// test/audit_p0_financial_test.dart
// note: Regression test suite for Phase 1 P0 financial-correctness bugs (A1–A6).

import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late AppProvider provider;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    db = AppDatabase(NativeDatabase.memory());
    AppDatabase.setInstanceForTesting(db);
    provider = AppProvider();
    await provider.load();
  });

  tearDown(() async {
    await db.close();
    AppDatabase.setInstanceForTesting(null);
  });

  group('A1 — Certificate monthly/yearly payouts & multi-cycle catch-up', () {
    test('nextCollectionDateAt returns today on due day across 00:01..23:59 for monthly and yearly', () {
      final monthlyCert = Certificate(
        id: 'cert-m',
        name: 'Monthly CD',
        amount: 120000,
        currency: 'EGP',
        startDate: DateTime(2026, 9, 30),
        endDate: DateTime(2027, 9, 30),
        interestRate: 24.0,
        collectionType: 'monthly',
        collectionDay: 30,
        accountId: 'acc-1',
      );

      for (final time in [
        DateTime(2026, 10, 30, 0, 1),
        DateTime(2026, 10, 30, 12, 30),
        DateTime(2026, 10, 30, 23, 59),
      ]) {
        final due = monthlyCert.nextCollectionDateAt(time);
        expect(due, DateTime(2026, 10, 30));
      }

      // Yearly certificate with collectionDay 30 (uncapped from 28)
      final yearlyCert = Certificate(
        id: 'cert-y',
        name: 'Yearly CD',
        amount: 100000,
        currency: 'EGP',
        startDate: DateTime(2025, 10, 30),
        endDate: DateTime(2028, 10, 30),
        interestRate: 20.0,
        collectionType: 'yearly',
        collectionDay: 30,
        accountId: 'acc-1',
      );

      for (final time in [
        DateTime(2026, 10, 30, 0, 1),
        DateTime(2026, 10, 30, 15, 45),
        DateTime(2026, 10, 30, 23, 59),
      ]) {
        final due = yearlyCert.nextCollectionDateAt(time);
        expect(due, DateTime(2026, 10, 30));
      }
    });

    test('Monthly certificate created 3 months ago collects 3 catch-up payouts on checkAndProcessCertificates', () async {
      final bank = Account(
        id: 'bank-egp',
        name: 'National Bank',
        type: 'bank',
        balance: 200000,
        colorValue: 0xFF1565C0,
        currency: 'EGP',
      );
      await provider.addAccount(bank);

      final now = DateTime.now();
      // Start 3 months ago so exactly 3 monthly cycles have elapsed by today
      final start = DateTime(now.year, now.month - 3, 1);
      final end = DateTime(now.year + 1, now.month, 1);

      final cert = Certificate(
        id: 'cert-catchup',
        name: '3-Month Starved CD',
        amount: 120000,
        currency: 'EGP',
        startDate: start,
        endDate: end,
        interestRate: 12.0, // 1,200 EGP/month
        collectionType: 'monthly',
        collectionDay: 1,
        accountId: bank.id,
      );

      await db.insertCertificate(cert);
      provider.certificates = await db.getCertificates();

      await provider.checkAndProcessCertificates();

      final yieldTxs = provider.transactions
          .where((t) =>
              t.certificateId == cert.id &&
              t.description.startsWith('Certificate Yield:'))
          .toList();
      expect(yieldTxs.length, 3);

      final updatedCert =
          provider.certificates.firstWhere((c) => c.id == cert.id);
      expect(updatedCert.totalCollectedAmount, closeTo(3600.0, 0.01));

      final updatedBank = provider.accountById(bank.id)!;
      expect(updatedBank.balance, closeTo(203600.0, 0.01));
    });
  });

  group('A2 & A2b — Loan settlement exact installment counting & delete un-settle', () {
    test('Loan settles only on final installment and un-settles when payment is deleted', () async {
      final bank = Account(
        id: 'bank-loan',
        name: 'Loan Bank',
        type: 'bank',
        balance: 5000,
        colorValue: 0xFF1565C0,
        currency: 'EGP',
      );
      await provider.addAccount(bank);

      final loan = Loan(
        id: 'loan-300',
        name: '3-Installment Loan',
        principal: 300,
        interestRate: 0,
        startDate: DateTime(2026, 1, 1),
        endDate: DateTime(2026, 4, 1),
        accountId: bank.id,
        currency: 'EGP',
      );
      await provider.addLoan(loan);

      // Installment 1 (100 / 300)
      await provider.payLoanInstallment(provider.loans.first);
      expect(provider.loans.first.isSettled, isFalse);

      // Installment 2 (200 / 300) — previously settled early due to double-count bug!
      await provider.payLoanInstallment(provider.loans.first);
      expect(provider.loans.first.isSettled, isFalse);

      // Installment 3 (300 / 300) — now settles
      await provider.payLoanInstallment(provider.loans.first);
      expect(provider.loans.first.isSettled, isTrue);

      // Delete the 3rd payment — must flip back to unsettled (A2b)
      final lastPayment = provider.loanPaymentsFor(loan.id).first;
      await provider.deleteLoanPayment(lastPayment.id);
      expect(provider.loans.first.isSettled, isFalse);
      expect(provider.accountById(bank.id)!.balance, closeTo(4800.0, 0.01));
    });
  });

  group('A3 — Empty transaction currency falls back to account currency', () {
    test('Transactions with empty currency on USD account convert at USD rate into EGP totals', () async {
      provider.settings.currency = 'EGP';
      provider.exchangeRates = {'EGP': 1.0, 'USD': 0.02}; // 1 USD = 50 EGP

      final egpBank = Account(
        id: 'acc-egp',
        name: 'EGP Bank',
        type: 'bank',
        balance: 10000,
        colorValue: 0xFF1565C0,
        currency: 'EGP',
      );
      final usdBank = Account(
        id: 'acc-usd',
        name: 'USD Bank',
        type: 'bank',
        balance: 1000,
        colorValue: 0xFF2E7D32,
        currency: 'USD',
      );
      await provider.addAccount(egpBank);
      await provider.addAccount(usdBank);

      final now = DateTime.now();
      final txDate = DateTime(now.year, now.month, 10);

      // Direct DB insert of legacy/empty-currency transactions
      final egpTx = AppTransaction(
        id: 'tx-egp',
        type: 'expense',
        amount: 500,
        description: 'Local Groceries',
        accountId: egpBank.id,
        categoryId: 'food',
        date: txDate,
        currency: '', // should resolve to EGP -> 500 EGP
      );
      final usdTx = AppTransaction(
        id: 'tx-usd',
        type: 'expense',
        amount: 10,
        description: 'Cloud Hosting',
        accountId: usdBank.id,
        categoryId: 'bills',
        date: txDate,
        currency: '', // should resolve to USD -> 10 * 50 = 500 EGP
      );
      provider.transactions = [egpTx, usdTx];

      expect(provider.txCurrency(egpTx), 'EGP');
      expect(provider.txCurrency(usdTx), 'USD');
      // 500 EGP + (10 USD * 50 EGP/USD) = 1000 EGP
      expect(provider.monthTotalExpense(now), closeTo(1000.0, 0.01));
      expect(provider.getWrappedData(now).totalOutflow, closeTo(1000.0, 0.01));
    });
  });

  group('A4 — Cross-currency debit card linked to parent bank account', () {
    test('Add, edit, and delete expense on USD debit card linked to EGP bank restores exact starting balance', () async {
      provider.settings.currency = 'EGP';
      provider.exchangeRates = {'EGP': 1.0, 'USD': 0.02}; // 1 USD = 50 EGP

      final egpBank = Account(
        id: 'bank-parent',
        name: 'EGP Checking',
        type: 'bank',
        balance: 10000.0,
        colorValue: 0xFF1565C0,
        currency: 'EGP',
      );
      final usdCard = Account(
        id: 'card-usd',
        name: 'USD Travel Debit',
        type: 'debit',
        balance: 0.0,
        linkedAccountId: egpBank.id,
        colorValue: 0xFF00897B,
        currency: 'USD',
      );
      await provider.addAccount(egpBank);
      await provider.addAccount(usdCard);

      // 1. Add 20 USD expense on debit card (should debit 1,000 EGP from parent bank)
      final tx = AppTransaction(
        id: 'tx-card-1',
        type: 'expense',
        amount: 20.0,
        description: 'Hotel Coffee',
        accountId: usdCard.id,
        categoryId: 'food',
        date: DateTime(2026, 10, 15),
        currency: '', // empty -> resolves to card's USD and normalizes on save
      );
      await provider.addTransaction(tx);
      expect(provider.accountById(egpBank.id)!.balance, closeTo(9000.0, 0.01));

      final stored = provider.transactions.firstWhere((t) => t.id == tx.id);
      expect(stored.accountId, egpBank.id);
      expect(stored.paidViaAccountId, usdCard.id);
      expect(stored.currency, 'USD');

      // 2. Edit from 20 USD -> 30 USD (should debit 1,500 EGP total -> balance 8,500 EGP)
      final edited1 = stored.copyWith(amount: 30.0);
      await provider.updateTransaction(edited1, stored);
      expect(provider.accountById(egpBank.id)!.balance, closeTo(8500.0, 0.01));

      // 3. Edit from 30 USD -> 10 USD (should debit 500 EGP total -> balance 9,500 EGP)
      final currentStored = provider.transactions.firstWhere((t) => t.id == tx.id);
      final edited2 = currentStored.copyWith(amount: 10.0);
      await provider.updateTransaction(edited2, currentStored);
      expect(provider.accountById(egpBank.id)!.balance, closeTo(9500.0, 0.01));

      // 4. Delete transaction -> parent bank balance returns to exact 10,000.0 EGP
      await provider.deleteTransaction(tx.id);
      expect(provider.accountById(egpBank.id)!.balance, closeTo(10000.0, 0.01));
    });
  });

  group('A5 — Cross-currency rate guard when exchangeRates is empty', () {
    test('Rejects cross-currency transaction and transfer when exchangeRates is empty, succeeds once loaded', () async {
      provider.settings.currency = 'EGP';
      provider.exchangeRates = {}; // Cold-start empty rates

      final egpBank = Account(
        id: 'b-egp',
        name: 'EGP Bank',
        type: 'bank',
        balance: 5000.0,
        colorValue: 0xFF1565C0,
        currency: 'EGP',
      );
      final usdBank = Account(
        id: 'b-usd',
        name: 'USD Bank',
        type: 'bank',
        balance: 100.0,
        colorValue: 0xFF2E7D32,
        currency: 'USD',
      );
      await provider.addAccount(egpBank);
      await provider.addAccount(usdBank);

      final crossTx = AppTransaction(
        id: 'tx-cross',
        type: 'expense',
        amount: 10.0,
        description: 'USD Subscription on EGP Account',
        accountId: egpBank.id,
        categoryId: 'bills',
        date: DateTime(2026, 10, 15),
        currency: 'USD',
      );

      await expectLater(
        provider.addTransaction(crossTx),
        throwsA(isA<RatesUnavailableException>()),
      );
      expect(provider.accountById(egpBank.id)!.balance, 5000.0);

      await expectLater(
        provider.addTransfer(
          fromId: usdBank.id,
          toId: egpBank.id,
          fromAmount: 10.0,
        ),
        throwsA(isA<RatesUnavailableException>()),
      );
      expect(provider.accountById(usdBank.id)!.balance, 100.0);
      expect(provider.accountById(egpBank.id)!.balance, 5000.0);

      // Now load rates and retry
      provider.exchangeRates = {'EGP': 1.0, 'USD': 0.02};
      await provider.addTransaction(crossTx);
      expect(provider.accountById(egpBank.id)!.balance, closeTo(4500.0, 0.01));
    });
  });

  group('A6 — Transfer deletion undo restores both legs and balances', () {
    test('deleteTransactionWithUndo snapshots and restores entire transferGroupId', () async {
      final accA = Account(
        id: 'acc-a',
        name: 'Account A',
        type: 'bank',
        balance: 1000.0,
        colorValue: 0xFF1565C0,
        currency: 'EGP',
      );
      final accB = Account(
        id: 'acc-b',
        name: 'Account B',
        type: 'bank',
        balance: 500.0,
        colorValue: 0xFF2E7D32,
        currency: 'EGP',
      );
      await provider.addAccount(accA);
      await provider.addAccount(accB);

      await provider.addTransfer(
        fromId: accA.id,
        toId: accB.id,
        fromAmount: 250.0,
        note: 'Savings move',
      );

      expect(provider.accountById(accA.id)!.balance, closeTo(750.0, 0.01));
      expect(provider.accountById(accB.id)!.balance, closeTo(750.0, 0.01));
      expect(provider.transactions.length, 2);
      final groupId = provider.transactions.first.transferGroupId;
      expect(groupId, isNotNull);

      // Delete one leg with undo
      final firstLegId = provider.transactions.first.id;
      final undo = await provider.deleteTransactionWithUndo(firstLegId);

      // Both legs deleted, balances restored to 1000 / 500
      expect(provider.transactions, isEmpty);
      expect(provider.accountById(accA.id)!.balance, closeTo(1000.0, 0.01));
      expect(provider.accountById(accB.id)!.balance, closeTo(500.0, 0.01));

      // Trigger undo -> both legs exist again with shared transferGroupId & 750 / 750 balances
      undo();
      // Wait for async undo mutation to complete
      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(provider.transactions.length, 2);
      expect(
        provider.transactions.every((t) => t.transferGroupId == groupId),
        isTrue,
      );
      expect(provider.accountById(accA.id)!.balance, closeTo(750.0, 0.01));
      expect(provider.accountById(accB.id)!.balance, closeTo(750.0, 0.01));
    });
  });
}
