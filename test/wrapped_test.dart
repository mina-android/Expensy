// test/wrapped_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/screens/wrapped_screen.dart';
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

  group('Expensy Wrapped Engine Tests', () {
    test('Computes accurate monthly inflow, outflow, net savings, and savings rate', () {
      final app = AppProvider();
      final month = DateTime(2026, 8, 1);

      final acc = Account(
        id: 'acc1',
        name: 'Checking',
        type: 'bank',
        balance: 10000.0,
        currency: 'USD',
        colorValue: 0xFF1E88E5,
      );
      final catFood = AppCategory(
        id: 'cat_food',
        name: 'Food',
        type: 'expense',
        colorValue: 0xFFE65100,
      );
      final catTravel = AppCategory(
        id: 'cat_travel',
        name: 'Travel',
        type: 'expense',
        colorValue: 0xFF1976D2,
      );

      app.accounts.clear();
      app.accounts.add(acc);
      app.categories.clear();
      app.categories.addAll([catFood, catTravel]);
      app.settings.currency = 'USD';

      // August transactions
      app.transactions.clear();
      app.transactions.addAll([
        AppTransaction(
          id: 'tx1',
          type: 'income',
          amount: 5000.0,
          description: 'August Salary',
          accountId: 'acc1',
          categoryId: '',
          date: DateTime(2026, 8, 1, 9, 0),
          currency: 'USD',
        ),
        AppTransaction(
          id: 'tx2',
          type: 'expense',
          amount: 400.0,
          description: 'Groceries',
          accountId: 'acc1',
          categoryId: 'cat_food',
          date: DateTime(2026, 8, 5, 12, 0),
          currency: 'USD',
        ),
        AppTransaction(
          id: 'tx3',
          type: 'expense',
          amount: 600.0,
          description: 'Flight tickets',
          accountId: 'acc1',
          categoryId: 'cat_travel',
          date: DateTime(2026, 8, 10, 15, 0),
          currency: 'USD',
        ),
        // Outside month (July)
        AppTransaction(
          id: 'tx4',
          type: 'expense',
          amount: 2000.0,
          description: 'July Rent',
          accountId: 'acc1',
          categoryId: '',
          date: DateTime(2026, 7, 28),
          currency: 'USD',
        ),
      ]);

      final wrapped = app.getWrappedData(month);

      expect(wrapped.totalInflow, equals(5000.0));
      expect(wrapped.totalOutflow, equals(1000.0));
      expect(wrapped.netSaved, equals(4000.0));
      // Savings rate = (4000 / 5000) * 100 = 80.0%
      expect(wrapped.savingsRate, equals(80.0));
      // Top category is cat_travel with $600
      expect(wrapped.topCategoryId, equals('cat_travel'));
      expect(wrapped.topCategoryAmount, equals(600.0));
      expect(wrapped.topCategoryPercent, equals(60.0));
      // Biggest splurge is tx3 ($600)
      expect(wrapped.biggestSplurge?.id, equals('tx3'));
      expect(wrapped.biggestSplurgeAmount, equals(600.0));
      // Days in August = 31, 2 days had spend (5th and 10th), so 29 zero spend days
      expect(wrapped.zeroSpendDays, equals(29));
      expect(wrapped.totalDaysInMonth, equals(31));
    });

    test('Handles zero expense and zero income month gracefully without errors', () {
      final app = AppProvider();
      final month = DateTime(2026, 1, 1);
      app.transactions.clear();
      app.settings.currency = 'USD';

      final wrapped = app.getWrappedData(month);

      expect(wrapped.totalInflow, equals(0.0));
      expect(wrapped.totalOutflow, equals(0.0));
      expect(wrapped.netSaved, equals(0.0));
      expect(wrapped.savingsRate, equals(0.0));
      expect(wrapped.topCategoryId, isNull);
      expect(wrapped.topCategoryAmount, equals(0.0));
      expect(wrapped.biggestSplurge, isNull);
      expect(wrapped.biggestSplurgeAmount, equals(0.0));
      expect(wrapped.zeroSpendDays, equals(31));
    });
  });

  group('WrappedScreen UI Widget Tests', () {
    testWidgets('Renders story slides, advances, and toggles obscure amounts', (tester) async {
      final app = AppProvider();
      final month = DateTime(2026, 8, 1);

      final acc = Account(
        id: 'acc1',
        name: 'Checking',
        type: 'bank',
        balance: 5000.0,
        currency: 'USD',
        colorValue: 0xFF1E88E5,
      );
      final cat = AppCategory(
        id: 'cat_dining',
        name: 'Dining',
        type: 'expense',
        colorValue: 0xFFE65100,
      );

      app.accounts.clear();
      app.accounts.add(acc);
      app.categories.clear();
      app.categories.add(cat);
      app.settings.currency = 'USD';

      app.transactions.clear();
      app.transactions.addAll([
        AppTransaction(
          id: 'tx1',
          type: 'income',
          amount: 3000.0,
          description: 'Paycheck',
          accountId: 'acc1',
          categoryId: '',
          date: DateTime(2026, 8, 1, 10, 0),
          currency: 'USD',
        ),
        AppTransaction(
          id: 'tx2',
          type: 'expense',
          amount: 250.0,
          description: 'Fancy Dinner',
          accountId: 'acc1',
          categoryId: 'cat_dining',
          date: DateTime(2026, 8, 14, 20, 0),
          currency: 'USD',
        ),
      ]);

      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        ChangeNotifierProvider<AppProvider>.value(
          value: app,
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: WrappedScreen(initialMonth: month),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Slide 1: Big Picture should be visible
      expect(find.byType(WrappedScreen), findsOneWidget);
      expect(find.byIcon(Icons.auto_awesome_rounded), findsWidgets);
      expect(find.byIcon(Icons.account_balance_wallet_rounded), findsOneWidget);

      // Tap right to advance to Slide 2: Top Category
      final rightSide =
          tester.getCenter(find.byType(WrappedScreen)) + const Offset(100, 0);
      await tester.tapAt(rightSide);
      await tester.pump(const Duration(milliseconds: 400));

      // Tap right to advance to Slide 3: Splurge
      await tester.tapAt(rightSide);
      await tester.pump(const Duration(milliseconds: 400));

      // Tap right to advance to Slide 4: Hero Habit
      await tester.tapAt(rightSide);
      await tester.pump(const Duration(milliseconds: 400));

      // Tap right to advance to Slide 5: Receipt
      await tester.tapAt(rightSide);
      await tester.pumpAndSettle();

      // Receipt slide should show Replay and Obscure toggle
      expect(find.byIcon(Icons.replay_rounded), findsOneWidget);
      expect(find.byType(ActionChip), findsOneWidget);

      // Toggle obscure amounts
      await tester.tap(find.byType(ActionChip));
      await tester.pumpAndSettle();

      // Should find '***' representing obscured values
      expect(find.text('***'), findsWidgets);

      // Tap Replay button to restart
      await tester.tap(find.byIcon(Icons.replay_rounded));
      await tester.pump(const Duration(milliseconds: 400));

      // Returns to first slide
      expect(find.byIcon(Icons.account_balance_wallet_rounded), findsOneWidget);
    });
  });
}
