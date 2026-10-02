import 'package:flutter_test/flutter_test.dart';
import 'package:expensy/widgets/app_numeric_keypad.dart';

void main() {
  group('ExpressionEvaluator Unit Tests', () {
    test('Basic numbers and decimals', () {
      expect(ExpressionEvaluator.evaluate('100'), 100.0);
      expect(ExpressionEvaluator.evaluate('25.5'), 25.5);
      expect(ExpressionEvaluator.evaluate('0.75'), 0.75);
    });

    test('Addition and Subtraction', () {
      expect(ExpressionEvaluator.evaluate('10 + 20'), 30.0);
      expect(ExpressionEvaluator.evaluate('50 - 15'), 35.0);
      expect(ExpressionEvaluator.evaluate('100 - 40 - 10'), 50.0);
    });

    test('Multiplication and Division', () {
      expect(ExpressionEvaluator.evaluate('5 * 6'), 30.0);
      expect(ExpressionEvaluator.evaluate('5 × 6'), 30.0);
      expect(ExpressionEvaluator.evaluate('100 / 4'), 25.0);
      expect(ExpressionEvaluator.evaluate('100 ÷ 4'), 25.0);
    });

    test('Operator Precedence (PEMDAS/BODMAS)', () {
      // 10 + (5 * 2) = 20
      expect(ExpressionEvaluator.evaluate('10 + 5 * 2'), 20.0);
      expect(ExpressionEvaluator.evaluate('10 + 5 × 2'), 20.0);

      // (20 / 4) + (3 * 2) = 5 + 6 = 11
      expect(ExpressionEvaluator.evaluate('20 ÷ 4 + 3 × 2'), 11.0);

      // 50 - 10 * 2 = 50 - 20 = 30
      expect(ExpressionEvaluator.evaluate('50 - 10 × 2'), 30.0);
    });

    test('Incomplete trailing operators', () {
      expect(ExpressionEvaluator.evaluate('50 +'), 50.0);
      expect(ExpressionEvaluator.evaluate('100 ×'), 100.0);
    });

    test('Percentage calculation', () {
      // Single number percentage
      expect(ExpressionEvaluator.calculatePercentage('50'), 0.5);
      expect(ExpressionEvaluator.calculatePercentage('200'), 2.0);
      expect(ExpressionEvaluator.calculatePercentage('100'), 1.0);

      // Multiplication percentage (portion)
      expect(ExpressionEvaluator.calculatePercentage('200 * 15'), 30.0);
      expect(ExpressionEvaluator.calculatePercentage('200 × 15'), 30.0);
      expect(ExpressionEvaluator.calculatePercentage('80 × 25'), 20.0);

      // Addition percentage (markup / tax)
      expect(ExpressionEvaluator.calculatePercentage('100 + 15'), 115.0);
      expect(ExpressionEvaluator.calculatePercentage('200 + 10'), 220.0);

      // Subtraction percentage (discount)
      expect(ExpressionEvaluator.calculatePercentage('100 - 20'), 80.0);
      expect(ExpressionEvaluator.calculatePercentage('200 - 15'), 170.0);

      // Division percentage
      expect(ExpressionEvaluator.calculatePercentage('100 / 50'), 200.0);
      expect(ExpressionEvaluator.calculatePercentage('100 ÷ 50'), 200.0);

      // Incomplete trailing operators should return null
      expect(ExpressionEvaluator.calculatePercentage('100 +'), isNull);
      expect(ExpressionEvaluator.calculatePercentage('100 ×'), isNull);

      // Evaluate string ending in %
      expect(ExpressionEvaluator.evaluate('50%'), 0.5);
      expect(ExpressionEvaluator.evaluate('200 * 15%'), 30.0);
      expect(ExpressionEvaluator.evaluate('100 - 20%'), 80.0);
    });

    test('Format results cleanly', () {
      expect(ExpressionEvaluator.formatResult(50.0), '50');
      expect(ExpressionEvaluator.formatResult(50.5), '50.5');
      expect(ExpressionEvaluator.formatResult(50.25), '50.25');
      expect(ExpressionEvaluator.formatResult(100.000), '100');
    });
  });
}
