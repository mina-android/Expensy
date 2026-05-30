// lib/screens/add_transaction_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

class AddTransactionScreen extends StatefulWidget {
  final AppTransaction? existing;
  const AddTransactionScreen({super.key, this.existing});
  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _amtCtrl  = TextEditingController();
  final _descCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();

  String    _type       = 'expense';
  String?   _accountId;
  String?   _categoryId;
  DateTime  _date       = DateTime.now();
  /// Currency the user entered the amount in. Empty = use account's currency.
  String    _currency   = '';

  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final app = context.read<AppProvider>();
    // Gold accounts update automatically — exclude them from manual transactions.
    final transactableAccounts =
        app.accounts.where((a) => !a.isGold).toList();
    if (transactableAccounts.isNotEmpty) {
      _accountId = transactableAccounts.first.id;
      _currency  = transactableAccounts.first.currency;
    }
    final cats = app.categories.where((c) => c.type == _type).toList();
    if (cats.isNotEmpty) _categoryId = cats.first.id;

    final e = widget.existing;
    if (e != null) {
      _amtCtrl.text  = e.amount.toStringAsFixed(2);
      _descCtrl.text = e.description;
      _noteCtrl.text = e.note;
      _type       = e.type;
      _accountId  = e.accountId;
      _categoryId = e.categoryId;
      _date       = e.date;
      // If existing has a currency use it; otherwise fall back to account currency
      final acc = app.accountById(e.accountId);
      _currency = e.currency.isNotEmpty
          ? e.currency
          : (acc?.currency ?? app.settings.currency);
    }
  }

  @override
  void dispose() {
    _amtCtrl.dispose(); _descCtrl.dispose(); _noteCtrl.dispose();
    super.dispose();
  }

  void _setType(String t) {
    final app  = context.read<AppProvider>();
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

  Future<void> _submit() async {
    final amount = double.tryParse(_amtCtrl.text);
    if (amount == null || amount <= 0) return;
    if (_accountId == null || _categoryId == null) return;

    final app = context.read<AppProvider>();
    // Determine effective currency: if same as account, store empty string
    final acc = app.accountById(_accountId!);
    final accCurrency = acc?.currency ?? app.settings.currency;
    final storeCurrency = _currency == accCurrency ? '' : _currency;

    if (isEdit) {
      final updated = widget.existing!.copyWith(
        type: _type, amount: amount, description: _descCtrl.text.trim(),
        accountId: _accountId, categoryId: _categoryId,
        date: _date, note: _noteCtrl.text.trim(),
        currency: storeCurrency,
      );
      await app.updateTransaction(updated, widget.existing!);
    } else {
      await app.addTransaction(AppTransaction(
        id: app.newId(), type: _type, amount: amount,
        description: _descCtrl.text.trim(), accountId: _accountId!,
        categoryId: _categoryId!, date: _date, note: _noteCtrl.text.trim(),
        currency: storeCurrency,
      ));
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final app  = context.watch<AppProvider>();
    final cs   = Theme.of(context).colorScheme;
    final cats = app.categories.where((c) => c.type == _type).toList();
    final sym  = currencyInfo(_currency.isNotEmpty
        ? _currency
        : (app.accountById(_accountId ?? '')?.currency ?? app.settings.currency)).symbol;

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
        title: Text(isEdit ? 'Edit Transaction' : 'Add Transaction',
            style: const TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ── Type toggle ───────────────────────────────────────────────
          Row(children: [
            Expanded(child: GestureDetector(
              onTap: () => _setType('expense'),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 140),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _type == 'expense'
                      ? const Color(0xFFC62828) : const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text('Expense',
                    style: TextStyle(fontWeight: FontWeight.w700,
                        color: _type == 'expense'
                            ? Colors.white : const Color(0xFFC62828)))),
              ),
            )),
            const SizedBox(width: 10),
            Expanded(child: GestureDetector(
              onTap: () => _setType('income'),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 140),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _type == 'income'
                      ? const Color(0xFF2E7D32) : const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text('Income',
                    style: TextStyle(fontWeight: FontWeight.w700,
                        color: _type == 'income'
                            ? Colors.white : const Color(0xFF2E7D32)))),
              ),
            )),
          ]),
          const SizedBox(height: 16),

          // ── Amount + currency row ─────────────────────────────────────
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Expanded(
              flex: 3,
              child: TextField(
                controller: _amtCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Amount',
                    prefixText: '$sym '),
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w700),
                onChanged: (_) => setState(() {}),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () async {
                  final picked = await showCurrencyPicker(
                      context,
                      current: _currency.isNotEmpty ? _currency : accCurrency);
                  if (picked != null) setState(() => _currency = picked);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: cs.outline.withValues(alpha: 0.4)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(children: [
                    Expanded(child: Text(
                      _currency.isNotEmpty ? _currency : accCurrency,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15),
                    )),
                    const Icon(Icons.arrow_drop_down, size: 20),
                  ]),
                ),
              ),
            ),
          ]),

          // Conversion preview banner
          if (convertedPreview != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: cs.primaryContainer.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                Icon(Icons.swap_horiz_rounded, size: 16, color: cs.primary),
                const SizedBox(width: 6),
                Text(
                  '≈ ${formatAmount(convertedPreview, accCurrency)} '
                  'will be deducted from ${acc?.name ?? 'account'}',
                  style: TextStyle(fontSize: 12, color: cs.onPrimaryContainer,
                      fontWeight: FontWeight.w600),
                ),
              ]),
            ),
          ],
          const SizedBox(height: 12),

          // ── Description ───────────────────────────────────────────────
          TextField(
            controller: _descCtrl,
            decoration: const InputDecoration(
                labelText: 'Description (optional)',
                prefixIcon: Icon(Icons.notes_outlined)),
          ),
          const SizedBox(height: 16),

          // ── Account ───────────────────────────────────────────────────
          Text('Account', style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 8),
          AccountCardPicker(
            accounts: app.accounts.where((a) => !a.isGold).toList(),
            selectedId: _accountId,
            onSelected: _onAccountSelected,
          ),
          const SizedBox(height: 16),

          // ── Category ──────────────────────────────────────────────────
          Text('Category', style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 8),
          CategoryChipPicker(
            categories: cats,
            selectedId: _categoryId,
            onSelected: (id) => setState(() => _categoryId = id),
          ),
          const SizedBox(height: 16),

          // ── Date ──────────────────────────────────────────────────────
          ListTile(contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.calendar_today_outlined),
            title: Text(DateFormat('EEEE, d MMM yyyy').format(_date),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            onTap: () async {
              final p = await showDatePicker(context: context,
                  initialDate: _date,
                  firstDate: DateTime(2000), lastDate: DateTime(2100));
              if (p != null) setState(() => _date = p);
            },
          ),

          // ── Note ──────────────────────────────────────────────────────
          TextField(
            controller: _noteCtrl,
            maxLines: 2,
            decoration: const InputDecoration(
                labelText: 'Note (optional)',
                prefixIcon: Icon(Icons.sticky_note_2_outlined)),
          ),
          const SizedBox(height: 24),

          FilledButton.icon(
            onPressed: _submit,
            icon: Icon(isEdit ? Icons.save_outlined : Icons.add),
            label: Text(isEdit ? 'Save Changes' : 'Add Transaction'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28))),
          ),
        ]),
      ),
    );
  }
}
