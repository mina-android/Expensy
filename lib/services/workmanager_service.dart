// lib/services/workmanager_service.dart
// note: Workmanager dispatcher for background tasks: periodic auto-pay and nightly auto-backup.

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import '../database/app_database.dart';
import 'recurring_payment_processor.dart';
import 'auto_backup_service.dart';

const String autoPayTaskKey = 'com.ma.expensy.autoPayTask';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      if (task == autoPayTaskKey) {
        String defaultCurrency = 'EGP';
        try {
          final prefs = await SharedPreferences.getInstance();
          final raw = prefs.getString('settings');
          if (raw != null) {
            final map = jsonDecode(raw) as Map<String, dynamic>;
            final cur = map['currency'] as String?;
            if (cur != null && cur.isNotEmpty) defaultCurrency = cur;
          }
        } catch (_) {}
        final processor = RecurringPaymentProcessor(AppDatabase.instance);
        await processor.processDuePayments(defaultCurrency: defaultCurrency);
        return true;
      } else if (task == AutoBackupService.taskKey) {
        final result = await AutoBackupService.runNow(BackupTrigger.scheduled);
        // Return true when disabled or skipped so WorkManager does not retry-storm
        return result.success || result.skipped;
      }
      return true;
    } catch (e) {
      debugPrint('Workmanager task execution error ($task): $e');
      return false;
    }
  });
}

class WorkmanagerService {
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;
    try {
      await Workmanager().initialize(
        callbackDispatcher,
        isInDebugMode: false,
      );

      // Periodic Auto-Pay task (every 12 hours).
      // Nightly Auto-Backup is scheduled on-demand by AutoBackupService.scheduleNext().
      await Workmanager().registerPeriodicTask(
        'expensy_autopay_periodic',
        autoPayTaskKey,
        frequency: const Duration(hours: 12),
        constraints: Constraints(
          networkType: NetworkType.not_required,
          requiresBatteryNotLow: true,
        ),
      );

      _initialized = true;
    } catch (e) {
      debugPrint('Workmanager initialize error: $e');
    }
  }
}
