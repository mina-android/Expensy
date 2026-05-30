// lib/screens/recurring_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../services/notification_service.dart';

class RecurringScreen extends StatefulWidget {
  const RecurringScreen({super.key});
  @override
  State<RecurringScreen> createState() => _RecurringScreenState();
}

class _RecurringScreenState extends State<RecurringScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
    _tab.addListener(() => setState(() {}));
  }
  @override
  void dispose() { _tab.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    String fmt(double v) => formatAmount(v, app.settings.currency);

    final expenses = app.recurring.where((r) => r.paymentType == 'expense').toList();
    final incomes  = app.recurring.where((r) => r.paymentType == 'income').toList();
    final shown    = _tab.index == 0 ? expenses : incomes;

    double monthly(List<RecurringPayment> list) {
      double t = 0;
      for (final r in list) {
        switch (r.freqUnit) {
          case 'days':   t += r.amount * (30.44 / r.freqVal); break;
          case 'weeks':  t += r.amount * (4.33  / r.freqVal); break;
          case 'months': t += r.amount / r.freqVal;           break;
          case 'years':  t += r.amount / (12 * r.freqVal);    break;
        }
      }
      return t;
    }
    final m = monthly(shown);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recurring', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
        bottom: TabBar(
          controller: _tab,
          labelColor: cs.onPrimary,
          unselectedLabelColor: cs.onPrimary.withValues(alpha: 0.55),
          indicatorColor: cs.onPrimary,
          tabs: [
            Tab(text: 'Expenses (${expenses.length})'),
            Tab(text: 'Income (${incomes.length})'),
          ],
        ),
      ),
      body: Column(children: [
        // Summary cards
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
          child: Row(children: [
            Expanded(child: _SummaryCard(label: 'Monthly', value: fmt(m),
                color: cs.primary, bg: cs.primaryContainer, fg: cs.onPrimaryContainer)),
            const SizedBox(width: 10),
            Expanded(child: _SummaryCard(label: 'Weekly', value: fmt(m / 4.33),
                color: cs.secondary, bg: cs.secondaryContainer, fg: cs.onSecondaryContainer)),
          ]),
        ),
        const SizedBox(height: 8),
        Expanded(child: TabBarView(controller: _tab, children: [
          _RecurringList(items: expenses, app: app, fmt: fmt,
              empty: 'No recurring expenses'),
          _RecurringList(items: incomes,  app: app, fmt: fmt,
              empty: 'No recurring income'),
        ])),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        onPressed: () => _openRecurringSheet(context,
            defaultType: _tab.index == 0 ? 'expense' : 'income'),
        icon: const Icon(Icons.add),
        label: Text(_tab.index == 0 ? 'Add Expense' : 'Add Income'),
      ),
    );
  }
}

void _openRecurringSheet(BuildContext ctx,
    {RecurringPayment? existing, String defaultType = 'expense'}) {
  showModalBottomSheet(
    context: ctx, isScrollControlled: true, useSafeArea: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (_) => _RecurringSheet(existing: existing, defaultType: defaultType),
  );
}

// ── Summary Card ──────────────────────────────────────────────────────────────
class _SummaryCard extends StatelessWidget {
  final String label, value;
  final Color color, bg, fg;
  const _SummaryCard({required this.label, required this.value,
      required this.color, required this.bg, required this.fg});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: TextStyle(fontSize: 11,
              color: fg.withValues(alpha: 0.65), fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800,
              color: color)),
        ]),
      );
}

// ── List ──────────────────────────────────────────────────────────────────────
class _RecurringList extends StatelessWidget {
  final List<RecurringPayment> items;
  final AppProvider app;
  final String Function(double) fmt;
  final String empty;
  const _RecurringList({required this.items, required this.app,
      required this.fmt, required this.empty});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return EmptyState(icon: Icons.repeat_rounded,
        message: empty, subMessage: 'Tap + to add one');
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(14, 4, 14, 100),
      itemCount: items.length,
      itemBuilder: (_, i) => _RecurringCard(r: items[i], app: app, fmt: fmt),
    );
  }
}

// ── Card ──────────────────────────────────────────────────────────────────────
class _RecurringCard extends StatelessWidget {
  final RecurringPayment r;
  final AppProvider app;
  final String Function(double) fmt;
  const _RecurringCard({required this.r, required this.app, required this.fmt});

