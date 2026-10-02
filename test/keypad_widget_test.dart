import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expensy/widgets/app_numeric_keypad.dart';

void main() {
  testWidgets('AppNumericKeypad handles digit input, calculations and actions', (tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppNumericKeypad(
            controller: controller,
          ),
        ),
      ),
    );

    // Tap 1, 2, 5
    await tester.tap(find.text('1'));
    await tester.pump();
    await tester.tap(find.text('2'));
    await tester.pump();
    await tester.tap(find.text('5'));
    await tester.pump();
    expect(controller.text, '125');

    // Tap +
    await tester.tap(find.text('+'));
    await tester.pump();
    expect(controller.text, '125 + ');

    // Tap 7, 5
    await tester.tap(find.text('7'));
    await tester.pump();
    await tester.tap(find.text('5'));
    await tester.pump();
    expect(controller.text, '125 + 75');

    // Tap =
    await tester.tap(find.text('='));
    await tester.pump();
    expect(controller.text, '200');

    // Tap ⌫ (backspace)
    await tester.tap(find.byIcon(Icons.backspace_outlined));
    await tester.pump();
    expect(controller.text, '20');

    // Tap C (clear)
    await tester.tap(find.text('C'));
    await tester.pump();
    expect(controller.text, '');

    // Tap 2, 0, 0
    await tester.tap(find.text('2'));
    await tester.pump();
    await tester.tap(find.text('0'));
    await tester.pump();
    await tester.tap(find.text('0'));
    await tester.pump();
    expect(controller.text, '200');

    // Tap ×
    await tester.tap(find.text('×'));
    await tester.pump();
    expect(controller.text, '200 × ');

    // Tap 1, 5
    await tester.tap(find.text('1'));
    await tester.pump();
    await tester.tap(find.text('5'));
    await tester.pump();
    expect(controller.text, '200 × 15');

    // Tap % (percentage)
    await tester.tap(find.text('%'));
    await tester.pump();
    expect(controller.text, '30');

    // Tap -
    await tester.tap(find.text('-'));
    await tester.pump();

    // Tap 1, 0
    await tester.tap(find.text('1'));
    await tester.pump();
    await tester.tap(find.text('0'));
    await tester.pump();

    // Tap % (10% discount on 30 -> 27)
    await tester.tap(find.text('%'));
    await tester.pump();
    expect(controller.text, '27');
  });
}
