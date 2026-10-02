import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/screens/onboarding_screen.dart';
import 'package:expensy/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Onboarding skip button appears on Add Card and Account screens, but not Currency',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final provider = AppProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider<AppProvider>.value(
        value: provider,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale('en'),
          home: OnboardingScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Page 0: Language — tap English or Continue
    expect(find.text('Choose Language'), findsOneWidget);
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle(const Duration(milliseconds: 400));

    // Page 1: Welcome
    expect(find.text('Welcome to Expensy!'), findsOneWidget);
    await tester.tap(find.text('Start Fresh'));
    await tester.pumpAndSettle();

    // Page 2: Name
    expect(find.text("Let's get you set up"), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Test User');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Page 3: Currency
    expect(find.text('Default Currency'), findsOneWidget);
    // Ensure Currency screen does NOT have a "Skip for now" button
    expect(find.text('Skip for now'), findsNothing);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Page 4: First Account
    expect(find.text('Your First Account'), findsOneWidget);
    // Account screen has "Skip for now" button
    expect(find.text('Skip for now'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Page 5: Add a Card screen
    expect(find.text('Add a Card'), findsOneWidget);
    expect(
        find.text("You can skip this if you don't want to add a card right now."),
        findsOneWidget);
    // Verify "Skip for now" button is present on the Add a Card screen!
    final skipBtn = find.text('Skip for now');
    expect(skipBtn, findsOneWidget);

    // Tapping "Skip for now" skips card creation
    await tester.tap(skipBtn);
    await tester.pumpAndSettle();
  });

  testWidgets('Onboarding bank account shows Don\'t link to Card toggle and hides balance until toggled',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final provider = AppProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider<AppProvider>.value(
        value: provider,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale('en'),
          home: OnboardingScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Page 0: Language
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle(const Duration(milliseconds: 400));

    // Page 1: Welcome
    await tester.tap(find.text('Start Fresh'));
    await tester.pumpAndSettle();

    // Page 2: Name
    await tester.enterText(find.byType(TextField), 'Test User');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Page 3: Currency
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Page 4: First Account (defaults to Bank)
    expect(find.text('Your First Account'), findsOneWidget);
    expect(find.text("Don't link to Card"), findsOneWidget);
    // Initially, Starting Balance and Exclude from Total Balance are hidden for Bank
    expect(find.text('Starting Balance'), findsNothing);
    expect(find.text('Exclude from Total Balance'), findsNothing);

    // Toggle "Don't link to Card" ON
    await tester.tap(find.text("Don't link to Card"));
    await tester.pumpAndSettle();

    // Now Starting Balance and Exclude from Total Balance should be visible
    expect(find.text('Starting Balance'), findsOneWidget);
    expect(find.text('Exclude from Total Balance'), findsOneWidget);

    // Switch account type to Cash
    await tester.tap(find.text('Cash'));
    await tester.pumpAndSettle();

    // "Don't link to Card" should NOT be visible for Cash
    expect(find.text("Don't link to Card"), findsNothing);
    // Starting Balance should still be visible for Cash
    expect(find.text('Starting Balance'), findsOneWidget);
    expect(find.text('Exclude from Total Balance'), findsOneWidget);
  });
}