  @override
  Widget build(BuildContext context) {
    final cs       = Theme.of(context).colorScheme;
    final cat      = app.categoryById(r.categoryId);
    final catColor = cat != null ? Color(cat.colorValue) : cs.primary;
    final total    = r.totalPayments;
    final progress = (total != null && total > 0)
        ? (r.paidPayments / total).clamp(0.0, 1.0) : null;
    final days     = r.nextDate.difference(DateTime.now()).inDays;
    final overdue  = days < 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            CategoryDot(category: cat, size: 46),
            const SizedBox(width: 12),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r.name, style: const TextStyle(fontWeight: FontWeight.w700,
                    fontSize: 16)),
                Text('${fmt(r.amount)} · ${r.frequencyLabel}',
                    style: TextStyle(fontSize: 13,
                        color: cs.onSurface.withValues(alpha: 0.6))),
                Text(r.endDate != null
                    ? '${DateFormat('d MMM yy').format(r.startDate)} → ${DateFormat('d MMM yy').format(r.endDate!)}'
                    : 'From ${DateFormat('d MMM yy').format(r.startDate)} · Ongoing',
                    style: TextStyle(fontSize: 11,
                        color: cs.onSurface.withValues(alpha: 0.45))),
              ],
            )),
            // Badges column — INCOME tag and/or bell reminder
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (r.paymentType == 'income')
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text('INCOME', style: TextStyle(fontSize: 9,
                        fontWeight: FontWeight.w800, color: Color(0xFF2E7D32))),
                  ),
                if (r.reminderEnabled) ...[
                  if (r.paymentType == 'income') const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: cs.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.notifications_active_outlined,
                          size: 10, color: cs.primary),
                      const SizedBox(width: 3),
                      Text(r.reminderTime, style: TextStyle(fontSize: 9,
                          fontWeight: FontWeight.w700, color: cs.primary)),
                    ]),
                  ),
                  // 2-day advance reminder badge
                  if (r.earlyReminderEnabled) ...[
                    const SizedBox(height: 3),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: cs.secondaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.notifications_outlined,
                            size: 10, color: cs.secondary),
                        const SizedBox(width: 3),
                        Text('−2d', style: TextStyle(fontSize: 9,
                            fontWeight: FontWeight.w700, color: cs.secondary)),
                      ]),
                    ),
                  ],
                ],
              ],
            ),
          ]),

          if (total != null && total > 0) ...[
            const SizedBox(height: 10),
            LinearProgressCard(value: progress ?? 0, color: catColor),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('${r.paidPayments}/$total paid',
                  style: TextStyle(fontSize: 11,
                      color: cs.onSurface.withValues(alpha: 0.55))),
              Text('Total: ${fmt(r.totalAmount)}',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
                      color: cs.primary)),
            ]),
          ],

          const SizedBox(height: 10),
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: overdue ? const Color(0xFFFFEBEE) : const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(8)),
              child: Text(
                overdue ? 'Overdue!' : days == 0 ? 'Due Today' : 'Due in ${days}d',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700,
                    color: overdue ? const Color(0xFFC62828) : const Color(0xFF2E7D32)),
              ),
            ),
            const Spacer(),
            _Btn(icon: Icons.edit_outlined, label: 'Edit', color: cs.secondary,
                onTap: () => _openRecurringSheet(context, existing: r)),
            const SizedBox(width: 6),
            _Btn(icon: Icons.skip_next_outlined, label: 'Skip',
                color: const Color(0xFF785900),
                onTap: () async {
                  final ok = await showDialog<bool>(context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Skip Next Payment?'),
                        content: Text('Next: ${DateFormat('d MMM yyyy').format(r.calcNextDate())}'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx, false),
                              child: const Text('Cancel')),
                          FilledButton(onPressed: () => Navigator.pop(ctx, true),
                              child: const Text('Skip')),
                        ],
                      ));
                  if (ok == true && context.mounted) {
                    context.read<AppProvider>().skipNextRecurring(r);
                  }
                }),
            const SizedBox(width: 6),
            _Btn(icon: Icons.check_circle_outline, label: 'Pay',
                color: cs.primary,
                onTap: () => context.read<AppProvider>().markRecurringPaid(r)),
            const SizedBox(width: 6),
            _Btn(icon: Icons.delete_outline_rounded, label: 'Del',
                color: const Color(0xFFC62828),
                onTap: () async {
                  if (await showDeleteConfirm(context, r.name) && context.mounted) {
                    context.read<AppProvider>().deleteRecurring(r.id);
                  }
                }),
          ]),
        ]),
      ),
    );
  }
}

