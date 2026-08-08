// lib/screens/recurring_screen.dart
import 'package:flutter/material.dart';
import '../utils/snackbar.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../services/notification_service.dart';
import '../utils/haptics.dart';

class RecurringScreen extends StatefulWidget {
  const RecurringScreen({super.key});
  @override
  State<RecurringScreen> createState() => _RecurringScreenState();
}

class _RecurringScreenState extends State<RecurringScreen>
    with SingleTickerProviderStateMixin {
  AppLocalizations get l10n => AppLocalizations.of(context)!;
  late TabController _tab;
  String _expenseSubFilter = 'subscription'; // 'subscription' or 'installment'

  List<RecurringPayment>? _cachedRecurring;
  String? _cachedExpenseSubFilter;
  int? _cachedTabIndex;

  List<RecurringPayment> _expenses = [];
  List<RecurringPayment> _incomes = [];
  List<RecurringPayment> _filteredExpenses = [];
  List<RecurringPayment> _shown = [];
  double _m = 0;

  double _monthly(List<RecurringPayment> list) {
    double t = 0;
    for (final r in list) {
      switch (r.freqUnit) {
        case 'days':
          t += r.amount * (30.44 / r.freqVal);
          break;
        case 'weeks':
          t += r.amount * (4.33 / r.freqVal);
          break;
        case 'months':
          t += r.amount / r.freqVal;
          break;
        case 'years':
          t += r.amount / (12 * r.freqVal);
          break;
      }
    }
    return t;
  }

  void _computeData(AppProvider app) {
    if (identical(_cachedRecurring, app.recurring) &&
        _cachedExpenseSubFilter == _expenseSubFilter &&
        _cachedTabIndex == _tab.index) {
      return;
    }
    _cachedRecurring = app.recurring;
    _cachedExpenseSubFilter = _expenseSubFilter;
    _cachedTabIndex = _tab.index;

    _expenses = app.recurring.where((r) => r.paymentType == 'expense').toList();
    _incomes = app.recurring.where((r) => r.paymentType == 'income').toList();
    _filteredExpenses =
        _expenses.where((r) => r.recurringType == _expenseSubFilter).toList();
    _shown = _tab.index == 0 ? _filteredExpenses : _incomes;
    _m = _monthly(_shown);
  }

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
    _tab.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    String fmt(double v) => formatAmount(v, app.settings.currency);

    _computeData(app);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(l10n.recurring_recurring,
                style: const TextStyle(fontWeight: FontWeight.w800)),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${l10n.home_income} / ${l10n.home_expenses}',
                    style: TextStyle(
                        fontSize: 10,
                        color: cs.onPrimary.withValues(alpha: 0.7))),
                Text(
                  '${fmt(_monthly(_incomes))} / ${fmt(_monthly(_expenses))}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        bottom: TabBar(
          controller: _tab,
          labelColor: cs.onPrimary,
          unselectedLabelColor: cs.onPrimary.withValues(alpha: 0.55),
          indicatorColor: cs.onPrimary,
          tabs: [
            Tab(text: l10n.recurring_expenses(_expenses.length.toString())),
            Tab(text: l10n.recurring_incomeList(_incomes.length.toString())),
          ],
        ),
      ),
      body: Column(children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          child: Padding(
            key: ValueKey('summary_${_tab.index}_$_expenseSubFilter'),
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
            child: Row(children: [
              Expanded(
                  child: _SummaryCard(
                      label: l10n.recurring_monthly,
                      value: fmt(_m),
                      color: cs.primary,
                      bg: cs.primaryContainer,
                      fg: cs.onPrimaryContainer)),
              const SizedBox(width: 10),
              Expanded(
                  child: _SummaryCard(
                      label: l10n.recurring_weekly,
                      value: fmt(_m / 4.33),
                      color: cs.secondary,
                      bg: cs.secondaryContainer,
                      fg: cs.onSecondaryContainer)),
            ]),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 150),
          crossFadeState: _tab.index == 0
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Padding(
            padding: const EdgeInsets.only(left: 14, right: 14, bottom: 8),
            child: Row(children: [
              Expanded(
                child: _FilterCard(
                  label: l10n.recurring_subscriptions(_expenses
                      .where((e) => e.recurringType == 'subscription')
                      .length
                      .toString()),
                  icon: Icons.sync_rounded,
                  selected: _expenseSubFilter == 'subscription',
                  onTap: () =>
                      setState(() => _expenseSubFilter = 'subscription'),
                  color: cs.primary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _FilterCard(
                  label: l10n.recurring_installments(_expenses
                      .where((e) => e.recurringType == 'installment')
                      .length
                      .toString()),
                  icon: Icons.payments_outlined,
                  selected: _expenseSubFilter == 'installment',
                  onTap: () =>
                      setState(() => _expenseSubFilter = 'installment'),
                  color: cs.secondary,
                ),
              ),
            ]),
          ),
          secondChild: const SizedBox.shrink(),
        ),
        Expanded(
            child: TabBarView(controller: _tab, children: [
          _RecurringList(
              items: _filteredExpenses,
              app: app,
              fmt: fmt,
              empty: l10n.recurring_noRecurringExpenses),
          _RecurringList(
              items: _incomes,
              app: app,
              fmt: fmt,
              empty: l10n.recurring_noRecurringIncome),
        ])),
      ]),
      floatingActionButton: ExpandableFab(
        label: l10n.home_add,
        onIncome: () => _openRecurringSheet(context, defaultType: 'income'),
        onExpense: () => _openRecurringSheet(context, defaultType: 'expense'),
      ),
    );
  }
}

