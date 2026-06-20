// lib/screens/statistics_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});
  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  DateTime _month = DateTime(DateTime.now().year, DateTime.now().month);
  String? _filterAccountId; // null = all accounts

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    String fmt(double v) => formatAmount(v, app.settings.currency);

    // Guard stale account filter (account deleted while selected)
    if (_filterAccountId != null &&
        app.accountById(_filterAccountId!) == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _filterAccountId = null);
      });
    }

    final mStart = DateTime(_month.year, _month.month, 1);
    final mEnd   = DateTime(_month.year, _month.month + 1, 0, 23, 59, 59);

    // All transactions in selected month (optionally filtered by account)
    final mTxs = app.transactions.where((t) {
      if (t.date.isBefore(mStart) || t.date.isAfter(mEnd)) return false;
      if (_filterAccountId != null && t.accountId != _filterAccountId) {
        return false;
      }
      return true;
    }).toList();

    final income  = mTxs.where((t) => t.type == 'income')
        .fold(0.0, (s, t) => s + t.amount);
    final expense = mTxs.where((t) => t.type == 'expense')
        .fold(0.0, (s, t) => s + t.amount);

    // 6-month bar data (respects account filter)
    final now    = DateTime.now();
    final months = List.generate(6, (i) =>
        DateTime(now.year, now.month - 5 + i, 1));

    List<BarChartGroupData> barGroups() => months.map((m) {
      final mE = DateTime(m.year, m.month + 1, 0, 23, 59, 59);
      final txs = app.transactions.where((t) {
        if (t.date.isBefore(m) || t.date.isAfter(mE)) return false;
        if (_filterAccountId != null && t.accountId != _filterAccountId) {
          return false;
        }
        return true;
      }).toList();
      final inc = txs.where((t) => t.type == 'income')
          .fold(0.0, (s, t) => s + t.amount);
      final exp = txs.where((t) => t.type == 'expense')
          .fold(0.0, (s, t) => s + t.amount);
      final idx = months.indexOf(m);
      return BarChartGroupData(x: idx, barRods: [
        BarChartRodData(toY: inc, color: const Color(0xFF2E7D32), width: 9,
            borderRadius: BorderRadius.circular(4)),
        BarChartRodData(toY: exp, color: const Color(0xFFC62828), width: 9,
            borderRadius: BorderRadius.circular(4)),
      ], barsSpace: 2);
    }).toList();

    // Expense pie — category breakdown for selected month/account
    final expBycat = <String, double>{};
    final expBycatId = <String, String>{}; // catName → categoryId
    for (final t in mTxs.where((t) => t.type == 'expense')) {
      final cat = app.categoryById(t.categoryId);
      final key = cat?.name ?? 'Other';
      expBycat[key] = (expBycat[key] ?? 0) + t.amount;
      if (cat != null) expBycatId[key] = cat.id;
    }

    // Non-gold accounts for filter chips
    final filterableAccounts =
        app.accounts.where((a) => !a.isGold).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics',
            style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          // ── Account filter pills ─────────────────────────────────────
          if (filterableAccounts.length > 1) ...[
            SizedBox(
              height: 34,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _FilterPill(
                    label: 'All accounts',
                    color: const Color(0xFF6750A4),
                    selected: _filterAccountId == null,
                    onTap: () => setState(() => _filterAccountId = null),
                  ),
                  ...filterableAccounts.map((a) => Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: _FilterPill(
                      label: a.name,
                      color: Color(a.colorValue),
                      selected: _filterAccountId == a.id,
                      onTap: () => setState(() => _filterAccountId = a.id),
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          // ── Month nav ────────────────────────────────────────────────
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
              icon: const Icon(Icons.chevron_left_rounded),
              onPressed: () => setState(() =>
                  _month = DateTime(_month.year, _month.month - 1))),
            Text(DateFormat('MMMM yyyy').format(_month),
                style: const TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 16)),
            IconButton(
              icon: const Icon(Icons.chevron_right_rounded),
              onPressed: () => setState(() =>
                  _month = DateTime(_month.year, _month.month + 1))),
          ]),

          // ── Summary cards ─────────────────────────────────────────────
          Row(children: [
            Expanded(child: _StatCard(label: 'Income', value: fmt(income),
                color: const Color(0xFF2E7D32))),
            const SizedBox(width: 8),
            Expanded(child: _StatCard(label: 'Expenses', value: fmt(expense),
                color: const Color(0xFFC62828))),
            const SizedBox(width: 8),
            Expanded(child: _StatCard(
                label: 'Net', value: fmt(income - expense),
                color: income >= expense
                    ? const Color(0xFF1565C0)
                    : const Color(0xFF785900))),
          ]),
          const SizedBox(height: 20),

          // ── 6-month bar chart ─────────────────────────────────────────
          Card(child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text(
                _filterAccountId != null
                    ? '6-Month Overview · ${app.accountById(_filterAccountId!)?.name ?? ''}'
                    : '6-Month Overview',
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 14)),
              const SizedBox(height: 4),
              const Row(children: [
                _Legend(color: Color(0xFF2E7D32), label: 'Income'),
                SizedBox(width: 12),
                _Legend(color: Color(0xFFC62828), label: 'Expense'),
              ]),
              const SizedBox(height: 12),
              SizedBox(
                height: 160,
                child: BarChart(BarChartData(
                  barGroups: barGroups(),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        getTitlesWidget: (val, _) {
                          final idx = val.toInt();
                          if (idx < 0 || idx >= months.length) {
                            return const SizedBox();
                          }
                          return Text(
                            DateFormat('MMM').format(months[idx]),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ),
                )),
              ),
            ]),
          )),
          const SizedBox(height: 16),

          // ── Expense pie ───────────────────────────────────────────────
          if (expBycat.isNotEmpty)
            Card(child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const Text('Expenses by Category',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: PieChart(PieChartData(
                    sections: expBycat.entries
                        .toList()
                        .asMap()
                        .entries
                        .map((e) {
                      final colors = [
                        const Color(0xFF1565C0),
                        const Color(0xFFC62828),
                        const Color(0xFF2E7D32),
                        const Color(0xFF785900),
                        const Color(0xFF4527A0),
                        const Color(0xFF00838F),
                        const Color(0xFF880E4F),
                        const Color(0xFF37474F),
                      ];
                      final color = colors[e.key % colors.length];
                      final pct = expense > 0
                          ? (e.value.value / expense * 100)
                          : 0.0;
                      return PieChartSectionData(
                        value: e.value.value,
                        color: color,
                        radius: 60,
                        title: '${pct.toStringAsFixed(0)}%',
                        titleStyle: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      );
                    }).toList(),
                    sectionsSpace: 2,
                    centerSpaceRadius: 32,
                  )),
                ),
                const SizedBox(height: 10),

                // Legend with optional budget bar
                ...expBycat.entries.toList().asMap().entries.map((e) {
                  final colors = [
                    const Color(0xFF1565C0), const Color(0xFFC62828),
                    const Color(0xFF2E7D32), const Color(0xFF785900),
                    const Color(0xFF4527A0), const Color(0xFF00838F),
                    const Color(0xFF880E4F), const Color(0xFF37474F),
                  ];
                  final catId = expBycatId[e.value.key];
                  final budget = catId != null
                      ? app.budgetForCategory(catId)
                      : null;
                  final progress = budget != null
                      ? app.budgetProgress(budget)
                      : null;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(children: [
                        Container(
                            width: 10, height: 10,
                            decoration: BoxDecoration(
                                color: colors[e.key % colors.length],
                                shape: BoxShape.circle)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(e.value.key,
                              style: const TextStyle(fontSize: 11)),
                        ),
                        if (budget != null)
                          Text(
                            '${(progress! * 100).toStringAsFixed(0)}% of budget',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: progress >= 1.0
                                  ? cs.error
                                  : progress >= 0.75
                                      ? Colors.orange
                                      : cs.primary,
                            ),
                          ),
                      ]),
                      // Budget mini-bar under this category's legend row
                      if (budget != null) ...[
                        const SizedBox(height: 3),
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: LinearProgressIndicator(
                              value: progress!.clamp(0.0, 1.0),
                              minHeight: 3,
                              backgroundColor:
                                  cs.primary.withValues(alpha: 0.1),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  progress >= 1.0
                                      ? cs.error
                                      : progress >= 0.75
                                          ? Colors.orange
                                          : cs.primary),
                            ),
                          ),
                        ),
                      ],
                    ]),
                  );
                }),
              ]),
            )),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label, value;
  final Color color;
  const _StatCard(
      {required this.label, required this.value, required this.color});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.25))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style: TextStyle(
                  fontSize: 11, color: color, fontWeight: FontWeight.w600)),
          const SizedBox(height: 3),
          Text(value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: color)),
        ]),
      );
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});
  @override
  Widget build(BuildContext context) =>
      Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
            width: 10,
            height: 10,
            decoration:
                BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11)),
      ]);
}

/// Coloured filter pill — solid fill when selected, tinted border + text idle.
/// Matches the style used in TransactionsScreen.
class _FilterPill extends StatelessWidget {
  final String label;
  final Color color;
  final bool selected;
  final VoidCallback onTap;
  const _FilterPill({
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? color : color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? color : color.withValues(alpha: 0.45),
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : color,
          ),
        ),
      ),
    );
  }
}
