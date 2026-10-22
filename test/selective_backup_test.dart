import 'package:flutter_test/flutter_test.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/database/db_helper.dart';
import 'package:expensy/models/models.dart';
import 'package:drift/native.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    AppDatabase.setInstanceForTesting(db);

    await db.insertAccount(Account(
      id: 'acc1',
      name: 'Checking Account',
      type: 'bank',
      currency: 'USD',
      balance: 1500.0,
      colorValue: 0xFF123456,
    ));

    await db.insertCategory(AppCategory(
      id: 'cat1',
      name: 'Groceries',
      type: 'expense',
      colorValue: 0xFF654321,
    ));

    await db.insertTransaction(AppTransaction(
      id: 'tx1',
      description: 'Supermarket',
      amount: 50.0,
      type: 'expense',
      date: DateTime.now(),
      accountId: 'acc1',
      categoryId: 'cat1',
    ));

    await db.insertCertificate(Certificate(
      id: 'cert1',
      name: 'High Yield CD',
      amount: 10000.0,
      currency: 'USD',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 365)),
      interestRate: 5.5,
      collectionType: 'monthly',
      collectionDay: 1,
      accountId: 'acc1',
    ));
  });

  tearDown(() async {
    await db.close();
    AppDatabase.setInstanceForTesting(null);
  });

  test('DBHelper.exportSelective only exports the requested tables', () async {
    final exportData = await DBHelper.exportSelective({'accounts', 'certificates'});

    expect(exportData.containsKey('accounts'), isTrue);
    expect(exportData.containsKey('certificates'), isTrue);
    expect(exportData.containsKey('categories'), isFalse);
    expect(exportData.containsKey('transactions'), isFalse);

    final accountsList = exportData['accounts'] as List;
    expect(accountsList.length, 1);
    expect(accountsList.first['name'], 'Checking Account');

    final certsList = exportData['certificates'] as List;
    expect(certsList.length, 1);
    expect(certsList.first['name'], 'High Yield CD');
  });

  test('DBHelper.importSelective only updates specified tables without touching others', () async {
    // Current state: 1 account, 1 category, 1 transaction, 1 certificate
    final payload = {
      'categories': [
        {
          'id': 'cat_new',
          'name': 'Dining Out',
          'type': 'expense',
          'color_value': 0xFF999999,
          'icon_code_point': 0,
          'order_index': 0,
        }
      ],
      'accounts': [
        {
          'id': 'acc_should_not_import',
          'name': 'Ignored Account',
          'type': 'cash',
          'currency': 'EUR',
          'balance': 999.0,
          'color': 0,
          'created_at': DateTime.now().toIso8601String(),
        }
      ]
    };

    // Restore ONLY categories
    await DBHelper.importSelective(payload, {'categories'});

    // 1. Categories should now only have the imported category
    final cats = await db.getCategories();
    expect(cats.length, 1);
    expect(cats.first.name, 'Dining Out');

    // 2. Accounts should still have the original account untouched
    final accs = await db.getAccounts();
    expect(accs.length, 1);
    expect(accs.first.id, 'acc1');
    expect(accs.first.name, 'Checking Account');

    // 3. Transactions should remain untouched
    final txs = await db.getTransactions();
    expect(txs.length, 1);
    expect(txs.first.description, 'Supermarket');

    // 4. Certificates should remain untouched
    final certs = await db.getCertificates();
    expect(certs.length, 1);
    expect(certs.first.name, 'High Yield CD');
  });
}
