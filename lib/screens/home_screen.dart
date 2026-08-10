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
import 'insights_screen.dart';
import 'yearly_analysis_screen.dart';
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
  double _fixedObligations = 0;
  List<AppTransaction> _recent = [];

  void _computeTransactions(AppProvider app) {
    if (identical(_prevTransactions, app.transactions) &&
        identical(_prevRates, app.exchangeRates)) {
      return;
    }
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

    double recExp = 0;
    for (final r in app.recurring.where((r) => r.paymentType == 'expense')) {
      final amt = app.convertToMain(
          r.amount,
          app.accountById(r.accountId)?.currency ?? app.settings.currency);
      if (r.freqUnit == 'months') {
        recExp += amt / (r.freqVal > 0 ? r.freqVal : 1);
      } else if (r.freqUnit == 'weeks') {
        recExp += (amt * 4.33) / (r.freqVal > 0 ? r.freqVal : 1);
      } else if (r.freqUnit == 'days') {
        recExp += (amt * 30) / (r.freqVal > 0 ? r.freqVal : 1);
      } else if (r.freqUnit == 'years') {
        recExp += amt / (12 * (r.freqVal > 0 ? r.freqVal : 1));
      }
    }
    _fixedObligations = recExp + app.totalMonthlyLoanObligation;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.read<AppProvider>();
    final cs = Theme.of(context).colorScheme;

    context.select<AppProvider, int>((a) => a.transactions.length);
    context.select<AppProvider, int>((a) => a.accounts.length);
    final hideBalance =
        context.select<AppProvider, bool>((a) => a.settings.hideBalance);
    final currency =
        context.select<AppProvider, String>((a) => a.settings.currency);
    final userName =
        context.select<AppProvider, String>((a) => a.settings.userName);
    final totalBalance =
        context.select<AppProvider, double>((a) => a.totalBalance);

    String fmt(double v) => formatAmount(v, currency);

    _computeTransactions(app);

    final now = DateTime.now();
    final daysInMonth = now.day;
    final dailyAvg = daysInMonth > 0 ? _expense / daysInMonth : 0.0;
    final freeCash = _income - _fixedObligations;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Compact Header with Date & Quick Action Icons ────────────
          SliverToBoxAdapter(
            child: Container(
              color: cs.primary,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 12,
                left: 20,
                right: 12,
                bottom: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('EEEE, d MMMM').format(now).toUpperCase(),
                        style: TextStyle(
                          color: cs.onPrimary.withValues(alpha: 0.7),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.all(6),
                            icon: Icon(
                              hideBalance
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: cs.onPrimary,
                              size: 20,
                            ),
                            onPressed: () => app.updateSetting(
                                'hideBalance', !hideBalance),
                          ),
                          IconButton(
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.all(6),
                            icon: Icon(Icons.swap_horiz_rounded,
                                color: cs.onPrimary, size: 20),
                            onPressed: () => Navigator.push(
                              context,
                              ExpensySlideUpRoute(
                                builder: (_) => const TransferScreen(),
                              ),
                            ),
                          ),
                          IconButton(
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.all(6),
                            icon: Icon(Icons.insights_rounded,
                                color: cs.onPrimary, size: 20),
                            onPressed: () => Navigator.push(
                              context,
                              ExpensyRoute(
                                builder: (_) => const InsightsScreen(),
                              ),
                            ),
                          ),
                          IconButton(
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.all(6),
                            icon: Icon(Icons.calendar_month_rounded,
                                color: cs.onPrimary, size: 20),
                            onPressed: () => Navigator.push(
                              context,
                              ExpensyRoute(
                                builder: (_) => const YearlyAnalysisScreen(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.home_greeting(
                        userName.isNotEmpty ? userName : l10n.home_there),
                    style: TextStyle(
                      color: cs.onPrimary.withValues(alpha: 0.9),
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.home_totalBalance,
                    style: TextStyle(
                      color: cs.onPrimary.withValues(alpha: 0.6),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    hideBalance ? '• • • • • •' : fmt(totalBalance),
                    style: TextStyle(
                      color: cs.onPrimary,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Dashboard Body ──────────────────────────────────────────
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 60,
                  child: Container(
                    color: cs.primary,
                  ),
                ),
                Column(
                  children: [
                    // Cash Flow Summary Chips
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: _SummaryChip(
                              label: l10n.home_income,
                              amount: fmt(_income),
                              color: const Color(0xFF2E7D32),
                              icon: Icons.arrow_downward_rounded,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _SummaryChip(
                              label: l10n.home_expenses,
                              amount: fmt(_expense),
                              color: const Color(0xFFC62828),
                              icon: Icons.arrow_upward_rounded,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _SummaryChip(
                              label: l10n.home_net,
                              amount: fmt(_income - _expense),
                              color: _income >= _expense
                                  ? const Color(0xFF1565C0)
                                  : const Color(0xFF785900),
                              icon: Icons.account_balance_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Daily Pace Card (Moved down 3px)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 14),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: cs.outlineVariant.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.local_fire_department_rounded,
                                    size: 16, color: Color(0xFFF57C00)),
                                const SizedBox(width: 6),
                                Text(
                                  'Daily Pace',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: cs.onSurface.withValues(alpha: 0.7),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${fmt(dailyAvg)} / day',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Accounts Section
                    if (app.accounts.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.home_accounts,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 15),
                            ),
                            GestureDetector(
                              onTap: () {
                                AppHaptics.tap(context, HapticStrength.light);
                                app.tabIndexNotifier.value = 3; // Accounts tab
                              },
                              child: Text(
                                'Manage →',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: cs.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 92,
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
                          itemCount: app.accounts.length + 1,
                          onReorderStart: (_) =>
                              AppHaptics.tap(context, HapticStrength.heavy),
                          onReorderItem: (oldIdx, newIdx) {
                            if (oldIdx < app.accounts.length &&
                                newIdx <= app.accounts.length) {
                              AppHaptics.tap(context, HapticStrength.light);
                              app.reorderAccounts(
                                  oldIdx,
                                  newIdx > app.accounts.length
                                      ? app.accounts.length - 1
                                      : newIdx);
                            }
                          },
                          itemBuilder: (_, i) {
                            if (i == app.accounts.length) {
                              // Add Account Button Card
                              return GestureDetector(
                                key: const ValueKey('add_account_card'),
                                onTap: () {
                                  AppHaptics.tap(context, HapticStrength.light);
                                  AccountsScreen.openSheet(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 110,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: cs.surfaceContainerHighest
                                        .withValues(alpha: 0.4),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: cs.outlineVariant
                                          .withValues(alpha: 0.5),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_circle_outline_rounded,
                                          color: cs.primary, size: 24),
                                      const SizedBox(height: 6),
                                      Text(
                                        'Add Account',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: cs.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            final acc = app.accounts[i];
                            final color = Color(acc.colorValue);
                            return GestureDetector(
                              key: ValueKey(acc.id),
                              onTap: () {
                                AppHaptics.tap(context, HapticStrength.light);
                                AccountsScreen.openSheet(context,
                                    existing: acc,
                                    isCard: acc.type == 'credit');
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 155,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      color.withValues(alpha: 0.75),
                                      color
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        AccountTypeIcon(
                                            type: acc.type,
                                            size: 14,
                                            color: Colors.white),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            acc.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          hideBalance
                                              ? '• • •'
                                              : (acc.type == 'bank'
                                                  ? formatAmount(
                                                      app.getBankTotalBalance(
                                                          acc.id),
                                                      acc.currency)
                                                  : formatAmount(acc.balance,
                                                      acc.currency)),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        if (!hideBalance &&
                                            acc.isGold &&
                                            acc.goldKarat != null &&
                                            acc.goldGrams != null)
                                          Text(
                                            '${acc.goldKarat}k · ${acc.goldGrams!.toStringAsFixed(2)} g',
                                            style: TextStyle(
                                              color: Colors.white
                                                  .withValues(alpha: 0.65),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        else if (!hideBalance &&
                                            app.canShowConverted(acc))
                                          Text(
                                            '≈ ${formatAmount(app.convertToMain(acc.type == 'bank' ? app.getBankTotalBalance(acc.id) : acc.balance, acc.currency), currency)}',
                                            style: TextStyle(
                                              color: Colors.white
                                                  .withValues(alpha: 0.65),
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

                    // Recent Transactions Section
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.home_recentTransactions,
                            style: const TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () {
                              AppHaptics.tap(context, HapticStrength.light);
                              app.tabIndexNotifier.value = 1; // Transactions tab
                            },
                            child: Text(
                              'See All →',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: cs.primary,
                              ),
                            ),
                          ),
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
                            child: const Icon(Icons.delete_outline,
                                color: Colors.white),
                          ),
                          onDismissed: (_) async {
                            AppHaptics.tap(context, HapticStrength.medium);
                            final undo =
                                await app.deleteTransactionWithUndo(t.id);
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
                                  builder: (_) =>
                                      AddTransactionScreen(existing: t),
                                ),
                              );
                            },
                            leading: CategoryDot(category: cat, size: 42),
                            title: Text(
                              t.description.isNotEmpty
                                  ? t.description
                                  : t.type,
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: isInc
                                      ? const Color(0xFF2E7D32)
                                      : const Color(0xFFC62828)),
                            ),
                          ),
                        );
                      }),

                    const SizedBox(height: 140),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 76),
        child: ExpandableFab(
          label: l10n.home_add,
          onIncome: () => Navigator.push(
            context,
            ExpensySlideUpRoute(
              builder: (_) => const AddTransactionScreen(initialType: 'income'),
            ),
          ),
          onExpense: () => Navigator.push(
            context,
            ExpensySlideUpRoute(
              builder: (_) =>
                  const AddTransactionScreen(initialType: 'expense'),
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String label, amount;
  final Color color;
  final IconData icon;
  const _SummaryChip({
    required this.label,
    required this.amount,
    required this.color,
    required this.icon,
  });

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 11, color: Colors.white),
                const SizedBox(width: 3),
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              amount,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
          ],
        ),
      );
}


