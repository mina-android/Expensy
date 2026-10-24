import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
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
    final h = await context.read<AppProvider>().getHistoryFor(widget.recurring.id);
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
    final upcoming = r.upcomingPaymentDates;

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
                  icon: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: cs.error.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.delete_outline_rounded,
                        color: cs.error, size: 26),
                  ),
                  title:
                      Text(l10n.recurring_del, textAlign: TextAlign.center),
                  content: Text(l10n.recurring_confirmDelete,
                      textAlign: TextAlign.center),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(46),
                              side: BorderSide(
                                  color: cs.outlineVariant
                                      .withValues(alpha: 0.6)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            onPressed: () => Navigator.pop(c),
                            child: Text(l10n.shared_widgets_cancel),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: cs.error,
                              foregroundColor: cs.onError,
                              minimumSize: const Size.fromHeight(46),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            onPressed: () async {
                              Navigator.pop(c); // close dialog
                              Navigator.pop(context); // close screen
                              final undo =
                                  await app.deleteRecurringWithUndo(r.id);
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
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
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

          // Upcoming Payments Section (Installment Schedule)
          if (r.endDate != null) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upcoming Payments',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface.withValues(alpha: 0.6),
                      letterSpacing: 0.5,
                    ),
                  ),
                  if (upcoming.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: cs.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${upcoming.length} remaining',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: cs.primary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (upcoming.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainer.withValues(alpha: isDark ? 0.35 : 0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.black.withValues(alpha: 0.04),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle_outline_rounded,
                            size: 18, color: Color(0xFF2E7D32)),
                        const SizedBox(width: 8),
                        Text(
                          'All installments completed',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: cs.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    for (int i = 0; i < upcoming.length; i++)
                      _UpcomingRow(
                        index: i,
                        dueDate: upcoming[i],
                        recurring: r,
                        fmt: widget.fmt,
                        isFirst: i == 0,
                        onPay: () async {
                          await app.markRecurringPaid(r);
                          await _loadHistory();
                        },
                        onSkip: () async {
                          final ok = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              icon: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF785900).withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.skip_next_rounded,
                                    color: Color(0xFF785900), size: 26),
                              ),
                              title: Text(l10n.recurring_skipNextPayment, textAlign: TextAlign.center),
                              content: Text(
                                l10n.recurring_nextDate(DateFormat('d MMM yyyy').format(r.calcNextDate())),
                                textAlign: TextAlign.center,
                              ),
                              actionsAlignment: MainAxisAlignment.center,
                              actions: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          minimumSize: const Size.fromHeight(46),
                                          side: BorderSide(
                                              color: cs.outlineVariant.withValues(alpha: 0.6)),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(14)),
                                        ),
                                        onPressed: () => Navigator.pop(ctx, false),
                                        child: Text(l10n.recurring_cancel),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: FilledButton(
                                        style: FilledButton.styleFrom(
                                          backgroundColor: const Color(0xFF785900),
                                          minimumSize: const Size.fromHeight(46),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(14)),
                                        ),
                                        onPressed: () => Navigator.pop(ctx, true),
                                        child: Text(l10n.recurring_skip),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                          if (ok == true && mounted) {
                            await app.skipNextRecurring(r);
                            await _loadHistory();
                          }
                        },
                      ),
                  ],
                ),
              ),
          ],

          // Payment History Header
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
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

          if (_history == null)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_history!.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Text(
                  l10n.recurring_noHistoryYet,
                  style: TextStyle(
                    fontSize: 14,
                    color: cs.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  for (final h in _history!)
                    _HistoryRow(entry: h, fmt: widget.fmt),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _UpcomingRow extends StatelessWidget {
  final int index;
  final DateTime dueDate;
  final RecurringPayment recurring;
  final String Function(double) fmt;
  final bool isFirst;
  final VoidCallback onPay;
  final VoidCallback onSkip;

  const _UpcomingRow({
    required this.index,
    required this.dueDate,
    required this.recurring,
    required this.fmt,
    required this.isFirst,
    required this.onPay,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    final installmentNum = recurring.paidPayments + index + 1;
    final total = recurring.totalPayments;
    final installmentLabel = total != null && total > 0
        ? '#$installmentNum of $total'
        : '#$installmentNum';

    final days = dueDate.difference(DateTime.now()).inDays;
    final overdue = days < 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isFirst
            ? (overdue
                ? const Color(0xFFC62828).withValues(alpha: isDark ? 0.08 : 0.04)
                : cs.primary.withValues(alpha: isDark ? 0.08 : 0.04))
            : cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isFirst
              ? (overdue
                  ? const Color(0xFFC62828).withValues(alpha: 0.35)
                  : cs.primary.withValues(alpha: 0.35))
              : (isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.05)),
          width: isFirst ? 1.5 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: isFirst
                        ? (overdue
                            ? const Color(0xFFC62828).withValues(alpha: 0.15)
                            : cs.primary.withValues(alpha: 0.15))
                        : cs.surfaceContainerHighest.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      '#$installmentNum',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: isFirst
                            ? (overdue ? const Color(0xFFC62828) : cs.primary)
                            : cs.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            DateFormat('MMM dd, yyyy').format(dueDate),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                          if (isFirst) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: overdue
                                    ? const Color(0xFFC62828).withValues(alpha: 0.12)
                                    : const Color(0xFF2E7D32).withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                overdue
                                    ? l10n.recurring_overdue
                                    : (days == 0
                                        ? l10n.recurring_dueToday
                                        : l10n.recurring_dueInDays(days.toString())),
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  color: overdue
                                      ? const Color(0xFFC62828)
                                      : const Color(0xFF2E7D32),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        installmentLabel,
                        style: TextStyle(
                          fontSize: 11,
                          color: cs.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  fmt(recurring.amount),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: cs.onSurface,
                  ),
                ),
              ],
            ),
            if (isFirst) ...[
              const SizedBox(height: 10),
              Divider(
                height: 1,
                thickness: 0.5,
                color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.06),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      minimumSize: const Size(0, 34),
                      side: BorderSide(
                        color: const Color(0xFF785900).withValues(alpha: 0.5),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.skip_next_rounded, size: 16, color: Color(0xFF785900)),
                    label: Text(
                      l10n.recurring_skip,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF785900),
                      ),
                    ),
                    onPressed: onSkip,
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      minimumSize: const Size(0, 34),
                      backgroundColor: cs.primary,
                      foregroundColor: cs.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.check_circle_outline_rounded, size: 16),
                    label: Text(
                      l10n.recurring_pay,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: onPay,
                  ),
                ],
              ),
            ],
          ],
        ),
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
