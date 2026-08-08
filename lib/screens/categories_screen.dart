// lib/screens/categories_screen.dart
import 'package:flutter/material.dart';
import '../utils/snackbar.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../widgets/shared_widgets.dart';
import '../utils/haptics.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    final expenses = app.categories.where((c) => c.type == 'expense').toList();
    final incomes = app.categories.where((c) => c.type == 'income').toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.categories_categories,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
        children: [
          SectionHeader(title: l10n.categories_expenseCategories),
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: expenses.length,
            onReorderStart: (_) =>
                AppHaptics.tap(context, HapticStrength.heavy),
            onReorderItem: (oldIndex, newIndex) {
              AppHaptics.tap(context, HapticStrength.light);
              app.reorderCategories(oldIndex, newIndex, 'expense');
            },
            itemBuilder: (context, i) => Container(
              key: ValueKey(expenses[i].id),
              child: _CatTile(cat: expenses[i]),
            ),
          ),
          const SizedBox(height: 16),
          SectionHeader(title: l10n.categories_incomeCategories),
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: incomes.length,
            onReorderStart: (_) =>
                AppHaptics.tap(context, HapticStrength.heavy),
            onReorderItem: (oldIndex, newIndex) {
              AppHaptics.tap(context, HapticStrength.light);
              app.reorderCategories(oldIndex, newIndex, 'income');
            },
            itemBuilder: (context, i) => Container(
              key: ValueKey(incomes[i].id),
              child: _CatTile(cat: incomes[i]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          AppHaptics.tap(context, HapticStrength.light);
          _openSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  static void _openSheet(BuildContext context, {AppCategory? existing}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _CategorySheet(existing: existing),
    );
  }
}

// ── Category tile ─────────────────────────────────────────────────────────────
class _CatTile extends StatelessWidget {
  final AppCategory cat;
  const _CatTile({required this.cat});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        leading: CategoryDot(category: cat, size: 36),
        title:
            Text(cat.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
            cat.type == 'expense'
                ? l10n.categories_expenseLabel
                : l10n.categories_incomeLabel,
            style: TextStyle(
                fontSize: 11, color: cs.onSurface.withValues(alpha: 0.5))),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
              icon: const Icon(Icons.edit_outlined, size: 18),
              onPressed: () =>
                  CategoriesScreen._openSheet(context, existing: cat)),
          IconButton(
              icon:
                  Icon(Icons.delete_outline_rounded, size: 18, color: cs.error),
              onPressed: () async {
                final undo = await context
                    .read<AppProvider>()
                    .deleteCategoryWithUndo(cat.id);
                if (context.mounted) {
                  showAppSnackbar(context, '${cat.name} deleted', onUndo: undo);
                }
              }),
        ]),
      ),
    );
  }
}

// ── Color palette ────────────────────────────────────────────────────────────
const List<int> _kCatColors = [
  // Purples & violets
  0xFF6750A4, 0xFF4527A0, 0xFF6A1B9A, 0xFF880E4F, 0xFF7D5260,
  // Blues
  0xFF1565C0, 0xFF0D47A1, 0xFF283593, 0xFF0077B6, 0xFF006064,
  // Teals & cyans
  0xFF00695C, 0xFF00897B, 0xFF00838F, 0xFF006874, 0xFF004D40,
  // Greens
  0xFF2E7D32, 0xFF1B5E20, 0xFF33691E, 0xFF558B2F, 0xFF827717,
  // Reds & pinks
  0xFFC62828, 0xFFB71C1C, 0xFFAD1457, 0xFF9C4257, 0xFF7B1FA2,
  // Oranges & ambers
  0xFFE65100, 0xFFBF360C, 0xFFD84315, 0xFFF57F17, 0xFFF9A825,
  // Browns & warm neutrals
  0xFF4E342E, 0xFF5D4037, 0xFF6D4C41, 0xFF795548, 0xFF8D6E63,
  // Slates & grays
  0xFF37474F, 0xFF455A64, 0xFF546E7A, 0xFF263238, 0xFF9E9E9E,
];

// ── Sheet ─────────────────────────────────────────────────────────────────────
class _CategorySheet extends StatefulWidget {
  final AppCategory? existing;
  const _CategorySheet({this.existing});
  @override
  State<_CategorySheet> createState() => _CategorySheetState();
}

