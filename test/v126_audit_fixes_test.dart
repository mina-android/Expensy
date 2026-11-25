import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/database/db_helper.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/services/backup_validator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    db = AppDatabase(NativeDatabase.memory());
    AppDatabase.setInstanceForTesting(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('v1.2.6 Backup & Migration Fixes', () {
    test('v28+ backup preserves negative credit card balances without re-flipping',
        () async {
      final v28Backup = <String, dynamic>{
        'version': 28,
        'accounts': [
          {
            'id': 'cc1',
            'name': 'Visa Platinum',
            'type': 'credit',
            'currency': 'USD',
            'balance': -1200.0,
            'color_value': 0xFF6750A4,
            'credit_limit': 5000.0,
          },
        ],
        'categories': <Map<String, dynamic>>[],
        'transactions': <Map<String, dynamic>>[],
        'settings': {'currency': 'USD'},
      };

      await DBHelper.importAll(v28Backup);
      final accounts = await DBHelper.getAccounts();
      final cc = accounts.firstWhere((a) => a.id == 'cc1');
      expect(cc.balance, -1200.0);
    });

    test('v27 backup migrates positive credit card balance to negative debt',
        () async {
      final v27Backup = <String, dynamic>{
        'version': 27,
        'accounts': [
          {
            'id': 'cc_old',
            'name': 'Legacy Card',
            'type': 'credit',
            'currency': 'USD',
            'balance': 850.0,
            'color_value': 0xFF6750A4,
            'credit_limit': 3000.0,
          },
        ],
        'categories': <Map<String, dynamic>>[],
        'transactions': <Map<String, dynamic>>[],
        'settings': {'currency': 'USD'},
      };

      await DBHelper.importAll(v27Backup);
      final accounts = await DBHelper.getAccounts();
      final cc = accounts.firstWhere((a) => a.id == 'cc_old');
      expect(cc.balance, -850.0);
    });

    test(
        'selective backup & restore supports net_worth_snapshots and settings',
        () async {
      await db.insertNetWorthSnapshot(const NetWorthSnapshot(
        id: 'nw1',
        date: '2026-10-01',
        totalAccounts: 5000,
        totalAssets: 2000,
        netWorth: 7000,
        currency: 'EUR',
      ));

      final selective = await DBHelper.exportSelective({'net_worth_snapshots'});
      selective['settings'] = {
        'currency': 'EUR',
        'user_name': 'Mina',
        'onboarded': true,
      };

      final validation = BackupValidator.validate(selective);
      expect(validation.isValid, isTrue);
      expect(validation.tableCounts['net_worth_snapshots'], 1);
      expect(validation.tableCounts['settings'], 1);

      await db.delete(db.netWorthSnapshots).go();
      expect((await db.getNetWorthSnapshots()).length, 0);

      await DBHelper.importSelective(selective, {'net_worth_snapshots'});
      final snaps = await db.getNetWorthSnapshots();
      expect(snaps.length, 1);
      expect(snaps.first.netWorth, 7000.0);
      expect(snaps.first.currency, 'EUR');
    });
  });

  group('v1.2.6 Financial Logic & Multi-Currency Fixes', () {
    test('lendedCurrency resolves linked account currency and converts totals',
        () async {
      final app = AppProvider();
      app.settings = AppSettings(currency: 'USD');
      app.exchangeRates = {'USD': 1.0, 'EUR': 0.5}; // 1 EUR = 2 USD

      final eurAcc = Account(
        id: 'acc_eur',
        name: 'Euro Bank',
        type: 'bank',
        currency: 'EUR',
        balance: 1000,
        colorValue: 0xFF6750A4,
      );
      final person = LendedPerson(id: 'p1', name: 'Alex', colorValue: 0xFF6750A4);
      final lentEur = LendedMoney(
        id: 'l1',
        personId: 'p1',
        amount: 100.0,
        type: 'lent',
        accountId: 'acc_eur',
        currency: '',
        date: DateTime(2026, 11, 1),
      );
      app.accounts = [eurAcc];
      app.lendedPeople = [person];
      app.lended = [lentEur];

      expect(app.lendedCurrency(lentEur), 'EUR');
      expect(app.totalLentMoneyValue, closeTo(200.0, 0.01));
      expect(app.personBalance('p1'), closeTo(200.0, 0.01));
    });

    test('nonOverlappingBudgets avoids double-counting parent & child budgets',
        () async {
      final app = AppProvider();
      final parent = AppCategory(
        id: 'cat_food',
        name: 'Food',
        type: 'expense',
        colorValue: 0xFF6750A4,
      );
      final child = AppCategory(
        id: 'cat_coffee',
        name: 'Coffee',
        type: 'expense',
        colorValue: 0xFF6750A4,
        parentId: 'cat_food',
      );
      app.categories = [parent, child];
      app.budgets = [
        Budget(
          id: 'b_parent',
          categoryId: 'cat_food',
          amount: 500,
          period: 'monthly',
          createdAt: DateTime(2026, 11, 1),
        ),
        Budget(
          id: 'b_child',
          categoryId: 'cat_coffee',
          amount: 100,
          period: 'monthly',
          createdAt: DateTime(2026, 11, 1),
        ),
      ];

      final nonOverlap = app.nonOverlappingBudgets;
      expect(nonOverlap.map((b) => b.id).toList(), ['b_parent']);
    });

    test('getEffectiveBalance redirects debit card to linked bank account', () {
      final app = AppProvider();
      final bank = Account(
        id: 'b1',
        name: 'Main Bank',
        type: 'bank',
        currency: 'USD',
        balance: 2500.0,
        colorValue: 0xFF6750A4,
      );
      final debit = Account(
        id: 'd1',
        name: 'My Debit',
        type: 'debit',
        currency: 'USD',
        balance: 0.0,
        linkedAccountId: 'b1',
        colorValue: 0xFF6750A4,
      );
      app.accounts = [bank, debit];

      expect(app.getEffectiveBalance(debit), 2500.0);
    });
  });
}
