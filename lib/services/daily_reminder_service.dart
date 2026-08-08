import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class DailyReminderService {
  static final DailyReminderService _instance =
      DailyReminderService._internal();
  factory DailyReminderService() => _instance;
  DailyReminderService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    const androidInit =
        AndroidInitializationSettings('@drawable/ic_notification');
    const initSettings = InitializationSettings(android: androidInit);
    await _plugin.initialize(initSettings);
    _initialized = true;
  }

  Future<void> requestPermissions() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await android?.requestNotificationsPermission();
  }

  Future<bool> hasPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    return (await android?.areNotificationsEnabled()) ?? false;
  }

  static const int dailyReminderId = 999999; // Stable ID

  tz.TZDateTime _toUtcTZDate(int hour, int minute) {
    final nowLocal = DateTime.now();
    final localTarget =
        DateTime(nowLocal.year, nowLocal.month, nowLocal.day, hour, minute);
    final offset = nowLocal.timeZoneOffset;
    final utc = localTarget.subtract(offset);
    var tzDate =
        tz.TZDateTime.utc(utc.year, utc.month, utc.day, utc.hour, utc.minute);

    // If passed for today in local time, schedule for tomorrow
    if (tzDate.isBefore(tz.TZDateTime.now(tz.UTC))) {
      tzDate = tzDate.add(const Duration(days: 1));
    }
    return tzDate;
  }

  Future<void> scheduleDailyReminder(String timeString) async {
    if (!(await hasPermission())) return;

    // Parse timeString (e.g. '22:00')
    final parts = timeString.split(':');
    if (parts.length != 2) return;
    final hour = int.tryParse(parts[0]) ?? 22;
    final minute = int.tryParse(parts[1]) ?? 0;

    final scheduledDate = _toUtcTZDate(hour, minute);

    const androidDetails = AndroidNotificationDetails(
      'expensy_daily_reminder',
      'Daily Transaction Reminder',
      channelDescription: 'Nightly nudge to log your daily spending.',
      importance: Importance.high,
      priority: Priority.high,
      category: AndroidNotificationCategory.reminder,
      playSound: true,
      enableVibration: true,
      styleInformation: BigTextStyleInformation(''),
    );
    const details = NotificationDetails(android: androidDetails);

    await _plugin.zonedSchedule(
      dailyReminderId,
      '📝 Daily Reminder',
      "Don't forget to log today's spending.",
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelDailyReminder() async {
    await _plugin.cancel(dailyReminderId);
  }
}
