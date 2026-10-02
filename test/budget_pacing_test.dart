// test/budget_pacing_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/screens/budget_screen.dart';
import 'package:expensy/screens/home_screen.dart';
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

  group('Smart Safe-to-Spend Daily Budget Pacer Engine Tests', () {
    test('Calculates onTrack status and safeDailyAllowance correctly', () {
      final app = AppProvider();
      // September has 30 days. Let reference date be Sept 10.
      final now = DateTime(2026, 9, 10);

      final cat = AppCategory(
        id: 'cat_food',
        name: 'Dining',
        type: 'expense',
        colorValue: 0xFFE65100,
      );
      final acc = Account(
        id: 'acc1',
        name: 'Main Bank',
        type: 'bank',
        balance: 2000.0,
        currency: 'USD',
        colorValue: 0xFF1E88E5,
      );
      final budget = Budget(
        id: 'b1',
        categoryId: 'cat_food',
        amount: 300.0,
        period: 'monthly',
        createdAt: DateTime(2026, 9, 1),
      );

      // Spend 80 on day 10.
      // Total days = 30, elapsed = 10, days remaining = 30 - 10 + 1 = 21.
      // Spent frac = 80 / 300 = 0.2667
      // Time frac = 10 / 30 = 0.3333
      // Pacing ratio = 0.2667 / 0.3333 = 0.80 <= 1.0 -> onTrack
      // Safe daily allowance = (300 - 80) / 21 = 220 / 21 ≈ 10.476
      final tx = AppTransaction(
        id: 'tx1',
        type: 'expense',
        amount: 80.0,
        description: 'Groceries',
        accountId: 'acc1',
        categoryId: 'cat_food',
        date: DateTime(2026, 9, 5),
        currency: 'USD',
      );

      app.categories = [cat];
      app.accounts = [acc];
      app.budgets = [budget];
      app.transactions = [tx];

      final pacing = app.budgetPacing(budget, now);

      expect(pacing.status, BudgetPacingStatus.onTrack);
      expect(pacing.isOnTrack, isTrue);
      expect(pacing.totalDaysInPeriod, 30);
      expect(pacing.elapsedDays, 10);
      expect(pacing.daysRemaining, 21);
      expect(pacing.spent, 80.0);
      expect(pacing.allowance, 300.0);
      expect(pacing.remainingAmount, 220.0);
      expect(pacing.safeDailyAllowance, closeTo(10.476, 0.01));
      expect(pacing.pacingRatio, closeTo(0.80, 0.01));
    });

    test('Calculates caution status when spending rate is slightly fast (ratio 1.01-1.25)', () {
      final app = AppProvider();
      final now = DateTime(2026, 9, 10);

      final cat = AppCategory(
        id: 'cat_shop',
        name: 'Shopping',
        type: 'expense',
        colorValue: 0xFF9C27B0,
      );
      final acc = Account(
        id: 'acc1',
        name: 'Main Bank',
        type: 'bank',
        balance: 2000.0,
        currency: 'USD',
        colorValue: 0xFF1E88E5,
      );
      final budget = Budget(
        id: 'b2',
        categoryId: 'cat_shop',
        amount: 300.0,
        period: 'monthly',
        createdAt: DateTime(2026, 9, 1),
      );

      // Spend 110 on day 10.
      // Spent frac = 110 / 300 = 0.3667
      // Time frac = 10 / 30 = 0.3333
      // Ratio = 0.3667 / 0.3333 = 1.10 -> caution
      // Safe daily allowance = (300 - 110) / 21 = 190 / 21 ≈ 9.047
      final tx = AppTransaction(
        id: 'tx2',
        type: 'expense',
        amount: 110.0,
        description: 'Clothes',
        accountId: 'acc1',
        categoryId: 'cat_shop',
        date: DateTime(2026, 9, 8),
        currency: 'USD',
      );

      app.categories = [cat];
      app.accounts = [acc];
      app.budgets = [budget];
      app.transactions = [tx];

      final pacing = app.budgetPacing(budget, now);

      expect(pacing.status, BudgetPacingStatus.caution);
      expect(pacing.isCaution, isTrue);
      expect(pacing.daysRemaining, 21);
      expect(pacing.safeDailyAllowance, closeTo(9.047, 0.01));
      expect(pacing.pacingRatio, closeTo(1.10, 0.01));
    });

    test('Calculates overPaced status when spending rate is fast (ratio > 1.25)', () {
      final app = AppProvider();
      final now = DateTime(2026, 9, 10);

      final cat = AppCategory(
        id: 'cat_tech',
        name: 'Electronics',
        type: 'expense',
        colorValue: 0xFF009688,
      );
      final acc = Account(
        id: 'acc1',
        name: 'Main Bank',
        type: 'bank',
        balance: 2000.0,
        currency: 'USD',
        colorValue: 0xFF1E88E5,
      );
      final budget = Budget(
        id: 'b3',
        categoryId: 'cat_tech',
        amount: 300.0,
        period: 'monthly',
        createdAt: DateTime(2026, 9, 1),
      );

      // Spend 150 on day 10.
      // Spent frac = 150 / 300 = 0.50
      // Time frac = 10 / 30 = 0.3333
      // Ratio = 0.50 / 0.3333 = 1.50 > 1.25 -> overPaced
      // Safe daily allowance = (300 - 150) / 21 = 150 / 21 ≈ 7.142
      final tx = AppTransaction(
        id: 'tx3',
        type: 'expense',
        amount: 150.0,
        description: 'Headphones',
        accountId: 'acc1',
        categoryId: 'cat_tech',
        date: DateTime(2026, 9, 7),
        currency: 'USD',
      );

      app.categories = [cat];
      app.accounts = [acc];
      app.budgets = [budget];
      app.transactions = [tx];

      final pacing = app.budgetPacing(budget, now);

      expect(pacing.status, BudgetPacingStatus.overPaced);
      expect(pacing.isOverPaced, isTrue);
      expect(pacing.safeDailyAllowance, closeTo(7.142, 0.01));
      expect(pacing.pacingRatio, closeTo(1.50, 0.01));
    });

    test('Calculates exceeded status when spending surpasses allowance', () {
      final app = AppProvider();
      final now = DateTime(2026, 9, 10);

      final cat = AppCategory(
        id: 'cat_food',
        name: 'Dining',
        type: 'expense',
        colorValue: 0xFFE65100,
      );
      final acc = Account(
        id: 'acc1',
        name: 'Main Bank',
        type: 'bank',
        balance: 2000.0,
        currency: 'USD',
        colorValue: 0xFF1E88E5,
      );
      final budget = Budget(
        id: 'b1',
        categoryId: 'cat_food',
        amount: 300.0,
        period: 'monthly',
        createdAt: DateTime(2026, 9, 1),
      );

      // Spend 320 on day 10 -> exceeded
      final tx = AppTransaction(
        id: 'tx1',
        type: 'expense',
        amount: 320.0,
        description: 'Fancy Dinner Party',
        accountId: 'acc1',
        categoryId: 'cat_food',
        date: DateTime(2026, 9, 9),
        currency: 'USD',
      );

      app.categories = [cat];
      app.accounts = [acc];
      app.budgets = [budget];
      app.transactions = [tx];

      final pacing = app.budgetPacing(budget, now);

      expect(pacing.status, BudgetPacingStatus.exceeded);
      expect(pacing.isExceeded, isTrue);
      expect(pacing.safeDailyAllowance, 0.0);
      expect(pacing.remainingAmount, 0.0);
    });

    test('Weekly budget pacing handles 7-day period accurately', () {
      final app = AppProvider();
      // Wednesday Sept 9, 2026.
      final now = DateTime(2026, 9, 9);

      final cat = AppCategory(
        id: 'cat_groceries',
        name: 'Weekly Groceries',
        type: 'expense',
        colorValue: 0xFF4CAF50,
      );
      final acc = Account(
        id: 'acc1',
        name: 'Main Bank',
        type: 'bank',
        balance: 2000.0,
        currency: 'USD',
        colorValue: 0xFF1E88E5,
      );
      final budget = Budget(
        id: 'b_weekly',
        categoryId: 'cat_groceries',
        amount: 140.0,
        period: 'weekly',
        createdAt: DateTime(2026, 9, 1),
      );

      // Week starts Monday Sept 7. Today is Wednesday Sept 9 (elapsed = 3 days).
      // Days remaining = 7 - 3 + 1 = 5 days.
      // Spent 40 of 140 -> remaining = 100 -> safe daily = 100 / 5 = 20.0.
      final tx = AppTransaction(
        id: 'tx_w1',
        type: 'expense',
        amount: 40.0,
        description: 'Groceries Mon',
        accountId: 'acc1',
        categoryId: 'cat_groceries',
        date: DateTime(2026, 9, 7),
        currency: 'USD',
      );

      app.categories = [cat];
      app.accounts = [acc];
      app.budgets = [budget];
      app.transactions = [tx];

      final pacing = app.budgetPacing(budget, now);

      expect(pacing.totalDaysInPeriod, 7);
      expect(pacing.elapsedDays, 3);
      expect(pacing.daysRemaining, 5);
      expect(pacing.safeDailyAllowance, 20.0);
      expect(pacing.status, BudgetPacingStatus.onTrack);
    });

    test('Pacing calculation incorporates rollover surplus and deficit', () {
      final app = AppProvider();
      final now = DateTime(2026, 9, 10);
      final lastMonth = DateTime(2026, 8, 15);

      final cat = AppCategory(
        id: 'cat_fuel',
        name: 'Fuel',
        type: 'expense',
        colorValue: 0xFF2196F3,
      );
      final acc = Account(
        id: 'acc1',
        name: 'Main Bank',
        type: 'bank',
        balance: 2000.0,
        currency: 'USD',
        colorValue: 0xFF1E88E5,
      );
      final budget = Budget(
        id: 'b_fuel',
        categoryId: 'cat_fuel',
        amount: 200.0,
        period: 'monthly',
        createdAt: DateTime(2026, 8, 1),
        allowRollover: true,
      );

      // Last month: spent 150 out of 200 -> +50 rollover surplus.
      // Effective allowance in Sept = 200 + 50 = 250.
      final txPrev = AppTransaction(
        id: 'tx_f_prev',
        type: 'expense',
        amount: 150.0,
        description: 'Gas Aug',
        accountId: 'acc1',
        categoryId: 'cat_fuel',
        date: lastMonth,
        currency: 'USD',
      );

      // Current month: spent 50 on Sept 5.
      // Remaining = 250 - 50 = 200.
      // Days remaining on Sept 10 = 21.
      // Safe daily = 200 / 21 ≈ 9.52.
      final txCurr = AppTransaction(
        id: 'tx_f_curr',
        type: 'expense',
        amount: 50.0,
        description: 'Gas Sept',
        accountId: 'acc1',
        categoryId: 'cat_fuel',
        date: DateTime(2026, 9, 5),
        currency: 'USD',
      );

      app.categories = [cat];
      app.accounts = [acc];
      app.budgets = [budget];
      app.transactions = [txPrev, txCurr];

      final pacing = app.budgetPacing(budget, now);

      expect(pacing.allowance, 250.0);
      expect(pacing.spent, 50.0);
      expect(pacing.remainingAmount, 200.0);
      expect(pacing.safeDailyAllowance, closeTo(9.52, 0.01));
      expect(pacing.status, BudgetPacingStatus.onTrack);
    });

    test('overallMonthlyBudgetPacing aggregates all monthly budgets correctly', () {
      final app = AppProvider();
      final now = DateTime(2026, 9, 10);

      final cat1 = AppCategory(
        id: 'cat_1',
        name: 'Dining',
        type: 'expense',
        colorValue: 0xFFE65100,
      );
      final cat2 = AppCategory(
        id: 'cat_2',
        name: 'Entertainment',
        type: 'expense',
        colorValue: 0xFF673AB7,
      );
      final acc = Account(
        id: 'acc1',
        name: 'Main Bank',
        type: 'bank',
        balance: 3000.0,
        currency: 'USD',
        colorValue: 0xFF1E88E5,
      );

      final budget1 = Budget(
        id: 'b1',
        categoryId: 'cat_1',
        amount: 300.0,
        period: 'monthly',
        createdAt: DateTime(2026, 9, 1),
      );
      final budget2 = Budget(
        id: 'b2',
        categoryId: 'cat_2',
        amount: 200.0,
        period: 'monthly',
        createdAt: DateTime(2026, 9, 1),
      );

      // Spend 60 on Dining, 40 on Entertainment -> Total spent 100 of 500
      final tx1 = AppTransaction(
        id: 'tx1',
        type: 'expense',
        amount: 60.0,
        description: 'Lunch',
        accountId: 'acc1',
        categoryId: 'cat_1',
        date: DateTime(2026, 9, 3),
        currency: 'USD',
      );
      final tx2 = AppTransaction(
        id: 'tx2',
        type: 'expense',
        amount: 40.0,
        description: 'Movies',
        accountId: 'acc1',
        categoryId: 'cat_2',
        date: DateTime(2026, 9, 6),
        currency: 'USD',
      );

      app.categories = [cat1, cat2];
      app.accounts = [acc];
      app.budgets = [budget1, budget2];
      app.transactions = [tx1, tx2];

      final overall = app.overallMonthlyBudgetPacing(now);

      expect(overall, isNotNull);
      expect(overall!.allowance, 500.0);
      expect(overall.spent, 100.0);
      expect(overall.remainingAmount, 400.0);
      // Days remaining = 30 - 10 + 1 = 21
      // Safe daily = 400 / 21 ≈ 19.047
      expect(overall.safeDailyAllowance, closeTo(19.047, 0.01));
      expect(overall.status, BudgetPacingStatus.onTrack);
    });

    test('overallMonthlyBudgetPacing returns null when no monthly budgets exist', () {
      final app = AppProvider();
      app.budgets = [];

      final overall = app.overallMonthlyBudgetPacing(DateTime(2026, 9, 10));
      expect(overall, isNull);
    });
  });

  group('Smart Daily Budget Pacer Widget Tests', () {
    testWidgets('BudgetScreen renders Safe-to-Spend pacing chip on budget card',
        (tester) async {
      final app = AppProvider();
      final cat = AppCategory(
        id: 'cat_groceries',
        name: 'Groceries',
        type: 'expense',
        colorValue: 0xFF2E7D32,
      );
      final acc = Account(
        id: 'acc1',
        name: 'Main Bank',
        type: 'bank',
        balance: 1500.0,
        currency: 'USD',
        colorValue: 0xFF1E88E5,
      );
      final budget = Budget(
        id: 'b_groc',
        categoryId: 'cat_groceries',
        amount: 500.0,
        period: 'monthly',
        createdAt: DateTime.now(),
      );

      app.categories = [cat];
      app.accounts = [acc];
      app.budgets = [budget];
      app.transactions = [];

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

      // Verify Groceries card is present
      expect(find.text('Groceries'), findsOneWidget);

      // Verify pacing indicator renders daily safe spend text
      expect(find.byIcon(Icons.check_circle_outline_rounded), findsWidgets);
    });

    testWidgets('HomeScreen renders interactive Safe-to-Spend Daily Pacer card',
        (tester) async {
      final app = AppProvider();
      final cat = AppCategory(
        id: 'cat_food',
        name: 'Dining',
        type: 'expense',
        colorValue: 0xFFE65100,
      );
      final acc = Account(
        id: 'acc1',
        name: 'Main Bank',
        type: 'bank',
        balance: 2000.0,
        currency: 'USD',
        colorValue: 0xFF1E88E5,
      );
      final budget = Budget(
        id: 'b1',
        categoryId: 'cat_food',
        amount: 600.0,
        period: 'monthly',
        createdAt: DateTime.now(),
      );

      app.categories = [cat];
      app.accounts = [acc];
      app.budgets = [budget];
      app.transactions = [];

      await tester.pumpWidget(
        ChangeNotifierProvider<AppProvider>.value(
          value: app,
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: HomeScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify Safe-to-Spend badge or card renders
      expect(find.text('Safe-to-Spend'), findsOneWidget);
      expect(find.text('On track'), findsOneWidget);

      // Tap on the Safe-to-Spend card to test navigation to Budgets tab (index 4)
      await tester.tap(find.text('Safe-to-Spend'));
      await tester.pumpAndSettle();

      expect(app.tabIndexNotifier.value, 4);
    });
  });
}
