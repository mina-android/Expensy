import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/l10n/app_localizations.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/screens/accounts_screen.dart';
import 'package:expensy/screens/add_transaction_screen.dart';
import 'package:expensy/screens/lended_person_screen.dart';
import 'package:expensy/screens/transactions_screen.dart';
import 'package:expensy/widgets/shared_widgets.dart';
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

    final food = AppCategory(
      id: 'cat_food',
      name: 'Food & Dining',
      type: 'expense',
      colorValue: 0xFFE53935,
    );
    final subGroceries = AppCategory(
      id: 'sub_groceries',
      name: 'Groceries',
      type: 'expense',
      colorValue: 0xFFE53935,
      parentId: 'cat_food',
    );
    final subRestaurants = AppCategory(
      id: 'sub_restaurants',
      name: 'Restaurants',
      type: 'expense',
      colorValue: 0xFFE53935,
      parentId: 'cat_food',
    );
    final subDelivery = AppCategory(
      id: 'sub_delivery',
      name: 'Delivery',
      type: 'expense',
      colorValue: 0xFFE53935,
      parentId: 'cat_food',
    );
    final transferCat = AppCategory(
      id: 'sys_transfer',
      name: 'Transfer',
      type: 'expense',
      colorValue: 0xFF1976D2,
    );

    await db.insertCategory(food);
    await db.insertCategory(subGroceries);
    await db.insertCategory(subRestaurants);
    await db.insertCategory(subDelivery);
    await db.insertCategory(transferCat);
    provider.categories = [
      food,
      subGroceries,
      subRestaurants,
      subDelivery,
      transferCat,
    ];
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

  testWidgets('Issue #32: CategoryChipPicker renders subcategories in one horizontal scrollable row',
      (tester) async {
    await tester.pumpWidget(
      wrap(
        Scaffold(
          body: CategoryChipPicker(
            categories: provider.userCategories,
            selectedId: 'cat_food',
            onSelected: (_) {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final horizontalScroll = find.byWidgetPredicate(
      (w) => w is SingleChildScrollView && w.scrollDirection == Axis.horizontal,
    );
    expect(horizontalScroll, findsOneWidget);
    expect(
      find.descendant(of: horizontalScroll, matching: find.text('Groceries')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: horizontalScroll, matching: find.text('Restaurants')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: horizontalScroll, matching: find.text('Delivery')),
      findsOneWidget,
    );
  });

  testWidgets(
      'Issue #33: unlinked bank accounts appear in spendableAccounts and AddTransactionScreen; linked banks are represented by their card',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final unlinkedBank = Account(
      id: 'bank_upi',
      name: 'HDFC UPI Bank',
      type: 'bank',
      balance: 5000.0,
      currency: 'USD',
      colorValue: 0xFF1976D2,
    );
    final creditLinkedBank = Account(
      id: 'bank_credit_linked',
      name: 'Chase Bank',
      type: 'bank',
      balance: 4000.0,
      currency: 'USD',
      colorValue: 0xFF00838F,
    );
    final creditCard = Account(
      id: 'card_credit',
      name: 'Chase Credit',
      type: 'credit',
      balance: -200.0,
      currency: 'USD',
      colorValue: 0xFF00838F,
      linkedAccountId: 'bank_credit_linked',
    );
    final linkedBank = Account(
      id: 'bank_linked',
      name: 'Citi Bank',
      type: 'bank',
      balance: 3000.0,
      currency: 'USD',
      colorValue: 0xFF388E3C,
    );
    final debitCard = Account(
      id: 'card_debit',
      name: 'Citi Debit',
      type: 'debit',
      balance: 0.0,
      currency: 'USD',
      colorValue: 0xFF388E3C,
      linkedAccountId: 'bank_linked',
    );
    final goldAcc = Account(
      id: 'acc_gold',
      name: 'Gold Vault',
      type: 'gold',
      balance: 0.0,
      currency: 'USD',
      colorValue: 0xFFB8860B,
    );

    provider.accounts = [
      unlinkedBank,
      creditLinkedBank,
      creditCard,
      linkedBank,
      debitCard,
      goldAcc,
    ];

    expect(
      provider.spendableAccounts.map((a) => a.id),
      containsAll(['bank_upi', 'bank_credit_linked', 'card_credit', 'card_debit']),
    );
    expect(provider.spendableAccounts.map((a) => a.id), isNot(contains('bank_linked')));
    expect(provider.spendableAccounts.map((a) => a.id), isNot(contains('acc_gold')));

    await tester.pumpWidget(
      wrap(const AddTransactionScreen(initialType: 'expense')),
    );
    await tester.pumpAndSettle();

    expect(find.text('HDFC UPI Bank'), findsOneWidget);
    expect(find.text('Chase Bank'), findsOneWidget);
    expect(find.text('Chase Credit'), findsOneWidget);
    expect(find.text('Citi Debit'), findsOneWidget);
    expect(find.text('Citi Bank'), findsNothing);
  });

  testWidgets('TransactionsScreen add menu opens inside a single SheetShell container',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(wrap(const TransactionsScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(SheetShell), findsOneWidget);
    expect(find.text('Expense'), findsAtLeastNWidgets(1));
    expect(find.text('Income'), findsAtLeastNWidgets(1));
    expect(find.text('Transfer'), findsAtLeastNWidgets(1));
  });

  testWidgets('LendedPersonScreen uses ExpandableFab with Lent & Borrowed options',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final person = LendedPerson(
      id: 'person_1',
      name: 'Alex',
      colorValue: 0xFF1976D2,
    );
    final bank = Account(
      id: 'bank_1',
      name: 'Main Bank',
      type: 'bank',
      balance: 1000.0,
      currency: 'USD',
      colorValue: 0xFF1976D2,
    );
    provider.lendedPeople = [person];
    provider.accounts = [bank];

    await tester.pumpWidget(wrap(LendedPersonScreen(person: person)));
    await tester.pumpAndSettle();

    expect(find.byType(ExpandableFab), findsOneWidget);

    // Open ExpandableFab
    await tester.tap(find.byIcon(Icons.add_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Lent'), findsOneWidget);
    expect(find.text('Borrowed'), findsOneWidget);

    // Tap Borrowed -> opens _EntrySheet pre-selected to borrowed
    await tester.tap(find.text('Borrowed'));
    await tester.pumpAndSettle();

    expect(find.byType(SheetShell), findsOneWidget);
    expect(find.byType(TypeToggleChips), findsOneWidget);
    final toggle = tester.widget<TypeToggleChips>(find.byType(TypeToggleChips));
    expect(toggle.selectedValue, 'borrowed');
    expect(find.text('Main Bank'), findsOneWidget);
  });

  testWidgets('AccountsScreen.openSheet(isCard: false) defaults to Bank, not Credit Card',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      wrap(
        Scaffold(
          body: Builder(
            builder: (ctx) => TextButton(
              onPressed: () => AccountsScreen.openSheet(ctx, isCard: false),
              child: const Text('Open Account Sheet'),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Open Account Sheet'));
    await tester.pumpAndSettle();

    expect(find.text('Add New Account'), findsAtLeastNWidgets(1));
    expect(find.text('Initial Balance'), findsOneWidget);
    expect(find.text('Credit Limit (Optional)'), findsNothing);
  });

  testWidgets('Credit card shows Available Credit inside AccountCardPicker when creditLimit > 0',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final creditWithLimit = Account(
      id: 'cc_limit',
      name: 'Sapphire Reserve',
      type: 'credit',
      balance: -200.0,
      creditLimit: 5000.0,
      currency: 'USD',
      colorValue: 0xFF1976D2,
    );
    final creditNoLimit = Account(
      id: 'cc_nolimit',
      name: 'Legacy Credit',
      type: 'credit',
      balance: -150.0,
      currency: 'USD',
      colorValue: 0xFF00838F,
    );
    provider.accounts = [creditWithLimit, creditNoLimit];

    expect(creditWithLimit.availableCredit, closeTo(4800.0, 0.001));
    expect(provider.getPickerDisplayBalance(creditWithLimit), closeTo(4800.0, 0.001));
    expect(provider.getPickerDisplayBalance(creditNoLimit), closeTo(-150.0, 0.001));

    await tester.pumpWidget(
      wrap(const AddTransactionScreen(initialType: 'expense')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Sapphire Reserve'), findsOneWidget);
    expect(find.textContaining('4,800'), findsOneWidget);
    expect(find.text('Legacy Credit'), findsOneWidget);
    expect(find.textContaining('150.00'), findsOneWidget);
  });
}
