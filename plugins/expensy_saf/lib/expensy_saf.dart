import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';

class SafDirectory {
  final String uri;
  final String name;
  const SafDirectory({required this.uri, required this.name});
}

class SafAccessCheck {
  final bool ok;
  final String reason;
  const SafAccessCheck({required this.ok, required this.reason});
}

class SafFileEntry {
  final String name;
  final String uri;
  final int modified;
  final int size;
  const SafFileEntry({
    required this.name,
    required this.uri,
    required this.modified,
    required this.size,
  });
}

class SafWriteResult {
  final String uri;
  final int size;
  const SafWriteResult({required this.uri, required this.size});
}

class ExpensySaf {
  static const MethodChannel _channel = MethodChannel('com.ma.expensy/saf');

  static Future<SafDirectory?> pickDirectory() async {
    final res = await _channel.invokeMapMethod<String, dynamic>('pickDirectory');
    if (res == null) return null;
    return SafDirectory(
      uri: res['uri'] as String,
      name: res['name'] as String,
    );
  }

  static Future<SafAccessCheck> checkAccess(String uri) async {
    final res = await _channel.invokeMapMethod<String, dynamic>('checkAccess', {'uri': uri});
    return SafAccessCheck(
      ok: res?['ok'] as bool? ?? false,
      reason: res?['reason'] as String? ?? 'unknown',
    );
  }

  static Future<SafWriteResult> writeFile({
    required String treeUri,
    required String name,
    String mime = 'application/octet-stream',
    required Uint8List bytes,
  }) async {
    final res = await _channel.invokeMapMethod<String, dynamic>('writeFile', {
      'treeUri': treeUri,
      'name': name,
      'mime': mime,
      'bytes': bytes,
    });
    if (res == null) {
      throw FileSystemException('SAF writeFile returned empty response');
    }
    return SafWriteResult(
      uri: res['uri'] as String,
      size: res['size'] as int,
    );
  }

  static Future<List<SafFileEntry>> listFiles({
    required String treeUri,
    String prefix = '',
  }) async {
    final res = await _channel.invokeListMethod<Map<dynamic, dynamic>>('listFiles', {
      'treeUri': treeUri,
      'prefix': prefix,
    });
    if (res == null) return [];
    return res.map((item) {
      final map = Map<String, dynamic>.from(item);
      return SafFileEntry(
        name: map['name'] as String? ?? '',
        uri: map['uri'] as String? ?? '',
        modified: (map['modified'] as num?)?.toInt() ?? 0,
        size: (map['size'] as num?)?.toInt() ?? 0,
      );
    }).toList();
  }

  static Future<bool> deleteFile(String uri) async {
    final res = await _channel.invokeMethod<bool>('deleteFile', {'uri': uri});
    return res ?? false;
  }

  static Future<void> releaseDirectory(String uri) async {
    await _channel.invokeMethod<void>('releaseDirectory', {'uri': uri});
  }

  static Future<bool> isSecretStoreAvailable() async {
    final res = await _channel.invokeMethod<bool>('isSecretStoreAvailable');
    return res ?? false;
  }

  static Future<bool> setSecret(String key, String value) async {
    final res = await _channel.invokeMethod<bool>('setSecret', {
      'key': key,
      'value': value,
    });
    return res ?? false;
  }

  static Future<String?> getSecret(String key) async {
    return _channel.invokeMethod<String>('getSecret', {'key': key});
  }

  static Future<void> clearSecret(String key) async {
    await _channel.invokeMethod<void>('clearSecret', {'key': key});
  }
}
