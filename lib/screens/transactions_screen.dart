// lib/screens/transactions_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import 'add_transaction_screen.dart';
import 'lended_person_screen.dart';
import 'savings_goal_detail_screen.dart';
import 'loan_detail_screen.dart';
import '../utils/snackbar.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});
  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String  _search    = '';
  String  _filter    = 'all';   // all|income|expense
  String? _accFilter;

  // New selections & advanced filters
  final Set<String> _selectedIds = {};
  double? _minAmount;
  double? _maxAmount;
  String? _advCategoryFilter;


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        context.read<AppProvider>().setTransactionSelectionMode(_selectedIds.isNotEmpty);
      }
    });

    // ── Build item list ─────────────────────────────────────────────────
    final List<_TxItem> allItems = [];

    // 1. Add matching regular transactions
    if (_filter == 'all' || _filter == 'income' || _filter == 'expense') {
      for (final t in app.transactions) {
        if (_filter != 'all' && t.type != _filter) continue;
        if (_accFilter != null && t.accountId != _accFilter) continue;
        if (_minAmount != null && t.amount < _minAmount!) continue;
        if (_maxAmount != null && t.amount > _maxAmount!) continue;
        if (_advCategoryFilter != null && t.categoryId != _advCategoryFilter) continue;
        if (_search.isNotEmpty) {
          final q   = _search.toLowerCase();
          final cat = app.categoryById(t.categoryId)?.name.toLowerCase() ?? '';
          final acc = app.accountById(t.accountId)?.name.toLowerCase() ?? '';
          if (!t.description.toLowerCase().contains(q) &&
              !cat.contains(q) && !acc.contains(q)) {
            continue;
          }
        }
        allItems.add(_TxItem.fromTx(t));
      }
    }

    // 2. Add matching lent & borrowed records
    if (_filter == 'all' || _filter == 'lent' || _filter == 'borrowed') {
      for (final l in app.lended) {
        if (_filter != 'all' && l.type != _filter) continue;
        if (_accFilter != null && l.accountId != _accFilter) continue;
        if (_minAmount != null && l.amount < _minAmount!) continue;
        if (_maxAmount != null && l.amount > _maxAmount!) continue;
        if (_advCategoryFilter != null) continue;
        if (_search.isNotEmpty) {
          final q      = _search.toLowerCase();
          final person = app.personById(l.personId)?.name.toLowerCase() ?? '';
          final acc    = l.accountId != null
              ? (app.accountById(l.accountId!)?.name.toLowerCase() ?? '')
              : '';
          final typeStr = l.type.toLowerCase();
          if (!l.notes.toLowerCase().contains(q) &&
              !person.contains(q) &&
              !acc.contains(q) &&
              !typeStr.contains(q)) {
            continue;
          }
        }
        allItems.add(_TxItem.fromLended(l));
      }
    }

    // 3. Add savings contributions
    if (_filter == 'all' || _filter == 'expense' || _filter == 'income') {
      for (final c in app.savingsContributions) {
        if (_filter == 'expense' && c.type != 'contribution') continue; // Contribution = money out of account = expense
        if (_filter == 'income' && c.type != 'withdrawal') continue; // Withdrawal = money into account = income
        if (_accFilter != null && c.accountId != _accFilter) continue;
        if (_minAmount != null && c.amount < _minAmount!) continue;
        if (_maxAmount != null && c.amount > _maxAmount!) continue;
        if (_advCategoryFilter != null) continue;
        if (_search.isNotEmpty) {
          final q = _search.toLowerCase();
          final goal = app.savingsGoals.where((g) => g.id == c.goalId).firstOrNull?.name.toLowerCase() ?? '';
          final note = c.note.toLowerCase();
          if (!goal.contains(q) && !note.contains(q)) continue;
        }
        allItems.add(_TxItem.fromContribution(c));
      }
    }

    // 4. Add loan payments
    if (_filter == 'all' || _filter == 'expense') {
      for (final p in app.loanPayments) {
        if (_accFilter != null && p.accountId != _accFilter) continue;
        if (_minAmount != null && p.amount < _minAmount!) continue;
        if (_maxAmount != null && p.amount > _maxAmount!) continue;
        if (_advCategoryFilter != null) continue;
        if (_search.isNotEmpty) {
          final q = _search.toLowerCase();
          final loan = app.loans.where((l) => l.id == p.loanId).firstOrNull?.name.toLowerCase() ?? '';
          final acc = p.accountId != null
              ? (app.accountById(p.accountId!)?.name.toLowerCase() ?? '')
              : '';
          if (!loan.contains(q) && !acc.contains(q) && !p.notes.toLowerCase().contains(q)) continue;
        }
        allItems.add(_TxItem.fromLoanPayment(p));
      }
    }

    // Sort by date descending
    allItems.sort((a, b) => b.date.compareTo(a.date));

    // Group by date
    final groups = <String, List<_TxItem>>{};
    for (final item in allItems) {
      final key = DateFormat('yyyy-MM-dd').format(item.date);
      (groups[key] ??= []).add(item);
    }
    final keys = groups.keys.toList()..sort((a, b) => b.compareTo(a));

    return PopScope(
      canPop: _selectedIds.isEmpty,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _selectedIds.isNotEmpty) {
          setState(() => _selectedIds.clear());
        }
      },
      child: Scaffold(
      appBar: _selectedIds.isEmpty
          ? AppBar(
              title: Text(l10n.transactions_transactions,
                  style: const TextStyle(fontWeight: FontWeight.w800)),
              backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
            )
          : AppBar(
              backgroundColor: cs.secondaryContainer,
              foregroundColor: cs.onSecondaryContainer,
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => setState(() => _selectedIds.clear()),
              ),
              title: Text('${_selectedIds.length} selected', style: const TextStyle(fontWeight: FontWeight.w600)),
              actions: [
                if (_selectedIds.every((id) => app.transactions.any((t) => t.id == id)))
                  IconButton(
                    icon: const Icon(Icons.category_outlined),
                    onPressed: () => _bulkChangeCategory(context, app),
                    tooltip: 'Change Category',
                  ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _bulkDelete(context, app),
                  tooltip: 'Delete Selected',
                ),
              ],
            ),
      body: Column(children: [
        // ── Search bar ──────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: l10n.transactions_searchTransactions,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _search.isNotEmpty
                        ? IconButton(icon: const Icon(Icons.clear),
                            onPressed: () => setState(() => _search = ''))
                        : null,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary, width: 2)),
                  ),
                  onChanged: (v) => setState(() => _search = v),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filledTonal(
                onPressed: () => _openAdvancedFilter(context, app),
                icon: const Icon(Icons.filter_alt_outlined),
                style: IconButton.styleFrom(
                  backgroundColor: (_minAmount != null || _maxAmount != null || _advCategoryFilter != null)
                      ? cs.primaryContainer
                      : cs.surfaceContainerHighest,
                ),
              ),
            ],
          ),
        ),

        // ── Filter chips ────────────────────────────────────────────────
        SizedBox(
          height: 44,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            children: [
              for (final f in [
                ('all',      l10n.transactions_all,              0xFF6750A4),
                ('income',   l10n.transactions_income,           0xFF2E7D32),
                ('expense',  l10n.transactions_expenses,         0xFFC62828),
                ('lent',     l10n.transactions_lent,             0xFF1565C0),
                ('borrowed', l10n.transactions_borrowed,         0xFFE65140),
              ])
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: _FilterPill(
                    label: f.$2,
                    color: Color(f.$3),
                    selected: _filter == f.$1,
                    onTap: () => setState(() => _filter = f.$1),
                  ),
                ),
              if (app.accounts.isNotEmpty)
                for (final acc in app.accounts)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: _FilterPill(
                      label: acc.name,
                      color: Color(acc.colorValue),
                      selected: _accFilter == acc.id,
                      onTap: () => setState(() =>
                          _accFilter = _accFilter == acc.id ? null : acc.id),
                    ),
                  ),
            ],
          ),
        ),

        // ── List ────────────────────────────────────────────────────────
        Expanded(
          child: allItems.isEmpty
              ? EmptyState(
                  icon: Icons.receipt_long_outlined,
                  message: l10n.transactions_noTransactions,
                  subMessage: l10n.transactions_tapPlusToAddOne,
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(14, 4, 14, 140),
                  itemCount: keys.length,
                  itemBuilder: (_, i) {
                    final key   = keys[i];
                    final items = groups[key]!;
                    final date  = DateFormat('yyyy-MM-dd').parse(key);
                    final now   = DateTime.now();
                    String label;
                    if (DateFormat('yyyy-MM-dd').format(now) == key) {
                      label = l10n.transactions_today;
                    } else if (DateFormat('yyyy-MM-dd').format(
                        now.subtract(const Duration(days: 1))) == key) {
                      label = l10n.transactions_yesterday;
                    } else {
                      label = DateFormat('d MMMM yyyy').format(date);
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(2, i == 0 ? 6 : 12, 0, 7),
                          child: Text(label, style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700,
                              color: cs.primary)),
                        ),
                        ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: items.length,
                            itemBuilder: (_, idx) {
                              final item = items[idx];
                              if (item.isTx) {
                                final isSelected = _selectedIds.contains(item.tx!.id);
                                return _TxTile(
                                  t: item.tx!, 
                                  app: app,
                                  isSelected: isSelected,
                                  selectionMode: _selectedIds.isNotEmpty,
                                  onTap: () {
                                    if (_selectedIds.isNotEmpty) {
                                      setState(() {
                                        if (isSelected) {
                                          _selectedIds.remove(item.tx!.id);
                                        } else {
                                          _selectedIds.add(item.tx!.id);
                                        }
                                      });
                                    } else {
                                      Navigator.push(context, ExpensySlideUpRoute(
                                          builder: (_) => AddTransactionScreen(existing: item.tx!)));
                                    }
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      if (isSelected) {
                                        _selectedIds.remove(item.tx!.id);
                                      } else {
                                        _selectedIds.add(item.tx!.id);
                                      }
                                    });
                                  }
                                );
                              } else if (item.isLended) {
                                final isSelected = _selectedIds.contains(item.lended!.id);
                                return _LendedTile(
                                  l: item.lended!, 
                                  app: app,
                                  isSelected: isSelected,
                                  selectionMode: _selectedIds.isNotEmpty,
                                  onTap: () {
                                    if (_selectedIds.isNotEmpty) {
                                      setState(() {
                                        if (isSelected) {
                                          _selectedIds.remove(item.lended!.id);
                                        } else {
                                          _selectedIds.add(item.lended!.id);
                                        }
                                      });
                                    } else {
                                      final person = app.personById(item.lended!.personId);
                                      if (person != null) {
                                        Navigator.push(
                                          context,
                                          ExpensyRoute(builder: (_) => LendedPersonScreen(person: person)),
                                        );
                                      }
                                    }
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      if (isSelected) {
                                        _selectedIds.remove(item.lended!.id);
                                      } else {
                                        _selectedIds.add(item.lended!.id);
                                      }
                                    });
                                  }
                                );
                              } else if (item.isContribution) {
                                return _ContributionTile(c: item.contribution!, app: app);
                              } else if (item.isLoanPayment) {
                                final isSelected = _selectedIds.contains(item.loanPayment!.id);
                                return _LoanPaymentTile(
                                  p: item.loanPayment!,
                                  app: app,
                                  isSelected: isSelected,
                                  selectionMode: _selectedIds.isNotEmpty,
                                  onTap: () {
                                    if (_selectedIds.isNotEmpty) {
                                      setState(() {
                                        if (isSelected) {
                                          _selectedIds.remove(item.loanPayment!.id);
                                        } else {
                                          _selectedIds.add(item.loanPayment!.id);
                                        }
                                      });
                                    } else {
                                      final loan = app.loans.where((l) => l.id == item.loanPayment!.loanId).firstOrNull;
                                      if (loan != null) {
                                        Navigator.push(context, ExpensyRoute(builder: (_) => LoanDetailScreen(loan: loan)));
                                      }
                                    }
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      if (isSelected) {
                                        _selectedIds.remove(item.loanPayment!.id);
                                      } else {
                                        _selectedIds.add(item.loanPayment!.id);
                                      }
                                    });
                                  },
                                );
                              }
                              return const SizedBox.shrink();
                            }),
                      ],
                    );
                  },
                ),
        ),
      ]),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 76),
        child: ExpandableFab(
          label: l10n.home_add,
          onIncome: () => Navigator.push(
              context,
              ExpensySlideUpRoute(
                  builder: (_) =>
                      const AddTransactionScreen(initialType: 'income'))),
          onExpense: () => Navigator.push(
              context,
              ExpensySlideUpRoute(
                  builder: (_) =>
                      const AddTransactionScreen(initialType: 'expense'))),
        ),
      ),
      ),
    );
  }

  Future<void> _bulkDelete(BuildContext context, AppProvider app) async {
    final idsToDelete = _selectedIds.toList();
    setState(() => _selectedIds.clear());

    final undoActions = <VoidCallback>[];
    for (final id in idsToDelete) {
      if (app.transactions.any((t) => t.id == id)) {
        undoActions.add(await app.deleteTransactionWithUndo(id));
      } else if (app.lended.any((l) => l.id == id)) {
        undoActions.add(await app.deleteLendedWithUndo(id));
      } else if (app.loanPayments.any((p) => p.id == id)) {
        undoActions.add(await app.deleteLoanPaymentWithUndo(id));
      }
    }

    if (context.mounted) {
      showAppSnackbar(
        context, 
        'Deleted ${idsToDelete.length} items',
        onUndo: () {
          for (final undo in undoActions.reversed) {
            undo();
          }
        },
      );
    }
  }

  void _bulkChangeCategory(BuildContext context, AppProvider app) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 24, right: 24, top: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Change Category', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Flexible(
              child: SingleChildScrollView(
                child: CategoryChipPicker(
                  categories: app.categories,
                  selectedId: null,
                  onSelected: (catId) {
                    Navigator.pop(context);
                    for (final id in _selectedIds.toList()) {
                      final tx = app.transactions.where((t) => t.id == id).firstOrNull;
                      if (tx == null) continue;
                      final updated = AppTransaction(
                        id: tx.id,
                        accountId: tx.accountId,
                        categoryId: catId,
                        amount: tx.amount,
                        type: tx.type,
                        date: tx.date,
                        description: tx.description,
                        note: tx.note,
                        currency: tx.currency,
                      );
                      app.updateTransaction(updated, tx);
                    }
                    setState(() => _selectedIds.clear());
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _openAdvancedFilter(BuildContext context, AppProvider app) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _AdvancedFilterSheet(
        initialMinAmount: _minAmount,
        initialMaxAmount: _maxAmount,
        initialCategory: _advCategoryFilter,
        app: app,
        onApply: (minAmt, maxAmt, catId) {
          setState(() {
            _minAmount = minAmt;
            _maxAmount = maxAmt;
            _advCategoryFilter = catId;
          });
        },
      ),
    );
  }
}

