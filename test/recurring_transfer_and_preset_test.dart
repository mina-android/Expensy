import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/aggregations.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/services/backup_validator.dart';
import 'package:expensy/services/recurring_payment_processor.dart';
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

  Future<({Account fromAcc, Account toAcc})> seedAccounts() async {
    final fromAcc = Account(
      id: 'acc_from',
      name: 'Main Bank',
      type: 'bank',
      balance: 1000.0,
      currency: 'USD',
      colorValue: 0xFF1976D2,
      createdAt: DateTime(2026, 1, 1),
    );
    final toAcc = Account(
      id: 'acc_to',
      name: 'Savings Wallet',
      type: 'cash',
      balance: 200.0,
      currency: 'USD',
      colorValue: 0xFF388E3C,
      createdAt: DateTime(2026, 1, 1),
    );
    await provider.addAccount(fromAcc);
    await provider.addAccount(toAcc);
    return (fromAcc: fromAcc, toAcc: toAcc);
  }

  group('Recurring Transfers & Transfer Presets (v1.2.4)', () {
    test('Transfer Preset logs paired transfer legs, excludes from totals, and 1-tap undo reverses both', () async {
      await seedAccounts();

      final preset = TransactionPreset(
        id: 'preset_tr_1',
        title: 'Monthly Reserve',
        type: 'transfer',
        amount: 250.0,
        accountId: 'acc_from',
        toAccountId: 'acc_to',
        categoryId: 'sys_transfer',
        currency: 'USD',
        note: 'Auto-save',
        colorValue: 0xFF1976D2,
      );
      await provider.addPreset(preset);

      expect(provider.presets.length, 1);
      expect(provider.presets.first.isTransfer, isTrue);
      expect(provider.presets.first.toAccountId, 'acc_to');

      final outTx = await provider.logPreset(preset);
      expect(outTx.isTransfer, isTrue);
      expect(outTx.description, 'Monthly Reserve (Transfer out)');
      expect(provider.accountById('acc_from')!.balance, closeTo(750.0, 0.001));
      expect(provider.accountById('acc_to')!.balance, closeTo(450.0, 0.001));
      expect(provider.transactions.length, 2);

      // Excluded from income/expense aggregations
      final totals = FinancialAggregations.periodTotals(
        provider.transactions,
        convert: provider.convertToMain,
      );
      expect(totals.income, 0.0);
      expect(totals.expense, 0.0);

      // 1-tap Undo deletes both legs and restores balances
      await provider.deleteTransaction(outTx.id);
      expect(provider.transactions, isEmpty);
      expect(provider.accountById('acc_from')!.balance, closeTo(1000.0, 0.001));
      expect(provider.accountById('acc_to')!.balance, closeTo(200.0, 0.001));
    });

    test('Recurring Transfer manual pay, skip, and auto-pay processor work atomically', () async {
      await seedAccounts();

      final futureDue = DateTime.now().add(const Duration(days: 5));
      final rec = RecurringPayment(
        id: 'rec_tr_1',
        name: 'Rent Reserve',
        accountId: 'acc_from',
        toAccountId: 'acc_to',
        categoryId: 'sys_transfer',
        amount: 150.0,
        paymentType: 'transfer',
        freqVal: 1,
        freqUnit: 'months',
        startDate: DateTime(futureDue.year, futureDue.month, futureDue.day),
        nextDate: DateTime(futureDue.year, futureDue.month, futureDue.day),
        autoPayEnabled: true,
        autoPayTime: '00:00',
      );
      await provider.addRecurring(rec);
      expect(provider.recurring.first.isTransfer, isTrue);
      expect(provider.recurring.first.toAccountId, 'acc_to');

      // Manual pay
      await provider.markRecurringPaid(rec);
      expect(provider.accountById('acc_from')!.balance, closeTo(850.0, 0.001));
      expect(provider.accountById('acc_to')!.balance, closeTo(350.0, 0.001));
      expect(provider.recurring.first.paidPayments, 1);
      final afterPayNext = provider.recurring.first.nextDate;
      expect(afterPayNext.isAfter(rec.nextDate), isTrue);

      // Skip next
      await provider.skipNextRecurring(provider.recurring.first);
      expect(provider.recurring.first.nextDate.isAfter(afterPayNext), isTrue);
      expect(provider.accountById('acc_from')!.balance, closeTo(850.0, 0.001));

      // Auto-pay processor processes due recurring transfers
      final dueRec = provider.recurring.first.copyWith(
        nextDate: DateTime.now().subtract(const Duration(days: 1)),
      );
      // Reset nextDate to 2 days ago via DB directly (avoiding updateRecurring's auto-pay + yesterday's idempotency guard)
      await db.updateRecurring(dueRec.copyWith(
        nextDate: DateTime.now().subtract(const Duration(days: 2)),
      ));
      final processed = await RecurringPaymentProcessor(db).processDuePayments(
        defaultCurrency: provider.settings.currency,
      );
      expect(processed, contains('rec_tr_1'));
      await provider.load();
      expect(provider.accountById('acc_from')!.balance, closeTo(700.0, 0.001));
      expect(provider.accountById('acc_to')!.balance, closeTo(500.0, 0.001));
    });

    test('Account deletion is blocked when referenced as toAccountId', () async {
      await seedAccounts();

      await provider.addPreset(TransactionPreset(
        id: 'p_dest',
        title: 'Save',
        type: 'transfer',
        amount: 50,
        accountId: 'acc_from',
        toAccountId: 'acc_to',
        categoryId: 'sys_transfer',
        currency: 'USD',
        colorValue: 0xFF1976D2,
      ));
      expect(provider.getAccountDeletionBlockReason('acc_to'), isNotNull);

      await provider.deletePreset('p_dest');
      expect(provider.getAccountDeletionBlockReason('acc_to'), isNull);

      await provider.addRecurring(RecurringPayment(
        id: 'r_dest',
        name: 'Weekly Save',
        accountId: 'acc_from',
        toAccountId: 'acc_to',
        categoryId: 'sys_transfer',
        amount: 50,
        paymentType: 'transfer',
        freqVal: 1,
        freqUnit: 'weeks',
        startDate: DateTime(2026, 1, 1),
        nextDate: DateTime(2026, 1, 1),
      ));
      expect(provider.getAccountDeletionBlockReason('acc_to'), isNotNull);
    });

    test('BackupValidator detects orphan to_account_id on recurring_payments and transaction_presets', () {
      final badRecurring = {
        'version': 31,
        'accounts': [
          {'id': 'a1', 'name': 'Main', 'type': 'bank', 'balance': 100.0}
        ],
        'categories': [
          {'id': 'sys_transfer', 'name': 'Transfer', 'type': 'expense'}
        ],
        'recurring_payments': [
          {
            'id': 'r1',
            'name': 'Bad Transfer',
            'account_id': 'a1',
            'to_account_id': 'missing_acc',
            'category_id': 'sys_transfer',
            'amount': 10.0,
            'payment_type': 'transfer',
          }
        ],
      };
      final r1 = BackupValidator.validate(badRecurring);
      expect(r1.isValid, isTrue);
      expect(r1.warnings, isNotEmpty);

      final badPreset = {
        'version': 31,
        'accounts': [
          {'id': 'a1', 'name': 'Main', 'type': 'bank', 'balance': 100.0}
        ],
        'categories': [
          {'id': 'sys_transfer', 'name': 'Transfer', 'type': 'expense'}
        ],
        'transaction_presets': [
          {
            'id': 'p1',
            'title': 'Bad Preset',
            'type': 'transfer',
            'amount': 10.0,
            'account_id': 'a1',
            'to_account_id': 'missing_acc',
            'category_id': 'sys_transfer',
          }
        ],
      };
      final r2 = BackupValidator.validate(badPreset);
      expect(r2.isValid, isTrue);
      expect(r2.warnings, isNotEmpty);
    });

    test('O(1) accountById and categoryById maps stay coherent across mutations', () async {
      await seedAccounts();
      expect(provider.accountById('acc_from')?.name, 'Main Bank');

      final updated = provider.accountById('acc_from')!.copyWith(name: 'Renamed Bank');
      await provider.updateAccount(updated);
      expect(provider.accountById('acc_from')?.name, 'Renamed Bank');

      await provider.deleteAccount('acc_to');
      expect(provider.accountById('acc_to'), isNull);
    });

    test('transferableAccounts excludes cards and gold while keeping bank and cash accounts', () async {
      await seedAccounts();
      await provider.addAccount(Account(
        id: 'card_debit',
        name: 'Debit Card',
        type: 'debit',
        balance: 0,
        currency: 'USD',
        colorValue: 0xFF000000,
        linkedAccountId: 'acc_from',
        createdAt: DateTime(2026, 1, 1),
      ));
      await provider.addAccount(Account(
        id: 'card_credit',
        name: 'Credit Card',
        type: 'credit',
        balance: -100,
        currency: 'USD',
        colorValue: 0xFF000000,
        createdAt: DateTime(2026, 1, 1),
      ));
      await provider.addAccount(Account(
        id: 'acc_gold',
        name: 'Gold',
        type: 'gold',
        balance: 0,
        currency: 'USD',
        colorValue: 0xFFFFD700,
        createdAt: DateTime(2026, 1, 1),
      ));

      final ids = provider.transferableAccounts.map((a) => a.id).toSet();
      expect(ids, containsAll(['acc_from', 'acc_to']));
      expect(ids.contains('card_debit'), isFalse);
      expect(ids.contains('card_credit'), isFalse);
      expect(ids.contains('acc_gold'), isFalse);
    });
  });
}
