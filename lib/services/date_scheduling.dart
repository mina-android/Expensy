// lib/services/date_scheduling.dart
// note: Shared date-clamping and next-monthly-reminder scheduling utilities for notification services.

import 'package:timezone/timezone.dart' as tz;

/// Returns a [DateTime] for [year]-[month]-[day], clamping [day] to the actual
/// number of days in that month (e.g., Feb 28/29, Apr 30).
DateTime clampedMonthlyDate(int year, int month, int day) {
  final maxDays = DateTime(year, month + 1, 0).day;
  final safeDay = day.clamp(1, maxDays);
  return DateTime(year, month, safeDay);
}

/// Computes the next future [tz.TZDateTime] instance in UTC for a monthly
/// reminder occurring [daysBefore] the [dueDay] of the month at [hour]:[minute].
tz.TZDateTime? nextMonthlyReminderTzDate({
  required int dueDay,
  required int daysBefore,
  required int hour,
  required int minute,
  DateTime? nowOverride,
}) {
  final now = nowOverride ?? DateTime.now();
  var targetDate = clampedMonthlyDate(now.year, now.month, dueDay);
  targetDate = targetDate.subtract(Duration(days: daysBefore));
  targetDate =
      DateTime(targetDate.year, targetDate.month, targetDate.day, hour, minute);

  var currentMonth = now.month;
  var currentYear = now.year;
  while (targetDate.isBefore(now)) {
    currentMonth++;
    if (currentMonth > 12) {
      currentMonth = 1;
      currentYear++;
    }
    targetDate = clampedMonthlyDate(currentYear, currentMonth, dueDay);
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
