// lib/screens/budget_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/fintech_components.dart';
import '../widgets/savings_goal_sheet.dart';
import '../widgets/app_numeric_keypad.dart';
import 'savings_goal_detail_screen.dart';
import '../utils/haptics.dart';
import '../utils/snackbar.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  static void _openSheet(BuildContext context, {Budget? existing}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _BudgetSheet(existing: existing),
    );
  }

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  int _tabIndex = 0; // 0 = Budgets, 1 = Goals

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tabRose = isDark ? const Color(0xFFF06292) : const Color(0xFFD81B60);
    final cur = app.settings.currency;

    final overCount = app.budgets.where(app.budgetExceeded).length;
    final totalBudgeted = app.budgets.fold(0.0, (s, b) => s + app.budgetEffectiveAllowance(b));
    final totalSpent    = app.budgets.fold(0.0, (s, b) => s + app.budgetSpent(b));
    final overallPacing = app.overallMonthlyBudgetPacing();

    // Calculate total monthly recurring income in main currency
    final recurringIncomes = app.recurring.where((r) => r.paymentType == 'income');
    double totalMonthlyIncome = 0.0;
    for (final r in recurringIncomes) {
      final amountInMain = app.convertToMain(r.amount, app.accountById(r.accountId)?.currency ?? cur);
      double multiplier = 1.0;
      switch (r.freqUnit) {
        case 'days':
          multiplier = 30.0 / r.freqVal;
          break;
        case 'weeks':
          multiplier = 52.0 / 12.0 / r.freqVal;
          break;
        case 'months':
          multiplier = 1.0 / r.freqVal;
          break;
        case 'years':
          multiplier = 1.0 / (12.0 * r.freqVal);
          break;
      }
      totalMonthlyIncome += amountInMain * multiplier;
    }

    // Calculate total monthly budgets in main currency
    double totalMonthlyBudgets = 0.0;
    for (final b in app.budgets) {
      final eff = app.budgetEffectiveAllowance(b);
      if (b.period == 'weekly') {
        totalMonthlyBudgets += eff * 52.0 / 12.0;
      } else {
        totalMonthlyBudgets += eff;
      }
    }

    final leftToSpend = totalMonthlyIncome - totalMonthlyBudgets;

    final goals = app.savingsGoals;
    final totalSaved = app.totalSaved;
    final totalTarget = goals.fold(0.0, (s, g) => s + app.convertToMain(g.targetAmount, g.currency));
    final goalsProgress = totalTarget > 0 ? (totalSaved / totalTarget).clamp(0.0, 1.0) : 0.0;
    final budgetProgress = totalBudgeted > 0 ? (totalSpent / totalBudgeted).clamp(0.0, 1.0) : 0.0;

    return Scaffold(
      body: Column(
        children: [
          // ── Transparent Edge-to-Edge Header ────────────────────────
          FintechHeader(
            title: l10n.budget_budgetsAndGoals,
            subtitle: '${app.budgets.length} ${l10n.budget_budgets.toLowerCase()} · ${goals.length} goals',
          ),

          // ── Elevated Budget & Pacing Hero Card ──────────────────────
          FintechHeroCard(
            accentColor: tabRose,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: _tabIndex == 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: tabRose.withValues(alpha: isDark ? 0.25 : 0.12),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: tabRose.withValues(alpha: isDark ? 0.4 : 0.25),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.speed_rounded, size: 12, color: tabRose),
                                const SizedBox(width: 5),
                                Text(
                                  l10n.budget_budgets.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.5,
                                    color: tabRose,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (overallPacing != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: overallPacing.isOnTrack
                                    ? const Color(0xFF2E7D32).withValues(alpha: isDark ? 0.25 : 0.12)
                                    : (overallPacing.isCaution
                                        ? Colors.orange.withValues(alpha: isDark ? 0.25 : 0.12)
                                        : const Color(0xFFC62828).withValues(alpha: isDark ? 0.25 : 0.12)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                overallPacing.isOnTrack
                                    ? l10n.pacing_onTrack
                                    : (overallPacing.isCaution ? l10n.pacing_fast : l10n.pacing_alert),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: overallPacing.isOnTrack
                                      ? (isDark ? const Color(0xFF81C784) : const Color(0xFF2E7D32))
                                      : (overallPacing.isCaution
                                          ? (isDark ? const Color(0xFFFFB74D) : const Color(0xFFE65100))
                                          : (isDark ? const Color(0xFFE57373) : const Color(0xFFC62828))),
                                ),
                              ),
                            )
                          else if (overCount > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: cs.errorContainer.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                l10n.budget_overLimit,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: cs.error,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            overallPacing != null
                                ? formatAmount(overallPacing.safeDailyAllowance, cur)
                                : formatAmount(leftToSpend, cur),
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            overallPacing != null ? '/ day' : l10n.budget_leftToSpend.toLowerCase(),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: cs.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: budgetProgress,
                          minHeight: 6,
                          backgroundColor: cs.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            budgetProgress >= 1.0 ? cs.error : tabRose,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${l10n.budget_spent}: ${formatAmount(totalSpent, cur)}',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: cs.onSurface.withValues(alpha: 0.6)),
                          ),
                          Text(
                            '${l10n.budget_budgeted}: ${formatAmount(totalBudgeted, cur)}',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: cs.onSurface.withValues(alpha: 0.6)),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: tabRose.withValues(alpha: isDark ? 0.25 : 0.12),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: tabRose.withValues(alpha: isDark ? 0.4 : 0.25),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.savings_outlined, size: 12, color: tabRose),
                                const SizedBox(width: 5),
                                Text(
                                  'SAVINGS GOALS',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.5,
                                    color: tabRose,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${(goalsProgress * 100).toStringAsFixed(0)}% saved',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: tabRose,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        formatAmount(totalSaved, cur),
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'of ${formatAmount(totalTarget, cur)} target',
                        style: TextStyle(fontSize: 12, color: cs.onSurface.withValues(alpha: 0.55)),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: goalsProgress,
                          minHeight: 6,
                          backgroundColor: cs.surfaceContainerHighest,
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
                        ),
                      ),
                    ],
                  ),
          ),

          // ── Pill Segmented Control (Budgets / Goals) ────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
            child: FintechSegmentedControl<int>(
              activeColor: tabRose,
              selectedValue: _tabIndex,
              onValueChanged: (val) => setState(() => _tabIndex = val),
              items: [
                FintechSegmentItem<int>(
                  value: 0,
                  label: l10n.budget_budgets,
                  icon: Icons.pie_chart_outline_rounded,
                  badge: '${app.budgets.length}',
                ),
                FintechSegmentItem<int>(
                  value: 1,
                  label: 'Goals',
                  icon: Icons.savings_outlined,
                  badge: '${goals.length}',
                ),
              ],
            ),
          ),

          // ── Tab Content ─────────────────────────────────────────────
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _tabIndex == 0
                  ? (app.budgets.isEmpty
                      ? EmptyState(
                          icon: Icons.account_balance_wallet_outlined,
                          message: l10n.budget_noBudgetsYet,
                          subMessage: l10n.budget_tapToAddBudget,
                        )
                      : ListView.builder(
                          key: const ValueKey('budgets_list'),
                          padding: const EdgeInsets.fromLTRB(14, 4, 14, 140),
                          itemCount: app.budgets.length,
                          itemBuilder: (_, i) => _BudgetCard(
                            budget: app.budgets[i],
                            app: app,
                          ),
                        ))
                  : (goals.isEmpty
                      ? EmptyState(
                          icon: Icons.savings_outlined,
                          message: l10n.savings_noGoalsYet,
                          subMessage: l10n.savings_tapToAddGoal,
                        )
                      : ListView.builder(
                          key: const ValueKey('goals_list'),
                          padding: const EdgeInsets.fromLTRB(14, 4, 14, 140),
                          itemCount: goals.length,
                          itemBuilder: (_, i) => _GoalCard(
                            goal: goals[i],
                            app: app,
                          ),
                        )),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 84, right: 4),
        child: ExpandableFab(
          label: l10n.home_add,
          color: tabRose,
          items: [
            ExpandableFabItem(
              label: l10n.budget_addBudget,
              icon: Icons.pie_chart_rounded,
              color: tabRose,
              onTap: () => BudgetScreen._openSheet(context),
            ),
            ExpandableFabItem(
              label: l10n.budget_addGoal,
              icon: Icons.savings_rounded,
              color: tabRose,
              onTap: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
                builder: (_) => const SavingsGoalSheet(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Budget card ───────────────────────────────────────────────────────────────
class _BudgetCard extends StatelessWidget {
  final Budget budget;
  final AppProvider app;
  const _BudgetCard({required this.budget, required this.app});

  Color _barColor(double progress, ColorScheme cs) {
    if (progress >= 1.0) return cs.error;
    if (progress >= 0.75) return Colors.orange;
    return cs.primary;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs        = Theme.of(context).colorScheme;
    final isDark    = Theme.of(context).brightness == Brightness.dark;
    final cat       = app.categoryById(budget.categoryId);
    final spent     = app.budgetSpent(budget);
    final allowance = app.budgetEffectiveAllowance(budget);
    final rollover  = app.budgetRollover(budget);
    final progress  = app.budgetProgress(budget);
    final exceeded  = app.budgetExceeded(budget);
    final barColor  = _barColor(progress, cs);
    final cur       = app.settings.currency;
    final pacing    = app.budgetPacing(budget);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => BudgetScreen._openSheet(context, existing: budget),
          onLongPress: () async {
            if (await showDeleteConfirm(context, cat?.name ?? l10n.budget_budget) &&
                context.mounted) {
              final undo = await context.read<AppProvider>().deleteBudgetWithUndo(budget.id);
              if (context.mounted) {
                showAppSnackbar(
                  context,
                  'Deleted ${cat?.name ?? 'Budget'}',
                  onUndo: undo,
                );
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                CategoryDot(category: cat, size: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(cat?.name ?? l10n.budget_unknown,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15)),
                    Row(children: [
                      Text(
                        budget.period == 'weekly' ? l10n.budget_weeklyLabel : l10n.budget_monthlyLabel,
                        style: TextStyle(
                            fontSize: 11,
                            color: cs.onSurface.withValues(alpha: 0.5)),
                      ),
                      Text(l10n.budget_empty,
                          style: TextStyle(
                              color: cs.onSurface.withValues(alpha: 0.3))),
                      Text(
                        formatAmount(budget.amount, cur),
                        style: TextStyle(
                            fontSize: 11,
                            color: cs.onSurface.withValues(alpha: 0.5)),
                      ),
                      if (budget.allowRollover) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: cs.primaryContainer,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.autorenew_rounded,
                                  size: 10, color: cs.onPrimaryContainer),
                              const SizedBox(width: 2),
                              Text(
                                l10n.budget_rolloverBadge,
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: cs.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ]),
                  ]),
                ),
                // Spent / remaining pill
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(
                    formatAmount(spent, cur),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: barColor),
                  ),
                  Text(
                    exceeded
                        ? l10n.budget_overAmount(formatAmount(spent - allowance, cur))
                        : l10n.budget_leftAmount(formatAmount(allowance - spent, cur)),
                    style: TextStyle(
                        fontSize: 10,
                        color: exceeded
                            ? cs.error
                            : cs.onSurface.withValues(alpha: 0.5)),
                  ),
                ]),
              ]),
              const SizedBox(height: 10),
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: barColor.withValues(alpha: 0.12),
                  valueColor: AlwaysStoppedAnimation<Color>(barColor),
                ),
              ),
              const SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  l10n.budget_percentUsed((progress * 100).toStringAsFixed(0)),
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: barColor),
                ),
                if (exceeded)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: cs.errorContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(l10n.budget_overBudget,
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: cs.onErrorContainer)),
                  ),
              ]),
              if (budget.allowRollover) ...[
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${l10n.budget_base(formatAmount(budget.amount, cur))}  •  ${l10n.budget_rolloverFrom(app.previousPeriodName(budget, l10n.budget_lastWeek), (rollover > 0 ? '+' : '') + formatAmount(rollover, cur))}  •  ${l10n.budget_totalAvailable(formatAmount(allowance, cur))}',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface.withValues(alpha: 0.75),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              _BudgetPacingRow(pacing: pacing, cur: cur, l10n: l10n),
            ]),
          ),
        ),
      ),
    );
  }
}

