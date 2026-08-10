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
import 'package:flutter/foundation.dart';
import '../database/db_helper.dart';
import '../services/exchange_rate_service.dart';
import 'net_worth_screen.dart';
import '../utils/haptics.dart';

class _ComputePayload {
  final List<AppTransaction> txs;
  final String mainCurrency;
  final Map<String, double> rates;
  final Map<String, String> accountCurrencies;
  final DateTime now;
  final Map<String, String> categoryNames;
  
  _ComputePayload({
    required this.txs,
    required this.mainCurrency,
    required this.rates,
    required this.accountCurrencies,
    required this.now,
    required this.categoryNames,
  });
}

class _InsightsData {
  final List<AppTransaction> thisMonth;
  final List<AppTransaction> lastMonth;
  final double thisExp;
  final double lastExp;
  final double thisInc;
  final double pctChange;
  final double dailyAverage;
  final int daysElapsed;
  final Map<String, double> thisCatMap;
  final Map<String, double> lastCatMap;
  final List<MapEntry<String, double>> topCats;
  final AppTransaction? biggestTx;
  final double biggestAmt;
  final List<DateTime> months12;
  final List<FlSpot> expSpots;
  final List<FlSpot> incSpots;

  _InsightsData({
    required this.thisMonth, required this.lastMonth, required this.thisExp, required this.lastExp,
    required this.thisInc, required this.pctChange, required this.dailyAverage, required this.daysElapsed,
    required this.thisCatMap, required this.lastCatMap, required this.topCats,
    this.biggestTx, required this.biggestAmt,
    required this.months12, required this.expSpots, required this.incSpots,
  });
}