void _openRecurringSheet(BuildContext ctx,
    {RecurringPayment? existing, String defaultType = 'expense'}) {
  showModalBottomSheet(
    context: ctx,
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (_) =>
        _RecurringSheet(existing: existing, defaultType: defaultType),
  );
}

// ── Summary Card ──────────────────────────────────────────────────────────────
class _SummaryCard extends StatelessWidget {
  final String label, value;
  final Color color, bg, fg;
  const _SummaryCard(
      {required this.label,
      required this.value,
      required this.color,
      required this.bg,
      required this.fg});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  color: fg.withValues(alpha: 0.65),
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(value,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w800, color: color)),
        ]),
      );
}

class _FilterCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final Color color;

  const _FilterCard({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = selected
        ? color.withValues(alpha: 0.15)
        : cs.surfaceContainerHigh.withValues(alpha: 0.5);
    final fg = selected ? color : cs.onSurfaceVariant;
    final border = selected ? color.withValues(alpha: 0.5) : Colors.transparent;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: border, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: fg, size: 20),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: fg,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── List ──────────────────────────────────────────────────────────────────────
class _RecurringList extends StatelessWidget {
  final List<RecurringPayment> items;
  final AppProvider app;
  final String Function(double) fmt;
  final String empty;
  const _RecurringList(
      {required this.items,
      required this.app,
      required this.fmt,
      required this.empty});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (items.isEmpty) {
      return EmptyState(
          icon: Icons.repeat_rounded,
          message: empty,
          subMessage: l10n.recurring_tapPlusToAddOne);
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(14, 4, 14, 100),
      itemCount: items.length,
      itemBuilder: (_, i) => _RecurringCard(
          key: ValueKey(items[i].id), r: items[i], app: app, fmt: fmt),
    );
  }
}

// ── Card (stateful for history expansion) ────────────────────────────────────
class _RecurringCard extends StatefulWidget {
  final RecurringPayment r;
  final AppProvider app;
  final String Function(double) fmt;
  const _RecurringCard({
    super.key,
    required this.r,
    required this.app,
    required this.fmt,
  });
  @override
  State<_RecurringCard> createState() => _RecurringCardState();
}

class _RecurringCardState extends State<_RecurringCard> {
  AppLocalizations get l10n => AppLocalizations.of(context)!;
  List<RecurringHistoryEntry>? _history;
  bool _expanded = false;

