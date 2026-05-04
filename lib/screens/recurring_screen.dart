// lib/screens/recurring_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

class RecurringScreen extends StatelessWidget {
  const RecurringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app      = context.watch<AppProvider>();
    final cs       = Theme.of(context).colorScheme;
    final currency = app.settings.currency;
    String fmt(double v) => formatAmount(v, currency);

    // Estimated monthly cost across all recurring payments
    double estMonthly = 0;
    for (final r in app.recurring) {
      switch (r.freqUnit) {
        case 'days':   estMonthly += r.amount * (30.44 / r.freqVal); break;
        case 'weeks':  estMonthly += r.amount * (4.33  / r.freqVal); break;
        case 'months': estMonthly += r.amount / r.freqVal;           break;
        case 'years':  estMonthly += r.amount / (12 * r.freqVal);    break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recurring Payments',
            style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  const Text('Monthly',
                      style: TextStyle(fontSize: 9, color: Colors.white70)),
                  Text(fmt(estMonthly),
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontSize: 13)),
                ]),
                const SizedBox(width: 14),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  const Text('Weekly',
                      style: TextStyle(fontSize: 9, color: Colors.white70)),
                  Text(fmt(estMonthly / 4.33),
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontSize: 13)),
                ]),
              ],
            ),
          ),
        ],
      ),
      body: app.recurring.isEmpty
          ? const EmptyState(
              icon: Icons.repeat_rounded,
              message: 'No recurring payments',
              subMessage: 'Track subscriptions & instalments',
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
              itemCount: app.recurring.length,
              itemBuilder: (_, i) =>
                  _RecurringCard(r: app.recurring[i], app: app, fmt: fmt),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSheet(context, app),
        child: const Icon(Icons.add),
      ),
    );
  }

  static void _showSheet(BuildContext ctx, AppProvider app,
      {RecurringPayment? existing}) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _RecurringSheet(app: app, existing: existing),
    );
  }
}

// ─── Card ──────────────────────────────────────────────────────────────────
class _RecurringCard extends StatelessWidget {
  final RecurringPayment r;
  final AppProvider app;
  final String Function(double) fmt;
  const _RecurringCard(
      {required this.r, required this.app, required this.fmt});

  @override
  Widget build(BuildContext context) {
    final cs       = Theme.of(context).colorScheme;
    final cat      = app.categoryById(r.categoryId);
    final catColor = cat != null ? Color(cat.colorValue) : cs.primary;

    final total     = r.totalPayments;     // null if no last payment set
    final remaining = r.remainingPayments; // null if ongoing
    final progress  = (total != null && total > 0)
        ? (r.paidPayments / total).clamp(0.0, 1.0)
        : null;

    final daysLeft = r.nextDate.difference(DateTime.now()).inDays;
    final overdue  = daysLeft < 0;

    // Label for the last payment / end date
    final lastLabel = r.endDate != null
        ? DateFormat('d MMM yyyy').format(r.endDate!)
        : 'Ongoing';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(children: [
              CategoryDot(category: cat, size: 44),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15)),
                    Text(
                      '${fmt(r.amount)} · ${r.frequencyLabel}',
                      style: TextStyle(
                          fontSize: 12,
                          color: cs.onSurface.withValues(alpha: 0.6)),
                    ),
                    // Show first → last payment dates
                    Text(
                      r.endDate != null
                          ? '${DateFormat('d MMM yyyy').format(r.startDate)} → $lastLabel'
                          : 'From ${DateFormat('d MMM yyyy').format(r.startDate)} · Ongoing',
                      style: TextStyle(
                          fontSize: 11,
                          color: cs.onSurface.withValues(alpha: 0.5)),
                    ),
                  ],
                ),
              ),
            ]),

            // Progress bar + payment count (only when last payment is set)
            if (total != null && total > 0) ...[
              const SizedBox(height: 12),
              LinearProgressCard(value: progress ?? 0, color: catColor),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${r.paidPayments} of $total paid',
                    style: TextStyle(
                        fontSize: 11,
                        color: cs.onSurface.withValues(alpha: 0.6)),
                  ),
                  // Remaining payments + remaining amount
                  if (remaining != null && remaining > 0)
                    Text(
                      '$remaining left · ${fmt(r.remainingAmount)}',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: cs.primary),
                    ),
                ],
              ),
              // Total cost line
              const SizedBox(height: 2),
              Text(
                'Total: ${fmt(r.totalAmount)}  (${fmt(r.amount)} × $total)',
                style: TextStyle(
                    fontSize: 11,
                    color: cs.onSurface.withValues(alpha: 0.5)),
              ),
            ],

            const SizedBox(height: 10),

            // Action buttons row
            Row(children: [
              // Due badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: overdue
                      ? const Color(0xFFFFEBEE)
                      : const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  overdue
                      ? 'Overdue!'
                      : daysLeft == 0
                          ? 'Due Today'
                          : 'Due in ${daysLeft}d',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: overdue
                          ? const Color(0xFFC62828)
                          : const Color(0xFF2E7D32)),
                ),
              ),
              const Spacer(),
              _ActionBtn(
                icon: Icons.edit_outlined,
                label: 'Edit',
                color: cs.secondary,
                onTap: () =>
                    RecurringScreen._showSheet(context, app, existing: r),
              ),
              const SizedBox(width: 6),
              _ActionBtn(
                icon: Icons.skip_next_outlined,
                label: 'Skip',
                color: const Color(0xFF785900),
                onTap: () async {
                  final ok = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Skip Next Payment?'),
                      content: Text(
                          'The next due date will move to '
                          '${DateFormat('d MMM yyyy').format(r.calcNextDate())}'),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text('Cancel')),
                        FilledButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: const Text('Skip')),
                      ],
                    ),
                  );
                  if (ok == true && context.mounted) app.skipNextRecurring(r);
                },
              ),
              const SizedBox(width: 6),
              _ActionBtn(
                icon: Icons.check_circle_outline,
                label: 'Pay',
                color: cs.primary,
                onTap: () => app.markRecurringPaid(r),
              ),
              const SizedBox(width: 6),
              _ActionBtn(
                icon: Icons.delete_outline_rounded,
                label: 'Del',
                color: const Color(0xFFC62828),
                onTap: () async {
                  final ok = await showDeleteConfirm(context, r.name);
                  if (ok && context.mounted) app.deleteRecurring(r.id);
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionBtn(
      {required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 3),
            Text(label,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: color)),
          ]),
        ),
      );
}

