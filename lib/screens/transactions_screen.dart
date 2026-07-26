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

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});
  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String  _search    = '';
  String  _filter    = 'all';   // all|income|expense
  String? _accFilter;

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
        if (_search.isNotEmpty) {
          final q   = _search.toLowerCase();
          final cat = app.categoryById(t.categoryId)?.name.toLowerCase() ?? '';
          final acc = app.accountById(t.accountId)?.name.toLowerCase() ?? '';
          if (!t.description.toLowerCase().contains(q) &&
              !cat.contains(q) && !acc.contains(q)) continue;
        }
        allItems.add(_TxItem.fromTx(t));
      }
    }

    // 2. Add matching lent & borrowed records
    if (_filter == 'all' || _filter == 'lent' || _filter == 'borrowed') {
      for (final l in app.lended) {
        if (_filter != 'all' && l.type != _filter) continue;
        if (_accFilter != null && l.accountId != _accFilter) continue;
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
              !typeStr.contains(q)) continue;
        }
        allItems.add(_TxItem.fromLended(l));
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

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.transactions_transactions,
            style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: Column(children: [
        // ── Search bar ──────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
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
                ('borrowed', l10n.transactions_borrowed,         0xFFE65100),
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
                  padding: const EdgeInsets.fromLTRB(14, 4, 14, 100),
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
                          padding: const EdgeInsets.fromLTRB(2, 10, 0, 4),
                          child: Text(label, style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700,
                              color: cs.primary)),
                        ),
                        for (final item in items)
                          item.isTx
                              ? _TxTile(t: item.tx!, app: app)
                              : _LendedTile(l: item.lended!, app: app),
                      ],
                    );
                  },
                ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => Navigator.push(context,
            ExpensyRoute(builder: (_) => const AddTransactionScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ── Transaction tile ────────────────────────────────────────────────────────
class _TxTile extends StatelessWidget {
  final AppTransaction t;
  final AppProvider    app;
  const _TxTile({required this.t, required this.app});

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
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: CategoryDot(category: cat, size: 40),
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
        onTap: () => Navigator.push(context, ExpensyRoute(
            builder: (_) => AddTransactionScreen(existing: t))),
        onLongPress: () async {
          if (await showDeleteConfirm(
                  context,
                  t.description.isNotEmpty ? t.description : t.type) &&
              context.mounted) {
            context.read<AppProvider>().deleteTransaction(t.id);
          }
        },
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
  const _LendedTile({required this.l, required this.app});

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
        person?.colorValue ?? (isLent ? 0xFF1565C0 : 0xFFE65100));
    final amountColor = isLent ? const Color(0xFF1565C0) : const Color(0xFFE65100);

    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Container(
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
        onTap: () {
          if (person != null) {
            Navigator.push(
              context,
              ExpensyRoute(
                builder: (_) => LendedPersonScreen(person: person),
              ),
            );
          }
        },
        onLongPress: () async {
          if (await showDeleteConfirm(
                context,
                l.notes.isNotEmpty
                    ? l.notes
                    : (isLent ? l10n.transactions_lentTo(person?.name ?? l10n.transactions_unknown) : l10n.transactions_borrowedFrom(person?.name ?? l10n.transactions_unknown)),
              ) &&
              context.mounted) {
            context.read<AppProvider>().deleteLended(l.id);
          }
        },
      ),
    );
  }
}

// ── Unified display item wrapper ────────────────────────────────────────────
class _TxItem {
  final AppTransaction? tx;
  final LendedMoney? lended;
  final DateTime date;

  _TxItem.fromTx(this.tx) : lended = null, date = tx!.date;
  _TxItem.fromLended(this.lended) : tx = null, date = lended!.date;

  bool get isTx => tx != null;
  bool get isLended => lended != null;
}
