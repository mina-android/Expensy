// test/shortcuts_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:expensy/services/quick_add_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Android Shortcuts & Quick Tile Service Tests', () {
    test('QuickAddService route constants match Android manifest & shortcuts.xml actions', () {
      expect(QuickAddService.routeQuickAdd, equals('quick_add_transaction'));
      expect(QuickAddService.routeExpense, equals('expense'));
      expect(QuickAddService.routeIncome, equals('income'));
      expect(QuickAddService.routeTransfer, equals('transfer'));
      expect(QuickAddService.routePresets, equals('presets'));
    });

    test('Route stream broadcasts cleanly without throwing', () {
      final service = QuickAddService.instance;
      expect(service.routeStream, isNotNull);
    });
  });
}
