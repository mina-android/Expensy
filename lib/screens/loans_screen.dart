import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../widgets/shared_widgets.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../utils/snackbar.dart';
import '../services/loan_reminder_service.dart';
import 'loan_detail_screen.dart';

class LoansScreen extends StatefulWidget {
  const LoansScreen({super.key});

  @override
  State<LoansScreen> createState() => _LoansScreenState();
}

class _LoansScreenState extends State<LoansScreen> {
  static void _openSheet(BuildContext context, {Loan? existing}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LoanSheet(existing: existing),
    );
  }

  Color _barColor(double pct) {
    if (pct >= 0.8) return const Color(0xFF2E7D32); // Green
    if (pct >= 0.4) return const Color(0xFFE65100); // Orange
    return const Color(0xFFC62828); // Red
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final cur = app.settings.currency;

    final activeLoans = app.loans.where((l) => !l.isSettled).toList();
    final settledLoans = app.loans.where((l) => l.isSettled).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.loans_title, style: const TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      body: Column(
        children: [
          // Summary row
          if (app.loans.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
              child: Row(
                children: [
                  _SumChip(
                    label: l10n.loans_outstandingDebt,
                    value: formatAmount(app.totalOutstandingLoanDebt, cur),
                    color: const Color(0xFF4A148C),
                  ),
                  const SizedBox(width: 8),
                  _SumChip(
                    label: l10n.loans_monthlyObligation,
                    value: formatAmount(app.totalMonthlyLoanObligation, cur),
                    color: cs.primary,
                  ),
                ],
              ),
            ),
          
          Expanded(
            child: app.loans.isEmpty
                ? Center(
                    child: Text(
                      'No loans tracked yet',
                      style: TextStyle(
                        color: cs.onSurface.withValues(alpha: 0.5),
                        fontSize: 14,
                      ),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.fromLTRB(14, 6, 14, 100),
                    children: [
                      if (activeLoans.isNotEmpty) ...[
                        ...activeLoans.map((l) => _LoanCard(
                              loan: l,
                              app: app,
                              barColor: _barColor(app.loanProgress(l)),
                              onTap: () => Navigator.push(
                                context,
                                ExpensyRoute(builder: (_) => LoanDetailScreen(loan: l)),
                              ),
                              onLongPress: () => _openSheet(context, existing: l),
                            )),
                      ],
                      if (settledLoans.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                          child: Text(
                            l10n.loans_settled,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: cs.onSurface.withValues(alpha: 0.4),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        ...settledLoans.map((l) => Opacity(
                              opacity: 0.6,
                              child: _LoanCard(
                                loan: l,
                                app: app,
                                barColor: const Color(0xFF2E7D32),
                                onTap: () => Navigator.push(
                                  context,
                                  ExpensyRoute(builder: (_) => LoanDetailScreen(loan: l)),
                                ),
                                onLongPress: () => _openSheet(context, existing: l),
                              ),
                            )),
                      ],
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _SumChip extends StatelessWidget {
  final String label, value;
  final Color color;
  const _SumChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withValues(alpha: 0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      );
}

class _LoanCard extends StatelessWidget {
  final Loan loan;
  final AppProvider app;
  final Color barColor;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _LoanCard({
    required this.loan,
    required this.app,
    required this.barColor,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final cur = loan.currency;
    final l10n = AppLocalizations.of(context)!;
    final progress = app.loanProgress(loan);
    final remaining = app.loanRemaining(loan);

    final df = DateFormat('MMM dd, yyyy');

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loan.name,
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${df.format(loan.startDate)} - ${df.format(loan.endDate)}',
                          style: TextStyle(
                            fontSize: 11,
                            color: cs.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        formatAmount(loan.monthlyPayment, cur),
                        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                      ),
                      Text(
                        l10n.loans_monthlyPayment,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: cs.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgressCard(value: progress, color: barColor),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.recurring_paidPayments(
                        app.loanPaymentsFor(loan.id).length.toString(),
                        loan.durationMonths.toString()),
                    style: TextStyle(
                      fontSize: 11,
                      color: cs.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                  Text(
                    '${l10n.loans_remaining}: ${formatAmount(remaining, cur)}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: remaining > 0 ? cs.primary : const Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              if (!loan.isSettled) ...[
                const SizedBox(height: 10),
                const Divider(height: 1, thickness: 0.5),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (loan.reminderEnabled)
                      Row(
                        children: [
                          Icon(Icons.notifications_active_outlined, size: 12, color: cs.primary),
                          const SizedBox(width: 4),
                          Text(
                            'Due: Day ${loan.reminderDay} @ ${loan.reminderTime}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: cs.primary,
                            ),
                          ),
                        ],
                      )
                    else
                      const SizedBox.shrink(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _Btn(
                            icon: Icons.skip_next_outlined,
                            label: l10n.recurring_skipBtn,
                            color: const Color(0xFF785900),
                            onTap: () async {
                              final ok = await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        title: Text(l10n.recurring_skipNextPayment),
                                        content: const Text('Skip the next loan installment?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () => Navigator.pop(ctx, false),
                                              child: Text(l10n.recurring_cancel)),
                                          FilledButton(
                                              onPressed: () => Navigator.pop(ctx, true),
                                              child: Text(l10n.recurring_skip)),
                                        ],
                                      ));
                              if (ok == true && context.mounted) {
                                await app.skipLoanInstallment(loan);
                                if (context.mounted) {
                                  showAppSnackbar(context, 'Skipped loan installment');
                                }
                              }
                            }),
                        const SizedBox(width: 6),
                        _Btn(
                            icon: Icons.check_circle_outline,
                            label: l10n.recurring_pay,
                            color: cs.primary,
                            onTap: () async {
                              await app.payLoanInstallment(loan);
                              if (context.mounted) {
                                showAppSnackbar(context, 'Logged payment of ${formatAmount(loan.monthlyPayment, cur)}');
                              }
                            }),
                      ],
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Btn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _Btn(
      {required this.icon,
      required this.label,
      required this.color,
      required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 3),
            Text(label,
                style: TextStyle(
                    fontSize: 11, fontWeight: FontWeight.w700, color: color)),
          ]),
        ),
      );
}

class LoanSheet extends StatefulWidget {
  final Loan? existing;
  const LoanSheet({super.key, this.existing});

  @override
  State<LoanSheet> createState() => _LoanSheetState();
}

class _LoanSheetState extends State<LoanSheet> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _principal;
  late String _currency;
  late DateTime _startDate;
  late DateTime _endDate;
  double? _interestRate;
  String? _accountId;
  String? _transferAccountId;
  late bool _reminderEnabled;
  late int _reminderDay;
  late String _reminderTime;
  late String _notes;

  @override
  void initState() {
    super.initState();
    final app = context.read<AppProvider>();
    final ex = widget.existing;

    _name = ex?.name ?? '';
    _principal = ex?.principal ?? 0.0;
    _currency = ex?.currency ?? app.settings.currency;
    _startDate = ex?.startDate ?? DateTime.now();
    _endDate = ex?.endDate ?? DateTime.now().add(const Duration(days: 365));
    _interestRate = ex?.interestRate;
    _accountId = ex?.accountId;
    _transferAccountId = ex?.transferAccountId;
    _reminderEnabled = ex?.reminderEnabled ?? false;
    _reminderDay = ex?.reminderDay ?? 1;
    _reminderTime = ex?.reminderTime ?? '09:00';
    _notes = ex?.notes ?? '';
  }

  int get _durationMonths {
    final months = (_endDate.year - _startDate.year) * 12 + (_endDate.month - _startDate.month);
    return months < 1 ? 1 : months;
  }

  double get _totalPayable {
    if (_interestRate == null || _interestRate == 0) return _principal;
    final years = _durationMonths / 12.0;
    final totalInterest = _principal * (_interestRate! / 100) * years;
    return _principal + totalInterest;
  }

  double get _monthlyPayment => _totalPayable / _durationMonths;

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
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
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.existing == null ? l10n.loans_addLoan : l10n.loans_editLoan,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Loan Name
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(
                  labelText: l10n.loans_loanName,
                  prefixIcon: const Icon(Icons.label_outline),
                ),
                textInputAction: TextInputAction.next,
                validator: (val) => val == null || val.trim().isEmpty ? 'Required' : null,
                onChanged: (val) => setState(() => _name = val),
              ),
              const SizedBox(height: 12),

              // Amount & Currency Row
              TextFormField(
                initialValue: _principal > 0 ? _principal.toString() : '',
                decoration: InputDecoration(
                  labelText: l10n.loans_amount,
                  prefixIcon: const Icon(Icons.account_balance_wallet_outlined),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'Required';
                  final num = double.tryParse(val);
                  if (num == null || num <= 0) return 'Invalid';
                  return null;
                },
                onChanged: (val) => setState(() => _principal = double.tryParse(val) ?? 0.0),
              ),
              const SizedBox(height: 16),

              // Currency Picker
              Text(l10n.accounts_currency,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(letterSpacing: 1)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  final picked =
                      await showCurrencyPicker(context, current: _currency);
                  if (picked != null) setState(() => _currency = picked);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: cs.primary.withValues(alpha: 0.5)),
                  ),
                  child: Row(children: [
                    Icon(Icons.monetization_on_outlined, size: 18, color: cs.primary),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Text(
                            '$_currency  ${currencyInfo(_currency).symbol}  —  ${currencyInfo(_currency).name}',
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
                    const Icon(Icons.arrow_drop_down_rounded),
                  ]),
                ),
              ),
              const SizedBox(height: 16),

              // Duration Dates Row
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final res = await showDatePicker(
                          context: context,
                          initialDate: _startDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (res != null) {
                          setState(() {
                            _startDate = res;
                            if (_endDate.isBefore(_startDate)) {
                              _endDate = _startDate.add(const Duration(days: 30));
                            }
                          });
                        }
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: l10n.loans_startDate,
                          prefixIcon: const Icon(Icons.calendar_today_outlined),
                        ),
                        child: Text(DateFormat('MMM dd, yyyy').format(_startDate)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final res = await showDatePicker(
                          context: context,
                          initialDate: _endDate,
                          firstDate: _startDate,
                          lastDate: DateTime(2100),
                        );
                        if (res != null) {
                          setState(() => _endDate = res);
                        }
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: l10n.loans_endDate,
                          prefixIcon: const Icon(Icons.event_outlined),
                        ),
                        child: Text(DateFormat('MMM dd, yyyy').format(_endDate)),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  'Duration: ${l10n.loans_durationMonths(_durationMonths)}',
                  style: TextStyle(fontSize: 11, color: cs.onSurface.withValues(alpha: 0.6)),
                ),
              ),
              const SizedBox(height: 12),

              // Interest Rate (Optional)
              TextFormField(
                initialValue: _interestRate != null ? _interestRate.toString() : '',
                decoration: InputDecoration(
                  labelText: l10n.loans_interestRateOptional,
                  prefixIcon: const Icon(Icons.percent_outlined),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                validator: (val) {
                  if (val != null && val.trim().isNotEmpty) {
                    final num = double.tryParse(val);
                    if (num == null || num < 0) return 'Invalid';
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() => _interestRate = double.tryParse(val));
                },
              ),
              const SizedBox(height: 16),

              // Account Card Picker
              // Transfer Account Card Picker
              const Text(
                'Transfer Loan Amount To',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              AccountCardPicker(
                accounts: accountsList,
                selectedId: _transferAccountId,
                allowNone: true,
                onSelected: (id) => setState(() => _transferAccountId = id),
              ),
              const SizedBox(height: 16),

              // Installment Account Card Picker
              const Text(
                'Pay Installments From',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              AccountCardPicker(
                accounts: accountsList,
                selectedId: _accountId,
                allowNone: true,
                onSelected: (id) => setState(() => _accountId = id),
              ),
              const SizedBox(height: 16),

              // Live Monthly Preview Card
              if (_principal > 0)
                Card(
                  color: cs.primaryContainer.withValues(alpha: 0.3),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: cs.primary.withValues(alpha: 0.25)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(l10n.loans_monthlyPayment, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            Text(formatAmount(_monthlyPayment, _currency), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: cs.primary)),
                          ],
                        ),
                        if (_interestRate != null && _interestRate! > 0) ...[
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(l10n.loans_totalPayable, style: const TextStyle(fontSize: 11)),
                              Text(formatAmount(_totalPayable, _currency), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 12),

              // Reminder Toggle
              SwitchListTile(
                value: _reminderEnabled,
                title: Text(l10n.loans_paymentReminder, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                contentPadding: EdgeInsets.zero,
                onChanged: (val) async {
                  if (val) {
                    final granted = await LoanReminderService().hasPermission();
                    if (!granted) {
                      if (context.mounted) {
                        showAppSnackbar(context, 'Notifications permission required');
                      }
                      return;
                    }
                  }
                  setState(() => _reminderEnabled = val);
                },
              ),
              if (_reminderEnabled) ...[
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        initialValue: _reminderDay,
                        decoration: InputDecoration(
                          labelText: l10n.loans_reminderDay,
                          prefixIcon: const Icon(Icons.today),
                        ),
                        items: List.generate(31, (i) => i + 1)
                            .map((day) => DropdownMenuItem(value: day, child: Text(day.toString())))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _reminderDay = val);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final timeParts = _reminderTime.split(':');
                          final initialTime = TimeOfDay(
                            hour: int.tryParse(timeParts[0]) ?? 9,
                            minute: timeParts.length > 1 ? (int.tryParse(timeParts[1]) ?? 0) : 0,
                          );
                          final res = await showTimePicker(
                            context: context,
                            initialTime: initialTime,
                          );
                          if (res != null) {
                            setState(() {
                              _reminderTime = '${res.hour.toString().padLeft(2, '0')}:${res.minute.toString().padLeft(2, '0')}';
                            });
                          }
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Reminder Time',
                            prefixIcon: Icon(Icons.access_time),
                          ),
                          child: Text(_reminderTime),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],

              // Notes
              TextFormField(
                initialValue: _notes,
                decoration: InputDecoration(
                  labelText: l10n.loans_notes,
                  prefixIcon: const Icon(Icons.notes),
                ),
                textInputAction: TextInputAction.done,
                maxLines: 2,
                onChanged: (val) => setState(() => _notes = val),
              ),
              const SizedBox(height: 24),

              // Save Button
              FilledButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  final loan = Loan(
                    id: widget.existing?.id ?? app.newId(),
                    name: _name,
                    principal: _principal,
                    currency: _currency,
                    startDate: _startDate,
                    endDate: _endDate,
                    interestRate: _interestRate,
                    accountId: _accountId,
                    transferAccountId: _transferAccountId,
                    reminderEnabled: _reminderEnabled,
                    reminderDay: _reminderDay,
                    reminderTime: _reminderTime,
                    isSettled: widget.existing?.isSettled ?? false,
                    notes: _notes,
                    createdAt: widget.existing?.createdAt,
                  );

                  if (widget.existing == null) {
                    await app.addLoan(loan);
                  } else {
                    await app.updateLoan(loan);
                  }

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: Text(l10n.loans_saveLoan),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
