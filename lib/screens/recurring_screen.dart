// note: Recurring bills and subscriptions manager with calendar timeline, upcoming due badges, and auto-pay configuration.
// All state mutations and queries route through AppProvider to preserve UI-DB decoupling.
// Follows Material 3 and AMOLED surface conventions via popupSurfaceColor(cs) and semantic constants.
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
import '../widgets/fintech_components.dart';
import '../services/notification_service.dart';
import '../utils/haptics.dart';
import 'recurring_detail_screen.dart';
import '../utils/nav_metrics.dart';

// ── class RecurringScreen ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for RecurringScreen.
class RecurringScreen extends StatefulWidget {
  const RecurringScreen({super.key});
  @override
  State<RecurringScreen> createState() => _RecurringScreenState();
}

// ── class _RecurringScreenState ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for _RecurringScreenState.
class _RecurringScreenState extends State<RecurringScreen> {
  AppLocalizations get l10n => AppLocalizations.of(context)!;
  int _tabIndex = 0; // 0 = Expenses, 1 = Income, 2 = Transfers
  String _expenseSubFilter = 'subscription'; // 'subscription' or 'installment'

  List<RecurringPayment>? _cachedRecurring;
  String? _cachedExpenseSubFilter;
  int? _cachedTabIndex;

  List<RecurringPayment> _expenses = [];
  List<RecurringPayment> _incomes = [];
  List<RecurringPayment> _transfers = [];
  List<RecurringPayment> _filteredExpenses = [];
  List<RecurringPayment> _shown = [];
  double _m = 0;

  // Helper method `_monthly`: handles user action or computes derived UI state.
  double _monthly(List<RecurringPayment> list, AppProvider app) {
    double t = 0;
    for (final r in list) {
      if (r.isInstallment && r.isInstallmentEnded) continue;
      final accCur = app.accountById(r.accountId)?.currency ?? app.settings.currency;
      final amt = app.convertToMain(r.amount, accCur);
      switch (r.freqUnit) {
        case 'days':
          t += amt * (30.44 / r.freqVal);
          break;
        case 'weeks':
          t += amt * (4.33 / r.freqVal);
          break;
        case 'months':
          t += amt / r.freqVal;
          break;
        case 'years':
          t += amt / (12 * r.freqVal);
          break;
      }
    }
    return t;
  }

  // Helper method `_computeData`: handles user action or computes derived UI state.
  void _computeData(AppProvider app) {
    if (identical(_cachedRecurring, app.recurring) &&
        _cachedExpenseSubFilter == _expenseSubFilter &&
        _cachedTabIndex == _tabIndex) {
      return;
    }
    _cachedRecurring = app.recurring;
    _cachedExpenseSubFilter = _expenseSubFilter;
    _cachedTabIndex = _tabIndex;

    _expenses = app.recurring.where((r) => r.paymentType == 'expense').toList();
    _incomes = app.recurring.where((r) => r.paymentType == 'income').toList();
    _transfers = app.recurring.where((r) => r.isTransfer).toList();
    _filteredExpenses =
        _expenses.where((r) => r.recurringType == _expenseSubFilter).toList();
    _shown = _tabIndex == 0
        ? _filteredExpenses
        : (_tabIndex == 1 ? _incomes : _transfers);
    _m = _monthly(_shown, app);
  }

  @override
  // Builds the widget subtree using theme-adaptive colors and localization.
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tabPurple = isDark ? const Color(0xFFBA68C8) : const Color(0xFF8E24AA);
    // Helper method `fmt`: handles user action or computes derived UI state.
    String fmt(double v) => formatAmount(v, app.settings.currency);

    _computeData(app);

    final monthlyExpenses = _monthly(_expenses, app);
    final monthlyIncomes = _monthly(_incomes, app);