// ─── Add / Edit sheet ──────────────────────────────────────────────────────
class _RecurringSheet extends StatefulWidget {
  final AppProvider app;
  final RecurringPayment? existing;
  const _RecurringSheet({required this.app, this.existing});

  @override
  State<_RecurringSheet> createState() => _RecurringSheetState();
}

class _RecurringSheetState extends State<_RecurringSheet> {
  final _nameCtrl    = TextEditingController();
  final _amountCtrl  = TextEditingController();
  final _freqValCtrl = TextEditingController(text: '1');

  String    _freqUnit  = 'months';
  DateTime  _firstPayment = DateTime.now(); // was startDate
  DateTime? _lastPayment;                  // was endDate
  String?   _accountId;
  String?   _categoryId;

  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final app = widget.app;
    final e   = widget.existing;
    _accountId = app.accounts.isNotEmpty ? app.accounts.first.id : null;
    _categoryId =
        app.categories.where((c) => c.type == 'expense').isNotEmpty
            ? app.categories.firstWhere((c) => c.type == 'expense').id
            : null;
    if (e != null) {
      _nameCtrl.text    = e.name;
      _amountCtrl.text  = e.amount.toStringAsFixed(2);
      _freqValCtrl.text = '${e.freqVal}';
      _freqUnit         = e.freqUnit;
      _firstPayment     = e.startDate;
      _lastPayment      = e.endDate;
      _accountId        = e.accountId;
      _categoryId       = e.categoryId;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _amountCtrl.dispose();
    _freqValCtrl.dispose();
    super.dispose();
  }

  // Live estimate based on first → last payment (inclusive)
  int? get _estPayments {
    if (_lastPayment == null) return null;
    final val = int.tryParse(_freqValCtrl.text) ?? 1;
    // Use the model's _countPayments via a temporary object
    return RecurringPayment(
      id: '', name: '', accountId: '', categoryId: '',
      amount: 0, freqVal: val, freqUnit: _freqUnit,
      startDate: _firstPayment, nextDate: _firstPayment, endDate: _lastPayment,
    ).totalPayments;
  }

