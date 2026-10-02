// lib/screens/wishlist_screen.dart
import 'package:flutter/material.dart';
import '../utils/snackbar.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/fintech_components.dart';
import '../widgets/app_numeric_keypad.dart';
import '../utils/haptics.dart';
import '../widgets/savings_goal_sheet.dart';
import 'savings_goal_detail_screen.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final l10n = AppLocalizations.of(context)!;
    String fmt(double v) => formatAmount(v, app.settings.currency);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.wishlist_wishlist,
            style: const TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: app.wishlist.isEmpty
          ? EmptyState(
              icon: Icons.star_outline_rounded,
              message: l10n.wishlist_noItems,
              subMessage: l10n.wishlist_noItemsSub)
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 110),
              itemCount: app.wishlist.length,
              itemBuilder: (_, i) => _WishCard(item: app.wishlist[i], fmt: fmt),
            ),
      floatingActionButton: FintechFab(
        tooltip: l10n.wishlist_addItem,
        onPressed: () => _openSheet(context),
      ),
    );
  }

  static void _openSheet(BuildContext ctx, {WishlistItem? existing}) async {
    final result = await showModalBottomSheet<(String, VoidCallback)?>(
      context: ctx,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _WishSheet(existing: existing),
    );
    if (result != null && ctx.mounted) {
      final l10n = AppLocalizations.of(ctx)!;
      showAppSnackbar(
        ctx,
        l10n.common_itemDeleted(result.$1),
        onUndo: result.$2,
      );
    }
  }
}

class _WishCard extends StatelessWidget {
  final WishlistItem item;
  final String Function(double) fmt;
  const _WishCard({required this.item, required this.fmt});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final pColor = _priorityColor(item.priority);

    final goal = app.goalForWishlist(item);
    final hasGoal = goal != null;
    final isAchieved = hasGoal &&
        ((goal.currentAmount >= goal.targetAmount && goal.targetAmount > 0) ||
            goal.isCompleted);
    final progress = hasGoal && goal.targetAmount > 0
        ? (goal.currentAmount / goal.targetAmount).clamp(0.0, 1.0)
        : 0.0;
    final percent = (progress * 100).toInt();

