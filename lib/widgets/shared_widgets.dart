// lib/widgets/shared_widgets.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../utils/haptics.dart';
import '../utils/snackbar.dart';
import '../screens/certificate_detail_screen.dart';
import '../screens/certificates_screen.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

// ── Empty state ───────────────────────────────────────────────────────────────
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  final String? subMessage;
  const EmptyState(
      {super.key, required this.icon, required this.message, this.subMessage});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 64, color: cs.onSurface.withValues(alpha: 0.2)),
      const SizedBox(height: 16),
      Text(message,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: cs.onSurface.withValues(alpha: 0.5))),
      if (subMessage != null) ...[
        const SizedBox(height: 6),
        Text(subMessage!,
            style: TextStyle(
                fontSize: 13, color: cs.onSurface.withValues(alpha: 0.35))),
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
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
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
    final cs = Theme.of(context).colorScheme;
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
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(size / 4),
      ),
      child: Icon(icon, color: color, size: size * 0.48),
    );
  }

  IconData _catIcon(String name) {
    final n = name.toLowerCase();
    if (n.contains('transfer')) return Icons.swap_horiz_rounded;
    if (n.contains('grocer')) return Icons.local_grocery_store_outlined;
    if (n.contains('coffee') || n.contains('tea') || n.contains('cafe')) {
      return Icons.local_cafe_outlined;
    }
    if (n.contains('delivery') || n.contains('snack') || n.contains('fast')) {
      return Icons.fastfood_outlined;
    }
    if (n.contains('food') || n.contains('dining') || n.contains('restaur')) {
      return Icons.restaurant_outlined;
    }
    if (n.contains('fuel') || n.contains('petrol') || n.contains('gas')) {
      return Icons.local_gas_station_outlined;
    }
    if (n.contains('parking')) return Icons.local_parking_outlined;
    if (n.contains('maint') || n.contains('repair')) return Icons.build_outlined;
    if (n.contains('taxi') || n.contains('ride')) return Icons.local_taxi_outlined;
    if (n.contains('public') || n.contains('bus') || n.contains('train')) {
      return Icons.directions_bus_outlined;
    }
    if (n.contains('transport') || n.contains('car') || n.contains('vehicle')) {
      return Icons.directions_car_outlined;
    }
    if (n.contains('cloth')) return Icons.checkroom_outlined;
    if (n.contains('electron') || n.contains('tech')) return Icons.devices_outlined;
    if (n.contains('home') || n.contains('rent') || n.contains('furnit') || n.contains('housing')) {
      return Icons.home_outlined;
    }
    if (n.contains('shop')) return Icons.shopping_bag_outlined;
    if (n.contains('internet') || n.contains('wifi')) return Icons.wifi_outlined;
    if (n.contains('elec')) return Icons.electrical_services_outlined;
    if (n.contains('water')) return Icons.water_drop_outlined;
    if (n.contains('phone') || n.contains('mobile')) return Icons.phone_android_outlined;
    if (n.contains('bill') || n.contains('util') || n.contains('emi')) {
      return Icons.receipt_outlined;
    }
    if (n.contains('health') || n.contains('med') || n.contains('doctor') || n.contains('docter')) {
      return Icons.favorite_outline;
    }
    if (n.contains('game')) return Icons.sports_esports_outlined;
    if (n.contains('sport')) return Icons.sports_soccer_outlined;
    if (n.contains('entertain') || n.contains('movie') || n.contains('leisure')) {
      return Icons.movie_outlined;
    }
    if (n.contains('baby') || n.contains('child')) return Icons.child_care_outlined;
    if (n.contains('salon') || n.contains('cosmetic') || n.contains('personal')) {
      return Icons.spa_outlined;
    }
    if (n.contains('subscrip')) return Icons.subscriptions_outlined;
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
  const AccountTypeIcon(
      {super.key, required this.type, this.size = 22, this.color});

  @override
  Widget build(BuildContext context) => Icon(_icon(),
      size: size, color: color ?? Theme.of(context).colorScheme.primary);

  IconData _icon() {
    switch (type) {
      case 'cash':
        return Icons.payments_outlined;
      case 'savings':
        return Icons.savings_outlined;
      case 'credit':
        return Icons.credit_card_outlined;
      case 'wallet':
        return Icons.account_balance_wallet_outlined;
      case 'gold':
        return Icons.diamond_outlined;
      default:
        return Icons.account_balance_outlined;
    }
  }
}

