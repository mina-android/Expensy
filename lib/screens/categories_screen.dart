// lib/screens/categories_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../widgets/shared_widgets.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;

    final expenses =
        app.categories.where((c) => c.type == 'expense').toList().cast<Category>();
    final incomes =
        app.categories.where((c) => c.type == 'income').toList().cast<Category>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories',
            style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        bottom: TabBar(
          controller: _tab,
          labelColor: cs.onPrimary,
          unselectedLabelColor: cs.onPrimary.withValues(alpha: 0.6),
          indicatorColor: cs.onPrimary,
          tabs: const [Tab(text: 'Expense'), Tab(text: 'Income')],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _CatGrid(cats: expenses, type: 'expense', app: app),
          _CatGrid(cats: incomes,  type: 'income',  app: app),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSheet(context, app,
            type: _tab.index == 0 ? 'expense' : 'income'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showSheet(BuildContext ctx, AppProvider app,
      {required String type}) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _CategorySheet(app: app, type: type),
    );
  }
}

// ─── Grid ─────────────────────────────────────────────────────────────────
class _CatGrid extends StatelessWidget {
  final List<Category> cats;
  final String type;
  final AppProvider app;
  const _CatGrid(
      {required this.cats, required this.type, required this.app});

  @override
  Widget build(BuildContext context) {
    if (cats.isEmpty) {
      return EmptyState(
        icon: Icons.label_outline_rounded,
        message: 'No $type categories',
        subMessage: 'Tap + to add one',
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.all(14),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.2,
      ),
      itemCount: cats.length,
      itemBuilder: (_, i) => _CatChip(cat: cats[i], app: app),
    );
  }
}

class _CatChip extends StatelessWidget {
  final Category cat;
  final AppProvider app;
  const _CatChip({required this.cat, required this.app});

  @override
  Widget build(BuildContext context) {
    final color = Color(cat.colorValue);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Container(
                width: 12, height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(cat.name,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                overflow: TextOverflow.ellipsis),
          ),
          // Edit button
          GestureDetector(
            onTap: () => _showEditSheet(context, cat, app),
            child: Icon(Icons.edit_outlined, size: 16,
                color: color.withValues(alpha: 0.8)),
          ),
          const SizedBox(width: 8),
          // Delete button (all categories can be deleted)
          GestureDetector(
            onTap: () async {
              final ok = await showDeleteConfirm(context, cat.name);
              if (ok && context.mounted) app.deleteCategory(cat.id);
            },
            child: Icon(Icons.close_rounded, size: 16,
                color: Colors.grey.withValues(alpha: 0.7)),
          ),
        ]),
      ),
    );
  }

  void _showEditSheet(BuildContext ctx, Category cat, AppProvider app) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _CategoryEditSheet(app: app, cat: cat),
    );
  }
}

// ─── Add sheet ────────────────────────────────────────────────────────────
class _CategorySheet extends StatefulWidget {
  final AppProvider app;
  final String type;
  const _CategorySheet({required this.app, required this.type});

  @override
  State<_CategorySheet> createState() => _CategorySheetState();
}

class _CategorySheetState extends State<_CategorySheet> {
  final _nameCtrl = TextEditingController();
  int _color = 0xFFE53935;

  static const _colors = [
    0xFFE53935, 0xFFFB8C00, 0xFF8E24AA, 0xFF1E88E5,
    0xFF00897B, 0xFF43A047, 0xFF5D4037, 0xFF2E7D32,
    0xFF1565C0, 0xFFF57F17, 0xFF6750A4, 0xFF37474F,
    0xFFE65100, 0xFF0277BD, 0xFF546E7A,
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_nameCtrl.text.trim().isEmpty) return;
    await widget.app.addCategory(Category(
      id:         widget.app.newId(),
      name:       _nameCtrl.text.trim(),
      type:       widget.type,
      colorValue: _color,
    ));
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final typeCap =
        widget.type[0].toUpperCase() + widget.type.substring(1);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 20, right: 20, top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add $typeCap Category',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(
              labelText: 'Category Name',
              prefixIcon: Icon(Icons.label_outline_rounded),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Colour',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(letterSpacing: 1),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _colors.map((c) {
              return GestureDetector(
                onTap: () => setState(() => _color = c),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 80),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Color(c),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _color == c
                          ? Theme.of(context).colorScheme.onSurface
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.add),
            label: const Text('Add Category'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28)),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Edit sheet ───────────────────────────────────────────────────────────
class _CategoryEditSheet extends StatefulWidget {
  final AppProvider app;
  final Category cat;
  const _CategoryEditSheet({required this.app, required this.cat});

  @override
  State<_CategoryEditSheet> createState() => _CategoryEditSheetState();
}

class _CategoryEditSheetState extends State<_CategoryEditSheet> {
  late TextEditingController _nameCtrl;
  late int _color;

  static const _colors = [
    0xFFE53935, 0xFFFB8C00, 0xFF8E24AA, 0xFF1E88E5,
    0xFF00897B, 0xFF43A047, 0xFF5D4037, 0xFF2E7D32,
    0xFF1565C0, 0xFFF57F17, 0xFF6750A4, 0xFF37474F,
    0xFFE65100, 0xFF0277BD, 0xFF546E7A,
  ];

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.cat.name);
    _color    = widget.cat.colorValue;
  }

  @override
  void dispose() { _nameCtrl.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (_nameCtrl.text.trim().isEmpty) return;
    final updated = widget.cat.copyWith(
      name: _nameCtrl.text.trim(),
      colorValue: _color,
    );
    await widget.app.updateCategory(updated);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 20, right: 20, top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Edit Category',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 18),
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(
              labelText: 'Category Name',
              prefixIcon: Icon(Icons.label_outline_rounded),
            ),
          ),
          const SizedBox(height: 16),
          Text('Colour',
              style: Theme.of(context).textTheme.labelMedium
                  ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10, runSpacing: 10,
            children: _colors.map((c) => GestureDetector(
              onTap: () => setState(() => _color = c),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 80),
                width: 32, height: 32,
                decoration: BoxDecoration(
                  color: Color(c),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _color == c
                        ? Theme.of(context).colorScheme.onSurface
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
            )).toList(),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Save Changes'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28)),
            ),
          ),
        ],
      ),
    );
  }
}
