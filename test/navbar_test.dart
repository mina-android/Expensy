import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expensy/widgets/rounded_square_border.dart';
import 'package:expensy/screens/main_shell.dart';
import 'package:expensy/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:expensy/providers/app_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RoundedSquareBorder Unit Tests', () {
    test('renders as a perfect square centered in rectangular bounds', () {
      const border = RoundedSquareBorder(borderRadius: 14, size: 40);
      const rect = Rect.fromLTWH(0, 0, 100, 60);
      final path = border.getOuterPath(rect);

      final bounds = path.getBounds();
      expect(bounds.width, equals(40));
      expect(bounds.height, equals(40));
      expect(bounds.center, equals(rect.center));
    });

    test('defaults to min(width, height) when size is null', () {
      const border = RoundedSquareBorder(borderRadius: 12);
      const rect = Rect.fromLTWH(10, 20, 80, 50);
      final path = border.getOuterPath(rect);

      final bounds = path.getBounds();
      expect(bounds.width, equals(50));
      expect(bounds.height, equals(50));
      expect(bounds.center, equals(rect.center));
    });

    test('equality and scale work as expected', () {
      const b1 = RoundedSquareBorder(borderRadius: 14, size: 40);
      const b2 = RoundedSquareBorder(borderRadius: 14, size: 40);
      const b3 = RoundedSquareBorder(borderRadius: 10, size: 30);

      expect(b1, equals(b2));
      expect(b1 == b3, isFalse);
      expect(b1.hashCode, equals(b2.hashCode));

      final scaled = b1.scale(2.0) as RoundedSquareBorder;
      expect(scaled.borderRadius, equals(28));
      expect(scaled.size, equals(80));
    });
  });

  group('Floating Rounded Navbar Integration Tests', () {
    testWidgets('MainShell renders floating navbar with rounded square highlight', (tester) async {
      final app = AppProvider();
      await tester.pumpWidget(
        ChangeNotifierProvider<AppProvider>.value(
          value: app,
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: MainShell(),
          ),
        ),
      );

      expect(find.byType(NavigationBar), findsOneWidget);

      final navBarTheme = tester.widget<NavigationBarTheme>(find.byType(NavigationBarTheme));
      expect(navBarTheme.data.height, equals(64));
      expect(navBarTheme.data.indicatorShape, isA<RoundedSquareBorder>());

      final border = navBarTheme.data.indicatorShape as RoundedSquareBorder;
      expect(border.borderRadius, equals(14));
      expect(border.size, equals(40));

      // Verify the navbar is wrapped in a Material with rounded corners and elevation
      final clipRRectFinder = find.ancestor(
        of: find.byType(NavigationBar),
        matching: find.byType(ClipRRect),
      );
      expect(clipRRectFinder, findsOneWidget);

      final clipRRect = tester.widget<ClipRRect>(clipRRectFinder);
      expect(clipRRect.borderRadius, equals(BorderRadius.circular(22)));

      // Verify overlayColor is transparent so no rectangular highlight appears on press
      expect(
        navBarTheme.data.overlayColor?.resolve({WidgetState.pressed}),
        equals(Colors.transparent),
      );

      // Verify Theme around NavigationBar uses NoSplash
      final themeFinder = find.ancestor(
        of: find.byType(NavigationBarTheme),
        matching: find.byType(Theme),
      );
      expect(themeFinder, findsWidgets);
      final navTheme = tester.widget<Theme>(themeFinder.first);
      expect(navTheme.data.splashFactory, equals(NoSplash.splashFactory));

      // Verify destination icons are colored and not monochrome white
      final homeIconFinder = find.byIcon(Icons.home);
      expect(homeIconFinder, findsOneWidget);
      final homeIcon = tester.widget<Icon>(homeIconFinder);
      expect(homeIcon.color, isNotNull);
      expect(homeIcon.color, isNot(equals(Colors.white)));

      // Test tapping a tab changes the tab cleanly without errors
      final receiptTabFinder = find.descendant(
        of: find.byType(NavigationBar),
        matching: find.byIcon(Icons.receipt_long_outlined),
      );
      await tester.tap(receiptTabFinder);
      await tester.pumpAndSettle();
      expect(app.tabIndexNotifier.value, equals(1));
    });
  });
}