// ── Linear progress ───────────────────────────────────────────────────────────
class LinearProgressCard extends StatelessWidget {
  final double value;
  final Color color;
  const LinearProgressCard(
      {super.key, required this.value, required this.color});

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
  AppHaptics.tap(context, HapticStrength.medium);
  final l10n = AppLocalizations.of(context)!;
  final cs = Theme.of(context).colorScheme;

  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      icon: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: cs.error.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.delete_outline_rounded, color: cs.error, size: 26),
      ),
      title: Text(l10n.shared_widgets_delete, textAlign: TextAlign.center),
      content: Text(
        l10n.shared_widgets_deleteConfirm(name),
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(46),
                  side: BorderSide(
                      color: cs.outlineVariant.withValues(alpha: 0.6)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l10n.shared_widgets_cancel),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: cs.error,
                  foregroundColor: cs.onError,
                  minimumSize: const Size.fromHeight(46),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(l10n.shared_widgets_delete_),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  return ok == true;
}

// ── Account cards (horizontal scroll) ────────────────────────────────────────
class AccountCardPicker extends StatelessWidget {
  final List<Account> accounts;
  final String? selectedId;
  final String? disabledId;
  final bool allowNone;
  final void Function(String?) onSelected;

  const AccountCardPicker({
    super.key,
    required this.accounts,
    required this.selectedId,
    this.disabledId,
    this.allowNone = false,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final app = Provider.of<AppProvider?>(context);
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
          final isDisabled = disabledId != null && acc.id == disabledId;
          final sel = !isDisabled && selectedId == acc.id;
          final color = Color(acc.colorValue);
          final balance = app != null
              ? app.getPickerDisplayBalance(acc)
              : ((acc.isCredit && (acc.creditLimit ?? 0) > 0)
                  ? acc.availableCredit
                  : acc.balance);
          return GestureDetector(
            onTap: isDisabled ? null : () => onSelected(acc.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: 125,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: isDisabled
                    ? cs.surfaceContainerHigh
                    : sel
                        ? color
                        : color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: isDisabled
                        ? Colors.transparent
                        : sel
                            ? color
                            : color.withValues(alpha: 0.35),
                    width: sel ? 2 : 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AccountTypeIcon(
                      type: acc.type,
                      size: 14,
                      color: isDisabled
                          ? cs.onSurface.withValues(alpha: 0.3)
                          : sel
                              ? Colors.white
                              : color),
                  const SizedBox(height: 3),
                  Text(acc.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isDisabled
                              ? cs.onSurface.withValues(alpha: 0.3)
                              : sel
                                  ? Colors.white
                                  : color)),
                  Text(formatAmount(balance, acc.currency),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 9,
                          color: isDisabled
                              ? cs.onSurface.withValues(alpha: 0.2)
                              : sel
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 90,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: sel
              ? cs.primary.withValues(alpha: 0.15)
              : cs.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: sel ? cs.primary : Colors.transparent, width: sel ? 2 : 1),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.block_outlined,
              size: 16,
              color: sel ? cs.primary : cs.onSurface.withValues(alpha: 0.5)),
          const SizedBox(height: 4),
          Text(l10n.shared_widgets_none,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color:
                      sel ? cs.primary : cs.onSurface.withValues(alpha: 0.6))),
        ]),
      ),
    );
  }
}

// ── Category chip picker ──────────────────────────────────────────────────────
class CategoryChipPicker extends StatelessWidget {
  final List<AppCategory> categories;
  final String? selectedId;
  final void Function(String) onSelected;
  final bool showSubcategories;

  const CategoryChipPicker({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onSelected,
    this.showSubcategories = true,
  });

