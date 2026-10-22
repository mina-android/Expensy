// lib/services/auto_backup_service.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:expensy_saf/expensy_saf.dart';
import 'backup_builder.dart';

enum BackupTrigger { scheduled, catchUp, manual }

class AutoBackupResult {
  final bool success;
  final String? fileName;
  final int? size;
  final String? error;

  const AutoBackupResult({
    required this.success,
    this.fileName,
    this.size,
    this.error,
  });
}

class AutoBackupState {
  final bool enabled;
  final String folderUri;
  final String folderName;
  final int retention;
  final bool encrypted;
  final int lastSuccessMs;
  final int lastAttemptMs;
  final String lastError;
  final String lastFile;
  final int lastSize;
  final int nextRunMs;

  const AutoBackupState({
    required this.enabled,
    required this.folderUri,
    required this.folderName,
    required this.retention,
    required this.encrypted,
    required this.lastSuccessMs,
    required this.lastAttemptMs,
    required this.lastError,
    required this.lastFile,
    required this.lastSize,
    required this.nextRunMs,
  });

  factory AutoBackupState.fromPrefs(SharedPreferences prefs) {
    return AutoBackupState(
      enabled: prefs.getBool('ab_enabled') ?? false,
      folderUri: prefs.getString('ab_tree_uri') ?? '',
      folderName: prefs.getString('ab_folder_name') ?? '',
      retention: prefs.getInt('ab_retention') ?? 7,
      encrypted: prefs.getBool('ab_encrypted') ?? false,
      lastSuccessMs: prefs.getInt('ab_last_success_ms') ?? 0,
      lastAttemptMs: prefs.getInt('ab_last_attempt_ms') ?? 0,
      lastError: prefs.getString('ab_last_error') ?? '',
      lastFile: prefs.getString('ab_last_file') ?? '',
      lastSize: prefs.getInt('ab_last_size') ?? 0,
      nextRunMs: prefs.getInt('ab_next_run_ms') ?? 0,
    );
  }
}

class AutoBackupService {
  static const String taskKey = 'com.ma.expensy.autoBackupTask';
  static const String secretKey = 'ab_encryption_password';
  static const String channelId = 'expensy_backup';

  /// Computes next 02:00 local time
  static DateTime nextRunAt(DateTime now, {int hour = 2}) {
    final today = DateTime(now.year, now.month, now.day, hour);
    return today.isAfter(now)
        ? today
        : DateTime(now.year, now.month, now.day + 1, hour);
  }

  static Future<void> scheduleNext({bool force = false}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final enabled = prefs.getBool('ab_enabled') ?? false;

    if (!enabled) {
      try {
        await Workmanager().cancelByUniqueName('expensy_auto_backup');
      } catch (_) {}
      return;
    }

    final now = DateTime.now();
    final storedNextMs = prefs.getInt('ab_next_run_ms') ?? 0;
    final storedTzOffset = prefs.getInt('ab_next_run_tz_offset_min') ?? 0;
    final currentTzOffset = now.timeZoneOffset.inMinutes;

    if (!force &&
        storedNextMs > now.millisecondsSinceEpoch &&
        storedTzOffset == currentTzOffset) {
      return;
    }

    final next = nextRunAt(now);
    final delay = next.difference(now);

    try {
      await Workmanager().registerOneOffTask(
        'expensy_auto_backup',
        taskKey,
        initialDelay: delay,
        existingWorkPolicy: ExistingWorkPolicy.replace,
        constraints: Constraints(
          networkType: NetworkType.not_required,
          requiresBatteryNotLow: false,
          requiresStorageNotLow: true,
        ),
        backoffPolicy: BackoffPolicy.exponential,
      );

      await prefs.setInt('ab_next_run_ms', next.millisecondsSinceEpoch);
      await prefs.setInt('ab_next_run_tz_offset_min', currentTzOffset);
    } catch (e) {
      debugPrint('Workmanager scheduleNext error: $e');
    }
  }

  static Future<AutoBackupResult> runNow(BackupTrigger trigger) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    final enabled = prefs.getBool('ab_enabled') ?? false;
    if (!enabled && trigger != BackupTrigger.manual) {
      return const AutoBackupResult(success: false, error: 'disabled');
    }

    // Acquire lock (stale after 10 min)
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final runningSince = prefs.getInt('ab_running_since_ms') ?? 0;
    if (runningSince > 0 && (nowMs - runningSince) < 600000) {
      return const AutoBackupResult(success: false, error: 'already_running');
    }
    await prefs.setInt('ab_running_since_ms', nowMs);
    await prefs.setInt('ab_last_attempt_ms', nowMs);

