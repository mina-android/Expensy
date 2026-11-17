import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import '../models/models.dart';
import '../utils/service_localizations.dart';
import 'date_scheduling.dart';

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
    if (!_initialized) return false;
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
    if (!_initialized || !(await hasPermission())) return;

    final parts = c.reminderTime.split(':');
    final hour = int.tryParse(parts[0]) ?? 9;
    final minute = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;

    final loc = ServiceLocalizations.current;

    // Day of payout
    final tzDate = nextMonthlyReminderTzDate(
      dueDay: c.collectionDay,
      daysBefore: 0,
      hour: hour,
      minute: minute,
    );
    if (tzDate != null) {
      await _plugin.zonedSchedule(
        id: _notifId(c.id, early: false),
        title: loc.notif_certPayoutDueTitle,
        body: loc.notif_certPayoutBody(c.name),
        scheduledDate: tzDate,
        notificationDetails: _buildDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: c.id,
      );
    }

    // 2 Days Early
    if (c.reminderEarlyEnabled) {
      final earlyDate = nextMonthlyReminderTzDate(
        dueDay: c.collectionDay,
        daysBefore: 2,
        hour: hour,
        minute: minute,
      );
      if (earlyDate != null) {
        await _plugin.zonedSchedule(
          id: _notifId(c.id, early: true),
          title: loc.notif_certPayoutUpcomingTitle,
          body: loc.notif_certPayoutSoonBody(c.name),
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
    if (!_initialized) return;
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
