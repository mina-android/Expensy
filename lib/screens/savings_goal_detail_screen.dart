import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/savings_goal_sheet.dart';
import '../widgets/app_numeric_keypad.dart';
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

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(currentGoal.name,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
                ),
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
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: cs.onSurface.withValues(alpha: 0.6))),
                          const SizedBox(height: 4),
                          Text(
                              formatAmount(currentGoal.currentAmount,
                                  currentGoal.currency),
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: color)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(l10n.savings_target,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: cs.onSurface.withValues(alpha: 0.6))),
                          const SizedBox(height: 4),
                          Text(
                              formatAmount(
                                  currentGoal.targetAmount, currentGoal.currency),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      color: currentGoal.isCompleted
                          ? const Color(0xFF2E7D32)
                          : color,
                      backgroundColor: color.withValues(alpha: 0.15),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${(progress * 100).toStringAsFixed(1)}%',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: color)),
                      if (currentGoal.targetDate != null)
                        Text(
                            l10n.savings_targetDate(
                                DateFormat('MMM d, yyyy').format(currentGoal.targetDate!)),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: cs.onSurface.withValues(alpha: 0.55))),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (app.wishlistForGoal(currentGoal) != null) ...[
            Builder(builder: (context) {
              final linkedWishlist = app.wishlistForGoal(currentGoal)!;
              return Container(
                margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: const Color(0xFF2E7D32).withValues(alpha: 0.25)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: Color(0xFF2E7D32), size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.savings_linkedWishlist(linkedWishlist.name),
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2E7D32)),
                          ),
                          if (linkedWishlist.isPurchased)
                            Text(
                              l10n.transactions_settled,
                              style: TextStyle(
                                fontSize: 11,
                                color: cs.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
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
                  return EmptyState(
                    icon: Icons.history,
                    message: l10n.savings_noContributionsYet,
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  itemCount: contributions.length,
                  itemBuilder: (context, index) {
                    final c = contributions[index];
                    final isContrib = c.type == 'contribution';
                    final acc = app.accountById(c.accountId);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
                        ),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        leading: CircleAvatar(
                          backgroundColor: isContrib
                              ? const Color(0xFF2E7D32).withValues(alpha: 0.12)
                              : cs.error.withValues(alpha: 0.12),
                          child: Icon(
                            isContrib ? Icons.arrow_downward : Icons.arrow_upward,
                            color: isContrib ? const Color(0xFF2E7D32) : cs.error,
                          ),
                        ),
                        title: Text(isContrib ? l10n.savings_contribution : l10n.savings_withdrawal,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                        subtitle: Text(
                            '${DateFormat('MMM d, yyyy').format(c.date)} • ${acc?.name ?? l10n.savings_unknownAccount}',
                            style: TextStyle(
                                fontSize: 12,
                                color: cs.onSurface.withValues(alpha: 0.55))),
                        trailing: Text(
                          '${isContrib ? '+' : '-'}${formatAmount(c.amount, currentGoal.currency)}',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: isContrib
                                  ? const Color(0xFF2E7D32)
                                  : cs.onSurface),
                        ),
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
  bool _showKeypad = true;

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
              widget.isContribution ? l10n.savings_addContribution : l10n.savings_withdrawFromGoal,
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
                    widget.isContribution ? l10n.savings_fromAccount : l10n.savings_toAccount,
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
              readOnly: true,
              showCursor: true,
              onTap: () {
                FocusScope.of(context).unfocus();
                setState(() => _showKeypad = true);
              },
              decoration: InputDecoration(
                labelText: l10n.add_transaction_amount,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.monetization_on_outlined),
                suffixIcon: _showKeypad
                    ? IconButton(
                        icon: const Icon(Icons.keyboard_hide_outlined),
                        onPressed: () => setState(() => _showKeypad = false),
                      )
                    : null,
                errorText: _submitted &&
                        (double.tryParse(
                                    _amountCtrl.text.replaceAll(',', '')) ??
                                0.0) <=
                            0
                    ? l10n.savings_amountRequired
                    : null,
              ),
            ),
            if (_showKeypad &&
                MediaQuery.of(context).viewInsets.bottom < 100) ...[
              const SizedBox(height: 8),
              AppNumericKeypad(
                compact: true,
                controller: _amountCtrl,
                onChanged: (_) => setState(() {}),
                onDone: () => setState(() => _showKeypad = false),
              ),
            ],
            const SizedBox(height: 16),
            TextField(
              controller: _noteCtrl,
              textCapitalization: TextCapitalization.sentences,
              onTap: () {
                if (_showKeypad) setState(() => _showKeypad = false);
              },
              decoration: InputDecoration(
                labelText: l10n.savings_noteOptional,
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
                  widget.isContribution ? l10n.savings_addContribution : l10n.savings_withdraw,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700)),
            ),
          ],
        ],
      ),
    );
  }
}
