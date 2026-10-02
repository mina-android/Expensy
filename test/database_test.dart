import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';

void main() {
  late AppDatabase db;

  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('AppDatabase Drift In-Memory Tests', () {
    test('Database initializes and default categories are seeded', () async {
      final categories = await db.getCategories();
      expect(categories.isNotEmpty, isTrue);
      expect(categories.any((c) => c.name == 'Food & Dining'), isTrue);
      expect(categories.any((c) => c.name == 'Salary'), isTrue);
    });

    test('Account CRUD operations work correctly', () async {
      final account = Account(
        id: 'acc_test_1',
        name: 'Test Bank',
        type: 'bank',
        balance: 1500.0,
        currency: 'USD',
        colorValue: 0xFF2196F3,
        dontLinkToCard: true,
      );

      await db.insertAccount(account);

      var accounts = await db.getAccounts();
      expect(accounts.any((a) => a.id == 'acc_test_1' && a.name == 'Test Bank'), isTrue);
      expect(accounts.firstWhere((a) => a.id == 'acc_test_1').dontLinkToCard, isTrue);

      final updatedAccount = account.copyWith(
        name: 'Updated Bank',
        balance: 2000.0,
        dontLinkToCard: false,
      );
      await db.updateAccount(updatedAccount);

      accounts = await db.getAccounts();
      final retrieved = accounts.firstWhere((a) => a.id == 'acc_test_1');
      expect(retrieved.balance, 2000.0);
      expect(retrieved.name, 'Updated Bank');
      expect(retrieved.dontLinkToCard, isFalse);

      await db.deleteAccount('acc_test_1');
      accounts = await db.getAccounts();
      expect(accounts.any((a) => a.id == 'acc_test_1'), isFalse);
    });

    test('Transaction CRUD operations work correctly', () async {
      final account = Account(
        id: 'acc_wallet',
        name: 'Wallet',
        type: 'cash',
        balance: 100.0,
        currency: 'USD',
        colorValue: 0xFF4CAF50,
      );
      await db.insertAccount(account);

      final categories = await db.getCategories();
      final cat = categories.first;

      final tx = AppTransaction(
        id: 'tx_test_1',
        type: 'expense',
        amount: 25.0,
        description: 'Coffee',
        accountId: account.id,
        categoryId: cat.id,
        date: DateTime.now(),
        note: 'Coffee & Snack',
      );

      await db.insertTransaction(tx);

      final txList = await db.getTransactions();
      expect(txList.any((t) => t.id == 'tx_test_1'), isTrue);

      await db.deleteTransaction('tx_test_1');
      final txListAfterDelete = await db.getTransactions();
      expect(txListAfterDelete.any((t) => t.id == 'tx_test_1'), isFalse);
    });

    test('Transaction presets CRUD operations work correctly', () async {
      final preset = TransactionPreset(
        id: 'preset_1',
        title: 'Morning Latte',
        type: 'expense',
        amount: 4.5,
        accountId: 'acc_wallet',
        categoryId: 'food_exp',
        colorValue: 0xFF4CAF50,
      );

      await db.insertPreset(preset);
      var presets = await db.getPresets();
      expect(presets.any((p) => p.id == 'preset_1' && p.title == 'Morning Latte'), isTrue);

      final updated = preset.copyWith(title: 'Special Latte', amount: 5.0);
      await db.updatePreset(updated);
      presets = await db.getPresets();
      expect(presets.firstWhere((p) => p.id == 'preset_1').title, 'Special Latte');
      expect(presets.firstWhere((p) => p.id == 'preset_1').amount, 5.0);

      await db.deletePreset('preset_1');
      presets = await db.getPresets();
      expect(presets.any((p) => p.id == 'preset_1'), isFalse);
    });

    test('Transaction splits save, retrieve and cascade delete', () async {
      const txId = 'tx_split_1';
      final splits = [
        const TransactionSplit(id: 's1', transactionId: txId, categoryId: 'food_exp', amount: 30.0, note: 'Dinner'),
        const TransactionSplit(id: 's2', transactionId: txId, categoryId: 'entertainment', amount: 20.0, note: 'Movie'),
      ];

      await db.saveTransactionSplits(txId, splits);
      final retrieved = await db.getSplitsForTransaction(txId);
      expect(retrieved.length, 2);
      expect(retrieved[0].amount + retrieved[1].amount, 50.0);

      await db.deleteSplitsForTransaction(txId);
      final afterDelete = await db.getSplitsForTransaction(txId);
      expect(afterDelete.isEmpty, isTrue);
    });

    test('JSON export and import integrity test', () async {
      final account = Account(
        id: 'acc_savings',
        name: 'Savings',
        type: 'savings',
        balance: 5000.0,
        currency: 'USD',
        colorValue: 0xFFFF9800,
      );
      await db.insertAccount(account);

      final exported = await db.exportAll();
      expect(exported.containsKey('accounts'), isTrue);
      expect(exported.containsKey('transaction_presets'), isTrue);
      expect(exported.containsKey('transaction_splits'), isTrue);
      expect(exported['accounts'] is List, isTrue);

      // Create a new database and import
      final newDb = AppDatabase(NativeDatabase.memory());
      await newDb.importAll(exported);

      final importedAccounts = await newDb.getAccounts();
      expect(importedAccounts.any((a) => a.id == 'acc_savings'), isTrue);
      await newDb.close();
    });
  });
}
