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

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});
  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String  _search    = '';
  String  _filter    = 'all';   // all|income|expense|lent
  String? _accFilter;

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;

    // ── Build unified item list ─────────────────────────────────────────
    // Each list item is either an AppTransaction or a LendedMoney wrapped
    // in a common class so they can be sorted together.
    final List<_ListItem> allItems = [];

    final showLent = _filter == 'lent';
    final showTx   = _filter != 'lent';

    // Add transactions when not in lent view
    if (showTx) {
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
        allItems.add(_ListItem.transaction(t));
      }
    }

    // Add lended when in lent view
    if (showLent) {
      for (final l in app.lended) {
        if (_search.isNotEmpty) {
          final q = _search.toLowerCase();
          if (!l.personName.toLowerCase().contains(q) &&
              !l.notes.toLowerCase().contains(q)) continue;
        }
        allItems.add(_ListItem.lended(l));
      }
    }

    // Sort by date descending
    allItems.sort((a, b) => b.date.compareTo(a.date));

    // Group by date
    final groups = <String, List<_ListItem>>{};
    for (final item in allItems) {
      final key = DateFormat('yyyy-MM-dd').format(item.date);
      (groups[key] ??= []).add(item);
    }
    final keys = groups.keys.toList()..sort((a, b) => b.compareTo(a));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions',
            style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: Column(children: [
        // ── Search bar ──────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
          child: TextField(
            decoration: InputDecoration(
              hintText: showLent
                  ? 'Search lent & borrowed...'
                  : 'Search transactions...',
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
              for (final f in const [
                ('all',     'All',              0xFF6750A4),
                ('income',  'Income',           0xFF2E7D32),
                ('expense', 'Expenses',         0xFFC62828),
                ('lent',    'Lent & Borrowed',  0xFF0077B6),
              ])
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: _FilterPill(
                    label: f.$2,
                    color: Color(f.$3),
                    selected: _filter == f.$1,
                    onTap: () => setState(() {
                      _filter = f.$1;
                      if (f.$1 == 'lent') _accFilter = null;
                    }),
                  ),
                ),
              // Account filters only when not in lent view
              if (!showLent && app.accounts.isNotEmpty)
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
                  icon: showLent
                      ? Icons.handshake_outlined
                      : Icons.receipt_long_outlined,
                  message: showLent ? 'No lent / borrowed records' : 'No transactions',
                  subMessage: showLent
                      ? 'Go to More → Lent Money to add records'
                      : 'Tap + to add one',
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
                      label = 'Today';
                    } else if (DateFormat('yyyy-MM-dd').format(
                        now.subtract(const Duration(days: 1))) == key) {
                      label = 'Yesterday';
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
                          if (item.transaction != null)
                            _TxTile(t: item.transaction!, app: app)
                          else
                            _LentTile(l: item.lended!, app: app),
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

// ── Unified list item ─────────────────────────────────────────────────────────
class _ListItem {
  final AppTransaction? transaction;
  final LendedMoney?    lended;
  final DateTime        date;

  _ListItem.transaction(AppTransaction t)
      : transaction = t, lended = null, date = t.date;
  _ListItem.lended(LendedMoney l)
      : lended = l, transaction = null, date = l.date;
}

// ── Transaction tile (unchanged from before) ──────────────────────────────────
class _TxTile extends StatelessWidget {
  final AppTransaction t;
  final AppProvider    app;
  const _TxTile({required this.t, required this.app});

  @override
  Widget build(BuildContext context) {
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

// ── Lent / Borrowed tile ──────────────────────────────────────────────────────
class _LentTile extends StatelessWidget {
  final LendedMoney l;
  final AppProvider app;
  const _LentTile({required this.l, required this.app});

  @override
  Widget build(BuildContext context) {
    final cs     = Theme.of(context).colorScheme;
    final isLent = l.type == 'lent';
    final color  = isLent
        ? const Color(0xFF2E7D32)
        : const Color(0xFFC62828);

    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
              isLent
                  ? Icons.arrow_upward_rounded
                  : Icons.arrow_downward_rounded,
              color: color, size: 20),
        ),
        title: Text(l.personName,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Row(children: [
          // Lent / Borrowed badge
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
                color: color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(6)),
            child: Text(isLent ? 'LENT' : 'BORROWED',
                style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: color)),
          ),
          if (l.isSettled) ...[
            const SizedBox(width: 6),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(6)),
              child: const Text('SETTLED',
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2E7D32))),
            ),
          ],
          if (l.dueDate != null) ...[
            const SizedBox(width: 6),
            Text(
              'Due ${DateFormat('d MMM').format(l.dueDate!)}',
              style: TextStyle(
                  fontSize: 10,
                  color: cs.onSurface.withValues(alpha: 0.5)),
            ),
          ],
        ]),
        trailing: Text(
          '${isLent ? '+' : '-'}${formatAmount(l.amount, app.settings.currency)}',
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: color),
        ),
        onTap: () {
          // Navigate to lended screen to view / edit
          LendedScreen.openSheetFromExternal(context, existing: l);
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
