import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import '../models/models.dart';
import '../utils/service_localizations.dart';
import 'date_scheduling.dart';

class LoanReminderService {
  static final LoanReminderService _instance = LoanReminderService._();
  factory LoanReminderService() => _instance;
  LoanReminderService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const _channelId = 'expensy_loans';
  static const _channelName = 'Loan Payment Reminders';
  static const _channelDesc = 'Reminders when a loan installment is due';

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
      debugPrint('LoanReminderService initialize warning: $e');
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

  int _notifId(String loanId) {
    var hash = 0;
    for (var i = 0; i < loanId.length; i++) {
      hash = 31 * hash + loanId.codeUnitAt(i);
    }
    return 2000000 + ((hash & 0x0FFFFFFF) % 400000);
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

  Future<void> scheduleReminder(Loan l) async {
    if (!l.reminderEnabled || l.isSettled) return;
    await _ensureInit();
    if (!_initialized || !(await hasPermission())) return;

    final parts = l.reminderTime.split(':');
    final hour = int.tryParse(parts[0]) ?? 9;
    final minute = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;

    final tzDate = nextMonthlyReminderTzDate(
      dueDay: l.reminderDay,
      daysBefore: 0,
      hour: hour,
      minute: minute,
    );
    if (tzDate != null) {
      final loc = ServiceLocalizations.current;
      await _plugin.zonedSchedule(
        id: _notifId(l.id),
        title: loc.notif_loanPaymentDueTitle,
        body: loc.notif_loanPaymentDueBody(l.name),
        scheduledDate: tzDate,
        notificationDetails: _buildDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: l.id,
      );
    }
  }

  Future<void> cancelReminder(String loanId) async {
    await _ensureInit();
    if (!_initialized) return;
    await _plugin.cancel(id: _notifId(loanId));
  }

  Future<void> rescheduleAllLoans(List<Loan> loans) async {
    await _ensureInit();
    for (final l in loans) {
      await cancelReminder(l.id);
      if (l.reminderEnabled && !l.isSettled) {
        await scheduleReminder(l);
      }
    }
  }
}
