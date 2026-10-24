// lib/services/workmanager_service.dart
// note: Workmanager dispatcher for background tasks: periodic auto-pay and nightly auto-backup.

import 'package:flutter/foundation.dart';
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
        final processor = RecurringPaymentProcessor(AppDatabase.instance);
        await processor.processDuePayments();
        return true;
      } else if (task == AutoBackupService.taskKey) {
        final result = await AutoBackupService.runNow(BackupTrigger.scheduled);
        return result.success;
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

      // 1. Periodic Auto-Pay task (every 12 hours)
      await Workmanager().registerPeriodicTask(
        'expensy_autopay_periodic',
        autoPayTaskKey,
        frequency: const Duration(hours: 12),
        constraints: Constraints(
          networkType: NetworkType.not_required,
          requiresBatteryNotLow: true,
        ),
      );

      // 2. Periodic Auto-Backup task (every 24 hours, starting at next 02:00)
      final now = DateTime.now();
      final nextRun = AutoBackupService.nextRunAt(now, hour: 2);
      final initialDelay = nextRun.difference(now);

      await Workmanager().registerPeriodicTask(
        'expensy_auto_backup_periodic',
        AutoBackupService.taskKey,
        frequency: const Duration(hours: 24),
        initialDelay: initialDelay,
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
