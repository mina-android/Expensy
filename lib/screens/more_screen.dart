// lib/screens/more_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../utils/haptics.dart';
import '../widgets/fintech_components.dart';
import 'statistics_screen.dart';
import 'insights_screen.dart';
import 'net_worth_screen.dart';
import 'yearly_analysis_screen.dart';
import 'financial_calendar_screen.dart';
import 'wrapped_screen.dart';

import 'currency_converter_screen.dart';
import 'wishlist_screen.dart';
import 'lended_screen.dart';
import 'assets_screen.dart';
import 'categories_screen.dart';
import 'loans_screen.dart';
import 'export_screen.dart';
import 'backup_screen.dart';
import 'settings_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = context.watch<AppProvider>();

    final tabTeal = isDark ? const Color(0xFF4DB6AC) : const Color(0xFF00897B);

    final wishlistLen = app.wishlist.where((w) => !w.isPurchased).length;
    final lendedLen = app.lended.where((l) => !l.isSettled).length;
    final assetsLen = app.assets.length;
    final categoriesLen = app.categories.length;
    final loansLen = app.loans.where((l) => !l.isSettled).length;

    final sections = [
      // ── Section 1: Financial Tools ─────────────────────────────────────────
      _Section(
        title: l10n.more_sectionTools,
        items: [
          _Item(
            icon: Icons.currency_exchange_rounded,
            label: l10n.more_currencyConverter,
            sub: l10n.more_currencyConverterSub,
            color: const Color(0xFF6750A4),
            screen: const CurrencyConverterScreen(),
          ),
          _Item(
            icon: Icons.star_outline_rounded,
            label: l10n.more_wishlist,
            sub: l10n.more_wishlistSub(wishlistLen),
            color: const Color(0xFF7D5260),
            screen: const WishlistScreen(),
          ),
          _Item(
            icon: Icons.handshake_outlined,
            label: l10n.more_lentMoney,
            sub: l10n.more_lentMoneySub(lendedLen),
            color: const Color(0xFFE65140),
            screen: const LendedScreen(),
          ),
          _Item(
            icon: Icons.inventory_2_outlined,
            label: l10n.more_assets,
            sub: l10n.more_assetsSub(assetsLen),
            color: const Color(0xFF1565C0),
            screen: const AssetsScreen(),
          ),
          _Item(
            icon: Icons.account_balance_outlined,
            label: l10n.more_loans,
            sub: l10n.more_loansSub(loansLen),
            color: const Color(0xFF4A148C),
            screen: const LoansScreen(),
          ),
        ],
      ),

      // ── Section 2: Analytics & Insights ────────────────────────────────────
      _Section(
        title: l10n.more_sectionAnalytics,
        items: [
          _Item(
            icon: Icons.account_balance_rounded,
            label: l10n.netWorth_title,
            sub: l10n.netWorth_subtitle,
            color: const Color(0xFF00897B),
            screen: const NetWorthScreen(),
          ),
          _Item(
            icon: Icons.bar_chart_outlined,
            label: l10n.more_statistics,
            sub: l10n.more_statisticsSub,
            color: const Color(0xFF1565C0),
            screen: const StatisticsScreen(),
          ),
          _Item(
            icon: Icons.insights_outlined,
            label: l10n.more_insights,
            sub: l10n.more_insightsSub,
            color: const Color(0xFF00838F),
            screen: const InsightsScreen(),
          ),
          _Item(
            icon: Icons.calendar_month_outlined,
            label: l10n.more_yearlyAnalysis,
            sub: l10n.more_yearlyAnalysisSub,
            color: const Color(0xFF2E7D32),
            screen: const YearlyAnalysisScreen(),
          ),
          _Item(
            icon: Icons.calendar_today_rounded,
            label: l10n.calendar_title,
            sub: l10n.calendar_subtitle,
            color: const Color(0xFFE65100),
            screen: const FinancialCalendarScreen(),
          ),
          _Item(
            icon: Icons.auto_awesome_rounded,
            label: l10n.wrapped_title,
            sub: l10n.wrapped_bannerSub,
            color: const Color(0xFF8E24AA),
            screen: const WrappedScreen(),
          ),
        ],
      ),

      // ── Section 3: Preferences & Data ──────────────────────────────────────
      _Section(
        title: l10n.more_sectionPreferences,
        items: [
          _Item(
            icon: Icons.label_outline_rounded,
            label: l10n.more_categories,
            sub: l10n.more_categoriesSub(categoriesLen),
            color: const Color(0xFF00897B),
            screen: const CategoriesScreen(),
          ),
          _Item(
            icon: Icons.save_alt_outlined,
            label: l10n.more_exportTransactions,
            sub: l10n.more_exportTransactionsSub,
            color: const Color(0xFF00838F),
            screen: const ExportScreen(),
          ),
          _Item(
            icon: Icons.backup_outlined,
            label: l10n.more_backupRestore,
            sub: l10n.more_backupRestoreSub,
            color: const Color(0xFF37474F),
            screen: const BackupScreen(),
          ),
        ],
      ),
    ];

    final totalTools = sections.fold<int>(0, (sum, s) => sum + s.items.length);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            FintechHeader(
              title: l10n.more_more,
              subtitle: '$totalTools financial tools & preferences',
              padding: const EdgeInsets.only(
                top: 8,
                left: 20,
                right: 16,
                bottom: 8,
              ),
              actions: [
                FintechCircleButton(
                  icon: Icons.settings_outlined,
                  tooltip: l10n.more_settings,
                  onTap: () {
                    AppHaptics.tap(context, HapticStrength.light);
                    Navigator.push(context, ExpensyRoute(builder: (_) => const SettingsScreen()));
                  },
                ),
              ],
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: _buildNetWorthHero(context, app, tabTeal, isDark),
                    ),
                  ),
                  for (final section in sections) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 16, 10),
                        child: Text(
                          section.title.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: tabTeal,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.36,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => _buildCard(context, section.items[index], isDark),
                          childCount: section.items.length,
                        ),
                      ),
                    ),
                  ],
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 140),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetWorthHero(BuildContext context, AppProvider app, Color tabTeal, bool isDark) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final netWorth = app.liveNetWorth;
    final cur = app.settings.currency;
    final assets = app.totalWealthAssets;
    final liabilities = app.totalWealthLiabilities;

    return FintechHeroCard(
      accentColor: tabTeal,
      onTap: () {
        AppHaptics.tap(context, HapticStrength.light);
        Navigator.push(context, ExpensyRoute(builder: (_) => const NetWorthScreen()));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: tabTeal.withValues(alpha: isDark ? 0.25 : 0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: tabTeal.withValues(alpha: isDark ? 0.4 : 0.25),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.account_balance_rounded, size: 12, color: tabTeal),
                    const SizedBox(width: 5),
                    Text(
                      'TOTAL WEALTH',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                        color: tabTeal,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.netWorth_title,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: tabTeal,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Icon(Icons.chevron_right_rounded, size: 16, color: tabTeal),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            formatAmount(netWorth, cur),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
          ),
          const SizedBox(height: 3),
          Text(
            'Live aggregated net worth across all holdings',
            style: TextStyle(fontSize: 11.5, color: cs.onSurface.withValues(alpha: 0.55)),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2E7D32),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Assets: ${formatAmount(assets, cur)}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: cs.onSurface.withValues(alpha: 0.8),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 12,
                  width: 1,
                  color: cs.outlineVariant.withValues(alpha: 0.4),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: cs.error,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Liabilities: ${formatAmount(liabilities, cur)}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: cs.onSurface.withValues(alpha: 0.8),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
    );
  }

  Widget _buildCard(BuildContext context, _Item item, bool isDark) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            AppHaptics.tap(context, HapticStrength.selection);
            Navigator.push(context, ExpensyRoute(builder: (_) => item.screen));
          },
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: item.color.withValues(alpha: isDark ? 0.2 : 0.12),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(item.icon, color: item.color, size: 20),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                      color: cs.onSurface.withValues(alpha: 0.3),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.sub,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: cs.onSurface.withValues(alpha: 0.55),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Section {
  final String title;
  final List<_Item> items;
  const _Section({required this.title, required this.items});
}

class _Item {
  final IconData icon;
  final String label, sub;
  final Color color;
  final Widget screen;
  const _Item({
    required this.icon,
    required this.label,
    required this.sub,
    required this.color,
    required this.screen,
  });
}
