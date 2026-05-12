// lib/screens/transactions_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import 'add_transaction_screen.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});
  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _search  = '';
  String _filter  = 'all';  // all|income|expense
  String? _accFilter;

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    String fmt(double v) => formatAmount(v, app.settings.currency);

    var filtered = app.transactions.where((t) {
      if (_filter != 'all' && t.type != _filter) return false;
      if (_accFilter != null && t.accountId != _accFilter) return false;
      if (_search.isNotEmpty) {
        final q = _search.toLowerCase();
        final cat = app.categoryById(t.categoryId)?.name.toLowerCase() ?? '';
        final acc = app.accountById(t.accountId)?.name.toLowerCase() ?? '';
        if (!t.description.toLowerCase().contains(q) &&
            !cat.contains(q) && !acc.contains(q)) return false;
      }
      return true;
    }).toList();

    // Group by date
    final groups = <String, List<AppTransaction>>{};
    for (final t in filtered) {
      final key = DateFormat('yyyy-MM-dd').format(t.date);
      (groups[key] ??= []).add(t);
    }
    final keys = groups.keys.toList()..sort((a, b) => b.compareTo(a));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: Column(children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search transactions...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _search.isNotEmpty
                  ? IconButton(icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => _search = ''))
                  : null,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
            onChanged: (v) => setState(() => _search = v),
          ),
        ),
        // Filter chips
        SizedBox(
          height: 44,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            children: [
              for (final f in const [('all','All'),('income','Income'),('expense','Expenses')])
                Padding(padding: const EdgeInsets.only(right: 6),
                  child: FilterChip(
                    label: Text(f.$2),
                    selected: _filter == f.$1,
                    onSelected: (_) => setState(() => _filter = f.$1),
                  )),
              if (app.accounts.isNotEmpty)
                for (final acc in app.accounts)
                  Padding(padding: const EdgeInsets.only(right: 6),
                    child: FilterChip(
                      label: Text(acc.name),
                      selected: _accFilter == acc.id,
                      onSelected: (_) => setState(() =>
                          _accFilter = _accFilter == acc.id ? null : acc.id),
                    )),
            ],
          ),
        ),

        // List
        Expanded(
          child: filtered.isEmpty
              ? const EmptyState(icon: Icons.receipt_long_outlined,
                  message: 'No transactions', subMessage: 'Tap + to add one')
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(14, 4, 14, 100),
                  itemCount: keys.length,
                  itemBuilder: (_, i) {
                    final key  = keys[i];
                    final txs  = groups[key]!;
                    final date = DateFormat('yyyy-MM-dd').parse(key);
                    final now  = DateTime.now();
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
                        ...txs.map((t) => _TxTile(t: t, app: app, fmt: fmt)),
                      ],
                    );
                  },
                ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const AddTransactionScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TxTile extends StatelessWidget {
  final AppTransaction t;
  final AppProvider app;
  final String Function(double) fmt;
  const _TxTile({required this.t, required this.app, required this.fmt});

  @override
  Widget build(BuildContext context) {
    final cs    = Theme.of(context).colorScheme;
    final cat   = app.categoryById(t.categoryId);
    final isInc = t.type == 'income';

    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: CategoryDot(category: cat, size: 40),
        title: Text(
          t.description.isNotEmpty ? t.description : (cat?.name ?? t.type),
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Text(
          '${app.accountById(t.accountId)?.name ?? ''}  ·  ${cat?.name ?? ''}',
          style: TextStyle(fontSize: 11,
              color: cs.onSurface.withValues(alpha: 0.5))),
        trailing: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            '${isInc ? '+' : '-'}${fmt(t.amount)}',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,
                color: isInc ? const Color(0xFF2E7D32) : const Color(0xFFC62828)),
          ),
          if (t.note.isNotEmpty)
            Icon(Icons.sticky_note_2_outlined, size: 12,
                color: cs.onSurface.withValues(alpha: 0.4)),
        ]),
        onTap: () => Navigator.push(context, MaterialPageRoute(
            builder: (_) => AddTransactionScreen(existing: t))),
        onLongPress: () async {
          if (await showDeleteConfirm(context, t.description.isNotEmpty
              ? t.description : t.type) && context.mounted) {
            context.read<AppProvider>().deleteTransaction(t.id);
          }
        },
      ),
    );
  }
}
