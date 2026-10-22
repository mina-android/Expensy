import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/models/models.dart';
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

    // Page 5: Add a Debit Card screen
    expect(find.text('Add a Debit Card'), findsOneWidget);
    expect(
        find.text('Link a debit card to your new bank account for effortless expense tracking.'),
        findsOneWidget);
    // Verify "Skip for now" button is present on the Debit Card screen!
    final skipBtn = find.text('Skip for now');
    expect(skipBtn, findsOneWidget);

    // Tapping "Skip for now" advances to Notification Access Request page
    await tester.tap(skipBtn);
    await tester.pumpAndSettle();

    expect(find.text('Stay on Top of Your Finances'), findsOneWidget);
    expect(find.text('Allow Notifications'), findsOneWidget);
    expect(find.text('Maybe Later'), findsOneWidget);
  });

  testWidgets('Onboarding name validation highlights red when empty and continue is clicked',
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

    // Page 1: Welcome -> Start Fresh
    await tester.tap(find.text('Start Fresh'));
    await tester.pumpAndSettle();

    // Page 2: Name -> Click continue without entering a name
    expect(find.text("Let's get you set up"), findsOneWidget);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Expect red validation error "Name is required"
    expect(find.text('Name is required'), findsOneWidget);

    // Enter name -> error clears
    await tester.enterText(find.byType(TextField), 'Alice');
    await tester.pumpAndSettle();
    expect(find.text('Name is required'), findsNothing);

    // Continue to Currency
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Default Currency'), findsOneWidget);
  });

  testWidgets('Onboarding non-bank account bypasses debit card page directly to notifications',
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
    await tester.enterText(find.byType(TextField), 'Alice');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Page 3: Currency
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Page 4: Account -> Select Cash
    await tester.tap(find.text('Cash'));
    await tester.pumpAndSettle();

    // Continue -> Should bypass debit card page and go directly to notifications
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Add a Debit Card'), findsNothing);
    expect(find.text('Stay on Top of Your Finances'), findsOneWidget);
  });

  testWidgets('Onboarding bank account displays balance field directly without unlinking toggle',
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
    // Don't link to card is removed
    expect(find.text("Don't link to Card"), findsNothing);
    // Starting Balance and Exclude from Total Balance are now immediately visible for Bank accounts
    expect(find.text('Starting Balance'), findsOneWidget);
    expect(find.text('Exclude from Total Balance'), findsOneWidget);

    // Switch account type to Cash
    await tester.tap(find.text('Cash'));
    await tester.pumpAndSettle();

    // Starting Balance should still be visible for Cash
    expect(find.text('Starting Balance'), findsOneWidget);
    expect(find.text('Exclude from Total Balance'), findsOneWidget);
  });

  test('Debit card dynamically inherits effective balance from linked bank account', () {
    final provider = AppProvider();
    final bank = Account(
      id: 'acc_bank_1',
      name: 'Main Bank',
      type: 'bank',
      balance: 5000,
      colorValue: 0xFF1972E8,
      currency: 'USD',
    );
    final debitCard = Account(
      id: 'acc_debit_card',
      name: 'Bank Debit Card',
      type: 'debit',
      balance: 0,
      linkedAccountId: 'acc_bank_1',
      colorValue: 0xFF1972E8,
      currency: 'USD',
    );

    provider.accounts = [bank, debitCard];

    // Debit card inherits bank balance via getEffectiveBalance
    expect(provider.getEffectiveBalance(debitCard), 5000.0);
    // Total balance only counts bank, debit is excluded from double counting
    expect(provider.totalBalance, 5000.0);
  });
}
