// test/recurring_payment_processor_test.dart
// note: Unit tests for RecurringPaymentProcessor verifying idempotency, race prevention, and card redirection.

import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/services/recurring_payment_processor.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late RecurringPaymentProcessor processor;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    AppDatabase.setInstanceForTesting(db);
    processor = RecurringPaymentProcessor(db);

    // Setup base bank account and debit card
    await db.insertAccount(Account(
      id: 'bank_main',
      name: 'Main Bank',
      type: 'bank',
      balance: 10000.0,
      colorValue: 0xFF1565C0,
    ));

    await db.insertAccount(Account(
      id: 'debit_card_1',
      name: 'Visa Debit',
      type: 'debit',
      balance: 0.0,
      colorValue: 0xFF2E7D32,
      cardNumberLast4: '1234',
      linkedAccountId: 'bank_main',
    ));

    await db.insertCategory(AppCategory(
      id: 'cat_bills',
      name: 'Bills',
      type: 'expense',
      colorValue: 0xFF827717,
    ));
  });

  tearDown(() async {
    await db.close();
    AppDatabase.setInstanceForTesting(null);
  });

  Future<Account?> getAccount(String id) async {
    final accs = await db.getAccounts();
    return accs.where((a) => a.id == id).firstOrNull;
  }

  test('Debit card auto-pay redirects delta to linked bank account', () async {
    final now = DateTime(2026, 10, 23, 10, 0);

    final payment = RecurringPayment(
      id: 'rec_bill',
      name: 'Internet Bill',
      accountId: 'debit_card_1',
      categoryId: 'cat_bills',
      amount: 500.0,
      paymentType: 'expense',
      freqVal: 1,
      freqUnit: 'months',
      startDate: DateTime(2026, 9, 23),
      nextDate: DateTime(2026, 10, 23),
      autoPayEnabled: true,
      autoPayTime: '09:00',
    );
    await db.insertRecurring(payment);

    final processed = await processor.processDuePayments(nowOverride: now);
    expect(processed, contains('rec_bill'));

    // Verify bank balance reduced by 500
    final bank = await getAccount('bank_main');
    expect(bank?.balance, 9500.0);

    // Verify debit card balance remains untouched at 0.0
    final card = await getAccount('debit_card_1');
    expect(card?.balance, 0.0);

    // Verify transaction attribution
    final txs = await db.getTransactions();
    expect(txs.length, 1);
    expect(txs.first.accountId, 'bank_main');
    expect(txs.first.paidViaAccountId, 'debit_card_1');
  });

  test('Racing processors on same payment execute exactly once due to idempotency', () async {
    final now = DateTime(2026, 10, 23, 10, 0);

    final payment = RecurringPayment(
      id: 'rec_race',
      name: 'Streaming Service',
      accountId: 'bank_main',
      categoryId: 'cat_bills',
      amount: 150.0,
      paymentType: 'expense',
      freqVal: 1,
      freqUnit: 'months',
      startDate: DateTime(2026, 9, 23),
      nextDate: DateTime(2026, 10, 23),
      autoPayEnabled: true,
      autoPayTime: '09:00',
    );
    await db.insertRecurring(payment);

    // Run two processors simultaneously
    final p1 = processor.processDuePayments(nowOverride: now);
    final p2 = processor.processDuePayments(nowOverride: now);
    await Future.wait([p1, p2]);

    final txs = await db.getTransactions();
    expect(txs.length, 1);

    final bank = await getAccount('bank_main');
    expect(bank?.balance, 9850.0);

    final history = await db.getRecurringHistory('rec_race');
    expect(history.length, 1);
  });

  test('Time-of-day gating skips payment if autoPayTime has not yet arrived', () async {
    final nowEarly = DateTime(2026, 10, 23, 8, 30); // 08:30 AM

    final payment = RecurringPayment(
      id: 'rec_future',
      name: 'Gym Membership',
      accountId: 'bank_main',
      categoryId: 'cat_bills',
      amount: 300.0,
      paymentType: 'expense',
      freqVal: 1,
      freqUnit: 'months',
      startDate: DateTime(2026, 9, 23),
      nextDate: DateTime(2026, 10, 23),
      autoPayEnabled: true,
      autoPayTime: '10:00',
    );
    await db.insertRecurring(payment);

    final processed = await processor.processDuePayments(nowOverride: nowEarly);
    expect(processed.isEmpty, isTrue);

    final txs = await db.getTransactions();
    expect(txs.isEmpty, isTrue);

    final bank = await getAccount('bank_main');
    expect(bank?.balance, 10000.0);
  });
}
