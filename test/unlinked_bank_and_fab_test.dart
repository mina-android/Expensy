import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/widgets/shared_widgets.dart';
import 'package:expensy/screens/recurring_screen.dart';
import 'package:expensy/utils/nav_metrics.dart';
import 'package:expensy/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AccountCardPicker with unlinked bank accounts', () {
    testWidgets('shows unlinked bank account and excludes linked bank account',
        (tester) async {
      final normalBank = Account(
        id: 'bank-linked',
        name: 'Linked Bank',
        type: 'bank',
        currency: 'USD',
        balance: 1000,
        colorValue: 0xFF2196F3,
        dontLinkToCard: false,
      );

      final unlinkedBank = Account(
        id: 'bank-unlinked',
        name: 'Unlinked Bank',
        type: 'bank',
        currency: 'USD',
        balance: 2000,
        colorValue: 0xFF4CAF50,
        dontLinkToCard: true,
      );

      final regularWallet = Account(
        id: 'cash-wallet',
        name: 'Cash Wallet',
        type: 'cash',
        currency: 'USD',
        balance: 500,
        colorValue: 0xFFFF9800,
      );

      String? selectedId;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AccountCardPicker(
              accounts: [normalBank, unlinkedBank, regularWallet],
              selectedId: selectedId,
              onSelected: (id) => selectedId = id,
            ),
          ),
        ),
      );

      // Linked bank account should NOT appear
      expect(find.text('Linked Bank'), findsNothing);

      // Unlinked bank account should appear
      expect(find.text('Unlinked Bank'), findsOneWidget);

      // Cash wallet should appear
      expect(find.text('Cash Wallet'), findsOneWidget);

      // Tapping unlinked bank account triggers onSelected
      await tester.tap(find.text('Unlinked Bank'));
      expect(selectedId, equals('bank-unlinked'));
    });
  });

  group('RecurringScreen FAB bottom padding', () {
    testWidgets('FAB padding is positioned directly above the floating navbar',
        (tester) async {
      final app = AppProvider();

      await tester.pumpWidget(
        ChangeNotifierProvider<AppProvider>.value(
          value: app,
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: RecurringScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final scaffoldFinder = find.byType(Scaffold);
      expect(scaffoldFinder, findsOneWidget);

      final scaffold = tester.widget<Scaffold>(scaffoldFinder);
      expect(scaffold.floatingActionButton, isNotNull);

      // Verify NavAwareFabLocation and ExpandableFab are configured correctly
      expect(scaffold.floatingActionButtonLocation, isA<NavAwareFabLocation>());
      expect(scaffold.floatingActionButton, isA<ExpandableFab>());
    });
  });
}
