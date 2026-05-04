// lib/screens/statistics_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});
  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late int _month;
  late int _year;
  static const _months = [
    '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = now.month;
    _year = now.year;
  }

  void _prev() => setState(() {
        if (_month == 1) { _month = 12; _year--; } else { _month--; }
      });
  void _next() => setState(() {
        if (_month == 12) { _month = 1; _year++; } else { _month++; }
      });

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    final currency = app.settings.currency;
    String fmt(double v) => formatAmount(v, currency);

    final monthTx = app.transactions.where((t) =>
        t.date.month == _month && t.date.year == _year).toList();
    final income = monthTx.where((t) => t.type == 'income')
        .fold(0.0, (s, t) => s + t.amount);
    final expense = monthTx.where((t) => t.type == 'expense')
        .fold(0.0, (s, t) => s + t.amount);
    final net = income - expense;

    // 6-month bar data
    final barGroups = <BarChartGroupData>[];
    final barLabels = <String>[];
    for (int i = 5; i >= 0; i--) {
      int m = _month - i;
      int y = _year;
      while (m <= 0) { m += 12; y--; }
      final txs = app.transactions
          .where((t) => t.date.month == m && t.date.year == y);
      final inc = txs.where((t) => t.type == 'income')
          .fold(0.0, (s, t) => s + t.amount);
      final exp = txs.where((t) => t.type == 'expense')
          .fold(0.0, (s, t) => s + t.amount);
      barLabels.add(_months[m]);
      barGroups.add(BarChartGroupData(
        x: 5 - i,
        barRods: [
          BarChartRodData(
              toY: inc,
              color: const Color(0xFF4CAF50),
              width: 8,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(4))),
          BarChartRodData(
              toY: exp,
              color: const Color(0xFFF44336),
              width: 8,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(4))),
        ],
      ));
    }

    // Pie data
    final catMap = <String, Map<String, dynamic>>{};
    for (final t in monthTx.where((t) => t.type == 'expense')) {
      final cat = app.categoryById(t.categoryId);
      if (cat != null) {
        catMap[cat.id] ??= {'name': cat.name, 'color': cat.colorValue, 'total': 0.0};
        catMap[cat.id]!['total'] =
            (catMap[cat.id]!['total'] as double) + t.amount;
      }
    }
    final pieData = catMap.values.toList()
      ..sort((a, b) => (b['total'] as double).compareTo(a['total'] as double));

    final maxY = barGroups.isEmpty
        ? 100.0
        : barGroups
            .expand((g) => g.barRods.map((r) => r.toY))
            .fold(0.0, (m, v) => v > m ? v : m) * 1.3;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        actions: [
          IconButton(icon: const Icon(Icons.chevron_left), onPressed: _prev),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Text('${_months[_month]} $_year',
                style: TextStyle(
                    color: cs.onPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14)),
          ),
          IconButton(icon: const Icon(Icons.chevron_right), onPressed: _next),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            // Summary cards
            Row(
              children: [
                _SummaryCard(label: 'Income',  value: fmt(income),  color: const Color(0xFF2E7D32), bg: const Color(0xFFE8F5E9)),
                const SizedBox(width: 10),
                _SummaryCard(label: 'Expense', value: fmt(expense), color: const Color(0xFFC62828), bg: const Color(0xFFFFEBEE)),
                const SizedBox(width: 10),
                _SummaryCard(label: 'Net',     value: fmt(net),     color: net >= 0 ? const Color(0xFF2E7D32) : const Color(0xFFC62828), bg: net >= 0 ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE)),
              ],
            ),
            const SizedBox(height: 16),

            // Bar chart
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('6-Month Overview',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Row(children: [
                      _LegendDot(color: const Color(0xFF4CAF50), label: 'Income'),
                      const SizedBox(width: 12),
                      _LegendDot(color: const Color(0xFFF44336), label: 'Expense'),
                    ]),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 180,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: maxY == 0 ? 100 : maxY,
                          barGroups: barGroups,
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
                                getTitlesWidget: (v, _) => Text(
                                    barLabels[v.toInt()],
                                    style: const TextStyle(fontSize: 10)),
                              ),
                            ),
                          ),
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                              getTooltipItem: (group, gI, rod, rI) =>
                                  BarTooltipItem(
                                      fmt(rod.toY),
                                      const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Pie chart
            if (pieData.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Expense Breakdown',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          SizedBox(
                            height: 180,
                            width: 180,
                            child: PieChart(
                              PieChartData(
                                sections: pieData.map((d) {
                                  final pct = expense > 0
                                      ? (d['total'] as double) / expense * 100
                                      : 0.0;
                                  return PieChartSectionData(
                                    value: d['total'] as double,
                                    title: '${pct.toStringAsFixed(0)}%',
                                    color: Color(d['color'] as int),
                                    radius: 70,
                                    titleStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  );
                                }).toList(),
                                sectionsSpace: 2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              children: pieData.take(7).map((d) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    child: Row(children: [
                                      Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              color: Color(d['color'] as int),
                                              shape: BoxShape.circle)),
                                      const SizedBox(width: 6),
                                      Expanded(
                                          child: Text(d['name'] as String,
                                              style: const TextStyle(fontSize: 12),
                                              overflow: TextOverflow.ellipsis)),
                                      Text(fmt(d['total'] as double),
                                          style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold)),
                                    ]),
                                  )).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label, value;
  final Color color, bg;
  const _SummaryCard({required this.label, required this.value, required this.color, required this.bg});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w700, letterSpacing: .5)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: color), overflow: TextOverflow.ellipsis),
        ]),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(width: 10, height: 10, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
      const SizedBox(width: 4),
      Text(label, style: const TextStyle(fontSize: 11)),
    ]);
  }
}