  Widget _buildChip(
    AppCategory cat,
    bool sel,
    AppLocalizations l10n, {
    String? labelOverride,
  }) {
    final color = Color(cat.colorValue);
    final label = labelOverride ?? AppProvider.localizeCategoryName(cat, l10n);
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
          Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                  color: sel ? Colors.white : color,
                  shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: sel ? Colors.white : color)),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final visible = categories.where((c) => !c.isSystem).toList();
    final roots = visible.where((c) => !c.isSubcategory).toList();
    final selectedCat = visible.where((c) => c.id == selectedId).firstOrNull;
    final activeRootId = selectedCat == null
        ? null
        : (selectedCat.isSubcategory ? selectedCat.parentId : selectedCat.id);
    final activeRoot =
        roots.where((c) => c.id == activeRootId).firstOrNull;
    final subs = (showSubcategories && activeRoot != null)
        ? visible.where((c) => c.parentId == activeRoot.id).toList()
        : const <AppCategory>[];

    // If a category list only contains flat/orphan items, fall back to rendering visible.
    final topList = roots.isNotEmpty ? roots : visible;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: topList
              .map((cat) => _buildChip(cat, cat.id == activeRootId, l10n))
              .toList(),
        ),
        if (subs.isNotEmpty && activeRoot != null) ...[
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            decoration: BoxDecoration(
              color: Color(activeRoot.colorValue).withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(14),
              border: Border(
                left: BorderSide(
                  color: Color(activeRoot.colorValue).withValues(alpha: 0.55),
                  width: 3,
                ),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildChip(
                    activeRoot,
                    selectedId == activeRoot.id,
                    l10n,
                    labelOverride:
                        '${l10n.transactions_all} ${AppProvider.localizeCategoryName(activeRoot, l10n)}',
                  ),
                  for (final sub in subs) ...[
                    const SizedBox(width: 6),
                    _buildChip(sub, selectedId == sub.id, l10n),
                  ],
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ── Category icon catalogue ───────────────────────────────────────────────────
//
// IMPORTANT: iconCodePoint in AppCategory stores a 1-BASED INDEX into this
// list (0 = auto / name-based heuristic). Never call IconData(variable, ...)
// at runtime — that breaks Flutter's release-mode icon tree-shaking.
// Always resolve via kCategoryIconOptions[index - 1].icon.

class CategoryIconOption {
  final IconData icon;
  final String label;
  const CategoryIconOption(this.icon, this.label);
}

const List<CategoryIconOption> kCategoryIconOptions = [
  // ── Finance ──────────────────────────────────────────────────────────
  CategoryIconOption(Icons.account_balance_outlined, 'Bank'),
  CategoryIconOption(Icons.payments_outlined, 'Cash'),
  CategoryIconOption(Icons.credit_card_outlined, 'Card'),
  CategoryIconOption(Icons.savings_outlined, 'Savings'),
  CategoryIconOption(Icons.trending_up_outlined, 'Investment'),
  CategoryIconOption(Icons.currency_exchange_rounded, 'Exchange'),
  CategoryIconOption(Icons.wallet_outlined, 'Wallet'),
  CategoryIconOption(Icons.monetization_on_outlined, 'Money'),
  CategoryIconOption(Icons.receipt_outlined, 'Receipt'),
  CategoryIconOption(Icons.receipt_long_outlined, 'Bill'),
  CategoryIconOption(Icons.attach_money_rounded, 'Dollar'),
  CategoryIconOption(Icons.card_giftcard_outlined, 'Gift'),
  // ── Food & Home ──────────────────────────────────────────────────────
  CategoryIconOption(Icons.restaurant_outlined, 'Food'),
  CategoryIconOption(Icons.local_cafe_outlined, 'Coffee'),
  CategoryIconOption(Icons.fastfood_outlined, 'Fast Food'),
  CategoryIconOption(Icons.local_grocery_store_outlined, 'Grocery'),
  CategoryIconOption(Icons.home_outlined, 'Home'),
  CategoryIconOption(Icons.house_outlined, 'House'),
  CategoryIconOption(Icons.electrical_services_outlined, 'Electricity'),
  CategoryIconOption(Icons.water_drop_outlined, 'Water'),
  CategoryIconOption(Icons.wifi_outlined, 'Internet'),
  CategoryIconOption(Icons.local_gas_station_outlined, 'Gas'),
  // ── Transport ─────────────────────────────────────────────────────────
  CategoryIconOption(Icons.directions_car_outlined, 'Car'),
  CategoryIconOption(Icons.directions_bus_outlined, 'Bus'),
  CategoryIconOption(Icons.flight_outlined, 'Flight'),
  CategoryIconOption(Icons.local_taxi_outlined, 'Taxi'),
  CategoryIconOption(Icons.pedal_bike_outlined, 'Bike'),
  CategoryIconOption(Icons.train_outlined, 'Train'),
  // ── Shopping ──────────────────────────────────────────────────────────
  CategoryIconOption(Icons.shopping_bag_outlined, 'Shopping'),
  CategoryIconOption(Icons.shopping_cart_outlined, 'Cart'),
  CategoryIconOption(Icons.checkroom_outlined, 'Clothes'),
  CategoryIconOption(Icons.devices_outlined, 'Electronics'),
  // ── Health ────────────────────────────────────────────────────────────
  CategoryIconOption(Icons.favorite_outline, 'Health'),
  CategoryIconOption(Icons.medical_services_outlined, 'Medical'),
  CategoryIconOption(Icons.local_hospital_outlined, 'Hospital'),
  CategoryIconOption(Icons.fitness_center_outlined, 'Gym'),
  CategoryIconOption(Icons.spa_outlined, 'Spa'),
  // ── Entertainment & Education ─────────────────────────────────────────
  CategoryIconOption(Icons.movie_outlined, 'Movie'),
  CategoryIconOption(Icons.sports_esports_outlined, 'Gaming'),
  CategoryIconOption(Icons.music_note_outlined, 'Music'),
  CategoryIconOption(Icons.book_outlined, 'Book'),
  CategoryIconOption(Icons.school_outlined, 'School'),
  CategoryIconOption(Icons.sports_soccer_outlined, 'Sports'),
  CategoryIconOption(Icons.travel_explore_outlined, 'Travel'),
  // ── Work & Business ───────────────────────────────────────────────────
  CategoryIconOption(Icons.work_outline, 'Work'),
  CategoryIconOption(Icons.business_outlined, 'Business'),
  CategoryIconOption(Icons.laptop_outlined, 'Laptop'),
  CategoryIconOption(Icons.people_outline, 'People'),
  CategoryIconOption(Icons.handshake_outlined, 'Handshake'),
  // ── Misc ──────────────────────────────────────────────────────────────
  CategoryIconOption(Icons.label_outline_rounded, 'Label'),
  CategoryIconOption(Icons.star_outline_rounded, 'Star'),
  CategoryIconOption(Icons.emoji_events_outlined, 'Trophy'),
  CategoryIconOption(Icons.category_outlined, 'Category'),
  CategoryIconOption(Icons.pets_outlined, 'Pets'),
  CategoryIconOption(Icons.child_care_outlined, 'Child'),
  CategoryIconOption(Icons.phone_outlined, 'Phone'),
  CategoryIconOption(Icons.subscriptions_outlined, 'Subscription'),
];

// ── Searchable currency dialog ────────────────────────────────────────────────
Future<String?> showCurrencyPicker(BuildContext context,
    {String? current}) async {
  final ctrl = TextEditingController();
  final l10n = AppLocalizations.of(context)!;
  String query = '';
  return showDialog<String>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setS) => AlertDialog(
        title: Text(l10n.shared_widgets_selectCurrency),
        contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
              controller: ctrl,
              autofocus: false,
              decoration: InputDecoration(
                  hintText: l10n.shared_widgets_searchByCode,
                  prefixIcon: const Icon(Icons.search),
                  isDense: true),
              onChanged: (v) => setS(() => query = v.toLowerCase()),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 340,
              child: ListView(
                children: kCurrencies
                    .where((c) =>
                        query.isEmpty ||
                        c.code.toLowerCase().contains(query) ||
                        c.name.toLowerCase().contains(query))
                    .map((cur) => ListTile(
                          dense: true,
                          leading: Text(cur.symbol,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 16)),
                          title: Text('${cur.code} — ${cur.name}'),
                          selected: current == cur.code,
                          selectedColor: Theme.of(ctx).colorScheme.primary,
                          onTap: () => Navigator.pop(ctx, cur.code),
                        ))
                    .toList(),
              ),
            ),
          ]),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.shared_widgets_cancel)),
        ],
      ),
    ),
  );
}