// ── Budget Pacing Row ────────────────────────────────────────────────────────
class _BudgetPacingRow extends StatelessWidget {
  final BudgetPacingInfo pacing;
  final String cur;
  final AppLocalizations l10n;

  const _BudgetPacingRow({
    required this.pacing,
    required this.cur,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color bgTint;
    final Color fgColor;
    final Color borderTint;
    final IconData statusIcon;
    final String statusMessage;

    switch (pacing.status) {
      case BudgetPacingStatus.onTrack:
        bgTint = const Color(0xFF2E7D32).withValues(alpha: isDark ? 0.16 : 0.08);
        fgColor = isDark ? const Color(0xFF81C784) : const Color(0xFF2E7D32);
        borderTint = const Color(0xFF2E7D32).withValues(alpha: isDark ? 0.35 : 0.22);
        statusIcon = Icons.check_circle_outline_rounded;
        statusMessage = l10n.pacing_safeToSpend(
          formatAmount(pacing.safeDailyAllowance, cur),
          pacing.daysRemaining.toString(),
        );
        break;
      case BudgetPacingStatus.caution:
        bgTint = Colors.orange.withValues(alpha: isDark ? 0.16 : 0.08);
        fgColor = isDark ? const Color(0xFFFFB74D) : const Color(0xFFE65100);
        borderTint = Colors.orange.withValues(alpha: isDark ? 0.35 : 0.22);
        statusIcon = Icons.speed_rounded;
        statusMessage = l10n.pacing_caution(
          formatAmount(pacing.safeDailyAllowance, cur),
        );
        break;
      case BudgetPacingStatus.overPaced:
        bgTint = const Color(0xFFD32F2F).withValues(alpha: isDark ? 0.16 : 0.08);
        fgColor = isDark ? const Color(0xFFE57373) : const Color(0xFFC62828);
        borderTint = const Color(0xFFD32F2F).withValues(alpha: isDark ? 0.35 : 0.22);
        statusIcon = Icons.warning_amber_rounded;
        statusMessage = l10n.pacing_overPaced;
        break;
      case BudgetPacingStatus.exceeded:
        bgTint = cs.errorContainer.withValues(alpha: isDark ? 0.25 : 0.4);
        fgColor = cs.error;
        borderTint = cs.error.withValues(alpha: isDark ? 0.35 : 0.25);
        statusIcon = Icons.error_outline_rounded;
        statusMessage = l10n.pacing_budgetExhausted;
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgTint,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderTint, width: 0.8),
      ),
      child: Row(
        children: [
          Icon(statusIcon, size: 14, color: fgColor),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              statusMessage,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
                color: fgColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Goal card ───────────────────────────────────────────────────────────────
class _GoalCard extends StatelessWidget {
  final SavingsGoal goal;
  final AppProvider app;
  const _GoalCard({required this.goal, required this.app});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = app.goalProgress(goal);
    final isCompleted = goal.isCompleted;
    final barColor = isCompleted ? const Color(0xFF2E7D32) : cs.primary;
    final color = Color(goal.colorValue);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              ExpensyRoute(builder: (_) => SavingsGoalDetailScreen(goal: goal)),
            );
          },
          onLongPress: () async {
            if (await showDeleteConfirm(context, goal.name) && context.mounted) {
              final undo = await context.read<AppProvider>().deleteSavingsGoalWithUndo(goal.id);
              if (context.mounted) {
                showAppSnackbar(
                  context,
                  'Deleted ${goal.name}',
                  onUndo: undo,
                );
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(Icons.savings_outlined, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(goal.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15)),
                    if (goal.targetDate != null)
                      Text(
                        'Target: ${goal.targetDate}',
                        style: TextStyle(
                            fontSize: 11,
                            color: cs.onSurface.withValues(alpha: 0.5)),
                      ),
                  ]),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(
                    formatAmount(goal.currentAmount, goal.currency),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: barColor),
                  ),
                  Text(
                    isCompleted ? 'Completed' : 'of ${formatAmount(goal.targetAmount, goal.currency)}',
                    style: TextStyle(
                        fontSize: 10,
                        color: isCompleted ? const Color(0xFF2E7D32) : cs.onSurface.withValues(alpha: 0.5)),
                  ),
                ]),
              ]),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  color: barColor,
                  backgroundColor: barColor.withValues(alpha: 0.15),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

