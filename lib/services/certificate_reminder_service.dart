import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;
import '../models/models.dart';

class CertificateReminderService {
  static final CertificateReminderService _instance =
      CertificateReminderService._();
  factory CertificateReminderService() => _instance;
  CertificateReminderService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const _channelId = 'expensy_certificates';
  static const _channelName = 'Time Deposit Reminders';
  static const _channelDesc = 'Reminders when a certificate or deposit payout is due';

  Future<void> initialize() async {
    if (_initialized) return;
    try {
      tz_data.initializeTimeZones();
      const androidSettings =
          AndroidInitializationSettings('ic_notification');
      await _plugin.initialize(
          settings: const InitializationSettings(android: androidSettings));
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
      debugPrint('CertificateReminderService initialize warning: $e');
    }
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

  int _notifId(String certId, {bool early = false}) {
    var hash = 0;
    for (var i = 0; i < certId.length; i++) {
      hash = 31 * hash + certId.codeUnitAt(i);
    }
    final base = (hash & 0x7FFFFFFF) + 2000000;
    return early ? base + 1 : base;
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

  Future<void> scheduleReminder(Certificate c) async {
    await cancelReminder(c.id);
    if (!c.reminderEnabled || c.isSettled) return;
    await _ensureInit();
    if (!(await hasPermission())) return;

    final parts = c.reminderTime.split(':');
    final hour = int.tryParse(parts[0]) ?? 9;
    final minute = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;

    // Day of payout
    final tzDate = _nextReminderDate(c.collectionDay, 0, hour, minute);
    if (tzDate != null) {
      await _plugin.zonedSchedule(
        id: _notifId(c.id, early: false),
        title: '📈 Certificate Payout Due',
        body: '${c.name} interest return is due today.',
        scheduledDate: tzDate,
        notificationDetails: _buildDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: c.id,
      );
    }

    // 2 Days Early
    if (c.reminderEarlyEnabled) {
      final earlyDate = _nextReminderDate(c.collectionDay, 2, hour, minute);
      if (earlyDate != null) {
        await _plugin.zonedSchedule(
          id: _notifId(c.id, early: true),
          title: '📈 Upcoming Certificate Payout',
          body: '${c.name} interest return is due in 2 days.',
          scheduledDate: earlyDate,
          notificationDetails: _buildDetails(),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          payload: c.id,
        );
      }
    }
  }

  Future<void> cancelReminder(String certId) async {
    await _ensureInit();
    await _plugin.cancel(id: _notifId(certId, early: false));
    await _plugin.cancel(id: _notifId(certId, early: true));
  }

  Future<void> rescheduleAllCertificates(List<Certificate> certs) async {
    await _ensureInit();
    for (final c in certs) {
      await cancelReminder(c.id);
      if (c.reminderEnabled && !c.isSettled) {
        await scheduleReminder(c);
      }
    }
  }
}
