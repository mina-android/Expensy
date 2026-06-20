// lib/widgets/shared_widgets.dart
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

// ── Empty state ───────────────────────────────────────────────────────────────
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  final String? subMessage;
  const EmptyState({super.key, required this.icon,
      required this.message, this.subMessage});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 64, color: cs.onSurface.withValues(alpha: 0.2)),
      const SizedBox(height: 16),
      Text(message, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,
          color: cs.onSurface.withValues(alpha: 0.5))),
      if (subMessage != null) ...[
        const SizedBox(height: 6),
        Text(subMessage!, style: TextStyle(fontSize: 13,
            color: cs.onSurface.withValues(alpha: 0.35))),
      ],
    ]));
  }
}

// ── Section header ────────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(4, 16, 0, 6),
        child: Text(title.toUpperCase(),
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2,
                color: Theme.of(context).colorScheme.onSurface
                    .withValues(alpha: 0.5))),
      );
}

// ── Category dot ──────────────────────────────────────────────────────────────
class CategoryDot extends StatelessWidget {
  final AppCategory? category;
  final double size;
  const CategoryDot({super.key, required this.category, this.size = 44});

  @override
  Widget build(BuildContext context) {
    final cs    = Theme.of(context).colorScheme;
    final color = category != null ? Color(category!.colorValue) : cs.primary;
    // iconCodePoint actually stores a 1-based index into kCategoryIconOptions.
    // 0 means "auto" (use name heuristic). This avoids non-constant IconData()
    // calls that break Flutter's icon tree-shaking in release builds.
    final IconData icon;
    final storedIndex = category?.iconCodePoint ?? 0;
    if (storedIndex > 0 && storedIndex <= kCategoryIconOptions.length) {
      icon = kCategoryIconOptions[storedIndex - 1].icon; // const IconData ✓
    } else {
      icon = _catIcon(category?.name ?? '');
    }
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(size / 4),
      ),
      child: Icon(icon, color: color, size: size * 0.48),
    );
  }

  IconData _catIcon(String name) {
    final n = name.toLowerCase();
    if (n.contains('food') || n.contains('dining')) return Icons.restaurant_outlined;
    if (n.contains('transport') || n.contains('car')) return Icons.directions_car_outlined;
    if (n.contains('shop')) return Icons.shopping_bag_outlined;
    if (n.contains('bill') || n.contains('util')) return Icons.receipt_outlined;
    if (n.contains('health') || n.contains('med')) return Icons.favorite_outline;
    if (n.contains('entertain')) return Icons.movie_outlined;
    if (n.contains('edu')) return Icons.school_outlined;
    if (n.contains('salary') || n.contains('wage')) return Icons.work_outline;
    if (n.contains('freelance')) return Icons.laptop_outlined;
    if (n.contains('invest')) return Icons.trending_up_outlined;
    if (n.contains('gift')) return Icons.card_giftcard_outlined;
    if (n.contains('business')) return Icons.business_outlined;
    return Icons.label_outline_rounded;
  }
}

// ── Account type icon ─────────────────────────────────────────────────────────
class AccountTypeIcon extends StatelessWidget {
  final String type;
  final double size;
  final Color? color;
  const AccountTypeIcon({super.key, required this.type,
      this.size = 22, this.color});

  @override
  Widget build(BuildContext context) => Icon(_icon(), size: size,
      color: color ?? Theme.of(context).colorScheme.primary);

  IconData _icon() {
    switch (type) {
      case 'cash':    return Icons.payments_outlined;
      case 'savings': return Icons.savings_outlined;
      case 'credit':  return Icons.credit_card_outlined;
      case 'wallet':  return Icons.account_balance_wallet_outlined;
      case 'gold':    return Icons.diamond_outlined;
      default:        return Icons.account_balance_outlined;
    }
  }
}

// ── Linear progress ───────────────────────────────────────────────────────────
class LinearProgressCard extends StatelessWidget {
  final double value;
  final Color  color;
  const LinearProgressCard({super.key, required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: value.clamp(0, 1),
          minHeight: 6,
          color: color,
          backgroundColor: color.withValues(alpha: 0.15),
        ),
      );
}

// ── Delete confirm ────────────────────────────────────────────────────────────
Future<bool> showDeleteConfirm(BuildContext context, String name) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Delete?'),
      content: Text('Delete "$name"? This cannot be undone.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel')),
        FilledButton(
          style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error),
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
  return ok == true;
}

// ── Account cards (horizontal scroll) ────────────────────────────────────────
class AccountCardPicker extends StatelessWidget {
  final List<Account>   accounts;
  final String?         selectedId;
  final bool            allowNone;
  final void Function(String?) onSelected;

