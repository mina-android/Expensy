// lib/screens/add_transaction_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

class AddTransactionScreen extends StatefulWidget {
  final Transaction? existing;
  const AddTransactionScreen({super.key, this.existing});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  late String _type;
  late TextEditingController _amountCtrl;
  late TextEditingController _descCtrl;
  late TextEditingController _noteCtrl;
  late DateTime _date;
  String? _accountId;
  String? _categoryId;

  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final ex = widget.existing;
    _type = ex?.type ?? 'expense';
    _amountCtrl = TextEditingController(
        text: ex != null ? ex.amount.toStringAsFixed(2) : '');
    _descCtrl = TextEditingController(text: ex?.description ?? '');
    _noteCtrl = TextEditingController(text: ex?.note ?? '');
    _date = ex?.date ?? DateTime.now();
    _accountId = ex?.accountId;
    _categoryId = ex?.categoryId;
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _descCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final app = context.read<AppProvider>();
    final amount = double.tryParse(_amountCtrl.text.replaceAll(',', ''));
    if (amount == null || amount <= 0) {
      showError(context, 'Please enter a valid amount');
      return;
    }
    if (_descCtrl.text.trim().isEmpty) {
      showError(context, 'Please enter a description');
      return;
    }
    final accId = _accountId ?? (app.accounts.isNotEmpty ? app.accounts.first.id : null);
    final catId = _categoryId ??
        (app.categories.where((c) => c.type == _type).isNotEmpty
            ? app.categories.firstWhere((c) => c.type == _type).id
            : null);
    if (accId == null) { showError(context, 'No accounts available'); return; }
    if (catId == null) { showError(context, 'No categories available'); return; }

    if (isEdit) {
      final updated = Transaction(
        id: widget.existing!.id,
        accountId: accId,
        categoryId: catId,
        amount: amount,
        type: _type,
        description: _descCtrl.text.trim(),
        date: _date,
        note: _noteCtrl.text.trim(),
      );
      await app.updateTransaction(widget.existing!, updated);
    } else {
      await app.addTransaction(Transaction(
        id: app.newId(),
        accountId: accId,
        categoryId: catId,
        amount: amount,
        type: _type,
        description: _descCtrl.text.trim(),
        date: _date,
        note: _noteCtrl.text.trim(),
      ));
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    final isExp = _type == 'expense';
    final headerColor = isExp ? const Color(0xFFC62828) : const Color(0xFF2E7D32);
    final filteredCats =
        app.categories.where((c) => c.type == _type).toList();

    // Auto-fix categoryId if it doesn't match the selected type
    if (_categoryId != null &&
        !filteredCats.any((c) => c.id == _categoryId)) {
      _categoryId = filteredCats.isNotEmpty ? filteredCats.first.id : null;
    }
    _accountId ??= app.accounts.isNotEmpty ? app.accounts.first.id : null;
    _categoryId ??= filteredCats.isNotEmpty ? filteredCats.first.id : null;

    final currency = app.settings.currency;
    final sym = currencyInfo(currency).symbol;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Transaction' : 'Add Transaction',
            style: const TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: headerColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Type toggle
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                    value: 'expense',
                    label: Text('Expense'),
                    icon: Icon(Icons.arrow_upward_rounded)),
                ButtonSegment(
                    value: 'income',
                    label: Text('Income'),
                    icon: Icon(Icons.arrow_downward_rounded)),
              ],
              selected: {_type},
              onSelectionChanged: (s) => setState(() {
                _type = s.first;
                _categoryId = null;
              }),
            ),
            const SizedBox(height: 20),

            // Amount (no card border)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(children: [
                Text('Amount',
                    style: TextStyle(
                        fontSize: 12,
                        color: cs.onSurface.withValues(alpha: 0.6),
                        letterSpacing: 1)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(sym,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: headerColor)),
                    SizedBox(
                      width: 180,
                      child: TextField(
                        controller: _amountCtrl,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                            color: headerColor),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: false,
                            hintText: '0.00'),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
            const SizedBox(height: 16),

            // Description
            TextField(
              controller: _descCtrl,
              decoration: const InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.notes_outlined),
              ),
            ),
            const SizedBox(height: 14),

            // Account — clickable cards
            if (app.accounts.isNotEmpty) ...[
              Text('Account',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(letterSpacing: 1)),
              const SizedBox(height: 8),
              SizedBox(
                height: 72,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: app.accounts.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (_, i) {
                    final acc = app.accounts[i];
                    final sel = _accountId == acc.id;
                    return GestureDetector(
                      onTap: () => setState(() => _accountId = acc.id),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: 130,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: sel
                              ? Color(acc.colorValue)
                              : Color(acc.colorValue).withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: sel
                                ? Color(acc.colorValue)
                                : Color(acc.colorValue)
                                    .withValues(alpha: 0.35),
                            width: sel ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AccountTypeIcon(
                              type: acc.type,
                              size: 16,
                              color: sel
                                  ? Colors.white
                                  : Color(acc.colorValue),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              acc.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: sel
                                    ? Colors.white
                                    : Color(acc.colorValue),
                              ),
                            ),
                            Text(
                              formatAmount(acc.balance, acc.currency),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10,
                                color: sel
                                    ? Colors.white.withValues(alpha: 0.8)
                                    : cs.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),
            ],

            // Category chips
            if (filteredCats.isNotEmpty) ...[
              Text('Category',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(letterSpacing: 1)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: filteredCats.map((c) {
                  final sel = _categoryId == c.id;
                  return GestureDetector(
                    onTap: () => setState(() => _categoryId = c.id),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 80),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: sel
                            ? Color(c.colorValue)
                            : Color(c.colorValue).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: sel
                                  ? Colors.white
                                  : Color(c.colorValue),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(c.name,
                              style: TextStyle(
                                  color: sel
                                      ? Colors.white
                                      : Color(c.colorValue),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 14),

            // Date
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today_outlined),
              title: Text(
                  '${_date.day}/${_date.month}/${_date.year}',
                  style: const TextStyle(fontWeight: FontWeight.w500)),
              subtitle: const Text('Tap to change date'),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _date,
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now().add(const Duration(days: 1)),
                );
                if (picked != null) setState(() => _date = picked);
              },
            ),

            // Note
            TextField(
              controller: _noteCtrl,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Note (optional)',
                prefixIcon: Icon(Icons.sticky_note_2_outlined),
              ),
            ),
            const SizedBox(height: 28),

            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(isEdit ? Icons.save_outlined : Icons.check_rounded),
              label: Text(isEdit ? 'Save Changes' : 'Add ${_type[0].toUpperCase()}${_type.substring(1)}'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                backgroundColor: headerColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