class _Btn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _Btn({required this.icon, required this.label,
      required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 3),
            Text(label, style: TextStyle(fontSize: 11,
                fontWeight: FontWeight.w700, color: color)),
          ]),
        ),
      );
}

// ── Sheet ─────────────────────────────────────────────────────────────────────
class _RecurringSheet extends StatefulWidget {
  final RecurringPayment? existing;
  final String defaultType;
  const _RecurringSheet({this.existing, this.defaultType = 'expense'});
  @override
  State<_RecurringSheet> createState() => _RecurringSheetState();
}

class _RecurringSheetState extends State<_RecurringSheet> {
  final _nameCtrl = TextEditingController();
  final _amtCtrl  = TextEditingController();
  final _freqCtrl = TextEditingController(text: '1');

  String    _payType         = 'expense';
  String    _freqUnit        = 'months';
  DateTime  _first           = DateTime.now();
  DateTime? _last;
  String?   _accountId;
  String?   _categoryId;
  bool      _reminderEnabled      = false;
  bool      _earlyReminderEnabled = false;
  TimeOfDay _reminderTime         = const TimeOfDay(hour: 9, minute: 0);

  bool get isEdit => widget.existing != null;

  /// Format TimeOfDay → 'HH:mm' for storage.
  String get _reminderTimeStr =>
      '${_reminderTime.hour.toString().padLeft(2, '0')}:'
      '${_reminderTime.minute.toString().padLeft(2, '0')}';

  /// Parse stored 'HH:mm' → TimeOfDay.
  static TimeOfDay _parseTime(String s) {
    final parts = s.split(':');
    return TimeOfDay(
      hour:   int.tryParse(parts[0]) ?? 9,
      minute: parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0,
    );
  }

