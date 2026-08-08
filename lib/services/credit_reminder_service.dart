import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;
import '../models/models.dart';

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
    tz_data.initializeTimeZones();
    const androidSettings =
        AndroidInitializationSettings('@drawable/ic_notification');
    await _plugin
        .initialize(const InitializationSettings(android: androidSettings));
    _initialized = true;

    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await android?.createNotificationChannel(const AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDesc,
      importance: Importance.high,
    ));
  }

  Future<void> _ensureInit() async {
    if (!_initialized) await initialize();
  }

  Future<bool> hasPermission() async {
    await _ensureInit();
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    return (await android?.areNotificationsEnabled()) ?? false;
  }

  int _notifId(String accountId) {
    var hash = 0;
    for (var i = 0; i < accountId.length; i++) {
      hash = 31 * hash + accountId.codeUnitAt(i);
    }
    return (hash & 0x7FFFFFFF) + 800000;
  }

  int _advanceId(String accountId) {
    var hash = 0;
    for (var i = 0; i < accountId.length; i++) {
      hash = 31 * hash + accountId.codeUnitAt(i);
    }
    return (hash & 0x7FFFFFFF) + 900000;
  }

  tz.TZDateTime? _nextReminderDate(
      int dueDay, int daysBefore, int hour, int minute) {
    final now = DateTime.now();
    var targetDate = _clampedDate(now.year, now.month, dueDay);
    targetDate = targetDate.subtract(Duration(days: daysBefore));
    targetDate = DateTime(
        targetDate.year, targetDate.month, targetDate.day, hour, minute);

    var currentMonth = now.month;
    var currentYear = now.year;
    while (targetDate.isBefore(now)) {
      currentMonth++;
      if (currentMonth > 12) {
        currentMonth = 1;
        currentYear++;
      }
      targetDate = _clampedDate(currentYear, currentMonth, dueDay);
      targetDate = targetDate.subtract(Duration(days: daysBefore));
      targetDate = DateTime(
          targetDate.year, targetDate.month, targetDate.day, hour, minute);
    }

    final offset = targetDate.timeZoneOffset;
    final utc = targetDate.subtract(offset);
    final tzDate =
        tz.TZDateTime.utc(utc.year, utc.month, utc.day, utc.hour, utc.minute);

    // Safety check just in case logic fails
    if (tzDate.isBefore(tz.TZDateTime.now(tz.UTC))) return null;
    return tzDate;
  }

  DateTime _clampedDate(int year, int month, int day) {
    int maxDays = DateTime(year, month + 1, 0).day;
    int safeDay = day > maxDays ? maxDays : day;
    return DateTime(year, month, safeDay);
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
    if (acc.type != 'credit' ||
        !acc.creditReminderEnabled ||
        acc.dueDay == null) {
      return;
    }
    await _ensureInit();
    if (!(await hasPermission())) return;

    final parts = acc.creditReminderTime.split(':');
    final hour = int.tryParse(parts[0]) ?? 9;
    final minute = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;

    // 1. On due date reminder
    final tzDate = _nextReminderDate(acc.dueDay!, 0, hour, minute);
    if (tzDate != null) {
      final body = 'Your ${acc.name} bill is due today.';
      await _plugin.zonedSchedule(
        _notifId(acc.id),
        '💳 Bill Due Today',
        body,
        tzDate,
        _buildDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: acc.id,
      );
    }

    // 2. Early reminder (2 days before)
    if (acc.creditEarlyReminderEnabled) {
      final advTzDate = _nextReminderDate(acc.dueDay!, 2, hour, minute);
      if (advTzDate != null) {
        final body = 'Your ${acc.name} bill is due in 2 days.';
        await _plugin.zonedSchedule(
          _advanceId(acc.id),
          '💳 Bill Due Soon',
          body,
          advTzDate,
          _buildDetails(),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: acc.id,
        );
      }
    }
  }

  Future<void> cancelReminder(String accountId) async {
    await _ensureInit();
    await _plugin.cancel(_notifId(accountId));
    await _plugin.cancel(_advanceId(accountId));
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
