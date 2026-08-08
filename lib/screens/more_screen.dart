// lib/screens/more_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import 'statistics_screen.dart';
import 'insights_screen.dart';

import 'currency_converter_screen.dart';
import 'wishlist_screen.dart';
import 'lended_screen.dart';
import 'assets_screen.dart';
import 'categories_screen.dart';
import 'export_screen.dart';
import 'backup_screen.dart';
import 'settings_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    final wishlistLen = context.select<AppProvider, int>((a) => a.wishlist.where((w) => !w.isPurchased).length);
    final lendedLen = context.select<AppProvider, int>((a) => a.lended.where((l) => !l.isSettled).length);
    final assetsLen = context.select<AppProvider, int>((a) => a.assets.length);
    final categoriesLen = context.select<AppProvider, int>((a) => a.categories.length);

    final items = [
      _Item(
          icon: Icons.bar_chart_outlined,
          label: l10n.more_statistics,
          sub: l10n.more_statisticsSub,
          color: const Color(0xFF1565C0),
          screen: const StatisticsScreen()),
      _Item(
          icon: Icons.insights_outlined,
          label: l10n.more_insights,
          sub: l10n.more_insightsSub,
          color: const Color(0xFF00838F),
          screen: const InsightsScreen()),
      _Item(
          icon: Icons.currency_exchange_rounded,
          label: l10n.more_currencyConverter,
          sub: l10n.more_currencyConverterSub,
          color: const Color(0xFF6750A4),
          screen: const CurrencyConverterScreen()),
      _Item(
          icon: Icons.star_outline_rounded,
          label: l10n.more_wishlist,
          sub: l10n.more_wishlistSub(wishlistLen),
          color: const Color(0xFF7D5260),
          screen: const WishlistScreen()),
      _Item(
          icon: Icons.handshake_outlined,
          label: l10n.more_lentMoney,
          sub: l10n.more_lentMoneySub(lendedLen),
          color: const Color(0xFFE65100),
          screen: const LendedScreen()),
      _Item(
          icon: Icons.inventory_2_outlined,
          label: l10n.more_assets,
          sub: l10n.more_assetsSub(assetsLen),
          color: const Color(0xFF1565C0),
          screen: const AssetsScreen()),
      _Item(
          icon: Icons.label_outline_rounded,
          label: l10n.more_categories,
          sub: l10n.more_categoriesSub(categoriesLen),
          color: const Color(0xFF00897B),
          screen: const CategoriesScreen()),
      _Item(
          icon: Icons.save_alt_outlined,
          label: l10n.more_exportTransactions,
          sub: l10n.more_exportTransactionsSub,
          color: const Color(0xFF00838F),
          screen: const ExportScreen()),
      _Item(
          icon: Icons.backup_outlined,
          label: l10n.more_backupRestore,
          sub: l10n.more_backupRestoreSub,
          color: const Color(0xFF37474F),
          screen: const BackupScreen()),
      _Item(
          icon: Icons.settings_outlined,
          label: l10n.more_settings,
          sub: l10n.more_settingsSub,
          color: const Color(0xFF4A148C),
          screen: const SettingsScreen()),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(l10n.more_more,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(14),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, i) {
          final item = items[i];
          return Card(
              child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12)),
              child: Icon(item.icon, color: item.color, size: 22),
            ),
            title: Text(item.label,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            subtitle: Text(item.sub,
                style: TextStyle(
                    fontSize: 12, color: cs.onSurface.withValues(alpha: 0.55))),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => Navigator.push(
                context, ExpensyRoute(builder: (_) => item.screen)),
          ));
        },
      ),
    );
  }
}

class _Item {
  final IconData icon;
  final String label, sub;
  final Color color;
  final Widget screen;
  const _Item(
      {required this.icon,
      required this.label,
      required this.sub,
      required this.color,
      required this.screen});
}
