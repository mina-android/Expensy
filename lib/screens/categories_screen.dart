// lib/screens/categories_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../widgets/shared_widgets.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    final expenses = app.categories.where((c) => c.type == 'expense').toList();
    final incomes  = app.categories.where((c) => c.type == 'income').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
        children: [
          const SectionHeader(title: 'Expense Categories'),
          ...expenses.map((c) => _CatTile(cat: c)),
          const SectionHeader(title: 'Income Categories'),
          ...incomes.map((c) => _CatTile(cat: c)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => _openSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  static void _openSheet(BuildContext context, {AppCategory? existing}) {
    showModalBottomSheet(
      context: context, isScrollControlled: true, useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _CategorySheet(existing: existing),
    );
  }
}

class _CatTile extends StatelessWidget {
  final AppCategory cat;
  const _CatTile({required this.cat});
  @override
  Widget build(BuildContext context) {
    final cs    = Theme.of(context).colorScheme;
    final color = Color(cat.colorValue);
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        leading: Container(
          width: 36, height: 36,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10)),
          child: Icon(Icons.label_outline_rounded, color: color, size: 18),
        ),
        title: Text(cat.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(cat.type == 'expense' ? 'Expense' : 'Income',
            style: TextStyle(fontSize: 11,
                color: cs.onSurface.withValues(alpha: 0.5))),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(icon: const Icon(Icons.edit_outlined, size: 18),
              onPressed: () => CategoriesScreen._openSheet(context, existing: cat)),
          IconButton(icon: Icon(Icons.delete_outline_rounded, size: 18,
              color: cs.error),
              onPressed: () async {
                if (await showDeleteConfirm(context, cat.name) && context.mounted) {
                  context.read<AppProvider>().deleteCategory(cat.id);
                }
              }),
        ]),
      ),
    );
  }
}

const List<int> _kCatColors = [
  0xFF6750A4, 0xFF1565C0, 0xFF2E7D32, 0xFFE65100,
  0xFF00897B, 0xFFC62828, 0xFF37474F, 0xFF7D5260,
  0xFF0077B6, 0xFF9C27B0, 0xFF00BFA5, 0xFFF9A825,
];

class _CategorySheet extends StatefulWidget {
  final AppCategory? existing;
  const _CategorySheet({this.existing});
  @override
  State<_CategorySheet> createState() => _CategorySheetState();
}

class _CategorySheetState extends State<_CategorySheet> {
  final _nameCtrl = TextEditingController();
  String _type  = 'expense';
  int    _color = 0xFF6750A4;
  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      _nameCtrl.text = e.name;
      _type  = e.type;
      _color = e.colorValue;
    }
  }

  @override
  void dispose() { _nameCtrl.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (_nameCtrl.text.trim().isEmpty) return;
    final app = context.read<AppProvider>();
    if (isEdit) {
      await app.updateCategory(
          widget.existing!.copyWith(name: _nameCtrl.text.trim(), colorValue: _color));
    } else {
      await app.addCategory(AppCategory(
        id: app.newId(), name: _nameCtrl.text.trim(),
        type: _type, colorValue: _color,
      ));
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 20, right: 20, top: 20),
      child: Column(mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(isEdit ? 'Edit Category' : 'Add Category',
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        TextField(controller: _nameCtrl,
            decoration: const InputDecoration(labelText: 'Category Name',
                prefixIcon: Icon(Icons.label_outline_rounded))),
        const SizedBox(height: 14),
        if (!isEdit)
          Row(children: [
            Expanded(child: GestureDetector(
              onTap: () => setState(() => _type = 'expense'),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 140),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _type == 'expense'
                      ? const Color(0xFFC62828) : const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text('Expense',
                    style: TextStyle(fontWeight: FontWeight.w700,
                        color: _type == 'expense'
                            ? Colors.white : const Color(0xFFC62828)))),
              ),
            )),
            const SizedBox(width: 10),
            Expanded(child: GestureDetector(
              onTap: () => setState(() => _type = 'income'),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 140),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _type == 'income'
                      ? const Color(0xFF2E7D32) : const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text('Income',
                    style: TextStyle(fontWeight: FontWeight.w700,
                        color: _type == 'income'
                            ? Colors.white : const Color(0xFF2E7D32)))),
              ),
            )),
          ]),
        const SizedBox(height: 14),
        Text('Colour', style: Theme.of(context).textTheme.labelMedium
            ?.copyWith(letterSpacing: 1)),
        const SizedBox(height: 8),
        Wrap(spacing: 10, runSpacing: 10, children: _kCatColors.map((col) =>
          GestureDetector(
            onTap: () => setState(() => _color = col),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 80),
              width: 32, height: 32,
              decoration: BoxDecoration(color: Color(col), shape: BoxShape.circle,
                  border: Border.all(
                      color: _color == col ? cs.onSurface : Colors.transparent,
                      width: 3)),
            ),
          ),
        ).toList()),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: _submit,
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))),
          child: Text(isEdit ? 'Save Changes' : 'Add Category'),
        ),
      ]),
    );
  }
}