// ── Budget sheet ──────────────────────────────────────────────────────────────
class _BudgetSheet extends StatefulWidget {
  final Budget? existing;
  const _BudgetSheet({this.existing});
  @override
  State<_BudgetSheet> createState() => _BudgetSheetState();
}

class _BudgetSheetState extends State<_BudgetSheet> {
  final _amtCtrl = TextEditingController();
  String? _categoryId;
  String  _period = 'monthly';
  bool _allowRollover = false;
  bool _submitted = false;
  bool _showKeypad = true;

  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    if (isEdit) {
      final e = widget.existing!;
      _amtCtrl.text = e.amount.toStringAsFixed(2);
      _categoryId   = e.categoryId;
      _period       = e.period;
      _allowRollover = e.allowRollover;
    } else {
      // Default to first expense category not yet budgeted
      final app = context.read<AppProvider>();
      final expCats = app.categories.where((c) => c.type == 'expense').toList();
      final budgetedIds = app.budgets.map((b) => b.categoryId).toSet();
      final free = expCats.where((c) => !budgetedIds.contains(c.id)).toList();
      if (free.isNotEmpty) {
        _categoryId = free.first.id;
      } else if (expCats.isNotEmpty) {
        _categoryId = expCats.first.id;
      }
    }
  }

  @override
  void dispose() {
    _amtCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    final amount = double.tryParse(_amtCtrl.text);
    if (amount == null || amount <= 0 || _categoryId == null) return;
    final app = context.read<AppProvider>();
    final l10n = AppLocalizations.of(context)!;

    // Guard: if adding and category already has a budget, block it
    if (!isEdit) {
      final existing = app.budgetForCategory(_categoryId!);
      if (existing != null) {
        if (!mounted) return;
        showAppSnackbar(context, l10n.budget_thisCategoryAlreadyH);
        return;
      }
    }

    final b = Budget(
      id: isEdit ? widget.existing!.id : app.newId(),
      categoryId: _categoryId!,
      amount: amount,
      period: _period,
      createdAt: isEdit ? widget.existing!.createdAt : DateTime.now(),
      allowRollover: _allowRollover,
    );

    if (isEdit) {
      await app.updateBudget(b);
    } else {
      await app.addBudget(b);
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app     = context.watch<AppProvider>();
    final cs      = Theme.of(context).colorScheme;
    final sym     = currencyInfo(app.settings.currency).symbol;
    final expCats = app.categories.where((c) => c.type == 'expense').toList();

    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 20, right: 20, top: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEdit ? l10n.budget_editBudget : l10n.budget_setBudget,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),

            // Amount
            TextField(
              controller: _amtCtrl,
              readOnly: true,
              showCursor: true,
              onTap: () {
                FocusScope.of(context).unfocus();
                setState(() => _showKeypad = true);
              },
              decoration: InputDecoration(
                labelText: l10n.budget_budgetAmount,
                prefixText: '$sym ',
                suffixIcon: _showKeypad
                    ? IconButton(
                        icon: const Icon(Icons.keyboard_hide_outlined),
                        onPressed: () => setState(() => _showKeypad = false),
                      )
                    : null,
                errorText: _submitted && (double.tryParse(_amtCtrl.text) ?? 0) <= 0 ? l10n.error_required : null,
              ),
              onChanged: (_) => setState(() {}),
            ),
            if (_showKeypad && MediaQuery.of(context).viewInsets.bottom < 100) ...[
              const SizedBox(height: 8),
              AppNumericKeypad(
                compact: true,
                controller: _amtCtrl,
                onChanged: (_) => setState(() {}),
                onDone: () => setState(() => _showKeypad = false),
              ),
            ],
            const SizedBox(height: 16),

            // Period selector
            Text(l10n.budget_period,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(letterSpacing: 1)),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _period = 'monthly'),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 140),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: _period == 'monthly'
                          ? cs.primary
                          : cs.primaryContainer.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(l10n.budget_monthly,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: _period == 'monthly'
                                  ? cs.onPrimary
                                  : cs.primary)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _period = 'weekly'),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 140),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: _period == 'weekly'
                          ? cs.secondary
                          : cs.secondaryContainer.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(l10n.budget_weekly,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: _period == 'weekly'
                                  ? cs.onSecondary
                                  : cs.secondary)),
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 16),

            // Category
            if (expCats.isNotEmpty) ...[
              Text(l10n.budget_category,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(letterSpacing: 1)),
              const SizedBox(height: 8),
              CategoryChipPicker(
                categories: expCats,
                selectedId: _categoryId,
                onSelected: (id) => setState(() => _categoryId = id),
              ),
              const SizedBox(height: 16),
            ],

            // Rollover (Envelope) toggle
            Material(
              color: cs.surfaceContainerHighest.withValues(alpha: 0.35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: _allowRollover
                      ? cs.primary.withValues(alpha: 0.4)
                      : cs.outlineVariant.withValues(alpha: 0.3),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: SwitchListTile(
                value: _allowRollover,
                onChanged: (val) {
                  AppHaptics.tap(context, HapticStrength.selection);
                  setState(() => _allowRollover = val);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                secondary: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: _allowRollover
                        ? cs.primary.withValues(alpha: 0.15)
                        : cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.autorenew_rounded,
                    color: _allowRollover ? cs.primary : cs.onSurfaceVariant,
                    size: 20,
                  ),
                ),
                title: Text(
                  l10n.budget_rollover,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  l10n.budget_rolloverDesc,
                  style: TextStyle(
                    fontSize: 11,
                    color: cs.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Preview
            if (_categoryId != null &&
                double.tryParse(_amtCtrl.text) != null &&
                double.parse(_amtCtrl.text) > 0) ...[
              Builder(builder: (ctx) {
                final baseAmt = double.parse(_amtCtrl.text);
                final testBudget = Budget(
                  id: isEdit ? widget.existing!.id : '',
                  categoryId: _categoryId!,
                  amount: baseAmt,
                  period: _period,
                  createdAt: isEdit ? widget.existing!.createdAt : DateTime.now(),
                  allowRollover: _allowRollover,
                );
                final spent = app.budgetSpent(testBudget);
                final allowance = app.budgetEffectiveAllowance(testBudget);
                final rollover = app.budgetRollover(testBudget);
                final pct = allowance > 0 ? (spent / allowance).clamp(0.0, 1.0) : 1.0;
                final catName = app.categoryById(_categoryId!)?.name ?? '';
                final cur = app.settings.currency;

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.budget_previewFor(catName),
                              style: TextStyle(
                                  fontSize: 11,
                                  color: cs.onSurface.withValues(alpha: 0.6))),
                          if (_allowRollover)
                            Text(
                              '${l10n.budget_rolloverBadge}: ${(rollover >= 0 ? '+' : '') + formatAmount(rollover, cur)}',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: rollover >= 0
                                    ? const Color(0xFF2E7D32)
                                    : cs.error,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.budget_spentAmount(formatAmount(spent, cur)),
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            _allowRollover
                                ? '${l10n.budget_ofAmount(formatAmount(allowance, cur))} (${formatAmount(baseAmt, cur)})'
                                : l10n.budget_ofAmount(formatAmount(baseAmt, cur)),
                            style: TextStyle(
                                fontSize: 12,
                                color: cs.onSurface.withValues(alpha: 0.5)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: pct,
                          minHeight: 5,
                          backgroundColor:
                              cs.primary.withValues(alpha: 0.12),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            pct >= 1.0
                                ? cs.error
                                : pct >= 0.75
                                    ? Colors.orange
                                    : cs.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 16),
            ],

            FilledButton.icon(
              onPressed: () { AppHaptics.tap(context, HapticStrength.light); _submit(); },
              icon: Icon(isEdit ? Icons.save_outlined : Icons.add),
              label: Text(isEdit ? l10n.budget_saveChanges : l10n.budget_setBudget),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28)),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}


