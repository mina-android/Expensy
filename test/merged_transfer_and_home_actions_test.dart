import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/l10n/app_localizations.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/screens/add_transaction_screen.dart';
import 'package:expensy/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
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

    final bank = Account(
      id: 'acc_bank',
      name: 'Main Bank',
      type: 'bank',
      balance: 1000.0,
      currency: 'USD',
      colorValue: 0xFF1976D2,
      createdAt: DateTime(2026, 1, 1),
    );
    final cash = Account(
      id: 'acc_cash',
      name: 'Cash Wallet',
      type: 'cash',
      balance: 200.0,
      currency: 'USD',
      colorValue: 0xFF388E3C,
      createdAt: DateTime(2026, 1, 1),
    );
    final expenseCat = AppCategory(
      id: 'cat_food',
      name: 'Food',
      type: 'expense',
      colorValue: 0xFFE53935,
    );
    final incomeCat = AppCategory(
      id: 'cat_salary',
      name: 'Salary',
      type: 'income',
      colorValue: 0xFF2E7D32,
    );
    final transferCat = AppCategory(
      id: 'sys_transfer',
      name: 'Transfer',
      type: 'expense',
      colorValue: 0xFF1976D2,
    );
    final preset = TransactionPreset(
      id: 'preset_1',
      title: 'Coffee',
      type: 'expense',
      amount: 5.0,
      accountId: 'acc_cash',
      categoryId: 'cat_food',
      currency: 'USD',
      colorValue: 0xFF1976D2,
    );

    await db.insertAccount(bank);
    await db.insertAccount(cash);
    await db.insertCategory(expenseCat);
    await db.insertCategory(incomeCat);
    await db.insertCategory(transferCat);
    await db.insertPreset(preset);

    provider.accounts = [bank, cash];
    provider.categories = [expenseCat, incomeCat, transferCat];
    provider.presets = [preset];
  });

  tearDown(() async {
    provider.dispose();
    await db.close();
    AppDatabase.setInstanceForTesting(null);
  });

  Widget wrap(Widget child) {
    return ChangeNotifierProvider<AppProvider>.value(
      value: provider,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: child,
      ),
    );
  }

  testWidgets(
      'AddTransactionScreen unifies Expense/Income/Transfer, hides Quick Presets, and submits transfer with description',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      wrap(const AddTransactionScreen(initialType: 'transfer')),
    );
    await tester.pumpAndSettle();

    // Unified AppBar title across all tabs
    expect(find.text('Enter Transaction'), findsOneWidget);

    // Quick presets strip is hidden across all modes (even though a preset exists)
    expect(find.text('Coffee'), findsNothing);

    // 3-way type toggle is present
    expect(find.text('Expense'), findsOneWidget);
    expect(find.text('Income'), findsOneWidget);
    expect(find.text('Transfer'), findsAtLeastNWidgets(2)); // toggle + submit button

    // Transfer-specific sections: FROM, TO, locked Transfer category, shared Description & Note
    expect(find.text('FROM'), findsOneWidget);
    expect(find.text('TO'), findsOneWidget);
    expect(find.text('Transfer (Default & Only Category)'), findsOneWidget);
    expect(find.text('Description (optional)'), findsOneWidget);

    // Tap keypad digits '1', '5', '0' -> amount = 150
    await tester.tap(find.text('1').last);
    await tester.pump();
    await tester.tap(find.text('5').last);
    await tester.pump();
    await tester.tap(find.text('0').last);
    await tester.pump();
    expect(find.text('150'), findsOneWidget);

    // Enter description
    await tester.enterText(
      find.widgetWithText(TextField, 'Description (optional)'),
      'Rent reserve',
    );
    await tester.pump();

    // Swap From and To accounts (Cash Wallet -> Main Bank)
    await tester.tap(find.byIcon(Icons.swap_vert_rounded));
    await tester.pump();

    // Submit transfer via pinned button
    final submitButton = find.widgetWithIcon(FilledButton, Icons.swap_horiz_rounded);
    expect(submitButton, findsOneWidget);
    await tester.tap(submitButton);
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 100)));
    await tester.pump(const Duration(seconds: 1));

    // Verify paired transfer legs and swapped balances (Cash: 200 - 150 = 50, Bank: 1000 + 150 = 1150)
    expect(provider.transactions.length, 2);
    expect(provider.transactions.every((t) => t.isTransfer), isTrue);
    expect(
      provider.transactions.any((t) => t.description == 'Rent reserve (Transfer out)'),
      isTrue,
    );
    expect(provider.accountById('acc_cash')!.balance, closeTo(50.0, 0.001));
    expect(provider.accountById('acc_bank')!.balance, closeTo(1150.0, 0.001));
  });

  testWidgets('AddTransactionScreen hides Transfer tab when editing an existing transaction',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final existing = AppTransaction(
      id: 'tx_edit_1',
      type: 'expense',
      amount: 42.0,
      description: 'Groceries',
      accountId: 'acc_cash',
      categoryId: 'cat_food',
      date: DateTime(2026, 2, 1),
    );

    await tester.pumpWidget(wrap(AddTransactionScreen(existing: existing)));
    await tester.pumpAndSettle();

    expect(find.text('Edit Transaction'), findsOneWidget);
    expect(find.text('Expense'), findsOneWidget);
    expect(find.text('Income'), findsOneWidget);
    expect(find.text('Transfer'), findsNothing);
    expect(find.text('Coffee'), findsNothing);
  });

  testWidgets(
      'HomeScreen quick actions show Converter, Lent Money, Calendar, and Forecast',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(wrap(const HomeScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Converter'), findsOneWidget);
    expect(find.text('Lent Money'), findsOneWidget);
    expect(find.text('Calendar'), findsOneWidget);
    expect(find.text('Forecast'), findsOneWidget);
    expect(find.text('Insights'), findsNothing);
  });
}
