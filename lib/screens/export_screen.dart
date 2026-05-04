// lib/screens/export_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});
  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  bool _exporting = false;
  bool _done = false;
  String? _error;

  Future<void> _export() async {
    setState(() { _exporting = true; _done = false; _error = null; });
    try {
      await context.read<AppProvider>().exportTransactionsCSV();
      setState(() => _done = true);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _exporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final app      = context.watch<AppProvider>();
    final cs       = Theme.of(context).colorScheme;
    final currency = app.settings.currency;
    String fmt(double v) => formatAmount(v, currency);

    final totalIncome = app.transactions
        .where((t) => t.type == 'income')
        .fold(0.0, (s, t) => s + t.amount);
    final totalExpense = app.transactions
        .where((t) => t.type == 'expense')
        .fold(0.0, (s, t) => s + t.amount);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Export Transactions',
            style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status messages
            if (_done)
              Container(
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFA5D6A7)),
                ),
                child: const Row(children: [
                  Icon(Icons.check_circle_outline, color: Color(0xFF2E7D32)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text('Export complete! Check your share sheet.',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2E7D32))),
                  ),
                ]),
              ),
            if (_error != null)
              Container(
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFEF9A9A)),
                ),
                child: Row(children: [
                  const Icon(Icons.error_outline, color: Color(0xFFC62828)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('Error: $_error',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFC62828))),
                  ),
                ]),
              ),

            // Summary card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Export Summary',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 14),
                    _SummaryRow(
                      label: 'Total Transactions',
                      value: '${app.transactions.length}',
                    ),
                    _SummaryRow(
                      label: 'Income Entries',
                      value: '${app.transactions.where((t) => t.type == "income").length}',
                      valueColor: const Color(0xFF2E7D32),
                    ),
                    _SummaryRow(
                      label: 'Expense Entries',
                      value: '${app.transactions.where((t) => t.type == "expense").length}',
                      valueColor: const Color(0xFFC62828),
                    ),
                    _SummaryRow(
                      label: 'Total Income',
                      value: fmt(totalIncome),
                      valueColor: const Color(0xFF2E7D32),
                    ),
                    _SummaryRow(
                      label: 'Total Expense',
                      value: fmt(totalExpense),
                      valueColor: const Color(0xFFC62828),
                      last: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Format info card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CSV Format',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Date, Description, Type, Amount, Account, Category, Note',
                        style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Compatible with Excel, Google Sheets, and any CSV viewer.',
                      style: TextStyle(
                          fontSize: 12,
                          color: cs.onSurface.withValues(alpha: 0.6)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            if (app.transactions.isEmpty)
              const EmptyState(
                icon: Icons.receipt_long_outlined,
                message: 'No transactions to export',
                subMessage: 'Add some transactions first',
              )
            else
              FilledButton.icon(
                onPressed: _exporting ? null : _export,
                icon: _exporting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.file_download_outlined),
                label: Text(_exporting ? 'Exporting…' : 'Export as CSV'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  backgroundColor: const Color(0xFF1565C0),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label, value;
  final Color? valueColor;
  final bool last;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: last
            ? null
            : Border(
                bottom: BorderSide(
                    color: cs.outlineVariant.withValues(alpha: 0.5), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 14,
                  color: cs.onSurface.withValues(alpha: 0.7))),
          Text(value,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: valueColor ?? cs.onSurface)),
        ],
      ),
    );
  }
}
