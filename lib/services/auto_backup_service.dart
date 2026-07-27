import 'dart:convert';
import 'dart:typed_data';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_storage/shared_storage.dart' as saf;
import '../database/db_helper.dart';

class AutoBackupService {
  static const int backupAlarmId = 999;
  static const String backupUriPrefKey = 'auto_backup_uri';
  static const String backupEnabledPrefKey = 'auto_backup_enabled';

  static Future<void> initialize() async {
    await AndroidAlarmManager.initialize();
  }

  static Future<bool> isEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(backupEnabledPrefKey) ?? false;
  }

  static Future<void> enable(String uriStr) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(backupUriPrefKey, uriStr);
    await prefs.setBool(backupEnabledPrefKey, true);
    
    // Calculate initial delay until next 2:00 AM
    final now = DateTime.now();
    DateTime next2Am = DateTime(now.year, now.month, now.day, 2, 0);
    if (now.isAfter(next2Am)) {
      next2Am = next2Am.add(const Duration(days: 1));
    }
    
    await AndroidAlarmManager.periodic(
      const Duration(days: 1),
      backupAlarmId,
      _backupCallback,
      startAt: next2Am,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }

  static Future<void> disable() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(backupEnabledPrefKey, false);
    await AndroidAlarmManager.cancel(backupAlarmId);
  }

  @pragma('vm:entry-point')
  static Future<void> _backupCallback() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool(backupEnabledPrefKey) ?? false;
    final uriStr = prefs.getString(backupUriPrefKey);
    
    if (!enabled || uriStr == null) return;
    
    try {
      final data = await DBHelper.exportAll();
      final settings = {
        'userName': prefs.getString('user_name') ?? 'User',
        'currency': prefs.getString('currency') ?? '\$',
        'themeMode': prefs.getString('theme_mode') ?? 'system',
        'accentColor': prefs.getInt('accent_color'),
        'onboarded': prefs.getBool('onboarded') ?? true,
      };
      data['settings'] = settings;
      
      final json = const JsonEncoder.withIndent('  ').convert(data);
      final bytes = Uint8List.fromList(utf8.encode(json));
      final ts = DateTime.now().millisecondsSinceEpoch;
      
      final uri = Uri.parse(uriStr);
      await saf.createFile(
        uri,
        mimeType: 'application/json',
        displayName: 'expensy_autobackup_${ts}.json',
        bytes: bytes,
      );
    } catch (e) {
      // Background isolate, can't show UI.
      print('Auto Backup failed: $e');
    }
  }
}
