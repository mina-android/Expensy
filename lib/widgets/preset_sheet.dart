import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../widgets/shared_widgets.dart';
import '../utils/haptics.dart';
import '../utils/snackbar.dart';
import 'app_numeric_keypad.dart';

class PresetSheet extends StatefulWidget {
  final TransactionPreset? existing;

  const PresetSheet({super.key, this.existing});

  static Future<void> show(BuildContext context, {TransactionPreset? existing}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PresetSheet(existing: existing),
    );
  }

  @override
  State<PresetSheet> createState() => _PresetSheetState();
}

class _PresetSheetState extends State<PresetSheet> {
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();

  String _type = 'expense';
  String? _accountId;
  String? _categoryId;
  int _colorValue = 0xFF2196F3;
  bool _submitted = false;
  bool _showAmountKeypad = false;

  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final app = context.read<AppProvider>();
    if (isEdit) {
      final p = widget.existing!;
      _titleCtrl.text = p.title;
      _amountCtrl.text = p.amount.toString();
      _noteCtrl.text = p.note;
      _type = p.type;
      _accountId = p.accountId;
      _categoryId = p.categoryId;
      _colorValue = p.colorValue;
    } else {
      final accounts = app.nonBankAccounts.where((a) => !a.isGold).toList();
      if (accounts.isNotEmpty) {
        _accountId = accounts.first.id;
      }
      final cats = app.categories.where((c) => c.type == _type).toList();
      if (cats.isNotEmpty) {
        _categoryId = cats.first.id;
        _colorValue = cats.first.colorValue;
      }
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _onTypeChanged(String newType) {
    if (_type == newType) return;
    final app = context.read<AppProvider>();
    final cats = app.categories.where((c) => c.type == newType).toList();
    setState(() {
      _type = newType;
      _categoryId = cats.isNotEmpty ? cats.first.id : null;
      if (cats.isNotEmpty) _colorValue = cats.first.colorValue;
    });
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    final title = _titleCtrl.text.trim();
    final amount = double.tryParse(_amountCtrl.text);

    if (title.isEmpty || amount == null || amount <= 0) return;
    if (_accountId == null || _categoryId == null) return;

    final app = context.read<AppProvider>();
    final acc = app.accountById(_accountId!);
    final currency = acc?.currency ?? app.settings.currency;

    if (isEdit) {
      final updated = widget.existing!.copyWith(
        title: title,
        type: _type,
        amount: amount,
        accountId: _accountId!,
        categoryId: _categoryId!,
        currency: currency,
        note: _noteCtrl.text.trim(),
        colorValue: _colorValue,
      );
      await app.updatePreset(updated);
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        showAppSnackbar(context, l10n.presets_presetUpdated);
        Navigator.pop(context);
      }
    } else {
      final preset = TransactionPreset(
        id: app.newId(),
        title: title,
        type: _type,
        amount: amount,
        accountId: _accountId!,
        categoryId: _categoryId!,
        currency: currency,
        note: _noteCtrl.text.trim(),
        colorValue: _colorValue,
      );
      await app.addPreset(preset);
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        showAppSnackbar(context, l10n.presets_presetAdded);
        Navigator.pop(context);
      }
    }
  }

  Future<void> _delete() async {
    if (!isEdit) return;
    final l10n = AppLocalizations.of(context)!;
    final app = context.read<AppProvider>();
    await app.deletePreset(widget.existing!.id);
    if (mounted) {
      showAppSnackbar(context, l10n.presets_presetDeleted);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final isAmoled = Theme.of(context).scaffoldBackgroundColor == Colors.black;
    final app = context.watch<AppProvider>();
    final cats = app.categories.where((c) => c.type == _type).toList();
    final transferable = app.nonBankAccounts.where((a) => !a.isGold).toList();

    return Container(
      decoration: BoxDecoration(
        color: isAmoled ? Colors.black : cs.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.onSurfaceVariant.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEdit ? l10n.presets_editQuickPreset : l10n.presets_newQuickPreset,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                if (isEdit)
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: cs.error),
                    onPressed: _delete,
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // Type Toggle
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onTypeChanged('expense'),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: _type == 'expense'
                            ? const Color(0xFFC62828)
                            : cs.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          l10n.add_transaction_expense,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: _type == 'expense' ? Colors.white : cs.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onTypeChanged('income'),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: _type == 'income'
                            ? const Color(0xFF2E7D32)
                            : cs.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          l10n.add_transaction_income,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: _type == 'income' ? Colors.white : cs.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Title
            TextField(
              controller: _titleCtrl,
              decoration: InputDecoration(
                labelText: l10n.presets_presetName,
                prefixIcon: const Icon(Icons.bookmark_outline),
                errorText: _submitted && _titleCtrl.text.trim().isEmpty
                    ? l10n.error_required
                    : null,
              ),
              textCapitalization: TextCapitalization.sentences,
              onTap: () {
                if (_showAmountKeypad) setState(() => _showAmountKeypad = false);
              },
            ),
            const SizedBox(height: 12),

            // Amount
            TextField(
              controller: _amountCtrl,
              readOnly: true,
              showCursor: true,
              onTap: () {
                FocusScope.of(context).unfocus();
                setState(() => _showAmountKeypad = true);
              },
              decoration: InputDecoration(
                labelText: l10n.presets_defaultAmount,
                prefixIcon: const Icon(Icons.attach_money),
                suffixIcon: _showAmountKeypad
                    ? IconButton(
                        icon: const Icon(Icons.keyboard_hide_outlined),
                        onPressed: () =>
                            setState(() => _showAmountKeypad = false),
                      )
                    : null,
                errorText: _submitted &&
                        (double.tryParse(_amountCtrl.text) ?? 0) <= 0
                    ? l10n.error_required
                    : null,
              ),
            ),
            if (_showAmountKeypad &&
                MediaQuery.of(context).viewInsets.bottom < 100) ...[
              const SizedBox(height: 8),
              AppNumericKeypad(
                compact: true,
                controller: _amountCtrl,
                onChanged: (_) => setState(() {}),
                onDone: () => setState(() => _showAmountKeypad = false),
              ),
            ],
            const SizedBox(height: 16),

            // Account
            Text(l10n.add_transaction_account, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 8),
            AccountCardPicker(
              accounts: transferable,
              selectedId: _accountId,
              onSelected: (id) => setState(() => _accountId = id),
            ),
            const SizedBox(height: 16),

            // Category
            Text(l10n.recurring_category, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 8),
            CategoryChipPicker(
              categories: cats,
              selectedId: _categoryId,
              onSelected: (id) {
                final cat = cats.where((c) => c.id == id).firstOrNull;
                setState(() {
                  _categoryId = id;
                  if (cat != null) _colorValue = cat.colorValue;
                });
              },
            ),
            const SizedBox(height: 20),

            FilledButton(
              onPressed: () {
                AppHaptics.tap(context, HapticStrength.light);
                _submit();
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(isEdit ? l10n.accounts_saveChanges : l10n.presets_createPreset),
            ),
          ],
        ),
      ),
    );
  }
}
