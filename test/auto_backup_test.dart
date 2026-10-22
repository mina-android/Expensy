import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:expensy/services/auto_backup_service.dart';
import 'package:expensy/services/backup_encryption_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AutoBackupService.nextRunAt calculation', () {
    test('schedules for 2:00 AM today if current time is before 2:00 AM', () {
      final now = DateTime(2026, 10, 20, 1, 15);
      final next = AutoBackupService.nextRunAt(now);
      expect(next.year, 2026);
      expect(next.month, 10);
      expect(next.day, 20);
      expect(next.hour, 2);
      expect(next.minute, 0);
      expect(next.isAfter(now), isTrue);
    });

    test('schedules for 2:00 AM tomorrow if current time is at or after 2:00 AM', () {
      final now = DateTime(2026, 10, 20, 2, 0);
      final next = AutoBackupService.nextRunAt(now);
      expect(next.year, 2026);
      expect(next.month, 10);
      expect(next.day, 21);
      expect(next.hour, 2);
      expect(next.minute, 0);
      expect(next.isAfter(now), isTrue);
    });

    test('schedules for 2:00 AM tomorrow if current time is late night', () {
      final now = DateTime(2026, 10, 20, 23, 45);
      final next = AutoBackupService.nextRunAt(now);
      expect(next.year, 2026);
      expect(next.month, 10);
      expect(next.day, 21);
      expect(next.hour, 2);
      expect(next.minute, 0);
    });
  });

  group('BackupEncryptionService', () {
    test('encrypts and decrypts payload successfully with correct password', () async {
      const plaintext = '{"version":25,"app":"expensy","tables":{"accounts":[{"id":"1","name":"Main"}]}}';
      const password = 'CorrectPassword123!';

      final encBytes = await BackupEncryptionService.encrypt(
        jsonStr: plaintext,
        password: password,
      );

      expect(BackupEncryptionService.isEncrypted(encBytes), isTrue);
      expect(encBytes.length, greaterThan(plaintext.length));

      final decryptedText = await BackupEncryptionService.decrypt(
        bytes: encBytes,
        password: password,
      );

      expect(decryptedText, equals(plaintext));
    });

    test('fails decryption when given an incorrect password', () async {
      const plaintext = 'Secret Data';

      final encBytes = await BackupEncryptionService.encrypt(
        jsonStr: plaintext,
        password: 'RightPassword',
      );

      expect(
        () async => await BackupEncryptionService.decrypt(
          bytes: encBytes,
          password: 'WrongPassword',
        ),
        throwsA(isA<FormatException>().having(
          (e) => e.message,
          'message',
          contains('Incorrect password'),
        )),
      );
    });

    test('isEncrypted returns false for plain JSON data and throws on decrypt', () async {
      final plainJsonBytes = Uint8List.fromList(utf8.encode('{"version":25}'));
      expect(BackupEncryptionService.isEncrypted(plainJsonBytes), isFalse);

      expect(
        () async => await BackupEncryptionService.decrypt(
          bytes: plainJsonBytes,
          password: 'any',
        ),
        throwsA(isA<FormatException>().having(
          (e) => e.message,
          'message',
          contains('File is corrupted or too short'),
        )),
      );

      final unencryptedLongBytes = Uint8List.fromList(List.filled(100, 65));
      expect(BackupEncryptionService.isEncrypted(unencryptedLongBytes), isFalse);
      expect(
        () async => await BackupEncryptionService.decrypt(
          bytes: unencryptedLongBytes,
          password: 'any',
        ),
        throwsA(isA<FormatException>().having(
          (e) => e.message,
          'message',
          contains('Invalid or unrecognized backup format'),
        )),
      );
    });
  });
}
