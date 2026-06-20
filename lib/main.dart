// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'providers/app_provider.dart';
import 'theme/app_theme.dart';
import 'screens/main_shell.dart';
import 'screens/onboarding_screen.dart';
import 'services/notification_service.dart';

/// Awaiting [provider.load()] before [runApp] keeps the native LaunchTheme
/// window background (launch_background.xml) visible for the entire startup
/// duration.  Flutter only replaces it with the first Flutter frame, which is
/// already the real app — no intermediate loading screen, no double icon flash.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initialize();

  final provider = AppProvider();
  await provider.load();   // DB reads finish before Flutter draws anything

  runApp(
    ChangeNotifierProvider.value(
      value: provider,
      child: const ExpensyApp(),
    ),
  );
}

class ExpensyApp extends StatelessWidget {
  const ExpensyApp({super.key});

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
