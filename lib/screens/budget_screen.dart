// lib/screens/budget_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    final cur = app.settings.currency;

    final overCount = app.budgets.where(app.budgetExceeded).length;
    final totalBudgeted = app.budgets.fold(0.0, (s, b) => s + b.amount);
    final totalSpent    = app.budgets.fold(0.0, (s, b) => s + app.budgetSpent(b));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.budget_budgets, style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: app.budgets.isEmpty
          ? EmptyState(
              icon: Icons.account_balance_wallet_outlined,
              message: l10n.budget_noBudgetsYet,
              subMessage: l10n.budget_tapToAddBudget)
          : Column(children: [
              // ── Summary strip ───────────────────────────────────────
              Container(
                color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(children: [
                  _SumChip(
                    label: l10n.budget_budgeted,
                    value: formatAmount(totalBudgeted, cur),
                    color: cs.primary,
                  ),
                  const SizedBox(width: 8),
                  _SumChip(
                    label: l10n.budget_spent,
                    value: formatAmount(totalSpent, cur),
                    color: totalSpent > totalBudgeted
                        ? cs.error
                        : const Color(0xFF2E7D32),
                  ),
                  const SizedBox(width: 8),
                  if (overCount > 0)
                    _SumChip(
                      label: l10n.budget_overLimit,
                      value: '$overCount',
                      color: cs.error,
                    ),
                ]),
              ),
              // ── Budget list ─────────────────────────────────────────
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 100),
                  itemCount: app.budgets.length,
                  itemBuilder: (_, i) => _BudgetCard(
                    budget: app.budgets[i], app: app,
                  ),
                ),
              ),
            ]),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => _openSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  static void _openSheet(BuildContext context, {Budget? existing}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _BudgetSheet(existing: existing),
    );
  }
}

// ── Summary chip ──────────────────────────────────────────────────────────────
class _SumChip extends StatelessWidget {
  final String label, value;
  final Color color;
  const _SumChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withValues(alpha: 0.25)),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label,
                style: TextStyle(
                    fontSize: 10, fontWeight: FontWeight.w600, color: color)),
            const SizedBox(height: 1),
            Text(value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w800, color: color)),
          ]),
        ),
      );
}

// ── Budget card ───────────────────────────────────────────────────────────────
class _BudgetCard extends StatelessWidget {
  final Budget budget;
  final AppProvider app;
  const _BudgetCard({required this.budget, required this.app});

  Color _barColor(double progress, ColorScheme cs) {
    if (progress >= 1.0) return cs.error;
    if (progress >= 0.75) return Colors.orange;
    return cs.primary;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs       = Theme.of(context).colorScheme;
    final cat      = app.categoryById(budget.categoryId);
    final spent    = app.budgetSpent(budget);
    final progress = app.budgetProgress(budget);
    final exceeded = app.budgetExceeded(budget);
    final barColor = _barColor(progress, cs);
    final cur      = app.settings.currency;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => BudgetScreen._openSheet(context, existing: budget),
        onLongPress: () async {
          if (await showDeleteConfirm(context, cat?.name ?? l10n.budget_budget) &&
              context.mounted) {
            context.read<AppProvider>().deleteBudget(budget.id);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              CategoryDot(category: cat, size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(cat?.name ?? l10n.budget_unknown,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15)),
                  Row(children: [
                    Text(
                      budget.period == 'weekly' ? l10n.budget_weeklyLabel : l10n.budget_monthlyLabel,
                      style: TextStyle(
                          fontSize: 11,
                          color: cs.onSurface.withValues(alpha: 0.5)),
                    ),
                    Text(l10n.budget_empty,
                        style: TextStyle(
                            color: cs.onSurface.withValues(alpha: 0.3))),
                    Text(
                      formatAmount(budget.amount, cur),
                      style: TextStyle(
                          fontSize: 11,
                          color: cs.onSurface.withValues(alpha: 0.5)),
                    ),
                  ]),
                ]),
              ),
              // Spent / remaining pill
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(
                  formatAmount(spent, cur),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: barColor),
                ),
                Text(
                  exceeded
                      ? l10n.budget_overAmount(formatAmount(spent - budget.amount, cur))
                      : l10n.budget_leftAmount(formatAmount(budget.amount - spent, cur)),
                  style: TextStyle(
                      fontSize: 10,
                      color: exceeded
                          ? cs.error
                          : cs.onSurface.withValues(alpha: 0.5)),
                ),
              ]),
            ]),
            const SizedBox(height: 10),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: barColor.withValues(alpha: 0.12),
                valueColor: AlwaysStoppedAnimation<Color>(barColor),
              ),
            ),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                l10n.budget_percentUsed((progress * 100).toStringAsFixed(0)),
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: barColor),
              ),
              if (exceeded)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: cs.errorContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(l10n.budget_overBudget,
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: cs.onErrorContainer)),
                ),
            ]),
          ]),
        ),
      ),
    );
  }
}

