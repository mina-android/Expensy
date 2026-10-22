// lib/services/backup_encryption_service.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';

class BackupEncryptionService {
  static const String magicHeader = 'EXPENSY_ENC_V1';

  static final _pbkdf2 = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: 100000,
    bits: 256,
  );

  static final _aesGcm = AesGcm.with256bits();

  /// Determines if raw bytes represent an encrypted Expensy backup file.
  static bool isEncrypted(List<int> bytes) {
    if (bytes.length < magicHeader.length) return false;
    final prefix =
        utf8.decode(bytes.sublist(0, magicHeader.length), allowMalformed: true);
    return prefix == magicHeader;
  }

  /// Encrypts plaintext [jsonStr] using [password] with PBKDF2 (100k rounds) + AES-GCM-256.
  /// Binary format:
  /// [magicHeader: 14 bytes ASCII]
  /// [salt: 16 bytes]
  /// [nonce/iv: 12 bytes]
  /// [ciphertext + 16 bytes auth tag]
  static Future<Uint8List> encrypt({
    required String jsonStr,
    required String password,
  }) async {
    final saltKey = await _aesGcm.newSecretKey();
    final salt = (await saltKey.extractBytes()).sublist(0, 16);
    final derivedSecretKey = await _pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(password)),
      nonce: salt,
    );

    final clearBytes = utf8.encode(jsonStr);
    final secretBox = await _aesGcm.encrypt(
      clearBytes,
      secretKey: derivedSecretKey,
    );

    final headerBytes = utf8.encode(magicHeader);
    final builder = BytesBuilder(copy: false);
    builder.add(headerBytes);
    builder.add(salt);
    builder.add(secretBox.nonce);
    builder.add(secretBox.cipherText);
    builder.add(secretBox.mac.bytes);

    return builder.takeBytes();
  }

  /// Decrypts encrypted backup bytes using [password]. Throws [FormatException] if password or payload is invalid.
  static Future<String> decrypt({
    required List<int> bytes,
    required String password,
  }) async {
    final headerLength = magicHeader.length;
    if (bytes.length < headerLength + 16 + 12 + 16) {
      throw const FormatException('File is corrupted or too short.');
    }

    final header =
        utf8.decode(bytes.sublist(0, headerLength), allowMalformed: true);
    if (header != magicHeader) {
      throw const FormatException('Invalid or unrecognized backup format.');
    }

    int offset = headerLength;
    final salt = bytes.sublist(offset, offset + 16);
    offset += 16;

    final nonce = bytes.sublist(offset, offset + 12);
    offset += 12;

    final macLength = 16;
    final cipherTextLength = bytes.length - offset - macLength;
    if (cipherTextLength <= 0) {
      throw const FormatException('Corrupted encrypted backup.');
    }

    final cipherText = bytes.sublist(offset, offset + cipherTextLength);
    final macBytes = bytes.sublist(bytes.length - macLength);

    final derivedSecretKey = await _pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(password)),
      nonce: salt,
    );

    final secretBox = SecretBox(
      cipherText,
      nonce: nonce,
      mac: Mac(macBytes),
    );

    try {
      final decryptedBytes = await _aesGcm.decrypt(
        secretBox,
        secretKey: derivedSecretKey,
      );
      return utf8.decode(decryptedBytes);
    } catch (_) {
      throw const FormatException(
          'Incorrect password or corrupted backup file.');
    }
  }
}
