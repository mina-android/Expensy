// test/net_worth_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/screens/net_worth_screen.dart';
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

  group('Net Worth Database & Snapshots Tests', () {
    test('insertNetWorthSnapshot saves and replaces snapshot by date', () async {
      const snap1 = NetWorthSnapshot(
        id: 'snap_1',
        date: '2026-09-24',
        totalAccounts: 5000.0,
        totalAssets: 10000.0,
        netWorth: 15000.0,
        currency: 'USD',
      );

      await db.insertNetWorthSnapshot(snap1);

      final fetched1 = await db.getNetWorthSnapshotForDate('2026-09-24');
      expect(fetched1, isNotNull);
      expect(fetched1!.netWorth, 15000.0);
      expect(fetched1.totalAccounts, 5000.0);

      // Re-insert with updated values for same date
      const snap2 = NetWorthSnapshot(
        id: 'snap_1',
        date: '2026-09-24',
        totalAccounts: 5200.0,
        totalAssets: 10000.0,
        netWorth: 15200.0,
        currency: 'USD',
      );
      await db.insertNetWorthSnapshot(snap2);

      final fetched2 = await db.getNetWorthSnapshotForDate('2026-09-24');
      expect(fetched2, isNotNull);
      expect(fetched2!.netWorth, 15200.0);
      expect(fetched2.totalAccounts, 5200.0);

      final allSnaps = await db.getNetWorthSnapshots();
      expect(allSnaps.length, 1);
    });

    test('getNetWorthSnapshots orders by date ascending', () async {
      await db.insertNetWorthSnapshot(const NetWorthSnapshot(
        id: 's2',
        date: '2026-09-20',
        totalAccounts: 4000,
        totalAssets: 5000,
        netWorth: 9000,
        currency: 'USD',
      ));
      await db.insertNetWorthSnapshot(const NetWorthSnapshot(
        id: 's1',
        date: '2026-09-10',
        totalAccounts: 3000,
        totalAssets: 5000,
        netWorth: 8000,
        currency: 'USD',
      ));

      final all = await db.getNetWorthSnapshots();
      expect(all.length, 2);
      expect(all.first.date, '2026-09-10');
      expect(all.last.date, '2026-09-20');
    });
  });

  group('Net Worth Calculation & Wealth Engine Tests', () {
    test('AppProvider computes accurate Assets, Liabilities, and Net Worth', () {
      final app = AppProvider();

      // Configure accounts
      app.accounts = [
        Account(id: 'a1', name: 'Bank', type: 'bank', balance: 5000, colorValue: 0xFF000000, currency: 'USD'),
        Account(id: 'a2', name: 'Cash', type: 'cash', balance: 1000, colorValue: 0xFF000000, currency: 'USD'),
        Account(id: 'a3', name: 'Gold Holding', type: 'gold', balance: 2500, colorValue: 0xFF000000, currency: 'USD'),
        Account(id: 'a4', name: 'Credit Card', type: 'credit', balance: -800, colorValue: 0xFF000000, currency: 'USD'),
      ];

      // Configure assets
      app.assets = [
        AssetItem(id: 'ast1', name: 'Vehicle', value: 15000, currency: 'USD', createdAt: DateTime.now()),
      ];

      // Configure lended money (Alice owes user 400, user owes Bob 300)
      app.lended = [
        LendedMoney(
          id: 'lm1',
          personId: 'p1',
          amount: 400,
          type: 'lent',
          isSettled: false,
          date: DateTime.now(),
        ),
        LendedMoney(
          id: 'lm2',
          personId: 'p2',
          amount: 300,
          type: 'borrowed',
          isSettled: false,
          date: DateTime.now(),
        ),
      ];

      // Configure loans (Loan remaining is 2000)
      app.loans = [
        Loan(
          id: 'l1',
          name: 'Home Loan',
          principal: 2000,
          currency: 'USD',
          startDate: DateTime(2026, 1, 1),
          endDate: DateTime(2026, 12, 31),
        ),
      ];
      app.loanPayments = []; // 0 paid, so remaining = 2000

      // Assets check:
      // Liquid Accounts: 5000 + 1000 = 6000
      // Gold: 2500
      // Fixed Assets: 15000
      // Lent: 400
      // Total Wealth Assets = 6000 + 2500 + 15000 + 400 = 23900
      expect(app.totalLiquidAccountsValue, 6000.0);
      expect(app.totalGoldValue, 2500.0);
      expect(app.totalAssetsValue, 15000.0);
      expect(app.totalLentMoneyValue, 400.0);
      expect(app.totalWealthAssets, 23900.0);

      // Liabilities check:
      // Credit card / Overdraft debt: 800
      // Outstanding Loans: 2000
      // Borrowed money: 300
      // Total Wealth Liabilities = 800 + 2000 + 300 = 3100
      expect(app.totalDebtAccounts, 800.0);
      expect(app.totalOutstandingLoanDebt, 2000.0);
      expect(app.totalBorrowedMoneyValue, 300.0);
      expect(app.totalWealthLiabilities, 3100.0);

      // Net Worth check:
      // 23900 - 3100 = 20800
      expect(app.liveNetWorth, 20800.0);
    });
  });

  group('NetWorthScreen Widget Test', () {
    testWidgets('renders NetWorthScreen hero card, trend, and breakdown cards', (tester) async {
      tester.view.physicalSize = const Size(800, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final app = AppProvider();
      app.accounts = [
        Account(id: 'a1', name: 'Checking', type: 'bank', balance: 12000, colorValue: 0xFF000000, currency: 'USD'),
      ];
      app.assets = [
        AssetItem(id: 'ast1', name: 'Artwork', value: 3000, currency: 'USD', createdAt: DateTime.now()),
      ];
      app.loans = [];
      app.lended = [];

      await tester.pumpWidget(
        ChangeNotifierProvider<AppProvider>.value(
          value: app,
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale('en'),
            home: NetWorthScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Check for title and hero text
      expect(find.text('Net Worth'), findsWidgets);
      expect(find.text('CURRENT NET WORTH'), findsOneWidget);
      expect(find.textContaining('15,000'), findsWidgets);
      expect(find.text('Debt-free'), findsOneWidget);
      expect(find.text('Assets Breakdown'), findsOneWidget);
      expect(find.text('Liabilities Breakdown'), findsOneWidget);
      expect(find.text('Cash & Bank Accounts'), findsOneWidget);
    });
  });
}
