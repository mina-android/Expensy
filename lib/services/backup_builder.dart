// lib/services/backup_builder.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import '../database/db_helper.dart';
import 'backup_encryption_service.dart';

class BackupArtifact {
  final Uint8List bytes;
  final String fileName;
  final String mimeType;

  const BackupArtifact({
    required this.bytes,
    required this.fileName,
    required this.mimeType,
  });
}

class BackupBuilder {
  static Future<BackupArtifact> build({
    required Map<String, dynamic> settingsJson,
    String? password,
    String namePrefix = 'expensy_backup',
    DateTime? now,
  }) async {
    final dt = now ?? DateTime.now();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(dt);
    final data = await DBHelper.exportAll();
    data['settings'] = settingsJson;
    data['exported_at'] = dt.toIso8601String();

    final jsonStr = const JsonEncoder.withIndent('  ').convert(data);

    if (password != null && password.isNotEmpty) {
      final encryptedBytes = await BackupEncryptionService.encrypt(
        jsonStr: jsonStr,
        password: password,
      );
      return BackupArtifact(
        bytes: encryptedBytes,
        fileName: '${namePrefix}_$timestamp.enc',
        mimeType: 'application/octet-stream',
      );
    } else {
      final bytes = Uint8List.fromList(utf8.encode(jsonStr));
      return BackupArtifact(
        bytes: bytes,
        fileName: '${namePrefix}_$timestamp.json',
        mimeType: 'application/json',
      );
    }
  }
}
