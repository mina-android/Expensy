import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/theme/app_theme.dart';
import 'package:expensy/widgets/shared_widgets.dart';

void main() {
  group('RecurringPayment upcomingPaymentDates', () {
    test('returns empty list when endDate is null', () {
      final r = RecurringPayment(
        id: '1',
        name: 'Netflix',
        amount: 15.0,
        accountId: 'acc1',
        categoryId: 'cat1',
        paymentType: 'expense',
        freqVal: 1,
        freqUnit: 'months',
        startDate: DateTime(2026, 1, 1),
        nextDate: DateTime(2026, 2, 1),
        endDate: null,
      );

      expect(r.upcomingPaymentDates, isEmpty);
    });

    test('returns sequential payment dates up to endDate and remaining count', () {
      final r = RecurringPayment(
        id: '2',
        name: 'Car Loan',
        amount: 250.0,
        accountId: 'acc1',
        categoryId: 'cat1',
        paymentType: 'expense',
        freqVal: 1,
        freqUnit: 'months',
        startDate: DateTime(2026, 1, 1),
        nextDate: DateTime(2026, 2, 1),
        endDate: DateTime(2026, 5, 1),
        paidPayments: 1, // 1 of 5 paid (Jan was paid, Feb is next, up to May = 4 remaining)
      );

      final dates = r.upcomingPaymentDates;
      expect(dates.length, equals(4));
      expect(dates[0], equals(DateTime(2026, 2, 1)));
      expect(dates[1], equals(DateTime(2026, 3, 1)));
      expect(dates[2], equals(DateTime(2026, 4, 1)));
      expect(dates[3], equals(DateTime(2026, 5, 1)));
    });

    test('returns empty list when all payments are paid', () {
      final r = RecurringPayment(
        id: '3',
        name: 'Phone Installment',
        amount: 100.0,
        accountId: 'acc1',
        categoryId: 'cat1',
        paymentType: 'expense',
        freqVal: 1,
        freqUnit: 'months',
        startDate: DateTime(2026, 1, 1),
        nextDate: DateTime(2026, 4, 1),
        endDate: DateTime(2026, 3, 1),
        paidPayments: 3,
      );

      expect(r.upcomingPaymentDates, isEmpty);
    });
  });

  group('popupSurfaceColor & popupBorderSide theme helpers', () {
    test('returns Colors.black for AMOLED dark mode', () {
      final amoledScheme = const ColorScheme.dark().copyWith(
        surface: Colors.black,
      );
      expect(popupSurfaceColor(amoledScheme), equals(Colors.black));
      expect(popupBorderSide(amoledScheme).color, isNot(Colors.transparent));
    });

    test('returns surfaceContainerHigh for regular dark mode', () {
      final darkScheme = const ColorScheme.dark().copyWith(
        surface: const Color(0xFF121212),
        surfaceContainerHigh: const Color(0xFF2B2B2B),
      );
      expect(popupSurfaceColor(darkScheme), equals(const Color(0xFF2B2B2B)));
      expect(
        popupBorderSide(darkScheme).color,
        equals(darkScheme.outlineVariant.withValues(alpha: 0.2)),
      );
    });

    test('returns surface for light mode', () {
      final lightScheme = const ColorScheme.light().copyWith(
        surface: Colors.white,
      );
      expect(popupSurfaceColor(lightScheme), equals(Colors.white));
      expect(popupBorderSide(lightScheme), equals(BorderSide.none));
    });
  });

  group('AccountCardPicker in TransferScreen', () {
    testWidgets('displays all transferable accounts without internal filtering',
        (tester) async {
      final bank = Account(
        id: 'bank-1',
        name: 'Chase Checking',
        type: 'bank',
        currency: 'USD',
        balance: 1500,
        colorValue: 0xFF2196F3,
        dontLinkToCard: false,
      );

      String? selected;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AccountCardPicker(
              accounts: [bank],
              selectedId: selected,
              onSelected: (id) => selected = id,
            ),
          ),
        ),
      );

      expect(find.text('Chase Checking'), findsOneWidget);
    });
  });
}
