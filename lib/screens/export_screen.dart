// lib/screens/export_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/app_provider.dart';
import '../services/pdf_report_service.dart';
import '../utils/haptics.dart';

enum ExportFormat { excel, pdf }

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});
  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  DateTime _from = DateTime.now().subtract(const Duration(days: 30));
  DateTime _to = DateTime.now();
  ExportFormat _selectedFormat = ExportFormat.excel;
  bool _busy = false;
  String? _ok;
  String? _err;

  Future<void> _pickFrom() async {
    final p = await showDatePicker(
      context: context,
      initialDate: _from,
      firstDate: DateTime(2000),
      lastDate: _to,
    );
    if (p != null) setState(() => _from = p);
  }

  Future<void> _pickTo() async {
    final p = await showDatePicker(
      context: context,
      initialDate: _to,
      firstDate: _from,
      lastDate: DateTime.now(),
    );
    if (p != null) setState(() => _to = p);
  }

  Future<void> _exportExcel(AppLocalizations l10n) async {
    setState(() {
      _busy = true;
      _ok = null;
      _err = null;
    });
    try {
      final path = await context
          .read<AppProvider>()
          .exportTransactionsExcel(
            from: _from,
            to: _to,
            dialogTitle: l10n.export_exportAsExcel,
          );
      if (!mounted) return;
      if (path != null) {
        AppHaptics.tap(context, HapticStrength.light);
        setState(() => _ok = path);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _err = e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _exportPdf(AppLocalizations l10n) async {
    setState(() {
      _busy = true;
      _ok = null;
      _err = null;
    });
    try {
      final app = context.read<AppProvider>();
      final path = await PdfReportService.savePdfReport(
        context: context,
        app: app,
        from: _from,
        to: _to,
        l10n: l10n,
      );
      if (!mounted) return;
      if (path != null) {
        AppHaptics.tap(context, HapticStrength.light);
        setState(() => _ok = path);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _err = e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _printPdf(AppLocalizations l10n) async {
    try {
      AppHaptics.tap(context, HapticStrength.light);
      final app = context.read<AppProvider>();
      await PdfReportService.printPdfReport(
        app: app,
        from: _from,
        to: _to,
        l10n: l10n,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _err = e.toString());
    }
  }

  Future<void> _sharePdf(AppLocalizations l10n) async {
    try {
      AppHaptics.tap(context, HapticStrength.light);
      final app = context.read<AppProvider>();
      await PdfReportService.sharePdfReport(
        app: app,
        from: _from,
        to: _to,
        l10n: l10n,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _err = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    final start = DateTime(_from.year, _from.month, _from.day);
    final end = DateTime(_to.year, _to.month, _to.day, 23, 59, 59);
    final count = app.transactions
        .where((t) => !t.date.isBefore(start) && !t.date.isAfter(end))
        .length;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isPdf = _selectedFormat == ExportFormat.pdf;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.export_exportTransactions,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Format Segmented Picker ─────────────────────────────────────
            Text(
              'EXPORT FORMAT',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(letterSpacing: 1),
            ),
            const SizedBox(height: 10),
            SegmentedButton<ExportFormat>(
              segments: [
                ButtonSegment<ExportFormat>(
                  value: ExportFormat.excel,
                  icon: const Icon(Icons.table_chart_outlined),
                  label: Text(l10n.export_formatExcelOption),
                ),
                ButtonSegment<ExportFormat>(
                  value: ExportFormat.pdf,
                  icon: const Icon(Icons.picture_as_pdf_outlined),
                  label: Text(l10n.export_formatPdfOption),
                ),
              ],
              selected: {_selectedFormat},
              onSelectionChanged: (newSelection) {
                AppHaptics.tap(context, HapticStrength.light);
                setState(() => _selectedFormat = newSelection.first);
              },
            ),
            const SizedBox(height: 24),

            // ── Date Range ──────────────────────────────────────────────────
            Text(
              l10n.export_dateRange,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(letterSpacing: 1),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _DateCard(
                    label: l10n.export_from,
                    date: _from,
                    onTap: _pickFrom,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: cs.onSurface.withValues(alpha: 0.4),
                  ),
                ),
                Expanded(
                  child: _DateCard(
                    label: l10n.export_to,
                    date: _to,
                    onTap: _pickTo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // ── Summary Box ─────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isPdf
                        ? Icons.picture_as_pdf_rounded
                        : Icons.table_chart_outlined,
                    color: cs.primary,
                    size: 26,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.export_txCount(count),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: cs.primary,
                          ),
                        ),
                        Text(
                          isPdf
                              ? l10n.export_formatPdf
                              : l10n.export_formatExcelXlsx,
                          style: TextStyle(
                            fontSize: 12,
                            color: cs.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            if (_ok != null) _Banner(ok: true, msg: l10n.export_saved(_ok!)),
            if (_err != null) _Banner(ok: false, msg: _err!),

            const SizedBox(height: 32),

            // ── Export Actions ──────────────────────────────────────────────
            FilledButton.icon(
              onPressed: count == 0 || _busy
                  ? null
                  : () => isPdf ? _exportPdf(l10n) : _exportExcel(l10n),
              icon: _busy
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Icon(
                      isPdf
                          ? Icons.picture_as_pdf_rounded
                          : Icons.save_alt_rounded,
                    ),
              label: Text(
                _busy
                    ? (isPdf ? l10n.export_pdfGenerating : l10n.export_exporting)
                    : (isPdf ? l10n.export_exportAsPdf : l10n.export_exportAsExcel),
              ),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
            ),

            if (isPdf) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: count == 0 || _busy ? null : () => _printPdf(l10n),
                      icon: const Icon(Icons.print_rounded, size: 20),
                      label: Text(l10n.export_pdfPrint),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: count == 0 || _busy ? null : () => _sharePdf(l10n),
                      icon: const Icon(Icons.share_rounded, size: 20),
                      label: Text(l10n.export_pdfShare),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _DateCard extends StatelessWidget {
  final String label;
  final DateTime date;
  final VoidCallback onTap;
  const _DateCard({
    required this.label,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: cs.surfaceContainer.withValues(alpha: isDark ? 0.35 : 0.55),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: cs.onSurface.withValues(alpha: 0.55),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${date.day}/${date.month}/${date.year}',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  final bool ok;
  final String msg;
  const _Banner({required this.ok, required this.msg});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = ok ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.15 : 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(
            ok ? Icons.check_circle_outline : Icons.error_outline,
            color: color,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              msg,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
