// lib/screens/transactions_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/fintech_components.dart';
import 'add_transaction_screen.dart';
import 'lended_person_screen.dart';
import 'savings_goal_detail_screen.dart';
import 'loan_detail_screen.dart';
import '../widgets/split_transaction_sheet.dart';
import '../widgets/app_numeric_keypad.dart';
import '../utils/haptics.dart';
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

  void _toggleSelection(String id) {
    final wasEmpty = _selectedIds.isEmpty;
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
    if (wasEmpty != _selectedIds.isEmpty) {
      context.read<AppProvider>().setTransactionSelectionMode(_selectedIds.isNotEmpty);
    }
  }

  void _clearSelection() {
    if (_selectedIds.isNotEmpty) {
      setState(() => _selectedIds.clear());
      context.read<AppProvider>().setTransactionSelectionMode(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;

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

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tabGreen = isDark ? const Color(0xFF81C784) : const Color(0xFF2E7D32);

    return PopScope(
      canPop: _selectedIds.isEmpty,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _selectedIds.isNotEmpty) {
          _clearSelection();
        }
      },
      child: Scaffold(
        appBar: null,
        body: Column(
          children: [
            // ── Edge-to-Edge Header (Normal or Selection Mode) ──────────
            if (_selectedIds.isNotEmpty)
              FintechHeader(
                title: l10n.transactions_selectedCount(_selectedIds.length),
                subtitle: '${_selectedIds.length} ${_selectedIds.length == 1 ? "item" : "items"} selected',
                leading: FintechCircleButton(
                  icon: Icons.close_rounded,
                  tooltip: 'Clear selection',
                  onTap: _clearSelection,
                ),
                actions: [
                  if (_selectedIds.every((id) => app.transactions.any((t) => t.id == id))) ...[
                    FintechCircleButton(
                      icon: Icons.category_outlined,
                      tooltip: l10n.transactions_changeCategory,
                      color: tabGreen.withValues(alpha: isDark ? 0.25 : 0.15),
                      iconColor: tabGreen,
                      onTap: () => _bulkChangeCategory(context, app),
                    ),
                    const SizedBox(width: 8),
                  ],
                  FintechCircleButton(
                    icon: Icons.delete_outline_rounded,
                    tooltip: l10n.transactions_deleteSelected,
                    color: cs.error.withValues(alpha: isDark ? 0.25 : 0.15),
                    iconColor: cs.error,
                    onTap: () => _bulkDelete(context, app),
                  ),
                ],
              )
            else
              FintechHeader(
                title: l10n.transactions_transactions,
                subtitle: '${allItems.length} ${allItems.length == 1 ? "entry" : "entries"}',
                actions: [
                  FintechCircleButton(
                    icon: Icons.filter_alt_outlined,
                    tooltip: l10n.transactions_advancedFilters,
                    color: (_minAmount != null || _maxAmount != null || _advCategoryFilter != null)
                        ? tabGreen.withValues(alpha: isDark ? 0.25 : 0.15)
                        : null,
                    iconColor: (_minAmount != null || _maxAmount != null || _advCategoryFilter != null)
                        ? tabGreen
                        : null,
                    onPressed: () => _openAdvancedFilter(context, app),
                  ),
                  const SizedBox(width: 8),
                  FintechCircleButton(
                    icon: Icons.add_rounded,
                    tooltip: l10n.home_add,
                    color: tabGreen,
                    iconColor: Colors.white,
                    onPressed: () => _showAddActionSheet(context),
                  ),
                ],
              ),

            // ── Modern Search Bar ───────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 2, 16, 6),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: isDark
                      ? cs.surfaceContainerHighest.withValues(alpha: 0.35)
                      : cs.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.06)
                        : Colors.black.withValues(alpha: 0.05),
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: l10n.transactions_searchTransactions,
                    hintStyle: TextStyle(
                      fontSize: 13.5,
                      color: cs.onSurface.withValues(alpha: 0.5),
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      size: 20,
                      color: cs.onSurface.withValues(alpha: 0.55),
                    ),
                    suffixIcon: _search.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close_rounded, size: 18),
                            onPressed: () => setState(() => _search = ''),
                          )
                        : null,
                    isDense: true,
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onChanged: (v) => setState(() => _search = v),
                ),
              ),
            ),

            // ── Modern Filter Pills ─────────────────────────────────────
            SizedBox(
              height: 42,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                children: [
                  for (final f in [
                    ('all',      l10n.transactions_all,              0xFF2E7D32),
                    ('income',   l10n.transactions_income,           0xFF2E7D32),
                    ('expense',  l10n.transactions_expenses,         0xFFC62828),
                    ('lent',     l10n.transactions_lent,             0xFF1565C0),
                    ('borrowed', l10n.transactions_borrowed,         0xFFE65140),
                  ])
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
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
                        padding: const EdgeInsets.only(right: 8),
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

            // ── Contained Day Ledgers ───────────────────────────────────
            Expanded(
              child: allItems.isEmpty
                  ? EmptyState(
                      icon: Icons.receipt_long_outlined,
                      message: l10n.transactions_noTransactions,
                      subMessage: l10n.transactions_tapPlusToAddOne,
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(0, 6, 0, 140),
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

                        double dayTotal = 0.0;
                        for (final item in items) {
                          if (item.isTx) {
                            dayTotal += item.tx!.type == 'income' ? item.tx!.amount : -item.tx!.amount;
                          } else if (item.isLended) {
                            dayTotal += item.lended!.type == 'borrowed' ? item.lended!.amount : -item.lended!.amount;
                          } else if (item.isContribution) {
                            dayTotal += item.contribution!.type == 'withdrawal' ? item.contribution!.amount : -item.contribution!.amount;
                          }
                        }

                        return FintechContainedLedger(
                          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          dividerIndent: 66,
                          header: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  label,
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.2,
                                    color: tabGreen,
                                  ),
                                ),
                                Text(
                                  '${dayTotal >= 0 ? '+' : '-'}${formatAmount(dayTotal.abs(), app.settings.currency)}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: dayTotal > 0
                                        ? const Color(0xFF2E7D32)
                                        : (dayTotal < 0
                                            ? (isDark ? const Color(0xFFE57373) : const Color(0xFFC62828))
                                            : cs.onSurface.withValues(alpha: 0.5)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          children: [
                            for (int idx = 0; idx < items.length; idx++)
                              _buildItemTile(context, items[idx], app),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddActionSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E2128) : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.08),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.12),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: cs.onSurface.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53935).withValues(alpha: isDark ? 0.2 : 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.arrow_upward_rounded, color: Color(0xFFE53935)),
                ),
                title: Text(
                  l10n.add_transaction_expense,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    ExpensySlideUpRoute(
                      builder: (_) => const AddTransactionScreen(initialType: 'expense'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32).withValues(alpha: isDark ? 0.2 : 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.arrow_downward_rounded, color: Color(0xFF2E7D32)),
                ),
                title: Text(
                  l10n.add_transaction_income,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    ExpensySlideUpRoute(
                      builder: (_) => const AddTransactionScreen(initialType: 'income'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemTile(BuildContext context, _TxItem item, AppProvider app) {
    if (item.isTx) {
      final isSelected = _selectedIds.contains(item.tx!.id);
      return _TxTile(
        t: item.tx!,
        app: app,
        isSelected: isSelected,
        selectionMode: _selectedIds.isNotEmpty,
        onTap: () {
          if (_selectedIds.isNotEmpty) {
            _toggleSelection(item.tx!.id);
          } else if (app.isTransactionSplit(item.tx!.id)) {
            SplitTransactionSheet.show(
              context,
              transaction: item.tx!,
              splits: app.getSplits(item.tx!.id),
              app: app,
            );
          } else {
            Navigator.push(
              context,
              ExpensySlideUpRoute(
                builder: (_) => AddTransactionScreen(existing: item.tx!),
              ),
            );
          }
        },
        onLongPress: () {
          _toggleSelection(item.tx!.id);
        },
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
            _toggleSelection(item.lended!.id);
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
          _toggleSelection(item.lended!.id);
        },
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
            _toggleSelection(item.loanPayment!.id);
          } else {
            final loan = app.loans.where((l) => l.id == item.loanPayment!.loanId).firstOrNull;
            if (loan != null) {
              Navigator.push(
                context,
                ExpensyRoute(builder: (_) => LoanDetailScreen(loan: loan)),
              );
            }
          }
        },
        onLongPress: () {
          _toggleSelection(item.loanPayment!.id);
        },
      );
    }
    return const SizedBox.shrink();
  }

  Future<void> _bulkDelete(BuildContext context, AppProvider app) async {
    final idsToDelete = _selectedIds.toList();
    _clearSelection();

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
      final l10n = AppLocalizations.of(context)!;
      showAppSnackbar(
        context, 
        l10n.transactions_deletedCount(idsToDelete.length),
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
            Text(l10n.transactions_changeCategory, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                    _clearSelection();
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

    final isSplit = app.isTransactionSplit(t.id);
    final splits = isSplit ? app.getSplits(t.id) : const <TransactionSplit>[];

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: isSelected
          ? cs.primaryContainer.withValues(alpha: 0.28)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        leading: selectionMode
            ? Checkbox(value: isSelected, onChanged: (_) => onTap())
            : (isSplit
                ? Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF81C784).withValues(alpha: 0.2)
                          : const Color(0xFF2E7D32).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(Icons.call_split_rounded,
                        color: isDark
                            ? const Color(0xFF81C784)
                            : const Color(0xFF2E7D32),
                        size: 20),
                  )
                : CategoryDot(category: cat, size: 40)),
        title: Text(
          t.description.isNotEmpty ? t.description : (cat?.name ?? t.type),
          style:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: isSplit
            ? Row(
                children: [
                  Text('${acc?.name ?? ''}  ·  ',
                      style: TextStyle(
                          fontSize: 11,
                          color: cs.onSurface.withValues(alpha: 0.5))),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      color: cs.secondaryContainer.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.call_split_rounded,
                            size: 10, color: cs.onSecondaryContainer),
                        const SizedBox(width: 2),
                        Text(
                          '${splits.length} ${l10n.split_transactions_title}',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: cs.onSecondaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Text(
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
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
                color: isInc
                    ? const Color(0xFF2E7D32)
                    : (isDark
                        ? const Color(0xFFE57373)
                        : const Color(0xFFC62828))),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        AppHaptics.tap(context, HapticStrength.light);
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? (isDark ? color.withValues(alpha: 0.3) : color)
              : (isDark
                  ? color.withValues(alpha: 0.08)
                  : color.withValues(alpha: 0.08)),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? (isDark ? color.withValues(alpha: 0.5) : Colors.transparent)
                : (isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : color.withValues(alpha: 0.18)),
            width: 1,
          ),
          boxShadow: selected && !isDark
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected
                  ? (isDark ? color : Colors.white)
                  : (isDark ? Colors.white.withValues(alpha: 0.8) : color),
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

    return Material(
      color: isSelected
          ? cs.primaryContainer.withValues(alpha: 0.28)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        leading: selectionMode
            ? Checkbox(value: isSelected, onChanged: (_) => onTap())
            : Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: personColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            isLent ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
            color: personColor,
            size: 20,
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

    final cs = Theme.of(context).colorScheme;

    return Material(
      color: isSelected ? cs.primaryContainer.withValues(alpha: 0.28) : Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        leading: selectionMode
            ? Checkbox(value: isSelected, onChanged: (_) => onTap())
            : Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                    color: loanColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.account_balance_outlined, color: loanColor, size: 20),
              ),
        title: Text(loan?.name ?? 'Loan', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Text(
          [if (acc != null) acc.name, 'Loan Payment'].join('  ·  '),
          style: TextStyle(fontSize: 11, color: cs.onSurface.withValues(alpha: 0.5)),
        ),
        trailing: Text('-${formatAmount(p.amount, displayCurrency)}',
            style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: loanColor)),
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
    
    return Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            Icons.savings_outlined,
            color: color,
            size: 20,
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
  TextEditingController? _activeNumericCtrl;
  bool _showKeypad = false;

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
    final l10n = AppLocalizations.of(context)!;
    final kbOpen = MediaQuery.of(context).viewInsets.bottom > 100;
    final showPad = _showKeypad && !kbOpen;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.transactions_advancedFilters, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {
                      widget.onApply(null, null, null);
                      Navigator.pop(context);
                    },
                    child: Text(l10n.transactions_clearAll),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(l10n.transactions_amountRange, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _minCtrl,
                      readOnly: true,
                      showCursor: true,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _activeNumericCtrl = _minCtrl;
                          _showKeypad = true;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: l10n.transactions_minAmount,
                        prefixIcon: const Icon(Icons.attach_money),
                        suffixIcon: IconButton(
                          icon: Icon(
                            showPad && _activeNumericCtrl == _minCtrl
                                ? Icons.keyboard_hide_outlined
                                : Icons.dialpad_outlined,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {
                            AppHaptics.tap(context, HapticStrength.light);
                            FocusScope.of(context).unfocus();
                            setState(() {
                              if (_showKeypad && _activeNumericCtrl == _minCtrl) {
                                _showKeypad = false;
                              } else {
                                _activeNumericCtrl = _minCtrl;
                                _showKeypad = true;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _maxCtrl,
                      readOnly: true,
                      showCursor: true,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _activeNumericCtrl = _maxCtrl;
                          _showKeypad = true;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: l10n.transactions_maxAmount,
                        prefixIcon: const Icon(Icons.attach_money),
                        suffixIcon: IconButton(
                          icon: Icon(
                            showPad && _activeNumericCtrl == _maxCtrl
                                ? Icons.keyboard_hide_outlined
                                : Icons.dialpad_outlined,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {
                            AppHaptics.tap(context, HapticStrength.light);
                            FocusScope.of(context).unfocus();
                            setState(() {
                              if (_showKeypad && _activeNumericCtrl == _maxCtrl) {
                                _showKeypad = false;
                              } else {
                                _activeNumericCtrl = _maxCtrl;
                                _showKeypad = true;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(l10n.recurring_category, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              CategoryChipPicker(
                categories: widget.app.categories,
                selectedId: _catId,
                onSelected: (id) => setState(() => _catId = id),
              ),
              if (showPad && _activeNumericCtrl != null) ...[
                const SizedBox(height: 12),
                AppNumericKeypad(
                  controller: _activeNumericCtrl!,
                  compact: true,
                  onDone: () => setState(() => _showKeypad = false),
                  onChanged: (_) => setState(() {}),
                ),
              ],
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: () {
                    AppHaptics.tap(context, HapticStrength.light);
                    final minAmt = double.tryParse(_minCtrl.text);
                    final maxAmt = double.tryParse(_maxCtrl.text);
                    widget.onApply(minAmt, maxAmt, _catId);
                    Navigator.pop(context);
                  },
                  child: Text(l10n.transactions_applyFilters),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}