class _CategorySheetState extends State<_CategorySheet> {
  final _nameCtrl = TextEditingController();
  String _type = 'expense';
  int _color = 0xFF6750A4;
  // Stores a 1-based index into kCategoryIconOptions.
  // 0 = auto (name-based heuristic). Never store a raw IconData.codePoint here
  // because reconstructing IconData at runtime breaks release tree-shaking.
  int _iconIndex = 1;
  bool _submitted = false;

  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      _nameCtrl.text = e.name;
      _type = e.type;
      _color = e.colorValue;
      _iconIndex = e.iconCodePoint; // field repurposed as 1-based index
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  /// Returns the icon to display for the current selection.
  /// Uses only compile-time-constant IconData values — tree-shaking safe.
  IconData get _previewIcon {
    if (_iconIndex > 0 && _iconIndex <= kCategoryIconOptions.length) {
      return kCategoryIconOptions[_iconIndex - 1].icon;
    }
    return Icons.label_outline_rounded; // safe fallback constant
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (_nameCtrl.text.trim().isEmpty) return;
    final app = context.read<AppProvider>();
    if (isEdit) {
      await app.updateCategory(widget.existing!.copyWith(
        name: _nameCtrl.text.trim(),
        colorValue: _color,
        iconCodePoint: _iconIndex, // 1-based index stored as iconCodePoint
      ));
    } else {
      await app.addCategory(AppCategory(
        id: app.newId(),
        name: _nameCtrl.text.trim(),
        type: _type,
        colorValue: _color,
        iconCodePoint: _iconIndex,
      ));
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

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
              // ── Title + live preview ────────────────────────────────────
              Row(children: [
                Expanded(
                  child: Text(
                      isEdit
                          ? l10n.categories_editCategory
                          : l10n.categories_addCategory,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w800)),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(_color).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(_previewIcon, color: Color(_color), size: 20),
                    if (_nameCtrl.text.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      Text(_nameCtrl.text,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(_color),
                              fontSize: 13)),
                    ],
                  ]),
                ),
              ]),
              const SizedBox(height: 16),

              // ── Name ────────────────────────────────────────────────────
              TextField(
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                controller: _nameCtrl,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  labelText: l10n.categories_categoryName,
                  prefixIcon: const Icon(Icons.label_outline_rounded),
                  errorText: _submitted && _nameCtrl.text.trim().isEmpty
                      ? l10n.error_required
                      : null,
                ),
              ),
              const SizedBox(height: 14),

              // ── Type (add only) ─────────────────────────────────────────
              if (!isEdit)
                Row(children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () => setState(() => _type = 'expense'),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: _type == 'expense'
                              ? const Color(0xFFC62828)
                              : const Color(0xFFFFEBEE),
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text(l10n.categories_expense,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: _type == 'expense'
                                      ? Colors.white
                                      : const Color(0xFFC62828)))),
                    ),
                  )),
                  const SizedBox(width: 10),
                  Expanded(
                      child: GestureDetector(
                    onTap: () => setState(() => _type = 'income'),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: _type == 'income'
                              ? const Color(0xFF2E7D32)
                              : const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text(l10n.categories_income,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: _type == 'income'
                                      ? Colors.white
                                      : const Color(0xFF2E7D32)))),
                    ),
                  )),
                ]),

              const SizedBox(height: 14),

              // ── Color ─────────────────────────────────────────────────
              Text(l10n.categories_color,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(letterSpacing: 1)),
              const SizedBox(height: 8),
              Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _kCatColors
                      .map(
                        (col) => GestureDetector(
                          onTap: () => setState(() => _color = col),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 60),
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                color: Color(col),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: _color == col
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                        : Colors.transparent,
                                    width: 3)),
                          ),
                        ),
                      )
                      .toList()),
              const SizedBox(height: 16),

              // ── Icon picker ─────────────────────────────────────────────
              Text(l10n.categories_icon,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(letterSpacing: 1)),
              const SizedBox(height: 8),

              // "Auto" chip
              GestureDetector(
                onTap: () => setState(() => _iconIndex = 0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  margin: const EdgeInsets.only(bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: _iconIndex == 0
                        ? cs.primaryContainer
                        : cs.surfaceContainerHighest.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color:
                            _iconIndex == 0 ? cs.primary : Colors.transparent),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.auto_awesome_outlined,
                        size: 16,
                        color: _iconIndex == 0
                            ? cs.primary
                            : cs.onSurface.withValues(alpha: 0.5)),
                    const SizedBox(width: 8),
                    Text(l10n.categories_autoBasedOnName,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _iconIndex == 0
                                ? cs.primary
                                : cs.onSurface.withValues(alpha: 0.5))),
                  ]),
                ),
              ),

              // Icon grid — uses kCategoryIconOptions from shared_widgets.dart.
              // _iconIndex is 1-based (matches position in the list + 1).
              // No IconData(...) call anywhere — all icons are compile-time constants.
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                ),
                itemCount: kCategoryIconOptions.length,
                itemBuilder: (_, i) {
                  final opt = kCategoryIconOptions[i];
                  final oneBasedIndex = i + 1;
                  final selected = _iconIndex == oneBasedIndex;
                  return Tooltip(
                    message: opt.label,
                    child: GestureDetector(
                      onTap: () => setState(() => _iconIndex = oneBasedIndex),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        decoration: BoxDecoration(
                          color: selected
                              ? Color(_color)
                              : Color(_color).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: selected
                                  ? Color(_color)
                                  : Color(_color).withValues(alpha: 0.3)),
                        ),
                        // opt.icon is a compile-time constant — tree-shaking safe ✓
                        child: Icon(opt.icon,
                            size: 20,
                            color: selected
                                ? Colors.white
                                : Color(_color).withValues(alpha: 0.7)),
                      ),
                    ),
                  );
                },
              ),

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
                    ? l10n.categories_saveChanges
                    : l10n.categories_addCategory),
              ),
            ]),
      ),
    );
  }
}

