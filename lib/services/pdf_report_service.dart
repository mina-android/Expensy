// lib/services/pdf_report_service.dart
import 'dart:typed_data';
import 'package:flutter/material.dart' show BuildContext;
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../l10n/app_localizations.dart';
import '../providers/app_provider.dart';

class PdfReportService {
  PdfReportService._();

  /// Generates the complete multi-page PDF financial statement.
  static Future<Uint8List> generateReport({
    required AppProvider app,
    required DateTime from,
    required DateTime to,
    required AppLocalizations l10n,
  }) async {
    final doc = pw.Document();

    final fromStart = DateTime(from.year, from.month, from.day);
    final toEnd = DateTime(to.year, to.month, to.day, 23, 59, 59);

    final filteredTxs = app.transactions
        .where((t) => !t.date.isBefore(fromStart) && !t.date.isAfter(toEnd))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    final baseCurrency = app.settings.currency;

    // Financial calculations in base currency
    double totalInflow = 0.0;
    double totalOutflow = 0.0;
    final Map<String, double> categoryExpenseTotals = {};

    for (final t in filteredTxs) {
      final acct = app.accountById(t.accountId);
      final txCur = t.currency.isNotEmpty ? t.currency : (acct?.currency ?? baseCurrency);
      final convertedAmt = app.convertToMain(t.amount, txCur);

      if (t.type == 'income') {
        totalInflow += convertedAmt;
      } else if (t.type == 'expense') {
        totalOutflow += convertedAmt;
        final catId = t.categoryId;
        if (catId.isNotEmpty) {
          categoryExpenseTotals[catId] =
              (categoryExpenseTotals[catId] ?? 0.0) + convertedAmt;
        }
      }
    }

    final netSaved = totalInflow - totalOutflow;
    final savingsRate = totalInflow > 0
        ? ((netSaved / totalInflow) * 100).clamp(0.0, 100.0)
        : 0.0;

    final sortedCategories = categoryExpenseTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final liveAssets = app.totalWealthAssets;
    final liveLiabilities = app.totalWealthLiabilities;
    final liveNetWorth = app.liveNetWorth;

    final dateRangeStr =
        '${DateFormat('yyyy-MM-dd').format(from)} - ${DateFormat('yyyy-MM-dd').format(to)}';
    final generatedOnStr = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

    final primaryColor = PdfColor.fromHex('#1E88E5');
    final incomeColor = PdfColor.fromHex('#2E7D32');
    final expenseColor = PdfColor.fromHex('#C62828');
    final grayLight = PdfColor.fromHex('#F5F5F5');
    final grayBorder = PdfColor.fromHex('#E0E0E0');

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) => pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 16),
          padding: const pw.EdgeInsets.only(bottom: 12),
          decoration: pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(color: primaryColor, width: 2),
            ),
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'EXPENSY',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  pw.Text(
                    l10n.export_pdfTitle,
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    'Period: $dateRangeStr',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                  pw.Text(
                    'Currency: $baseCurrency',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                  pw.Text(
                    'Generated: $generatedOnStr',
                    style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
                  ),
                ],
              ),
            ],
          ),
        ),
        footer: (context) => pw.Container(
          margin: const pw.EdgeInsets.only(top: 16),
          padding: const pw.EdgeInsets.only(top: 8),
          decoration: const pw.BoxDecoration(
            border: pw.Border(top: pw.BorderSide(color: PdfColors.grey300)),
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                l10n.export_pdfGeneratedBy.replaceAll('•', '-'),
                style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
              ),
              pw.Text(
                'Page ${context.pageNumber} of ${context.pagesCount}',
                style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
              ),
            ],
          ),
        ),
        build: (context) => [
          // ── Section 1: Executive Summary ──────────────────────────────────
          pw.Text(
            l10n.export_pdfSummary,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.Table(
            border: pw.TableBorder.all(color: grayBorder, width: 0.5),
            children: [
              pw.TableRow(
                decoration: pw.BoxDecoration(color: grayLight),
                children: [
                  _tableCell(l10n.export_pdfInflow, isHeader: true),
                  _tableCell(l10n.export_pdfOutflow, isHeader: true),
                  _tableCell(l10n.export_pdfNet, isHeader: true),
                  _tableCell(l10n.export_pdfSavingsRate, isHeader: true),
                  _tableCell('Transactions', isHeader: true),
                ],
              ),
              pw.TableRow(
                children: [
                  _tableCell(
                    '+${totalInflow.toStringAsFixed(2)} $baseCurrency',
                    color: incomeColor,
                    bold: true,
                  ),
                  _tableCell(
                    '-${totalOutflow.toStringAsFixed(2)} $baseCurrency',
                    color: expenseColor,
                    bold: true,
                  ),
                  _tableCell(
                    '${netSaved >= 0 ? '+' : ''}${netSaved.toStringAsFixed(2)} $baseCurrency',
                    color: netSaved >= 0 ? incomeColor : expenseColor,
                    bold: true,
                  ),
                  _tableCell(
                    '${savingsRate.toStringAsFixed(1)}%',
                    bold: true,
                  ),
                  _tableCell('${filteredTxs.length}', bold: true),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 18),

          // ── Section 2: Wealth Status / Net Worth ──────────────────────────
          pw.Text(
            l10n.export_pdfNetWorthBreakdown,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.Table(
            border: pw.TableBorder.all(color: grayBorder, width: 0.5),
            children: [
              pw.TableRow(
                decoration: pw.BoxDecoration(color: grayLight),
                children: [
                  _tableCell('Total Assets', isHeader: true),
                  _tableCell('Total Liabilities', isHeader: true),
                  _tableCell('Current Net Worth', isHeader: true),
                ],
              ),
              pw.TableRow(
                children: [
                  _tableCell(
                    '${liveAssets.toStringAsFixed(2)} $baseCurrency',
                    color: incomeColor,
                    bold: true,
                  ),
                  _tableCell(
                    '${liveLiabilities.toStringAsFixed(2)} $baseCurrency',
                    color: expenseColor,
                    bold: true,
                  ),
                  _tableCell(
                    '${liveNetWorth.toStringAsFixed(2)} $baseCurrency',
                    color: primaryColor,
                    bold: true,
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 18),

          // ── Section 3: Category Breakdown ─────────────────────────────────
          if (sortedCategories.isNotEmpty) ...[
            pw.Text(
              l10n.export_pdfCategoryBreakdown,
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 8),
            pw.Table(
              border: pw.TableBorder.all(color: grayBorder, width: 0.5),
              children: [
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: grayLight),
                  children: [
                    _tableCell('Category', isHeader: true),
                    _tableCell('Amount ($baseCurrency)', isHeader: true),
                    _tableCell('% of Total Expenses', isHeader: true),
                  ],
                ),
                ...sortedCategories.map((entry) {
                  final cat = app.categoryById(entry.key);
                  final catName = cat?.name ?? 'Other';
                  final pct = totalOutflow > 0
                      ? (entry.value / totalOutflow * 100).clamp(0.0, 100.0)
                      : 0.0;
                  return pw.TableRow(
                    children: [
                      _tableCell(catName),
                      _tableCell(entry.value.toStringAsFixed(2)),
                      _tableCell('${pct.toStringAsFixed(1)}%'),
                    ],
                  );
                }),
              ],
            ),
            pw.SizedBox(height: 18),
          ],

          // ── Section 4: Itemized Transactions ──────────────────────────────
          pw.Text(
            l10n.export_pdfTransactions,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          if (filteredTxs.isEmpty)
            pw.Padding(
              padding: const pw.EdgeInsets.all(12),
              child: pw.Text(l10n.export_pdfNoTransactions),
            )
          else
            pw.Table(
              border: pw.TableBorder.all(color: grayBorder, width: 0.5),
              children: [
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: grayLight),
                  children: [
                    _tableCell(l10n.export_pdfDate, isHeader: true),
                    _tableCell(l10n.export_pdfDescription, isHeader: true),
                    _tableCell(l10n.recurring_category, isHeader: true),
                    _tableCell(l10n.add_transaction_account, isHeader: true),
                    _tableCell(l10n.add_transaction_amount, isHeader: true),
                  ],
                ),
                ...filteredTxs.map((t) {
                  final acct = app.accountById(t.accountId);
                  final cat = app.categoryById(t.categoryId);
                  final isIncome = t.type == 'income';
                  final displayCur = t.currency.isNotEmpty
                      ? t.currency
                      : (acct?.currency ?? baseCurrency);

                  return pw.TableRow(
                    children: [
                      _tableCell(
                        DateFormat('yyyy-MM-dd').format(t.date),
                        fontSize: 8.5,
                      ),
                      _tableCell(
                        t.description.isNotEmpty ? t.description : '-',
                        fontSize: 8.5,
                      ),
                      _tableCell(
                        cat?.name ?? '-',
                        fontSize: 8.5,
                      ),
                      _tableCell(
                        acct?.name ?? '-',
                        fontSize: 8.5,
                      ),
                      _tableCell(
                        '${isIncome ? '+' : '-'}${t.amount.toStringAsFixed(2)} $displayCur',
                        color: isIncome ? incomeColor : expenseColor,
                        bold: true,
                        fontSize: 8.5,
                      ),
                    ],
                  );
                }),
              ],
            ),
        ],
      ),
    );

    return doc.save();
  }

  static pw.Widget _tableCell(
    String text, {
    bool isHeader = false,
    bool bold = false,
    PdfColor? color,
    double fontSize = 9.0,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: fontSize,
          fontWeight: (isHeader || bold) ? pw.FontWeight.bold : pw.FontWeight.normal,
          color: color ?? (isHeader ? PdfColors.black : PdfColors.grey900),
        ),
      ),
    );
  }

  /// Exports and saves the generated PDF report via the platform FilePicker.
  static Future<String?> savePdfReport({
    required BuildContext context,
    required AppProvider app,
    required DateTime from,
    required DateTime to,
    required AppLocalizations l10n,
  }) async {
    final bytes = await generateReport(
      app: app,
      from: from,
      to: to,
      l10n: l10n,
    );

    final fromStr = DateFormat('yyyy-MM-dd').format(from);
    final toStr = DateFormat('yyyy-MM-dd').format(to);
    final fileName = 'expensy_report_${fromStr}_to_$toStr.pdf';

    final saveUri = await FilePickerPlatform.instance.saveFile(
      dialogTitle: l10n.export_exportAsPdf,
      fileName: fileName,
      bytes: bytes,
      mimeType: 'application/pdf',
    );
    return saveUri?.toString();
  }

  /// Directly invokes the system print / preview sheet for the financial report.
  static Future<void> printPdfReport({
    required AppProvider app,
    required DateTime from,
    required DateTime to,
    required AppLocalizations l10n,
  }) async {
    final fromStr = DateFormat('yyyy-MM-dd').format(from);
    final toStr = DateFormat('yyyy-MM-dd').format(to);
    final fileName = 'expensy_report_${fromStr}_to_$toStr.pdf';

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) => generateReport(
        app: app,
        from: from,
        to: to,
        l10n: l10n,
      ),
      name: fileName,
    );
  }

  /// Opens the system share sheet with the generated PDF report.
  static Future<void> sharePdfReport({
    required AppProvider app,
    required DateTime from,
    required DateTime to,
    required AppLocalizations l10n,
  }) async {
    final bytes = await generateReport(
      app: app,
      from: from,
      to: to,
      l10n: l10n,
    );
    final fromStr = DateFormat('yyyy-MM-dd').format(from);
    final toStr = DateFormat('yyyy-MM-dd').format(to);
    final fileName = 'expensy_report_${fromStr}_to_$toStr.pdf';

    await Printing.sharePdf(bytes: bytes, filename: fileName);
  }
}
