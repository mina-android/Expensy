// note: Primary dashboard screen displaying net balance hero card, period cashflow summary, quick presets, and recent transactions.
// All state mutations and queries route through AppProvider to preserve UI-DB decoupling.
// Follows Material 3 and AMOLED surface conventions via popupSurfaceColor(cs) and semantic constants.
// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../utils/snackbar.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../providers/aggregations.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/fintech_components.dart';
import 'add_transaction_screen.dart';
import 'currency_converter_screen.dart';
import 'lended_screen.dart';
import 'yearly_analysis_screen.dart';
import 'financial_calendar_screen.dart';
import '../utils/haptics.dart';
import '../utils/nav_metrics.dart';
import 'accounts_screen.dart';
import '../widgets/presets_carousel.dart';
import '../widgets/split_transaction_sheet.dart';

// ── class HomeScreen ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for HomeScreen.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// ── class _HomeScreenState ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for _HomeScreenState.
class _HomeScreenState extends State<HomeScreen> {
  List<AppTransaction>? _prevTransactions;
  Map<String, double>? _prevRates;
  List<TransactionSplit>? _prevSplits;
  String? _prevCurrency;
  int _prevTxCount = -1;
  String? _prevFirstTxId;
  double _income = 0;
  double _expense = 0;
  List<AppTransaction> _recent = [];

  // Helper method `_computeTransactions`: handles user action or computes derived UI state.
  void _computeTransactions(AppProvider app) {
    if (identical(_prevTransactions, app.transactions) &&
        identical(_prevRates, app.exchangeRates) &&
        identical(_prevSplits, app.splits) &&
        _prevCurrency == app.settings.currency &&
        _prevTxCount == app.transactions.length &&
        _prevFirstTxId == app.transactions.firstOrNull?.id) {
      return;
    }
    _prevTransactions = app.transactions;
    _prevRates = app.exchangeRates;
    _prevSplits = app.splits;
    _prevCurrency = app.settings.currency;
    _prevTxCount = app.transactions.length;
    _prevFirstTxId = app.transactions.firstOrNull?.id;
    final txs = app.transactions;
    final now = DateTime.now();
    final mStart = DateTime(now.year, now.month, 1);

    final totals = FinancialAggregations.periodTotals(
      txs,
      start: mStart,
      end: DateTime(now.year, now.month + 1, 1),
      resolveCurrency: app.txCurrency,
      convert: app.convertToMain,
    );
    _income = totals.income;
    _expense = totals.expense;

    _recent = txs.take(5).toList();
  }

  // Helper method `_greetingText`: handles user action or computes derived UI state.
  String _greetingText(String userName, AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    final String greeting;
    if (hour >= 5 && hour < 12) {
      greeting = l10n.home_goodMorning;
    } else if (hour >= 12 && hour < 17) {
      greeting = l10n.home_goodAfternoon;
    } else {
      greeting = l10n.home_goodEvening;
    }

    final trimmed = userName.trim();
    if (trimmed.isNotEmpty) {
      return '$greeting, $trimmed';
    }
    return greeting;
  }

  @override
  // Builds the widget subtree using theme-adaptive colors and localization.
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final hideBalance = app.settings.hideBalance;
    final currency = app.settings.currency;
    final userName = app.settings.userName;
    final totalBalance = app.totalBalance;
    final homeAccounts = app.accounts.where((a) => !a.isCard).toList();
    final homeCards = app.accounts.where((a) => a.isCard).toList();

    // Helper method `fmt`: handles user action or computes derived UI state.
    String fmt(double v) => formatAmount(v, currency);

    _computeTransactions(app);

    final now = DateTime.now();
    final daysInMonth = now.day;
    final dailyAvg = daysInMonth > 0 ? _expense / daysInMonth : 0.0;
    final overallPacing = app.overallMonthlyBudgetPacing(now);
    final net = _income - _expense;
    final savingsRate = _income > 0 ? (net / _income).clamp(0.0, 1.0) : 0.0;

    final tabBlue = isDark ? const Color(0xFF64B5F6) : const Color(0xFF1972E8);

