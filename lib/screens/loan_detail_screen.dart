import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../widgets/shared_widgets.dart';
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
      backgroundColor: Colors.transparent,
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

    return Scaffold(
      appBar: AppBar(
        title: Text(_loan.name),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
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
                  title: Text(l10n.loans_deleteLoan),
                  content: Text(l10n.loans_confirmDeleteLoan),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(c),
                      child: Text(l10n.shared_widgets_cancel),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(foregroundColor: const Color(0xFFC62828)),
                      onPressed: () async {
                        Navigator.pop(c); // close dialog
                        Navigator.pop(context); // go back to loans screen
                        final undo = await app.deleteLoanWithUndo(_loan.id);
                        if (context.mounted) {
                          showAppSnackbar(
                            context,
                            'Deleted ${_loan.name}',
                            onUndo: undo,
                          );
                        }
                      },
                      child: Text(l10n.shared_widgets_delete_),
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
          Container(
            color: cs.primary,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                              color: const Color(0xFF2E7D32).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              l10n.loans_settled.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      formatAmount(remaining, cur),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: remaining > 0 ? cs.primary : const Color(0xFF2E7D32),
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
                      color: _loan.isSettled ? const Color(0xFF2E7D32) : cs.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Loan Metadata Stats Grid
          Padding(
            padding: const EdgeInsets.all(14),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.5)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _DetailStat('Principal', formatAmount(_loan.principal, cur))),
                        Expanded(
                          child: _DetailStat(
                            'Interest Rate',
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
                        Expanded(child: _DetailStat('Duration', l10n.loans_durationMonths(_loan.durationMonths))),
                        Expanded(child: _DetailStat('Total Payable', formatAmount(_loan.totalPayable, cur))),
                      ],
                    ),
                    if (_loan.accountId != null) ...[
                      const Divider(height: 16, thickness: 0.5),
                      Row(
                        children: [
                          Expanded(
                            child: _DetailStat(
                              'Linked Account',
                              app.accountById(_loan.accountId!)?.name ?? 'Deleted Account',
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
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    itemCount: payments.length,
                    itemBuilder: (context, index) {
                      final p = payments[index];
                      final acc = p.accountId != null ? app.accountById(p.accountId!) : null;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 6),
                        child: Dismissible(
                          key: Key(p.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC62828),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          confirmDismiss: (dir) async {
                            return await showDialog<bool>(
                              context: context,
                              builder: (c) => AlertDialog(
                                title: Text(l10n.loans_deletePayment),
                                content: Text(l10n.loans_confirmDeletePayment),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(c, false), child: Text(l10n.shared_widgets_cancel)),
                                  TextButton(
                                    style: TextButton.styleFrom(foregroundColor: const Color(0xFFC62828)),
                                    onPressed: () => Navigator.pop(c, true),
                                    child: Text(l10n.shared_widgets_delete_),
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
                                'Payment deleted',
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
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: !_loan.isSettled
          ? FloatingActionButton.extended(
              onPressed: () => _openLogPaymentSheet(context),
              icon: const Icon(Icons.add),
              label: Text(l10n.loans_logPayment),
            )
          : null,
    );
  }
}

class _DetailStat extends StatelessWidget {
  final String label, value;
  const _DetailStat(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: cs.onSurface.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
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
    final viewInsets = MediaQuery.of(context).viewInsets;

    final accountsList = app.accounts.where((a) => !a.isGold).toList();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + viewInsets.bottom),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.loans_logPayment,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

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
                  if (val == null || val.trim().isEmpty) return 'Required';
                  final num = double.tryParse(val);
                  if (num == null || num <= 0) return 'Invalid';
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

                  await app.payLoanInstallment(
                    widget.loan,
                    amount: _amount,
                    accountId: _accountId,
                    notes: _notes,
                  );

                  if (mounted) {
                    Navigator.pop(context);
                    showAppSnackbar(context, 'Logged payment of ${formatAmount(_amount, widget.loan.currency)}');
                  }
                },
                child: Text(l10n.loans_logPayment),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
