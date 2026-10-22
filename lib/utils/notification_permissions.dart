// lib/utils/notification_permissions.dart
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'snackbar.dart';

class NotificationPermissions {
  /// Ensures notification permission is granted. If not, prompts the user.
  /// If denied, shows a helpful floating snackbar and returns false.
  static Future<bool> ensure(BuildContext context,
      {String? customDeniedMessage}) async {
    final plugin = FlutterLocalNotificationsPlugin();
    final android = plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android == null) return true;

    final granted = await android.requestNotificationsPermission() ?? false;
    if (!granted && context.mounted) {
      showAppSnackbar(
        context,
        customDeniedMessage ??
            'Notification permission is required for reminders.',
      );
    }
    return granted;
  }
}
