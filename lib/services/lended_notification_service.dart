// lib/services/lended_notification_service.dart
//
// Standalone notification service for lent/borrowed money due-date reminders.
// Completely separate from NotificationService (which handles recurring
// payments only). Uses its own Android notification channel ('expensy_lended')
// so users can toggle lent/borrowed reminders independently of recurring
// payment reminders in system settings.
//
// Scheduling model mirrors NotificationService.scheduleReminder() exactly:
// same guard-clause shape, same _toUtcTZDate() with null-check-and-skip for
// already-passed moments, same zonedSchedule() call. There is NO fallback
// firing for past-due-today times — if the chosen reminder time has already
// passed, the notification is simply not scheduled (the UI already shows a
// hint about this to the user).

import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;
import '../models/models.dart';
import '../theme/app_theme.dart';

class LendedNotificationService {
  // ── Singleton ────────────────────────────────────────────────────────────
  static final LendedNotificationService _instance =
      LendedNotificationService._();
  factory LendedNotificationService() => _instance;
  LendedNotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  // ── Channel constants ────────────────────────────────────────────────────
  static const _channelId = 'expensy_lended';
  static const _channelName = 'Lent & Borrowed Reminders';
  static const _channelDesc = 'Reminders for lent and borrowed money due dates';

  // ── Initialization ──────────────────────────────────────────────────────

  /// Must be called once during app startup (in main(), after
  /// WidgetsFlutterBinding.ensureInitialized()). Registers the lended
  /// notification channel so it's immediately visible in system settings
  /// even before any reminder is ever scheduled.
  Future<void> initialize() async {
    if (_initialized) return;

    // Timezone definitions — safe to call multiple times if the recurring
    // service already called it; tz_data tracks its own init state.
    tz_data.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('ic_notification');
    await _plugin
        .initialize(const InitializationSettings(android: androidSettings));
    _initialized = true;

    // Eagerly create the Android notification channel so it appears in
    // Settings → Apps → Expensy → Notifications from the very first launch,
    // not just after the first reminder is scheduled.
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      await android.createNotificationChannel(const AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDesc,
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
      ));
    }
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

    final notifGranted =
        await android.requestNotificationsPermission() ?? false;
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

  /// Schedule a reminder for a lent/borrowed record on its due date.
  /// Fires at [l.reminderTime] on [l.dueDate]. Does nothing when there is
  /// no due date, reminder is disabled, or the record is already settled.
  ///
  /// [personName] is resolved by the caller from [l.personId] (a
  /// [LendedPerson]) since this service has no access to the provider.
  ///
  /// Mirrors [NotificationService.scheduleReminder()] exactly: same guard
  /// shape, same [_toUtcTZDate()] null-check-and-skip for already-passed
  /// moments, same [zonedSchedule()] call. No special-casing, no fallback
  /// firing — if the target moment has already passed, the notification is
  /// simply not scheduled.
  Future<void> scheduleLendedReminder(
    LendedMoney l,
    String mainCurrency, {
    required String personName,
  }) async {
    if (!l.reminderEnabled || l.isSettled || l.dueDate == null) return;
    await _ensureInit();

    final parts = l.reminderTime.split(':');
    final hour = int.tryParse(parts[0]) ?? 9;
    final minute = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;

    final emoji = l.type == 'lent' ? '\u{1F4B8}' : '\u{1F4B0}';
    final amount = formatAmount(l.amount, mainCurrency);
    final details = _buildDetails();

    // Convert the target local date+time to a UTC-based TZDateTime.
    // Returns null if the moment has already passed — in that case we
    // simply skip scheduling (same as the recurring path).
    final tzDate = _toUtcTZDate(l.dueDate!, hour, minute);
    if (tzDate == null) return;

    final body = l.type == 'lent'
        ? '$amount you lent to $personName is due today'
        : '$amount you borrowed from $personName is due today';

    await _plugin.zonedSchedule(
      _notifId(l.id),
      '$emoji Due: $personName',
      body,
      tzDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: l.id,
    );
  }

  /// Cancel the lended reminder for [lendedId].
  Future<void> cancelLendedReminder(String lendedId) async {
    await _ensureInit();
    await _plugin.cancel(_notifId(lendedId));
  }

  /// Cancel all pending lended notifications and reschedule only the enabled,
  /// unsettled ones with a future due date. Used after a backup restore.
  ///
  /// [personNameOf] resolves a [LendedMoney.personId] to a display name
  /// (the caller — [AppProvider] — owns the [LendedPerson] list).
  ///
  /// NOTE: This does NOT touch recurring payment notifications — those are
  /// handled by the separate [NotificationService.rescheduleAll()].
  Future<void> rescheduleAllLended(
    List<LendedMoney> lended,
    String mainCurrency, {
    String Function(String personId)? personNameOf,
  }) async {
    await _ensureInit();
    // Cancel all previously scheduled lended notifications. We only cancel
    // our own — recurring notifications use different IDs and a different
    // plugin instance, so they are untouched.
    for (final l in lended) {
      await _plugin.cancel(_notifId(l.id));
    }
    // Re-schedule enabled reminders
    for (final l in lended
        .where((l) => l.reminderEnabled && !l.isSettled && l.dueDate != null)) {
      await scheduleLendedReminder(l, mainCurrency,
          personName: personNameOf?.call(l.personId) ?? '');
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

    // Shift to UTC by subtracting the local time's offset (fixes DST bugs).
    final offset = local.timeZoneOffset;
    final utc = local.subtract(offset);

    final tzDate = tz.TZDateTime.utc(
      utc.year,
      utc.month,
      utc.day,
      utc.hour,
      utc.minute,
    );

    // Return null (skip scheduling) if the moment has already passed.
    if (tzDate.isBefore(tz.TZDateTime.now(tz.UTC))) return null;
    return tzDate;
  }

  /// Stable positive int ID for lended notifications.
  /// Uses a 'lended_' prefix to guarantee it never collides with recurring
  /// payment notification IDs even if the underlying UUIDs matched.
  int _notifId(String lendedId) => 'lended_$lendedId'.hashCode & 0x7FFFFFFF;

  /// Builds the [NotificationDetails] for all lent/borrowed reminders,
  /// pointed at the dedicated lended channel.
  NotificationDetails _buildDetails() => const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.high,
          priority: Priority.high,
          category: AndroidNotificationCategory.reminder,
          playSound: true,
          enableVibration: true,
          styleInformation: BigTextStyleInformation(''),
        ),
      );

  Future<void> _ensureInit() async {
    if (!_initialized) await initialize();
  }
}
