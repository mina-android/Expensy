// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/app_provider.dart';
import 'theme/app_theme.dart';
import 'screens/onboarding_screen.dart';
import 'screens/main_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final provider = AppProvider();
  await provider.init();

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
    return Consumer<AppProvider>(
      builder: (context, app, _) {
        final s = app.settings;
        return MaterialApp(
          title: 'Expensy',
          debugShowCheckedModeBanner: false,
          theme:     buildTheme(seed: s.themeSeed, dark: false),
          darkTheme: buildTheme(seed: s.themeSeed, dark: true),
          themeMode: s.themeSeed == 'pitch_black'
              ? ThemeMode.dark
              : (s.darkMode ? ThemeMode.dark : ThemeMode.light),
          home: app.isLoading
              ? const _SplashScreen()
              : s.onboarded
                  ? const MainShell()
                  : const OnboardingScreen(),
        );
      },
    );
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Custom app icon from drawable/splash_icon.png
            ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.asset(
                'assets/splash_icon.png',
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'Expensy',
              style: TextStyle(
                color: cs.onPrimary,
                fontSize: 34,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your personal finance tracker',
              style: TextStyle(
                color: cs.onPrimary.withValues(alpha: 0.7),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 48),
            CircularProgressIndicator(
                color: cs.onPrimary.withValues(alpha: 0.7)),
          ],
        ),
      ),
    );
  }
}
