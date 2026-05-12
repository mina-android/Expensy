// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import 'add_transaction_screen.dart';
import 'transfer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    final s   = app.settings;
    String fmt(double v) => formatAmount(v, s.currency);

    final now    = DateTime.now();
    final mStart = DateTime(now.year, now.month, 1);
    final mEnd   = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    final monthTxs = app.transactions
        .where((t) => !t.date.isBefore(mStart) && !t.date.isAfter(mEnd))
        .toList();
    final income  = monthTxs.where((t) => t.type == 'income')
        .fold(0.0, (sum, t) => sum + t.amount);
    final expense = monthTxs.where((t) => t.type == 'expense')
        .fold(0.0, (sum, t) => sum + t.amount);

    final recent = app.transactions.take(5).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Compact greeting + balance header ──────────────────────────
          SliverToBoxAdapter(child: Container(
            color: cs.primary,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              left: 20, right: 8, bottom: 16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, ${s.userName.isNotEmpty ? s.userName : 'there'} \u{1F44B}',
                      style: TextStyle(
                          color: cs.onPrimary.withValues(alpha: 0.85),
                          fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 1),
                    Text('Total Balance', style: TextStyle(
                        color: cs.onPrimary.withValues(alpha: 0.6), fontSize: 12)),
                    Text(
                      s.hideBalance ? '• • • • • •' : fmt(app.totalBalance),
                      style: TextStyle(
                          color: cs.onPrimary,
                          fontSize: 28, fontWeight: FontWeight.w800),
                    ),
                  ],
                )),
                // Action icons – use cs.onPrimary so they're always readable
                IconButton(
                  icon: Icon(
                    s.hideBalance
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: cs.onPrimary,
                  ),
                  onPressed: () => app.updateSetting('hideBalance', !s.hideBalance),
                ),
                IconButton(
                  icon: Icon(Icons.swap_horiz_rounded, color: cs.onPrimary),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const TransferScreen())),
                ),
              ],
            ),
          )),

          SliverToBoxAdapter(child: Column(children: [
            // Month summary chips
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Row(children: [
                Expanded(child: _SummaryChip(label: 'Income',
                    amount: fmt(income), color: const Color(0xFF2E7D32),
                    icon: Icons.arrow_downward_rounded)),
                const SizedBox(width: 8),
                Expanded(child: _SummaryChip(label: 'Expenses',
                    amount: fmt(expense), color: const Color(0xFFC62828),
                    icon: Icons.arrow_upward_rounded)),
                const SizedBox(width: 8),
                Expanded(child: _SummaryChip(label: 'Net',
                    amount: fmt(income - expense),
                    color: income >= expense
                        ? const Color(0xFF1565C0) : const Color(0xFF785900),
                    icon: Icons.account_balance_outlined)),
              ]),
            ),

            // Accounts
            if (app.accounts.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Row(children: [
                  Text('Accounts', style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 15)),
                ]),
              ),
              SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: app.accounts.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (_, i) {
                    final acc   = app.accounts[i];
                    final color = Color(acc.colorValue);
                    return Container(
                      width: 155,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color.withValues(alpha: 0.75), color],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            AccountTypeIcon(type: acc.type, size: 14,
                                color: Colors.white),
                            const SizedBox(width: 4),
                            Expanded(child: Text(acc.name,
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white,
                                    fontSize: 12, fontWeight: FontWeight.w600))),
                          ]),
                          Text(
                            s.hideBalance ? '• • •'
                                : formatAmount(acc.balance, acc.currency),
                            style: const TextStyle(color: Colors.white,
                                fontSize: 14, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],

            // Recent transactions
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Transactions',
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 15)),
                ],
              ),
            ),

            if (recent.isEmpty)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text('No transactions yet',
                    style: TextStyle(
                        color: cs.onSurface.withValues(alpha: 0.4))),
              )
            else
              ...recent.map((t) {
                final acc   = app.accountById(t.accountId);
                final cat   = app.categoryById(t.categoryId);
                final isInc = t.type == 'income';
                return ListTile(
                  leading: CategoryDot(category: cat, size: 40),
                  title: Text(
                    t.description.isNotEmpty ? t.description : t.type,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  subtitle: Text(
                    '${DateFormat('d MMM').format(t.date)} · ${acc?.name ?? ''}',
                    style: TextStyle(fontSize: 11,
                        color: cs.onSurface.withValues(alpha: 0.5)),
                  ),
                  trailing: Text(
                    '${isInc ? '+' : '-'}${fmt(t.amount)}',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,
                        color: isInc
                            ? const Color(0xFF2E7D32)
                            : const Color(0xFFC62828)),
                  ),
                );
              }),

            const SizedBox(height: 100),
          ])),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const AddTransactionScreen())),
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String label, amount;
  final Color color;
  final IconData icon;
  const _SummaryChip({required this.label, required this.amount,
      required this.color, required this.icon});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(icon, size: 11, color: color),
            const SizedBox(width: 3),
            Text(label, style: TextStyle(fontSize: 10, color: color,
                fontWeight: FontWeight.w600)),
          ]),
          const SizedBox(height: 2),
          Text(amount, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800,
                  color: color)),
        ]),
      );
}