// ── Transaction tile ────────────────────────────────────────────────────────
class _TxTile extends StatelessWidget {
  final AppTransaction t;
  final AppProvider    app;
  final bool isSelected;
  final bool selectionMode;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _TxTile({
    required this.t, 
    required this.app,
    required this.isSelected,
    required this.selectionMode,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs    = Theme.of(context).colorScheme;
    final cat   = app.categoryById(t.categoryId);
    final isInc = t.type == 'income';
    final acc   = app.accountById(t.accountId);
    final accCurrency = acc?.currency ?? app.settings.currency;
    final displayCurrency = t.currency.isNotEmpty ? t.currency : accCurrency;

    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      color: isSelected ? cs.primaryContainer : null,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: selectionMode
            ? Checkbox(value: isSelected, onChanged: (_) => onTap())
            : CategoryDot(category: cat, size: 40),
        title: Text(
          t.description.isNotEmpty ? t.description : (cat?.name ?? t.type),
          style:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Text(
          '${acc?.name ?? ''}  ·  ${cat?.name ?? ''}',
          style: TextStyle(
              fontSize: 11,
              color: cs.onSurface.withValues(alpha: 0.5))),
        trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
          Text(
            '${isInc ? '+' : '-'}${formatAmount(t.amount, displayCurrency)}',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isInc
                    ? const Color(0xFF2E7D32)
                    : const Color(0xFFC62828)),
          ),
          if (t.note.isNotEmpty)
            Icon(Icons.sticky_note_2_outlined,
                size: 12, color: cs.onSurface.withValues(alpha: 0.4)),
        ]),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}