  const AccountCardPicker({super.key,
    required this.accounts, required this.selectedId,
    this.allowNone = false, required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final items = allowNone
        ? [null, ...accounts.map((a) => a as Account?)]
        : accounts.map((a) => a as Account?).toList();

    return SizedBox(
      height: 76,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final acc = items[i];
          if (acc == null) {
            final sel = selectedId == null;
            return _NoneCard(sel: sel, cs: cs, onTap: () => onSelected(null));
          }
          final sel   = selectedId == acc.id;
          final color = Color(acc.colorValue);
          return GestureDetector(
            onTap: () => onSelected(acc.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: 125,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: sel ? color : color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: sel ? color : color.withValues(alpha: 0.35),
                    width: sel ? 2 : 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AccountTypeIcon(type: acc.type, size: 14,
                      color: sel ? Colors.white : color),
                  const SizedBox(height: 3),
                  Text(acc.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
                          color: sel ? Colors.white : color)),
                  Text(formatAmount(acc.balance, acc.currency),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 9,
                          color: sel
                              ? Colors.white.withValues(alpha: 0.8)
                              : cs.onSurface.withValues(alpha: 0.5))),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NoneCard extends StatelessWidget {
  final bool sel;
  final ColorScheme cs;
  final VoidCallback onTap;
  const _NoneCard({required this.sel, required this.cs, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: 90,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: sel ? cs.primary.withValues(alpha: 0.15) : cs.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: sel ? cs.primary : Colors.transparent,
                width: sel ? 2 : 1),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.block_outlined, size: 16,
                color: sel ? cs.primary : cs.onSurface.withValues(alpha: 0.5)),
            const SizedBox(height: 4),
            Text('None', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                color: sel ? cs.primary : cs.onSurface.withValues(alpha: 0.6))),
          ]),
        ),
      );
}

// ── Category chip picker ──────────────────────────────────────────────────────
class CategoryChipPicker extends StatelessWidget {
  final List<AppCategory> categories;
  final String?           selectedId;
  final void Function(String) onSelected;

  const CategoryChipPicker({super.key,
    required this.categories, required this.selectedId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 8, runSpacing: 8,
        children: categories.map((cat) {
          final sel   = selectedId == cat.id;
          final color = Color(cat.colorValue);
          return GestureDetector(
            onTap: () => onSelected(cat.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: sel ? color : color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: sel ? color : color.withValues(alpha: 0.4),
                    width: sel ? 2 : 1),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(width: 8, height: 8,
                    decoration: BoxDecoration(
                        color: sel ? Colors.white : color,
                        shape: BoxShape.circle)),
                const SizedBox(width: 6),
                Text(cat.name, style: TextStyle(fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: sel ? Colors.white : color)),
              ]),
            ),
          );
        }).toList(),
      );
}

// ── Category icon catalogue ───────────────────────────────────────────────────
//
// IMPORTANT: iconCodePoint in AppCategory stores a 1-BASED INDEX into this
// list (0 = auto / name-based heuristic). Never call IconData(variable, ...)
// at runtime — that breaks Flutter's release-mode icon tree-shaking.
// Always resolve via kCategoryIconOptions[index - 1].icon.

class CategoryIconOption {
  final IconData icon;
  final String   label;
  const CategoryIconOption(this.icon, this.label);
}

