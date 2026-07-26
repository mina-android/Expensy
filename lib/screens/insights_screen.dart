// lib/screens/insights_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  // ── Data helpers ──────────────────────────────────────────────────────

  static List<AppTransaction> _txsInMonth(AppProvider app, DateTime month) {
    final start = DateTime(month.year, month.month, 1);
    final end   = DateTime(month.year, month.month + 1, 0, 23, 59, 59);
    return app.transactions
        .where((t) => !t.date.isBefore(start) && !t.date.isAfter(end))
        .toList();
  }

  static double _converted(AppProvider app, AppTransaction t) {
    final acct = app.accountById(t.accountId);
    final cur  = t.currency.isNotEmpty
        ? t.currency
        : (acct?.currency ?? app.settings.currency);
    return app.convertToMain(t.amount, cur);
  }

  static double _sum(AppProvider app, List<AppTransaction> txs, String type) =>
      txs.where((t) => t.type == type).fold(0.0, (s, t) => s + _converted(app, t));

  static Map<String, double> _byCategory(
      AppProvider app, List<AppTransaction> txs, String type, String otherLabel) {
    final map = <String, double>{};
    for (final t in txs.where((t) => t.type == type)) {
      final cat = app.categoryById(t.categoryId)?.name ?? otherLabel;
      map[cat] = (map[cat] ?? 0) + _converted(app, t);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    final cur = app.settings.currency;
    String fmt(double v) => formatAmount(v, cur);

    if (app.transactions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.insights_insights,
              style: TextStyle(fontWeight: FontWeight.w800)),
          backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
        ),
        body: EmptyState(
          icon: Icons.insights_outlined,
          message: l10n.insights_noDataYet,
          subMessage: l10n.insights_addSomeTransactions,
        ),
      );
    }

    final now       = DateTime.now();
    final thisMonth = _txsInMonth(app, now);
    final lastMonth = _txsInMonth(app, DateTime(now.year, now.month - 1));

    final thisExp  = _sum(app, thisMonth, 'expense');
    final lastExp  = _sum(app, lastMonth, 'expense');
    final thisInc  = _sum(app, thisMonth, 'income');
    final pctChange = lastExp > 0
        ? ((thisExp - lastExp) / lastExp * 100)
        : (thisExp > 0 ? 100.0 : 0.0);

    final daysElapsed  = now.day.clamp(1, 31);
    final dailyAverage = thisExp / daysElapsed;

    final thisCatMap = _byCategory(app, thisMonth, 'expense', l10n.insights_other);
    final lastCatMap = _byCategory(app, lastMonth, 'expense', l10n.insights_other);

    final topCats = (thisCatMap.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value)))
        .take(3)
        .toList();

    AppTransaction? biggestTx;
    double biggestAmt = 0;
    for (final t in thisMonth.where((t) => t.type == 'expense')) {
      final a = _converted(app, t);
      if (a > biggestAmt) { biggestAmt = a; biggestTx = t; }
    }

    // 12-month line chart data
    final months12 = List.generate(12, (i) =>
        DateTime(now.year, now.month - 11 + i));
    final expSpots = <FlSpot>[];
    final incSpots = <FlSpot>[];
    for (int i = 0; i < months12.length; i++) {
      final txs = _txsInMonth(app, months12[i]);
      expSpots.add(FlSpot(i.toDouble(), _sum(app, txs, 'expense')));
      incSpots.add(FlSpot(i.toDouble(), _sum(app, txs, 'income')));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.insights_insights,
            style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 40),
        children: [

          // ── This vs Last month ──────────────────────────────────────
          _SectionLabel(label: l10n.insights_thisMonthVsLastMonth),
          Card(child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              Expanded(child: _MonthCol(
                title: DateFormat('MMMM').format(now),
                value: fmt(thisExp),
                color: cs.primary,
              )),
              Container(width: 1, height: 48, color: cs.outlineVariant),
              Expanded(child: _MonthCol(
                title: DateFormat('MMMM').format(DateTime(now.year, now.month - 1)),
                value: fmt(lastExp),
                color: cs.onSurface.withValues(alpha: 0.45),
              )),
              const SizedBox(width: 12),
              _TrendBadge(pct: pctChange),
            ]),
          )),
          const SizedBox(height: 12),

          // ── Daily average ───────────────────────────────────────────
          _SectionLabel(label: l10n.insights_dailyAverage),
          Card(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.today_outlined, color: cs.primary, size: 22),
              ),
              const SizedBox(width: 14),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(fmt(dailyAverage),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: cs.primary)),
                Text(l10n.insights_perDayBasedOn(daysElapsed.toString()),
                    style: TextStyle(
                        fontSize: 11,
                        color: cs.onSurface.withValues(alpha: 0.5))),
              ]),
            ]),
          )),
          const SizedBox(height: 12),

          // ── Income vs Expense ratio ─────────────────────────────────
          if (thisInc > 0 || thisExp > 0) ...[
            _SectionLabel(label: l10n.insights_incomeVsExpenses),
            Card(child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                _RatioBar(income: thisInc, expense: thisExp, cs: cs),
                const SizedBox(height: 10),
                Row(children: [
                  _DotLabel(color: const Color(0xFF2E7D32), label: l10n.insights_incomeAmount(fmt(thisInc))),
                  const SizedBox(width: 14),
                  _DotLabel(color: const Color(0xFFC62828), label: l10n.insights_expensesAmount(fmt(thisExp))),
                ]),
                if (thisInc > 0 && thisInc > thisExp) ...[
                  const SizedBox(height: 6),
                  Text(
                    l10n.insights_percentSaved(((thisInc - thisExp) / thisInc * 100).toStringAsFixed(0)),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2E7D32)),
                  ),
                ],
              ]),
            )),
            const SizedBox(height: 12),
          ],

          // ── Top 3 categories ────────────────────────────────────────
          if (topCats.isNotEmpty) ...[
            _SectionLabel(label: l10n.insights_topSpendingCategories),
            Card(child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: topCats.map((e) {
                  final cat = app.categories
                      .where((c) => c.name == e.key)
                      .firstOrNull;
                  final pct = thisExp > 0 ? e.value / thisExp : 0.0;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(children: [
                      CategoryDot(category: cat, size: 36),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                            Text(e.key,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13)),
                            Text(fmt(e.value),
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: cs.primary)),
                          ]),
                          const SizedBox(height: 4),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: LinearProgressIndicator(
                              value: pct.clamp(0.0, 1.0),
                              minHeight: 4,
                              backgroundColor:
                                  cs.primary.withValues(alpha: 0.1),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                              l10n.insights_percentOfTotal((pct * 100).toStringAsFixed(1)),
                              style: TextStyle(
                                  fontSize: 10,
                                  color:
                                      cs.onSurface.withValues(alpha: 0.45))),
                        ]),
                      ),
                    ]),
                  );
                }).toList(),
              ),
            )),
            const SizedBox(height: 12),
          ],

          // ── Biggest single expense ──────────────────────────────────
          if (biggestTx != null) ...[
            _SectionLabel(label: l10n.insights_biggestExpenseThisMonth),
            Card(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(children: [
                CategoryDot(
                    category: app.categoryById(biggestTx.categoryId),
                    size: 44),
                const SizedBox(width: 12),
                Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(biggestTx.description,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14)),
                  Text(
                    DateFormat('d MMMM').format(biggestTx.date),
                    style: TextStyle(
                        fontSize: 11,
                        color: cs.onSurface.withValues(alpha: 0.5)),
                  ),
                ])),
                Text(fmt(biggestAmt),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: cs.error)),
              ]),
            )),
            const SizedBox(height: 12),
          ],

          // ── Category trends ─────────────────────────────────────────
          if (thisCatMap.isNotEmpty || lastCatMap.isNotEmpty) ...[
            _SectionLabel(label: l10n.insights_categoryTrends),
            Card(child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: _buildTrendRows(app, thisCatMap, lastCatMap, cs, fmt),
              ),
            )),
            const SizedBox(height: 12),
          ],

          // ── 12-month trend chart ─────────────────────────────────────
          _SectionLabel(label: l10n.insights_12MonthTrend),
          Card(child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Row(children: [
                _DotLabel(
                    color: const Color(0xFF2E7D32), label: l10n.insights_incomeLabel),
                const SizedBox(width: 12),
                _DotLabel(
                    color: const Color(0xFFC62828), label: l10n.insights_expensesLabel),
              ]),
              const SizedBox(height: 12),
              SizedBox(
                height: 160,
                child: LineChart(LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: incSpots,
                      isCurved: true,
                      color: const Color(0xFF2E7D32),
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: const Color(0xFF2E7D32).withValues(alpha: 0.08),
                      ),
                    ),
                    LineChartBarData(
                      spots: expSpots,
                      isCurved: true,
                      color: const Color(0xFFC62828),
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: const Color(0xFFC62828).withValues(alpha: 0.08),
                      ),
                    ),
                  ],
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
                        interval: 2,
                        getTitlesWidget: (val, _) {
                          final idx = val.toInt();
                          if (idx < 0 || idx >= months12.length) {
                            return const SizedBox();
                          }
                          return Text(
                            DateFormat('MMM').format(months12[idx]),
                            style: const TextStyle(fontSize: 9),
                          );
                        },
                      ),
                    ),
                  ),
                )),
              ),
            ]),
          )),
        ],
      ),
    );
  }

  List<Widget> _buildTrendRows(
    AppProvider app,
    Map<String, double> current,
    Map<String, double> previous,
    ColorScheme cs,
    String Function(double) fmt,
  ) {
    final allCats = {...current.keys, ...previous.keys}.toList()
      ..sort((a, b) =>
          (current[b] ?? 0).compareTo(current[a] ?? 0));

    return allCats.take(6).map((catName) {
      final cur = current[catName] ?? 0;
      final prev = previous[catName] ?? 0;
      final cat = app.categories.where((c) => c.name == catName).firstOrNull;

      final double pct;
      final Color trendColor;
      final IconData trendIcon;
      if (prev == 0 && cur > 0) {
        pct = 100;
        trendColor = const Color(0xFFC62828);
        trendIcon = Icons.arrow_upward_rounded;
      } else if (cur == 0 && prev > 0) {
        pct = -100;
        trendColor = const Color(0xFF2E7D32);
        trendIcon = Icons.arrow_downward_rounded;
      } else if (prev > 0) {
        pct = (cur - prev) / prev * 100;
        trendColor = pct > 0
            ? const Color(0xFFC62828)
            : const Color(0xFF2E7D32);
        trendIcon = pct > 0
            ? Icons.arrow_upward_rounded
            : Icons.arrow_downward_rounded;
      } else {
        pct = 0;
        trendColor = cs.onSurface.withValues(alpha: 0.4);
        trendIcon = Icons.remove_rounded;
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(children: [
          CategoryDot(category: cat, size: 32),
          const SizedBox(width: 10),
          Expanded(child: Text(catName,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
          Text(fmt(cur),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: trendColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(trendIcon, size: 10, color: trendColor),
              const SizedBox(width: 2),
              Text(
                '${pct.abs().toStringAsFixed(0)}%',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: trendColor),
              ),
            ]),
          ),
        ]),
      );
    }).toList();
  }
}

