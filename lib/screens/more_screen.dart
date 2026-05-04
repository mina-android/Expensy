// lib/screens/more_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'recurring_screen.dart';
import 'wishlist_screen.dart';
import 'lended_screen.dart';
import 'categories_screen.dart';
import 'settings_screen.dart';
import 'export_screen.dart';
import 'backup_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;

    final activeWish     = app.wishlist.where((w) => !w.isPurchased).length;
    final activeRec      = app.recurring.length;
    final activeLend     = app.lended.where((l) => !l.isSettled).length;

    final items = [
      _MoreItem(
        icon: Icons.repeat_rounded,
        label: 'Recurring Payments',
        sub: '$activeRec active',
        color: const Color(0xFF6750A4),
        onTap: () => _push(context, const RecurringScreen()),
      ),
      _MoreItem(
        icon: Icons.star_outline_rounded,
        label: 'Wishlist',
        sub: '$activeWish items',
        color: const Color(0xFF7D5260),
        onTap: () => _push(context, const WishlistScreen()),
      ),
      _MoreItem(
        icon: Icons.handshake_outlined,
        label: 'Lent Money',
        sub: '$activeLend outstanding',
        color: const Color(0xFFE65100),
        onTap: () => _push(context, const LendedScreen()),
      ),
      _MoreItem(
        icon: Icons.label_outline_rounded,
        label: 'Categories',
        sub: '${app.categories.length} categories',
        color: const Color(0xFF00897B),
        onTap: () => _push(context, const CategoriesScreen()),
      ),
      _MoreItem(
        icon: Icons.file_download_outlined,
        label: 'Export Transactions',
        sub: 'Download as CSV',
        color: const Color(0xFF1565C0),
        onTap: () => _push(context, const ExportScreen()),
      ),
      _MoreItem(
        icon: Icons.backup_outlined,
        label: 'Backup & Restore',
        sub: 'Save or load your data',
        color: const Color(0xFF37474F),
        onTap: () => _push(context, const BackupScreen()),
      ),
      _MoreItem(
        icon: Icons.settings_outlined,
        label: 'Settings',
        sub: 'Theme, currency & notifications',
        color: const Color(0xFF4A148C),
        onTap: () => _push(context, const SettingsScreen()),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('More', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, i) {
          final item = items[i];
          return Card(
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              leading: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(item.icon, color: item.color, size: 22),
              ),
              title: Text(item.label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 15)),
              subtitle: Text(item.sub,
                  style: TextStyle(
                      fontSize: 12,
                      color: cs.onSurface.withValues(alpha: 0.55))),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: item.onTap,
            ),
          );
        },
      ),
    );
  }

  void _push(BuildContext ctx, Widget screen) =>
      Navigator.push(ctx, MaterialPageRoute(builder: (_) => screen));
}

class _MoreItem {
  final IconData icon;
  final String label, sub;
  final Color color;
  final VoidCallback onTap;
  const _MoreItem(
      {required this.icon, required this.label, required this.sub,
       required this.color, required this.onTap});
}