    final showCelebrationBorder = isAchieved && !item.isPurchased;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: showCelebrationBorder
            ? const Color(0xFF2E7D32).withValues(alpha: isDark ? 0.12 : 0.08)
            : cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: showCelebrationBorder
              ? const Color(0xFF2E7D32)
              : (isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05)),
          width: showCelebrationBorder ? 1.5 : 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    AppHaptics.tap(context, HapticStrength.light);
                    if (item.isPurchased) {
                      app.updateWishlist(item.copyWith(isPurchased: false));
                    } else {
                      _showPurchaseDialog(context, item, fmt);
                    }
                  },
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: item.isPurchased
                          ? const Color(0xFF2E7D32).withValues(alpha: 0.15)
                          : (showCelebrationBorder
                              ? const Color(0xFF2E7D32).withValues(alpha: 0.15)
                              : cs.surfaceContainerHigh),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item.isPurchased
                          ? Icons.check_circle_rounded
                          : (showCelebrationBorder
                              ? Icons.celebration_rounded
                              : Icons.circle_outlined),
                      color: item.isPurchased || showCelebrationBorder
                          ? const Color(0xFF2E7D32)
                          : cs.onSurface.withValues(alpha: 0.35),
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          decoration: item.isPurchased
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: pColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              item.priority.toUpperCase(),
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: pColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            fmt(item.targetPrice),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      if (item.notes.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          item.notes,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            color: cs.onSurface.withValues(alpha: 0.55),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      padding: EdgeInsets.zero,
                      constraints:
                          const BoxConstraints(minWidth: 32, minHeight: 32),
                      onPressed: () =>
                          WishlistScreen._openSheet(context, existing: item),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outline_rounded,
                          size: 18, color: cs.error),
                      padding: EdgeInsets.zero,
                      constraints:
                          const BoxConstraints(minWidth: 32, minHeight: 32),
                      onPressed: () async {
                        AppHaptics.tap(context, HapticStrength.medium);
                        final undo = await context
                            .read<AppProvider>()
                            .deleteWishlistWithUndo(item.id);
                        if (context.mounted) {
                          showAppSnackbar(
                              context, l10n.common_itemDeleted(item.name),
                              onUndo: undo);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            if (!item.isPurchased) ...[
              if (showCelebrationBorder) ...[
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.celebration_rounded,
                          size: 16, color: Color(0xFF2E7D32)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          l10n.wishlist_goalAchieved,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ),
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () =>
                            _showPurchaseDialog(context, item, fmt),
                        icon:
                            const Icon(Icons.shopping_bag_outlined, size: 13),
                        label: Text(l10n.wishlist_buyNow,
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
              ],
              if (hasGoal) ...[
                const SizedBox(height: 10),
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    AppHaptics.tap(context, HapticStrength.light);
                    Navigator.push(
                      context,
                      ExpensyRoute(
                        builder: (_) => SavingsGoalDetailScreen(goal: goal),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.savings_outlined,
                                    size: 14, color: Color(0xFF2E7D32)),
                                const SizedBox(width: 5),
                                Text(
                                  l10n.wishlist_funded(
                                    percent,
                                    fmt(goal.currentAmount),
                                    fmt(goal.targetAmount),
                                  ),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        cs.onSurface.withValues(alpha: 0.8),
                                  ),
                                ),
                              ],
                            ),
                            Icon(Icons.chevron_right_rounded,
                                size: 16,
                                color: cs.onSurface.withValues(alpha: 0.4)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 6,
                            color: isAchieved
                                ? const Color(0xFF2E7D32)
                                : Color(goal.colorValue),
                            backgroundColor: (isAchieved
                                    ? const Color(0xFF2E7D32)
                                    : Color(goal.colorValue))
                                .withValues(alpha: 0.15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF2E7D32),
                        side: const BorderSide(
                            color: Color(0xFF2E7D32), width: 1.2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        AppHaptics.tap(context, HapticStrength.light);
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24))),
                          builder: (_) => SavingsGoalSheet(
                            initialName: item.name,
                            initialTargetAmount: item.targetPrice,
                            wishlistItemId: item.id,
                          ),
                        );
                      },
                      icon: const Icon(Icons.savings_outlined, size: 14),
                      label: Text(
                        l10n.wishlist_fundThisItem,
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Color _priorityColor(String p) {
    switch (p) {
      case 'high':
        return const Color(0xFFC62828);
      case 'medium':
        return const Color(0xFFE65100);
      default:
        return const Color(0xFF2E7D32);
    }
  }
}

