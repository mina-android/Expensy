// test/rollover_budget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/screens/budget_screen.dart';
import 'package:expensy/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    AppDatabase.setInstanceForTesting(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Rollover Budget Calculation Engine Tests', () {
    test('Calculates positive rollover (surplus) from previous month', () {
      final app = AppProvider();
      final now = DateTime(2026, 9, 15);
      final lastMonth = DateTime(2026, 8, 10);

      final cat = AppCategory(
        id: 'cat_food',
        name: 'Food & Dining',
        type: 'expense',
        colorValue: 0xFFE65100,
      );
      final acc = Account(
        id: 'acc1',
        name: 'Main Bank',
        type: 'bank',
        balance: 1000.0,
        currency: 'USD',
        colorValue: 0xFF1E88E5,
      );

      final budget = Budget(
        id: 'b1',
        categoryId: 'cat_food',
        amount: 300.0,
        period: 'monthly',
        createdAt: DateTime(2026, 7, 1),
        allowRollover: true,
      );

      // Previous month transactions: spent 240 out of 300 -> 60 surplus
      final txPrev1 = AppTransaction(
        id: 'tx1',
        type: 'expense',
        amount: 140.0,
        description: 'Groceries',
        accountId: 'acc1',
        categoryId: 'cat_food',
        date: lastMonth,
        currency: 'USD',
      );
      final txPrev2 = AppTransaction(
        id: 'tx2',
        type: 'expense',
        amount: 100.0,
        description: 'Dinner',
        accountId: 'acc1',
        categoryId: 'cat_food',
        date: lastMonth.add(const Duration(days: 2)),
        currency: 'USD',
      );

      // Current month transactions: spent 50
      final txCurr = AppTransaction(
        id: 'tx3',
        type: 'expense',
        amount: 50.0,
        description: 'Coffee',
        accountId: 'acc1',
        categoryId: 'cat_food',
        date: now,
        currency: 'USD',
      );

      app.categories = [cat];
      app.accounts = [acc];
      app.budgets = [budget];
      app.transactions = [txPrev1, txPrev2, txCurr];

      final rollover = app.budgetRollover(budget, now);
      expect(rollover, 60.0);

      final allowance = app.budgetEffectiveAllowance(budget, now);
      expect(allowance, 360.0); // 300 base + 60 rollover

      final spent = app.budgetSpent(budget, now);
      expect(spent, 50.0);
      expect(allowance - spent, 310.0);
      expect(app.budgetExceeded(budget), false);
    });

    test('Calculates negative rollover (deficit/overspending) from previous month', () {
      final app = AppProvider();
      final now = DateTime(2026, 9, 15);
      final lastMonth = DateTime(2026, 8, 10);

      final cat = AppCategory(
        id: 'cat_dining',
        name: 'Dining',
        type: 'expense',
        colorValue: 0xFFE65100,
      );
      final acc = Account(
        id: 'acc1',
        name: 'Main Bank',
        type: 'bank',
        balance: 1000.0,
        currency: 'USD',
        colorValue: 0xFF1E88E5,
      );

      final budget = Budget(
        id: 'b2',
        categoryId: 'cat_dining',
        amount: 200.0,
        period: 'monthly',
        createdAt: DateTime(2026, 6, 1),
        allowRollover: true,
      );

      // Previous month transactions: spent 240 out of 200 -> -40 deficit
      final txPrev = AppTransaction(
        id: 'tx_prev',
        type: 'expense',
        amount: 240.0,
        description: 'Party dinner',
        accountId: 'acc1',
        categoryId: 'cat_dining',
        date: lastMonth,
        currency: 'USD',
      );

      app.categories = [cat];
      app.accounts = [acc];
      app.budgets = [budget];
      app.transactions = [txPrev];

      final rollover = app.budgetRollover(budget, now);
      expect(rollover, -40.0);

      final allowance = app.budgetEffectiveAllowance(budget, now);
      expect(allowance, 160.0); // 200 base - 40 deficit
    });

    test('Returns 0.0 rollover and base allowance when allowRollover is false', () {
      final app = AppProvider();
      final now = DateTime(2026, 9, 15);
      final lastMonth = DateTime(2026, 8, 10);

      final budget = Budget(
        id: 'b3',
        categoryId: 'cat_fixed',
        amount: 500.0,
        period: 'monthly',
        createdAt: DateTime(2026, 6, 1),
        allowRollover: false, // disabled
      );

      // Previous month spent only 100 out of 500
      final txPrev = AppTransaction(
        id: 'tx_fixed',
        type: 'expense',
        amount: 100.0,
        description: 'Bills',
        accountId: 'acc1',
        categoryId: 'cat_fixed',
        date: lastMonth,
        currency: 'USD',
      );

      app.budgets = [budget];
      app.transactions = [txPrev];

      expect(app.budgetRollover(budget, now), 0.0);
      expect(app.budgetEffectiveAllowance(budget, now), 500.0);
    });

    test('Clamps effective allowance to 0 when overspending exceeds base budget', () {
      final app = AppProvider();
      final now = DateTime(2026, 9, 15);
      final lastMonth = DateTime(2026, 8, 10);

      final budget = Budget(
        id: 'b4',
        categoryId: 'cat_trip',
        amount: 100.0,
        period: 'monthly',
        createdAt: DateTime(2026, 6, 1),
        allowRollover: true,
      );

      // Previous month spent 300 out of 100 -> -200 deficit
      final txPrev = AppTransaction(
        id: 'tx_trip',
        type: 'expense',
        amount: 300.0,
        description: 'Flight',
        accountId: 'acc1',
        categoryId: 'cat_trip',
        date: lastMonth,
        currency: 'USD',
      );

      app.budgets = [budget];
      app.transactions = [txPrev];

      final rollover = app.budgetRollover(budget, now);
      expect(rollover, -200.0);

      final allowance = app.budgetEffectiveAllowance(budget, now);
      expect(allowance, 0.0); // Clamped at 0
    });

    test('Weekly period computes rollover from previous week correctly', () {
      final app = AppProvider();
      // Monday Sep 14, 2026
      final monday = DateTime(2026, 9, 14, 10);
      final lastWeek = DateTime(2026, 9, 9, 10);

      final budget = Budget(
        id: 'b_week',
        categoryId: 'cat_snack',
        amount: 70.0,
        period: 'weekly',
        createdAt: DateTime(2026, 8, 1),
        allowRollover: true,
      );

      // Last week spent 45 out of 70 -> 25 surplus
      final txLastWeek = AppTransaction(
        id: 'tx_w',
        type: 'expense',
        amount: 45.0,
        description: 'Snacks',
        accountId: 'acc1',
        categoryId: 'cat_snack',
        date: lastWeek,
        currency: 'USD',
      );

      app.budgets = [budget];
      app.transactions = [txLastWeek];

      final rollover = app.budgetRollover(budget, monday);
      expect(rollover, 25.0);

      final allowance = app.budgetEffectiveAllowance(budget, monday);
      expect(allowance, 95.0);
    });

    test('Fresh budget created in current month with no prior history has 0 rollover', () {
      final app = AppProvider();
      final now = DateTime(2026, 9, 15);

      final budget = Budget(
        id: 'b_new',
        categoryId: 'cat_new',
        amount: 400.0,
        period: 'monthly',
        createdAt: DateTime(2026, 9, 2), // created in September
        allowRollover: true,
      );

      app.budgets = [budget];
      app.transactions = []; // no transactions in August

      final rollover = app.budgetRollover(budget, now);
      expect(rollover, 0.0);
      expect(app.budgetEffectiveAllowance(budget, now), 400.0);
    });

    test('Correctly computes rollover when transactions contain category splits', () {
      final app = AppProvider();
      final now = DateTime(2026, 9, 15);
      final lastMonth = DateTime(2026, 8, 10);

      final budget = Budget(
        id: 'b_split',
        categoryId: 'cat_clothing',
        amount: 200.0,
        period: 'monthly',
        createdAt: DateTime(2026, 7, 1),
        allowRollover: true,
      );

      // Split transaction last month: total 150, but clothing is 80
      final txSplit = AppTransaction(
        id: 'tx_split1',
        type: 'expense',
        amount: 150.0,
        description: 'Department store',
        accountId: 'acc1',
        categoryId: 'cat_other',
        date: lastMonth,
        currency: 'USD',
      );

      const split1 = TransactionSplit(
        id: 's1',
        transactionId: 'tx_split1',
        categoryId: 'cat_clothing',
        amount: 80.0,
      );
      const split2 = TransactionSplit(
        id: 's2',
        transactionId: 'tx_split1',
        categoryId: 'cat_electronics',
        amount: 70.0,
      );

      app.budgets = [budget];
      app.transactions = [txSplit];
      app.splits = [split1, split2];
      app.rebuildSplitsCache();

      final rollover = app.budgetRollover(budget, now);
      // 200 budget - 80 split spent = 120 surplus
      expect(rollover, 120.0);
      expect(app.budgetEffectiveAllowance(budget, now), 320.0);
    });
  });

  group('Rollover Budget UI Tests', () {
    testWidgets('BudgetScreen renders rollover badge and base • rollover • total breakdown', (tester) async {
      final app = AppProvider();
      final now = DateTime.now();
      final lastMonth = DateTime(now.year, now.month - 1, 15);

      final cat = AppCategory(
        id: 'cat_groceries',
        name: 'Groceries',
        type: 'expense',
        colorValue: 0xFF2E7D32,
      );

      final budget = Budget(
        id: 'b_ui',
        categoryId: 'cat_groceries',
        amount: 300.0,
        period: 'monthly',
        createdAt: DateTime(now.year, now.month - 2, 1),
        allowRollover: true,
      );

      // Last month spent 250 -> 50 rollover
      final txPrev = AppTransaction(
        id: 'tx_ui_prev',
        type: 'expense',
        amount: 250.0,
        description: 'Supermarket',
        accountId: 'acc1',
        categoryId: 'cat_groceries',
        date: lastMonth,
      );

      app.categories = [cat];
      app.budgets = [budget];
      app.transactions = [txPrev];

      await tester.pumpWidget(
        ChangeNotifierProvider<AppProvider>.value(
          value: app,
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: BudgetScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify Category Name
      expect(find.text('Groceries'), findsWidgets);

      // Verify Rollover Badge
      expect(find.text('Rollover'), findsWidgets);

      // Verify Base amount in breakdown
      expect(find.textContaining('Base:'), findsOneWidget);

      // Verify Rollover amount in breakdown
      expect(find.textContaining('Rollover ('), findsOneWidget);
      expect(find.textContaining('+'), findsWidgets);

      // Verify Total Available in breakdown
      expect(find.textContaining('Total Available:'), findsOneWidget);
    });

    testWidgets('Tapping budget card opens sheet with Rollover switch and preview', (tester) async {
      final app = AppProvider();
      final now = DateTime.now();
      final lastMonth = DateTime(now.year, now.month - 1, 15);

      final cat = AppCategory(
        id: 'cat_groceries',
        name: 'Groceries',
        type: 'expense',
        colorValue: 0xFF2E7D32,
      );

      final budget = Budget(
        id: 'b_ui2',
        categoryId: 'cat_groceries',
        amount: 300.0,
        period: 'monthly',
        createdAt: DateTime(now.year, now.month - 2, 1),
        allowRollover: true,
      );

      final txPrev = AppTransaction(
        id: 'tx_ui_prev2',
        type: 'expense',
        amount: 250.0,
        description: 'Supermarket',
        accountId: 'acc1',
        categoryId: 'cat_groceries',
        date: lastMonth,
      );

      app.categories = [cat];
      app.budgets = [budget];
      app.transactions = [txPrev];

      await tester.pumpWidget(
        ChangeNotifierProvider<AppProvider>.value(
          value: app,
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: BudgetScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap on the budget card to open the edit sheet
      await tester.tap(find.text('Groceries').first);
      await tester.pumpAndSettle();

      // Verify the sheet opened with Rollover (Envelope) switch
      expect(find.text('Rollover (Envelope)'), findsOneWidget);
      expect(find.byType(SwitchListTile), findsOneWidget);

      final switchWidget = tester.widget<SwitchListTile>(find.byType(SwitchListTile));
      expect(switchWidget.value, true);

      // Tap the switch to toggle it
      await tester.tap(find.byType(SwitchListTile));
      await tester.pumpAndSettle();

      final updatedSwitch = tester.widget<SwitchListTile>(find.byType(SwitchListTile));
      expect(updatedSwitch.value, false);
    });
  });
}