// ── Expandable FAB ────────────────────────────────────────────────────────────

class ExpandableFabItem {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const ExpandableFabItem({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class ExpandableFab extends StatefulWidget {
  final String label;
  final VoidCallback? onIncome;
  final VoidCallback? onExpense;
  final VoidCallback? onTransfer;
  final List<ExpandableFabItem>? items;
  final Color? color;
  final CrossAxisAlignment alignment;

  const ExpandableFab({
    super.key,
    required this.label,
    this.onIncome,
    this.onExpense,
    this.onTransfer,
    this.items,
    this.color,
    this.alignment = CrossAxisAlignment.end,
  });

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 180),
      vsync: this,
    );
  }

  Animation<double> _animationForIndex(int index, int count) {
    if (count <= 1) return _controller;
    final start = (index / (count + 1)).clamp(0.0, 0.5);
    final end = ((index + 2) / (count + 1)).clamp(0.5, 1.0);
    return CurvedAnimation(
      parent: _controller,
      curve: Interval(start, end, curve: Curves.fastOutSlowIn),
      reverseCurve: Interval(start, end, curve: Curves.easeOutQuad),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTabChange() {
    if (_open && mounted) {
      _toggle(haptic: false);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final app = context.read<AppProvider>();
    app.tabIndexNotifier.removeListener(_onTabChange);
    app.tabIndexNotifier.addListener(_onTabChange);
  }

  void _toggle({bool haptic = true}) {
    if (haptic) AppHaptics.tap(context, HapticStrength.light);
    if (!mounted) return;
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;
    final primaryColor = widget.color ?? cs.primary;

    final List<ExpandableFabItem> actions = widget.items ?? [
      if (widget.onTransfer != null)
        ExpandableFabItem(
          label: l10n.transfer_transfer,
          icon: Icons.swap_horiz_rounded,
          color: cs.primary,
          onTap: widget.onTransfer!,
        ),
      ExpandableFabItem(
        label: l10n.add_transaction_expense,
        icon: Icons.arrow_upward_rounded,
        color: const Color(0xFFE53935),
        onTap: widget.onExpense ?? () {},
      ),
      ExpandableFabItem(
        label: l10n.add_transaction_income,
        icon: Icons.arrow_downward_rounded,
        color: kSuccessColor,
        onTap: widget.onIncome ?? () {},
      ),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: widget.alignment,
      children: [
        ...actions.asMap().entries.map((entry) {
          final idx = entry.key;
          final item = entry.value;
          final anim = _animationForIndex(idx, actions.length);
          return _buildAction(
            color: item.color,
            icon: item.icon,
            label: item.label,
            onTap: () {
              _toggle();
              item.onTap();
            },
            animation: anim,
            isDark: isDark,
          );
        }),
        Material(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: _toggle,
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor,
                    Color.lerp(primaryColor, Colors.black, isDark ? 0.25 : 0.15)!,
                  ],
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: isDark ? 0.25 : 0.4),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: isDark ? 0.45 : 0.35),
                    blurRadius: 18,
                    spreadRadius: 0,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.5,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: _open ? 0.125 : 0,
                    duration: const Duration(milliseconds: 180),
                    child: const Icon(Icons.add_rounded, color: Colors.white, size: 22),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAction({
    required Color color,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Animation<double> animation,
    required bool isDark,
  }) {
    final textDir = Directionality.of(context);
    final Alignment animAlignment = (widget.alignment == CrossAxisAlignment.end
            ? AlignmentDirectional.bottomEnd
            : (widget.alignment == CrossAxisAlignment.start
                ? AlignmentDirectional.bottomStart
                : AlignmentDirectional.bottomCenter))
        .resolve(textDir);

    return Align(
      alignment: widget.alignment == CrossAxisAlignment.end
          ? AlignmentDirectional.centerEnd
          : (widget.alignment == CrossAxisAlignment.start
              ? AlignmentDirectional.centerStart
              : AlignmentDirectional.center),
      child: SizeTransition(
        sizeFactor: animation,
        axis: Axis.vertical,
        alignment: animAlignment,
        child: FadeTransition(
          opacity: animation,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Material(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onTap,
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        color,
                        Color.lerp(color, Colors.black, isDark ? 0.2 : 0.1)!,
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: isDark ? 0.25 : 0.35),
                      width: 1.1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: isDark ? 0.4 : 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13.5,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(icon, color: Colors.white, size: 19),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Modern fintech-styled dropdown form field with 16px rounded corners,
/// subtle outline border, theme-adaptive container fill, and rounded chevron.
class AppDropdownFormField<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final FormFieldValidator<T>? validator;
  final bool isExpanded;
  final EdgeInsetsGeometry? contentPadding;

  const AppDropdownFormField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.isExpanded = true,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DropdownButtonFormField<T>(
      initialValue: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
      isExpanded: isExpanded,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: cs.onSurfaceVariant,
        size: 22,
      ),
      borderRadius: BorderRadius.circular(16),
      dropdownColor: popupSurfaceColor(cs),
      elevation: 6,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: cs.surfaceContainerHighest.withValues(alpha: isDark ? 0.35 : 0.45),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: cs.outlineVariant.withValues(alpha: isDark ? 0.35 : 0.45),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: cs.outlineVariant.withValues(alpha: isDark ? 0.35 : 0.45),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: cs.primary,
            width: 1.6,
          ),
        ),
      ),
    );
  }
}

/// Standalone fintech-styled rounded dropdown menu with 16px corner radius.
class AppDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final bool isExpanded;
  final EdgeInsetsGeometry? padding;

  const AppDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isExpanded = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: isDark ? 0.35 : 0.45),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: cs.outlineVariant.withValues(alpha: isDark ? 0.35 : 0.45),
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          isExpanded: isExpanded,
          isDense: true,
          borderRadius: BorderRadius.circular(16),
          dropdownColor: popupSurfaceColor(cs),
          elevation: 6,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: cs.onSurfaceVariant,
            size: 18,
          ),
        ),
      ),
    );
  }
}

