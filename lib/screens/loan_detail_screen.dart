import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/fintech_components.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../utils/snackbar.dart';
import 'loans_screen.dart';

class LoanDetailScreen extends StatefulWidget {
  final Loan loan;
  const LoanDetailScreen({super.key, required this.loan});

  @override
  State<LoanDetailScreen> createState() => _LoanDetailScreenState();
}

class _LoanDetailScreenState extends State<LoanDetailScreen> {
  late Loan _loan;

  @override
  void initState() {
    super.initState();
    _loan = widget.loan;
  }

  void _openLogPaymentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _LogPaymentSheet(loan: _loan),
    );
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    // Refresh local loan reference in case it was edited
    _loan = app.loans.firstWhere((l) => l.id == _loan.id, orElse: () => _loan);

    final payments = app.loanPaymentsFor(_loan.id);
    final totalPaid = app.loanTotalPaid(_loan);
    final remaining = app.loanRemaining(_loan);
    final progress = app.loanProgress(_loan);
    final cur = _loan.currency;

    final df = DateFormat('MMM dd, yyyy');

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(_loan.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => LoanSheet(existing: _loan),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (c) => AlertDialog(
                  icon: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: cs.error.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.delete_outline_rounded,
                        color: cs.error, size: 26),
                  ),
                  title:
                      Text(l10n.loans_deleteLoan, textAlign: TextAlign.center),
                  content: Text(l10n.loans_confirmDeleteLoan,
                      textAlign: TextAlign.center),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(46),
                              side: BorderSide(
                                  color: cs.outlineVariant
                                      .withValues(alpha: 0.6)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            onPressed: () => Navigator.pop(c),
                            child: Text(l10n.shared_widgets_cancel),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: cs.error,
                              foregroundColor: cs.onError,
                              minimumSize: const Size.fromHeight(46),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            onPressed: () async {
                              Navigator.pop(c); // close dialog
                              Navigator.pop(context); // go back to loans screen
                              final undo =
                                  await app.deleteLoanWithUndo(_loan.id);
                              if (context.mounted) {
                                showAppSnackbar(
                                  context,
                                  l10n.common_itemDeleted(_loan.name),
                                  onUndo: undo,
                                );
                              }
                            },
                            child: Text(l10n.shared_widgets_delete_),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Summary Card
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Container(
              decoration: BoxDecoration(
                color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.loans_remaining,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: cs.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                        if (_loan.isSettled)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: kSuccessColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              l10n.loans_settled.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: kSuccessColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      formatAmount(remaining, cur),
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: remaining > 0 ? cs.primary : kSuccessColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${l10n.loans_paid}: ${formatAmount(totalPaid, cur)}',
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '${(progress * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    LinearProgressCard(
                      value: progress,
                      color: _loan.isSettled ? kSuccessColor : cs.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Loan Metadata Stats Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                color: cs.surfaceContainer.withValues(alpha: isDark ? 0.35 : 0.55),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: DetailStatCell(l10n.loans_principal, formatAmount(_loan.principal, cur))),
                        Expanded(
                          child: DetailStatCell(
                            l10n.loans_interestRate,
                            _loan.interestRate != null && _loan.interestRate! > 0
                                ? '${_loan.interestRate}%'
                                : '0%',
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 16, thickness: 0.5),
                    Row(
                      children: [
                        Expanded(child: DetailStatCell(l10n.loans_duration, l10n.loans_durationMonths(_loan.durationMonths))),
                        Expanded(child: DetailStatCell(l10n.loans_totalPayable, formatAmount(_loan.totalPayable, cur))),
                      ],
                    ),
                    if (_loan.accountId != null) ...[
                      const Divider(height: 16, thickness: 0.5),
                      Row(
                        children: [
                          Expanded(
                            child: DetailStatCell(
                              l10n.recurring_linkedAccount,
                              app.accountById(_loan.accountId!)?.name ?? l10n.recurring_deletedAccount,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (_loan.notes.trim().isNotEmpty) ...[
                      const Divider(height: 16, thickness: 0.5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.loans_notes,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: cs.onSurface.withValues(alpha: 0.5),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _loan.notes,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // Payment History Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            child: Row(
              children: [
                Text(
                  l10n.loans_paymentHistory,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface.withValues(alpha: 0.6),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          // Payment History List
          Expanded(
            child: payments.isEmpty
                ? Center(
                    child: Text(
                      l10n.loans_noPayments,
                      style: TextStyle(
                        fontSize: 13,
                        color: cs.onSurface.withValues(alpha: 0.4),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(14, 4, 14, 110),
                    itemCount: payments.length,
                    itemBuilder: (context, index) {
                      final p = payments[index];
                      final acc = p.accountId != null ? app.accountById(p.accountId!) : null;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainer.withValues(alpha: isDark ? 0.35 : 0.55),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.black.withValues(alpha: 0.04),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Dismissible(
                          key: Key(p.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: kDangerColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          confirmDismiss: (dir) async {
                            return await showDialog<bool>(
                              context: context,
                              builder: (c) => AlertDialog(
                                icon: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: cs.error.withValues(alpha: 0.12),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.delete_outline_rounded,
                                      color: cs.error, size: 26),
                                ),
                                title: Text(l10n.loans_deletePayment,
                                    textAlign: TextAlign.center),
                                content: Text(l10n.loans_confirmDeletePayment,
                                    textAlign: TextAlign.center),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            minimumSize:
                                                const Size.fromHeight(46),
                                            side: BorderSide(
                                                color: cs.outlineVariant
                                                    .withValues(alpha: 0.6)),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14)),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(c, false),
                                          child:
                                              Text(l10n.shared_widgets_cancel),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: FilledButton(
                                          style: FilledButton.styleFrom(
                                            backgroundColor: cs.error,
                                            foregroundColor: cs.onError,
                                            minimumSize:
                                                const Size.fromHeight(46),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14)),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(c, true),
                                          child:
                                              Text(l10n.shared_widgets_delete_),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          onDismissed: (dir) async {
                            final undo = await app.deleteLoanPaymentWithUndo(p.id);
                            if (context.mounted) {
                              showAppSnackbar(
                                context,
                                l10n.loans_paymentDeleted,
                                onUndo: undo,
                              );
                            }
                          },
                          child: ListTile(
                            leading: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: cs.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.payment, color: cs.primary, size: 18),
                            ),
                            title: Text(
                              formatAmount(p.amount, p.currency),
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            subtitle: Text(
                              [
                                df.format(p.date),
                                if (acc != null) acc.name,
                                if (p.notes.trim().isNotEmpty) p.notes
                              ].join('  ·  '),
                              style: TextStyle(
                                fontSize: 11,
                                color: cs.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                        ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: !_loan.isSettled
          ? FintechExtendedFab(
              onPressed: () => _openLogPaymentSheet(context),
              icon: Icons.add_rounded,
              label: l10n.loans_logPayment,
            )
          : null,
    );
  }
}

class _LogPaymentSheet extends StatefulWidget {
  final Loan loan;
  const _LogPaymentSheet({required this.loan});

  @override
  State<_LogPaymentSheet> createState() => _LogPaymentSheetState();
}

class _LogPaymentSheetState extends State<_LogPaymentSheet> {
  final _formKey = GlobalKey<FormState>();
  late double _amount;
  String? _accountId;
  String _notes = '';

  @override
  void initState() {
    super.initState();
    _amount = widget.loan.monthlyPayment;
    _accountId = widget.loan.accountId;
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final l10n = AppLocalizations.of(context)!;

    final accountsList = app.spendableAccounts;

    return Form(
      key: _formKey,
      child: SheetShell(
        showHandle: true,
        title: l10n.loans_logPayment,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // Amount Form Field
              TextFormField(
                initialValue: _amount.toStringAsFixed(2),
                decoration: InputDecoration(
                  labelText: l10n.loans_amount,
                  suffixText: widget.loan.currency,
                  border: const OutlineInputBorder(),
                  isDense: true,
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return l10n.error_required;
                  }
                  final num = double.tryParse(val);
                  if (num == null || num <= 0) return l10n.common_invalid;
                  return null;
                },
                onChanged: (val) => setState(() => _amount = double.tryParse(val) ?? 0.0),
              ),
              const SizedBox(height: 16),

              // Account Picker
              Text(
                l10n.loans_account,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              AccountCardPicker(
                accounts: accountsList,
                selectedId: _accountId,
                allowNone: true,
                onSelected: (id) => setState(() => _accountId = id),
              ),
              const SizedBox(height: 16),

              // Notes
              TextFormField(
                decoration: InputDecoration(
                  labelText: l10n.loans_notes,
                  border: const OutlineInputBorder(),
                  isDense: true,
                ),
                maxLines: 2,
                onChanged: (val) => setState(() => _notes = val),
              ),
              const SizedBox(height: 20),

              // Log Button
              FilledButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  final nav = Navigator.of(context);
                  final messenger = ScaffoldMessenger.of(context);
                  final msg = l10n.loans_loggedPayment(
                      formatAmount(_amount, widget.loan.currency));

                  await app.payLoanInstallment(
                    widget.loan,
                    amount: _amount,
                    accountId: _accountId,
                    notes: _notes,
                  );

                  if (mounted) {
                    nav.pop();
                    messenger.showSnackBar(
                      SnackBar(content: Text(msg)),
                    );
                  }
                },
                child: Text(l10n.loans_logPayment),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
