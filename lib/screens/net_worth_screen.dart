// lib/screens/net_worth_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../utils/haptics.dart';
import '../utils/snackbar.dart';
import '../widgets/fintech_components.dart';
import 'accounts_screen.dart';
import 'assets_screen.dart';
import 'loans_screen.dart';
import 'lended_screen.dart';

class NetWorthScreen extends StatefulWidget {
  const NetWorthScreen({super.key});

  @override
  State<NetWorthScreen> createState() => _NetWorthScreenState();
}

class _NetWorthScreenState extends State<NetWorthScreen> {
  String _selectedRange = '30D';
  bool _showAllHistory = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final app = context.watch<AppProvider>();

    final currency = app.settings.currency;
    String fmt(double v) => formatAmount(v, currency);

    final totalAssets = app.totalWealthAssets;
    final totalLiabilities = app.totalWealthLiabilities;
    final liveNetWorth = app.liveNetWorth;
    final snapshots = app.netWorthSnapshots;

    // Filter snapshots based on selected time range
    final now = DateTime.now();
    DateTime? cutoff;
    switch (_selectedRange) {
      case '7D':
        cutoff = now.subtract(const Duration(days: 7));
        break;
      case '30D':
        cutoff = now.subtract(const Duration(days: 30));
        break;
      case '90D':
        cutoff = now.subtract(const Duration(days: 90));
        break;
      case '1Y':
        cutoff = DateTime(now.year - 1, now.month, now.day);
        break;
      case 'ALL':
      default:
        cutoff = null;
        break;
    }

    final filteredSnaps = cutoff == null
        ? snapshots.toList()
        : snapshots.where((s) {
            final d = DateTime.tryParse(s.date);
            return d != null && !d.isBefore(cutoff!);
          }).toList();

    // Chart points: filtered snapshots + live current point
    final chartPoints = <_ChartDataPoint>[];
    for (final s in filteredSnaps) {
      chartPoints.add(_ChartDataPoint(date: s.date, value: s.netWorth));
    }
    final todayStr = DateFormat('yyyy-MM-dd').format(now);
    if (chartPoints.isEmpty || chartPoints.last.date != todayStr) {
      chartPoints.add(_ChartDataPoint(date: todayStr, value: liveNetWorth));
    } else {
      // Update today's live point value in chart
      chartPoints[chartPoints.length - 1] =
          _ChartDataPoint(date: todayStr, value: liveNetWorth);
    }

    final spots = <FlSpot>[];
    for (int i = 0; i < chartPoints.length; i++) {
      spots.add(FlSpot(i.toDouble(), chartPoints[i].value));
    }

