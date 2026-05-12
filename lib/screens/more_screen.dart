// lib/screens/more_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'statistics_screen.dart';
import 'wishlist_screen.dart';
import 'lended_screen.dart';
import 'categories_screen.dart';
import 'export_screen.dart';
import 'backup_screen.dart';
import 'settings_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;

    final items = [
      const _Item(icon: Icons.bar_chart_outlined, label: 'Statistics',
          sub: 'Charts & monthly summary', color: Color(0xFF1565C0),
          screen: StatisticsScreen()),
      _Item(icon: Icons.star_outline_rounded, label: 'Wishlist',
          sub: '${app.wishlist.where((w) => !w.isPurchased).length} items',
          color: const Color(0xFF7D5260), screen: const WishlistScreen()),
      _Item(icon: Icons.handshake_outlined, label: 'Lent Money',
          sub: '${app.lended.where((l) => !l.isSettled).length} outstanding',
          color: const Color(0xFFE65100), screen: const LendedScreen()),
      _Item(icon: Icons.label_outline_rounded, label: 'Categories',
          sub: '${app.categories.length} categories',
          color: const Color(0xFF00897B), screen: const CategoriesScreen()),
      const _Item(icon: Icons.save_alt_outlined, label: 'Export Transactions',
          sub: 'Save as Excel (.xlsx)',
          color: Color(0xFF00838F), screen: ExportScreen()),
      const _Item(icon: Icons.backup_outlined, label: 'Backup & Restore',
          sub: 'Save or load your data',
          color: Color(0xFF37474F), screen: BackupScreen()),
      const _Item(icon: Icons.settings_outlined, label: 'Settings',
          sub: 'Theme, currency & preferences',
          color: Color(0xFF4A148C), screen: SettingsScreen()),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('More', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(14),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, i) {
          final item = items[i];
          return Card(child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            leading: Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12)),
              child: Icon(item.icon, color: item.color, size: 22),
            ),
            title: Text(item.label,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            subtitle: Text(item.sub,
                style: TextStyle(fontSize: 12,
                    color: cs.onSurface.withValues(alpha: 0.55))),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => item.screen)),
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
  const _Item({required this.icon, required this.label, required this.sub,
      required this.color, required this.screen});
}