    // Render Scaffold layout container.
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Static Top App Bar / Greeting ──────────────────────────
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: 20,
                right: 16,
                bottom: 8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _greetingText(userName, l10n),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 21,
                                letterSpacing: -0.4,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          DateFormat.MMMMEEEEd(
                                  Localizations.localeOf(context).toString())
                              .format(now),
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: cs.onSurface.withValues(alpha: 0.55),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Eye Hide-Balance Action Button
                  Material(
                    color: cs.surfaceContainerHighest.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        AppHaptics.tap(context, HapticStrength.light);
                        app.updateSetting('hideBalance', !hideBalance);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          hideBalance
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20,
                          color: cs.onSurface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Static Elevated Hero Balance Card ──────────────────────
            FintechHeroCard(
              margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 18),
              accentColor: tabBlue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 15,
                            color: cs.onSurface.withValues(alpha: 0.7),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            l10n.home_totalBalance,
                            style: TextStyle(
                              color: cs.onSurface.withValues(alpha: 0.7),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest.withValues(alpha: isDark ? 0.4 : 0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          currency,
                          style: TextStyle(
                            color: cs.onSurface,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    hideBalance ? '• • • • • •' : fmt(totalBalance),
                    style: TextStyle(
                      color: cs.onSurface,
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.6,
                    ),
                  ),
                ],
              ),
            ),

            // ── Scrollable Rest of Home Screen ─────────────────────────
            Expanded(
              child: CustomScrollView(
                slivers: [

          // ── Quick Actions Row ───────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _QuickActionButton(
                    icon: Icons.currency_exchange_rounded,
                    label: l10n.home_converterAction,
                    onTap: () => Navigator.push(
                      context,
                      ExpensyRoute(
                          builder: (_) => const CurrencyConverterScreen()),
                    ),
                  ),
                  _QuickActionButton(
                    icon: Icons.handshake_outlined,
                    label: l10n.more_lentMoney,
                    onTap: () => Navigator.push(
                      context,
                      ExpensyRoute(builder: (_) => const LendedScreen()),
                    ),
                  ),
                  _QuickActionButton(
                    icon: Icons.calendar_month_rounded,
                    label: l10n.home_calendarAction,
                    onTap: () => Navigator.push(
                      context,
                      ExpensyRoute(
                          builder: (_) => const FinancialCalendarScreen()),
                    ),
                  ),
                  _QuickActionButton(
                    icon: Icons.auto_graph_rounded,
                    label: l10n.home_forecastAction,
                    onTap: () => Navigator.push(
                      context,
                      ExpensyRoute(
                          builder: (_) => const YearlyAnalysisScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Unified Monthly Cash Flow Card ──────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: cs.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: cs.outlineVariant.withValues(alpha: 0.35),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.pie_chart_outline_rounded,
                                size: 16, color: cs.primary),
                            const SizedBox(width: 6),
                            Text(
                              l10n.home_monthlyOverview,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: (net >= 0
                                    ? kSuccessColor
                                    : kDangerColor)
                                .withValues(alpha: isDark ? 0.2 : 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${net >= 0 ? '+' : ''}${fmt(net)}',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800,
                              color: net >= 0 ? kSuccessColor : kDangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        // Inflow
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: kSuccessColor
                                      .withValues(alpha: isDark ? 0.25 : 0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_downward_rounded,
                                  size: 18,
                                  color: kSuccessColor,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.home_income,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: cs.onSurface
                                            .withValues(alpha: 0.55),
                                      ),
                                    ),
                                    Text(
                                      fmt(_income),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 32,
                          color: cs.outlineVariant.withValues(alpha: 0.35),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        // Outflow
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: kDangerColor
                                      .withValues(alpha: isDark ? 0.25 : 0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_upward_rounded,
                                  size: 18,
                                  color: kDangerColor,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.home_expenses,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: cs.onSurface
                                            .withValues(alpha: 0.55),
                                      ),
                                    ),
                                    Text(
                                      fmt(_expense),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (_income > 0) ...[
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: (_expense / _income).clamp(0.0, 1.0),
                          minHeight: 5,
                          backgroundColor: kSuccessColor
                              .withValues(alpha: isDark ? 0.3 : 0.15),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              kDangerColor),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${l10n.home_savingsRate}: ${(savingsRate * 100).toStringAsFixed(0)}%',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: cs.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                          Text(
                            DateFormat.MMMM().format(now),
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: cs.onSurface.withValues(alpha: 0.4),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // ── Smart "Safe-to-Spend" Daily Budget Pacer ────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: InkWell(
                onTap: () {
                  AppHaptics.tap(context, HapticStrength.light);
                  app.tabIndexNotifier.value = 4; // Budgets & Goals tab
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 11, horizontal: 14),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: overallPacing != null
                          ? (overallPacing.isOnTrack
                              ? kSuccessColor
                                  .withValues(alpha: 0.35)
                              : (overallPacing.isCaution
                                  ? kWarningColor.withValues(alpha: 0.4)
                                  : cs.error.withValues(alpha: 0.4)))
                          : cs.outlineVariant.withValues(alpha: 0.35),
                    ),
                  ),
                  child: overallPacing != null
                      ? _buildPacingCardRow(
                          context, overallPacing, cs, l10n, fmt)
                      : _buildDefaultDailyAvgRow(
                          context, dailyAvg, cs, l10n, fmt),
                ),
              ),
            ),
          ),