// ── Colored filter pill ───────────────────────────────────────────────────────
class _FilterPill extends StatelessWidget {
  final String label;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _FilterPill({
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
        decoration: BoxDecoration(
          color: selected ? color : color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? color : color.withValues(alpha: 0.35),
            width: selected ? 0 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : color,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Lent / Borrowed tile ────────────────────────────────────────────────────
class _LendedTile extends StatelessWidget {
  final LendedMoney l;
  final AppProvider app;
  final bool isSelected;
  final bool selectionMode;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _LendedTile({
    required this.l, 
    required this.app,
    required this.isSelected,
    required this.selectionMode,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final person = app.personById(l.personId);
    final isLent = l.type == 'lent';
    final acc = l.accountId != null ? app.accountById(l.accountId!) : null;
    final accCurrency = acc?.currency ?? app.settings.currency;
    final displayCurrency = accCurrency;

    final personColor = Color(
        person?.colorValue ?? (isLent ? 0xFF1565C0 : 0xFFE65140));
    final amountColor = isLent ? const Color(0xFF1565C0) : const Color(0xFFE65140);

    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      color: isSelected ? cs.primaryContainer : null,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: selectionMode
            ? Checkbox(value: isSelected, onChanged: (_) => onTap())
            : Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: personColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            isLent ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
            color: personColor,
            size: 22,
          ),
        ),
        title: Text(
          l.notes.isNotEmpty
              ? l.notes
              : (isLent ? l10n.transactions_lentTo(person?.name ?? l10n.transactions_unknown) : l10n.transactions_borrowedFrom(person?.name ?? l10n.transactions_unknown)),
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        subtitle: Text(
          [
            if (l.notes.isNotEmpty)
              (isLent ? l10n.transactions_lentTo(person?.name ?? l10n.transactions_unknown) : l10n.transactions_borrowedFrom(person?.name ?? l10n.transactions_unknown)),
            if (acc != null) acc.name,
            isLent ? l10n.transactions_lent : l10n.transactions_borrowed,
            l.isSettled
                ? l10n.transactions_settled
                : (l.dueDate != null
                    ? l10n.transactions_due(DateFormat('d MMM yyyy').format(l.dueDate!))
                    : l10n.transactions_unsettled),
          ].join('  ·  '),
          style: TextStyle(
            fontSize: 11,
            color: cs.onSurface.withValues(alpha: 0.5),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${isLent ? '-' : '+'}${formatAmount(l.amount, displayCurrency)}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: l.isSettled
                    ? cs.onSurface.withValues(alpha: 0.4)
                    : amountColor,
              ),
            ),
            if (l.isSettled)
              Text(l10n.transactions_settled,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface.withValues(alpha: 0.4),
                ),
              )
            else if (l.notes.isNotEmpty)
              Icon(
                Icons.sticky_note_2_outlined,
                size: 12,
                color: cs.onSurface.withValues(alpha: 0.4),
              ),
          ],
        ),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}

// ── Unified display item wrapper ────────────────────────────────────────────
class _TxItem {
  final AppTransaction? tx;
  final LendedMoney? lended;
  final SavingsContribution? contribution;
  final LoanPayment? loanPayment;
  final DateTime date;

  _TxItem.fromTx(this.tx) : lended = null, contribution = null, loanPayment = null, date = tx!.date;
  _TxItem.fromLended(this.lended) : tx = null, contribution = null, loanPayment = null, date = lended!.date;
  _TxItem.fromContribution(this.contribution) : tx = null, lended = null, loanPayment = null, date = contribution!.date;
  _TxItem.fromLoanPayment(this.loanPayment) : tx = null, lended = null, contribution = null, date = loanPayment!.date;

  bool get isTx => tx != null;
  bool get isLended => lended != null;
  bool get isContribution => contribution != null;
  bool get isLoanPayment => loanPayment != null;
}

class _LoanPaymentTile extends StatelessWidget {
  final LoanPayment p;
  final AppProvider app;
  final bool isSelected;
  final bool selectionMode;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _LoanPaymentTile({
    required this.p,
    required this.app,
    required this.isSelected,
    required this.selectionMode,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final loan = app.loans.where((l) => l.id == p.loanId).firstOrNull;
    final acc = p.accountId != null ? app.accountById(p.accountId!) : null;
    final displayCurrency = acc?.currency ?? p.currency;
    const loanColor = Color(0xFF4A148C);

    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: selectionMode
            ? Checkbox(value: isSelected, onChanged: (_) => onTap())
            : Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                    color: loanColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.account_balance_outlined, color: loanColor, size: 22),
              ),
        title: Text(loan?.name ?? 'Loan', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Text(
          [if (acc != null) acc.name, 'Loan Payment'].join('  ·  '),
          style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)),
        ),
        trailing: Text('-${formatAmount(p.amount, displayCurrency)}',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: loanColor)),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}

