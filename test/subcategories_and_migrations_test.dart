// test/subcategories_and_migrations_test.dart
import 'dart:io';
import 'package:drift/drift.dart' show Variable;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/aggregations.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/theme/app_theme.dart';
import 'helpers/data_check_service.dart';

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

  group('Subcategories & Roll-up (#26)', () {
    test('seedDefaultSubcategories adds curated subcategories idempotently', () async {
      final initialSubs = provider.categories.where((c) => c.isSubcategory).length;
      expect(initialSubs, 0);

      final added = await provider.seedDefaultSubcategories();
      expect(added, greaterThan(15));
      expect(provider.subcategoriesOf('food_exp').length, 4);

      // Second call must be idempotent (0 added).
      final addedAgain = await provider.seedDefaultSubcategories();
      expect(addedAgain, 0);
    });

    test('Parent budgets, aggregations, and Wrapped roll up subcategory & split spend without double-counting', () async {
      await provider.addAccount(Account(
        id: 'acc_1',
        name: 'Cash',
        type: 'cash',
        currency: 'USD',
        balance: 1000,
        colorValue: 0xFF1565C0,
      ));
      await provider.addCategory(AppCategory(
        id: 'sub_groceries',
        name: 'Groceries',
        type: 'expense',
        colorValue: 0xFFE65100,
        parentId: 'food_exp',
      ));
      await provider.addCategory(AppCategory(
        id: 'sub_delivery',
        name: 'Delivery',
        type: 'expense',
        colorValue: 0xFFE65100,
        parentId: 'food_exp',
      ));

      final now = DateTime.now();
      // 1. Direct subcategory transaction: $120 on Groceries
      await provider.addTransaction(AppTransaction(
        id: 'tx_1',
        type: 'expense',
        amount: 120,
        description: 'Supermarket',
        accountId: 'acc_1',
        categoryId: 'sub_groceries',
        date: now,
      ));
      // 2. Split transaction: $80 on Delivery + $50 on Transport
      await provider.addTransaction(
        AppTransaction(
          id: 'tx_2',
          type: 'expense',
          amount: 130,
          description: 'Evening out',
          accountId: 'acc_1',
          categoryId: 'sub_delivery',
          date: now,
        ),
        splits: [
          TransactionSplit(
            id: 'sp_1',
            transactionId: 'tx_2',
            categoryId: 'sub_delivery',
            amount: 80,
          ),
          TransactionSplit(
            id: 'sp_2',
            transactionId: 'tx_2',
            categoryId: 'transport',
            amount: 50,
          ),
        ],
      );

      // Aggregation rolled up to root parent category
      final rolledUp = FinancialAggregations.categoryTotals(
        provider.transactions,
        resolveCategoryBucket: provider.rootCategoryIdOf,
        getSplits: (id) =>
            provider.isTransactionSplit(id) ? provider.getSplits(id) : const [],
      );
      expect(rolledUp['food_exp'], closeTo(200.0, 0.01));
      expect(rolledUp['transport'], closeTo(50.0, 0.01));

      // Parent budget + child budget: no double-count in nonOverlappingBudgets
      final parentBudget = Budget(
        id: 'b_food',
        categoryId: 'food_exp',
        amount: 500,
        period: 'monthly',
        createdAt: DateTime(now.year, now.month, 1),
      );
      final childBudget = Budget(
        id: 'b_groc',
        categoryId: 'sub_groceries',
        amount: 200,
        period: 'monthly',
        createdAt: DateTime(now.year, now.month, 1),
      );
      await provider.addBudget(parentBudget);
      await provider.addBudget(childBudget);

      expect(provider.budgetSpent(parentBudget), closeTo(200.0, 0.01));
      expect(provider.budgetSpent(childBudget), closeTo(120.0, 0.01));
      expect(provider.nonOverlappingBudgets.map((b) => b.id).toList(), ['b_food']);

      // Wrapped rolls up top category to Food & Dining
      final wrapped = provider.getWrappedData(DateTime(now.year, now.month));
      expect(wrapped.topCategoryId, 'food_exp');
      expect(wrapped.topCategoryAmount, closeTo(200.0, 0.01));

      // Display name helper
      expect(provider.categoryDisplayName('sub_groceries'), 'Food & Dining › Groceries');
    });

    test('Deleting a parent category promotes its subcategories, and undo restores the link', () async {
      await provider.addCategory(AppCategory(
        id: 'sub_test',
        name: 'Snacks',
        type: 'expense',
        colorValue: 0xFFE65100,
        parentId: 'food_exp',
      ));
      expect(provider.categoryById('sub_test')?.parentId, 'food_exp');

      final undo = await provider.deleteCategoryWithUndo('food_exp');
      expect(provider.categoryById('food_exp'), isNull);
      expect(provider.categoryById('sub_test')?.parentId, isNull);

      undo();
      expect(provider.categoryById('food_exp'), isNotNull);
      expect(provider.categoryById('sub_test')?.parentId, 'food_exp');
    });
  });

  group('Transfer Category Enforcement & Self-Heal', () {
    test('addTransfer and updateTransaction enforce sys_transfer and preserve transferGroupId', () async {
      await provider.addAccount(Account(
        id: 'acc_a',
        name: 'Bank',
        type: 'bank',
        currency: 'USD',
        balance: 500,
        colorValue: 0xFF1565C0,
      ));
      await provider.addAccount(Account(
        id: 'acc_b',
        name: 'Wallet',
        type: 'wallet',
        currency: 'USD',
        balance: 100,
        colorValue: 0xFF2E7D32,
      ));

      await provider.addTransfer(
        fromId: 'acc_a',
        toId: 'acc_b',
        fromAmount: 150,
        note: 'Top up wallet',
      );

      final transferTxs =
          provider.transactions.where((t) => t.isTransfer).toList();
      expect(transferTxs.length, 2);
      expect(transferTxs.every((t) => t.categoryId == 'sys_transfer'), isTrue);

      // Even if a caller attempts updateTransaction with categoryId='transport'
      // and transferGroupId=null, AppProvider enforces sys_transfer + groupId.
      final orig = transferTxs.first;
      final attemptedCorrupt = AppTransaction(
        id: orig.id,
        type: orig.type,
        amount: orig.amount,
        description: orig.description,
        accountId: orig.accountId,
        categoryId: 'transport',
        date: orig.date,
        note: 'Edited note',
        currency: orig.currency,
      );
      await provider.updateTransaction(attemptedCorrupt, orig);

      final after = provider.transactions.firstWhere((t) => t.id == orig.id);
      expect(after.categoryId, 'sys_transfer');
      expect(after.transferGroupId, orig.transferGroupId);
      expect(after.isTransfer, isTrue);

      // Must be excluded from expense/income totals
      final totals = FinancialAggregations.periodTotals(provider.transactions);
      expect(totals.expense, 0);
      expect(totals.income, 0);
    });

    test('runDataMigrationDataFixes repairs corrupted transfer rows back to sys_transfer', () async {
      await db.insertAccount(Account(
        id: 'acc_1',
        name: 'Bank',
        type: 'bank',
        currency: 'USD',
        balance: 500,
        colorValue: 0xFF1565C0,
      ));
      await db.insertTransaction(AppTransaction(
        id: 'corrupt_tr',
        type: 'expense',
        amount: 200,
        description: 'Transfer out',
        accountId: 'acc_1',
        categoryId: 'transport',
        date: DateTime.now(),
      ));

      await db.runDataMigrationDataFixes();
      await provider.load();

      final repaired = provider.transactions.firstWhere((t) => t.id == 'corrupt_tr');
      expect(repaired.categoryId, 'sys_transfer');
      expect(repaired.transferGroupId, isNotNull);
      expect(repaired.isTransfer, isTrue);

      final health = await DataCheckService(db).runCheck();
      expect(health.issues.where((i) => i.code == 'TRANSFER_CAT'), isEmpty);
    });
  });

  group('TrackWallet CSV Migration (#27)', () {
    test('restoreTrackWallet imports accounts, parent categories, subcategories, and transfers cleanly', () async {
      const sampleCsv = '''Date,Transaction,Account,Currency,Amount,Amount_INR,Category,Subcategory,Note
"2026-11-10T16:21:27.558","Expense","Slice","INR","-600","-600","Food","Groceries","Weekly veggies"
"2026-11-09T23:00:02.822","Expense","Slice","INR","-80","-80","Food","Snack",""
"2026-11-08T13:05:18.147","Expense","Slice","INR","-80","-80","Miscellaneous","",""
"2026-11-07T09:00:00.000","Income","Main Bank","INR","5000","5000","Salary","","Monthly pay"
"2026-11-06T12:00:00.000","Transfer","Main Bank","INR","-1000","-1000","","","Transfer to Slice"
"2026-11-06T12:00:00.000","Transfer","Slice","INR","1000","1000","","","Transfer to Slice"
"2026-11-05T10:00:00.000","Transfer","Slice","INR","250","250","","","Single-leg transfer"
''';

      final count = await provider.restoreTrackWallet(sampleCsv);
      expect(count, 7);

      expect(provider.accounts.any((a) => a.name == 'Slice'), isTrue);
      expect(provider.accounts.any((a) => a.name == 'Main Bank'), isTrue);

      final slice = provider.accounts.firstWhere((a) => a.name == 'Slice');
      final mainBank = provider.accounts.firstWhere((a) => a.name == 'Main Bank');
      expect(slice.balance, closeTo(-600 - 80 - 80 + 1000 + 250, 0.01));
      expect(mainBank.balance, closeTo(5000 - 1000, 0.01));

      // Subcategories created under matched Food & Dining parent
      final groceriesSub = provider.categories
          .where((c) => c.name == 'Groceries' && c.parentId == 'food_exp')
          .firstOrNull;
      expect(groceriesSub, isNotNull);

      // All 3 transfer legs use sys_transfer and are excluded from expense/income totals
      final transfers = provider.transactions.where((t) => t.isTransfer).toList();
      expect(transfers.length, 3);
      expect(transfers.every((t) => t.categoryId == 'sys_transfer'), isTrue);

      final totals = FinancialAggregations.periodTotals(provider.transactions);
      expect(totals.expense, closeTo(760.0, 0.01));
      expect(totals.income, closeTo(5000.0, 0.01));
    });

    test('restoreTrackWallet handles full 1,620-row sanitised TrackWallet CSV if present', () async {
      final scratchFile = File(
        r'C:\Users\minaa\.gemini\antigravity\brain\8ff2dd74-d15f-484a-b10c-c4d428595b99\scratch\trackwallet_sanitised.csv',
      );
      if (!scratchFile.existsSync()) return;

      final count = await provider.restoreTrackWallet(await scratchFile.readAsString());
      expect(count, 1620);
      expect(provider.transactions.where((t) => t.isTransfer).length, 48);
      expect(provider.transactions.where((t) => !t.isTransfer && t.type == 'expense').length, 1571);
      expect(provider.transactions.where((t) => !t.isTransfer && t.type == 'income').length, 1);
    });
  });

  group('Chart Color Resolution (#24)', () {
    test('resolveCategoryChartColors preserves distinct colors and separates collisions', () {
      final cs = ColorScheme.fromSeed(
        seedColor: const Color(0xFF6750A4),
        brightness: Brightness.dark,
      );
      final colors = resolveCategoryChartColors(
        [0xFFE65100, 0xFFE65100, 0xFF1565C0],
        cs,
      );
      expect(colors.length, 3);
      expect(colors[0], isNot(equals(colors[1])));
      expect(colors[1], isNot(equals(colors[2])));
    });
  });

  group('Recurring Installment Skip Progress', () {
    test('skipNextRecurring advances paidPayments and runDataMigrationDataFixes syncs from history', () async {
      await provider.addAccount(Account(
        id: 'acc_r',
        name: 'Bank',
        type: 'bank',
        currency: 'USD',
        balance: 1000,
        colorValue: 0xFF1565C0,
      ));
      final start = DateTime(2026, 1, 1);
      final rec = RecurringPayment(
        id: 'rec_1',
        name: 'Phone Installment',
        accountId: 'acc_r',
        categoryId: 'shopping',
        amount: 100,
        freqVal: 1,
        freqUnit: 'months',
        startDate: start,
        nextDate: DateTime(2026, 2, 1),
        endDate: DateTime(2026, 12, 1),
        recurringType: 'installment',
        paidPayments: 0,
      );
      await provider.addRecurring(rec);

      await provider.skipNextRecurring(rec);
      final afterSkip = provider.recurring.firstWhere((r) => r.id == 'rec_1');
      expect(afterSkip.paidPayments, 1);

      // Simulate legacy row where paid_payments was 0 despite 1 paid + 1 skipped in history
      await db.customUpdate(
        'UPDATE recurring_payments SET paid_payments = 0 WHERE id = ?',
        variables: [Variable<String>('rec_1')],
      );
      await db.insertRecurringHistory(RecurringHistoryEntry(
        id: 'rh_extra',
        recurringId: 'rec_1',
        action: 'paid',
        date: DateTime(2026, 1, 1),
        amount: 100,
        currency: 'USD',
      ));

      await db.runDataMigrationDataFixes();
      await provider.load();

      final synced = provider.recurring.firstWhere((r) => r.id == 'rec_1');
      expect(synced.paidPayments, 2);

      final health = await DataCheckService(db).runCheck();
      expect(health.issues.where((i) => i.code == 'COUNTER_DRIFT'), isEmpty);
    });
  });
}
