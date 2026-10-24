// test/golden_backup_roundtrip_test.dart
// note: Golden test suite verifying restore and round-trip integrity on the 3 real backup files.

import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/services/data_check_service.dart';
import 'package:drift/native.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late AppProvider provider;

  const fixtureDir = 'test/fixtures';

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    db = AppDatabase(NativeDatabase.memory());
    AppDatabase.setInstanceForTesting(db);
    provider = AppProvider();
  });

  tearDown(() async {
    await db.close();
    AppDatabase.setInstanceForTesting(null);
  });

  group('Golden Backup Fixtures Verification', () {
    test('expensy_backup_20261023_102358.json full restore into empty and populated DB', () async {
      final file = File('$fixtureDir/expensy_backup_20261023_102358.json');
      expect(file.existsSync(), isTrue, reason: 'Fixture file must exist in test/fixtures');
      final data = jsonDecode(await file.readAsString()) as Map<String, dynamic>;

      // 1. Restore into empty DB
      final ver = await provider.restoreBackupData(data);
      expect(ver, 27);
      expect(provider.accounts.length, 8);
      expect(provider.transactions.length, 108);
      expect(provider.recurring.length, 14);

      // Verify DataCheckService flags the known findings (D1, D2, D3, D5)
      final report = await DataCheckService(db).runCheck();
      expect(report.hasIssues, isTrue);
      final issueCodes = report.issues.map((i) => i.code).toSet();
      expect(issueCodes.contains('D1'), isTrue); // Legacy transfers
      expect(issueCodes.contains('D2'), isTrue); // Orphan history
      expect(issueCodes.contains('D3'), isTrue); // Positive credit card
      expect(issueCodes.contains('D5'), isTrue); // Stray debit card balance

      // 2. Restore again into populated DB (full overwrite)
      final ver2 = await provider.restoreBackupData(data);
      expect(ver2, 27);
      expect(provider.accounts.length, 8);
      expect(provider.transactions.length, 108);
    });

    test('expensy_auto_20261023_064842.json full restore matches shape', () async {
      final file = File('$fixtureDir/expensy_auto_20261023_064842.json');
      expect(file.existsSync(), isTrue);
      final data = jsonDecode(await file.readAsString()) as Map<String, dynamic>;

      final ver = await provider.restoreBackupData(data);
      expect(ver, 27);
      expect(provider.accounts.length, 7);
      expect(provider.transactions.length, 104);
    });

    test('expensy_selective_backup_20261023_102332.json selective restore', () async {
      final file = File('$fixtureDir/expensy_selective_backup_20261023_102332.json');
      expect(file.existsSync(), isTrue);
      final data = jsonDecode(await file.readAsString()) as Map<String, dynamic>;

      await provider.restoreSelective(data, {'accounts', 'categories', 'recurring', 'assets'});
      expect(provider.accounts.length, 8);
      expect(provider.categories.where((c) => !c.id.startsWith('sys_')).length, 11);
      expect(provider.recurring.length, 14);
      expect(provider.assets.length, 6);
    });

    test('selective file via Full API must refuse, not wipe', () async {
      final file = File('$fixtureDir/expensy_selective_backup_20261023_102332.json');
      expect(file.existsSync(), isTrue);
      final data = jsonDecode(await file.readAsString()) as Map<String, dynamic>;

      expect(() => provider.restoreBackupData(data), throwsA(isA<FormatException>()));
    });
  });
}
