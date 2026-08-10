// lib/screens/yearly_analysis_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../utils/haptics.dart';
import '../widgets/shared_widgets.dart';

class YearlyLineItem {
  final String name;
  final double amount;
  const YearlyLineItem(this.name, this.amount);
}

const _kGreenAccent = Color(0xFF2E7D32);
const _kTealAccent  = Color(0xFF00897B);
const _kOrangeAccent = Color(0xFFF57C00);
const _kPurpleAccent = Color(0xFF7B1FA2);

class YearlyMonthData {
  final List<YearlyLineItem> recurringIncome = [];
  final List<YearlyLineItem> recurringExpense = [];
  final List<YearlyLineItem> loanItems = [];
  final List<YearlyLineItem> borrowedItems = [];
  final List<YearlyLineItem> lentDueItems = [];

  double get recurringIncomeTotal => _sum(recurringIncome);
  double get recurringExpenseTotal => _sum(recurringExpense);
  double get loansTotal => _sum(loanItems);
  double get borrowedTotal => _sum(borrowedItems);
  double get lentDueTotal => _sum(lentDueItems);

  double get totalInflow => recurringIncomeTotal + lentDueTotal;
  double get totalOutflow => recurringExpenseTotal + loansTotal + borrowedTotal;
  double get netFlow => totalInflow - totalOutflow;

  bool get isEmpty =>
      recurringIncome.isEmpty &&
      recurringExpense.isEmpty &&
      loanItems.isEmpty &&
      borrowedItems.isEmpty &&
      lentDueItems.isEmpty;

  static double _sum(List<YearlyLineItem> items) =>
      items.fold(0.0, (s, i) => s + i.amount);
}

Map<int, Map<int, YearlyMonthData>> buildYearlyAnalysis(AppProvider app) {
  final buckets = <int, Map<int, YearlyMonthData>>{};
  YearlyMonthData bucket(DateTime d) => buckets
      .putIfAbsent(d.year, () => {})
      .putIfAbsent(d.month, () => YearlyMonthData());

  final now = DateTime.now();
  final openEndedHorizon = DateTime(now.year + 2, now.month, now.day);

  // 1. Recurring payments — project every future occurrence.
  for (final r in app.recurring) {
    final currency =
        app.accountById(r.accountId)?.currency ?? app.settings.currency;
    final convertedAmount = app.convertToMain(r.amount, currency);
    final cap = r.endDate ?? openEndedHorizon;
    var cursor = r.nextDate;
    var guard = 0;
    while (!cursor.isAfter(cap) && guard < 2000) {
      final item = YearlyLineItem(r.name, convertedAmount);
      final b = bucket(cursor);
      if (r.paymentType == 'income') {
        b.recurringIncome.add(item);
      } else {
        b.recurringExpense.add(item);
      }

      final probe = RecurringPayment(
        id: r.id,
        name: r.name,
        accountId: r.accountId,
        categoryId: r.categoryId,
        amount: r.amount,
        paymentType: r.paymentType,
        freqVal: r.freqVal,
        freqUnit: r.freqUnit,
        startDate: r.startDate,
        nextDate: cursor,
        endDate: r.endDate,
        paidPayments: r.paidPayments,
        reminderEnabled: r.reminderEnabled,
        reminderTime: r.reminderTime,
        earlyReminderEnabled: r.earlyReminderEnabled,
        notes: r.notes,
        recurringType: r.recurringType,
      );
      final stepped = probe.calcNextDate();
      if (!stepped.isAfter(cursor)) break;
      cursor = stepped;
      guard++;
    }
  }

  // 2. Lent money due back (informational inflow)
  for (final l in app.lended
      .where((x) => x.type == 'lent' && !x.isSettled && x.dueDate != null)) {
    final person = app.personById(l.personId)?.name ?? '';
    bucket(l.dueDate!).lentDueItems.add(YearlyLineItem(person, l.amount));
  }

  // 3. Borrowed money due (outflow)
  for (final l in app.lended
      .where((x) => x.type == 'borrowed' && !x.isSettled && x.dueDate != null)) {
    final person = app.personById(l.personId)?.name ?? '';
    bucket(l.dueDate!).borrowedItems.add(YearlyLineItem(person, l.amount));
  }

  // 4. Loans
  for (final loan in app.loans.where((x) => !x.isSettled)) {
    final convertedMonthly =
        app.convertToMain(loan.monthlyPayment, loan.currency);
    var cursor = DateTime(
      loan.startDate.isAfter(now) ? loan.startDate.year : now.year,
      loan.startDate.isAfter(now) ? loan.startDate.month : now.month,
    );
    final end = DateTime(loan.endDate.year, loan.endDate.month);
    while (!cursor.isAfter(end)) {
      bucket(cursor).loanItems.add(YearlyLineItem(loan.name, convertedMonthly));
      cursor = DateTime(cursor.year, cursor.month + 1);
    }
  }

  return buckets;
}

