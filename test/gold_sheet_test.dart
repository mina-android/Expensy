import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expensy/screens/accounts_screen.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Gold Purity Calculations & Character Encoding Tests', () {
    test('Karat purity percentage never exceeds 100%', () {
      final karats = [24, 22, 21, 18, 14, 10, 9];
      for (final k in karats) {
        final purity = k / 24 * 100;
        expect(purity, lessThanOrEqualTo(100.0));
        expect(purity, greaterThan(0.0));
      }

      // Check 24k is exactly 100%
      expect((24 / 24 * 100).toStringAsFixed(0), equals('100'));
      expect((24 / 24 * 100).toStringAsFixed(1), equals('100.0'));

      // Check 21k
      expect((21 / 24 * 100).toStringAsFixed(0), equals('88'));
      expect((21 / 24 * 100).toStringAsFixed(1), equals('87.5'));

      // Check 18k
      expect((18 / 24 * 100).toStringAsFixed(0), equals('75'));
      expect((18 / 24 * 100).toStringAsFixed(1), equals('75.0'));
    });

    testWidgets('Accounts screen gold sheet does not show Ã or purities above 100%', (tester) async {
      final app = AppProvider();
      await tester.pumpWidget(
        ChangeNotifierProvider<AppProvider>.value(
          value: app,
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: AccountsScreen(),
          ),
        ),
      );

      // Verify that no text widget in the tree contains the corrupted 'Ã' character
      final allTextWidgets = tester.widgetList<Text>(find.byType(Text));
      for (final textWidget in allTextWidgets) {
        final data = textWidget.data ?? textWidget.textSpan?.toPlainText() ?? '';
        expect(data.contains('Ã'), isFalse, reason: 'Text contains corrupted character: $data');
        expect(data.contains('140%'), isFalse, reason: 'Purity should not be 140%: $data');
      }
    });
  });
}