          // ── Accounts Section (Realistic Cards) ───────────────────────
          if (homeAccounts.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.home_accounts,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        AppHaptics.tap(context, HapticStrength.light);
                        app.accountsTabNotifier.value = 0; // Accounts tab
                        app.tabIndexNotifier.value = 3;
                      },
                      child: Text(
                        '${l10n.home_manage} →',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: cs.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 116,
                child: ReorderableListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  proxyDecorator: (child, index, animation) {
                    return Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(18),
                      child: child,
                    );
                  },
                  itemCount: homeAccounts.length + 1,
                  onReorderStart: (_) =>
                      AppHaptics.tap(context, HapticStrength.heavy),
                  onReorderItem: (oldIdx, newIdx) {
                    if (oldIdx < homeAccounts.length &&
                        newIdx <= homeAccounts.length) {
                      AppHaptics.tap(context, HapticStrength.light);
                      final oldAcc = homeAccounts[oldIdx];
                      final oldAppIdx = app.accounts.indexOf(oldAcc);
                      final targetAcc = newIdx < homeAccounts.length
                          ? homeAccounts[newIdx]
                          : null;
                      final newAppIdx = targetAcc != null
                          ? app.accounts.indexOf(targetAcc)
                          : app.accounts.length;
                      if (oldAppIdx != -1) {
                        app.reorderAccounts(oldAppIdx, newAppIdx);
                      }
                    }
                  },
                  itemBuilder: (_, i) {
                    if (i == homeAccounts.length) {
                      // Add Account Card
                      return GestureDetector(
                        key: const ValueKey('add_account_card'),
                        onTap: () {
                          AppHaptics.tap(context, HapticStrength.light);
                          AccountsScreen.openSheet(context, isCard: false);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 120,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: cs.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: cs.outlineVariant.withValues(alpha: 0.4),
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: cs.primary.withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add_rounded,
                                    color: cs.primary, size: 22),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                l10n.home_addAccount,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: cs.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final acc = homeAccounts[i];
                    final color = Color(acc.colorValue);

                    return GestureDetector(
                      key: ValueKey(acc.id),
                      onTap: () {
                        AppHaptics.tap(context, HapticStrength.light);
                        AccountsScreen.openSheet(
                          context,
                          existing: acc,
                          isCard: false,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 172,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color.withValues(alpha: 0.88),
                              color,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: color.withValues(alpha: 0.25),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Top row: Type chip & contactless / network icon
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    acc.type.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                Icon(
                                  acc.isGold
                                      ? Icons.workspace_premium_rounded
                                      : Icons.account_balance_rounded,
                                  size: 15,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ],
                            ),
                            // Middle: Account name
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  acc.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            // Bottom: Balance
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hideBalance
                                      ? '• • •'
                                      : (acc.type == 'bank'
                                          ? formatAmount(
                                              app.getBankTotalBalance(acc.id),
                                              acc.currency)
                                          : formatAmount(
                                              acc.balance, acc.currency)),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                if (!hideBalance &&
                                    acc.isGold &&
                                    acc.goldKarat != null &&
                                    acc.goldGrams != null)
                                  Text(
                                    '${acc.goldKarat}k · ${acc.goldGrams!.toStringAsFixed(2)} g',
                                    style: TextStyle(
                                      color: Colors.white
                                          .withValues(alpha: 0.75),
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                else if (!hideBalance &&
                                    app.canShowConverted(acc))
                                  Text(
                                    '≈ ${formatAmount(app.convertToMain(acc.type == 'bank' ? app.getBankTotalBalance(acc.id) : acc.balance, acc.currency), currency)}',
                                    style: TextStyle(
                                      color: Colors.white
                                          .withValues(alpha: 0.75),
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],

          // ── Cards Section (Mini Cards Carousel) ─────────────────────
          if (homeCards.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.home_cards,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        AppHaptics.tap(context, HapticStrength.light);
                        app.accountsTabNotifier.value = 1; // Cards tab
                        app.tabIndexNotifier.value = 3;
                      },
                      child: Text(
                        '${l10n.home_manage} →',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: cs.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 124,
                child: ReorderableListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  proxyDecorator: (child, index, animation) {
                    return Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(18),
                      child: child,
                    );
                  },
                  itemCount: homeCards.length + 1,
                  onReorderStart: (_) =>
                      AppHaptics.tap(context, HapticStrength.heavy),
                  onReorderItem: (oldIdx, newIdx) {
                    if (oldIdx < homeCards.length &&
                        newIdx <= homeCards.length) {
                      AppHaptics.tap(context, HapticStrength.light);
                      final oldAcc = homeCards[oldIdx];
                      final oldAppIdx = app.accounts.indexOf(oldAcc);
                      final targetAcc = newIdx < homeCards.length
                          ? homeCards[newIdx]
                          : null;
                      final newAppIdx = targetAcc != null
                          ? app.accounts.indexOf(targetAcc)
                          : app.accounts.length;
                      if (oldAppIdx != -1) {
                        app.reorderAccounts(oldAppIdx, newAppIdx);
                      }
                    }
                  },
                  itemBuilder: (_, i) {
                    if (i == homeCards.length) {
                      // Add Card item
                      return GestureDetector(
                        key: const ValueKey('add_card_carousel_item'),
                        onTap: () {
                          AppHaptics.tap(context, HapticStrength.light);
                          AccountsScreen.openSheet(context, isCard: true);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 120,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: cs.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: cs.outlineVariant.withValues(alpha: 0.4),
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: cs.primary.withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add_rounded,
                                    color: cs.primary, size: 22),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                l10n.home_addCard,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: cs.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final acc = homeCards[i];
                    final color = Color(acc.colorValue);

                    return GestureDetector(
                      key: ValueKey('card_${acc.id}'),
                      onTap: () {
                        AppHaptics.tap(context, HapticStrength.light);
                        AccountsScreen.openSheet(
                          context,
                          existing: acc,
                          isCard: true,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 172,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color.withValues(alpha: 0.88),
                              color,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: color.withValues(alpha: 0.25),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Top row: Type chip & contactless icon
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    acc.type.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.contactless_rounded,
                                  size: 15,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ],
                            ),
                            // Middle: Card name & Card number last 4
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  acc.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                if (acc.cardNumberLast4 != null &&
                                    acc.cardNumberLast4!.isNotEmpty)
                                  Text(
                                    '•••• ${acc.cardNumberLast4}',
                                    style: TextStyle(
                                      color: Colors.white
                                          .withValues(alpha: 0.7),
                                      fontSize: 10,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                            // Bottom: Balance
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hideBalance
                                      ? '• • •'
                                      : formatAmount(
                                          app.getEffectiveBalance(acc),
                                          acc.currency),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                if (acc.isCredit && (acc.creditLimit ?? 0) > 0)
                                  Text(
                                    hideBalance
                                        ? '${l10n.creditCard_availableCredit}: • • •'
                                        : '${l10n.creditCard_availableCredit}: ${formatAmount(app.getCreditCardStatement(acc).availableCredit, acc.currency)}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.8),
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                else if (!hideBalance &&
                                    app.canShowConverted(acc))
                                  Text(
                                    '≈ ${formatAmount(app.convertToMain(app.getEffectiveBalance(acc), acc.currency), currency)}',
                                    style: TextStyle(
                                      color: Colors.white
                                          .withValues(alpha: 0.75),
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],

          // ── Quick Log Presets Carousel ──────────────────────────────
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: PresetsCarousel(),
            ),
          ),

          // ── Contained Recent Transactions Section ───────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: cs.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: cs.outlineVariant.withValues(alpha: 0.35),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.home_recentTransactions,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15.5,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              AppHaptics.tap(context, HapticStrength.light);
                              app.tabIndexNotifier.value = 1; // Transactions tab
                            },
                            child: Text(
                              '${l10n.home_seeAll} →',
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: cs.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_recent.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: EmptyState(
                          icon: Icons.receipt_long_outlined,
                          message: l10n.home_noTransactionsYet,
                        ),
                      )
                    else
                      ...List.generate(_recent.length, (index) {
                        final t = _recent[index];
                        final isLast = index == _recent.length - 1;
                        final acc = app.accountById(t.paidViaAccountId ?? t.accountId);
                        final cat = app.categoryById(t.categoryId);
                        final isInc = t.type == 'income';
                        final isSplit = app.isTransactionSplit(t.id);
                        final splits = isSplit
                            ? app.getSplits(t.id)
                            : const <TransactionSplit>[];

                        // Render Column layout container.
                        return Column(
                          children: [
                            Material(
                              type: MaterialType.transparency,
                              child: Dismissible(
                              key: ValueKey(t.id),
                              direction: t.isInvestment
                                  ? DismissDirection.none
                                  : DismissDirection.startToEnd,
                              background: Container(
                                color: cs.error,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(left: 20),
                                child: const Icon(Icons.delete_outline,
                                    color: Colors.white),
                              ),
                              onDismissed: (_) async {
                                AppHaptics.tap(context, HapticStrength.medium);
                                final undo =
                                    await app.deleteTransactionWithUndo(t.id);
                                if (context.mounted) {
                                  showAppSnackbar(
                                    context,
                                    l10n.common_transactionDeleted,
                                    onUndo: undo,
                                  );
                                }
                              },
                              child: ListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 2),
                                onTap: () {
                                  AppHaptics.tap(context, HapticStrength.light);
                                  if (isSplit) {
                                    SplitTransactionSheet.show(
                                      context,
                                      transaction: t,
                                      splits: splits,
                                      app: app,
                                    );
                                  } else if (t.isTransfer) {
                                    showTransferTransactionDialog(context, t);
                                  } else if (t.isInvestment) {
                                    showCertificateTransactionDialog(context, t);
                                  } else {
                                    Navigator.push(
                                      context,
                                      ExpensySlideUpRoute(
                                        builder: (_) => AddTransactionScreen(
                                            existing: t),
                                      ),
                                    );
                                  }
                                },
                                leading: isSplit
                                    ? Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: cs.primaryContainer,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Icon(Icons.call_split_rounded,
                                            color: cs.onPrimaryContainer,
                                            size: 20),
                                      )
                                    : CategoryDot(category: cat, size: 40),
                                title: Text(
                                  t.description.isNotEmpty
                                      ? t.description
                                      : app.categoryDisplayName(
                                          t.categoryId,
                                          l10n: l10n,
                                        ),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.5,
                                  ),
                                ),
                                subtitle: isSplit
                                    ? Row(
                                        children: [
                                          Text(
                                            '${DateFormat('d MMM').format(t.date)} · ${acc?.name ?? ''}  ',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: cs.onSurface
                                                  .withValues(alpha: 0.5),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 1),
                                            decoration: BoxDecoration(
                                              color: cs.secondaryContainer
                                                  .withValues(alpha: 0.6),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              '${splits.length} ${l10n.split_transactions_title}',
                                              style: TextStyle(
                                                fontSize: 9.5,
                                                fontWeight: FontWeight.w700,
                                                color: cs.onSecondaryContainer,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        '${DateFormat('d MMM').format(t.date)} · ${acc?.name ?? ''}',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: cs.onSurface
                                              .withValues(alpha: 0.5),
                                        ),
                                      ),
                                trailing: Text(
                                  '${t.isTransfer ? '↔ ' : (isInc ? '+' : '-')}${formatAmount(t.amount, app.txCurrency(t))}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: t.isTransfer
                                        ? cs.primary
                                        : (isInc
                                            ? kSuccessColor
                                            : kDangerColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (!isLast)
                              Divider(
                                height: 1,
                                thickness: 0.6,
                                indent: 68,
                                endIndent: 16,
                                color: cs.outlineVariant.withValues(alpha: 0.25),
                              ),
                          ],
                        );
                      }),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 150),
          ),
        ],
      ),
    ),
  ],
),
),
      floatingActionButtonLocation: NavAwareFabLocation(
        bottomOffset: NavMetrics.fabBottomOffset(context),
      ),
      floatingActionButton: ExpandableFab(
        label: l10n.home_add,
        color: tabBlue,
        alignment: CrossAxisAlignment.end,
        onIncome: () => Navigator.push(
          context,
          ExpensySlideUpRoute(
            builder: (_) => const AddTransactionScreen(initialType: 'income'),
          ),
        ),
        onExpense: () => Navigator.push(
          context,
          ExpensySlideUpRoute(
            builder: (_) =>
                const AddTransactionScreen(initialType: 'expense'),
          ),
        ),
        onTransfer: () => Navigator.push(
          context,
          ExpensySlideUpRoute(
            builder: (_) =>
                const AddTransactionScreen(initialType: 'transfer'),
          ),
        ),
      ),
    );
  }

  // Helper method `_buildPacingCardRow`: handles user action or computes derived UI state.
  Widget _buildPacingCardRow(
    BuildContext context,
    BudgetPacingInfo pacing,
    ColorScheme cs,
    AppLocalizations l10n,
    // Helper method `Function`: handles user action or computes derived UI state.
    String Function(double) fmt,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final IconData icon;
    final Color iconColor;
    final String badgeLabel;
    final Color badgeBg;
    final Color badgeFg;
    final Color valueColor;

    switch (pacing.status) {
      case BudgetPacingStatus.onTrack:
        icon = Icons.speed_rounded;
        iconColor = kSuccessColor;
        badgeLabel = l10n.pacing_onTrack;
        badgeBg = kSuccessColor
            .withValues(alpha: isDark ? 0.25 : 0.12);
        badgeFg = kSuccessColor;
        valueColor = kSuccessColor;
        break;
      case BudgetPacingStatus.caution:
        icon = Icons.speed_rounded;
        iconColor = kWarningColor;
        badgeLabel = l10n.pacing_fast;
        badgeBg = kWarningColor.withValues(alpha: isDark ? 0.25 : 0.12);
        badgeFg = kWarningColor;
        valueColor = kWarningColor;
        break;
      case BudgetPacingStatus.overPaced:
        icon = Icons.warning_amber_rounded;
        iconColor = kDangerColor;
        badgeLabel = l10n.pacing_alert;
        badgeBg = kDangerColor
            .withValues(alpha: isDark ? 0.25 : 0.12);
        badgeFg = kDangerColor;
        valueColor = kDangerColor;
        break;
      case BudgetPacingStatus.exceeded:
        icon = Icons.error_outline_rounded;
        iconColor = cs.error;
        badgeLabel = l10n.budget_overLimit;
        badgeBg = cs.errorContainer.withValues(alpha: isDark ? 0.3 : 0.4);
        badgeFg = cs.error;
        valueColor = cs.error;
        break;
    }

    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.pacing_dailyBudget,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: cs.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
              decoration: BoxDecoration(
                color: badgeBg,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                badgeLabel,
                style: TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                  color: badgeFg,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.pacing_perDay(fmt(pacing.safeDailyAllowance)),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: valueColor,
              ),
            ),
            Text(
              l10n.pacing_daysLeft(pacing.daysRemaining.toString()),
              style: TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w500,
                color: cs.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Helper method `_buildDefaultDailyAvgRow`: handles user action or computes derived UI state.
  Widget _buildDefaultDailyAvgRow(
    BuildContext context,
    double dailyAvg,
    ColorScheme cs,
    AppLocalizations l10n,
    // Helper method `Function`: handles user action or computes derived UI state.
    String Function(double) fmt,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.local_fire_department_rounded,
                size: 16, color: kWarningColor),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.pacing_dailyAvgPace,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                Text(
                  l10n.pacing_setBudgetPrompt,
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    color: cs.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          l10n.pacing_perDay(fmt(dailyAvg)),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

// ── class _QuickActionButton ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for _QuickActionButton.
class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  // Builds the widget subtree using theme-adaptive colors and localization.
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        AppHaptics.tap(context, HapticStrength.light);
        onTap();
      },
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: cs.surfaceContainerHigh,
                shape: BoxShape.circle,
                border: Border.all(
                  color: cs.outlineVariant.withValues(alpha: 0.35),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(icon, color: cs.primary, size: 22),
            ),
            const SizedBox(height: 7),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: cs.onSurface.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
