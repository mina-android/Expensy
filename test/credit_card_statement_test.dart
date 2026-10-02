// test/credit_card_statement_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/widgets/credit_card_settlement_sheet.dart';
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

  group('Credit Card Statement Engine Tests', () {
    test('Calculates utilization tiers correctly (low, moderate, high)', () {
      final app = AppProvider();

      // Card 1: 15% utilization (< 30% -> low)
      final cardLow = Account(
        id: 'c1',
        name: 'Visa Green',
        type: 'credit',
        balance: -750.0,
        creditLimit: 5000.0,
        colorValue: 0xFF2E7D32,
        currency: 'USD',
      );
      final stmtLow = app.getCreditCardStatement(cardLow);
      expect(stmtLow.totalOutstandingDebt, 750.0);
      expect(stmtLow.availableCredit, 4250.0);
      expect(stmtLow.utilizationPercent, 15.0);
      expect(stmtLow.utilizationTier, 'low');
      expect(stmtLow.isFullyPaid, false);

      // Card 2: 50% utilization (30% - 70% -> moderate)
      final cardMed = Account(
        id: 'c2',
        name: 'Mastercard Gold',
        type: 'credit',
        balance: -2500.0,
        creditLimit: 5000.0,
        colorValue: 0xFFFFA000,
        currency: 'USD',
      );
      final stmtMed = app.getCreditCardStatement(cardMed);
      expect(stmtMed.utilizationPercent, 50.0);
      expect(stmtMed.utilizationTier, 'moderate');

      // Card 3: 85% utilization (> 70% -> high)
      final cardHigh = Account(
        id: 'c3',
        name: 'Amex Platinum',
        type: 'credit',
        balance: -8500.0,
        creditLimit: 10000.0,
        colorValue: 0xFFD32F2F,
        currency: 'USD',
      );
      final stmtHigh = app.getCreditCardStatement(cardHigh);
      expect(stmtHigh.utilizationPercent, 85.0);
      expect(stmtHigh.utilizationTier, 'high');

      // Card 4: Zero balance (fully paid)
      final cardPaid = Account(
        id: 'c4',
        name: 'Zero Balance Card',
        type: 'credit',
        balance: 0.0,
        creditLimit: 3000.0,
        colorValue: 0xFF000000,
        currency: 'USD',
      );
      final stmtPaid = app.getCreditCardStatement(cardPaid);
      expect(stmtPaid.totalOutstandingDebt, 0.0);
      expect(stmtPaid.availableCredit, 3000.0);
      expect(stmtPaid.utilizationPercent, 0.0);
      expect(stmtPaid.isFullyPaid, true);
    });

    test('Separates statement cycle expenses from unbilled charges', () {
      final app = AppProvider();

      // Statement day = 15 of each month
      final card = Account(
        id: 'c_stmt',
        name: 'Rewards Card',
        type: 'credit',
        balance: -1000.0, // Total debt = 1000
        creditLimit: 5000.0,
        statementDay: 15,
        dueDay: 5,
        colorValue: 0xFF000000,
        currency: 'USD',
      );

      // Statement date is 15th
      final stmt = app.getCreditCardStatement(card);
      final stmtDate = stmt.statementDate!;

      // Add expense inside statement window (statement period)
      final inCycleDate = stmtDate.subtract(const Duration(days: 3));
      // Add expense after statement date (unbilled)
      final unbilledDate = stmtDate.add(const Duration(days: 2));

      app.transactions = [
        AppTransaction(
          id: 'tx1',
          type: 'expense',
          amount: 650.0,
          description: 'Groceries in cycle',
          accountId: 'c_stmt',
          categoryId: 'food',
          date: inCycleDate,
          currency: 'USD',
        ),
        AppTransaction(
          id: 'tx2',
          type: 'expense',
          amount: 350.0,
          description: 'Dinner after cycle',
          accountId: 'c_stmt',
          categoryId: 'food',
          date: unbilledDate,
          currency: 'USD',
        ),
      ];

      final calculatedStmt = app.getCreditCardStatement(card);
      expect(calculatedStmt.totalOutstandingDebt, 1000.0);
      expect(calculatedStmt.statementBalance, 650.0);
      expect(calculatedStmt.unbilledBalance, 350.0);
    });

    test('Calculates minimum payments accurately', () {
      final app = AppProvider();

      // Flat minimum payment amount set to 50
      final cardFixedMin = Account(
        id: 'c_min1',
        name: 'Fixed Min Card',
        type: 'credit',
        balance: -600.0,
        minPaymentAmount: 50.0,
        colorValue: 0xFF000000,
        currency: 'USD',
      );
      expect(app.getCreditCardStatement(cardFixedMin).minPaymentAmount, 50.0);

      // Percentage minimum payment set to 10% of debt
      final cardPctMin = Account(
        id: 'c_min2',
        name: 'Percent Min Card',
        type: 'credit',
        balance: -800.0,
        minPaymentPercent: 10.0,
        colorValue: 0xFF000000,
        currency: 'USD',
      );
      expect(app.getCreditCardStatement(cardPctMin).minPaymentAmount, 80.0);

      // Default minimum payment (5% of debt with min 25)
      final cardDefMin = Account(
        id: 'c_min3',
        name: 'Default Min Card',
        type: 'credit',
        balance: -1000.0,
        colorValue: 0xFF000000,
        currency: 'USD',
      );
      expect(app.getCreditCardStatement(cardDefMin).minPaymentAmount, 50.0);
    });

    test('Due date computation handles same month and next month', () {
      final app = AppProvider();

      // Statement day = 10, Due day = 25 (Same calendar month)
      final cardSameMonth = Account(
        id: 'c_due1',
        name: 'Same Month Card',
        type: 'credit',
        balance: 0.0,
        statementDay: 10,
        dueDay: 25,
        colorValue: 0xFF000000,
      );
      final stmt1 = app.getCreditCardStatement(cardSameMonth);
      expect(stmt1.dueDate, isNotNull);
      expect(stmt1.dueDate!.day, 25);
      expect(stmt1.dueDate!.month, stmt1.statementDate!.month);

      // Statement day = 25, Due day = 10 (Next calendar month)
      final cardNextMonth = Account(
        id: 'c_due2',
        name: 'Next Month Card',
        type: 'credit',
        balance: 0.0,
        statementDay: 25,
        dueDay: 10,
        colorValue: 0xFF000000,
      );
      final stmt2 = app.getCreditCardStatement(cardNextMonth);
      expect(stmt2.dueDate, isNotNull);
      expect(stmt2.dueDate!.day, 10);
      final expectedMonth = stmt2.statementDate!.month == 12
          ? 1
          : stmt2.statementDate!.month + 1;
      expect(stmt2.dueDate!.month, expectedMonth);
    });
  });

  group('Credit Card Settlement Tests', () {
    test('settleCreditCard transfers funds from bank to credit card and updates balances', () async {
      final app = AppProvider();

      final bank = Account(
        id: 'bank_main',
        name: 'Checking Account',
        type: 'bank',
        balance: 3000.0,
        colorValue: 0xFF000000,
        currency: 'USD',
      );
      final card = Account(
        id: 'card_rewards',
        name: 'Rewards Card',
        type: 'credit',
        balance: -500.0,
        creditLimit: 2000.0,
        colorValue: 0xFF000000,
        currency: 'USD',
      );

      await db.insertAccount(bank);
      await db.insertAccount(card);
      app.accounts = await db.getAccounts();

      expect(app.accountById('bank_main')!.balance, 3000.0);
      expect(app.accountById('card_rewards')!.balance, -500.0);

      // Settle 350.0 towards credit card bill
      await app.settleCreditCard(
        cardAccount: card,
        fromAccount: bank,
        amount: 350.0,
        note: 'Partial bill payment',
      );

      final updatedBank = app.accountById('bank_main')!;
      final updatedCard = app.accountById('card_rewards')!;

      expect(updatedBank.balance, 2650.0); // 3000 - 350
      expect(updatedCard.balance, -150.0); // -500 + 350 = -150 debt

      final stmtAfter = app.getCreditCardStatement(updatedCard);
      expect(stmtAfter.totalOutstandingDebt, 150.0);
      expect(stmtAfter.availableCredit, 1850.0);
    });
  });

  group('Credit Card Settlement UI Tests', () {
    testWidgets('CreditCardSettlementSheet renders options and executes payment',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final app = AppProvider();
      final bank = Account(
        id: 'bank_ui',
        name: 'Main Bank',
        type: 'bank',
        balance: 2000.0,
        colorValue: 0xFF000000,
        currency: 'USD',
      );
      final card = Account(
        id: 'card_ui',
        name: 'Platinum Card',
        type: 'credit',
        balance: -400.0,
        creditLimit: 3000.0,
        statementDay: 15,
        dueDay: 5,
        cardNumberLast4: '4321',
        colorValue: 0xFF2E7D32,
        currency: 'USD',
      );

      await db.insertAccount(bank);
      await db.insertAccount(card);
      app.accounts = await db.getAccounts();

      await tester.pumpWidget(
        ChangeNotifierProvider<AppProvider>.value(
          value: app,
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: CreditCardSettlementSheet(cardAccount: card),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Check header and card info
      expect(find.text('Platinum Card · •••• 4321'), findsOneWidget);
      expect(find.text('Total Balance'), findsAtLeastNWidgets(1));

      // Check Pay button
      expect(find.byType(FilledButton), findsOneWidget);

      // Tap Pay button to settle
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      // Card debt should be settled
      final updatedCard = app.accountById('card_ui')!;
      expect(updatedCard.balance, 0.0); // Fully cleared

      // Let 3s snackbar timer finish
      await tester.pump(const Duration(seconds: 4));
    });
  });
}