const List<CategoryIconOption> kCategoryIconOptions = [
  // ── Finance ──────────────────────────────────────────────────────────
  CategoryIconOption(Icons.account_balance_outlined,       'Bank'),
  CategoryIconOption(Icons.payments_outlined,              'Cash'),
  CategoryIconOption(Icons.credit_card_outlined,           'Card'),
  CategoryIconOption(Icons.savings_outlined,               'Savings'),
  CategoryIconOption(Icons.trending_up_outlined,           'Investment'),
  CategoryIconOption(Icons.currency_exchange_rounded,      'Exchange'),
  CategoryIconOption(Icons.wallet_outlined,                'Wallet'),
  CategoryIconOption(Icons.monetization_on_outlined,       'Money'),
  CategoryIconOption(Icons.receipt_outlined,               'Receipt'),
  CategoryIconOption(Icons.receipt_long_outlined,          'Bill'),
  CategoryIconOption(Icons.attach_money_rounded,           'Dollar'),
  CategoryIconOption(Icons.card_giftcard_outlined,         'Gift'),
  // ── Food & Home ──────────────────────────────────────────────────────
  CategoryIconOption(Icons.restaurant_outlined,            'Food'),
  CategoryIconOption(Icons.local_cafe_outlined,            'Coffee'),
  CategoryIconOption(Icons.fastfood_outlined,              'Fast Food'),
  CategoryIconOption(Icons.local_grocery_store_outlined,   'Grocery'),
  CategoryIconOption(Icons.home_outlined,                  'Home'),
  CategoryIconOption(Icons.house_outlined,                 'House'),
  CategoryIconOption(Icons.electrical_services_outlined,   'Electricity'),
  CategoryIconOption(Icons.water_drop_outlined,            'Water'),
  CategoryIconOption(Icons.wifi_outlined,                  'Internet'),
  CategoryIconOption(Icons.local_gas_station_outlined,     'Gas'),
  // ── Transport ─────────────────────────────────────────────────────────
  CategoryIconOption(Icons.directions_car_outlined,        'Car'),
  CategoryIconOption(Icons.directions_bus_outlined,        'Bus'),
  CategoryIconOption(Icons.flight_outlined,                'Flight'),
  CategoryIconOption(Icons.local_taxi_outlined,            'Taxi'),
  CategoryIconOption(Icons.pedal_bike_outlined,            'Bike'),
  CategoryIconOption(Icons.train_outlined,                 'Train'),
  // ── Shopping ──────────────────────────────────────────────────────────
  CategoryIconOption(Icons.shopping_bag_outlined,          'Shopping'),
  CategoryIconOption(Icons.shopping_cart_outlined,         'Cart'),
  CategoryIconOption(Icons.checkroom_outlined,             'Clothes'),
  CategoryIconOption(Icons.devices_outlined,               'Electronics'),
  // ── Health ────────────────────────────────────────────────────────────
  CategoryIconOption(Icons.favorite_outline,               'Health'),
  CategoryIconOption(Icons.medical_services_outlined,      'Medical'),
  CategoryIconOption(Icons.local_hospital_outlined,        'Hospital'),
  CategoryIconOption(Icons.fitness_center_outlined,        'Gym'),
  CategoryIconOption(Icons.spa_outlined,                   'Spa'),
  // ── Entertainment & Education ─────────────────────────────────────────
  CategoryIconOption(Icons.movie_outlined,                 'Movie'),
  CategoryIconOption(Icons.sports_esports_outlined,        'Gaming'),
  CategoryIconOption(Icons.music_note_outlined,            'Music'),
  CategoryIconOption(Icons.book_outlined,                  'Book'),
  CategoryIconOption(Icons.school_outlined,                'School'),
  CategoryIconOption(Icons.sports_soccer_outlined,         'Sports'),
  CategoryIconOption(Icons.travel_explore_outlined,        'Travel'),
  // ── Work & Business ───────────────────────────────────────────────────
  CategoryIconOption(Icons.work_outline,                   'Work'),
  CategoryIconOption(Icons.business_outlined,              'Business'),
  CategoryIconOption(Icons.laptop_outlined,                'Laptop'),
  CategoryIconOption(Icons.people_outline,                 'People'),
  CategoryIconOption(Icons.handshake_outlined,             'Handshake'),
  // ── Misc ──────────────────────────────────────────────────────────────
  CategoryIconOption(Icons.label_outline_rounded,          'Label'),
  CategoryIconOption(Icons.star_outline_rounded,           'Star'),
  CategoryIconOption(Icons.emoji_events_outlined,          'Trophy'),
  CategoryIconOption(Icons.category_outlined,              'Category'),
  CategoryIconOption(Icons.pets_outlined,                  'Pets'),
  CategoryIconOption(Icons.child_care_outlined,            'Child'),
  CategoryIconOption(Icons.phone_outlined,                 'Phone'),
  CategoryIconOption(Icons.subscriptions_outlined,         'Subscription'),
];

// ── Searchable currency dialog ────────────────────────────────────────────────
Future<String?> showCurrencyPicker(BuildContext context,
    {String? current}) async {
  final ctrl  = TextEditingController();
  String query = '';
  return showDialog<String>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setS) => AlertDialog(
        title: const Text('Select Currency'),
        contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
              controller: ctrl, autofocus: true,
              decoration: const InputDecoration(
                  hintText: 'Search by code or name...',
                  prefixIcon: Icon(Icons.search), isDense: true),
              onChanged: (v) => setS(() => query = v.toLowerCase()),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 340,
              child: ListView(
                children: kCurrencies
                    .where((c) => query.isEmpty ||
                        c.code.toLowerCase().contains(query) ||
                        c.name.toLowerCase().contains(query))
                    .map((cur) => ListTile(
                          dense: true,
                          leading: Text(cur.symbol,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 16)),
                          title: Text('${cur.code} — ${cur.name}'),
                          selected: current == cur.code,
                          selectedColor:
                              Theme.of(ctx).colorScheme.primary,
                          onTap: () => Navigator.pop(ctx, cur.code),
                        ))
                    .toList(),
              ),
            ),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
        ],
      ),
    ),
  );
}
