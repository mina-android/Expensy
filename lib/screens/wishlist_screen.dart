// lib/screens/wishlist_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app      = context.watch<AppProvider>();
    final cs       = Theme.of(context).colorScheme;
    final currency = app.settings.currency;
    String fmt(double v) => formatAmount(v, currency);

    final active    = app.wishlist.where((w) => !w.isPurchased).toList();
    final purchased = app.wishlist.where((w) => w.isPurchased).toList();
    final totalCost = active.fold(0.0, (s, w) => s + w.price);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist',
            style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.tertiary,
        foregroundColor: cs.onTertiary,
        actions: [
          if (active.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Total',
                      style:
                          TextStyle(fontSize: 10, color: Colors.white70)),
                  Text(fmt(totalCost),
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontSize: 14)),
                ],
              ),
            ),
        ],
      ),
      body: app.wishlist.isEmpty
          ? const EmptyState(
              icon: Icons.star_outline_rounded,
              message: 'Your wishlist is empty',
              subMessage: 'Add items you want to save up for',
            )
          : ListView(
              padding:
                  const EdgeInsets.fromLTRB(14, 14, 14, 100),
              children: [
                if (active.isNotEmpty) ...[
                  _SectionTitle(title: 'Wishlist (${active.length})', cs: cs),
                  ...active.map((w) => _WishCard(w: w, app: app, fmt: fmt)),
                ],
                if (purchased.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _SectionTitle(title: 'Purchased ✓', cs: cs, color: const Color(0xFF2E7D32)),
                  ...purchased.map((w) => _WishCard(w: w, app: app, fmt: fmt)),
                ],
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: cs.tertiary,
        foregroundColor: cs.onTertiary,
        onPressed: () => _showSheet(context, app),
        child: const Icon(Icons.add),
      ),
    );
  }

  static void _showSheet(BuildContext ctx, AppProvider app,
      {WishlistItem? existing}) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _WishlistSheet(app: app, existing: existing),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final ColorScheme cs;
  final Color? color;
  const _SectionTitle({required this.title, required this.cs, this.color});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(title,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: color ?? cs.onSurface)),
      );
}

class _WishCard extends StatelessWidget {
  final WishlistItem w;
  final AppProvider app;
  final String Function(double) fmt;
  const _WishCard({required this.w, required this.app, required this.fmt});

  Color get _prioColor {
    switch (w.priority) {
      case 'high':   return const Color(0xFFC62828);
      case 'medium': return const Color(0xFFE65100);
      default:       return const Color(0xFF2E7D32);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _prioColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.star_outline_rounded, color: _prioColor, size: 22),
        ),
        title: Text(
          w.name,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            decoration: w.isPurchased ? TextDecoration.lineThrough : null,
            color: w.isPurchased ? cs.onSurface.withValues(alpha: 0.5) : null,
          ),
        ),
        subtitle: Row(children: [
          Text(fmt(w.price),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: cs.primary,
                  fontSize: 13)),
          const SizedBox(width: 8),
          PillBadge(label: w.priority, color: _prioColor),
        ]),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!w.isPurchased)
              IconButton(
                icon: Icon(Icons.edit_outlined,
                    color: Theme.of(context).colorScheme.primary),
                onPressed: () => WishlistScreen._showSheet(context, app, existing: w),
                tooltip: 'Edit',
              ),
            IconButton(
              icon: Icon(
                w.isPurchased
                    ? Icons.remove_circle_outline
                    : Icons.check_circle_outline,
                color: w.isPurchased
                    ? cs.onSurface.withValues(alpha: 0.4)
                    : const Color(0xFF2E7D32),
              ),
              onPressed: () => app.toggleWishlistPurchased(w.id),
              tooltip: w.isPurchased ? 'Mark unpurchased' : 'Mark purchased',
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              color: cs.onSurface.withValues(alpha: 0.4),
              onPressed: () async {
                final ok = await showDeleteConfirm(context, w.name);
                if (ok && context.mounted) app.deleteWishlistItem(w.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Sheet ────────────────────────────────────────────────────────────────
class _WishlistSheet extends StatefulWidget {
  final AppProvider app;
  final WishlistItem? existing;
  const _WishlistSheet({required this.app, this.existing});

  @override
  State<_WishlistSheet> createState() => _WishlistSheetState();
}

class _WishlistSheetState extends State<_WishlistSheet> {
  late TextEditingController _nameCtrl;
  late TextEditingController _priceCtrl;
  late TextEditingController _notesCtrl;
  late String _priority;

  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final ex = widget.existing;
    _nameCtrl  = TextEditingController(text: ex?.name ?? '');
    _priceCtrl = TextEditingController(
        text: ex != null ? ex.price.toStringAsFixed(2) : '');
    _notesCtrl = TextEditingController(text: ex?.notes ?? '');
    _priority  = ex?.priority ?? 'medium';
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_nameCtrl.text.trim().isEmpty) return;
    final price = double.tryParse(_priceCtrl.text);
    if (price == null || price <= 0) return;

    if (isEdit) {
      final updated = widget.existing!.copyWith(
        name:     _nameCtrl.text.trim(),
        price:    price,
        priority: _priority,
        notes:    _notesCtrl.text.trim(),
      );
      await widget.app.updateWishlistItemFull(updated);
    } else {
      await widget.app.addWishlistItem(WishlistItem(
        id:       widget.app.newId(),
        name:     _nameCtrl.text.trim(),
        price:    price,
        priority: _priority,
        notes:    _notesCtrl.text.trim(),
      ));
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cs       = Theme.of(context).colorScheme;
    final currency = widget.app.settings.currency;
    final sym      = currencyInfo(currency).symbol;

    final prioColors = {
      'low':    const Color(0xFF2E7D32),
      'medium': const Color(0xFFE65100),
      'high':   const Color(0xFFC62828),
    };

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 20, right: 20, top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isEdit ? 'Edit Wishlist Item' : 'Add to Wishlist',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 18),

          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(
                labelText: 'Item Name',
                prefixIcon: Icon(Icons.star_outline_rounded)),
          ),
          const SizedBox(height: 12),

          TextField(
            controller: _priceCtrl,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            decoration:
                InputDecoration(labelText: 'Target Price', prefixText: '$sym '),
          ),
          const SizedBox(height: 14),

          Text('Priority',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'low',    label: Text('Low')),
              ButtonSegment(value: 'medium', label: Text('Medium')),
              ButtonSegment(value: 'high',   label: Text('High')),
            ],
            selected: {_priority},
            onSelectionChanged: (s) => setState(() => _priority = s.first),
            style: SegmentedButton.styleFrom(
              selectedBackgroundColor:
                  prioColors[_priority]?.withValues(alpha: 0.15),
              selectedForegroundColor: prioColors[_priority],
            ),
          ),
          const SizedBox(height: 12),

          TextField(
            controller: _notesCtrl,
            maxLines: 2,
            decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                prefixIcon: Icon(Icons.notes_outlined)),
          ),
          const SizedBox(height: 20),

          FilledButton.icon(
            onPressed: _submit,
            icon: Icon(isEdit ? Icons.save_outlined : Icons.star_outline_rounded),
            label: Text(isEdit ? 'Save Changes' : 'Add to Wishlist'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: cs.tertiary,
              foregroundColor: cs.onTertiary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28)),
            ),
          ),
        ],
      ),
    );
  }
}
