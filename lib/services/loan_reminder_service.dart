import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;
import '../models/models.dart';

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
    tz_data.initializeTimeZones();
    const androidSettings =
        AndroidInitializationSettings('ic_notification');
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

  int _notifId(String loanId) {
    var hash = 0;
    for (var i = 0; i < loanId.length; i++) {
      hash = 31 * hash + loanId.codeUnitAt(i);
    }
    return (hash & 0x7FFFFFFF) + 1000000; // offset distinct from credit, recurring, lended
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

  Future<void> scheduleReminder(Loan l) async {
    if (!l.reminderEnabled || l.isSettled) return;
    await _ensureInit();
    if (!(await hasPermission())) return;

    final parts = l.reminderTime.split(':');
    final hour = int.tryParse(parts[0]) ?? 9;
    final minute = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;

    final tzDate = _nextReminderDate(l.reminderDay, 0, hour, minute);
    if (tzDate != null) {
      await _plugin.zonedSchedule(
        _notifId(l.id),
        '🏦 Loan Payment Due',
        '${l.name} installment is due today.',
        tzDate,
        _buildDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: l.id,
      );
    }
  }

  Future<void> cancelReminder(String loanId) async {
    await _ensureInit();
    await _plugin.cancel(_notifId(loanId));
  }

  Future<void> rescheduleAllLoans(List<Loan> loans, String mainCurrency) async {
    await _ensureInit();
    for (final l in loans) {
      await cancelReminder(l.id);
      if (l.reminderEnabled && !l.isSettled) {
        await scheduleReminder(l);
      }
    }
  }
}