// ── Budget sheet ──────────────────────────────────────────────────────────────
class _BudgetSheet extends StatefulWidget {
  final Budget? existing;
  const _BudgetSheet({this.existing});
  @override
  State<_BudgetSheet> createState() => _BudgetSheetState();
}

class _BudgetSheetState extends State<_BudgetSheet> {
  final _amtCtrl = TextEditingController();
  String? _categoryId;
  String  _period = 'monthly';

  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    if (isEdit) {
      final e = widget.existing!;
      _amtCtrl.text = e.amount.toStringAsFixed(2);
      _categoryId   = e.categoryId;
      _period       = e.period;
    } else {
      // Default to first expense category not yet budgeted
      final app = context.read<AppProvider>();
      final expCats = app.categories.where((c) => c.type == 'expense').toList();
      final budgetedIds = app.budgets.map((b) => b.categoryId).toSet();
      final free = expCats.where((c) => !budgetedIds.contains(c.id)).toList();
      if (free.isNotEmpty) _categoryId = free.first.id;
      else if (expCats.isNotEmpty) _categoryId = expCats.first.id;
    }
  }

  @override
  void dispose() {
    _amtCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final amount = double.tryParse(_amtCtrl.text);
    if (amount == null || amount <= 0 || _categoryId == null) return;
    final app = context.read<AppProvider>();
    final l10n = AppLocalizations.of(context)!;

    // Guard: if adding and category already has a budget, block it
    if (!isEdit) {
      final existing = app.budgetForCategory(_categoryId!);
      if (existing != null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.budget_thisCategoryAlreadyH)),
        );
        return;
      }
    }

    final b = Budget(
      id: isEdit ? widget.existing!.id : app.newId(),
      categoryId: _categoryId!,
      amount: amount,
      period: _period,
      createdAt: isEdit ? widget.existing!.createdAt : DateTime.now(),
    );

    if (isEdit) {
      await app.updateBudget(b);
    } else {
      await app.addBudget(b);
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app     = context.watch<AppProvider>();
    final cs      = Theme.of(context).colorScheme;
    final sym     = currencyInfo(app.settings.currency).symbol;
    final expCats = app.categories.where((c) => c.type == 'expense').toList();

    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 20, right: 20, top: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEdit ? l10n.budget_editBudget : l10n.budget_setBudget,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),

            // Amount
            TextField(
              controller: _amtCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: l10n.budget_budgetAmount,
                prefixText: '$sym ',
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),

            // Period selector
            Text(l10n.budget_period,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(letterSpacing: 1)),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _period = 'monthly'),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: _period == 'monthly'
                          ? cs.primary
                          : cs.primaryContainer.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(l10n.budget_monthly,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: _period == 'monthly'
                                  ? cs.onPrimary
                                  : cs.primary)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _period = 'weekly'),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: _period == 'weekly'
                          ? cs.secondary
                          : cs.secondaryContainer.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(l10n.budget_weekly,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: _period == 'weekly'
                                  ? cs.onSecondary
                                  : cs.secondary)),
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 16),

            // Category
            if (expCats.isNotEmpty) ...[
              Text(l10n.budget_category,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(letterSpacing: 1)),
              const SizedBox(height: 8),
              CategoryChipPicker(
                categories: expCats,
                selectedId: _categoryId,
                onSelected: (id) => setState(() => _categoryId = id),
              ),
              const SizedBox(height: 16),
            ],

            // Preview
            if (_categoryId != null &&
                double.tryParse(_amtCtrl.text) != null &&
                double.parse(_amtCtrl.text) > 0) ...[
              Builder(builder: (ctx) {
                final spent = app.budgetSpent(Budget(
                  id: '',
                  categoryId: _categoryId!,
                  amount: double.parse(_amtCtrl.text),
                  period: _period,
                  createdAt: DateTime.now(),
                ));
                final budgetAmt = double.parse(_amtCtrl.text);
                final pct = (spent / budgetAmt).clamp(0.0, 1.0);
                final catName = app.categoryById(_categoryId!)?.name ?? '';
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(l10n.budget_previewFor(catName),
                        style: TextStyle(
                            fontSize: 11,
                            color: cs.onSurface.withValues(alpha: 0.6))),
                    const SizedBox(height: 6),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Text(
                          l10n.budget_spentAmount(formatAmount(spent, app.settings.currency)),
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w700)),
                      Text(
                          l10n.budget_ofAmount(formatAmount(budgetAmt, app.settings.currency)),
                          style: TextStyle(
                              fontSize: 12,
                              color: cs.onSurface.withValues(alpha: 0.5))),
                    ]),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: pct,
                        minHeight: 5,
                        backgroundColor:
                            cs.primary.withValues(alpha: 0.12),
                        valueColor: AlwaysStoppedAnimation<Color>(
                            pct >= 1.0
                                ? cs.error
                                : pct >= 0.75
                                    ? Colors.orange
                                    : cs.primary),
                      ),
                    ),
                  ]),
                );
              }),
              const SizedBox(height: 16),
            ],

            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(isEdit ? Icons.save_outlined : Icons.add),
              label: Text(isEdit ? l10n.budget_saveChanges : l10n.budget_setBudget),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28)),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