  Future<void> _pickFirstPayment() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _firstPayment,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Select first payment date',
    );
    if (picked == null) return;
    setState(() {
      _firstPayment = picked;
      // If last payment is now before first, clear it
      if (_lastPayment != null && _lastPayment!.isBefore(picked)) {
        _lastPayment = null;
      }
    });
  }

  Future<void> _pickLastPayment() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _lastPayment ?? _firstPayment.add(const Duration(days: 365)),
      firstDate: _firstPayment,
      lastDate: DateTime(2100),
      helpText: 'Select last payment date',
    );
    if (picked != null) setState(() => _lastPayment = picked);
  }

  Future<void> _submit() async {
    if (_nameCtrl.text.trim().isEmpty) return;
    final amount = double.tryParse(_amountCtrl.text);
    if (amount == null || amount <= 0) return;
    if (_accountId == null || _categoryId == null) return;

    final freqVal = int.tryParse(_freqValCtrl.text) ?? 1;
    final provider = context.read<AppProvider>();

    if (isEdit) {
      final e = widget.existing!;
      await provider.updateRecurring(RecurringPayment(
        id: e.id, name: _nameCtrl.text.trim(),
        accountId: _accountId!, categoryId: _categoryId!,
        amount: amount, freqVal: freqVal, freqUnit: _freqUnit,
        startDate: _firstPayment, nextDate: e.nextDate,
        endDate: _lastPayment, paidPayments: e.paidPayments,
        reminderEnabled: false, notes: e.notes,
      ));
    } else {
      await provider.addRecurring(RecurringPayment(
        id: provider.newId(), name: _nameCtrl.text.trim(),
        accountId: _accountId!, categoryId: _categoryId!,
        amount: amount, freqVal: freqVal, freqUnit: _freqUnit,
        startDate: _firstPayment, nextDate: _firstPayment,
        endDate: _lastPayment, paidPayments: 0, reminderEnabled: false,
      ));
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final app      = widget.app;
    final cs       = Theme.of(context).colorScheme;
    final currency = app.settings.currency;
    final sym      = currencyInfo(currency).symbol;
    final est      = _estPayments;
    final amount   = double.tryParse(_amountCtrl.text) ?? 0;
    final expCats  = app.categories.where((c) => c.type == 'expense').toList();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 20, right: 20, top: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEdit ? 'Edit Recurring Payment' : 'Add Recurring Payment',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 18),

            // Name
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.repeat_rounded)),
            ),
            const SizedBox(height: 12),

            // Amount
            TextField(
              controller: _amountCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                  labelText: 'Amount per payment', prefixText: '$sym '),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),

            // Frequency
            Text('Frequency',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(letterSpacing: 1)),
            const SizedBox(height: 8),
            Row(children: [
              const Text('Every', style: TextStyle(fontSize: 15)),
              const SizedBox(width: 10),
              SizedBox(
                width: 70,
                child: TextField(
                  controller: _freqValCtrl,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12)),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _freqUnit,
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12)),
                  items: const [
                    DropdownMenuItem(value: 'days',   child: Text('Days')),
                    DropdownMenuItem(value: 'weeks',  child: Text('Weeks')),
                    DropdownMenuItem(value: 'months', child: Text('Months')),
                    DropdownMenuItem(value: 'years',  child: Text('Years')),
                  ],
                  onChanged: (v) => setState(() => _freqUnit = v!),
                ),
              ),
            ]),
            const SizedBox(height: 4),

            // ── First Payment date ──────────────────────────────────────
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.play_circle_outline),
              title: Text(
                'First Payment: ${DateFormat('d MMM yyyy').format(_firstPayment)}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text('Date of the first payment'),
              onTap: _pickFirstPayment,
            ),

            // ── Last Payment date ───────────────────────────────────────
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.stop_circle_outlined),
              title: Text(
                _lastPayment != null
                    ? 'Last Payment: ${DateFormat('d MMM yyyy').format(_lastPayment!)}'
                    : 'No last payment (ongoing)',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text('Date of the final payment'),
              trailing: _lastPayment != null
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      tooltip: 'Remove last payment date',
                      onPressed: () => setState(() => _lastPayment = null),
                    )
                  : null,
              onTap: _pickLastPayment,
            ),

            // ── Live estimate card ──────────────────────────────────────
            if (est != null && est > 0 && amount > 0)
              Container(
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Payments',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: cs.onPrimaryContainer
                                        .withValues(alpha: 0.7))),
                            Text('$est payments',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    color: cs.primary)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Total Cost',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: cs.onPrimaryContainer
                                        .withValues(alpha: 0.7))),
                            Text(
                              formatAmount(est * amount, currency),
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  color: cs.primary),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${formatAmount(amount, currency)} × $est payments',
                      style: TextStyle(
                          fontSize: 11,
                          color: cs.onPrimaryContainer.withValues(alpha: 0.6)),
                    ),
                  ],
                ),
              ),

            // Account
            if (app.accounts.isNotEmpty) ...[
              DropdownButtonFormField<String>(
                initialValue: _accountId,
                decoration: const InputDecoration(
                    labelText: 'Account',
                    prefixIcon:
                        Icon(Icons.account_balance_wallet_outlined)),
                items: app.accounts
                    .map((a) => DropdownMenuItem<String>(
                        value: a.id, child: Text(a.name)))
                    .toList(),
                onChanged: (v) => setState(() => _accountId = v),
              ),
              const SizedBox(height: 12),
            ],

            // Category
            if (expCats.isNotEmpty) ...[
              DropdownButtonFormField<String>(
                initialValue: _categoryId,
                decoration: const InputDecoration(
                    labelText: 'Category',
                    prefixIcon: Icon(Icons.label_outline)),
                items: expCats
                    .map((c) => DropdownMenuItem<String>(
                        value: c.id, child: Text(c.name)))
                    .toList(),
                onChanged: (v) => setState(() => _categoryId = v),
              ),
              const SizedBox(height: 16),
            ],

            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(isEdit ? Icons.save_outlined : Icons.add),
              label: Text(
                  isEdit ? 'Save Changes' : 'Add Recurring Payment'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28)),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