_InsightsData _computeInsights(_ComputePayload p) {
  List<AppTransaction> txsInMonth(DateTime month) {
    final start = DateTime(month.year, month.month, 1);
    final end   = DateTime(month.year, month.month + 1, 0, 23, 59, 59);
    return p.txs.where((t) => !t.date.isBefore(start) && !t.date.isAfter(end)).toList();
  }
  
  final er = ExchangeRateService();
  double converted(AppTransaction t) {
    final acctCur = p.accountCurrencies[t.accountId];
    final cur = t.currency.isNotEmpty ? t.currency : (acctCur ?? p.mainCurrency);
    if (cur == p.mainCurrency || p.rates.isEmpty) return t.amount;
    return er.convert(t.amount, cur, p.mainCurrency, p.rates) ?? t.amount;
  }

  double sum(List<AppTransaction> ts, String type) =>
      ts.where((t) => t.type == type).fold(0.0, (s, t) => s + converted(t));

  Map<String, double> byCategory(List<AppTransaction> ts, String type, String otherLabel) {
    final map = <String, double>{};
    for (final t in ts.where((x) => x.type == type)) {
      final cat = p.categoryNames[t.categoryId] ?? otherLabel;
      map[cat] = (map[cat] ?? 0) + converted(t);
    }
    return map;
  }
  
  final thisMonth = txsInMonth(p.now);
  final lastMonth = txsInMonth(DateTime(p.now.year, p.now.month - 1));
  
  final thisExp = sum(thisMonth, 'expense');
  final lastExp = sum(lastMonth, 'expense');
  final thisInc = sum(thisMonth, 'income');
  final pctChange = lastExp > 0 ? ((thisExp - lastExp) / lastExp * 100) : (thisExp > 0 ? 100.0 : 0.0);
  final daysElapsed = p.now.day.clamp(1, 31);
  final dailyAverage = thisExp / daysElapsed;
  
  final thisCatMap = byCategory(thisMonth, 'expense', 'Other');
  final lastCatMap = byCategory(lastMonth, 'expense', 'Other');
  
  final topCats = (thisCatMap.entries.toList()..sort((a, b) => b.value.compareTo(a.value))).take(3).toList();
  
  AppTransaction? biggestTx;
  double biggestAmt = 0;
  for (final t in thisMonth.where((t) => t.type == 'expense')) {
    final a = converted(t);
    if (a > biggestAmt) { biggestAmt = a; biggestTx = t; }
  }
  
  final months12 = List.generate(12, (i) => DateTime(p.now.year, p.now.month - 11 + i));
  final expSpots = <FlSpot>[];
  final incSpots = <FlSpot>[];
  for (int i = 0; i < months12.length; i++) {
    final ts = txsInMonth(months12[i]);
    expSpots.add(FlSpot(i.toDouble(), sum(ts, 'expense')));
    incSpots.add(FlSpot(i.toDouble(), sum(ts, 'income')));
  }

  return _InsightsData(
    thisMonth: thisMonth, lastMonth: lastMonth, thisExp: thisExp, lastExp: lastExp,
    thisInc: thisInc, pctChange: pctChange, dailyAverage: dailyAverage, daysElapsed: daysElapsed,
    thisCatMap: thisCatMap, lastCatMap: lastCatMap, topCats: topCats, biggestTx: biggestTx, biggestAmt: biggestAmt,
    months12: months12, expSpots: expSpots, incSpots: incSpots,
  );
}

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  bool _isLoading = true;
  _InsightsData? _data;
  int _lastTxLength = -1;
  int _lastLoadTime = 0;

  Future<void> _loadData() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    final app = context.read<AppProvider>();
    
    final allTxs = await DBHelper.getTransactions(limit: null); 

    final payload = _ComputePayload(
      txs: allTxs,
      mainCurrency: app.settings.currency,
      rates: app.exchangeRates,
      accountCurrencies: { for (var a in app.accounts) a.id: a.currency },
      now: DateTime.now(),
      categoryNames: { for (var c in app.categories) c.id: c.name },
    );

    final data = await compute(_computeInsights, payload);
    
    if (mounted) {
      setState(() {
        _data = data;
        _isLoading = false;
        _lastLoadTime = DateTime.now().millisecondsSinceEpoch;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    final cur = app.settings.currency;
    String fmt(double v) => formatAmount(v, cur);

    // Trigger reload if transactions changed
    if (_lastTxLength != app.transactions.length) {
      _lastTxLength = app.transactions.length;
      if (DateTime.now().millisecondsSinceEpoch - _lastLoadTime > 100) {
        Future.microtask(_loadData);
      }
    }

    if (app.transactions.isEmpty && !_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.insights_insights,
              style: const TextStyle(fontWeight: FontWeight.w800)),
          backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
        ),
        body: EmptyState(
          icon: Icons.insights_outlined,
          message: l10n.insights_noDataYet,
          subMessage: l10n.insights_addSomeTransactions,
        ),
      );
    }
    
    if (_isLoading || _data == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.insights_insights,
              style: const TextStyle(fontWeight: FontWeight.w800)),
          backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    
    final data = _data!;
    final now = DateTime.now();
    final thisExp = data.thisExp;
    final lastExp = data.lastExp;
    final thisInc = data.thisInc;
    final pctChange = data.pctChange;
    final dailyAverage = data.dailyAverage;
    final daysElapsed = data.daysElapsed;
    final thisCatMap = data.thisCatMap;
    final lastCatMap = data.lastCatMap;
    final topCats = data.topCats;
    final biggestTx = data.biggestTx;
    final biggestAmt = data.biggestAmt;
    final months12 = data.months12;
    final incSpots = data.incSpots;
    final expSpots = data.expSpots;

    final daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);
    final projectedTotal = dailyAverage * daysInMonth;
    final remainingDays = daysInMonth - daysElapsed;
    final totalBudget = app.budgets.fold(0.0, (s, b) => s + b.amount);
    final forecastColor = totalBudget > 0
        ? (projectedTotal >= totalBudget
            ? cs.error
            : (projectedTotal >= totalBudget * 0.75
                ? Colors.orange
                : cs.primary))
        : cs.primary;

    final liveTotalAccounts = app.totalBalanceAll;
    final liveTotalAssets = app.totalAssetsValue;
    final liveNetWorth = liveTotalAccounts + liveTotalAssets;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.insights_insights,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: RefreshIndicator(
        onRefresh: app.refreshRates,
        child: ListView(
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

          // ── Spending Forecast ───────────────────────────────────────
          if (daysElapsed >= 3) ...[
            const _SectionLabel(label: 'Spending Forecast'),
            Card(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: cs.tertiaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.insights_rounded,
                      color: cs.tertiary, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: cs.onSurface),
                          children: [
                            const TextSpan(
                                text: 'At this rate, you\'ll spend '),
                            TextSpan(
                                text: fmt(projectedTotal),
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: forecastColor)),
                            TextSpan(
                                text:
                                    ' by the end of ${DateFormat('MMMM').format(now)} — $remainingDays days left.'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Projection based on spending so far, doesn\'t include upcoming recurring bills.',
                        style: TextStyle(
                            fontSize: 11,
                            color: cs.onSurface.withValues(alpha: 0.5)),
                      ),
                    ])),
              ]),
            )),
            const SizedBox(height: 12),
          ] else ...[
            const _SectionLabel(label: 'Spending Forecast'),
            Card(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(children: [
                Icon(Icons.info_outline,
                    size: 20, color: cs.onSurface.withValues(alpha: 0.5)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Based on the first $daysElapsed days — accuracy improves as the month goes on.',
                    style: TextStyle(
                        fontSize: 12,
                        color: cs.onSurface.withValues(alpha: 0.6)),
                  ),
                ),
              ]),
            )),
            const SizedBox(height: 12),
          ],

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
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2E7D32)),
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
                children: [
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: topCats.asMap().entries.map((entry) {
                          final i = entry.key;
                          final e = entry.value;
                          final color = i == 0 
                              ? cs.primary 
                              : (i == 1 ? cs.secondary : cs.tertiary);
                          return PieChartSectionData(
                            value: e.value,
                            title: '${(e.value / thisExp * 100).toStringAsFixed(0)}%',
                            radius: 50,
                            titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            color: color,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          l10n.insights_percentOfTotal(
                                              (pct * 100).toStringAsFixed(1)),
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: cs.onSurface
                                                  .withValues(alpha: 0.45))),
                                      if (daysElapsed >= 3)
                                        Builder(builder: (ctx) {
                                          final catDaily = e.value / daysElapsed;
                                          final catProj = catDaily * daysInMonth;
                                          final catBudget = app
                                                  .budgetForCategory(cat?.id ?? '')
                                                  ?.amount ??
                                              0;
                                          String txt = 'Proj: ${fmt(catProj)}';
                                          if (catBudget > 0) {
                                            final projPct =
                                                (catProj / catBudget * 100)
                                                    .toStringAsFixed(0);
                                            txt += ' ($projPct% of budget)';
                                          }
                                          final cColor = catBudget > 0
                                              ? (catProj >= catBudget
                                                  ? cs.error
                                                  : (catProj >= catBudget * 0.75
                                                      ? Colors.orange
                                                      : cs.onSurface
                                                          .withValues(alpha: 0.45)))
                                              : cs.onSurface
                                                  .withValues(alpha: 0.45);
                                          return Text(
                                            txt,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: cColor,
                                                fontWeight: FontWeight.w600),
                                          );
                                        }),
                                    ],
                                  ),
                                ]),
                          ),
                        ]),
                      );
                    }).toList(),
                  ),
                ],
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

          // ── Net Worth ───────────────────────────────────────────────
          if (app.netWorthSnapshots.isNotEmpty || liveNetWorth != 0) ...[
            const _SectionLabel(label: 'Net Worth'),
            Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  AppHaptics.tap(context, HapticStrength.light);
                  Navigator.push(context, ExpensyRoute(builder: (_) => const NetWorthScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Current Net Worth',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: cs.onSurface.withValues(alpha: 0.5))),
                      const SizedBox(height: 4),
                      Text(fmt(liveNetWorth),
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: cs.primary)),
                      const SizedBox(height: 12),
                      if (app.netWorthSnapshots.isNotEmpty) ...[
                        Builder(builder: (context) {
                          final spots = <FlSpot>[];
                          for (int i = 0; i < app.netWorthSnapshots.length; i++) {
                            spots.add(FlSpot(i.toDouble(), app.netWorthSnapshots[i].netWorth));
                          }
                          // Append live point to show immediate changes
                          spots.add(FlSpot(app.netWorthSnapshots.length.toDouble(), liveNetWorth));

                          return SizedBox(
                            height: 80,
                            child: LineChart(LineChartData(
                              lineBarsData: [
                                LineChartBarData(
                                  spots: spots,
                                  isCurved: true,
                                  color: cs.primary,
                                  barWidth: 2,
                                  dotData: const FlDotData(show: false),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: cs.primary.withValues(alpha: 0.1),
                                  ),
                                ),
                              ],
                              gridData: const FlGridData(show: false),
                              borderData: FlBorderData(show: false),
                              titlesData: const FlTitlesData(show: false),
                              lineTouchData: const LineTouchData(enabled: false),
                            )),
                          );
                        }),
                        const SizedBox(height: 12),
                      ],
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: cs.primaryContainer.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Accounts & Gold',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: cs.onSurface
                                                .withValues(alpha: 0.55))),
                                    const SizedBox(height: 2),
                                    Text(
                                        fmt(liveTotalAccounts),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                            color: cs.primary)),
                                  ]),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: cs.tertiaryContainer.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Assets',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: cs.onSurface
                                                .withValues(alpha: 0.55))),
                                    const SizedBox(height: 2),
                                    Text(
                                        fmt(liveTotalAssets),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                            color: cs.tertiary)),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],

          // ── Loans ────────────────────────────────────────────────────
          if (app.loans.isNotEmpty) ...[
            const _SectionLabel(label: 'Loans'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Outstanding',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: cs.onSurface.withValues(alpha: 0.5),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                fmt(app.totalOutstandingLoanDebt),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: cs.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Monthly Obligation',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: cs.onSurface.withValues(alpha: 0.5),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                fmt(app.totalMonthlyLoanObligation),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: cs.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...app.loans.where((l) => !l.isSettled).map((l) {
                      final progress = app.loanProgress(l);
                      final Color barColor;
                      if (progress >= 0.8) {
                        barColor = const Color(0xFF2E7D32); // Green
                      } else if (progress >= 0.4) barColor = const Color(0xFFE65100); // Orange
                      else barColor = const Color(0xFFC62828); // Red

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(l.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                                Text(
                                  '${(progress * 100).toStringAsFixed(0)}%',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                    color: barColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            LinearProgressCard(value: progress, color: barColor),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],

        ],
      ),
    ));
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
