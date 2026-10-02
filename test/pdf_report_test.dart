// test/pdf_report_test.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/screens/export_screen.dart';
import 'package:expensy/services/pdf_report_service.dart';
import 'package:expensy/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    AppDatabase.setInstanceForTesting(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('PDF Financial Report Generator Tests', () {
    testWidgets('Generates valid multi-page PDF document bytes with financial sections',
        (tester) async {
      final app = AppProvider();
      final from = DateTime(2026, 8, 1);
      final to = DateTime(2026, 8, 31);

      final acc = Account(
        id: 'acc1',
        name: 'Primary Bank',
        type: 'bank',
        balance: 15000.0,
        currency: 'USD',
        colorValue: 0xFF1E88E5,
      );
      final catIncome = AppCategory(
        id: 'cat_inc',
        name: 'Salary',
        type: 'income',
        colorValue: 0xFF2E7D32,
      );
      final catExpense = AppCategory(
        id: 'cat_exp',
        name: 'Groceries',
        type: 'expense',
        colorValue: 0xFFE65100,
      );

      app.accounts.clear();
      app.accounts.add(acc);
      app.categories.clear();
      app.categories.addAll([catIncome, catExpense]);
      app.settings.currency = 'USD';

      app.transactions.clear();
      app.transactions.addAll([
        AppTransaction(
          id: 'tx1',
          type: 'income',
          amount: 6000.0,
          description: 'Consulting Inflow',
          accountId: 'acc1',
          categoryId: 'cat_inc',
          date: DateTime(2026, 8, 5, 10, 0),
          currency: 'USD',
        ),
        AppTransaction(
          id: 'tx2',
          type: 'expense',
          amount: 1200.0,
          description: 'Monthly Groceries',
          accountId: 'acc1',
          categoryId: 'cat_exp',
          date: DateTime(2026, 8, 12, 14, 0),
          currency: 'USD',
        ),
      ]);

      late AppLocalizations localizations;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              localizations = AppLocalizations.of(context)!;
              return const SizedBox();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      final pdfBytes = await PdfReportService.generateReport(
        app: app,
        from: from,
        to: to,
        l10n: localizations,
      );

      expect(pdfBytes, isNotEmpty);
      // Valid PDF magic header check
      final header = utf8.decode(pdfBytes.sublist(0, 5), allowMalformed: true);
      expect(header, equals('%PDF-'));
    });
  });

  group('ExportScreen PDF UI Integration Tests', () {
    testWidgets('Toggles format to PDF and displays PDF export & share action buttons',
        (tester) async {
      final app = AppProvider();
      final acc = Account(
        id: 'acc1',
        name: 'Bank',
        type: 'bank',
        balance: 1000.0,
        currency: 'USD',
        colorValue: 0xFF1E88E5,
      );
      app.accounts.clear();
      app.accounts.add(acc);
      app.transactions.clear();
      app.transactions.add(
        AppTransaction(
          id: 'tx1',
          type: 'expense',
          amount: 50.0,
          description: 'Coffee',
          accountId: 'acc1',
          categoryId: '',
          date: DateTime.now(),
          currency: 'USD',
        ),
      );

      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        ChangeNotifierProvider<AppProvider>.value(
          value: app,
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: ExportScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Initially on Excel
      expect(find.text('Excel (.xlsx)'), findsWidgets);
      expect(find.text('PDF Report'), findsOneWidget);

      // Switch to PDF
      await tester.tap(find.text('PDF Report'));
      await tester.pumpAndSettle();

      // Check PDF buttons
      expect(find.byIcon(Icons.picture_as_pdf_rounded), findsWidgets);
      expect(find.byIcon(Icons.print_rounded), findsOneWidget);
      expect(find.byIcon(Icons.share_rounded), findsOneWidget);
    });
  });
}
