// lib/services/workmanager_service.dart
import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart';
import '../models/models.dart';

const String autoPayTaskKey = 'com.ma.expensy.autoPayTask';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      if (task == autoPayTaskKey) {
        final db = AppDatabase.instance;
        final recurring = await db.getRecurring();
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        const uuid = Uuid();

        for (final r in recurring) {
          if (!r.autoPayEnabled) continue;
          if (r.endDate != null && r.nextDate.isAfter(r.endDate!)) continue;

          final dueDate =
              DateTime(r.nextDate.year, r.nextDate.month, r.nextDate.day);
          if (dueDate.isBefore(today) || dueDate.isAtSameMomentAs(today)) {
            final t = AppTransaction(
              id: uuid.v4(),
              type: r.paymentType,
              amount: r.amount,
              description: '${r.name} (recurring)',
              accountId: r.accountId,
              categoryId: r.categoryId,
              date: r.nextDate,
            );
            final delta = r.paymentType == 'income' ? r.amount : -r.amount;
            await db.applyTransactionWithBalance(t, delta);

            final updated = RecurringPayment(
              id: r.id,
              name: r.name,
              accountId: r.accountId,
              categoryId: r.categoryId,
              amount: r.amount,
              paymentType: r.paymentType,
              freqVal: r.freqVal,
              freqUnit: r.freqUnit,
              startDate: r.startDate,
              nextDate: r.calcNextDate(),
              endDate: r.endDate,
              paidPayments: r.paidPayments + 1,
              reminderEnabled: r.reminderEnabled,
              reminderTime: r.reminderTime,
              earlyReminderEnabled: r.earlyReminderEnabled,
              notes: r.notes,
              recurringType: r.recurringType,
              autoPayEnabled: r.autoPayEnabled,
              autoPayTime: r.autoPayTime,
            );
            await db.updateRecurring(updated);
          }
        }
      }
      return true;
    } catch (e) {
      debugPrint('Workmanager autoPayTask error: $e');
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
