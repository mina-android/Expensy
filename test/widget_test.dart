import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/main.dart';

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    final provider = AppProvider();
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: const ExpensyApp(),
      ),
    );
    expect(find.byType(ExpensyApp), findsOneWidget);
  });
}
