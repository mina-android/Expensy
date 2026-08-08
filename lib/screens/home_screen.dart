// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../utils/snackbar.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import 'add_transaction_screen.dart';
import 'transfer_screen.dart';
import '../utils/haptics.dart';
import 'accounts_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AppTransaction>? _prevTransactions;
  Map<String, double>? _prevRates;
  double _income = 0;
  double _expense = 0;
  List<AppTransaction> _recent = [];

  void _computeTransactions(AppProvider app) {
    if (identical(_prevTransactions, app.transactions) && identical(_prevRates, app.exchangeRates)) return;
    _prevTransactions = app.transactions;
    _prevRates = app.exchangeRates;
    final txs = app.transactions;
    final now = DateTime.now();
    final mStart = DateTime(now.year, now.month, 1);
    final mEnd = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    final monthTxs = txs
        .where((t) => !t.date.isBefore(mStart) && !t.date.isAfter(mEnd))
        .toList();

    _income = 0;
    _expense = 0;

    for (final t in monthTxs) {
      final acc = app.accountById(t.accountId);
      final amt =
          acc != null ? app.convertToMain(t.amount, acc.currency) : t.amount;
      if (t.type == 'income') {
        _income += amt;
      } else if (t.type == 'expense') {
        _expense += amt;
      }
    }

    _recent = txs.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.read<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    
    // Opt-in to specific rebuilds
    context.select<AppProvider, int>((a) => a.transactions.length);
    context.select<AppProvider, int>((a) => a.accounts.length);
    final hideBalance = context.select<AppProvider, bool>((a) => a.settings.hideBalance);
    final currency = context.select<AppProvider, String>((a) => a.settings.currency);
    final userName = context.select<AppProvider, String>((a) => a.settings.userName);
    final totalBalance = context.select<AppProvider, double>((a) => a.totalBalance);

    String fmt(double v) => formatAmount(v, currency);

    _computeTransactions(app);

    return Scaffold(
      body: CustomScrollView(
          slivers: [
            // ── Compact greeting + balance header ──────────────────────────
          SliverToBoxAdapter(
              child: Container(
            color: cs.primary,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              left: 20,
              right: 8,
              bottom: 6,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.home_greeting(userName.isNotEmpty ? userName : l10n.home_there),
                      style: TextStyle(
                          color: cs.onPrimary.withValues(alpha: 0.85),
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 1),
                    Text(l10n.home_totalBalance,
                        style: TextStyle(
                            color: cs.onPrimary.withValues(alpha: 0.6),
                            fontSize: 12)),
                    Text(
                      hideBalance ? '• • • • • •' : fmt(totalBalance),
                      style: TextStyle(
                          color: cs.onPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                )),
                // Action icons – use cs.onPrimary so they're always readable
                IconButton(
                  icon: Icon(
                    hideBalance
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: cs.onPrimary,
                  ),
                  onPressed: () =>
                      app.updateSetting('hideBalance', !hideBalance),
                ),
                IconButton(
                  icon: Icon(Icons.swap_horiz_rounded, color: cs.onPrimary),
                  onPressed: () => Navigator.push(
                      context,
                      ExpensySlideUpRoute(
                          builder: (_) => const TransferScreen())),
                ),
              ],
            ),
          )),

          SliverToBoxAdapter(
              child: Stack(children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 63, // Extends behind the cards
              child: Container(
                color: cs.primary,
              ),
            ),
            Column(children: [
              // Month summary chips
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: Row(children: [
                  Expanded(
                      child: _SummaryChip(
                          label: l10n.home_income,
                          amount: fmt(_income),
                          color: const Color(0xFF2E7D32),
                          icon: Icons.arrow_downward_rounded)),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _SummaryChip(
                          label: l10n.home_expenses,
                          amount: fmt(_expense),
                          color: const Color(0xFFC62828),
                          icon: Icons.arrow_upward_rounded)),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _SummaryChip(
                          label: l10n.home_net,
                          amount: fmt(_income - _expense),
                          color: _income >= _expense
                              ? const Color(0xFF1565C0)
                              : const Color(0xFF785900),
                          icon: Icons.account_balance_outlined)),
                ]),
              ),

              // Accounts
              if (app.accounts.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
                  child: Row(children: [
                    Text(l10n.home_accounts,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 15)),
                  ]),
                ),
                SizedBox(
                  height: 90,
                  child: ReorderableListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    proxyDecorator: (child, index, animation) {
                      return Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                        child: child,
                      );
                    },
                    itemCount: app.accounts.length,
                    onReorderStart: (_) =>
                        AppHaptics.tap(context, HapticStrength.heavy),
                    onReorderItem: (oldIdx, newIdx) {
                      AppHaptics.tap(context, HapticStrength.light);
                      app.reorderAccounts(oldIdx, newIdx);
                    },
                    itemBuilder: (_, i) {
                      final acc = app.accounts[i];
                      final color = Color(acc.colorValue);
                      return GestureDetector(
                        key: ValueKey(acc.id),
                        onTap: () {
                          AppHaptics.tap(context, HapticStrength.light);
                          AccountsScreen.openSheet(context,
                              existing: acc, isCard: acc.type == 'credit');
                        },
                        child: Container(
                            margin: const EdgeInsets.only(right: 10),
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
                                  AccountTypeIcon(
                                      type: acc.type,
                                      size: 14,
                                      color: Colors.white),
                                  const SizedBox(width: 4),
                                  Expanded(
                                      child: Text(acc.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600))),
                                ]),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      hideBalance
                                          ? '• • •'
                                          : (acc.type == 'bank'
                                              ? formatAmount(
                                                  app.getBankTotalBalance(acc.id),
                                                  acc.currency)
                                              : formatAmount(
                                                  acc.balance, acc.currency)),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    if (!hideBalance &&
                                        acc.isGold &&
                                        acc.goldKarat != null &&
                                        acc.goldGrams != null)
                                      Text(
                                        '${acc.goldKarat}k · ${acc.goldGrams!.toStringAsFixed(2)} g',
                                        style: TextStyle(
                                          color:
                                              Colors.white.withValues(alpha: 0.65),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    else if (!hideBalance &&
                                        app.canShowConverted(acc))
                                      Text(
                                        '≈ ${formatAmount(app.convertToMain(acc.type == 'bank' ? app.getBankTotalBalance(acc.id) : acc.balance, acc.currency), currency)}',
                                        style: TextStyle(
                                          color:
                                              Colors.white.withValues(alpha: 0.65),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],

              // Recent transactions
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l10n.home_recentTransactions,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 15)),
                  ],
                ),
              ),

              if (_recent.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: EmptyState(
                    icon: Icons.receipt_long_outlined,
                    message: l10n.home_noTransactionsYet,
                  ),
                )
              else
                ..._recent.map((t) {
                  final acc = app.accountById(t.accountId);
                  final cat = app.categoryById(t.categoryId);
                  final isInc = t.type == 'income';
                  return Dismissible(
                    key: ValueKey(t.id),
                    direction: DismissDirection.startToEnd,
                    background: Container(
                      color: Theme.of(context).colorScheme.error,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      child:
                          const Icon(Icons.delete_outline, color: Colors.white),
                    ),
                    onDismissed: (_) async {
                      AppHaptics.tap(context, HapticStrength.medium);
                      final undo = await app.deleteTransactionWithUndo(t.id);
                      if (context.mounted) {
                        showAppSnackbar(context, 'Transaction deleted',
                            onUndo: undo);
                      }
                    },
                    child: ListTile(
                      onTap: () {
                        AppHaptics.tap(context, HapticStrength.light);
                        Navigator.push(
                          context,
                          ExpensySlideUpRoute(
                            builder: (_) => AddTransactionScreen(existing: t),
                          ),
                        );
                      },
                      leading: CategoryDot(category: cat, size: 40),
                      title: Text(
                        t.description.isNotEmpty ? t.description : t.type,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      subtitle: Text(
                        '${DateFormat('d MMM').format(t.date)} · ${acc?.name ?? ''}',
                        style: TextStyle(
                            fontSize: 11,
                            color: cs.onSurface.withValues(alpha: 0.5)),
                      ),
                      trailing: Text(
                        '${isInc ? '+' : '-'}${fmt(t.amount)}',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: isInc
                                ? const Color(0xFF2E7D32)
                                : const Color(0xFFC62828)),
                      ),
                    ),
                  );
                }),

              const SizedBox(height: 100),
            ])
          ]),
        ),
      ],
    ),
      floatingActionButton: ExpandableFab(
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
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String label, amount;
  final Color color;
  final IconData icon;
  const _SummaryChip(
      {required this.label,
      required this.amount,
      required this.color,
      required this.icon});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withValues(alpha: 0.75), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(icon, size: 11, color: Colors.white),
            const SizedBox(width: 3),
            Text(label,
                style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
          ]),
          const SizedBox(height: 2),
          Text(amount,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.white)),
        ]),
      );
}
