// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_provider.dart';
import 'theme/app_theme.dart';
import 'screens/main_shell.dart';
import 'screens/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider()..load(),
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
    final isAmoled = s.themeMode == 'amoled';
    return MaterialApp(
      title: 'Expensy',
      debugShowCheckedModeBanner: false,
      themeMode:  resolveThemeMode(s.themeMode),
      theme:      buildTheme(seed: s.themeSeed, dark: false),
      darkTheme:  buildTheme(seed: s.themeSeed, dark: true, amoled: isAmoled),
      home: !app.loaded
          ? const _LoadingScreen()
          : app.settings.onboarded
              ? const MainShell()
              : const OnboardingScreen(),
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.surface,
      body: Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/splash_icon.png', width: 120, height: 120,
              fit: BoxFit.contain),
          const SizedBox(height: 32),
          Text('Expensy', style: TextStyle(fontSize: 34,
              fontWeight: FontWeight.w800, color: cs.onSurface)),
          const SizedBox(height: 8),
          Text('Your personal finance tracker', style: TextStyle(
              fontSize: 14, color: cs.onSurface.withValues(alpha: 0.55))),
          const SizedBox(height: 48),
          CircularProgressIndicator(color: cs.primary),
        ],
      )),
    );
  }
}
