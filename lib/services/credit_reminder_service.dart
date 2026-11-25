import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import '../models/models.dart';
import '../utils/service_localizations.dart';
import 'date_scheduling.dart';

class CreditReminderService {
  static final CreditReminderService _instance = CreditReminderService._();
  factory CreditReminderService() => _instance;
  CreditReminderService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const _channelId = 'expensy_credit';
  static const _channelName = 'Credit Card Reminders';
  static const _channelDesc = 'Reminders to pay credit card bills';

  Future<void> initialize() async {
    if (_initialized) return;
    try {
      tz_data.initializeTimeZones();
      const androidSettings =
          AndroidInitializationSettings('ic_notification');
      await _plugin
          .initialize(settings: const InitializationSettings(android: androidSettings));
      _initialized = true;

      final android = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await android?.createNotificationChannel(const AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDesc,
        importance: Importance.high,
      ));
    } catch (e) {
      debugPrint('CreditReminderService initialize warning: $e');
    }
  }

  Future<void> _ensureInit() async {
    if (!_initialized) await initialize();
  }

  Future<bool> hasPermission() async {
    await _ensureInit();
    if (!_initialized) return false;
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    return (await android?.areNotificationsEnabled()) ?? false;
  }

  int _notifId(String accountId) {
    var hash = 0;
    for (var i = 0; i < accountId.length; i++) {
      hash = 31 * hash + accountId.codeUnitAt(i);
    }
    return 1000000 + ((hash & 0x0FFFFFFF) % 400000);
  }

  int _advanceId(String accountId) {
    var hash = 0;
    for (var i = 0; i < accountId.length; i++) {
      hash = 31 * hash + accountId.codeUnitAt(i);
    }
    return 1400000 + ((hash & 0x0FFFFFFF) % 400000);
  }

  NotificationDetails _buildDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDesc,
        importance: Importance.high,
        priority: Priority.high,
      ),
    );
  }

  Future<void> scheduleReminder(Account acc) async {
    try {
      if (acc.type != 'credit' ||
          !acc.creditReminderEnabled ||
          acc.dueDay == null) {
        return;
      }
      await _ensureInit();
      if (!_initialized) return;
      if (acc.balance >= 0) {
        await cancelReminder(acc.id);
        return;
      }
      if (!(await hasPermission())) return;

      final parts = acc.creditReminderTime.split(':');
      final hour = int.tryParse(parts[0]) ?? 9;
      final minute = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;

      final loc = ServiceLocalizations.current;

      // 1. On due date reminder
      final tzDate = nextMonthlyReminderTzDate(
        dueDay: acc.dueDay!,
        daysBefore: 0,
        hour: hour,
        minute: minute,
      );
      if (tzDate != null) {
        await _plugin.zonedSchedule(
          id: _notifId(acc.id),
          title: loc.notif_creditBillDueTodayTitle,
          body: loc.notif_creditBillDueTodayBody(acc.name),
          scheduledDate: tzDate,
          notificationDetails: _buildDetails(),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          payload: acc.id,
        );
      }

      // 2. Early reminder (2 days before)
      if (acc.creditEarlyReminderEnabled) {
        final advTzDate = nextMonthlyReminderTzDate(
          dueDay: acc.dueDay!,
          daysBefore: 2,
          hour: hour,
          minute: minute,
        );
        if (advTzDate != null) {
          await _plugin.zonedSchedule(
            id: _advanceId(acc.id),
            title: loc.notif_creditBillDueSoonTitle,
            body: loc.notif_creditBillDueSoonBody(acc.name),
            scheduledDate: advTzDate,
            notificationDetails: _buildDetails(),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            payload: acc.id,
          );
        }
      }
    } catch (_) {}
  }

  Future<void> cancelReminder(String accountId) async {
    try {
      await _ensureInit();
      if (!_initialized) return;
      await _plugin.cancel(id: _notifId(accountId));
      await _plugin.cancel(id: _advanceId(accountId));
    } catch (_) {}
  }

  Future<void> rescheduleAll(List<Account> accounts) async {
    await _ensureInit();
    for (final acc in accounts) {
      if (acc.type == 'credit') {
        await cancelReminder(acc.id);
        if (acc.creditReminderEnabled) {
          await scheduleReminder(acc);
        }
      }
    }
  }
}
