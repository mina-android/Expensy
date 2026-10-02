// test/financial_calendar_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/screens/financial_calendar_screen.dart';
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

  group('Financial Calendar Engine Tests', () {
    test('Calculates day transactions, expense, and income accurately', () {
      final app = AppProvider();
      final targetDay = DateTime(2026, 9, 15);

      final catExpense = AppCategory(
        id: 'cat_e',
        name: 'Dining',
        type: 'expense',
        colorValue: 0xFFE65100,
      );
      final catIncome = AppCategory(
        id: 'cat_i',
        name: 'Salary',
        type: 'income',
        colorValue: 0xFF2E7D32,
      );
      final acc = Account(
        id: 'acc1',
        name: 'Bank',
        type: 'bank',
        balance: 5000.0,
        currency: 'USD',
        colorValue: 0xFF1E88E5,
      );

      final tx1 = AppTransaction(
        id: 'tx1',
        type: 'expense',
        amount: 45.0,
        description: 'Lunch',
        accountId: 'acc1',
        categoryId: 'cat_e',
        date: DateTime(2026, 9, 15, 12, 30),
        currency: 'USD',
      );
      final tx2 = AppTransaction(
        id: 'tx2',
        type: 'expense',
        amount: 25.0,
        description: 'Coffee',
        accountId: 'acc1',
        categoryId: 'cat_e',
        date: DateTime(2026, 9, 15, 16, 0),
        currency: 'USD',
      );
      final txIncome = AppTransaction(
        id: 'tx3',
        type: 'income',
        amount: 200.0,
        description: 'Bonus',
        accountId: 'acc1',
        categoryId: 'cat_i',
        date: DateTime(2026, 9, 15, 9, 0),
        currency: 'USD',
      );
      final txOtherDay = AppTransaction(
        id: 'tx4',
        type: 'expense',
        amount: 90.0,
        description: 'Shoes',
        accountId: 'acc1',
        categoryId: 'cat_e',
        date: DateTime(2026, 9, 16, 11, 0),
        currency: 'USD',
      );

      app.categories = [catExpense, catIncome];
      app.accounts = [acc];
      app.transactions = [tx1, tx2, txIncome, txOtherDay];

      final dayTxs = app.transactionsForDay(targetDay);
      expect(dayTxs.length, 3);
      expect(app.dayExpense(targetDay), 70.0);
      expect(app.dayIncome(targetDay), 200.0);

      // On Sept 16
      expect(app.dayExpense(DateTime(2026, 9, 16)), 90.0);
    });

    test('Identifies upcoming obligations (recurring, loans, lended) on target day', () {
      final app = AppProvider();
      final day = DateTime(2026, 9, 20);

      final rec = RecurringPayment(
        id: 'r1',
        name: 'Streaming',
        accountId: 'acc1',
        categoryId: 'cat1',
        amount: 15.0,
        paymentType: 'expense',
        freqVal: 1,
        freqUnit: 'months',
        startDate: DateTime(2026, 1, 20),
        nextDate: DateTime(2026, 9, 20),
      );

      final loan = Loan(
        id: 'l1',
        name: 'Car Loan',
        principal: 10000.0,
        startDate: DateTime(2026, 1, 1),
        endDate: DateTime(2028, 1, 1),
        reminderDay: 20,
      );

      final person = LendedPerson(id: 'p1', name: 'Alex', colorValue: 0xFF6750A4);
      final lended = LendedMoney(
        id: 'lm1',
        personId: 'p1',
        amount: 100.0,
        type: 'lent',
        date: DateTime(2026, 8, 1),
        dueDate: DateTime(2026, 9, 20),
        isSettled: false,
      );

      app.recurring = [rec];
      app.loans = [loan];
      app.lendedPeople = [person];
      app.lended = [lended];

      expect(app.recurringDueOnDay(day).length, 1);
      expect(app.recurringDueOnDay(day).first.name, 'Streaming');

      expect(app.loansDueOnDay(day).length, 1);
      expect(app.loansDueOnDay(day).first.name, 'Car Loan');

      expect(app.lendedDueOnDay(day).length, 1);
      expect(app.lendedDueOnDay(day).first.amount, 100.0);
    });

    test('Counts zero-spend days accurately up to reference date', () {
      final app = AppProvider();
      final cat = AppCategory(id: 'c1', name: 'Food', type: 'expense', colorValue: 0xFFE65100);
      final acc = Account(id: 'a1', name: 'Bank', type: 'bank', balance: 1000.0, currency: 'USD', colorValue: 0xFF1E88E5);

      // Suppose month is September 2026 (30 days).
      // Reference date is Sept 5 (5 days elapsed).
      // Suppose expenses happened on Sept 1 and Sept 3.
      // Zero-spend days should be Sept 2, 4, 5 (total 3 zero-spend days).
      final tx1 = AppTransaction(
        id: 'tx1',
        type: 'expense',
        amount: 20.0,
        description: 'Snack',
        accountId: 'a1',
        categoryId: 'c1',
        date: DateTime(2026, 9, 1),
        currency: 'USD',
      );
      final tx2 = AppTransaction(
        id: 'tx2',
        type: 'expense',
        amount: 30.0,
        description: 'Dinner',
        accountId: 'a1',
        categoryId: 'c1',
        date: DateTime(2026, 9, 3),
        currency: 'USD',
      );

      app.categories = [cat];
      app.accounts = [acc];
      app.transactions = [tx1, tx2];

      final zeroCount = app.zeroSpendDaysCount(DateTime(2026, 9, 1), DateTime(2026, 9, 5));
      expect(zeroCount, 3);
    });
  });

  group('Financial Calendar Widget Tests', () {
    testWidgets('Renders FinancialCalendarScreen with grid and day details', (tester) async {
      final app = AppProvider();
      final cat = AppCategory(id: 'c1', name: 'Groceries', type: 'expense', colorValue: 0xFF2E7D32);
      final acc = Account(id: 'a1', name: 'Cash', type: 'cash', balance: 500.0, currency: 'USD', colorValue: 0xFF4CAF50);

      final testDate = DateTime(2026, 9, 15);
      final tx = AppTransaction(
        id: 'tx_groc',
        type: 'expense',
        amount: 40.0,
        description: 'Weekly Groceries',
        accountId: 'a1',
        categoryId: 'c1',
        date: testDate,
        currency: 'USD',
      );

      app.categories = [cat];
      app.accounts = [acc];
      app.transactions = [tx];

      await tester.pumpWidget(
        ChangeNotifierProvider<AppProvider>.value(
          value: app,
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: FinancialCalendarScreen(initialDate: testDate),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check title and elements
      expect(find.text('Financial Calendar'), findsOneWidget);
      expect(find.text('Weekly Groceries'), findsOneWidget);
      expect(find.text('Today'), findsNothing); // Tooltip only
      expect(find.byIcon(Icons.today_rounded), findsOneWidget);

      // Verify tapping next month updates month
      await tester.tap(find.byIcon(Icons.chevron_right_rounded));
      await tester.pumpAndSettle();
      expect(find.text('October 2026'), findsOneWidget);
    });
  });
}