  @override
  void initState() {
    super.initState();
    _payType = widget.defaultType;
    final app = context.read<AppProvider>();
    final transactable = app.accounts.where((a) => !a.isGold).toList();
    if (transactable.isNotEmpty) _accountId = transactable.first.id;
    final cats = app.categories.where((c) => c.type == _payType).toList();
    if (cats.isNotEmpty) _categoryId = cats.first.id;

    final e = widget.existing;
    if (e != null) {
      _nameCtrl.text  = e.name;
      _amtCtrl.text   = e.amount.toStringAsFixed(2);
      _freqCtrl.text  = '${e.freqVal}';
      _payType        = e.paymentType;
      _freqUnit       = e.freqUnit;
      _first          = e.startDate;
      _last           = e.endDate;
      _accountId      = e.accountId;
      _categoryId     = e.categoryId;
      _reminderEnabled      = e.reminderEnabled;
      _earlyReminderEnabled = e.earlyReminderEnabled;
      _reminderTime         = _parseTime(e.reminderTime);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose(); _amtCtrl.dispose(); _freqCtrl.dispose();
    super.dispose();
  }

  void _setPayType(String t) {
    final app  = context.read<AppProvider>();
    final cats = app.categories.where((c) => c.type == t).toList();
    setState(() {
      _payType    = t;
      _categoryId = cats.isNotEmpty ? cats.first.id : null;
    });
  }

  int? get _estimate {
    if (_last == null) return null;
    final val = int.tryParse(_freqCtrl.text) ?? 1;
    return RecurringPayment(
      id: '', name: '', accountId: '', categoryId: '', amount: 0,
      paymentType: _payType, freqVal: val, freqUnit: _freqUnit,
      startDate: _first, nextDate: _first, endDate: _last,
    ).totalPayments;
  }

  // ── Reminder toggle ────────────────────────────────────────────────────
  Future<void> _toggleReminder(bool value) async {
    if (!value) {
      setState(() {
        _reminderEnabled      = false;
        _earlyReminderEnabled = false; // advance reminder requires main reminder
      });
      return;
    }
    // Check / request permission before enabling
    final hasPermission = await NotificationService().hasPermission();
    if (!hasPermission) {
      final granted = await NotificationService().requestPermissions();
      if (!granted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Notification permission denied. '
              'Enable it in Settings → Apps → Expensy → Notifications.',
            ),
            duration: Duration(seconds: 4),
          ));
        }
        return; // Don't enable reminder — no permission
      }
    }
    setState(() => _reminderEnabled = true);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
      helpText: 'Remind me at',
    );
    if (picked != null) setState(() => _reminderTime = picked);
  }

  // ── Submit ─────────────────────────────────────────────────────────────
  Future<void> _submit() async {
    if (_nameCtrl.text.trim().isEmpty) return;
    final amount = double.tryParse(_amtCtrl.text);
    if (amount == null || amount <= 0) return;
    if (_accountId == null || _categoryId == null) return;
    final freq = int.tryParse(_freqCtrl.text) ?? 1;
    final app  = context.read<AppProvider>();

    final r = RecurringPayment(
      id: isEdit ? widget.existing!.id : app.newId(),
      name: _nameCtrl.text.trim(),
      accountId: _accountId!, categoryId: _categoryId!,
      amount: amount, paymentType: _payType,
      freqVal: freq, freqUnit: _freqUnit,
      startDate: _first,
      nextDate: isEdit ? widget.existing!.nextDate : _first,
      endDate: _last,
      paidPayments: isEdit ? widget.existing!.paidPayments : 0,
      reminderEnabled: _reminderEnabled,
      reminderTime: _reminderTimeStr,
      earlyReminderEnabled: _earlyReminderEnabled,
      notes: isEdit ? widget.existing!.notes : '',
    );

    if (isEdit) {
      await app.updateRecurring(r);
    } else {
      await app.addRecurring(r);
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final app  = context.watch<AppProvider>();
    final cs   = Theme.of(context).colorScheme;
    final sym  = currencyInfo(app.settings.currency).symbol;
    final cats = app.categories.where((c) => c.type == _payType).toList();
    final est  = _estimate;
    final amt  = double.tryParse(_amtCtrl.text) ?? 0;

    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 20, right: 20, top: 20),
      child: SingleChildScrollView(child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isEdit ? 'Edit Recurring' : 'Add Recurring',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),

          // Type toggle
          Row(children: [
            Expanded(child: GestureDetector(
              onTap: () => _setPayType('expense'),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 140),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _payType == 'expense'
                      ? const Color(0xFFC62828) : const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text('Expense',
                    style: TextStyle(fontWeight: FontWeight.w700,
                        color: _payType == 'expense'
                            ? Colors.white : const Color(0xFFC62828)))),
              ),
            )),
            const SizedBox(width: 10),
            Expanded(child: GestureDetector(
              onTap: () => _setPayType('income'),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 140),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _payType == 'income'
                      ? const Color(0xFF2E7D32) : const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text('Income',
                    style: TextStyle(fontWeight: FontWeight.w700,
                        color: _payType == 'income'
                            ? Colors.white : const Color(0xFF2E7D32)))),
              ),
            )),
          ]),
          const SizedBox(height: 12),

          TextField(controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Name',
                  prefixIcon: Icon(Icons.repeat_rounded))),
          const SizedBox(height: 12),
          TextField(controller: _amtCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                  labelText: 'Amount per payment', prefixText: '$sym '),
              onChanged: (_) => setState(() {})),
          const SizedBox(height: 12),

          // Frequency
          Row(children: [
            const Text('Every ', style: TextStyle(fontSize: 15)),
            SizedBox(width: 70, child: TextField(
              controller: _freqCtrl, textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12)),
              onChanged: (_) => setState(() {}),
            )),
            const SizedBox(width: 10),
            Expanded(child: DropdownButtonFormField<String>(
              initialValue: _freqUnit,
              decoration: const InputDecoration(isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
              items: const [
                DropdownMenuItem(value: 'days',   child: Text('Days')),
                DropdownMenuItem(value: 'weeks',  child: Text('Weeks')),
                DropdownMenuItem(value: 'months', child: Text('Months')),
                DropdownMenuItem(value: 'years',  child: Text('Years')),
              ],
              onChanged: (v) { if (v != null) setState(() => _freqUnit = v); },
            )),
          ]),
          const SizedBox(height: 4),

          // First/Last payment dates
          ListTile(contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.play_circle_outline),
            title: Text('First: ${DateFormat('d MMM yyyy').format(_first)}',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            onTap: () async {
              final p = await showDatePicker(context: context,
                  initialDate: _first, firstDate: DateTime(2000),
                  lastDate: DateTime(2100));
              if (p != null) setState(() {
                _first = p;
                if (_last != null && _last!.isBefore(p)) _last = null;
              });
            },
          ),
          ListTile(contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.stop_circle_outlined),
            title: Text(_last != null
                ? 'Last: ${DateFormat('d MMM yyyy').format(_last!)}'
                : 'No last payment (ongoing)',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            trailing: _last != null
                ? IconButton(icon: const Icon(Icons.clear),
                    onPressed: () => setState(() => _last = null))
                : null,
            onTap: () async {
              final p = await showDatePicker(context: context,
                  initialDate: _last ?? _first.add(const Duration(days: 365)),
                  firstDate: _first, lastDate: DateTime(2100));
              if (p != null) setState(() => _last = p);
            },
          ),

          // Estimate
          if (est != null && est > 0 && amt > 0)
            Container(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(14)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Payments', style: TextStyle(fontSize: 11,
                      color: cs.onPrimaryContainer.withValues(alpha: 0.65))),
                  Text('$est', style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.w800, color: cs.primary)),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text('Total Cost', style: TextStyle(fontSize: 11,
                      color: cs.onPrimaryContainer.withValues(alpha: 0.65))),
                  Text(formatAmount(est * amt, app.settings.currency),
                      style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.w800, color: cs.primary)),
                ]),
              ]),
            ),

          // Account
          if (app.accounts.any((a) => !a.isGold)) ...[
            Text('Account', style: Theme.of(context).textTheme.labelMedium
                ?.copyWith(letterSpacing: 1)),
            const SizedBox(height: 8),
            AccountCardPicker(
                accounts: app.accounts.where((a) => !a.isGold).toList(),
                selectedId: _accountId,
                onSelected: (id) => setState(() => _accountId = id)),
            const SizedBox(height: 14),
          ],

          // Category
          if (cats.isNotEmpty) ...[
            Text('Category', style: Theme.of(context).textTheme.labelMedium
                ?.copyWith(letterSpacing: 1)),
            const SizedBox(height: 8),
            CategoryChipPicker(categories: cats, selectedId: _categoryId,
                onSelected: (id) => setState(() => _categoryId = id)),
            const SizedBox(height: 8),
          ],

          // ── Reminder section ────────────────────────────────────────────
          const Divider(height: 24),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            secondary: Icon(
              _reminderEnabled
                  ? Icons.notifications_active_outlined
                  : Icons.notifications_none_outlined,
              color: _reminderEnabled ? cs.primary : null,
            ),
            title: Text(
              'Payment Reminder',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: _reminderEnabled ? cs.primary : null,
              ),
            ),
            subtitle: Text(
              _reminderEnabled
                  ? 'You\'ll be notified on the due date'
                  : 'Get notified when a payment is due',
              style: TextStyle(
                fontSize: 12,
                color: cs.onSurface.withValues(alpha: 0.5),
              ),
            ),
            value: _reminderEnabled,
            onChanged: _toggleReminder,
          ),

          // Time picker + early reminder — only shown when reminder is enabled
          if (_reminderEnabled) ...[
            const SizedBox(height: 4),
            InkWell(
              onTap: _pickTime,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: cs.primaryContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: cs.primary.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(children: [
                  Icon(Icons.access_time_rounded, size: 20, color: cs.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Remind me at',
                            style: TextStyle(fontSize: 11,
                                color: cs.onSurface.withValues(alpha: 0.55))),
                        Text(
                          _reminderTime.format(context),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: cs.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: cs.primary),
                ]),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                'Notification will fire on the next due date at this time.',
                style: TextStyle(fontSize: 11,
                    color: cs.onSurface.withValues(alpha: 0.4)),
              ),
            ),

            // ── Early (2-day advance) reminder sub-toggle ────────────────
            const SizedBox(height: 8),
            SwitchListTile.adaptive(
              contentPadding: const EdgeInsets.only(left: 4),
              secondary: Icon(
                _earlyReminderEnabled
                    ? Icons.notifications_active_outlined
                    : Icons.notifications_outlined,
                color: _earlyReminderEnabled ? cs.secondary : null,
                size: 22,
              ),
              title: Text(
                'Remind 2 days before',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _earlyReminderEnabled ? cs.secondary : null,
                ),
              ),
              subtitle: Text(
                _earlyReminderEnabled
                    ? 'Extra heads-up 2 days early at the same time'
                    : 'Also get notified 2 days before the due date',
                style: TextStyle(fontSize: 11,
                    color: cs.onSurface.withValues(alpha: 0.5)),
              ),
              value: _earlyReminderEnabled,
              onChanged: (v) => setState(() => _earlyReminderEnabled = v),
            ),
          ],

          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _submit,
            icon: Icon(isEdit ? Icons.save_outlined : Icons.add),
            label: Text(isEdit ? 'Save Changes' : 'Add Recurring'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))),
          ),
          const SizedBox(height: 4),
        ],
      )),
    );
  }
}
