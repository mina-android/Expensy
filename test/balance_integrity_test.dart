// test/balance_integrity_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late AppProvider provider;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    AppDatabase.setInstanceForTesting(db);
    provider = AppProvider();
  });

  tearDown(() async {
    await db.close();
    AppDatabase.setInstanceForTesting(null);
  });

  group('Total Balance Calculation Tests', () {
    test('totalBalance sums signed account balances (assets minus card debt)', () {
      final cash = Account(
        id: 'acc_cash',
        name: 'Cash',
        type: 'cash',
        balance: 1000.0,
        currency: 'USD',
        colorValue: 0xFF2E7D32,
      );
      final bank = Account(
        id: 'acc_bank',
        name: 'Checking',
        type: 'bank',
        balance: 500.0,
        currency: 'USD',
        colorValue: 0xFF1565C0,
      );
      final credit = Account(
        id: 'acc_credit',
        name: 'Credit Card',
        type: 'credit',
        balance: -300.0,
        currency: 'USD',
        colorValue: 0xFFC62828,
      );
      final savingsExcluded = Account(
        id: 'acc_excluded',
        name: 'Secret Stash',
        type: 'cash',
        balance: 2000.0,
        currency: 'USD',
        colorValue: 0xFF000000,
        excludeFromTotal: true,
      );

      provider.settings.currency = 'USD';
      provider.accounts = [cash, bank, credit, savingsExcluded];

      // Total balance excludes excluded accounts and sums signed: 1000 + 500 - 300 = 1200
      expect(provider.totalBalance, equals(1200.0));
      // Total balance all includes all accounts signed: 1000 + 500 - 300 + 2000 = 3200
      expect(provider.totalBalanceAll, equals(3200.0));
    });
  });

  group('Atomic Balance Mutation Tests', () {
    test('applyTransactionWithBalance updates balance atomically via relative SQL delta', () async {
      final acc = Account(
        id: 'acc_1',
        name: 'Wallet',
        type: 'cash',
        balance: 100.0,
        currency: 'USD',
        colorValue: 0xFF2E7D32,
      );
      await db.insertAccount(acc);

      final tx1 = AppTransaction(
        id: 'tx_1',
        type: 'expense',
        amount: 30.0,
        description: 'Groceries',
        accountId: 'acc_1',
        categoryId: 'food_exp',
        date: DateTime.now(),
        currency: 'USD',
      );

      await db.applyTransactionWithBalance(tx1, -30.0);

      final accountsAfter = await db.getAccounts();
      final updated = accountsAfter.firstWhere((a) => a.id == 'acc_1');
      expect(updated.balance, equals(70.0));

      final txs = await db.getTransactions();
      expect(txs.length, equals(1));
      expect(txs.first.id, equals('tx_1'));
    });

    test('Gold accounts are protected from direct balance mutations', () async {
      final goldAcc = Account(
        id: 'acc_gold',
        name: 'Gold Vault',
        type: 'gold',
        balance: 50.0,
        currency: 'USD',
        colorValue: 0xFFFFD700,
        goldGrams: 50.0,
      );
      await db.insertAccount(goldAcc);

      final tx = AppTransaction(
        id: 'tx_gold',
        type: 'income',
        amount: 100.0,
        description: 'Gold bonus',
        accountId: 'acc_gold',
        categoryId: 'salary',
        date: DateTime.now(),
        currency: 'USD',
      );

      await db.applyTransactionWithBalance(tx, 100.0);

      final accountsAfter = await db.getAccounts();
      final goldAfter = accountsAfter.firstWhere((a) => a.id == 'acc_gold');
      // Gold balance must remain unchanged
      expect(goldAfter.balance, equals(50.0));
    });

    test('applyTransferWithBalances atomically updates debit and credit balances', () async {
      final fromAcc = Account(
        id: 'from_1',
        name: 'Bank',
        type: 'bank',
        balance: 500.0,
        currency: 'USD',
        colorValue: 0xFF1565C0,
      );
      final toAcc = Account(
        id: 'to_1',
        name: 'Cash',
        type: 'cash',
        balance: 50.0,
        currency: 'USD',
        colorValue: 0xFF2E7D32,
      );
      await db.insertAccount(fromAcc);
      await db.insertAccount(toAcc);

      final debitTx = AppTransaction(
        id: 'tx_out',
        type: 'expense',
        amount: 100.0,
        description: 'Transfer out',
        accountId: 'from_1',
        categoryId: 'food_exp',
        date: DateTime.now(),
        currency: 'USD',
      );
      final creditTx = AppTransaction(
        id: 'tx_in',
        type: 'income',
        amount: 100.0,
        description: 'Transfer in',
        accountId: 'to_1',
        categoryId: 'food_exp',
        date: DateTime.now(),
        currency: 'USD',
      );

      await db.applyTransferWithBalances(debitTx, creditTx, -100.0, 100.0);

      final accounts = await db.getAccounts();
      final updatedFrom = accounts.firstWhere((a) => a.id == 'from_1');
      final updatedTo = accounts.firstWhere((a) => a.id == 'to_1');

      expect(updatedFrom.balance, equals(400.0));
      expect(updatedTo.balance, equals(150.0));
    });
  });

  group('Account Deletion & Lossless Undo Tests', () {
    test('getAccountDeletionBlockReason identifies active recurring and loans', () {
      final acc = Account(
        id: 'acc_target',
        name: 'Main Checking',
        type: 'bank',
        balance: 1000.0,
        currency: 'USD',
        colorValue: 0xFF1565C0,
      );
      provider.accounts = [acc];

      expect(provider.getAccountDeletionBlockReason('acc_target'), isNull);

      // Add a recurring payment pointing to this account
      provider.recurring = [
        RecurringPayment(
          id: 'rec_1',
          name: 'Gym',
          accountId: 'acc_target',
          categoryId: 'health',
          amount: 50.0,
          paymentType: 'expense',
          freqVal: 1,
          freqUnit: 'month',
          startDate: DateTime.now(),
          nextDate: DateTime.now(),
        ),
      ];

      expect(provider.getAccountDeletionBlockReason('acc_target'), isNotNull);
      expect(
        provider.getAccountDeletionBlockReason('acc_target'),
        contains('recurring payments'),
      );
    });

    test('deleteAccountCascade and restoreAccountSnapshot preserve full state on undo', () async {
      final acc = Account(
        id: 'acc_del',
        name: 'Savings',
        type: 'cash',
        balance: 500.0,
        currency: 'USD',
        colorValue: 0xFF2E7D32,
      );
      await db.insertAccount(acc);

      final tx = AppTransaction(
        id: 'tx_del',
        type: 'income',
        amount: 500.0,
        description: 'Deposit',
        accountId: 'acc_del',
        categoryId: 'salary',
        date: DateTime.now(),
        currency: 'USD',
      );
      await db.insertTransaction(tx);

      final split = TransactionSplit(
        id: 'sp_1',
        transactionId: 'tx_del',
        categoryId: 'salary',
        amount: 500.0,
      );
      await db.saveTransactionSplits('tx_del', [split]);

      // Verify inserted
      expect((await db.getAccounts()).length, equals(1));
      expect((await db.getTransactions()).length, equals(1));
      expect((await db.getAllSplits()).length, equals(1));

      // Cascade delete
      await db.deleteAccountCascade('acc_del');
      expect((await db.getAccounts()).isEmpty, isTrue);
      expect((await db.getTransactions()).isEmpty, isTrue);
      expect((await db.getAllSplits()).isEmpty, isTrue);

      // Restore snapshot (Undo)
      await db.restoreAccountSnapshot(acc, [tx], [split]);
      expect((await db.getAccounts()).length, equals(1));
      expect((await db.getTransactions()).length, equals(1));
      expect((await db.getAllSplits()).length, equals(1));

      final restoredAcc = (await db.getAccounts()).first;
      expect(restoredAcc.balance, equals(500.0));
      expect(restoredAcc.name, equals('Savings'));
    });
  });
}