// ── Private widgets ───────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(label.toUpperCase(),
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.45))),
      );
}

class _MonthCol extends StatelessWidget {
  final String title, value;
  final Color color;
  const _MonthCol({required this.title, required this.value, required this.color});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.5))),
          const SizedBox(height: 2),
          Text(value,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w800, color: color)),
        ]),
      );
}

class _TrendBadge extends StatelessWidget {
  final double pct;
  const _TrendBadge({required this.pct});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isUp = pct > 0;
    final isFlat = pct == 0;
    final color = isFlat
        ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4)
        : isUp
            ? const Color(0xFFC62828)
            : const Color(0xFF2E7D32);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(
          isFlat
              ? Icons.remove_rounded
              : isUp
                  ? Icons.arrow_upward_rounded
                  : Icons.arrow_downward_rounded,
          size: 14,
          color: color,
        ),
        Text(
          '${pct.abs().toStringAsFixed(0)}%',
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w800, color: color),
        ),
      ]),
    );
  }
}

class _RatioBar extends StatelessWidget {
  final double income, expense;
  final ColorScheme cs;
  const _RatioBar({required this.income, required this.expense, required this.cs});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final total = income + expense;
    if (total == 0) return const SizedBox();
    final incRatio = income / total;
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: SizedBox(
        height: 14,
        child: Row(children: [
          Expanded(
            flex: (incRatio * 100).round(),
            child: Container(color: const Color(0xFF2E7D32)),
          ),
          Expanded(
            flex: ((1 - incRatio) * 100).round().clamp(0, 100),
            child: Container(color: const Color(0xFFC62828)),
          ),
        ]),
      ),
    );
  }
}

class _DotLabel extends StatelessWidget {
  final Color color;
  final String label;
  const _DotLabel({required this.color, required this.label});
  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 10,
              height: 10,
              decoration:
                  BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 11)),
        ],
      );
}