class YearlyAnalysisScreen extends StatefulWidget {
  const YearlyAnalysisScreen({super.key});

  @override
  State<YearlyAnalysisScreen> createState() => _YearlyAnalysisScreenState();
}

class _YearlyAnalysisScreenState extends State<YearlyAnalysisScreen> {
  late int _selectedYear;

  @override
  void initState() {
    super.initState();
    _selectedYear = DateTime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final app = context.watch<AppProvider>();

    final allData = buildYearlyAnalysis(app);
    final yearData = allData[_selectedYear] ?? {};

    double totalInflow = 0;
    double totalOutflow = 0;
    bool hasAnyDataInApp = false;

    for (final monthData in allData.values) {
      for (final m in monthData.values) {
        if (!m.isEmpty) {
          hasAnyDataInApp = true;
          break;
        }
      }
      if (hasAnyDataInApp) break;
    }

    for (final m in yearData.values) {
      totalInflow += m.totalInflow;
      totalOutflow += m.totalOutflow;
    }
    final netCashFlow = totalInflow - totalOutflow;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.yearly_title,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      body: !hasAnyDataInApp
          ? EmptyState(
              icon: Icons.calendar_month_outlined,
              message: l10n.yearly_noData,
              subMessage: l10n.yearly_noDataSub,
            )
          : Column(
              children: [
                // Year Navigator Row
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left_rounded),
                        onPressed: () {
                          AppHaptics.tap(context, HapticStrength.selection);
                          setState(() => _selectedYear--);
                        },
                      ),
                      Text(
                        '$_selectedYear',
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right_rounded),
                        onPressed: () {
                          AppHaptics.tap(context, HapticStrength.selection);
                          setState(() => _selectedYear++);
                        },
                      ),
                    ],
                  ),
                ),

                // Summary cards row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: _SummaryCard(
                          label: l10n.yearly_totalInflow,
                          amount: totalInflow,
                          currency: app.settings.currency,
                          color: _kGreenAccent,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _SummaryCard(
                          label: l10n.yearly_totalOutflow,
                          amount: totalOutflow,
                          currency: app.settings.currency,
                          color: cs.error,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _SummaryCard(
                          label: l10n.yearly_netCashFlow,
                          amount: netCashFlow,
                          currency: app.settings.currency,
                          color: netCashFlow >= 0 ? cs.primary : cs.error,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Month List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      final monthNum = index + 1;
                      final monthDate = DateTime(_selectedYear, monthNum);
                      final monthData = yearData[monthNum] ?? YearlyMonthData();
                      return _MonthCard(
                        month: monthDate,
                        data: monthData,
                        currency: app.settings.currency,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final double amount;
  final String currency;
  final Color color;

  const _SummaryCard({
    required this.label,
    required this.amount,
    required this.currency,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: cs.onSurface.withValues(alpha: 0.6),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              formatAmount(amount, currency),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthCard extends StatefulWidget {
  final DateTime month;
  final YearlyMonthData data;
  final String currency;

  const _MonthCard({
    required this.month,
    required this.data,
    required this.currency,
  });

  @override
  State<_MonthCard> createState() => _MonthCardState();
}

class _MonthCardState extends State<_MonthCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final isEmpty = widget.data.isEmpty;
    final monthName = DateFormat('MMMM').format(widget.month);
    final netColor = widget.data.netFlow >= 0 ? cs.primary : cs.error;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      elevation: _expanded ? 3 : 1,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isEmpty ? 0.5 : 1.0,
        child: InkWell(
          onTap: isEmpty
              ? null
              : () {
                  AppHaptics.tap(context, HapticStrength.selection);
                  setState(() => _expanded = !_expanded);
                },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  children: [
                    // Icon Container
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: isEmpty
                            ? cs.onSurface.withValues(alpha: 0.1)
                            : netColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.calendar_today_rounded,
                        color: isEmpty
                            ? cs.onSurface.withValues(alpha: 0.4)
                            : netColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    // Month Name & Subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            monthName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          if (!isEmpty)
                            Text(
                              _expanded ? l10n.yearly_netFlow : 'Tap to expand',
                              style: TextStyle(
                                fontSize: 12,
                                color: cs.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Net Flow
                    if (!isEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            formatAmount(widget.data.netFlow, widget.currency),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: netColor,
                            ),
                          ),
                          Text(
                            l10n.yearly_netFlow,
                            style: TextStyle(
                              fontSize: 11,
                              color: netColor.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    if (isEmpty)
                      Text(
                        'No Data',
                        style: TextStyle(
                          fontSize: 12,
                          color: cs.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                  ],
                ),

                // Inflow / Outflow Grid
                if (!isEmpty) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 14),
                          decoration: BoxDecoration(
                            color: _kGreenAccent.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.arrow_downward_rounded,
                                      size: 16, color: _kGreenAccent),
                                  const SizedBox(width: 6),
                                  Text(
                                    l10n.yearly_inflow,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: _kGreenAccent,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  formatAmount(widget.data.totalInflow, widget.currency),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: _kGreenAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 14),
                          decoration: BoxDecoration(
                            color: cs.error.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.arrow_upward_rounded,
                                      size: 16, color: cs.error),
                                  const SizedBox(width: 6),
                                  Text(
                                    l10n.yearly_outflow,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: cs.error,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  formatAmount(widget.data.totalOutflow, widget.currency),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: cs.error,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                // Expanded Breakdown List
                if (!isEmpty)
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCirc,
                    child: _expanded
                        ? Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Divider(height: 1),
                                const SizedBox(height: 16),
                                if (widget.data.recurringIncome.isNotEmpty) ...[
                                  _buildSectionTitle(l10n.yearly_recurringInc,
                                      _kGreenAccent, Icons.autorenew_rounded),
                                  ...widget.data.recurringIncome
                                      .map((i) => _buildLineRow(i.name, i.amount)),
                                  const SizedBox(height: 14),
                                ],
                                if (widget.data.lentDueItems.isNotEmpty) ...[
                                  _buildSectionTitle(l10n.yearly_lentDue,
                                      _kTealAccent, Icons.handshake_rounded),
                                  ...widget.data.lentDueItems
                                      .map((i) => _buildLineRow(i.name, i.amount)),
                                  const SizedBox(height: 14),
                                ],
                                if (widget.data.recurringExpense.isNotEmpty) ...[
                                  _buildSectionTitle(l10n.yearly_recurringExp,
                                      _kOrangeAccent, Icons.autorenew_rounded),
                                  ...widget.data.recurringExpense
                                      .map((i) => _buildLineRow(i.name, i.amount)),
                                  const SizedBox(height: 14),
                                ],
                                if (widget.data.loanItems.isNotEmpty) ...[
                                  _buildSectionTitle(l10n.yearly_loans, cs.error,
                                      Icons.account_balance_rounded),
                                  ...widget.data.loanItems
                                      .map((i) => _buildLineRow(i.name, i.amount)),
                                  const SizedBox(height: 14),
                                ],
                                if (widget.data.borrowedItems.isNotEmpty) ...[
                                  _buildSectionTitle(l10n.yearly_borrowed,
                                      _kPurpleAccent, Icons.handshake_rounded),
                                  ...widget.data.borrowedItems
                                      .map((i) => _buildLineRow(i.name, i.amount)),
                                ],
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLineRow(String name, double amount) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: cs.onSurface.withValues(alpha: 0.85),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            formatAmount(amount, widget.currency),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
