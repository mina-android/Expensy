// lib/services/notification_service.dart
//
// Singleton notification service. Uses Dart's built-in DateTime.timeZoneOffset
// to compute the correct UTC moment without needing flutter_timezone (which has
// a Kotlin 2.x incompatibility). On Android, AlarmManager stores absolute epoch
// milliseconds, so a correctly-computed TZDateTime.utc(...) fires at the right
// local wall-clock time regardless of the IANA location name.

import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;
import '../models/models.dart';
import '../theme/app_theme.dart';

class NotificationService {
  // Singleton
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const _channelId   = 'expensy_recurring';
  static const _channelName = 'Recurring Payment Reminders';
  static const _channelDesc =
      'Reminders for your scheduled recurring payments and income';

  // ── Initialization ──────────────────────────────────────────────────────

  Future<void> initialize() async {
    if (_initialized) return;

    // Load timezone definitions. We don't need setLocalLocation() because
    // _toUtcTZDate() converts local times to UTC using the device offset directly.
    tz_data.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@drawable/ic_notification');
    await _plugin.initialize(const InitializationSettings(android: androidSettings));
    _initialized = true;
  }

  // ── Permissions ─────────────────────────────────────────────────────────

  /// Request POST_NOTIFICATIONS (Android 13+) and SCHEDULE_EXACT_ALARM
  /// (Android 12+). Returns true when the app can post notifications.
  Future<bool> requestPermissions() async {
    if (!Platform.isAndroid) return false;
    await _ensureInit();
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android == null) return false;

    final notifGranted = await android.requestNotificationsPermission() ?? false;
    if (notifGranted) await android.requestExactAlarmsPermission();
    return notifGranted;
  }

  /// Whether the app currently holds notification permission.
  Future<bool> hasPermission() async {
    if (!Platform.isAndroid) return false;
    await _ensureInit();
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    return await android?.areNotificationsEnabled() ?? false;
  }

  // ── Scheduling ──────────────────────────────────────────────────────────

  /// Schedule up to two notifications for [r]:
  ///   1. On-due-date notification at [r.reminderTime] on [r.nextDate].
  ///   2. (when [r.earlyReminderEnabled]) an advance notification at the same
  ///      time 2 days before [r.nextDate].
  Future<void> scheduleReminder(
    RecurringPayment r,
    String mainCurrency,
  ) async {
    if (!r.reminderEnabled) return;
    await _ensureInit();

    if (r.endDate != null && r.nextDate.isAfter(r.endDate!)) return;

    final parts  = r.reminderTime.split(':');
    final hour   = int.tryParse(parts[0]) ?? 9;
    final minute = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;

    final emoji  = r.paymentType == 'expense' ? '\u{1F4B8}' : '\u{1F4B0}';
    final amount = formatAmount(r.amount, mainCurrency);
    final details = _buildDetails();

    // ── 1. On-due-date notification ──────────────────────────────────────
    final tzDate = _toUtcTZDate(r.nextDate, hour, minute);
    if (tzDate != null) {
      final body = r.paymentType == 'expense'
          ? '$amount due today'
          : '$amount expected today';
      await _plugin.zonedSchedule(
        _notifId(r.id),
        '$emoji ${r.name}',
        body,
        tzDate,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: r.id,
      );
    }

    // ── 2. 2-days-before advance notification ────────────────────────────
    if (r.earlyReminderEnabled) {
      final advanceDay = r.nextDate.subtract(const Duration(days: 2));
      final advTzDate  = _toUtcTZDate(advanceDay, hour, minute);
      if (advTzDate != null) {
        final body = r.paymentType == 'expense'
            ? '$amount due in 2 days'
            : '$amount expected in 2 days';
        await _plugin.zonedSchedule(
          _advanceId(r.id),
          '$emoji ${r.name}',
          body,
          advTzDate,
          details,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: r.id,
        );
      }
    }
  }

  /// Cancel both the on-day and the advance notification for [paymentId].
  Future<void> cancelReminder(String paymentId) async {
    await _ensureInit();
    await _plugin.cancel(_notifId(paymentId));
    await _plugin.cancel(_advanceId(paymentId));   // safe even when not scheduled
  }

  /// Cancel all pending notifications and reschedule only the enabled ones.
  Future<void> rescheduleAll(
    List<RecurringPayment> payments,
    String mainCurrency,
  ) async {
    await _ensureInit();
    await _plugin.cancelAll();
    for (final r in payments.where((p) => p.reminderEnabled)) {
      await scheduleReminder(r, mainCurrency);
    }
  }

  // ── Helpers ─────────────────────────────────────────────────────────────

  /// Convert a local date + hour + minute into a UTC-based TZDateTime so the
  /// alarm fires at the correct wall-clock time without needing the IANA
  /// timezone name (avoids flutter_timezone Kotlin incompatibility).
  ///
  /// Returns null if the computed moment is already in the past.
  tz.TZDateTime? _toUtcTZDate(DateTime date, int hour, int minute) {
    // Build the target moment in local time (no timezone info yet).
    final local = DateTime(date.year, date.month, date.day, hour, minute);

    // Shift to UTC by subtracting the device's current UTC offset.
    final offset = DateTime.now().timeZoneOffset;
    final utc    = local.subtract(offset);

    final tzDate = tz.TZDateTime.utc(
      utc.year, utc.month, utc.day, utc.hour, utc.minute,
    );

    // Return null (skip scheduling) if the moment has already passed.
    if (tzDate.isBefore(tz.TZDateTime.now(tz.UTC))) return null;
    return tzDate;
  }

  /// Stable positive int ID derived from the payment UUID.
  int _notifId(String paymentId) => paymentId.hashCode & 0x7FFFFFFF;

  /// Stable positive int ID for the 2-days-before advance notification.
  /// Uses a distinct suffix so it never collides with [_notifId].
  int _advanceId(String paymentId) =>
      ('${paymentId}_adv').hashCode & 0x7FFFFFFF;

  /// Builds the shared [NotificationDetails] for all Expensy reminders.
  NotificationDetails _buildDetails() => NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.high,
          priority: Priority.high,
          category: AndroidNotificationCategory.reminder,
          playSound: true,
          enableVibration: true,
          styleInformation: const BigTextStyleInformation(''),
        ),
      );

  Future<void> _ensureInit() async {
    if (!_initialized) await initialize();
  }
}