    // Render Scaffold layout container.
    return Scaffold(
      body: Column(
        children: [
          // ── Transparent Edge-to-Edge Header ────────────────────────
          FintechHeader(
            title: l10n.recurring_recurring,
            subtitle: l10n.recurring_subtitleCount(
              _expenses.length + _incomes.length + _transfers.length,
            ),
          ),

          // ── Elevated Committed Cash Flow Hero Card ──────────────────
          FintechHeroCard(
            accentColor: tabPurple,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: tabPurple.withValues(alpha: isDark ? 0.25 : 0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: tabPurple.withValues(alpha: isDark ? 0.4 : 0.25),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.repeat_rounded, size: 12, color: tabPurple),
                          const SizedBox(width: 5),
                          Text(
                            (_tabIndex == 0
                                    ? l10n.home_expenses
                                    : (_tabIndex == 1
                                        ? l10n.home_income
                                        : l10n.recurring_transfer))
                                .toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                              color: tabPurple,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      l10n.recurring_perWeek(fmt(_m / 4.33)),
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface.withValues(alpha: 0.55),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      fmt(_m),
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      l10n.recurring_perMonth,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest.withValues(alpha: isDark ? 0.3 : 0.45),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.arrow_downward_rounded, size: 14, color: kDangerColor),
                          const SizedBox(width: 4),
                          Text(
                            '${l10n.home_expenses}: ${fmt(monthlyExpenses)}',
                            style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.arrow_upward_rounded, size: 14, color: kSuccessColor),
                          const SizedBox(width: 4),
                          Text(
                            '${l10n.home_income}: ${fmt(monthlyIncomes)}',
                            style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Pill Segmented Control (Expenses / Income / Transfers) ───
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
            child: FintechSegmentedControl<int>(
              activeColor: tabPurple,
              selectedValue: _tabIndex,
              onValueChanged: (val) => setState(() => _tabIndex = val),
              items: [
                FintechSegmentItem<int>(
                  value: 0,
                  label: l10n.recurring_expenses(_expenses.length.toString()),
                  icon: Icons.arrow_downward_rounded,
                ),
                FintechSegmentItem<int>(
                  value: 1,
                  label: l10n.recurring_incomeList(_incomes.length.toString()),
                  icon: Icons.arrow_upward_rounded,
                ),
                FintechSegmentItem<int>(
                  value: 2,
                  label: l10n.recurring_transfers(_transfers.length.toString()),
                  icon: Icons.swap_horiz_rounded,
                ),
              ],
            ),
          ),

          // ── Expenses Sub-Filter (Subscription / Installment) ────────
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: _tabIndex == 0
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(16, 2, 16, 6),
                    child: Row(
                      children: [
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
                            color: tabPurple,
                          ),
                        ),
                        const SizedBox(width: 8),
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
                            color: tabPurple,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          // ── Content List ────────────────────────────────────────────
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _tabIndex == 0
                  ? _RecurringList(
                      key: ValueKey('expenses_$_expenseSubFilter'),
                      items: _filteredExpenses,
                      app: app,
                      fmt: fmt,
                      empty: l10n.recurring_noRecurringExpenses,
                    )
                  : _tabIndex == 1
                      ? _RecurringList(
                          key: const ValueKey('incomes_list'),
                          items: _incomes,
                          app: app,
                          fmt: fmt,
                          empty: l10n.recurring_noRecurringIncome,
                        )
                      : _RecurringList(
                          key: const ValueKey('transfers_list'),
                          items: _transfers,
                          app: app,
                          fmt: fmt,
                          empty: l10n.recurring_noRecurringTransfers,
                        ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: NavAwareFabLocation(
        bottomOffset: NavMetrics.fabBottomOffset(context),
      ),
      floatingActionButton: ExpandableFab(
        label: l10n.home_add,
        color: tabPurple,
        onIncome: () => openRecurringSheet(context, defaultType: 'income'),
        onExpense: () => openRecurringSheet(context, defaultType: 'expense'),
        onTransfer: () => openRecurringSheet(context, defaultType: 'transfer'),
      ),
    );
  }
}

// Helper method `openRecurringSheet`: handles user action or computes derived UI state.
void openRecurringSheet(BuildContext ctx,
    {RecurringPayment? existing, String defaultType = 'expense'}) {
  showModalBottomSheet(
    context: ctx,
    isScrollControlled: true,
    builder: (_) =>
        _RecurringSheet(existing: existing, defaultType: defaultType),
  );
}

// ── class _FilterCard ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for _FilterCard.
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
  // Builds the widget subtree using theme-adaptive colors and localization.
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
      {super.key,
      required this.items,
      required this.app,
      required this.fmt,
      required this.empty});

  @override
  // Builds the widget subtree using theme-adaptive colors and localization.
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (items.isEmpty) {
      return EmptyState(
          icon: Icons.repeat_rounded,
          message: empty,
          subMessage: l10n.recurring_tapPlusToAddOne);
    }
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(14, 4, 14, NavMetrics.scrollBottomPadding(context)),
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

// ── class _RecurringCardState ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for _RecurringCardState.
class _RecurringCardState extends State<_RecurringCard> {
  AppLocalizations get l10n => AppLocalizations.of(context)!;
  @override
  // Builds the widget subtree using theme-adaptive colors and localization.
  Widget build(BuildContext context) {
    final r = widget.r;
    final app = widget.app;
    final fmt = widget.fmt;
    final cs = Theme.of(context).colorScheme;
    final cat = app.categoryById(r.categoryId);
    final acc = app.accountById(r.accountId);
    final toAcc =
        r.toAccountId != null ? app.accountById(r.toAccountId!) : null;
    final nativeCur = acc?.currency ?? app.settings.currency;
    final total = r.totalPayments;
    final progress = (total != null && total > 0)
        ? (r.paidPayments / total).clamp(0.0, 1.0)
        : null;
    final catColor =
        r.isTransfer ? cs.primary : (cat != null ? Color(cat.colorValue) : cs.primary);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final nextDay = DateTime(r.nextDate.year, r.nextDate.month, r.nextDate.day);
    final days = nextDay.difference(today).inDays;
    final overdue = days < 0;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Render Container layout container.
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              ExpensyRoute(
                builder: (_) => RecurringDetailScreen(recurring: r, fmt: fmt),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // ── Header row ──────────────────────────────────────────────
            Row(children: [
            if (r.isTransfer)
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: cs.primary.withValues(alpha: 0.14),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.swap_horiz_rounded, color: cs.primary),
              )
            else
              CategoryDot(category: cat, size: 46),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(r.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16)),
                  Text(
                      '${formatAmount(r.amount, nativeCur)} · ${r.localizedFrequencyLabel(l10n)}',
                      style: TextStyle(
                          fontSize: 13,
                          color: cs.onSurface.withValues(alpha: 0.6))),
                  if (r.isTransfer)
                    Text(
                      '${acc?.name ?? l10n.recurring_deletedAccount} → ${toAcc?.name ?? l10n.recurring_deletedAccount}',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: cs.primary,
                      ),
                    ),
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
                      color: kSuccessColor.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(l10n.recurring_income,
                      style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: kSuccessColor)),
                ),
              if (r.isTransfer)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                      color: cs.primary.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(l10n.recurring_transferCaps,
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: cs.primary)),
                ),
              if (r.reminderEnabled) ...[
                if (r.paymentType == 'income' || r.isTransfer)
                  const SizedBox(height: 4),
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
          if (total != null && total > 0 && progress != null) ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.recurring_paidPayments(r.paidPayments.toString(), total.toString()),
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                ),
                Text(
                  '${(progress * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 4),
            LinearProgressCard(
              value: progress,
              color: catColor,
            ),
          ],
          
          // ── Action buttons ───────────────────────────────────────────
          const SizedBox(height: 10),
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: overdue
                      ? kDangerColor.withValues(alpha: 0.14)
                      : kSuccessColor.withValues(alpha: 0.14),
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
                        ? kDangerColor
                        : kSuccessColor),
              ),
            ),
            const Spacer(),
            _Btn(
                icon: Icons.skip_next_outlined,
                label: l10n.recurring_skipBtn,
                color: const Color(0xFF785900),
                onTap: () async {
                  final ok = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            icon: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFF785900)
                                    .withValues(alpha: 0.12),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.skip_next_rounded,
                                  color: Color(0xFF785900), size: 26),
                            ),
                            title: Text(l10n.recurring_skipNextPayment,
                                textAlign: TextAlign.center),
                            content: Text(
                              l10n.recurring_nextDate(DateFormat('d MMM yyyy')
                                  .format(r.calcNextDate())),
                              textAlign: TextAlign.center,
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        minimumSize:
                                            const Size.fromHeight(46),
                                        side: BorderSide(
                                            color: cs.outlineVariant
                                                .withValues(alpha: 0.6)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14)),
                                      ),
                                      onPressed: () =>
                                          Navigator.pop(ctx, false),
                                      child: Text(l10n.recurring_cancel),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: FilledButton(
                                      style: FilledButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF785900),
                                        minimumSize:
                                            const Size.fromHeight(46),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14)),
                                      ),
                                      onPressed: () =>
                                          Navigator.pop(ctx, true),
                                      child: Text(l10n.recurring_skip),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ));
                  if (ok == true && context.mounted) {
                    await context.read<AppProvider>().skipNextRecurring(r);
                  }
                }),
            const SizedBox(width: 6),
            _Btn(
                icon: Icons.check_circle_outline,
                label: l10n.recurring_pay,
                color: cs.primary,
                onTap: () async {
                  try {
                    await context.read<AppProvider>().markRecurringPaid(r);
                  } on RatesUnavailableException catch (e) {
                    if (context.mounted) showAppSnackbar(context, e.message);
                  }
                }),
            ]),
          ]),
        ),
      ),
    ),
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
  // Builds the widget subtree using theme-adaptive colors and localization.
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

