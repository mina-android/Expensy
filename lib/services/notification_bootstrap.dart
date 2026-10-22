// lib/services/notification_bootstrap.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;

class NotificationBootstrap {
  static bool _initialized = false;

  /// Consolidates notification plugin and timezone initialization into a single
  /// unified pass during app boot, avoiding redundant serial initializations.
  static Future<void> init() async {
    if (_initialized) return;

    // Initialize timezones once
    tz_data.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('ic_notification');
    const initSettings = InitializationSettings(android: androidSettings);
    final plugin = FlutterLocalNotificationsPlugin();
    await plugin.initialize(settings: initSettings);

    final android = plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      await Future.wait([
        android.createNotificationChannel(const AndroidNotificationChannel(
          'expensy_recurring',
          'Recurring Payment Reminders',
          description: 'Reminders for bills and recurring expenses',
          importance: Importance.high,
          playSound: true,
        )),
        android.createNotificationChannel(const AndroidNotificationChannel(
          'expensy_lended',
          'Lent & Borrowed Reminders',
          description: 'Reminders for lent and borrowed money due dates',
          importance: Importance.high,
          playSound: true,
        )),
        android.createNotificationChannel(const AndroidNotificationChannel(
          'expensy_budget_alerts',
          'Budget Alerts',
          description: 'Alerts when category spending exceeds budget',
          importance: Importance.high,
        )),
        android.createNotificationChannel(const AndroidNotificationChannel(
          'expensy_daily_reminder',
          'Daily Transaction Reminder',
          description: 'Nightly nudge to log your daily spending.',
          importance: Importance.high,
          playSound: true,
        )),
        android.createNotificationChannel(const AndroidNotificationChannel(
          'expensy_loans',
          'Loan Payment Reminders',
          description: 'Reminders when a loan installment is due',
          importance: Importance.high,
        )),
        android.createNotificationChannel(const AndroidNotificationChannel(
          'expensy_credit',
          'Credit Card Reminders',
          description: 'Reminders to pay credit card bills',
          importance: Importance.high,
        )),
        android.createNotificationChannel(const AndroidNotificationChannel(
          'expensy_certificates',
          'Time Deposit Reminders',
          description: 'Reminders when a certificate or deposit payout is due',
          importance: Importance.high,
        )),
      ]);
    }

    _initialized = true;
  }
}
