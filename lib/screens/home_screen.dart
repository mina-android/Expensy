// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import 'add_transaction_screen.dart';
import 'transfer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    final currency = app.settings.currency;
    String fmt(double v) => formatAmount(v, currency);
    final now = DateTime.now();
    final recent = List<Transaction>.from(app.transactions)
      ..sort((a, b) => b.date.compareTo(a.date));
    final recentFive = recent.take(5).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Hero header ───────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 222,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [cs.primary, cs.tertiary],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hi, ${app.settings.userName}',
                              style: TextStyle(
                                  color: cs.onPrimary.withValues(alpha: 0.95),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${_monthName(now.month)} ${now.year}',
                                style: TextStyle(
                                    color: cs.onPrimary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('Total Balance',
                            style: TextStyle(
                                color: cs.onPrimary.withValues(alpha: 0.7),
                                fontSize: 12,
                                letterSpacing: 1)),
                        const SizedBox(height: 2),
                        Text(
                          app.settings.hideBalance
                              ? '••••••'
                              : fmt(app.totalBalance),
                          style: TextStyle(
                              color: cs.onPrimary,
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _StatChip(
                              label: 'Income',
                              value: fmt(app.monthIncome),
                              icon: Icons.arrow_downward_rounded,
                              iconColor: const Color(0xFFA5D6A7),
                              cs: cs,
                            ),
                            const SizedBox(width: 10),
                            _StatChip(
                              label: 'Expense',
                              value: fmt(app.monthExpense),
                              icon: Icons.arrow_upward_rounded,
                              iconColor: const Color(0xFFEF9A9A),
                              cs: cs,
                            ),
                            const SizedBox(width: 10),
                            _StatChip(
                              label: 'Net',
                              value: fmt(app.monthIncome - app.monthExpense),
                              icon: app.monthIncome >= app.monthExpense
                                  ? Icons.trending_up_rounded
                                  : Icons.trending_down_rounded,
                              iconColor: app.monthIncome >= app.monthExpense
                                  ? const Color(0xFFA5D6A7)
                                  : const Color(0xFFEF9A9A),
                              cs: cs,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Accounts strip ────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Accounts',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w800)),
                      TextButton.icon(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const TransferScreen())),
                        icon: const Icon(Icons.swap_horiz_rounded, size: 18),
                        label: const Text('Transfer'),
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 128,
                  child: app.accounts.isEmpty
                      ? const Center(
                          child: Text('No accounts yet',
                              style: TextStyle(color: Colors.grey)))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: app.accounts.length,
                          itemBuilder: (_, i) =>
                              _AccountCard(account: app.accounts[i], fmt: fmt),
                        ),
                ),
              ],
            ),
          ),

          // ── Recent transactions ───────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ),

          recentFive.isEmpty
              ? const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(
                        child: Text('No transactions yet',
                            style: TextStyle(color: Colors.grey))),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) {
                      final tx = recentFive[i];
                      final cat = app.categoryById(tx.categoryId);
                      final acc = app.accountById(tx.accountId);
                      return _TxListTile(
                          tx: tx, cat: cat, acc: acc, currency: currency);
                    },
                    childCount: recentFive.length,
                  ),
                ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const AddTransactionScreen())),
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
    );
  }

  String _monthName(int m) => const [
        '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ][m];
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;
  final ColorScheme cs;

  const _StatChip({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(icon, color: iconColor, size: 16),
              const SizedBox(width: 5),
              Text(label,
                  style: TextStyle(
                      color: cs.onPrimary.withValues(alpha: 0.75),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3)),
            ]),
            const SizedBox(height: 5),
            Text(value,
                style: TextStyle(
                    color: cs.onPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w800),
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  final Account account;
  final String Function(double) fmt;
  const _AccountCard({required this.account, required this.fmt});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(account.colorValue),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Color(account.colorValue).withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AccountTypeIcon(type: account.type, size: 18),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(account.type.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const Spacer(),
          Text(fmt(account.balance),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w800),
              overflow: TextOverflow.ellipsis),
          Text(account.name,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

class _TxListTile extends StatelessWidget {
  final Transaction tx;
  final Category? cat;
  final Account? acc;
  final String currency;

  const _TxListTile(
      {required this.tx, this.cat, this.acc, required this.currency});

  @override
  Widget build(BuildContext context) {
    final isIncome = tx.type == 'income';
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: CategoryDot(category: cat, size: 42),
      title: Text(tx.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text('${cat?.name ?? ''} · ${acc?.name ?? ''}',
          style: const TextStyle(fontSize: 12)),
      trailing: AmountText(
        amount: tx.amount,
        currencyCode: currency,
        isIncome: isIncome,
        fontSize: 14,
      ),
    );
  }
}