  Future<void> _loadHistory() async {
    final entries =
        await context.read<AppProvider>().getHistoryFor(widget.r.id);
    if (mounted) setState(() => _history = entries);
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.r;
    final app = widget.app;
    final fmt = widget.fmt;
    final cs = Theme.of(context).colorScheme;
    final cat = app.categoryById(r.categoryId);
    final catColor = cat != null ? Color(cat.colorValue) : cs.primary;
    final total = r.totalPayments;
    final progress = (total != null && total > 0)
        ? (r.paidPayments / total).clamp(0.0, 1.0)
        : null;
    final days = r.nextDate.difference(DateTime.now()).inDays;
    final overdue = days < 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ── Header row ──────────────────────────────────────────────
          Row(children: [
            CategoryDot(category: cat, size: 46),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(r.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16)),
                  Text('${fmt(r.amount)} · ${r.frequencyLabel}',
                      style: TextStyle(
                          fontSize: 13,
                          color: cs.onSurface.withValues(alpha: 0.6))),
                  Text(
                      r.endDate != null
                          ? '${DateFormat('d MMM yy').format(r.startDate)} → ${DateFormat('d MMM yy').format(r.endDate!)}'
                          : l10n.recurring_fromOngoing(
                              DateFormat('d MMM yy').format(r.startDate)),
                      style: TextStyle(
                          fontSize: 11,
                          color: cs.onSurface.withValues(alpha: 0.45))),
                ])),
            // Badges
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              if (r.paymentType == 'income')
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(l10n.recurring_income,
                      style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2E7D32))),
                ),
              if (r.reminderEnabled) ...[
                if (r.paymentType == 'income') const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                      color: cs.primaryContainer,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.notifications_active_outlined,
                        size: 10, color: cs.primary),
                    const SizedBox(width: 3),
                    Text(r.reminderTime,
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: cs.primary)),
                  ]),
                ),
                if (r.earlyReminderEnabled) ...[
                  const SizedBox(height: 3),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                        color: cs.secondaryContainer,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.notifications_outlined,
                          size: 10, color: cs.secondary),
                      const SizedBox(width: 3),
                      Text(l10n.recurring_2D,
                          style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: cs.secondary)),
                    ]),
                  ),
                ],
              ],
            ]),
          ]),

          // ── Progress bar ─────────────────────────────────────────────
          if (total != null && total > 0) ...[
            const SizedBox(height: 10),
            LinearProgressCard(value: progress ?? 0, color: catColor),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                  l10n.recurring_paidPayments(
                      r.paidPayments.toString(), total.toString()),
                  style: TextStyle(
                      fontSize: 11,
                      color: cs.onSurface.withValues(alpha: 0.55))),
              Text(l10n.recurring_totalAmount(fmt(r.totalAmount)),
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: cs.primary)),
            ]),
          ],

          // ── Action buttons ───────────────────────────────────────────
          const SizedBox(height: 10),
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: overdue
                      ? const Color(0xFFFFEBEE)
                      : const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                overdue
                    ? l10n.recurring_overdue
                    : days == 0
                        ? l10n.recurring_dueToday
                        : l10n.recurring_dueInDays(days.toString()),
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: overdue
                        ? const Color(0xFFC62828)
                        : const Color(0xFF2E7D32)),
              ),
            ),
            const Spacer(),
            _Btn(
                icon: Icons.edit_outlined,
                label: l10n.recurring_edit,
                color: cs.secondary,
                onTap: () => _openRecurringSheet(context, existing: r)),
            const SizedBox(width: 6),
            _Btn(
                icon: Icons.skip_next_outlined,
                label: l10n.recurring_skipBtn,
                color: const Color(0xFF785900),
                onTap: () async {
                  final ok = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: Text(l10n.recurring_skipNextPayment),
                            content: Text(l10n.recurring_nextDate(
                                DateFormat('d MMM yyyy')
                                    .format(r.calcNextDate()))),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: Text(l10n.recurring_cancel)),
                              FilledButton(
                                  onPressed: () => Navigator.pop(ctx, true),
                                  child: Text(l10n.recurring_skip)),
                            ],
                          ));
                  if (ok == true && context.mounted) {
                    await context.read<AppProvider>().skipNextRecurring(r);
                    // Invalidate history so it reloads on next expand
                    if (mounted) setState(() => _history = null);
                  }
                }),
            const SizedBox(width: 6),
            _Btn(
                icon: Icons.check_circle_outline,
                label: l10n.recurring_pay,
                color: cs.primary,
                onTap: () async {
                  await context.read<AppProvider>().markRecurringPaid(r);
                  // Invalidate history so it reloads on next expand
                  if (mounted) setState(() => _history = null);
                }),
            const SizedBox(width: 6),
            _Btn(
                icon: Icons.delete_outline_rounded,
                label: l10n.recurring_del,
                color: const Color(0xFFC62828),
                onTap: () async {
                  AppHaptics.tap(context, HapticStrength.medium);
                  final undo = await context
                      .read<AppProvider>()
                      .deleteRecurringWithUndo(r.id);
                  if (context.mounted) {
                    showAppSnackbar(context, '${r.name} deleted', onUndo: undo);
                  }
                }),
          ]),

          // ── History expansion ─────────────────────────────────────────
          const SizedBox(height: 4),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              dense: true,
              leading: Icon(Icons.history_rounded,
                  size: 16, color: cs.onSurface.withValues(alpha: 0.45)),
              title: Text(
                _expanded && _history != null
                    ? l10n.recurring_historyCount(_history!.length.toString())
                    : l10n.recurring_paymentHistory,
                style: TextStyle(
                    fontSize: 12, color: cs.onSurface.withValues(alpha: 0.55)),
              ),
              trailing: Icon(
                _expanded
                    ? Icons.expand_less_rounded
                    : Icons.expand_more_rounded,
                size: 18,
                color: cs.onSurface.withValues(alpha: 0.4),
              ),
              onExpansionChanged: (expanded) {
                setState(() {
                  _expanded = expanded;
                  if (expanded && _history == null) _loadHistory();
                });
              },
              children: [
                if (_history == null && _expanded)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2))),
                  )
                else if (_history != null && _history!.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(l10n.recurring_noHistoryYet,
                        style: TextStyle(
                            fontSize: 12,
                            color: cs.onSurface.withValues(alpha: 0.4))),
                  )
                else if (_history != null)
                  ..._history!.map((e) => _HistoryRow(entry: e, fmt: fmt)),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

