import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:drift/native.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late AppProvider provider;

  const dir = r'C:\Users\minaa\.gemini\antigravity\brain\a03e3698-f091-44c5-946b-cc31d9e14aa9\scratch\uploaded_backup';

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    db = AppDatabase(NativeDatabase.memory());
    AppDatabase.setInstanceForTesting(db);
    provider = AppProvider();
  });

  tearDown(() async {
    await db.close();
    AppDatabase.setInstanceForTesting(null);
  });

  group('Transactions and Transfers Relogic', () {
    test('Card displays linked bank account balance and pay deducts from bank', () async {
      final bank = Account(
        id: 'bank_cib',
        name: 'CIB Current',
        type: 'bank',
        currency: 'EGP',
        balance: 10000.0,
        colorValue: 0xFF123456,
      );
      await db.insertAccount(bank);

      final debitCard = Account(
        id: 'card_debit',
        name: 'CIB Titanium Debit',
        type: 'debit',
        currency: 'EGP',
        balance: 0.0,
        colorValue: 0xFF654321,
        linkedAccountId: 'bank_cib',
      );
      await db.insertAccount(debitCard);

      final foodCat = AppCategory(
        id: 'cat_food',
        name: 'Dining',
        type: 'expense',
        colorValue: 0xFF334455,
      );
      await db.insertCategory(foodCat);

      await provider.load();

      // Card must reflect effective balance from parent bank account
      final effectiveBal = provider.getEffectiveBalance(debitCard);
      expect(effectiveBal, 10000.0);

      // Paying with debit card
      final tx = AppTransaction(
        id: 'tx_dinner',
        type: 'expense',
        amount: 850.0,
        description: 'Dinner with friends',
        accountId: 'card_debit',
        categoryId: 'cat_food',
        date: DateTime.now(),
      );

      await provider.addTransaction(tx);

      // Bank account balance is updated
      final updatedBank = provider.accountById('bank_cib');
      expect(updatedBank?.balance, 9150.0);
      expect(provider.getEffectiveBalance(debitCard), 9150.0);
    });

    test('Transfers show accounts only and not cards', () async {
      final bank = Account(
        id: 'bank_cib',
        name: 'CIB Bank',
        type: 'bank',
        currency: 'EGP',
        balance: 5000.0,
        colorValue: 0xFF111111,
      );
      final cash = Account(
        id: 'cash_wallet',
        name: 'Cash',
        type: 'cash',
        currency: 'EGP',
        balance: 1000.0,
        colorValue: 0xFF222222,
      );
      final debitCard = Account(
        id: 'debit_card',
        name: 'Debit Card',
        type: 'debit',
        currency: 'EGP',
        balance: 0.0,
        colorValue: 0xFF333333,
        linkedAccountId: 'bank_cib',
      );
      final creditCard = Account(
        id: 'credit_card',
        name: 'Credit Card',
        type: 'credit',
        currency: 'EGP',
        balance: 0.0,
        colorValue: 0xFF444444,
      );

      await db.insertAccount(bank);
      await db.insertAccount(cash);
      await db.insertAccount(debitCard);
      await db.insertAccount(creditCard);
      await provider.load();

      final transferable = provider.accounts.where((a) => !a.isCard && !a.isGold).toList();
      expect(transferable.any((a) => a.id == 'bank_cib'), isTrue);
      expect(transferable.any((a) => a.id == 'cash_wallet'), isTrue);
      expect(transferable.any((a) => a.id == 'debit_card'), isFalse);
      expect(transferable.any((a) => a.id == 'credit_card'), isFalse);
    });
  });

  group('Uploaded User Backup Files Restore', () {
    test('Restore expensy_backup_20261023_102358.json successfully', () async {
      final file = File('$dir\\expensy_backup_20261023_102358.json');
      final jsonStr = await file.readAsString();
      final data = jsonDecode(jsonStr) as Map<String, dynamic>;

      final ver = await provider.restoreBackupData(data);
      expect(ver, 27);
      expect(provider.accounts.length, 8);
      expect(provider.transactions.length, 108);
      expect(provider.categories.where((c) => !c.id.startsWith('sys_')).length, 11);
    });

    test('Restore expensy_auto_20261023_064842.json successfully', () async {
      final file = File('$dir\\expensy_auto_20261023_064842.json');
      final jsonStr = await file.readAsString();
      final data = jsonDecode(jsonStr) as Map<String, dynamic>;

      final ver = await provider.restoreBackupData(data);
      expect(ver, 27);
      expect(provider.accounts.length, 7);
      expect(provider.transactions.length, 104);
    });

    test('Restore expensy_selective_backup_20261023_102332.json successfully', () async {
      final file = File('$dir\\expensy_selective_backup_20261023_102332.json');
      final jsonStr = await file.readAsString();
      final data = jsonDecode(jsonStr) as Map<String, dynamic>;

      final selectedGroups = {'accounts', 'categories', 'recurring', 'assets'};
      await provider.restoreSelective(data, selectedGroups);
      expect(provider.accounts.length, 8);
      expect(provider.categories.where((c) => !c.id.startsWith('sys_')).length, 11);
      expect(provider.recurring.length, 14);
      expect(provider.assets.length, 6);
    });
  });
}
