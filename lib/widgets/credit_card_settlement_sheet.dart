// lib/widgets/credit_card_settlement_sheet.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../utils/haptics.dart';
import '../utils/snackbar.dart';
import '../l10n/app_localizations.dart';
import 'shared_widgets.dart';
import 'app_numeric_keypad.dart';

enum _PaymentType {
  statement,
  fullBalance,
  minPayment,
  custom,
}

class CreditCardSettlementSheet extends StatefulWidget {
  final Account cardAccount;

  const CreditCardSettlementSheet({
    super.key,
    required this.cardAccount,
  });

  static Future<void> show(BuildContext context, Account cardAccount) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CreditCardSettlementSheet(cardAccount: cardAccount),
    );
  }

  @override
  State<CreditCardSettlementSheet> createState() =>
      _CreditCardSettlementSheetState();
}

class _CreditCardSettlementSheetState extends State<CreditCardSettlementSheet> {
  late String? _sourceAccountId;
  _PaymentType _selectedPaymentType = _PaymentType.statement;
  final _customAmountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    final app = context.read<AppProvider>();
    final statement = app.getCreditCardStatement(widget.cardAccount);

    // Pick default funding account
    final eligible = app.accounts
        .where((a) => !['credit', 'debit'].contains(a.type))
        .toList();

    if (widget.cardAccount.linkedAccountId != null &&
        eligible.any((a) => a.id == widget.cardAccount.linkedAccountId)) {
      _sourceAccountId = widget.cardAccount.linkedAccountId;
    } else {
      // Pick first with positive balance, or first available
      final positiveAcc = eligible.where((a) => a.balance > 0).firstOrNull;
      _sourceAccountId = positiveAcc?.id ?? eligible.firstOrNull?.id;
    }