void _showPurchaseDialog(
  BuildContext context,
  WishlistItem item,
  String Function(double) fmt,
) {
  final app = context.read<AppProvider>();
  final l10n = AppLocalizations.of(context)!;
  final cs = Theme.of(context).colorScheme;

  final spendingAccounts = app.accounts.where((a) => !a.isGold).toList();
  String? selectedAccountId = spendingAccounts.isNotEmpty
      ? (spendingAccounts
              .where((a) => a.type == 'bank' || a.type == 'cash')
              .firstOrNull
              ?.id ??
          spendingAccounts.first.id)
      : null;

  final expenseCategories =
      app.categories.where((c) => c.type == 'expense').toList();
  String? selectedCategoryId = expenseCategories.isNotEmpty
      ? (expenseCategories
              .where((c) => c.name.toLowerCase().contains('shop'))
              .firstOrNull
              ?.id ??
          expenseCategories.first.id)
      : null;

  final amountCtrl = TextEditingController(
      text: item.targetPrice > 0
          ? item.targetPrice.toStringAsFixed(2).replaceAll('.00', '')
          : '');
  bool showPurchaseKeypad = false;

  showDialog(
    context: context,
    builder: (dialogCtx) {
      return StatefulBuilder(
        builder: (ctx, setDialogState) {
          return AlertDialog(
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32).withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.shopping_bag_outlined,
                      color: Color(0xFF2E7D32), size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.wishlist_purchaseTitle,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.wishlist_purchasePrompt,
                    style: TextStyle(
                      fontSize: 13,
                      color: cs.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (spendingAccounts.isNotEmpty) ...[
                    DropdownButtonFormField<String>(
                      initialValue: selectedAccountId,
                      decoration: InputDecoration(
                        labelText: l10n.recurring_account,
                        prefixIcon:
                            const Icon(Icons.account_balance_wallet_outlined),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      items: spendingAccounts.map((a) {
                        return DropdownMenuItem(
                          value: a.id,
                          child: Text(
                            '${a.name} (${formatAmount(a.balance, a.currency)})',
                            style: const TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setDialogState(() => selectedAccountId = val);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: amountCtrl,
                      readOnly: true,
                      showCursor: true,
                      onTap: () {
                        setDialogState(() => showPurchaseKeypad = true);
                      },
                      decoration: InputDecoration(
                        labelText: l10n.loans_amount,
                        prefixIcon: const Icon(Icons.attach_money_rounded),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        suffixIcon: showPurchaseKeypad
                            ? IconButton(
                                icon: const Icon(Icons.keyboard_hide_outlined),
                                onPressed: () => setDialogState(
                                    () => showPurchaseKeypad = false),
                              )
                            : null,
                      ),
                    ),
                    if (showPurchaseKeypad) ...[
                      const SizedBox(height: 8),
                      AppNumericKeypad(
                        compact: true,
                        controller: amountCtrl,
                        onDone: () =>
                            setDialogState(() => showPurchaseKeypad = false),
                      ),
                    ],
                    const SizedBox(height: 12),
                    if (expenseCategories.isNotEmpty)
                      DropdownButtonFormField<String>(
                        initialValue: selectedCategoryId,
                        decoration: InputDecoration(
                          labelText: l10n.recurring_category,
                          prefixIcon: const Icon(Icons.category_outlined),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        items: expenseCategories.map((c) {
                          return DropdownMenuItem(
                            value: c.id,
                            child: Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Color(c.colorValue),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(c.name,
                                    style: const TextStyle(fontSize: 13)),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setDialogState(() => selectedCategoryId = val);
                          }
                        },
                      ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogCtx),
                child: Text(l10n.shared_widgets_cancel),
              ),
              TextButton(
                onPressed: () async {
                  AppHaptics.tap(context, HapticStrength.light);
                  Navigator.pop(dialogCtx);
                  await app.purchaseWishlistItem(item: item);
                  if (context.mounted) {
                    showAppSnackbar(
                        context, l10n.wishlist_itemPurchased(item.name));
                  }
                },
                child: Text(l10n.wishlist_markPurchasedOnly),
              ),
              if (spendingAccounts.isNotEmpty)
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                  ),
                  onPressed: () async {
                    AppHaptics.tap(context, HapticStrength.medium);
                    Navigator.pop(dialogCtx);
                    final amt =
                        double.tryParse(amountCtrl.text) ?? item.targetPrice;
                    await app.purchaseWishlistItem(
                      item: item,
                      accountId: selectedAccountId,
                      categoryId: selectedCategoryId,
                      amount: amt,
                    );
                    if (context.mounted) {
                      showAppSnackbar(
                          context, l10n.wishlist_itemPurchased(item.name));
                    }
                  },
                  child: Text(l10n.wishlist_recordAndDeduct),
                ),
            ],
          );
        },
      );
    },
  );
}

class _WishSheet extends StatefulWidget {
  final WishlistItem? existing;
  const _WishSheet({this.existing});
  @override
  State<_WishSheet> createState() => _WishSheetState();
}

class _WishSheetState extends State<_WishSheet> {
  final _nameCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String _priority = 'medium';
  bool _submitted = false;
  bool _showKeypad = false;

  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      _nameCtrl.text = e.name;
      _priceCtrl.text = e.targetPrice.toStringAsFixed(2);
      _notesCtrl.text = e.notes;
      _priority = e.priority;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (_nameCtrl.text.trim().isEmpty) return;
    final price = double.tryParse(_priceCtrl.text) ?? 0;
    final app = context.read<AppProvider>();
    if (isEdit) {
      await app.updateWishlist(widget.existing!.copyWith(
        name: _nameCtrl.text.trim(),
        targetPrice: price,
        priority: _priority,
        notes: _notesCtrl.text.trim(),
      ));
    } else {
      await app.addWishlist(WishlistItem(
        id: app.newId(),
        name: _nameCtrl.text.trim(),
        targetPrice: price,
        priority: _priority,
        notes: _notesCtrl.text.trim(),
      ));
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final l10n = AppLocalizations.of(context)!;
    final sym = currencyInfo(app.settings.currency).symbol;
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 16,
          left: 20,
          right: 20,
          top: 20),
      child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        isEdit
                            ? l10n.wishlist_editItem
                            : l10n.wishlist_addWishlistItem,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    if (isEdit)
                      IconButton(
                        icon: Icon(Icons.delete_outline_rounded,
                            color: Theme.of(context).colorScheme.error),
                        onPressed: () async {
                          AppHaptics.tap(context, HapticStrength.medium);
                          final navigator = Navigator.of(context);
                          final item = widget.existing!;
                          final undo = await context
                              .read<AppProvider>()
                              .deleteWishlistWithUndo(item.id);
                          navigator.pop((item.name, undo));
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _nameCtrl,
                  textInputAction: TextInputAction.next,
                  onTap: () {
                    if (_showKeypad) setState(() => _showKeypad = false);
                  },
                  decoration: InputDecoration(
                    labelText: l10n.wishlist_itemName,
                    prefixIcon: const Icon(Icons.star_outline_rounded),
                    errorText: _submitted && _nameCtrl.text.trim().isEmpty
                        ? l10n.error_required
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _priceCtrl,
                  readOnly: true,
                  showCursor: true,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    setState(() => _showKeypad = true);
                  },
                  decoration: InputDecoration(
                    labelText: l10n.wishlist_targetPrice,
                    prefixText: '$sym ',
                    suffixIcon: _showKeypad
                        ? IconButton(
                            icon: const Icon(Icons.keyboard_hide_outlined),
                            onPressed: () =>
                                setState(() => _showKeypad = false),
                          )
                        : null,
                    errorText: _submitted &&
                            (double.tryParse(_priceCtrl.text) ?? 0) <= 0
                        ? l10n.error_required
                        : null,
                  ),
                ),
                if (_showKeypad &&
                    MediaQuery.of(context).viewInsets.bottom < 100) ...[
                  const SizedBox(height: 8),
                  AppNumericKeypad(
                    compact: true,
                    controller: _priceCtrl,
                    onChanged: (_) => setState(() {}),
                    onDone: () => setState(() => _showKeypad = false),
                  ),
                ],
                const SizedBox(height: 14),
                Text(l10n.wishlist_priority,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(letterSpacing: 1)),
                const SizedBox(height: 8),
                Row(children: [
                  for (final p in [
                    ('low', l10n.wishlist_priorityLow, 0xFF2E7D32),
                    ('medium', l10n.wishlist_priorityMedium, 0xFFE65100),
                    ('high', l10n.wishlist_priorityHigh, 0xFFC62828)
                  ])
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => _priority = p.$1),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          decoration: BoxDecoration(
                              color: _priority == p.$1
                                  ? Color(p.$3)
                                  : Color(p.$3).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(p.$2,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: _priority == p.$1
                                          ? Colors.white
                                          : Color(p.$3)))),
                        ),
                      ),
                    )),
                ]),
                const SizedBox(height: 12),
                TextField(
                    controller: _notesCtrl,
                    maxLines: 2,
                    textInputAction: TextInputAction.done,
                    onTap: () {
                      if (_showKeypad) setState(() => _showKeypad = false);
                    },
                    onSubmitted: (_) => _submit(),
                    decoration: InputDecoration(
                        labelText: l10n.wishlist_notesOptional,
                        prefixIcon: const Icon(Icons.sticky_note_2_outlined))),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () {
                    AppHaptics.tap(context, HapticStrength.light);
                    _submit();
                  },
                  style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28))),
                  child: Text(isEdit
                      ? l10n.wishlist_saveChanges
                      : l10n.wishlist_addItem),
                ),
              ]),
        ),
    );
  }
}
