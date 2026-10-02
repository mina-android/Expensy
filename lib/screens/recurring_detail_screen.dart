import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../database/db_helper.dart';
import '../l10n/app_localizations.dart';
import '../widgets/shared_widgets.dart';
import '../utils/snackbar.dart';
import '../theme/app_theme.dart';
import 'recurring_screen.dart'; // To access openRecurringSheet

class RecurringDetailScreen extends StatefulWidget {
  final RecurringPayment recurring;
  final String Function(double) fmt;
  const RecurringDetailScreen({super.key, required this.recurring, required this.fmt});

  @override
  State<RecurringDetailScreen> createState() => _RecurringDetailScreenState();
}

class _RecurringDetailScreenState extends State<RecurringDetailScreen> {
  AppLocalizations get l10n => AppLocalizations.of(context)!;
  List<RecurringHistoryEntry>? _history;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final h = await DBHelper.getRecurringHistory(widget.recurring.id);
    if (mounted) setState(() => _history = h);
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    
    // Attempt to find the up-to-date recurring payment in case it was edited
    final r = app.recurring.firstWhere(
      (x) => x.id == widget.recurring.id,
      orElse: () => widget.recurring,
    );

    final cat = app.categoryById(r.categoryId);
    final catColor = cat != null ? Color(cat.colorValue) : cs.primary;
    final total = r.totalPayments;
    final progress = (total != null && total > 0)
        ? (r.paidPayments / total).clamp(0.0, 1.0)
        : null;

    final days = r.nextDate.difference(DateTime.now()).inDays;
    final overdue = days < 0;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(r.name, style: const TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              openRecurringSheet(context, existing: r);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (c) => AlertDialog(
                  title: Text(l10n.recurring_del),
                  content: Text(l10n.recurring_confirmDelete),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(c),
                      child: Text(l10n.shared_widgets_cancel),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(foregroundColor: const Color(0xFFC62828)),
                      onPressed: () async {
                        Navigator.pop(c); // close dialog
                        Navigator.pop(context); // close screen
                        final undo = await app.deleteRecurringWithUndo(r.id);
                        if (context.mounted) {
                          showAppSnackbar(
                            context,
                            l10n.common_itemDeleted(r.name),
                            onUndo: undo,
                          );
                        }
                      },
                      child: Text(l10n.shared_widgets_delete_),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Summary Card
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cs.surfaceContainer.withValues(alpha: isDark ? 0.5 : 0.7),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.06),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Details',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: cs.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: overdue
                              ? const Color(0xFFC62828).withValues(alpha: 0.12)
                              : const Color(0xFF2E7D32).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: overdue
                                ? const Color(0xFFC62828).withValues(alpha: 0.25)
                                : const Color(0xFF2E7D32).withValues(alpha: 0.25),
                          ),
                        ),
                        child: Text(
                          overdue
                              ? l10n.recurring_overdue.toUpperCase()
                              : (days == 0
                                  ? l10n.recurring_dueToday.toUpperCase()
                                  : l10n.recurring_dueInDays(days.toString()).toUpperCase()),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                            color: overdue
                                ? const Color(0xFFC62828)
                                : const Color(0xFF2E7D32),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${widget.fmt(r.amount)} · ${r.frequencyLabel}',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: cs.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                  if (total != null && total > 0) ...[
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.recurring_paidPayments(r.paidPayments.toString(), total.toString()),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: cs.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                        Text(
                          '${(progress! * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: cs.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressCard(
                      value: progress,
                      color: catColor,
                    ),
                  ],
                ],
              ),
            ),
          ),
          
          // Recurring Metadata Stats Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _DetailStat('Linked Account', app.accountById(r.accountId)?.name ?? 'Deleted Account')),
                        Expanded(child: _DetailStat('Category', app.categoryById(r.categoryId)?.name ?? 'None')),
                      ],
                    ),
                    const Divider(height: 16, thickness: 0.5),
                    Row(
                      children: [
                        Expanded(child: _DetailStat('Frequency', '${r.freqVal} ${r.freqUnit}')),
                        Expanded(child: _DetailStat('Type', r.paymentType.toUpperCase())),
                      ],
                    ),
                    const Divider(height: 16, thickness: 0.5),
                    Row(
                      children: [
                        Expanded(child: _DetailStat('Start Date', DateFormat('MMM dd, yyyy').format(r.startDate))),
                        Expanded(child: _DetailStat('Next Due Date', DateFormat('MMM dd, yyyy').format(r.nextDate))),
                      ],
                    ),
                    const Divider(height: 16, thickness: 0.5),
                    Row(
                      children: [
                        Expanded(child: _DetailStat('Auto Pay', r.autoPayEnabled ? 'Enabled (${r.autoPayTime})' : 'Disabled')),
                        Expanded(child: _DetailStat('Reminder', r.reminderEnabled ? 'Enabled (${r.reminderTime})' : 'Disabled')),
                      ],
                    ),
                    if (r.endDate != null) ...[
                      const Divider(height: 16, thickness: 0.5),
                      Row(
                        children: [
                          Expanded(child: _DetailStat('End Date', DateFormat('MMM dd, yyyy').format(r.endDate!))),
                          Expanded(child: _DetailStat('Total Value', widget.fmt(r.totalAmount))),
                        ],
                      ),
                    ],
                    if (r.notes.trim().isNotEmpty) ...[
                      const Divider(height: 16, thickness: 0.5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Notes',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: cs.onSurface.withValues(alpha: 0.5),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  r.notes,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // Payment History Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Row(
              children: [
                Text(
                  'Payment History',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface.withValues(alpha: 0.6),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: _history == null
                ? const Center(child: CircularProgressIndicator())
                : _history!.isEmpty
                    ? Center(
                        child: Text(
                          l10n.recurring_noHistoryYet,
                          style: TextStyle(
                            fontSize: 14,
                            color: cs.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                        itemCount: _history!.length,
                        itemBuilder: (context, index) {
                          final h = _history![index];
                          return _HistoryRow(entry: h, fmt: widget.fmt);
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class _DetailStat extends StatelessWidget {
  final String label;
  final String value;
  const _DetailStat(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: cs.onSurface.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _HistoryRow extends StatelessWidget {
  final RecurringHistoryEntry entry;
  final String Function(double) fmt;
  const _HistoryRow({required this.entry, required this.fmt});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isPaid = entry.action == 'paid';
    final color = isPaid ? const Color(0xFF2E7D32) : const Color(0xFF785900);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            isPaid ? Icons.check_rounded : Icons.skip_next_rounded,
            size: 18,
            color: color,
          ),
        ),
        title: Text(
          isPaid ? 'Payment Paid' : 'Payment Skipped',
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
        ),
        subtitle: Text(
          DateFormat('MMM dd, yyyy · HH:mm').format(entry.date),
          style: TextStyle(
            fontSize: 11,
            color: cs.onSurface.withValues(alpha: 0.5),
          ),
        ),
        trailing: Text(
          formatAmount(entry.amount, entry.currency),
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
