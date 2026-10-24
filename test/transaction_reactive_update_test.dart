import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/screens/home_screen.dart';
import 'package:expensy/screens/transactions_screen.dart';
import 'package:expensy/l10n/app_localizations.dart';
import 'package:drift/native.dart';
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
      id: 'acc_main',
      name: 'Main Bank',
      type: 'bank',
      currency: 'EGP',
      balance: 10000.0,
      colorValue: 0xFF123456,
    );
    await db.insertAccount(bank);

    final cat = AppCategory(
      id: 'cat_groceries',
      name: 'Groceries',
      type: 'expense',
      colorValue: 0xFF43A047,
    );
    await db.insertCategory(cat);

    provider.accounts = [bank];
    provider.categories = [cat];
  });

  tearDown(() async {
    provider.dispose();
    await db.close();
    AppDatabase.setInstanceForTesting(null);
  });

  group('Reactive Collection Immutability & Instance Publication', () {
    test('addTransaction produces a new List instance for transactions', () async {
      final initialTxs = provider.transactions;
      final newTx = AppTransaction(
        id: 'tx_1',
        type: 'expense',
        amount: 250.0,
        description: 'Supermarket',
        accountId: 'acc_main',
        categoryId: 'cat_groceries',
        date: DateTime.now(),
      );

      await provider.addTransaction(newTx);

      expect(identical(initialTxs, provider.transactions), isFalse,
          reason: 'Provider must reassign transactions to a new List on add');
      expect(provider.transactions.length, 1);
      expect(provider.transactions.first.id, 'tx_1');
    });

    test('updateTransaction produces a new List instance for transactions', () async {
      final tx = AppTransaction(
        id: 'tx_update',
        type: 'expense',
        amount: 100.0,
        description: 'Coffee',
        accountId: 'acc_main',
        categoryId: 'cat_groceries',
        date: DateTime.now(),
      );
      await provider.addTransaction(tx);
      final beforeUpdate = provider.transactions;

      final updatedTx = tx.copyWith(amount: 150.0, description: 'Specialty Coffee');
      await provider.updateTransaction(updatedTx, tx);

      expect(identical(beforeUpdate, provider.transactions), isFalse,
          reason: 'Provider must reassign transactions to a new List on update');
      expect(provider.transactions.first.amount, 150.0);
      expect(provider.transactions.first.description, 'Specialty Coffee');
    });

    test('deleteTransaction and undo produce new List instances and update reactively', () async {
      final tx = AppTransaction(
        id: 'tx_del',
        type: 'expense',
        amount: 50.0,
        description: 'Snack',
        accountId: 'acc_main',
        categoryId: 'cat_groceries',
        date: DateTime.now(),
      );
      await provider.addTransaction(tx);
      final beforeDelete = provider.transactions;

      final undo = await provider.deleteTransactionWithUndo('tx_del');

      expect(identical(beforeDelete, provider.transactions), isFalse,
          reason: 'Provider must reassign transactions to a new List on delete');
      expect(provider.transactions.isEmpty, isTrue);

      final beforeUndo = provider.transactions;
      await (undo as dynamic)();

      expect(identical(beforeUndo, provider.transactions), isFalse,
          reason: 'Provider must reassign transactions to a new List on undo');
      expect(provider.transactions.length, 1);
      expect(provider.transactions.first.id, 'tx_del');
    });

    test('patching account balance produces a new List instance for accounts', () async {
      final initialAccounts = provider.accounts;
      final tx = AppTransaction(
        id: 'tx_balance_delta',
        type: 'expense',
        amount: 120.0,
        description: 'Hardware',
        accountId: 'acc_main',
        categoryId: 'cat_groceries',
        date: DateTime.now(),
      );

      await provider.addTransaction(tx);

      expect(identical(initialAccounts, provider.accounts), isFalse,
          reason: 'Provider must reassign accounts on balance patch');
      expect(provider.accounts.first.balance, 10000.0 - 120.0);
    });
  });

  group('Cross-Screen Two-Way Deletion & Sync Widget Tests', () {
    Widget buildTestApp(Widget child) {
      return ChangeNotifierProvider<AppProvider>.value(
        value: provider,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: Scaffold(body: child),
        ),
      );
    }

    testWidgets('TransactionsScreen updates immediately when transaction added/deleted',
        (tester) async {
      await tester.pumpWidget(buildTestApp(const TransactionsScreen()));
      await tester.pump();

      expect(find.text('Reactive Sync Item'), findsNothing);

      final tx = AppTransaction(
        id: 'tx_reactive_sync',
        type: 'expense',
        amount: 80.0,
        description: 'Reactive Sync Item',
        accountId: 'acc_main',
        categoryId: 'cat_groceries',
        date: DateTime.now(),
      );
      await tester.runAsync(() async {
        await provider.addTransaction(tx);
      });
      await tester.pump();

      expect(find.text('Reactive Sync Item'), findsOneWidget);

      await tester.runAsync(() async {
        await provider.deleteTransaction(tx.id);
      });
      await tester.pump();

      expect(find.text('Reactive Sync Item'), findsNothing);
    });

    testWidgets('HomeScreen recent list updates immediately when transaction added/deleted',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestApp(const HomeScreen()));
      await tester.pump();

      expect(find.text('Home Sync Item'), findsNothing);

      final tx = AppTransaction(
        id: 'tx_home_sync',
        type: 'expense',
        amount: 50.0,
        description: 'Home Sync Item',
        accountId: 'acc_main',
        categoryId: 'cat_groceries',
        date: DateTime.now(),
      );
      await tester.runAsync(() async {
        await provider.addTransaction(tx);
      });
      await tester.pump();

      expect(find.text('Home Sync Item'), findsOneWidget);

      await tester.runAsync(() async {
        await provider.deleteTransaction(tx.id);
      });
      await tester.pump();

      expect(find.text('Home Sync Item'), findsNothing);
    });
  });
}
