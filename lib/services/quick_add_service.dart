// lib/services/quick_add_service.dart
//
// Bridges the native "Quick Add Transaction" home screen widget (an Android
// App Widget — see HOMESCREEN_WIDGET.md) to Dart. No `home_widget` package
// dependency: this is a plain MethodChannel + EventChannel pair, matching
// the Kotlin side in MainActivity.kt / QuickAddWidgetProvider.kt.
//
// Two entrypoints mirror the two Android lifecycles the widget tap can hit:
//   - Cold start: [getInitialRoute] reads the launch Intent's extra once.
//   - Warm start: [routeStream] fires whenever the widget is tapped while
//     the app is already alive (Activity gets onNewIntent instead).
import 'package:flutter/services.dart';

class QuickAddService {
  QuickAddService._();
  static final QuickAddService instance = QuickAddService._();

  static const String routeQuickAdd = 'quick_add_transaction';

  static const MethodChannel _methodChannel =
      MethodChannel('com.ma.expensy/quick_add');
  static const EventChannel _eventChannel =
      EventChannel('com.ma.expensy/quick_add_stream');

  Stream<String?>? _routeStream;

  /// Reads the route extra (if any) the app was cold-started with.
  /// Returns null if the app wasn't launched from the widget.
  Future<String?> getInitialRoute() async {
    try {
      return await _methodChannel.invokeMethod<String>('getInitialRoute');
    } on PlatformException {
      return null;
    }
  }

  /// Fires with the route string every time the widget is tapped while the
  /// app is already running in the background (Activity's onNewIntent).
  Stream<String?> get routeStream {
    return _routeStream ??=
        _eventChannel.receiveBroadcastStream().cast<String?>();
  }
}
