import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/savings_goal_sheet.dart';
import '../utils/haptics.dart';
import 'package:intl/intl.dart';

class SavingsGoalDetailScreen extends StatelessWidget {
  final SavingsGoal goal;
  const SavingsGoalDetailScreen({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;

    // The goal instance might have updated
    final currentGoal =
        app.savingsGoals.where((g) => g.id == goal.id).firstOrNull;
    if (currentGoal == null) {
      return Scaffold(body: Center(child: Text(l10n.savings_goalNotFound)));
    }

    final progress = app.goalProgress(currentGoal);
    final color = Color(currentGoal.colorValue);

    return Scaffold(
      appBar: AppBar(
        title: Text(currentGoal.name,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: color,
        foregroundColor:
            color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              AppHaptics.tap(context);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24))),
                builder: (_) => SavingsGoalSheet(existing: currentGoal),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              border: Border(
                  bottom: BorderSide(color: color.withValues(alpha: 0.2))),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.savings_savedSoFar,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600)),
                        Text(
                            formatAmount(currentGoal.currentAmount,
                                currentGoal.currency),
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: color)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(l10n.savings_target,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600)),
                        Text(
                            formatAmount(
                                currentGoal.targetAmount, currentGoal.currency),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 12,
                    color: currentGoal.isCompleted
                        ? const Color(0xFF2E7D32)
                        : color,
                    backgroundColor: color.withValues(alpha: 0.2),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${(progress * 100).toStringAsFixed(1)}%',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: color)),
                    if (currentGoal.targetDate != null)
                      Text(
                          l10n.savings_targetDate(
                              DateFormat('MMM d, yyyy').format(currentGoal.targetDate!)),
                          style: TextStyle(
                              fontSize: 13,
                              color: cs.onSurface.withValues(alpha: 0.6))),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      AppHaptics.tap(context, HapticStrength.light);
                      _showContributionSheet(context, app, currentGoal, true);
                    },
                    icon: const Icon(Icons.add),
                    label: Text(l10n.savings_contribute),
                    style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      AppHaptics.tap(context, HapticStrength.light);
                      _showContributionSheet(context, app, currentGoal, false);
                    },
                    icon: const Icon(Icons.remove),
                    label: Text(l10n.savings_withdraw),
                    style: OutlinedButton.styleFrom(foregroundColor: cs.error),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                final contributions = app.contributionsFor(currentGoal.id);
                if (contributions.isEmpty) {
                  return const EmptyState(
                    icon: Icons.history,
                    message: 'No contributions yet',
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  itemCount: contributions.length,
                  itemBuilder: (context, index) {
                    final c = contributions[index];
                    final isContrib = c.type == 'contribution';
                    final acc = app.accountById(c.accountId);
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: isContrib
                            ? const Color(0xFF2E7D32).withValues(alpha: 0.1)
                            : cs.error.withValues(alpha: 0.1),
                        child: Icon(
                          isContrib ? Icons.arrow_downward : Icons.arrow_upward,
                          color: isContrib ? const Color(0xFF2E7D32) : cs.error,
                        ),
                      ),
                      title: Text(isContrib ? 'Contribution' : 'Withdrawal',
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(
                          '${DateFormat('MMM d, yyyy').format(c.date)} • ${acc?.name ?? 'Unknown Account'}',
                          style: TextStyle(
                              fontSize: 12,
                              color: cs.onSurface.withValues(alpha: 0.6))),
                      trailing: Text(
                        '${isContrib ? '+' : '-'}${formatAmount(c.amount, currentGoal.currency)}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: isContrib
                                ? const Color(0xFF2E7D32)
                                : cs.onSurface),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showContributionSheet(BuildContext context, AppProvider app,
      SavingsGoal goal, bool isContribution) {
    AppHaptics.tap(context, HapticStrength.medium);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _ContributionSheet(
          goal: goal, isContribution: isContribution, app: app),
    );
  }
}

class _ContributionSheet extends StatefulWidget {
  final SavingsGoal goal;
  final bool isContribution;
  final AppProvider app;

  const _ContributionSheet(
      {required this.goal, required this.isContribution, required this.app});

  @override
  State<_ContributionSheet> createState() => _ContributionSheetState();
}

class _ContributionSheetState extends State<_ContributionSheet> {
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  String? _selectedAccountId;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    // Preselect the primary account or the first one with matching currency
    final matches =
        widget.app.nonBankAccounts.where((a) => a.currency == widget.goal.currency);
    if (matches.isNotEmpty) {
      _selectedAccountId = matches.first.id;
    } else if (widget.app.nonBankAccounts.isNotEmpty) {
      _selectedAccountId = widget.app.nonBankAccounts.first.id;
    }
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _submitted = true);
    final amt = double.tryParse(_amountCtrl.text.replaceAll(',', '')) ?? 0.0;
    if (amt <= 0 || _selectedAccountId == null) return;

    if (widget.isContribution) {
      widget.app.contributeToGoal(
        goalId: widget.goal.id,
        fromAccountId: _selectedAccountId!,
        amount: amt, // Amount entered in account currency
        note: _noteCtrl.text.trim(),
      );
    } else {
      widget.app.withdrawFromGoal(
        goalId: widget.goal.id,
        toAccountId: _selectedAccountId!,
        amount: amt, // Amount entered in goal currency
        note: _noteCtrl.text.trim(),
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
              widget.isContribution ? 'Add Contribution' : 'Withdraw from Goal',
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 20),
          if (widget.app.nonBankAccounts.isEmpty)
            Text(l10n.savings_noAccounts)
          else ...[
            DropdownButtonFormField<String>(
              initialValue: _selectedAccountId,
              decoration: InputDecoration(
                labelText:
                    widget.isContribution ? 'From Account' : 'To Account',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: widget.app.nonBankAccounts
                  .map((a) => DropdownMenuItem(
                        value: a.id,
                        child: Text('${a.name} (${a.currency})'),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _selectedAccountId = v),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Amount',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.monetization_on_outlined),
                errorText: _submitted &&
                        (double.tryParse(
                                    _amountCtrl.text.replaceAll(',', '')) ??
                                0.0) <=
                            0
                    ? 'Amount is required'
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _noteCtrl,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: 'Note (Optional)',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.notes),
              ),
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () {
                AppHaptics.tap(context, HapticStrength.light);
                _submit();
              },
              style: FilledButton.styleFrom(
                  backgroundColor: widget.isContribution
                      ? const Color(0xFF2E7D32)
                      : Theme.of(context).colorScheme.error,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))),
              child: Text(
                  widget.isContribution ? 'Add Contribution' : 'Withdraw',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700)),
            ),
          ],
        ],
      ),
    );
  }
}
