// lib/screens/wishlist_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    String fmt(double v) => formatAmount(v, app.settings.currency);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.wishlist_wishlist, style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: app.wishlist.isEmpty
          ? EmptyState(icon: Icons.star_outline_rounded,
              message: l10n.wishlist_noItems,
              subMessage: l10n.wishlist_noItemsSub)
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
              itemCount: app.wishlist.length,
              itemBuilder: (_, i) => _WishCard(item: app.wishlist[i], fmt: fmt),
            ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => _openSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  static void _openSheet(BuildContext ctx, {WishlistItem? existing}) {
    showModalBottomSheet(
      context: ctx, isScrollControlled: true, useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _WishSheet(existing: existing),
    );
  }
}

class _WishCard extends StatelessWidget {
  final WishlistItem item;
  final String Function(double) fmt;
  const _WishCard({required this.item, required this.fmt});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final pColor = _priorityColor(item.priority);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        leading: GestureDetector(
          onTap: () => context.read<AppProvider>().updateWishlist(
              item.copyWith(isPurchased: !item.isPurchased)),
          child: Container(width: 40, height: 40,
              decoration: BoxDecoration(
                color: item.isPurchased
                    ? const Color(0xFF2E7D32).withValues(alpha: 0.12)
                    : cs.surfaceContainerHigh,
                shape: BoxShape.circle),
              child: Icon(
                item.isPurchased
                    ? Icons.check_circle_outline_rounded
                    : Icons.circle_outlined,
                color: item.isPurchased ? const Color(0xFF2E7D32) : cs.onSurface.withValues(alpha: 0.3),
              )),
        ),
        title: Text(item.name,
            style: TextStyle(fontWeight: FontWeight.w700,
                decoration: item.isPurchased ? TextDecoration.lineThrough : null)),
        subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                  color: pColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8)),
              child: Text(item.priority.toUpperCase(),
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700,
                      color: pColor)),
            ),
            const SizedBox(width: 8),
            Text(fmt(item.targetPrice),
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          ]),
          if (item.notes.isNotEmpty)
            Text(item.notes, maxLines: 1, overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11,
                    color: cs.onSurface.withValues(alpha: 0.5))),
        ]),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(icon: const Icon(Icons.edit_outlined, size: 18),
              onPressed: () => WishlistScreen._openSheet(context, existing: item)),
          IconButton(icon: Icon(Icons.delete_outline_rounded, size: 18,
              color: cs.error),
              onPressed: () async {
                if (await showDeleteConfirm(context, item.name) && context.mounted) {
                  context.read<AppProvider>().deleteWishlist(item.id);
                }
              }),
        ]),
      ),
    );
  }

  Color _priorityColor(String p) {
    switch (p) {
      case 'high':   return const Color(0xFFC62828);
      case 'medium': return const Color(0xFFE65100);
      default:       return const Color(0xFF2E7D32);
    }
  }
}

class _WishSheet extends StatefulWidget {
  final WishlistItem? existing;
  const _WishSheet({this.existing});
  @override
  State<_WishSheet> createState() => _WishSheetState();
}

class _WishSheetState extends State<_WishSheet> {
  final _nameCtrl  = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String _priority = 'medium';
  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      _nameCtrl.text  = e.name;
      _priceCtrl.text = e.targetPrice.toStringAsFixed(2);
      _notesCtrl.text = e.notes;
      _priority = e.priority;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose(); _priceCtrl.dispose(); _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_nameCtrl.text.trim().isEmpty) return;
    final price = double.tryParse(_priceCtrl.text) ?? 0;
    final app = context.read<AppProvider>();
    if (isEdit) {
      await app.updateWishlist(widget.existing!.copyWith(
        name: _nameCtrl.text.trim(), targetPrice: price,
        priority: _priority, notes: _notesCtrl.text.trim(),
      ));
    } else {
      await app.addWishlist(WishlistItem(
        id: app.newId(), name: _nameCtrl.text.trim(),
        targetPrice: price, priority: _priority,
        notes: _notesCtrl.text.trim(),
      ));
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final sym = currencyInfo(app.settings.currency).symbol;
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 20, right: 20, top: 20),
      child: Column(mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(isEdit ? l10n.wishlist_editItem : l10n.wishlist_addWishlistItem,
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        TextField(controller: _nameCtrl,
            decoration: InputDecoration(labelText: l10n.wishlist_itemName,
                prefixIcon: const Icon(Icons.star_outline_rounded))),
        const SizedBox(height: 12),
        TextField(controller: _priceCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                labelText: l10n.wishlist_targetPrice, prefixText: '$sym ')),
        const SizedBox(height: 14),
        Text(l10n.wishlist_priority, style: Theme.of(context).textTheme.labelMedium
            ?.copyWith(letterSpacing: 1)),
        const SizedBox(height: 8),
        Row(children: [
          for (final p in [('low',l10n.wishlist_priorityLow,0xFF2E7D32),
              ('medium',l10n.wishlist_priorityMedium,0xFFE65100), ('high',l10n.wishlist_priorityHigh,0xFFC62828)])
            Expanded(child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => setState(() => _priority = p.$1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  decoration: BoxDecoration(
                    color: _priority == p.$1
                        ? Color(p.$3) : Color(p.$3).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Text(p.$2, style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700,
                      color: _priority == p.$1
                          ? Colors.white : Color(p.$3)))),
                ),
              ),
            )),
        ]),
        const SizedBox(height: 12),
        TextField(controller: _notesCtrl, maxLines: 2,
            decoration: InputDecoration(labelText: l10n.wishlist_notesOptional,
                prefixIcon: const Icon(Icons.sticky_note_2_outlined))),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: _submit,
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))),
          child: Text(isEdit ? l10n.wishlist_saveChanges : l10n.wishlist_addItem),
        ),
      ]),
    );
  }
}
