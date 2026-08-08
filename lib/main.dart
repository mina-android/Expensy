// lib/main.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'providers/app_provider.dart';
import 'services/budget_notification_service.dart';
import 'services/daily_reminder_service.dart';
import 'l10n/app_localizations.dart';
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
  await BudgetNotificationService().initialize();
  await DailyReminderService().initialize();

  final provider = AppProvider();
  await provider.load(); // DB reads finish before Flutter draws anything

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
      ExpensySlideUpRoute(builder: (_) => const AddTransactionScreen()),
    );
  }

  @override
  void dispose() {
    _quickAddSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch only the specific settings properties needed by MaterialApp.
    // This prevents the entire app from rebuilding when transactions, accounts, etc. change.
    final settingsRecord = context.select<AppProvider,
        (bool, String, String, String, String, bool, bool)>((app) {
      final s = app.settings;
      return (
        s.dynamicColorEnabled,
        s.languageCode,
        s.themeMode,
        s.themeSeed,
        s.appFont,
        s.amoledSurfaces,
        s.onboarded
      );
    });

    final usesDynamic = settingsRecord.$1;
    final languageCode = settingsRecord.$2;
    final themeMode = settingsRecord.$3;
    final themeSeed = settingsRecord.$4;
    final appFont = settingsRecord.$5;
    final amoledSurfaces = settingsRecord.$6;
    final onboarded = settingsRecord.$7;

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        final view = View.of(context);
        final mediaQueryData =
            MediaQueryData.fromView(view).copyWith(accessibleNavigation: false);

        return MediaQuery(
          data: mediaQueryData,
          child: MaterialApp(
            title: 'Expensy',
            navigatorKey: rootNavigatorKey,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: languageCode == 'system' ? null : Locale(languageCode),
            themeMode: resolveThemeMode(themeMode),
            theme: buildTheme(
              seed: themeSeed,
              dark: false,
              appFont: appFont,
              dynamicScheme: usesDynamic ? lightDynamic : null,
            ),
            darkTheme: buildTheme(
              seed: themeSeed,
              dark: true,
              amoled: amoledSurfaces, // applies regardless of color source
              appFont: appFont,
              dynamicScheme: usesDynamic ? darkDynamic : null,
            ),
            home: onboarded ? const MainShell() : const OnboardingScreen(),
          ),
        );
      },
    );
  }
}
