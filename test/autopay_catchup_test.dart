// test/autopay_catchup_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late AppProvider provider;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    AppDatabase.setInstanceForTesting(db);
    provider = AppProvider();
  });

  tearDown(() async {
    await db.close();
    AppDatabase.setInstanceForTesting(null);
  });

  test('Auto-pay processes multi-cycle overdue bills with historical occurrence dates', () async {
    final acc = Account(
      id: 'acc_checking',
      name: 'Checking',
      type: 'bank',
      balance: 1000.0,
      currency: 'USD',
      colorValue: 0xFF1565C0,
    );
    await db.insertAccount(acc);
    provider.accounts = [acc];

    final now = DateTime.now();
    // Due 3 cycles ago (e.g. 3 weeks ago)
    final threeWeeksAgo = now.subtract(const Duration(days: 21));

    final rec = RecurringPayment(
      id: 'rec_sub',
      name: 'Cloud Hosting',
      accountId: 'acc_checking',
      categoryId: 'bills',
      amount: 20.0,
      paymentType: 'expense',
      freqVal: 1,
      freqUnit: 'week',
      startDate: threeWeeksAgo,
      nextDate: threeWeeksAgo,
      autoPayEnabled: true,
      autoPayTime: '00:01',
    );
    await db.insertRecurring(rec);
    provider.recurring = [rec];

    // Trigger auto-pay processing
    await provider.checkAndProcessAutoPay();

    final txs = await db.getTransactions();
    // Should have caught up across 3 or 4 elapsed week cycles
    expect(txs.isNotEmpty, isTrue);

    // Verify none of the past catch-up transactions were falsely dated 'now'
    for (final tx in txs) {
      expect(tx.amount, equals(20.0));
      expect(tx.accountId, equals('acc_checking'));
      expect(tx.description, contains('(recurring)'));
      // Occurrence dates should be in the past, matching elapsed cycles
      expect(tx.date.isBefore(now), isTrue);
    }

    // Account balance should have been debited accurately
    final accounts = await db.getAccounts();
    final updatedAcc = accounts.firstWhere((a) => a.id == 'acc_checking');
    expect(updatedAcc.balance, equals(1000.0 - (txs.length * 20.0)));

    // Next date on the recurring item must now be in the future
    final recurringItems = await db.getRecurring();
    final updatedRec = recurringItems.firstWhere((r) => r.id == 'rec_sub');
    expect(updatedRec.nextDate.isAfter(DateTime(now.year, now.month, now.day)), isTrue);

    // Re-running auto-pay immediately should do nothing (idempotent / no double charge)
    final txCountBefore = txs.length;
    await provider.checkAndProcessAutoPay();
    final txCountAfter = (await db.getTransactions()).length;
    expect(txCountAfter, equals(txCountBefore));
  });
}
