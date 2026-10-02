// test/splits_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/widgets/split_transaction_sheet.dart';
import 'package:expensy/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('Split Transactions Database & Model Tests', () {
    test('getAllSplits returns all saved splits across transactions', () async {
      const tx1 = 'tx_1';
      const tx2 = 'tx_2';

      await db.saveTransactionSplits(tx1, [
        const TransactionSplit(id: 's1', transactionId: tx1, categoryId: 'food_exp', amount: 25.0),
        const TransactionSplit(id: 's2', transactionId: tx1, categoryId: 'transport', amount: 15.0),
      ]);

      await db.saveTransactionSplits(tx2, [
        const TransactionSplit(id: 's3', transactionId: tx2, categoryId: 'shopping', amount: 60.0),
      ]);

      final all = await db.getAllSplits();
      expect(all.length, 3);
      expect(all.any((s) => s.id == 's1'), isTrue);
      expect(all.any((s) => s.id == 's2'), isTrue);
      expect(all.any((s) => s.id == 's3'), isTrue);
    });
  });

  group('SplitTransactionSheet Widget Tests', () {
    testWidgets('SplitTransactionSheet displays all split categories and amounts', (tester) async {
      final tx = AppTransaction(
        id: 'tx_sheet_1',
        type: 'expense',
        amount: 100.0,
        description: 'Supermarket Run',
        accountId: 'acc_main',
        categoryId: 'food_exp',
        date: DateTime.now(),
      );

      final splits = [
        const TransactionSplit(
          id: 'sp_1',
          transactionId: 'tx_sheet_1',
          categoryId: 'food_exp',
          amount: 70.0,
          note: 'Groceries',
        ),
        const TransactionSplit(
          id: 'sp_2',
          transactionId: 'tx_sheet_1',
          categoryId: 'bills',
          amount: 30.0,
          note: 'Cleaning supplies',
        ),
      ];

      final provider = AppProvider();
      provider.accounts = [
        Account(
          id: 'acc_main',
          name: 'Main Wallet',
          type: 'wallet',
          balance: 500.0,
          currency: 'USD',
          colorValue: 0xFF2E7D32,
          createdAt: DateTime.now(),
        ),
      ];
      provider.categories = [
        AppCategory(id: 'food_exp', name: 'Food & Dining', type: 'expense', colorValue: 0xFFE65100),
        AppCategory(id: 'bills', name: 'Bills & Utilities', type: 'expense', colorValue: 0xFF827717),
      ];
      provider.transactions = [tx];
      provider.splits = splits;

      await tester.pumpWidget(
        ChangeNotifierProvider<AppProvider>.value(
          value: provider,
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: SplitTransactionSheet(
                transaction: tx,
                splits: splits,
                app: provider,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Supermarket Run'), findsOneWidget);
      expect(find.text('Food & Dining'), findsOneWidget);
      expect(find.text('Bills & Utilities'), findsOneWidget);
      expect(find.text('Groceries'), findsOneWidget);
      expect(find.text('Cleaning supplies'), findsOneWidget);
      expect(find.text('70%'), findsOneWidget);
      expect(find.text('30%'), findsOneWidget);
    });
  });
}