    // Default payment type
    if (statement.statementBalance > 0) {
      _selectedPaymentType = _PaymentType.statement;
    } else if (statement.totalOutstandingDebt > 0) {
      _selectedPaymentType = _PaymentType.fullBalance;
    } else {
      _selectedPaymentType = _PaymentType.custom;
    }
  }

  @override
  void dispose() {
    _customAmountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  double _resolvePaymentAmount(CreditCardStatement statement) {
    switch (_selectedPaymentType) {
      case _PaymentType.statement:
        return statement.statementBalance > 0
            ? statement.statementBalance
            : statement.totalOutstandingDebt;
      case _PaymentType.fullBalance:
        return statement.totalOutstandingDebt;
      case _PaymentType.minPayment:
        return statement.minPaymentAmount > 0
            ? statement.minPaymentAmount
            : statement.totalOutstandingDebt;
      case _PaymentType.custom:
        return double.tryParse(_customAmountCtrl.text.trim()) ?? 0.0;
    }
  }

  Future<void> _submitPayment(
      AppProvider app, CreditCardStatement statement) async {
    final l10n = AppLocalizations.of(context)!;
    final amount = _resolvePaymentAmount(statement);

    if (amount <= 0) {
      showAppSnackbar(context, l10n.creditCard_invalidAmount);
      return;
    }

    if (_sourceAccountId == null) {
      showAppSnackbar(context, l10n.creditCard_selectFundingAccount);
      return;
    }

    final sourceAcc = app.accountById(_sourceAccountId!);
    if (sourceAcc == null) return;

    setState(() => _isProcessing = true);
    AppHaptics.tap(context, HapticStrength.medium);

    try {
      final note = _noteCtrl.text.trim().isNotEmpty
          ? _noteCtrl.text.trim()
          : 'Credit Card Bill Payment — ${widget.cardAccount.name}';

      await app.settleCreditCard(
        cardAccount: widget.cardAccount,
        fromAccount: sourceAcc,
        amount: amount,
        note: note,
      );

      if (mounted) {
        Navigator.pop(context);
        showAppSnackbar(
          context,
          l10n.creditCard_paymentSuccess(
            formatAmount(amount, widget.cardAccount.currency),
            widget.cardAccount.name,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final statement = app.getCreditCardStatement(widget.cardAccount);

    final eligibleSources = app.accounts
        .where((a) => !['credit', 'debit'].contains(a.type))
        .toList();
    final selectedSourceAcc = _sourceAccountId != null
        ? app.accountById(_sourceAccountId!)
        : null;

    final payAmount = _resolvePaymentAmount(statement);
    final cardColor = Color(widget.cardAccount.colorValue);

    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(20, 16, 20, 20 + bottomInset),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: cs.onSurfaceVariant.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Header Row
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: cardColor.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(Icons.credit_card_rounded,
                      color: cardColor, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.creditCard_payBillTitle,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${widget.cardAccount.name} · •••• ${widget.cardAccount.cardNumberLast4?.isNotEmpty == true ? widget.cardAccount.cardNumberLast4! : '0000'}',
                        style: TextStyle(
                          fontSize: 12,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Card Balance Summary Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: cs.outlineVariant.withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.creditCard_fullBalance,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formatAmount(statement.totalOutstandingDebt,
                            widget.cardAccount.currency),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: statement.totalOutstandingDebt > 0
                              ? cs.error
                              : cs.primary,
                        ),
                      ),
                    ],
                  ),
                  if (statement.statementBalance > 0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          l10n.creditCard_statementBalance,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formatAmount(statement.statementBalance,
                              widget.cardAccount.currency),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Select Payment Amount Option
            Text(
              l10n.creditCard_paymentAmount,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
            ),
            const SizedBox(height: 10),

            // Options List
            if (statement.statementBalance > 0)
              _buildOptionTile(
                type: _PaymentType.statement,
                title: l10n.creditCard_fullStatement,
                amount: statement.statementBalance,
                currency: widget.cardAccount.currency,
                subtitle: l10n.creditCard_closesStatementBillingCycle,
                selected: _selectedPaymentType == _PaymentType.statement,
                cs: cs,
              ),

            if (statement.totalOutstandingDebt > 0 &&
                (statement.statementBalance <= 0 ||
                    statement.totalOutstandingDebt != statement.statementBalance))
              _buildOptionTile(
                type: _PaymentType.fullBalance,
                title: l10n.creditCard_fullBalance,
                amount: statement.totalOutstandingDebt,
                currency: widget.cardAccount.currency,
                subtitle: l10n.creditCard_clearsTotalDebt,
                selected: _selectedPaymentType == _PaymentType.fullBalance,
                cs: cs,
              ),

            if (statement.minPaymentAmount > 0 &&
                statement.minPaymentAmount < statement.totalOutstandingDebt)
              _buildOptionTile(
                type: _PaymentType.minPayment,
                title: l10n.creditCard_minPayment,
                amount: statement.minPaymentAmount,
                currency: widget.cardAccount.currency,
                subtitle: l10n.creditCard_requiredMinPayment,
                selected: _selectedPaymentType == _PaymentType.minPayment,
                cs: cs,
              ),

            _buildOptionTile(
              type: _PaymentType.custom,
              title: l10n.creditCard_customAmount,
              amount: null,
              currency: widget.cardAccount.currency,
              subtitle: l10n.creditCard_specifyCustomAmount,
              selected: _selectedPaymentType == _PaymentType.custom,
              cs: cs,
            ),

            if (_selectedPaymentType == _PaymentType.custom) ...[
              const SizedBox(height: 10),
              TextField(
                controller: _customAmountCtrl,
                readOnly: true,
                showCursor: true,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  labelText: l10n.add_transaction_amount,
                  prefixText:
                      '${currencyInfo(widget.cardAccount.currency).symbol} ',
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              AppNumericKeypad(
                compact: true,
                controller: _customAmountCtrl,
                onChanged: (_) => setState(() {}),
                showDoneButton: false,
              ),
            ],

            const SizedBox(height: 20),

            // Funding Source Account
            Text(
              l10n.creditCard_payFromAccount,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
            ),
            const SizedBox(height: 10),

            if (eligibleSources.isEmpty)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cs.errorContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  'No bank or cash accounts available to fund payment.',
                  style: TextStyle(color: cs.error, fontSize: 13),
                ),
              )
            else
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: cs.outlineVariant.withValues(alpha: 0.4),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _sourceAccountId,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    dropdownColor: cs.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(16),
                    items: eligibleSources.map((acc) {
                      return DropdownMenuItem<String>(
                        value: acc.id,
                        child: Row(
                          children: [
                            AccountTypeIcon(
                              type: acc.type,
                              size: 16,
                              color: Color(acc.colorValue),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                acc.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              formatAmount(acc.balance, acc.currency),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: acc.balance >= 0
                                    ? cs.primary
                                    : cs.error,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (id) {
                      if (id != null) {
                        setState(() => _sourceAccountId = id);
                      }
                    },
                  ),
                ),
              ),

            // Warning if payment exceeds balance
            if (selectedSourceAcc != null &&
                payAmount > 0 &&
                payAmount > selectedSourceAcc.balance) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.info_outline, size: 14, color: cs.error),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      l10n.creditCard_insufficientFunds,
                      style: TextStyle(
                        fontSize: 11,
                        color: cs.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 24),

            // Action Pay Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                icon: _isProcessing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.check_circle_rounded),
                label: Text(
                  _isProcessing
                      ? 'Processing...'
                      : payAmount > 0
                          ? 'Pay ${formatAmount(payAmount, widget.cardAccount.currency)}'
                          : l10n.creditCard_payBill,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: cs.primary,
                  foregroundColor: cs.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _isProcessing || eligibleSources.isEmpty
                    ? null
                    : () => _submitPayment(app, statement),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required _PaymentType type,
    required String title,
    required double? amount,
    required String currency,
    required String subtitle,
    required bool selected,
    required ColorScheme cs,
  }) {
    return GestureDetector(
      onTap: () {
        AppHaptics.tap(context, HapticStrength.light);
        setState(() => _selectedPaymentType = type);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? cs.primaryContainer.withValues(alpha: 0.5)
              : cs.surfaceContainerHigh.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? cs.primary : cs.outlineVariant.withValues(alpha: 0.3),
            width: selected ? 1.8 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selected ? cs.primary : cs.onSurfaceVariant,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                      color: selected ? cs.onSurface : cs.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 10,
                      color: cs.onSurfaceVariant.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            if (amount != null)
              Text(
                formatAmount(amount, currency),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: selected ? cs.primary : cs.onSurface,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