    try {
      // Skip duplicate scheduled runs if last success was < 20h ago
      final lastSuccessMs = prefs.getInt('ab_last_success_ms') ?? 0;
      if (trigger != BackupTrigger.manual &&
          lastSuccessMs > 0 &&
          (nowMs - lastSuccessMs) < 72000000) {
        await prefs.remove('ab_running_since_ms');
        return const AutoBackupResult(success: true, error: 'recently_completed');
      }

      final treeUri = prefs.getString('ab_tree_uri') ?? '';
      if (treeUri.isEmpty) {
        await _recordError(prefs, 'no_folder_selected', notify: true);
        return const AutoBackupResult(success: false, error: 'no_folder_selected');
      }

      final access = await ExpensySaf.checkAccess(treeUri);
      if (!access.ok) {
        await _recordError(prefs, access.reason, notify: true);
        return AutoBackupResult(success: false, error: access.reason);
      }

      final encrypted = prefs.getBool('ab_encrypted') ?? false;
      String? password;
      if (encrypted) {
        password = await ExpensySaf.getSecret(secretKey);
        if (password == null || password.isEmpty) {
          await _recordError(prefs, 'secret_missing', notify: true);
          return const AutoBackupResult(success: false, error: 'secret_missing');
        }
      }

      // Settings JSON from prefs
      final settingsRaw = prefs.getString('settings');
      final settingsJson = settingsRaw != null
          ? jsonDecode(settingsRaw) as Map<String, dynamic>
          : <String, dynamic>{};

      // Build backup artifact
      final artifact = await BackupBuilder.build(
        settingsJson: settingsJson,
        password: password,
        namePrefix: 'expensy_auto',
      );

      // Write via SAF
      final writeResult = await ExpensySaf.writeFile(
        treeUri: treeUri,
        name: artifact.fileName,
        mime: artifact.mimeType,
        bytes: artifact.bytes,
      );

      // Retention pruning
      final retention = prefs.getInt('ab_retention') ?? 7;
      final files = await ExpensySaf.listFiles(
        treeUri: treeUri,
        prefix: 'expensy_auto_',
      );

      files.sort((a, b) => b.name.compareTo(a.name));
      if (files.length > retention) {
        final toDelete = files.sublist(retention);
        for (final file in toDelete) {
          try {
            await ExpensySaf.deleteFile(file.uri);
          } catch (_) {}
        }
      }

      // Record success
      await prefs.setInt('ab_last_success_ms', DateTime.now().millisecondsSinceEpoch);
      await prefs.setString('ab_last_file', artifact.fileName);
      await prefs.setInt('ab_last_size', writeResult.size);
      await prefs.remove('ab_last_error');
      await prefs.setInt('ab_attempt_count', 0);

      return AutoBackupResult(
        success: true,
        fileName: artifact.fileName,
        size: writeResult.size,
      );
    } catch (e, stack) {
      debugPrint('Auto backup execution failed: $e\n$stack');
      await _recordError(prefs, e.toString(), notify: true);
      return AutoBackupResult(success: false, error: e.toString());
    } finally {
      await prefs.remove('ab_running_since_ms');
      if (trigger == BackupTrigger.scheduled) {
        await scheduleNext(force: true);
      }
    }
  }

  static Future<void> runCatchUpIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final enabled = prefs.getBool('ab_enabled') ?? false;
    if (!enabled) return;

    final now = DateTime.now();
    final today2am = DateTime(now.year, now.month, now.day, 2);

    if (now.isAfter(today2am)) {
      final lastSuccessMs = prefs.getInt('ab_last_success_ms') ?? 0;
      if (lastSuccessMs < today2am.millisecondsSinceEpoch) {
        // Today's 2am backup was missed
        runNow(BackupTrigger.catchUp);
      }
    }

    scheduleNext(force: false);
  }

  static Future<void> _recordError(
    SharedPreferences prefs,
    String error, {
    bool notify = false,
  }) async {
    await prefs.setString('ab_last_error', error);
    final count = (prefs.getInt('ab_attempt_count') ?? 0) + 1;
    await prefs.setInt('ab_attempt_count', count);

    if (notify) {
      _showFailureNotification(error);
    }
  }

  static Future<void> _showFailureNotification(String error) async {
    try {
      final plugin = FlutterLocalNotificationsPlugin();
      const androidDetails = AndroidNotificationDetails(
        channelId,
        'Automatic Backup Alerts',
        channelDescription: 'Notifications for automated backup status and error alerts',
        importance: Importance.high,
        priority: Priority.high,
        icon: 'ic_notification',
      );
      await plugin.show(
        id: 99201,
        title: 'Auto Backup Failed',
        body: 'Expensy was unable to create your scheduled backup: $error',
        notificationDetails: const NotificationDetails(android: androidDetails),
      );
    } catch (e) {
      debugPrint('Notification error in AutoBackupService: $e');
    }
  }
}
