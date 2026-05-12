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

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    String fmt(double v) => formatAmount(v, app.settings.currency);

    final mStart = DateTime(_month.year, _month.month, 1);
    final mEnd   = DateTime(_month.year, _month.month + 1, 0, 23, 59, 59);
    final mTxs   = app.transactions
        .where((t) => !t.date.isBefore(mStart) && !t.date.isAfter(mEnd))
        .toList();

    final income  = mTxs.where((t) => t.type == 'income')
        .fold(0.0, (s, t) => s + t.amount);
    final expense = mTxs.where((t) => t.type == 'expense')
        .fold(0.0, (s, t) => s + t.amount);

    // 6-month bar data
    final now    = DateTime.now();
    final months = List.generate(6, (i) =>
        DateTime(now.year, now.month - 5 + i, 1));

    List<BarChartGroupData> barGroups() => months.map((m) {
      final mE = DateTime(m.year, m.month + 1, 0, 23, 59, 59);
      final txs = app.transactions
          .where((t) => !t.date.isBefore(m) && !t.date.isAfter(mE))
          .toList();
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

    // Expense pie
    final expBycat = <String, double>{};
    for (final t in mTxs.where((t) => t.type == 'expense')) {
      final cat = app.categoryById(t.categoryId)?.name ?? 'Other';
      expBycat[cat] = (expBycat[cat] ?? 0) + t.amount;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Month nav
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(icon: const Icon(Icons.chevron_left_rounded),
                onPressed: () => setState(() =>
                    _month = DateTime(_month.year, _month.month - 1))),
            Text(DateFormat('MMMM yyyy').format(_month),
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            IconButton(icon: const Icon(Icons.chevron_right_rounded),
                onPressed: () => setState(() =>
                    _month = DateTime(_month.year, _month.month + 1))),
          ]),

          // Summary
          Row(children: [
            Expanded(child: _StatCard(label: 'Income', value: fmt(income),
                color: const Color(0xFF2E7D32))),
            const SizedBox(width: 8),
            Expanded(child: _StatCard(label: 'Expenses', value: fmt(expense),
                color: const Color(0xFFC62828))),
            const SizedBox(width: 8),
            Expanded(child: _StatCard(label: 'Net', value: fmt(income - expense),
                color: income >= expense ? const Color(0xFF1565C0) : const Color(0xFF785900))),
          ]),
          const SizedBox(height: 20),

          // Bar chart
          Card(child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('6-Month Overview',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
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
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(sideTitles: SideTitles(
                      showTitles: true, reservedSize: 22,
                      getTitlesWidget: (val, _) {
                        final idx = val.toInt();
                        if (idx < 0 || idx >= months.length) return const SizedBox();
                        return Text(DateFormat('MMM').format(months[idx]),
                            style: const TextStyle(fontSize: 10));
                      },
                    )),
                  ),
                )),
              ),
            ]),
          )),
          const SizedBox(height: 16),

          // Pie chart
          if (expBycat.isNotEmpty)
            Card(child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Expenses by Category',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: PieChart(PieChartData(
                    sections: expBycat.entries.toList().asMap().entries.map((e) {
                      final colors = [
                        const Color(0xFF1565C0), const Color(0xFFC62828),
                        const Color(0xFF2E7D32), const Color(0xFF785900),
                        const Color(0xFF4527A0), const Color(0xFF00838F),
                        const Color(0xFF880E4F), const Color(0xFF37474F),
                      ];
                      final color = colors[e.key % colors.length];
                      final pct = expense > 0
                          ? (e.value.value / expense * 100) : 0.0;
                      return PieChartSectionData(
                        value: e.value.value,
                        color: color,
                        radius: 60,
                        title: '${pct.toStringAsFixed(0)}%',
                        titleStyle: const TextStyle(fontSize: 11,
                            fontWeight: FontWeight.w700, color: Colors.white),
                      );
                    }).toList(),
                    sectionsSpace: 2,
                    centerSpaceRadius: 32,
                  )),
                ),
                const SizedBox(height: 10),
                Wrap(spacing: 10, runSpacing: 6,
                    children: expBycat.entries.toList().asMap().entries.map((e) {
                      final colors = [
                        const Color(0xFF1565C0), const Color(0xFFC62828),
                        const Color(0xFF2E7D32), const Color(0xFF785900),
                        const Color(0xFF4527A0), const Color(0xFF00838F),
                        const Color(0xFF880E4F), const Color(0xFF37474F),
                      ];
                      return Row(mainAxisSize: MainAxisSize.min, children: [
                        Container(width: 10, height: 10,
                            decoration: BoxDecoration(
                                color: colors[e.key % colors.length],
                                shape: BoxShape.circle)),
                        const SizedBox(width: 4),
                        Text(e.value.key, style: const TextStyle(fontSize: 11)),
                      ]);
                    }).toList()),
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
  const _StatCard({required this.label, required this.value, required this.color});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.25))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: TextStyle(fontSize: 11, color: color,
              fontWeight: FontWeight.w600)),
          const SizedBox(height: 3),
          Text(value, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800,
                  color: color)),
        ]),
      );
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min,
      children: [
    Container(width: 10, height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
    const SizedBox(width: 4),
    Text(label, style: const TextStyle(fontSize: 11)),
  ]);
}
