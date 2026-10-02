// lib/screens/financial_calendar_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../utils/haptics.dart';
import '../widgets/shared_widgets.dart';
import 'add_transaction_screen.dart';
import '../widgets/split_transaction_sheet.dart';

class FinancialCalendarScreen extends StatefulWidget {
  final DateTime? initialDate;
  const FinancialCalendarScreen({super.key, this.initialDate});

  @override
  State<FinancialCalendarScreen> createState() => _FinancialCalendarScreenState();
}

class _FinancialCalendarScreenState extends State<FinancialCalendarScreen> {
  late DateTime _selectedMonth;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    final now = widget.initialDate ?? DateTime.now();
    _selectedMonth = DateTime(now.year, now.month, 1);
    _selectedDay = DateTime(now.year, now.month, now.day);
  }

  void _prevMonth() {
    AppHaptics.tap(context, HapticStrength.light);
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1, 1);
      final daysInNewMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0).day;
      final clampedDay = _selectedDay.day.clamp(1, daysInNewMonth);
      _selectedDay = DateTime(_selectedMonth.year, _selectedMonth.month, clampedDay);
    });
  }

  void _nextMonth() {
    AppHaptics.tap(context, HapticStrength.light);
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 1);
      final daysInNewMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0).day;
      final clampedDay = _selectedDay.day.clamp(1, daysInNewMonth);
      _selectedDay = DateTime(_selectedMonth.year, _selectedMonth.month, clampedDay);
    });
  }

  void _goToToday() {
    AppHaptics.tap(context, HapticStrength.light);
    final now = DateTime.now();
    setState(() {
      _selectedMonth = DateTime(now.year, now.month, 1);
      _selectedDay = DateTime(now.year, now.month, now.day);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cur = app.settings.currency;
    final now = DateTime.now();

    final totalSpentMonth = app.monthTotalExpense(_selectedMonth);
    final totalIncomeMonth = app.monthTotalIncome(_selectedMonth);
    final zeroSpendDays = app.zeroSpendDaysCount(_selectedMonth, now);

    final daysInMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0).day;
    final avgDailyExpense = daysInMonth > 0 ? totalSpentMonth / daysInMonth : 0.0;

    // Weekday alignment
    final startDayOffset = app.settings.weekStart == 'sunday'
        ? _selectedMonth.weekday % 7
        : (_selectedMonth.weekday - 1) % 7;

    final weekdayNames = app.settings.weekStart == 'sunday'
        ? ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
        : ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    // Selected day calculations
    final selectedDayExpense = app.dayExpense(_selectedDay);
    final selectedDayIncome = app.dayIncome(_selectedDay);
    final selectedDayTxs = app.transactionsForDay(_selectedDay);
    final selectedDayRecurring = app.recurringDueOnDay(_selectedDay);
    final selectedDayLoans = app.loansDueOnDay(_selectedDay);
    final selectedDayLended = app.lendedDueOnDay(_selectedDay);

    final isSelectedDayPastOrToday = !_selectedDay.isAfter(DateTime(now.year, now.month, now.day));
    final isZeroSpendDay = isSelectedDayPastOrToday && selectedDayExpense <= 0.001;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.calendar_title, style: const TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            tooltip: l10n.calendar_today,
            icon: const Icon(Icons.today_rounded),
            onPressed: _goToToday,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Month Navigation Header ──────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: cs.surfaceContainer.withValues(alpha: isDark ? 0.35 : 0.55),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.black.withValues(alpha: 0.04),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left_rounded),
                    onPressed: _prevMonth,
                  ),
                  Text(
                    DateFormat.yMMMM(Localizations.localeOf(context).toString())
                        .format(_selectedMonth),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right_rounded),
                    onPressed: _nextMonth,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── Month Summary Strip ──────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _SummaryPill(
                    label: l10n.home_expenses,
                    amount: formatAmount(totalSpentMonth, cur),
                    color: const Color(0xFFC62828),
                    icon: Icons.arrow_upward_rounded,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _SummaryPill(
                    label: l10n.home_income,
                    amount: formatAmount(totalIncomeMonth, cur),
                    color: const Color(0xFF2E7D32),
                    icon: Icons.arrow_downward_rounded,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _SummaryPill(
                    label: l10n.calendar_zeroSpendDays(zeroSpendDays.toString()),
                    amount: '$zeroSpendDays d',
                    color: const Color(0xFF00897B),
                    icon: Icons.star_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ── Calendar Card & Heatmap ──────────────────────────────────────
            Container(
              decoration: BoxDecoration(
                color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Weekday headers
                    Row(
                      children: weekdayNames.map((d) {
                        return Expanded(
                          child: Center(
                            child: Text(
                              d,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: cs.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),

                    // Calendar Days Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: startDayOffset + daysInMonth,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (context, index) {
                        if (index < startDayOffset) {
                          return const SizedBox.shrink();
                        }
                        final dayNumber = index - startDayOffset + 1;
                        final cellDate = DateTime(_selectedMonth.year, _selectedMonth.month, dayNumber);
                        final isSelected = cellDate.year == _selectedDay.year &&
                            cellDate.month == _selectedDay.month &&
                            cellDate.day == _selectedDay.day;
                        final isToday = cellDate.year == now.year &&
                            cellDate.month == now.month &&
                            cellDate.day == now.day;
                        final isPastOrToday = !cellDate.isAfter(DateTime(now.year, now.month, now.day));

                        final expense = app.dayExpense(cellDate);
                        final hasBills = app.recurringDueOnDay(cellDate).isNotEmpty;
                        final hasLoans = app.loansDueOnDay(cellDate).isNotEmpty;
                        final hasLended = app.lendedDueOnDay(cellDate).isNotEmpty;

                        // Density tint
                        Color cellBg = Colors.transparent;
                        Color? borderCol;
                        if (isSelected) {
                          borderCol = cs.primary;
                        }

                        if (isPastOrToday) {
                          if (expense <= 0.001) {
                            cellBg = const Color(0xFF2E7D32).withValues(alpha: isDark ? 0.2 : 0.1);
                          } else if (expense > (avgDailyExpense * 1.5) && avgDailyExpense > 0) {
                            cellBg = const Color(0xFFC62828).withValues(alpha: isDark ? 0.25 : 0.15);
                          } else {
                            cellBg = cs.surfaceContainerHighest.withValues(alpha: isDark ? 0.35 : 0.45);
                          }
                        }

                        return InkWell(
                          onTap: () {
                            AppHaptics.tap(context, HapticStrength.light);
                            setState(() {
                              _selectedDay = cellDate;
                            });
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: cellBg,
                              borderRadius: BorderRadius.circular(8),
                              border: borderCol != null
                                  ? Border.all(color: borderCol, width: 2)
                                  : (isToday
                                      ? Border.all(color: cs.primary.withValues(alpha: 0.5), width: 1.2)
                                      : null),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$dayNumber',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: isToday || isSelected ? FontWeight.w800 : FontWeight.w600,
                                    color: isToday
                                        ? cs.primary
                                        : cs.onSurface.withValues(alpha: isPastOrToday ? 0.9 : 0.4),
                                  ),
                                ),
                                if (isPastOrToday && expense <= 0.001) ...[
                                  const Icon(Icons.star_rounded, size: 9, color: Color(0xFF2E7D32)),
                                ] else if (isPastOrToday && expense > 0) ...[
                                  Text(
                                    formatAmount(expense, cur),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 8.5,
                                      fontWeight: FontWeight.w700,
                                      color: expense > (avgDailyExpense * 1.5)
                                          ? const Color(0xFFC62828)
                                          : cs.onSurface.withValues(alpha: 0.65),
                                    ),
                                  ),
                                ] else ...[
                                  // Future day dots
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (hasBills)
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 1),
                                          width: 4,
                                          height: 4,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF1565C0),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      if (hasLoans)
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 1),
                                          width: 4,
                                          height: 4,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFE65100),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      if (hasLended)
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 1),
                                          width: 4,
                                          height: 4,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF00897B),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ── Selected Day Ledger & Breakdown ──────────────────────────────
            Container(
              decoration: BoxDecoration(
                color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            DateFormat.yMMMMEEEEd(Localizations.localeOf(context).toString())
                                .format(_selectedDay),
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                          ),
                        ),
                        Text(
                          l10n.calendar_dayTransactions(selectedDayTxs.length.toString()),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: cs.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Day mini stats
                    Row(
                      children: [
                        Text(
                          '${l10n.home_expenses}: ${formatAmount(selectedDayExpense, cur)}',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFC62828)),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${l10n.home_income}: ${formatAmount(selectedDayIncome, cur)}',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF2E7D32)),
                        ),
                      ],
                    ),
                    const Divider(height: 20),

                    // Zero-Spend Celebration Card
                    if (isZeroSpendDay) ...[
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E7D32).withValues(alpha: isDark ? 0.2 : 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF2E7D32).withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.celebration_rounded, color: Color(0xFF2E7D32), size: 22),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.calendar_zeroSpendDayTitle,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13,
                                      color: Color(0xFF2E7D32),
                                    ),
                                  ),
                                  Text(
                                    l10n.calendar_zeroSpendDayDesc,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: cs.onSurface.withValues(alpha: 0.75),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    // Upcoming Bills Due
                    if (selectedDayRecurring.isNotEmpty) ...[
                      Text(
                        l10n.calendar_billsDue,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF1565C0)),
                      ),
                      const SizedBox(height: 6),
                      ...selectedDayRecurring.map((r) => ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: const CircleAvatar(
                              radius: 14,
                              backgroundColor: Color(0xFF1565C0),
                              child: Icon(Icons.repeat_rounded, size: 14, color: Colors.white),
                            ),
                            title: Text(r.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                            trailing: Text(formatAmount(r.amount, cur), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                          )),
                      const SizedBox(height: 10),
                    ],

                    // Loans Due
                    if (selectedDayLoans.isNotEmpty) ...[
                      Text(
                        l10n.calendar_loansDue,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFFE65100)),
                      ),
                      const SizedBox(height: 6),
                      ...selectedDayLoans.map((l) => ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: const CircleAvatar(
                              radius: 14,
                              backgroundColor: Color(0xFFE65100),
                              child: Icon(Icons.account_balance_outlined, size: 14, color: Colors.white),
                            ),
                            title: Text(l.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                            trailing: Text(formatAmount(l.monthlyPayment, cur), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                          )),
                      const SizedBox(height: 10),
                    ],

                    // Expected Repayments Due
                    if (selectedDayLended.isNotEmpty) ...[
                      Text(
                        l10n.calendar_lendedDue,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF00897B)),
                      ),
                      const SizedBox(height: 6),
                      ...selectedDayLended.map((m) {
                        final person = app.personById(m.personId);
                        return ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: const CircleAvatar(
                            radius: 14,
                            backgroundColor: Color(0xFF00897B),
                            child: Icon(Icons.handshake_outlined, size: 14, color: Colors.white),
                          ),
                          title: Text(person?.name ?? 'Repayment', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                          trailing: Text(formatAmount(m.amount, cur), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                        );
                      }),
                      const SizedBox(height: 10),
                    ],

                    // Transactions List
                    if (selectedDayTxs.isNotEmpty) ...[
                      ...selectedDayTxs.map((t) {
                        final cat = app.categoryById(t.categoryId);
                        final acc = app.accountById(t.accountId);
                        final isExpense = t.type == 'expense';
                        final isSplit = app.isTransactionSplit(t.id);

                        return Material(
                          color: Colors.transparent,
                          child: ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            onTap: () {
                              if (isSplit) {
                                SplitTransactionSheet.show(
                                  context,
                                  transaction: t,
                                  splits: app.getSplits(t.id),
                                  app: app,
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  ExpensySlideUpRoute(
                                    builder: (_) => AddTransactionScreen(existing: t),
                                  ),
                                );
                              }
                            },
                            leading: CategoryDot(category: cat, size: 34),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    t.description.isNotEmpty ? t.description : (cat?.name ?? 'Transaction'),
                                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                                  ),
                                ),
                                if (isSplit) ...[
                                  const SizedBox(width: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                    decoration: BoxDecoration(
                                      color: cs.primaryContainer,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'SPLIT',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        color: cs.onPrimaryContainer,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            subtitle: Text(
                              '${acc?.name ?? ''}${t.note.isNotEmpty ? ' • ${t.note}' : ''}',
                              style: TextStyle(fontSize: 10.5, color: cs.onSurface.withValues(alpha: 0.5)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Text(
                              '${isExpense ? '-' : '+'}${formatAmount(t.amount, t.currency.isNotEmpty ? t.currency : cur)}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: isExpense ? const Color(0xFFC62828) : const Color(0xFF2E7D32),
                              ),
                            ),
                          ),
                        );
                      }),
                    ] else if (!isZeroSpendDay &&
                        selectedDayRecurring.isEmpty &&
                        selectedDayLoans.isEmpty &&
                        selectedDayLended.isEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: Text(
                            l10n.calendar_noActivity,
                            style: TextStyle(
                              fontSize: 12,
                              color: cs.onSurface.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryPill extends StatelessWidget {
  final String label, amount;
  final Color color;
  final IconData icon;

  const _SummaryPill({
    required this.label,
    required this.amount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 12, color: color),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            amount,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
