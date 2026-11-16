// test/audit_p1_backup_concurrency_test.dart
// note: Regression test suite for Phase 2 (Concurrency & Integrity B1–B4, B10) and Phase 3 (Backup & Restore Hardening B5–B9, B13).

import 'dart:convert';
import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/services/backup_builder.dart';
import 'package:expensy/services/backup_encryption_service.dart';
import 'package:expensy/services/backup_validator.dart';
import 'package:expensy/services/recurring_payment_processor.dart';
import 'package:flutter_test/flutter_test.dart';
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
    await provider.load();
  });

  tearDown(() async {
    await db.close();
    AppDatabase.setInstanceForTesting(null);
  });

  group('B1, B2, B3 — Concurrency, atomic account updates, and atomic splits', () {
    test('B1: updateAccount applies balance changes via atomic SQL delta inside mutex', () async {
      final acc = Account(
        id: 'acc-atomic',
        name: 'Original Name',
        type: 'bank',
        balance: 1000.0,
        colorValue: 0xFF1565C0,
        currency: 'EGP',
      );
      await provider.addAccount(acc);

      // Update account name and opening balance (+500 delta) concurrently with a transaction (-200)
      final f1 = provider.updateAccount(
        acc.copyWith(name: 'Renamed Bank', balance: 1500.0),
      );
      final f2 = provider.addTransaction(
        AppTransaction(
          id: 'tx-conc',
          type: 'expense',
          amount: 200.0,
          description: 'Concurrent Expense',
          accountId: acc.id,
          categoryId: 'food',
          date: DateTime(2026, 10, 20),
          currency: 'EGP',
        ),
      );
      await Future.wait([f1, f2]);

      final updated = provider.accountById(acc.id)!;
      expect(updated.name, 'Renamed Bank');
      // 1000 + 500 (account delta) - 200 (tx delta) = 1300
      expect(updated.balance, closeTo(1300.0, 0.01));
    });

    test('B2 & B3: addTransaction with splits and deleteAccountWithUndo preserve splits atomically', () async {
      final acc = Account(
        id: 'acc-splits',
        name: 'Split Account',
        type: 'bank',
        balance: 2000.0,
        colorValue: 0xFF1565C0,
        currency: 'EGP',
      );
      await provider.addAccount(acc);

      final tx = AppTransaction(
        id: 'tx-split-1',
        type: 'expense',
        amount: 300.0,
        description: 'Supermarket Split',
        accountId: acc.id,
        categoryId: 'def_food',
        date: DateTime(2026, 10, 21),
        currency: 'EGP',
      );
      final txSplits = [
        TransactionSplit(
          id: 'sp-1',
          transactionId: tx.id,
          categoryId: 'def_food',
          amount: 200.0,
          note: 'Food part',
        ),
        TransactionSplit(
          id: 'sp-2',
          transactionId: tx.id,
          categoryId: 'def_shopping',
          amount: 100.0,
          note: 'Household part',
        ),
      ];

      await provider.addTransaction(tx, splits: txSplits);
      expect(provider.isTransactionSplit(tx.id), isTrue);
      expect(provider.getSplits(tx.id).length, 2);

      // Delete account with undo -> cascades tx & splits, then undo restores all
      final undo = await provider.deleteAccountWithUndo(acc.id);
      expect(provider.accountById(acc.id), isNull);
      expect(provider.isTransactionSplit(tx.id), isFalse);

      undo();
      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(provider.accountById(acc.id), isNotNull);
      expect(provider.isTransactionSplit(tx.id), isTrue);
      expect(provider.getSplits(tx.id).length, 2);
    });
  });

  group('B5 — Encrypted backup round-trip and wrong-password rejection', () {
    test('Creates encrypted backup, rejects missing/wrong password, and restores with correct password', () async {
      await provider.addAccount(
        Account(
          id: 'acc-enc',
          name: 'Vault Account',
          type: 'bank',
          balance: 7777.0,
          colorValue: 0xFF1565C0,
          currency: 'EGP',
        ),
      );

      final artifact = await BackupBuilder.build(
        settingsJson: provider.settings.toJson(),
        password: 'CorrectHorseBatteryStaple',
        namePrefix: 'test_enc',
      );
      expect(artifact.fileName.endsWith('.enc'), isTrue);
      expect(BackupEncryptionService.isEncrypted(artifact.bytes), isTrue);

      // Wipe account
      await provider.deleteAccount('acc-enc');
      expect(provider.accountById('acc-enc'), isNull);

      // 1. Missing password throws NEEDS_PASSWORD
      await expectLater(
        provider.parseBackupBytes(artifact.bytes, extension: 'enc'),
        throwsA(
          predicate((e) => e is FormatException && e.message == 'NEEDS_PASSWORD'),
        ),
      );

      // 2. Wrong password throws FormatException and does not mutate DB
      await expectLater(
        provider.parseBackupBytes(
          artifact.bytes,
          password: 'WrongPassword123',
          extension: 'enc',
        ),
        throwsA(isA<FormatException>()),
      );
      expect(provider.accountById('acc-enc'), isNull);

      // 3. Correct password decrypts and restores
      final parsed = await provider.parseBackupBytes(
        artifact.bytes,
        password: 'CorrectHorseBatteryStaple',
        extension: 'enc',
      );
      await provider.restoreBackupData(parsed);

      final restored = provider.accountById('acc-enc');
      expect(restored, isNotNull);
      expect(restored!.balance, closeTo(7777.0, 0.01));
    });
  });

  group('B7, B8, B13 — Selective restore system categories, net_worth_snapshots, and schema version', () {
    test('B7: Selective categories restore preserves sys_transfer and sys_investment', () async {
      final selectivePayload = {
        'version': AppDatabase.currentSchemaVersion,
        'selective': true,
        'categories': [
          {
            'id': 'custom_cat',
            'name': 'Custom Dining',
            'type': 'expense',
            'color_value': 0xFF1565C0,
            'icon_code_point': 0,
            'order_index': 0,
          }
        ],
      };

      await provider.restoreSelective(selectivePayload, {'categories'});
      final catIds = provider.categories.map((c) => c.id).toSet();
      expect(catIds.contains('custom_cat'), isTrue);
      expect(catIds.contains('sys_transfer'), isTrue);
      expect(catIds.contains('sys_investment'), isTrue);
    });

    test('B8 & B13: exportAll and importAll include net_worth_snapshots (18 tables) and unified schema version', () async {
      expect(
        BackupValidator.currentSchemaVersion,
        equals(AppDatabase.currentSchemaVersion),
      );
      expect(
        provider.schemaVersion,
        equals(AppDatabase.currentSchemaVersion),
      );
      expect(AppDatabase.backupTables.length, 18);
      expect(AppDatabase.backupTables.contains('net_worth_snapshots'), isTrue);

      await db.insertNetWorthSnapshot(
        NetWorthSnapshot(
          id: 'snap-1',
          date: '2026-10-01',
          totalAccounts: 5000,
          totalAssets: 1000,
          netWorth: 6000,
          currency: 'EGP',
        ),
      );

      final exported = await db.exportAll();
      expect(exported.containsKey('net_worth_snapshots'), isTrue);
      expect((exported['net_worth_snapshots'] as List), isNotEmpty);

      // Re-import and verify snapshot survives
      final jsonRoundtrip =
          jsonDecode(jsonEncode(exported)) as Map<String, dynamic>;
      await provider.restoreBackupData(jsonRoundtrip);
      expect(
        provider.netWorthSnapshots.any((s) => s.date == '2026-10-01'),
        isTrue,
      );
    });
  });

  group('B10 — Recurring manual markRecurringPaid idempotency after auto-pay', () {
    test('markRecurringPaid is a no-op if the cycle occurrence was already paid by auto-pay', () async {
      final bank = Account(
        id: 'acc-rec',
        name: 'Recurring Bank',
        type: 'bank',
        balance: 1000.0,
        colorValue: 0xFF1565C0,
        currency: 'EGP',
      );
      await provider.addAccount(bank);

      final today = DateTime.now();
      final dueToday = DateTime(today.year, today.month, today.day);
      final rec = RecurringPayment(
        id: 'rec-netflix',
        name: 'Netflix',
        accountId: bank.id,
        categoryId: 'def_entertain',
        amount: 200.0,
        freqVal: 1,
        freqUnit: 'months',
        startDate: dueToday,
        nextDate: dueToday,
        autoPayEnabled: true,
        autoPayTime: '00:00',
      );
      await db.insertRecurring(rec);
      provider.recurring = await db.getRecurring();

      // 1. Auto-pay runs for today
      final processor = RecurringPaymentProcessor(db);
      final processed = await processor.processDuePayments(
        nowOverride: DateTime(today.year, today.month, today.day, 10, 0),
        defaultCurrency: 'EGP',
      );
      expect(processed, contains(rec.id));
      await provider.load();
      expect(provider.accountById(bank.id)!.balance, closeTo(800.0, 0.01));

      // 2. User manually invokes markRecurringPaid for the same occurrence date (stale UI tap)
      await provider.markRecurringPaid(rec, occurrenceDate: dueToday);

      // Must NOT double-debit the account or create a second transaction
      expect(provider.accountById(bank.id)!.balance, closeTo(800.0, 0.01));
      final recTxs = provider.transactions
          .where((t) => t.description.contains('Netflix'))
          .toList();
      expect(recTxs.length, 1);
    });
  });
}
