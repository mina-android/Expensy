// lib/main.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'providers/app_provider.dart';
import 'theme/app_theme.dart';
import 'screens/main_shell.dart';
import 'screens/onboarding_screen.dart';
import 'screens/add_transaction_screen.dart';
import 'services/notification_service.dart';
import 'services/lended_notification_service.dart';
import 'services/quick_add_service.dart';

/// Root navigator key so the "Quick Add Transaction" home screen widget can
/// push [AddTransactionScreen] on top of whatever's currently showing,
/// without MaterialApp itself needing to know about the widget at all.
/// See HOMESCREEN_WIDGET.md §4.2 — this is the "push on top of MainShell"
/// approach, preferred over swapping `home:` directly because it keeps
/// MainShell as the true root for every cold-start path (consistent with
/// CLAUDE.md §8) and back navigation "just works" via the normal
/// ExpensyRoute pop transition.
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// Awaiting [provider.load()] before [runApp] keeps the native LaunchTheme
/// window background (launch_background.xml) visible for the entire startup
/// duration.  Flutter only replaces it with the first Flutter frame, which is
/// already the real app — no intermediate loading screen, no double icon flash.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initialize();
  await LendedNotificationService().initialize();

  final provider = AppProvider();
  await provider.load();   // DB reads finish before Flutter draws anything

  runApp(
    ChangeNotifierProvider.value(
      value: provider,
      child: const ExpensyApp(),
    ),
  );
}

class ExpensyApp extends StatefulWidget {
  const ExpensyApp({super.key});

  @override
  State<ExpensyApp> createState() => _ExpensyAppState();
}

class _ExpensyAppState extends State<ExpensyApp> {
  StreamSubscription<String?>? _quickAddSub;

  @override
  void initState() {
    super.initState();

    // Cold start: were we launched directly from the widget tap? Checked
    // once here (rather than in main(), before runApp) so it can safely
    // push onto rootNavigatorKey after the very first frame is up.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final initialRoute = await QuickAddService.instance.getInitialRoute();
      if (initialRoute == QuickAddService.routeQuickAdd) {
        _pushQuickAdd();
      }
    });

    // Warm start: app already alive in the background, widget tapped again.
    _quickAddSub = QuickAddService.instance.routeStream.listen((route) {
      if (route == QuickAddService.routeQuickAdd) {
        _pushQuickAdd();
      }
    });
  }

  void _pushQuickAdd() {
    // onboarding screen has no bottom-nav shell to return to underneath it —
    // skip the quick-add fast-path in that case and let onboarding proceed
    // normally.
    final app = context.read<AppProvider>();
    if (!app.settings.onboarded) return;

    rootNavigatorKey.currentState?.push(
      ExpensyRoute(builder: (_) => const AddTransactionScreen()),
    );
  }

  @override
  void dispose() {
    _quickAddSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final s   = app.settings;

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        // Dynamic colour only when following the system — Android 12+ devices
        // provide a wallpaper-extracted palette; older devices return null and
        // fall back to the chosen seed colour automatically.
        final usesDynamic = s.themeMode == 'system';

        return MaterialApp(
          title: 'Expensy',
          navigatorKey: rootNavigatorKey,
          debugShowCheckedModeBanner: false,
          themeMode: resolveThemeMode(s.themeMode),
          theme: buildTheme(
            seed:          s.themeSeed,
            dark:          false,
            appFont:       s.appFont,
            dynamicScheme: usesDynamic ? lightDynamic : null,
          ),
          darkTheme: buildTheme(
            seed:          s.themeSeed,
            dark:          true,
            amoled:        s.amoledSurfaces, // applies regardless of colour source
            appFont:       s.appFont,
            dynamicScheme: usesDynamic ? darkDynamic : null,
          ),
          home: s.onboarded ? const MainShell() : const OnboardingScreen(),
        );
      },
    );
  }
}
