import 'package:flutter_test/flutter_test.dart';
import 'package:expensy/services/backup_encryption_service.dart';

void main() {
  group('BackupEncryptionService Tests', () {
    const testJson = '{"accounts":[{"id":"acc1","name":"Test Wallet","balance":1500.0}],"version":26}';
    const testPassword = 'CorrectHorseBatteryStaple123!';

    test('isEncrypted detects unencrypted vs encrypted payloads correctly', () async {
      final unencryptedBytes = testJson.codeUnits;
      expect(BackupEncryptionService.isEncrypted(unencryptedBytes), isFalse);

      final encryptedBytes = await BackupEncryptionService.encrypt(
        jsonStr: testJson,
        password: testPassword,
      );
      expect(BackupEncryptionService.isEncrypted(encryptedBytes), isTrue);
    });

    test('encrypt and decrypt roundtrip restores identical json string', () async {
      final encryptedBytes = await BackupEncryptionService.encrypt(
        jsonStr: testJson,
        password: testPassword,
      );

      final decrypted = await BackupEncryptionService.decrypt(
        bytes: encryptedBytes,
        password: testPassword,
      );

      expect(decrypted, equals(testJson));
    });

    test('decrypt with incorrect password throws FormatException', () async {
      final encryptedBytes = await BackupEncryptionService.encrypt(
        jsonStr: testJson,
        password: testPassword,
      );

      expect(
        () => BackupEncryptionService.decrypt(
          bytes: encryptedBytes,
          password: 'WrongPassword!',
        ),
        throwsA(isA<FormatException>()),
      );
    });

    test('decrypt with corrupted ciphertext or truncated bytes throws FormatException', () async {
      final encryptedBytes = await BackupEncryptionService.encrypt(
        jsonStr: testJson,
        password: testPassword,
      );

      // Corrupt a byte in the middle of ciphertext
      final corrupted = List<int>.from(encryptedBytes);
      corrupted[corrupted.length - 20] ^= 0xFF;

      expect(
        () => BackupEncryptionService.decrypt(
          bytes: corrupted,
          password: testPassword,
        ),
        throwsA(isA<FormatException>()),
      );

      // Truncate bytes
      final truncated = encryptedBytes.sublist(0, 20);
      expect(
        () => BackupEncryptionService.decrypt(
          bytes: truncated,
          password: testPassword,
        ),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
