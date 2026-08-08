// lib/screens/export_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});
  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  DateTime _from = DateTime.now().subtract(const Duration(days: 30));
  DateTime _to = DateTime.now();
  bool _busy = false;
  String? _ok;
  String? _err;

  Future<void> _pickFrom() async {
    final p = await showDatePicker(
        context: context,
        initialDate: _from,
        firstDate: DateTime(2000),
        lastDate: _to);
    if (p != null) setState(() => _from = p);
  }

  Future<void> _pickTo() async {
    final p = await showDatePicker(
        context: context,
        initialDate: _to,
        firstDate: _from,
        lastDate: DateTime.now());
    if (p != null) setState(() => _to = p);
  }

  Future<void> _export(AppLocalizations l10n) async {
    setState(() {
      _busy = true;
      _ok = null;
      _err = null;
    });
    try {
      final path = await context
          .read<AppProvider>()
          .exportTransactionsExcel(from: _from, to: _to);
      if (!mounted) return;
      if (path != null) {
        setState(() => _ok = path);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _err = e.toString());
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
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

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.export_exportTransactions,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(l10n.export_dateRange,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(
                child: _DateCard(
                    label: l10n.export_from, date: _from, onTap: _pickFrom)),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.arrow_forward_rounded,
                    color: cs.onSurface.withValues(alpha: 0.4))),
            Expanded(
                child: _DateCard(
                    label: l10n.export_to, date: _to, onTap: _pickTo)),
          ]),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(14)),
            child: Row(children: [
              Icon(Icons.table_chart_outlined, color: cs.primary, size: 24),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.export_txCount(count),
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: cs.primary)),
                  Text(l10n.export_formatExcelXlsx,
                      style: TextStyle(
                          fontSize: 12,
                          color: cs.onPrimaryContainer.withValues(alpha: 0.6))),
                ],
              )),
            ]),
          ),
          const SizedBox(height: 16),
          if (_ok != null) _Banner(ok: true, msg: l10n.export_saved(_ok!)),
          if (_err != null) _Banner(ok: false, msg: _err!),
          const Spacer(),
          FilledButton.icon(
            onPressed: count == 0 || _busy ? null : () => _export(l10n),
            icon: _busy
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white))
                : const Icon(Icons.save_alt_rounded),
            label:
                Text(_busy ? l10n.export_exporting : l10n.export_exportAsExcel),
            style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28))),
          ),
        ]),
      ),
    );
  }
}

class _DateCard extends StatelessWidget {
  final String label;
  final DateTime date;
  final VoidCallback onTap;
  const _DateCard(
      {required this.label, required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cs.primary.withValues(alpha: 0.4)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface.withValues(alpha: 0.55))),
          const SizedBox(height: 4),
          Text('${date.day}/${date.month}/${date.year}',
              style:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
        ]),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  final bool ok;
  final String msg;
  const _Banner({required this.ok, required this.msg});
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: ok ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
            borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          Icon(ok ? Icons.check_circle_outline : Icons.error_outline,
              color: ok ? const Color(0xFF2E7D32) : const Color(0xFFC62828)),
          const SizedBox(width: 8),
          Expanded(
              child: Text(msg,
                  style: TextStyle(
                      fontSize: 12,
                      color: ok
                          ? const Color(0xFF2E7D32)
                          : const Color(0xFFC62828)))),
        ]),
      );
}