// ── Reusable Modal Sheet Shell (D5.1) ─────────────────────────────────────────
/// Standardized bottom-sheet wrapper with keyboard-inset padding, optional drag
/// handle, and optional title header.
class SheetShell extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool showHandle;
  final double maxHeightFactor;
  final List<Widget> children;

  const SheetShell({
    super.key,
    this.title,
    this.subtitle,
    this.showHandle = false,
    this.maxHeightFactor = 0.88,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(
        bottom: bottomInset + 16,
        left: 20,
        right: 20,
        top: showHandle ? 12 : 20,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * maxHeightFactor,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showHandle) ...[
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: cs.outlineVariant,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              if (title != null)
                Text(
                  title!,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface.withValues(alpha: 0.55),
                  ),
                ),
              if (title != null || subtitle != null) const SizedBox(height: 12),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

// ── Reusable Status Badge Pill (D5.2) ─────────────────────────────────────────
/// Compact colored pill badge used for status indicators (e.g. Settled, Active,
/// Overdue) that adapts cleanly in both light and dark/AMOLED themes.
class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;

  const StatusBadge({
    super.key,
    required this.label,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Reusable Binary or Ternary Type Toggle Chips (D5.3) ───────────────────────
/// Animated two- or three-option toggle row (e.g. Expense/Income/Transfer or
/// Lent/Borrowed) with dark/AMOLED-safe unselected tinting.
class TypeToggleChips extends StatelessWidget {
  final String selectedValue;
  final String firstValue;
  final String firstLabel;
  final Color firstColor;
  final Color? firstLightTint;
  final String secondValue;
  final String secondLabel;
  final Color secondColor;
  final Color? secondLightTint;
  final String? thirdValue;
  final String? thirdLabel;
  final Color? thirdColor;
  final Color? thirdLightTint;
  final ValueChanged<String> onChanged;
  final double verticalPadding;

  const TypeToggleChips({
    super.key,
    required this.selectedValue,
    required this.firstValue,
    required this.firstLabel,
    this.firstColor = kDangerColor,
    this.firstLightTint,
    required this.secondValue,
    required this.secondLabel,
    this.secondColor = kSuccessColor,
    this.secondLightTint,
    this.thirdValue,
    this.thirdLabel,
    this.thirdColor,
    this.thirdLightTint,
    required this.onChanged,
    this.verticalPadding = 10,
  });

  Widget _buildOption({
    required BuildContext context,
    required bool isDark,
    required String value,
    required String label,
    required Color color,
    Color? lightTint,
  }) {
    final sel = selectedValue == value;
    final unselectedBg = isDark
        ? color.withValues(alpha: 0.15)
        : (lightTint ?? color.withValues(alpha: 0.12));

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 6),
          decoration: BoxDecoration(
            color: sel ? color : unselectedBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: sel ? Colors.white : color,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;

    return Row(
      children: [
        _buildOption(
          context: context,
          isDark: isDark,
          value: firstValue,
          label: firstLabel,
          color: firstColor,
          lightTint: firstLightTint,
        ),
        const SizedBox(width: 8),
        _buildOption(
          context: context,
          isDark: isDark,
          value: secondValue,
          label: secondLabel,
          color: secondColor,
          lightTint: secondLightTint,
        ),
        if (thirdValue != null && thirdLabel != null) ...[
          const SizedBox(width: 8),
          _buildOption(
            context: context,
            isDark: isDark,
            value: thirdValue!,
            label: thirdLabel!,
            color: thirdColor ?? cs.primary,
            lightTint: thirdLightTint,
          ),
        ],
      ],
    );
  }
}

// ── Shared Detail Stat Cell ───────────────────────────────────────────────────
class DetailStatCell extends StatelessWidget {
  final String label;
  final String value;
  const DetailStatCell(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: cs.onSurface.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// ── Shared Transfer & Certificate Transaction Dialogs ─────────────────────────
Future<void> showTransferTransactionDialog(
  BuildContext context,
  AppTransaction t,
) async {
  final l10n = AppLocalizations.of(context)!;
  final cs = Theme.of(context).colorScheme;
  final app = context.read<AppProvider>();

  await showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.transactions_transferTitle),
      content: Text(l10n.transactions_transferBody),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(l10n.shared_widgets_cancel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: cs.error),
          onPressed: () async {
            Navigator.pop(ctx);
            final undo = await app.deleteTransactionWithUndo(t.id);
            if (context.mounted) {
              showAppSnackbar(
                context,
                l10n.transactions_transferDeleted,
                onUndo: undo,
              );
            }
          },
          child: Text(l10n.transactions_deleteTransfer),
        ),
      ],
    ),
  );
}

Future<void> showCertificateTransactionDialog(
  BuildContext context,
  AppTransaction t,
) async {
  final l10n = AppLocalizations.of(context)!;
  final app = context.read<AppProvider>();
  final cert = t.certificateId != null
      ? app.certificates.where((c) => c.id == t.certificateId).firstOrNull
      : null;

  await showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.transactions_certTitle),
      content: Text(l10n.transactions_certBody),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(l10n.common_close),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(ctx);
            Navigator.push(
              context,
              ExpensyRoute(
                builder: (_) => cert != null
                    ? CertificateDetailScreen(certificate: cert)
                    : const CertificatesScreen(),
              ),
            );
          },
          child: Text(
            cert != null
                ? l10n.transactions_viewCertificate
                : l10n.transactions_openCertificates,
          ),
        ),
      ],
    ),
  );
}

Future<String?> showBackupPasswordDialog(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  final ctrl = TextEditingController();
  bool obscure = true;
  final result = await showDialog<String>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setDialogState) => AlertDialog(
        title: Text(l10n.backup_encryptedTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.backup_encryptedPrompt,
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: ctrl,
              obscureText: obscure,
              autofocus: true,
              decoration: InputDecoration(
                labelText: l10n.backup_password,
                suffixIcon: IconButton(
                  icon: Icon(
                    obscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () => setDialogState(() => obscure = !obscure),
                ),
              ),
              onSubmitted: (v) => Navigator.pop(ctx, v.trim()),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, null),
            child: Text(l10n.shared_widgets_cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, ctrl.text.trim()),
            child: Text(l10n.backup_decryptContinue),
          ),
        ],
      ),
    ),
  );
  ctrl.dispose();
  return result;
}