// ── Contribution Tile ─────────────────────────────────────────────────────────
class _ContributionTile extends StatelessWidget {
  final SavingsContribution c;
  final AppProvider app;
  
  const _ContributionTile({required this.c, required this.app});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isContrib = c.type == 'contribution';
    final goal = app.savingsGoals.where((g) => g.id == c.goalId).firstOrNull;
    final acc = app.accountById(c.accountId);
    
    final color = goal != null ? Color(goal.colorValue) : cs.primary;
    final amountColor = isContrib ? cs.error : const Color(0xFF2E7D32); // Contrib is money OUT of account
    
    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.savings_outlined,
            color: color,
            size: 22,
          ),
        ),
        title: Text(
          isContrib ? 'Goal Contribution' : 'Goal Withdrawal',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        subtitle: Text(
          [
            if (goal != null) goal.name,
            if (acc != null) acc.name,
            if (c.note.isNotEmpty) c.note,
          ].join('  ·  '),
          style: TextStyle(
            fontSize: 11,
            color: cs.onSurface.withValues(alpha: 0.5),
          ),
        ),
        trailing: Text(
          '${isContrib ? '-' : '+'}${formatAmount(c.amount, goal?.currency ?? app.settings.currency)}',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: amountColor,
          ),
        ),
        onTap: () {
          if (goal != null) {
            Navigator.push(
              context,
              ExpensyRoute(builder: (_) => SavingsGoalDetailScreen(goal: goal)),
            );
          }
        },
      ),
    );
  }
}

