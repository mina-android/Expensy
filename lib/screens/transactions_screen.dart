// lib/screens/transactions_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import 'add_transaction_screen.dart';
import 'lended_screen.dart';

// Unified list item — either a Transaction or a LendedMoney entry
class _ListItem {
  final Transaction? tx;
  final LendedMoney? lend;
  DateTime get date => tx?.date ?? lend!.date;
  _ListItem.transaction(this.tx) : lend = null;
  _ListItem.lend(this.lend) : tx = null;
}

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});
  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _filter        = 'all';  // all | income | expense | lent
  String _search        = '';
  String _accountFilter = 'all';
  final _searchCtrl     = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app      = context.watch<AppProvider>();
    final cs       = Theme.of(context).colorScheme;
    final currency = app.settings.currency;

    // Build unified item list
    final items = <_ListItem>[];

    // Regular transactions
    for (final t in app.transactions) {
      if (_filter == 'lent') continue;
      if (_filter != 'all' && t.type != _filter) continue;
      if (_accountFilter != 'all' && t.accountId != _accountFilter) continue;
      if (_search.isNotEmpty &&
          !t.description.toLowerCase().contains(_search.toLowerCase())) { continue; }
      items.add(_ListItem.transaction(t));
    }

    // Lent/borrowed entries
    if (_filter == 'all' || _filter == 'lent') {
      for (final l in app.lended) {
        if (_search.isNotEmpty &&
            !l.personName.toLowerCase().contains(_search.toLowerCase())) { continue; }
        if (_accountFilter != 'all' && l.accountId != _accountFilter) continue;
        items.add(_ListItem.lend(l));
      }
    }

    items.sort((a, b) => b.date.compareTo(a.date));

    // Group by date key
    final grouped = <String, List<_ListItem>>{};
    for (final item in items) {
      final d   = item.date;
      final key = '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
      (grouped[key] ??= []).add(item);
    }
    final dates = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions',
            style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(108),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 6),
                child: SearchBar(
                  controller: _searchCtrl,
                  hintText: 'Search transactions…',
                  leading: const Icon(Icons.search),
                  trailing: _search.isNotEmpty
                      ? [
                          IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => setState(() {
                              _search = '';
                              _searchCtrl.clear();
                            }),
                          ),
                        ]
                      : null,
                  onChanged: (v) => setState(() => _search = v),
                  backgroundColor: WidgetStateProperty.all(
                      cs.surfaceContainerHighest),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                child: Row(
                  children: [
                    for (final f in [
                      ('all',     'All'),
                      ('income',  'Income'),
                      ('expense', 'Expense'),
                      ('lent',    'Lent / Borrowed'),
                    ])
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(f.$2),
                          selected: _filter == f.$1,
                          onSelected: (_) =>
                              setState(() => _filter = f.$1),
                          selectedColor: cs.primaryContainer,
                        ),
                      ),
                    const SizedBox(width: 4),
                    DropdownButton<String>(
                      value: _accountFilter,
                      underline: const SizedBox(),
                      dropdownColor: cs.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(12),
                      items: [
                        const DropdownMenuItem(
                            value: 'all', child: Text('All Accounts')),
                        ...app.accounts.map((a) => DropdownMenuItem(
                            value: a.id, child: Text(a.name))),
                      ],
                      onChanged: (v) =>
                          setState(() => _accountFilter = v ?? 'all'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: items.isEmpty
          ? const EmptyState(
              icon: Icons.receipt_long_outlined,
              message: 'No transactions found',
              subMessage: 'Try adjusting your filters',
            )
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount:
                  dates.fold<int>(0, (s, d) => s + 1 + (grouped[d]?.length ?? 0)),
              itemBuilder: (ctx, i) {
                int offset = 0;
                for (final date in dates) {
                  if (i == offset) {
                    return _DateHeader(
                        dateKey: date,
                        items: grouped[date]!,
                        currency: currency);
                  }
                  offset++;
                  final dayItems = grouped[date]!;
                  if (i < offset + dayItems.length) {
                    final item = dayItems[i - offset];
                    if (item.tx != null) {
                      return _TxCard(
                          tx: item.tx!, app: app, currency: currency);
                    } else {
                      return _LendCard(
                          l: item.lend!, app: app, currency: currency);
                    }
                  }
                  offset += dayItems.length;
                }
                return const SizedBox.shrink();
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const AddTransactionScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ─── Date header ─────────────────────────────────────────────────────────
class _DateHeader extends StatelessWidget {
  final String dateKey;
  final List<_ListItem> items;
  final String currency;

  const _DateHeader({
    required this.dateKey,
    required this.items,
    required this.currency,
  });

  String _label() {
    final d     = DateTime.parse(dateKey);
    final today = DateTime.now();
    final yest  = today.subtract(const Duration(days: 1));
    final todayKey = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    final yestKey  = '${yest.year}-${yest.month.toString().padLeft(2, '0')}-${yest.day.toString().padLeft(2, '0')}';
    if (dateKey == todayKey) return 'Today';
    if (dateKey == yestKey)  return 'Yesterday';
    const months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${d.day} ${months[d.month]} ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    final cs  = Theme.of(context).colorScheme;
    // Net for the day: regular tx only (lent entries are loans, not income/expense)
    final net = items
        .where((i) => i.tx != null)
        .fold(0.0,
            (s, i) => s + (i.tx!.type == 'income' ? i.tx!.amount : -i.tx!.amount));
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
      child: Row(children: [
        Text(_label(),
            style: TextStyle(
                color: cs.primary,
                fontWeight: FontWeight.w700,
                fontSize: 12)),
        const SizedBox(width: 8),
        Expanded(child: Divider(color: cs.outlineVariant)),
        const SizedBox(width: 8),
        if (net != 0)
          Text(
            (net >= 0 ? '+' : '') + formatAmount(net, currency),
            style: TextStyle(
                fontSize: 11,
                color: cs.onSurface.withValues(alpha: 0.5),
                fontWeight: FontWeight.w600),
          ),
      ]),
    );
  }
}

// ─── Regular transaction card ─────────────────────────────────────────────
class _TxCard extends StatelessWidget {
  final Transaction tx;
  final AppProvider app;
  final String currency;
  const _TxCard({required this.tx, required this.app, required this.currency});

  @override
  Widget build(BuildContext context) {
    final cat      = app.categoryById(tx.categoryId);
    final acc      = app.accountById(tx.accountId);
    final isIncome = tx.type == 'income';

    return Dismissible(
      key: Key(tx.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      confirmDismiss: (_) => showDeleteConfirm(context, tx.description),
      onDismissed: (_) => app.deleteTransaction(tx),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        child: ListTile(
          leading: CategoryDot(category: cat, size: 42),
          title: Text(
            tx.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          subtitle: Text(
            '${cat?.name ?? ''} · ${acc?.name ?? ''}',
            style: const TextStyle(fontSize: 12),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AmountText(
                    amount: tx.amount,
                    currencyCode: currency,
                    isIncome: isIncome,
                    fontSize: 14,
                  ),
                  Text(
                    '${tx.date.day}/${tx.date.month}/${tx.date.year}',
                    style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.45)),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 18),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AddTransactionScreen(existing: tx))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Lent/borrowed entry card ─────────────────────────────────────────────
class _LendCard extends StatelessWidget {
  final LendedMoney l;
  final AppProvider app;
  final String currency;
  const _LendCard({required this.l, required this.app, required this.currency});

  @override
  Widget build(BuildContext context) {
    final cs     = Theme.of(context).colorScheme;
    final isLent = l.type == 'lent';
    // Lent = money went out (shown like expense), Borrowed = came in (like income)
    final accent = isLent ? const Color(0xFFC62828) : const Color(0xFF2E7D32);
    final acc    = l.accountId != null ? app.accountById(l.accountId!) : null;

    return Dismissible(
      key: Key('lend_${l.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      confirmDismiss: (_) => showDeleteConfirm(context, l.personName),
      onDismissed: (_) => app.deleteLendedItem(l.id),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: accent.withValues(alpha: 0.25), width: 1),
        ),
        child: ListTile(
          leading: Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isLent ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
              color: accent, size: 20,
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  l.personName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    decoration: l.isSettled ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              _Pill(
                label: isLent ? 'I lent' : 'I borrowed',
                color: accent,
              ),
              if (l.isSettled) ...[
                const SizedBox(width: 4),
                _Pill(label: 'Settled', color: Colors.grey),
              ] else if (l.isOverdue) ...[
                const SizedBox(width: 4),
                _Pill(label: 'Overdue', color: const Color(0xFFC62828)),
              ],
            ],
          ),
          subtitle: Text(
            [
              acc?.name,
              l.dueDate != null
                  ? 'Due ${DateFormat('d MMM').format(l.dueDate!)}'
                  : null,
              l.notes.isNotEmpty ? l.notes : null,
            ].whereType<String>().join(' · '),
            style: const TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isLent ? '-' : '+'}${formatAmount(l.amount, currency)}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: l.isSettled ? Colors.grey : accent,
                    ),
                  ),
                  Text(
                    '${l.date.day}/${l.date.month}/${l.date.year}',
                    style: TextStyle(
                        fontSize: 10,
                        color: cs.onSurface.withValues(alpha: 0.45)),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 18),
                onPressed: () => LendedScreen.openSheet(context, app, existing: l),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final Color color;
  const _Pill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w700, color: color)),
      );
}