    final netWorthColor = liveNetWorth >= 0 ? cs.primary : cs.error;
    final debtRatio = totalAssets > 0
        ? ((totalLiabilities / totalAssets) * 100).clamp(0.0, 100.0)
        : (totalLiabilities > 0 ? 100.0 : 0.0);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.netWorth_title,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FintechCircleButton(
              icon: Icons.camera_alt_outlined,
              tooltip: l10n.netWorth_recordSnapshot,
              onPressed: () async {
                AppHaptics.tap(context, HapticStrength.light);
                await app.recordNetWorthSnapshot();
                if (context.mounted) {
                  showAppSnackbar(
                    context,
                    '${l10n.netWorth_current}: ${fmt(liveNetWorth)} (${l10n.netWorth_snapshotRecorded})',
                  );
                }
              },
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 140),
        children: [
          // ── Hero Card: Live Net Worth ─────────────────────────────
          FintechHeroCard(
            accentColor: const Color(0xFF00897B),
            margin: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.netWorth_current.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: cs.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: totalLiabilities == 0
                            ? const Color(0xFF2E7D32).withValues(alpha: 0.15)
                            : cs.errorContainer.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        totalLiabilities == 0
                            ? 'Debt-free'
                            : '${l10n.netWorth_debtRatio}: ${debtRatio.toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: totalLiabilities == 0
                              ? (isDark ? const Color(0xFF81C784) : const Color(0xFF2E7D32))
                              : cs.error,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  fmt(liveNetWorth),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: netWorthColor,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E7D32).withValues(alpha: isDark ? 0.2 : 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF2E7D32).withValues(alpha: isDark ? 0.35 : 0.25),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.arrow_upward_rounded,
                                    size: 14, color: Color(0xFF2E7D32)),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    l10n.netWorth_totalAssets,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          cs.onSurface.withValues(alpha: 0.7),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              fmt(totalAssets),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: isDark ? const Color(0xFF81C784) : const Color(0xFF2E7D32),
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
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: cs.errorContainer.withValues(alpha: isDark ? 0.25 : 0.35),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: cs.error.withValues(alpha: isDark ? 0.35 : 0.25),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.arrow_downward_rounded,
                                    size: 14, color: cs.error),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    l10n.netWorth_totalLiabilities,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          cs.onSurface.withValues(alpha: 0.7),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              fmt(totalLiabilities),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: cs.error,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Net Worth Trend Chart Card ────────────────────────────
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
                      Text(
                        l10n.netWorth_trend,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      // Time range segmented filter chips
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: ['7D', '30D', '90D', '1Y', 'ALL'].map((r) {
                          final selected = _selectedRange == r;
                          return Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                AppHaptics.tap(context, HapticStrength.light);
                                setState(() => _selectedRange = r);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? cs.primary
                                      : cs.surfaceContainerHighest
                                          .withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  r,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: selected
                                        ? cs.onPrimary
                                        : cs.onSurface.withValues(alpha: 0.7),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (spots.length <= 1) ...[
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHighest.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline_rounded,
                              size: 18, color: cs.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              l10n.netWorth_noHistory,
                              style: TextStyle(
                                fontSize: 12,
                                color: cs.onSurface.withValues(alpha: 0.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  SizedBox(
                    height: 190,
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: spots.length > 2,
                            curveSmoothness: 0.25,
                            color: cs.primary,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: FlDotData(
                              show: spots.length < 15,
                              getDotPainter: (spot, pct, bar, index) =>
                                  FlDotCirclePainter(
                                radius: 3,
                                color: cs.surface,
                                strokeWidth: 2,
                                strokeColor: cs.primary,
                              ),
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [
                                  cs.primary.withValues(alpha: 0.22),
                                  cs.primary.withValues(alpha: 0.0),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ],
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: cs.outlineVariant.withValues(alpha: 0.25),
                            strokeWidth: 1,
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        titlesData: const FlTitlesData(show: false),
                        lineTouchData: LineTouchData(
                          enabled: true,
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipColor: (_) =>
                                cs.inverseSurface.withValues(alpha: 0.9),
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map((tSpot) {
                                final idx = tSpot.x.toInt();
                                if (idx >= 0 && idx < chartPoints.length) {
                                  final pt = chartPoints[idx];
                                  final dateStr = pt.date;
                                  return LineTooltipItem(
                                    '$dateStr\n${fmt(pt.value)}',
                                    TextStyle(
                                      color: cs.onInverseSurface,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  );
                                }
                                return null;
                              }).toList();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Quick Navigation Shortcuts ────────────────────────────
          Container(
            decoration: BoxDecoration(
              color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _QuickNavButton(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Accounts',
                    onTap: () => Navigator.push(
                      context,
                      ExpensyRoute(builder: (_) => const AccountsScreen()),
                    ),
                  ),
                  _QuickNavButton(
                    icon: Icons.inventory_2_outlined,
                    label: 'Assets',
                    onTap: () => Navigator.push(
                      context,
                      ExpensyRoute(builder: (_) => const AssetsScreen()),
                    ),
                  ),
                  _QuickNavButton(
                    icon: Icons.account_balance_outlined,
                    label: 'Loans',
                    onTap: () => Navigator.push(
                      context,
                      ExpensyRoute(builder: (_) => const LoansScreen()),
                    ),
                  ),
                  _QuickNavButton(
                    icon: Icons.handshake_outlined,
                    label: 'Lent/Debts',
                    onTap: () => Navigator.push(
                      context,
                      ExpensyRoute(builder: (_) => const LendedScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Assets Breakdown Card ─────────────────────────────────
          _SectionBreakdownCard(
            title: l10n.netWorth_assetBreakdown,
            totalFormatted: fmt(totalAssets),
            isAsset: true,
            items: [
              _BreakdownItem(
                icon: Icons.account_balance_wallet_outlined,
                color: const Color(0xFF00897B),
                label: l10n.netWorth_liquidCash,
                amountFormatted: fmt(app.totalLiquidAccountsValue),
                percentage: totalAssets > 0
                    ? app.totalLiquidAccountsValue / totalAssets
                    : 0,
                onTap: () => Navigator.push(
                  context,
                  ExpensyRoute(builder: (_) => const AccountsScreen()),
                ),
              ),
              if (app.totalGoldValue > 0)
                _BreakdownItem(
                  icon: Icons.diamond_outlined,
                  color: const Color(0xFFB8860B),
                  label: l10n.netWorth_goldValuation,
                  amountFormatted: fmt(app.totalGoldValue),
                  percentage: totalAssets > 0
                      ? app.totalGoldValue / totalAssets
                      : 0,
                  onTap: () => Navigator.push(
                    context,
                    ExpensyRoute(builder: (_) => const AccountsScreen()),
                  ),
                ),
              _BreakdownItem(
                icon: Icons.inventory_2_outlined,
                color: const Color(0xFF1565C0),
                label: l10n.netWorth_fixedAssets,
                amountFormatted: fmt(app.totalAssetsValue),
                percentage: totalAssets > 0
                    ? app.totalAssetsValue / totalAssets
                    : 0,
                onTap: () => Navigator.push(
                  context,
                  ExpensyRoute(builder: (_) => const AssetsScreen()),
                ),
              ),
              if (app.totalLentMoneyValue > 0)
                _BreakdownItem(
                  icon: Icons.handshake_outlined,
                  color: const Color(0xFF6750A4),
                  label: l10n.netWorth_moneyLent,
                  amountFormatted: fmt(app.totalLentMoneyValue),
                  percentage: totalAssets > 0
                      ? app.totalLentMoneyValue / totalAssets
                      : 0,
                  onTap: () => Navigator.push(
                    context,
                    ExpensyRoute(builder: (_) => const LendedScreen()),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Liabilities Breakdown Card ────────────────────────────
          _SectionBreakdownCard(
            title: l10n.netWorth_liabilityBreakdown,
            totalFormatted: fmt(totalLiabilities),
            isAsset: false,
            items: totalLiabilities <= 0
                ? []
                : [
                    if (app.totalDebtAccounts > 0)
                      _BreakdownItem(
                        icon: Icons.credit_card_outlined,
                        color: const Color(0xFFE65100),
                        label: l10n.netWorth_creditDebt,
                        amountFormatted: fmt(app.totalDebtAccounts),
                        percentage: totalLiabilities > 0
                            ? app.totalDebtAccounts / totalLiabilities
                            : 0,
                        onTap: () => Navigator.push(
                          context,
                          ExpensyRoute(builder: (_) => const AccountsScreen()),
                        ),
                      ),
                    if (app.totalOutstandingLoanDebt > 0)
                      _BreakdownItem(
                        icon: Icons.account_balance_outlined,
                        color: const Color(0xFF7B1FA2),
                        label: l10n.netWorth_loanDebt,
                        amountFormatted: fmt(app.totalOutstandingLoanDebt),
                        percentage: totalLiabilities > 0
                            ? app.totalOutstandingLoanDebt / totalLiabilities
                            : 0,
                        onTap: () => Navigator.push(
                          context,
                          ExpensyRoute(builder: (_) => const LoansScreen()),
                        ),
                      ),
                    if (app.totalBorrowedMoneyValue > 0)
                      _BreakdownItem(
                        icon: Icons.money_off_outlined,
                        color: const Color(0xFFC62828),
                        label: l10n.netWorth_moneyBorrowed,
                        amountFormatted: fmt(app.totalBorrowedMoneyValue),
                        percentage: totalLiabilities > 0
                            ? app.totalBorrowedMoneyValue / totalLiabilities
                            : 0,
                        onTap: () => Navigator.push(
                          context,
                          ExpensyRoute(builder: (_) => const LendedScreen()),
                        ),
                      ),
                  ],
          ),
          const SizedBox(height: 16),

          // ── Snapshot History ──────────────────────────────────────
          if (snapshots.isNotEmpty) ...[
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
                        Text(
                          l10n.netWorth_history,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (snapshots.length > 5)
                          TextButton(
                            onPressed: () {
                              AppHaptics.tap(context, HapticStrength.light);
                              setState(() => _showAllHistory = !_showAllHistory);
                            },
                            child: Text(
                              _showAllHistory ? 'Show Less' : 'Show All (${snapshots.length})',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ..._buildHistoryList(
                      snapshots.reversed.toList(),
                      _showAllHistory ? snapshots.length : 5,
                      fmt,
                      cs,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildHistoryList(
    List<NetWorthSnapshot> list,
    int count,
    String Function(double) fmt,
    ColorScheme cs,
  ) {
    final display = list.take(count).toList();
    final items = <Widget>[];

    for (int i = 0; i < display.length; i++) {
      final snap = display[i];
      final parsedDate = DateTime.tryParse(snap.date);
      final dateText = parsedDate != null
          ? DateFormat('EEE, d MMM yyyy').format(parsedDate)
          : snap.date;

      double? delta;
      if (i + 1 < display.length) {
        delta = snap.netWorth - display[i + 1].netWorth;
      }

      items.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dateText,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Assets: ${fmt(snap.totalAssets)} · Accounts: ${fmt(snap.totalAccounts)}',
                    style: TextStyle(
                      fontSize: 10,
                      color: cs.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    fmt(snap.netWorth),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: snap.netWorth >= 0 ? cs.primary : cs.error,
                    ),
                  ),
                  if (delta != null && delta.abs() > 0.01)
                    Text(
                      '${delta >= 0 ? '+' : ''}${fmt(delta)}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: delta >= 0 ? Colors.green : cs.error,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      );

      if (i < display.length - 1) {
        items.add(Divider(
          height: 1,
          color: cs.outlineVariant.withValues(alpha: 0.2),
        ));
      }
    }

    return items;
  }
}

class _ChartDataPoint {
  final String date;
  final double value;
  const _ChartDataPoint({required this.date, required this.value});
}

class _QuickNavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickNavButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        AppHaptics.tap(context, HapticStrength.light);
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: cs.primary),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: cs.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BreakdownItem {
  final IconData icon;
  final Color color;
  final String label;
  final String amountFormatted;
  final double percentage;
  final VoidCallback onTap;

  const _BreakdownItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.amountFormatted,
    required this.percentage,
    required this.onTap,
  });
}

class _SectionBreakdownCard extends StatelessWidget {
  final String title;
  final String totalFormatted;
  final bool isAsset;
  final List<_BreakdownItem> items;

  const _SectionBreakdownCard({
    required this.title,
    required this.totalFormatted,
    required this.isAsset,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isAsset
        ? (isDark ? const Color(0xFF81C784) : const Color(0xFF2E7D32))
        : cs.error;

    return Container(
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
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  totalFormatted,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (items.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle_outline_rounded,
                          size: 18, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(
                        'Zero liabilities recorded! Outstanding debt is \$0.00.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: cs.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else ...[
              // Proportional distribution bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: SizedBox(
                  height: 6,
                  child: Row(
                    children: items.map((it) {
                      final flex = (it.percentage * 1000).toInt();
                      if (flex <= 0) return const SizedBox();
                      return Expanded(
                        flex: flex,
                        child: Container(color: it.color),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              ...items.map((it) {
                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    AppHaptics.tap(context, HapticStrength.light);
                    it.onTap();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: it.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(it.icon, size: 18, color: it.color),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            it.label,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              it.amountFormatted,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              '${(it.percentage * 100).toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: cs.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.chevron_right_rounded,
                            size: 18,
                            color: cs.onSurface.withValues(alpha: 0.4)),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}