// ── History row ───────────────────────────────────────────────────────────────
class _HistoryRow extends StatelessWidget {
  final RecurringHistoryEntry entry;
  final String Function(double) fmt;
  const _HistoryRow({required this.entry, required this.fmt});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isPaid = entry.action == 'paid';
    final color = isPaid ? const Color(0xFF2E7D32) : const Color(0xFF785900);

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 0, 4),
      child: Row(children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isPaid ? Icons.check_rounded : Icons.skip_next_rounded,
            size: 14,
            color: color,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
            child: Text(
          DateFormat('d MMM yyyy · HH:mm').format(entry.date),
          style: TextStyle(
              fontSize: 12, color: cs.onSurface.withValues(alpha: 0.6)),
        )),
        Text(
          '${isPaid ? '' : ''}${formatAmount(entry.amount, entry.currency)}',
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700, color: color),
        ),
      ]),
    );
  }
}

// ── Small action button ───────────────────────────────────────────────────────
class _Btn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _Btn(
      {required this.icon,
      required this.label,
      required this.color,
      required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 3),
            Text(label,
                style: TextStyle(
                    fontSize: 11, fontWeight: FontWeight.w700, color: color)),
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
  AppLocalizations get l10n => AppLocalizations.of(context)!;
  final _nameCtrl = TextEditingController();
  final _amtCtrl = TextEditingController();
  final _freqCtrl = TextEditingController(text: '1');

  String _payType = 'expense';
  String _recurringType = 'subscription';
  String _freqUnit = 'months';
  DateTime _first = DateTime.now();
  DateTime? _last;
  String? _accountId;
  String? _categoryId;
  bool _reminderEnabled = false;
  bool _earlyReminderEnabled = false;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 9, minute: 0);

  bool get isEdit => widget.existing != null;

  String get _reminderTimeStr =>
      '${_reminderTime.hour.toString().padLeft(2, '0')}:'
      '${_reminderTime.minute.toString().padLeft(2, '0')}';

  static TimeOfDay _parseTime(String s) {
    final parts = s.split(':');
    return TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 9,
      minute: parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0,
    );
  }

  @override
  void initState() {
    super.initState();
    _payType = widget.defaultType;
    final app = context.read<AppProvider>();
    final transactable = app.nonBankAccounts.where((a) => !a.isGold).toList();
    if (transactable.isNotEmpty) _accountId = transactable.first.id;
    final cats = app.categories.where((c) => c.type == _payType).toList();
    if (cats.isNotEmpty) _categoryId = cats.first.id;

    final e = widget.existing;
    if (e != null) {
      _nameCtrl.text = e.name;
      _amtCtrl.text = e.amount.toStringAsFixed(2);
      _freqCtrl.text = '${e.freqVal}';
      _payType = e.paymentType;
      _recurringType = e.recurringType;
      _freqUnit = e.freqUnit;
      _first = e.startDate;
      _last = e.endDate;
      _accountId = e.accountId;
      _categoryId = e.categoryId;
      _reminderEnabled = e.reminderEnabled;
      _earlyReminderEnabled = e.earlyReminderEnabled;
      _reminderTime = _parseTime(e.reminderTime);
    }
  }

  bool _submitted = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _amtCtrl.dispose();
    _freqCtrl.dispose();
    super.dispose();
  }

  void _setPayType(String t) {
    final app = context.read<AppProvider>();
    final cats = app.categories.where((c) => c.type == t).toList();
    setState(() {
      _payType = t;
      _categoryId = cats.isNotEmpty ? cats.first.id : null;
    });
  }

  int? get _estimate {
    if (_last == null) return null;
    final val = int.tryParse(_freqCtrl.text) ?? 1;
    return RecurringPayment(
      id: '',
      name: '',
      accountId: '',
      categoryId: '',
      amount: 0,
      paymentType: _payType,
      freqVal: val,
      freqUnit: _freqUnit,
      startDate: _first,
      nextDate: _first,
      endDate: _last,
    ).totalPayments;
  }

  Future<void> _toggleReminder(bool enabled) async {
    if (!enabled) {
      setState(() => _reminderEnabled = false);
      return;
    }
    final hasPermission = await NotificationService().hasPermission();
    if (!hasPermission) {
      final granted = await NotificationService().requestPermissions();
      if (!granted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(l10n.recurring_notificationPermissionDenied),
            duration: const Duration(seconds: 4),
          ));
        }
        return;
      }
    }
    setState(() => _reminderEnabled = true);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
      helpText: l10n.recurring_remindMeAt,
    );
    if (picked != null) setState(() => _reminderTime = picked);
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (_nameCtrl.text.trim().isEmpty) return;
    final amount = double.tryParse(_amtCtrl.text);
    if (amount == null || amount <= 0) return;
    if (_accountId == null || _categoryId == null) return;
    if (_payType == 'expense' &&
        _recurringType == 'installment' &&
        _last == null) {
      return;
    }

    final freq = int.tryParse(_freqCtrl.text) ?? 1;
    final app = context.read<AppProvider>();

    final r = RecurringPayment(
      id: isEdit ? widget.existing!.id : app.newId(),
      name: _nameCtrl.text.trim(),
      accountId: _accountId!,
      categoryId: _categoryId!,
      amount: amount,
      paymentType: _payType,
      recurringType: _payType == 'expense' ? _recurringType : 'subscription',
      freqVal: freq,
      freqUnit: _freqUnit,
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
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    final sym = currencyInfo(app.settings.currency).symbol;
    final cats = app.categories.where((c) => c.type == _payType).toList();
    final est = _estimate;
    final amt = double.tryParse(_amtCtrl.text) ?? 0;

    return Padding(
      padding: const EdgeInsets.only(
          bottom: 16,
          left: 20,
          right: 20,
          top: 20),
      child: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              isEdit
                  ? l10n.recurring_editRecurring
                  : l10n.recurring_addRecurring,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),

          // Type toggle
          Row(children: [
            Expanded(
                child: GestureDetector(
              onTap: () => _setPayType('expense'),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: _payType == 'expense'
                        ? const Color(0xFFC62828)
                        : const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text(l10n.recurring_expense,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: _payType == 'expense'
                                ? Colors.white
                                : const Color(0xFFC62828)))),
              ),
            )),
            const SizedBox(width: 10),
            Expanded(
                child: GestureDetector(
              onTap: () => _setPayType('income'),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: _payType == 'income'
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text(l10n.recurring_income_,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: _payType == 'income'
                                ? Colors.white
                                : const Color(0xFF2E7D32)))),
              ),
            )),
          ]),
          const SizedBox(height: 12),

          if (_payType == 'expense') ...[
            Row(children: [
              Expanded(
                  child: GestureDetector(
                onTap: () => setState(() => _recurringType = 'subscription'),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: _recurringType == 'subscription'
                          ? cs.primary
                          : cs.primaryContainer.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Text(l10n.recurring_subscription,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: _recurringType == 'subscription'
                                  ? cs.onPrimary
                                  : cs.onPrimaryContainer))),
                ),
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: GestureDetector(
                onTap: () => setState(() => _recurringType = 'installment'),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: _recurringType == 'installment'
                          ? cs.secondary
                          : cs.secondaryContainer.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Text(l10n.recurring_installment,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: _recurringType == 'installment'
                                  ? cs.onSecondary
                                  : cs.onSecondaryContainer))),
                ),
              )),
            ]),
            const SizedBox(height: 12),
          ],

          TextField(
            controller: _nameCtrl,
            textInputAction: TextInputAction.next,
           
            decoration: InputDecoration(
              labelText: l10n.recurring_name,
              prefixIcon: const Icon(Icons.repeat_rounded),
              errorText: _submitted && _nameCtrl.text.trim().isEmpty
                  ? l10n.error_required
                  : null,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
              controller: _amtCtrl,
              textInputAction: TextInputAction.next,
             
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: l10n.recurring_amountPerPayment,
                prefixText: '$sym ',
                errorText:
                    _submitted && (double.tryParse(_amtCtrl.text) ?? 0) <= 0
                        ? l10n.error_required
                        : null,
              ),
              onChanged: (_) => setState(() {})),
          const SizedBox(height: 12),

          Row(children: [
            Text(l10n.recurring_every, style: const TextStyle(fontSize: 15)),
            SizedBox(
                width: 70,
                child: TextField(
                  controller: _freqCtrl,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _submit(),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 12)),
                  onChanged: (_) => setState(() {}),
                )),
            const SizedBox(width: 10),
            Expanded(
                child: DropdownButtonFormField<String>(
              initialValue: _freqUnit,
              decoration: const InputDecoration(
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
              items: [
                DropdownMenuItem(
                    value: 'days', child: Text(l10n.recurring_days)),
                DropdownMenuItem(
                    value: 'weeks', child: Text(l10n.recurring_weeks)),
                DropdownMenuItem(
                    value: 'months', child: Text(l10n.recurring_months)),
                DropdownMenuItem(
                    value: 'years', child: Text(l10n.recurring_years)),
              ],
              onChanged: (v) {
                if (v != null) setState(() => _freqUnit = v);
              },
            )),
          ]),
          const SizedBox(height: 4),

          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.play_circle_outline),
            title: Text(
                l10n.recurring_firstDate(
                    DateFormat('d MMM yyyy').format(_first)),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            onTap: () async {
              final p = await showDatePicker(
                  context: context,
                  initialDate: _first,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100));
              if (p != null) {
                setState(() {
                  _first = p;
                  if (_last != null && _last!.isBefore(p)) _last = null;
                });
              }
            },
          ),
          if (_recurringType == 'installment' && _payType == 'expense')
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.stop_circle_outlined,
                  color: _submitted &&
                          _last == null &&
                          _recurringType == 'installment' &&
                          _payType == 'expense'
                      ? cs.error
                      : null),
              title: Text(
                  _last != null
                      ? l10n.recurring_lastDate(
                          DateFormat('d MMM yyyy').format(_last!))
                      : (_submitted &&
                              _recurringType == 'installment' &&
                              _payType == 'expense'
                          ? l10n.recurring_installmentsRequireEndDate
                          : l10n.recurring_noLastPaymentOngoing),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _submitted &&
                            _last == null &&
                            _recurringType == 'installment' &&
                            _payType == 'expense'
                        ? cs.error
                        : null,
                  )),
              trailing: _last != null
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => _last = null))
                  : null,
              onTap: () async {
                final p = await showDatePicker(
                    context: context,
                    initialDate: _last ?? _first.add(const Duration(days: 365)),
                    firstDate: _first,
                    lastDate: DateTime(2100));
                if (p != null) setState(() => _last = p);
              },
            ),

          if (est != null && est > 0 && amt > 0)
            Container(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(14)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.recurring_payments,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: cs.onPrimaryContainer
                                      .withValues(alpha: 0.65))),
                          Text('$est',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: cs.primary)),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(l10n.recurring_totalCost,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: cs.onPrimaryContainer
                                      .withValues(alpha: 0.65))),
                          Text(formatAmount(est * amt, app.settings.currency),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: cs.primary)),
                        ]),
                  ]),
            ),

          if (app.accounts.any((a) => !a.isGold)) ...[
            Text(l10n.recurring_account,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(letterSpacing: 1)),
            const SizedBox(height: 8),
            AccountCardPicker(
                accounts: app.nonBankAccounts.where((a) => !a.isGold).toList(),
                selectedId: _accountId,
                onSelected: (id) => setState(() => _accountId = id)),
            const SizedBox(height: 14),
          ],

          if (cats.isNotEmpty) ...[
            Text(l10n.recurring_category,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(letterSpacing: 1)),
            const SizedBox(height: 8),
            CategoryChipPicker(
                categories: cats,
                selectedId: _categoryId,
                onSelected: (id) => setState(() => _categoryId = id)),
            const SizedBox(height: 8),
          ],

          const Divider(height: 24),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            secondary: Icon(
              _reminderEnabled
                  ? Icons.notifications_active_outlined
                  : Icons.notifications_none_outlined,
              color: _reminderEnabled ? cs.primary : null,
            ),
            title: Text(l10n.recurring_paymentReminder,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _reminderEnabled ? cs.primary : null)),
            subtitle: Text(
              _reminderEnabled
                  ? 'You\'ll be notified on the due date'
                  : 'Get notified when a payment is due',
              style: TextStyle(
                  fontSize: 12, color: cs.onSurface.withValues(alpha: 0.5)),
            ),
            value: _reminderEnabled,
            onChanged: _toggleReminder,
          ),

          if (_reminderEnabled) ...[
            const SizedBox(height: 4),
            InkWell(
              onTap: _pickTime,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: cs.primaryContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: cs.primary.withValues(alpha: 0.35)),
                ),
                child: Row(children: [
                  Icon(Icons.access_time_rounded, size: 20, color: cs.primary),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(l10n.recurring_remindMeAt,
                            style: TextStyle(
                                fontSize: 11,
                                color: cs.onSurface.withValues(alpha: 0.55))),
                        Text(_reminderTime.format(context),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: cs.primary)),
                      ])),
                  Icon(Icons.chevron_right_rounded, color: cs.primary),
                ]),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                l10n.recurring_notificationWillFire,
                style: TextStyle(
                    fontSize: 11, color: cs.onSurface.withValues(alpha: 0.4)),
              ),
            ),
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
              title: Text(l10n.recurring_remind2DaysBefore,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _earlyReminderEnabled ? cs.secondary : null)),
              subtitle: Text(
                _earlyReminderEnabled
                    ? 'Extra heads-up 2 days early at the same time'
                    : 'Also get notified 2 days before the due date',
                style: TextStyle(
                    fontSize: 11, color: cs.onSurface.withValues(alpha: 0.5)),
              ),
              value: _earlyReminderEnabled,
              onChanged: (v) => setState(() => _earlyReminderEnabled = v),
            ),
          ],

          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              AppHaptics.tap(context, HapticStrength.light);
              _submit();
            },
            icon: Icon(isEdit ? Icons.save_outlined : Icons.add),
            label: Text(isEdit ? 'Save Changes' : 'Add Recurring'),
            style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28))),
          ),
          const SizedBox(height: 4),
        ],
      )),
    );
  }
}