// ── class _RecurringSheetState ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for _RecurringSheetState.
class _RecurringSheetState extends State<_RecurringSheet> {
  AppLocalizations get l10n => AppLocalizations.of(context)!;
  final _nameCtrl = TextEditingController();
  final _amtCtrl = TextEditingController();
  final _toAmtCtrl = TextEditingController();
  final _freqCtrl = TextEditingController(text: '1');
  final _notesCtrl = TextEditingController();

  String _payType = 'expense';
  String _recurringType = 'subscription';
  String _freqUnit = 'months';
  DateTime _first = DateTime.now();
  DateTime? _last;
  String? _accountId;
  String? _toAccountId;
  String? _categoryId;
  bool _reminderEnabled = false;
  bool _earlyReminderEnabled = false;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 9, minute: 0);
  bool _autoPayEnabled = false;
  TimeOfDay _autoPayTime = const TimeOfDay(hour: 9, minute: 0);

  bool get isEdit => widget.existing != null;

  String get _reminderTimeStr =>
      '${_reminderTime.hour.toString().padLeft(2, '0')}:'
      '${_reminderTime.minute.toString().padLeft(2, '0')}';

  String get _autoPayTimeStr =>
      '${_autoPayTime.hour.toString().padLeft(2, '0')}:'
      '${_autoPayTime.minute.toString().padLeft(2, '0')}';

  static TimeOfDay _parseTime(String s) {
    final parts = s.split(':');
    return TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 9,
      minute: parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0,
    );
  }

  @override
  // Initializes controllers and local state from widget parameters.
  void initState() {
    super.initState();
    _payType = widget.defaultType;
    final app = context.read<AppProvider>();
    final transactable = _payType == 'transfer'
        ? app.transferableAccounts
        : app.spendableAccounts;
    if (transactable.isNotEmpty) _accountId = transactable.first.id;
    if (_payType == 'transfer') {
      _categoryId = 'sys_transfer';
      if (transactable.length > 1) _toAccountId = transactable[1].id;
    } else {
      final cats = app.userCategories.where((c) => c.type == _payType).toList();
      if (cats.isNotEmpty) _categoryId = cats.first.id;
    }

    final e = widget.existing;
    if (e != null) {
      _nameCtrl.text = e.name;
      _amtCtrl.text = e.amount.toStringAsFixed(2);
      if (e.toAmount != null) _toAmtCtrl.text = e.toAmount!.toStringAsFixed(2);
      _freqCtrl.text = '${e.freqVal}';
      _payType = e.paymentType;
      _recurringType = e.recurringType;
      _freqUnit = e.freqUnit;
      _first = e.startDate;
      _last = e.endDate;
      _accountId = e.accountId;
      _toAccountId = e.toAccountId;
      _categoryId = e.categoryId;
      _reminderEnabled = e.reminderEnabled;
      _earlyReminderEnabled = e.earlyReminderEnabled;
      _reminderTime = _parseTime(e.reminderTime);
      _autoPayEnabled = e.autoPayEnabled;
      _autoPayTime = _parseTime(e.autoPayTime);
      _notesCtrl.text = e.notes;
    }
  }

  bool _submitted = false;

  @override
  // Disposes controllers and listeners to prevent memory leaks.
  void dispose() {
    _nameCtrl.dispose();
    _amtCtrl.dispose();
    _toAmtCtrl.dispose();
    _freqCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  // Helper method `_setPayType`: handles user action or computes derived UI state.
  void _setPayType(String t) {
    final app = context.read<AppProvider>();
    if (t == 'transfer') {
      final transferable = app.transferableAccounts;
      final nextFrom = transferable.any((a) => a.id == _accountId)
          ? _accountId
          : transferable.firstOrNull?.id;
      final fallbackTo =
          transferable.where((a) => a.id != nextFrom).firstOrNull?.id;
      final nextTo = (_toAccountId != null &&
              _toAccountId != nextFrom &&
              transferable.any((a) => a.id == _toAccountId))
          ? _toAccountId
          : fallbackTo;
      setState(() {
        _payType = t;
        _accountId = nextFrom;
        _toAccountId = nextTo;
        _categoryId = 'sys_transfer';
      });
      return;
    }
    final transactable = app.spendableAccounts;
    final nextAcc = transactable.any((a) => a.id == _accountId)
        ? _accountId
        : transactable.firstOrNull?.id;
    final cats = app.userCategories.where((c) => c.type == t).toList();
    setState(() {
      _payType = t;
      _accountId = nextAcc;
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

  // Helper method `_toggleReminder`: handles user action or computes derived UI state.
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
          showAppSnackbar(context, l10n.recurring_notificationPermissionDenied);
        }
        return;
      }
    }
    setState(() => _reminderEnabled = true);
  }

  // Helper method `_pickTime`: handles user action or computes derived UI state.
  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
      helpText: l10n.recurring_remindMeAt,
    );
    if (picked != null) setState(() => _reminderTime = picked);
  }

  // Helper method `_pickAutoPayTime`: handles user action or computes derived UI state.
  Future<void> _pickAutoPayTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _autoPayTime,
      helpText: l10n.recurring_autoPayAt,
    );
    if (picked != null) setState(() => _autoPayTime = picked);
  }

  // Helper method `_submit`: handles user action or computes derived UI state.
  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (_nameCtrl.text.trim().isEmpty) return;
    final amount = double.tryParse(_amtCtrl.text);
    if (amount == null || amount <= 0) return;
    if (_accountId == null) return;

    final app = context.read<AppProvider>();
    String? toAccId;
    double? toAmt;
    String catId;
    if (_payType == 'transfer') {
      if (_toAccountId == null || _toAccountId == _accountId) {
        showAppSnackbar(
          context,
          l10n.presets_selectDifferentAccounts,
        );
        return;
      }
      toAccId = _toAccountId;
      final fromAcc = app.accountById(_accountId!);
      final toAcc = app.accountById(toAccId!);
      final isCross =
          fromAcc != null && toAcc != null && fromAcc.currency != toAcc.currency;
      final parsedTo = double.tryParse(_toAmtCtrl.text.trim());
      if (isCross && parsedTo != null && parsedTo > 0) {
        toAmt = parsedTo;
      }
      catId = 'sys_transfer';
    } else {
      if (_categoryId == null) return;
      catId = _categoryId!;
    }

    if (_payType == 'expense' &&
        _recurringType == 'installment' &&
        _last == null) {
      return;
    }

    final freq = int.tryParse(_freqCtrl.text) ?? 1;

    final r = RecurringPayment(
      id: isEdit ? widget.existing!.id : app.newId(),
      name: _nameCtrl.text.trim(),
      accountId: _accountId!,
      toAccountId: toAccId,
      toAmount: toAmt,
      categoryId: catId,
      amount: amount,
      paymentType: _payType,
      recurringType: _payType == 'expense' ? _recurringType : 'subscription',
      freqVal: freq,
      freqUnit: _freqUnit,
      startDate: _first,
      nextDate: isEdit
          ? (widget.existing!.startDate != _first ? _first : widget.existing!.nextDate)
          : _first,
      endDate: _last,
      paidPayments: isEdit ? widget.existing!.paidPayments : 0,
      reminderEnabled: _reminderEnabled,
      reminderTime: _reminderTimeStr,
      earlyReminderEnabled: _earlyReminderEnabled,
      notes: _notesCtrl.text.trim(),
      autoPayEnabled: _autoPayEnabled,
      autoPayTime: _autoPayTimeStr,
    );

    if (isEdit) {
      await app.updateRecurring(r);
    } else {
      await app.addRecurring(r);
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  // Builds the widget subtree using theme-adaptive colors and localization.
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    final selectedAcc =
        _accountId != null ? app.accountById(_accountId!) : null;
    final sym =
        currencyInfo(selectedAcc?.currency ?? app.settings.currency).symbol;
    final cats = app.userCategories.where((c) => c.type == _payType).toList();
    final est = _estimate;
    final amt = double.tryParse(_amtCtrl.text) ?? 0;


    // Render SheetShell layout container.
    return SheetShell(
      maxHeightFactor: 0.85,
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
          TypeToggleChips(
            selectedValue: _payType,
            firstValue: 'expense',
            firstLabel: l10n.recurring_expense,
            firstColor: kDangerColor,
            secondValue: 'income',
            secondLabel: l10n.recurring_income_,
            secondColor: kSuccessColor,
            thirdValue: 'transfer',
            thirdLabel: l10n.recurring_transfer,
            thirdColor: cs.primary,
            onChanged: _setPayType,
          ),
          const SizedBox(height: 12),

          if (_payType == 'expense') ...[
            Row(children: [
              Expanded(
                  child: GestureDetector(
                onTap: () => setState(() => _recurringType = 'subscription'),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 140),
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
                  duration: const Duration(milliseconds: 140),
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
                child: AppDropdownFormField<String>(
              value: _freqUnit,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                  lastDate: DateTime(2140));
              if (p != null) {
                setState(() {
                  _first = p;
                  if (_last != null && _last!.isBefore(p)) _last = null;
                });
              }
            },
          ),
          if ((_recurringType == 'installment' && _payType == 'expense') ||
              _payType == 'transfer')
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
                    lastDate: DateTime(2140));
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
            Text(
                _payType == 'transfer'
                    ? l10n.recurring_fromAccount
                    : l10n.recurring_account,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(letterSpacing: 1)),
            const SizedBox(height: 8),
            AccountCardPicker(
                accounts: _payType == 'transfer'
                    ? app.transferableAccounts
                    : app.spendableAccounts,
                selectedId: _accountId,
                onSelected: (id) => setState(() {
                      _accountId = id;
                      if (_toAccountId == id) _toAccountId = null;
                    })),
            const SizedBox(height: 14),
          ],

          if (_payType == 'transfer') ...[
            Text(l10n.recurring_toAccount,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(letterSpacing: 1)),
            const SizedBox(height: 8),
            AccountCardPicker(
              accounts: app.transferableAccounts,
              selectedId: _toAccountId,
              disabledId: _accountId,
              onSelected: (id) => setState(() => _toAccountId = id),
            ),
            if (_accountId != null && _toAccountId != null)
              Builder(builder: (context) {
                final fromAcc = app.accountById(_accountId!);
                final toAcc = app.accountById(_toAccountId!);
                if (fromAcc == null ||
                    toAcc == null ||
                    fromAcc.currency == toAcc.currency) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: TextField(
                    controller: _toAmtCtrl,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: l10n.presets_targetAmountOptional(toAcc.currency),
                      prefixIcon: const Icon(Icons.currency_exchange),
                    ),
                  ),
                );
              }),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: cs.primary.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.swap_horiz_rounded, size: 18, color: cs.primary),
                  const SizedBox(width: 8),
                  Text(
                    '${l10n.recurring_category}: ${l10n.recurring_transfer}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: cs.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ] else if (cats.isNotEmpty) ...[
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

          const SizedBox(height: 14),
          FintechReminderToggle(
            value: _reminderEnabled,
            onChanged: _toggleReminder,
            title: l10n.recurring_paymentReminder,
            subtitle: _reminderEnabled
                ? l10n.recurring_reminderEnabledSub
                : l10n.recurring_reminderDisabledSub,
            activeColor: cs.primary,
            expandedContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(
                    l10n.recurring_notificationWillFire,
                    style: TextStyle(
                        fontSize: 11, color: cs.onSurface.withValues(alpha: 0.4)),
                  ),
                ),
                const Divider(height: 16),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  secondary: Icon(
                    _earlyReminderEnabled
                        ? Icons.notifications_active_outlined
                        : Icons.notifications_outlined,
                    color: _earlyReminderEnabled ? cs.secondary : null,
                    size: 20,
                  ),
                  title: Text(l10n.recurring_remind2DaysBefore,
                      style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: _earlyReminderEnabled ? cs.secondary : null)),
                  subtitle: Text(
                    _earlyReminderEnabled
                        ? l10n.recurring_earlyReminderEnabledSub
                        : l10n.recurring_earlyReminderDisabledSub,
                    style: TextStyle(
                        fontSize: 11, color: cs.onSurface.withValues(alpha: 0.5)),
                  ),
                  value: _earlyReminderEnabled,
                  activeTrackColor: cs.secondary,
                  onChanged: (v) => setState(() => _earlyReminderEnabled = v),
                ),
              ],
            ),
          ),
          const Divider(height: 24),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            secondary: Icon(
              _autoPayEnabled
                  ? Icons.autorenew_rounded
                  : Icons.sync_disabled_rounded,
              color: _autoPayEnabled ? kSuccessColor : null,
            ),
            title: Text(l10n.recurring_autoPayOnDueDate,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _autoPayEnabled ? kSuccessColor : null)),
            subtitle: Text(
              _autoPayEnabled
                  ? l10n.recurring_autoPayEnabledSub
                  : l10n.recurring_autoPayDisabledSub,
              style: TextStyle(
                  fontSize: 12, color: cs.onSurface.withValues(alpha: 0.5)),
            ),
            value: _autoPayEnabled,
            onChanged: (v) => setState(() => _autoPayEnabled = v),
          ),

          if (_autoPayEnabled) ...[
            const SizedBox(height: 4),
            InkWell(
              onTap: _pickAutoPayTime,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: kSuccessColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kSuccessColor.withValues(alpha: 0.35)),
                ),
                child: Row(children: [
                  const Icon(Icons.access_time_rounded, size: 20, color: kSuccessColor),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(l10n.recurring_autoPayTime,
                            style: TextStyle(
                                fontSize: 11,
                                color: cs.onSurface.withValues(alpha: 0.55))),
                        Text(_autoPayTime.format(context),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: kSuccessColor)),
                      ])),
                  const Icon(Icons.chevron_right_rounded, color: kSuccessColor),
                ]),
              ),
            ),
            const SizedBox(height: 8),
          ],

          const SizedBox(height: 12),
          TextField(
            controller: _notesCtrl,
            maxLines: 2,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: l10n.recurring_notes,
              prefixIcon: const Icon(Icons.notes_rounded),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              AppHaptics.tap(context, HapticStrength.light);
              _submit();
            },
            icon: Icon(isEdit ? Icons.save_outlined : Icons.add),
            label: Text(
                isEdit ? l10n.accounts_saveChanges : l10n.recurring_addRecurringBtn),
            style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28))),
          ),
          const SizedBox(height: 4),
      ],
    );
  }
}