// ── Advanced Filter Sheet ───────────────────────────────────────────────────
class _AdvancedFilterSheet extends StatefulWidget {
  final double? initialMinAmount;
  final double? initialMaxAmount;
  final String? initialCategory;
  final AppProvider app;
  final void Function(double? min, double? max, String? category) onApply;

  const _AdvancedFilterSheet({
    this.initialMinAmount,
    this.initialMaxAmount,
    this.initialCategory,
    required this.app,
    required this.onApply,
  });

  @override
  State<_AdvancedFilterSheet> createState() => _AdvancedFilterSheetState();
}

class _AdvancedFilterSheetState extends State<_AdvancedFilterSheet> {
  final _minCtrl = TextEditingController();
  final _maxCtrl = TextEditingController();
  String? _catId;

  @override
  void initState() {
    super.initState();
    if (widget.initialMinAmount != null) _minCtrl.text = widget.initialMinAmount.toString();
    if (widget.initialMaxAmount != null) _maxCtrl.text = widget.initialMaxAmount.toString();
    _catId = widget.initialCategory;
  }

  @override
  void dispose() {
    _minCtrl.dispose();
    _maxCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24, right: 24, top: 24
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Advanced Filters', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  widget.onApply(null, null, null);
                  Navigator.pop(context);
                },
                child: const Text('Clear All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Amount Range', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _minCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.next,
                 
                  decoration: const InputDecoration(labelText: 'Min Amount', prefixIcon: Icon(Icons.attach_money)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _maxCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: 'Max Amount', prefixIcon: Icon(Icons.attach_money)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Category', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Flexible(
            child: SingleChildScrollView(
              child: CategoryChipPicker(
                categories: widget.app.categories,
                selectedId: _catId,
                onSelected: (id) => setState(() => _catId = id),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton(
              onPressed: () {
                final minAmt = double.tryParse(_minCtrl.text);
                final maxAmt = double.tryParse(_maxCtrl.text);
                widget.onApply(minAmt, maxAmt, _catId);
                Navigator.pop(context);
              },
              child: const Text('Apply Filters'),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}


