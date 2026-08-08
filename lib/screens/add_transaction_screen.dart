// lib/screens/add_transaction_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../utils/haptics.dart';

class AddTransactionScreen extends StatefulWidget {
  final AppTransaction? existing;
  final String initialType;
  const AddTransactionScreen(
      {super.key, this.existing, this.initialType = 'expense'});
  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _amtCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();

  bool _submitted = false;
  bool _dupeWarningDismissed = false;

  late String _type = widget.existing?.type ?? widget.initialType;
  String? _accountId;
  String? _categoryId;
  DateTime _date = DateTime.now();

  /// Currency the user entered the amount in. Empty = use account's currency.
  String _currency = '';

  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final app = context.read<AppProvider>();
    // Gold accounts update automatically — exclude them from manual transactions.
    final transactableAccounts =
        app.nonBankAccounts.where((a) => !a.isGold).toList();
    if (transactableAccounts.isNotEmpty) {
      _accountId = transactableAccounts.first.id;
      _currency = transactableAccounts.first.currency;
    }
    final cats = app.categories.where((c) => c.type == _type).toList();
    if (cats.isNotEmpty) _categoryId = cats.first.id;

    final e = widget.existing;
    if (e != null) {
      _amtCtrl.text = e.amount.toStringAsFixed(2);
      _descCtrl.text = e.description;
      _noteCtrl.text = e.note;
      _type = e.type;
      _accountId = e.accountId;
      _categoryId = e.categoryId;
      _date = e.date;
      // If existing has a currency use it; otherwise fall back to account currency
      final acc = app.accountById(e.accountId);
      _currency = e.currency.isNotEmpty
          ? e.currency
          : (acc?.currency ?? app.settings.currency);
    }
  }

  @override
  void dispose() {
    _amtCtrl.dispose();
    _descCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _setType(String t) {
    final app = context.read<AppProvider>();
    final cats = app.categories.where((c) => c.type == t).toList();
    setState(() {
      _type = t;
      _categoryId = cats.isNotEmpty ? cats.first.id : null;
    });
  }

  void _onAccountSelected(String? id) {
    if (id == null) return;
    final app = context.read<AppProvider>();
    final acc = app.accountById(id);
    setState(() {
      _accountId = id;
      // Reset currency to new account's currency
      _currency = acc?.currency ?? app.settings.currency;
    });
  }

  Future<bool?> _showDuplicateWarningDialog(List<AppTransaction> dupes) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Possible duplicate'),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${dupes.length == 1 ? "A similar transaction" : "${dupes.length} similar transactions"} already exist${dupes.length == 1 ? "s" : ""}:'),
              const SizedBox(height: 8),
              ...dupes.take(3).map((d) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                        '• ${formatAmount(d.amount, d.currency.isNotEmpty ? d.currency : "")} on ${DateFormat('d MMM').format(d.date)}${d.description.isNotEmpty ? " — ${d.description}" : ""}',
                        style: const TextStyle(fontSize: 13)),
                  )),
            ]),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Go back')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Save anyway')),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    final amount = double.tryParse(_amtCtrl.text);
    if (amount == null || amount <= 0) return;
    if (_accountId == null || _categoryId == null) return;

    final app = context.read<AppProvider>();
    // Determine effective currency: if same as account, store empty string
    final acc = app.accountById(_accountId!);
    final accCurrency = acc?.currency ?? app.settings.currency;
    final storeCurrency = _currency == accCurrency ? '' : _currency;

    final targetTx = AppTransaction(
      id: isEdit ? widget.existing!.id : app.newId(),
      type: _type,
      amount: amount,
      description: _descCtrl.text.trim(),
      accountId: _accountId!,
      categoryId: _categoryId!,
      date: _date,
      note: _noteCtrl.text.trim(),
      currency: storeCurrency,
    );

    final dupes =
        app.findPossibleDuplicates(targetTx, excludeId: widget.existing?.id);
    if (dupes.isNotEmpty && !_dupeWarningDismissed) {
      final proceed = await _showDuplicateWarningDialog(dupes);
      if (proceed != true) return;
      _dupeWarningDismissed = true;
    }

    if (isEdit) {
      await app.updateTransaction(targetTx, widget.existing!);
    } else {
      await app.addTransaction(targetTx);
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    final cats = app.categories.where((c) => c.type == _type).toList();
    final sym = currencyInfo(_currency.isNotEmpty
            ? _currency
            : (app.accountById(_accountId ?? '')?.currency ??
                app.settings.currency))
        .symbol;

    // Show converted amount preview when transaction currency != account currency
    final acc = app.accountById(_accountId ?? '');
    final accCurrency = acc?.currency ?? app.settings.currency;
    final showConversion = _currency.isNotEmpty &&
        _currency != accCurrency &&
        app.exchangeRates.isNotEmpty;
    final inputAmount = double.tryParse(_amtCtrl.text);
    final convertedPreview = showConversion && inputAmount != null
        ? app.convertBetween(inputAmount, _currency, accCurrency)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            isEdit
                ? l10n.add_transaction_editTransaction
                : l10n.add_transaction_addTransaction,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      body: SafeArea(
          bottom: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // ── Type toggle ───────────────────────────────────────────────
              Row(children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () => _setType('expense'),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        color: _type == 'expense'
                            ? const Color(0xFFC62828)
                            : const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                        child: Text(l10n.add_transaction_expense,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: _type == 'expense'
                                    ? Colors.white
                                    : const Color(0xFFC62828)))),
                  ),
                )),
                const SizedBox(width: 10),
                Expanded(
                    child: GestureDetector(
                  onTap: () => _setType('income'),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        color: _type == 'income'
                            ? const Color(0xFF2E7D32)
                            : const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                        child: Text(l10n.add_transaction_income,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: _type == 'income'
                                    ? Colors.white
                                    : const Color(0xFF2E7D32)))),
                  ),
                )),
              ]),
              const SizedBox(height: 16),

              // ── Amount + currency row ─────────────────────────────────────
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _amtCtrl,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                   
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: l10n.add_transaction_amount,
                      prefixText: '$sym ',
                      errorText: _submitted &&
                              (double.tryParse(_amtCtrl.text) ?? 0) <= 0
                          ? l10n.error_required
                          : null,
                      helperText: _submitted &&
                              (double.tryParse(_amtCtrl.text) ?? 0) <= 0
                          ? null
                          : ' ',
                    ),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                    onChanged: (_) => setState(() => _submitted = false),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      final picked = await showCurrencyPicker(context,
                          current:
                              _currency.isNotEmpty ? _currency : accCurrency);
                      if (picked != null) setState(() => _currency = picked);
                    },
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: cs.outline.withValues(alpha: 0.4)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Text(
                              _currency.isNotEmpty ? _currency : accCurrency,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            )),
                            const Icon(Icons.arrow_drop_down, size: 20),
                          ]),
                    ), // Container
                  ), // InkWell
                ), // Expanded
              ]), // Row

              // Conversion preview banner
              if (convertedPreview != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(children: [
                    Icon(Icons.swap_horiz_rounded, size: 16, color: cs.primary),
                    const SizedBox(width: 6),
                    Text(
                      l10n.add_transaction_conversionPreview(
                          formatAmount(convertedPreview, accCurrency),
                          acc?.name ?? l10n.add_transaction_accountFallback),
                      style: TextStyle(
                          fontSize: 12,
                          color: cs.onPrimaryContainer,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
                ),
              ],
              const SizedBox(height: 12),

              // ── Description ───────────────────────────────────────────────
              TextField(
                controller: _descCtrl,
                textInputAction: TextInputAction.next,
               
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                    labelText: l10n.add_transaction_descriptionOptional,
                    prefixIcon: const Icon(Icons.notes_outlined)),
              ),
              const SizedBox(height: 16),

              // ── Account ───────────────────────────────────────────────────
              Text(l10n.add_transaction_account,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(letterSpacing: 1)),
              const SizedBox(height: 8),
              AccountCardPicker(
                accounts: app.nonBankAccounts.where((a) => !a.isGold).toList(),
                selectedId: _accountId,
                onSelected: _onAccountSelected,
              ),
              const SizedBox(height: 16),

              // ── Category ──────────────────────────────────────────────────
              Text(l10n.add_transaction_category,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(letterSpacing: 1)),
              const SizedBox(height: 8),
              CategoryChipPicker(
                categories: cats,
                selectedId: _categoryId,
                onSelected: (id) => setState(() => _categoryId = id),
              ),
              const SizedBox(height: 16),

              // ── Date ──────────────────────────────────────────────────────
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today_outlined),
                title: Text(DateFormat('EEEE, d MMM yyyy').format(_date),
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                onTap: () async {
                  final p = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  if (p != null) setState(() => _date = p);
                },
              ),

              // ── Note ──────────────────────────────────────────────────────
              TextField(
                controller: _noteCtrl,
                maxLines: 2,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                    labelText: l10n.add_transaction_noteOptional,
                    prefixIcon: const Icon(Icons.sticky_note_2_outlined)),
              ),
              const SizedBox(height: 24),

              FilledButton.icon(
                onPressed: () {
                  AppHaptics.tap(context, HapticStrength.light);
                  _submit();
                },
                icon: Icon(isEdit ? Icons.save_outlined : Icons.add),
                label: Text(isEdit
                    ? l10n.add_transaction_saveChanges
                    : l10n.add_transaction_addTransaction),
                style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28))),
              ),
            ]),
          )),
    );
  }
}
