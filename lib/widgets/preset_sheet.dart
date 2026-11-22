import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../widgets/shared_widgets.dart';
import '../theme/app_theme.dart';
import '../utils/haptics.dart';
import '../utils/snackbar.dart';
import 'app_numeric_keypad.dart';

class PresetSheet extends StatefulWidget {
  final TransactionPreset? existing;
  final String? initialType;

  const PresetSheet({super.key, this.existing, this.initialType});

  static Future<void> show(
    BuildContext context, {
    TransactionPreset? existing,
    String? initialType,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PresetSheet(existing: existing, initialType: initialType),
    );
  }

  @override
  State<PresetSheet> createState() => _PresetSheetState();
}

class _PresetSheetState extends State<PresetSheet> {
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _toAmtCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();

  String _type = 'expense';
  String? _accountId;
  String? _toAccountId;
  String? _categoryId;
  int _colorValue = 0xFF2196F3;
  bool _submitted = false;
  bool _showAmountKeypad = false;
  bool _showToAmountKeypad = false;

  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final app = context.read<AppProvider>();
    if (isEdit) {
      final p = widget.existing!;
      _titleCtrl.text = p.title;
      _amountCtrl.text = p.amount.toString();
      if (p.toAmount != null) _toAmtCtrl.text = p.toAmount.toString();
      _noteCtrl.text = p.note;
      _type = p.type;
      _accountId = p.accountId;
      _toAccountId = p.toAccountId;
      _categoryId = p.categoryId;
      _colorValue = p.colorValue;
    } else {
      _type = widget.initialType ?? 'expense';
      final accounts = _type == 'transfer'
          ? app.transferableAccounts
          : app.spendableAccounts;
      if (accounts.isNotEmpty) {
        _accountId = accounts.first.id;
      }
      if (_type == 'transfer') {
        _categoryId = 'sys_transfer';
        if (accounts.length > 1) {
          _toAccountId = accounts[1].id;
        }
      } else {
        final cats = app.userCategories.where((c) => c.type == _type).toList();
        if (cats.isNotEmpty) {
          _categoryId = cats.first.id;
          _colorValue = cats.first.colorValue;
        }
      }
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    _toAmtCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _onTypeChanged(String newType) {
    if (_type == newType) return;
    final app = context.read<AppProvider>();
    if (newType == 'transfer') {
      final transferable = app.transferableAccounts;
      final nextFrom = transferable.any((a) => a.id == _accountId)
          ? _accountId
          : transferable.firstOrNull?.id;
      final fallbackTo =
          transferable.where((a) => a.id != nextFrom).firstOrNull?.id;
      final nextTo = (_toAccountId != null &&
              _toAccountId != nextFrom &&
              transferable.any((a) => a.id == _toAccountId))
          ? _toAccountId
          : fallbackTo;
      setState(() {
        _type = newType;
        _accountId = nextFrom;
        _toAccountId = nextTo;
        _categoryId = 'sys_transfer';
        _colorValue = Theme.of(context).colorScheme.primary.toARGB32();
      });
      return;
    }
    final transactable = app.spendableAccounts;
    final nextAcc = transactable.any((a) => a.id == _accountId)
        ? _accountId
        : transactable.firstOrNull?.id;
    final cats = app.userCategories.where((c) => c.type == newType).toList();
    setState(() {
      _type = newType;
      _accountId = nextAcc;
      _showToAmountKeypad = false;
      _categoryId = cats.isNotEmpty ? cats.first.id : null;
      if (cats.isNotEmpty) _colorValue = cats.first.colorValue;
    });
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    final l10n = AppLocalizations.of(context)!;
    final title = _titleCtrl.text.trim();
    final amount = double.tryParse(_amountCtrl.text);

    if (title.isEmpty || amount == null || amount <= 0) return;
    if (_accountId == null) return;

    final app = context.read<AppProvider>();
    final acc = app.accountById(_accountId!);
    final currency = acc?.currency ?? app.settings.currency;

    String? toAccId;
    double? toAmt;
    String catId;
    if (_type == 'transfer') {
      if (_toAccountId == null || _toAccountId == _accountId) {
        showAppSnackbar(
          context,
          l10n.presets_selectDifferentAccounts,
        );
        return;
      }
      toAccId = _toAccountId;
      final toAcc = app.accountById(toAccId!);
      final isCrossCurrency =
          acc != null && toAcc != null && acc.currency != toAcc.currency;
      final parsedTo = double.tryParse(_toAmtCtrl.text.trim());
      if (isCrossCurrency && parsedTo != null && parsedTo > 0) {
        toAmt = parsedTo;
      }
      catId = 'sys_transfer';
    } else {
      if (_categoryId == null) return;
      catId = _categoryId!;
    }

    if (isEdit) {
      final updated = widget.existing!.copyWith(
        title: title,
        type: _type,
        amount: amount,
        accountId: _accountId!,
        toAccountId: toAccId,
        clearToAccountId: _type != 'transfer',
        toAmount: toAmt,
        clearToAmount: toAmt == null,
        categoryId: catId,
        currency: currency,
        note: _noteCtrl.text.trim(),
        colorValue: _colorValue,
      );
      await app.updatePreset(updated);
      if (mounted) {
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
        toAccountId: toAccId,
        toAmount: toAmt,
        categoryId: catId,
        currency: currency,
        note: _noteCtrl.text.trim(),
        colorValue: _colorValue,
      );
      await app.addPreset(preset);
      if (mounted) {
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
    final app = context.watch<AppProvider>();
    final cats = app.userCategories.where((c) => c.type == _type).toList();
    final transferable = _type == 'transfer'
        ? app.transferableAccounts
        : app.spendableAccounts;

    return Container(
      decoration: BoxDecoration(
        color: popupSurfaceColor(cs),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.fromBorderSide(popupBorderSide(cs)),
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
            TypeToggleChips(
              selectedValue: _type,
              firstValue: 'expense',
              firstLabel: l10n.add_transaction_expense,
              firstColor: kDangerColor,
              secondValue: 'income',
              secondLabel: l10n.add_transaction_income,
              secondColor: kSuccessColor,
              thirdValue: 'transfer',
              thirdLabel: l10n.presets_transfer,
              thirdColor: cs.primary,
              onChanged: _onTypeChanged,
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

            // Account / From & To Accounts
            Text(
              _type == 'transfer'
                  ? l10n.recurring_fromAccount
                  : l10n.add_transaction_account,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            AccountCardPicker(
              accounts: transferable,
              selectedId: _accountId,
              onSelected: (id) {
                setState(() {
                  _accountId = id;
                  if (_toAccountId == id) _toAccountId = null;
                });
              },
            ),
            if (_type == 'transfer') ...[
              const SizedBox(height: 16),
              Text(
                l10n.recurring_toAccount,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 8),
              AccountCardPicker(
                accounts: transferable,
                selectedId: _toAccountId,
                disabledId: _accountId,
                onSelected: (id) => setState(() => _toAccountId = id),
              ),
              if (_accountId != null && _toAccountId != null) ...[
                Builder(
                  builder: (context) {
                    final fromAcc = app.accountById(_accountId!);
                    final toAcc = app.accountById(_toAccountId!);
                    if (fromAcc == null ||
                        toAcc == null ||
                        fromAcc.currency == toAcc.currency) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 14),
                        TextField(
                          controller: _toAmtCtrl,
                          readOnly: true,
                          showCursor: true,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              _showAmountKeypad = false;
                              _showToAmountKeypad = true;
                            });
                          },
                          decoration: InputDecoration(
                            labelText:
                                l10n.presets_targetAmountOptional(toAcc.currency),
                            prefixIcon: const Icon(Icons.currency_exchange),
                            suffixIcon: _showToAmountKeypad
                                ? IconButton(
                                    icon: const Icon(Icons.keyboard_hide_outlined),
                                    onPressed: () => setState(
                                        () => _showToAmountKeypad = false),
                                  )
                                : null,
                          ),
                        ),
                        if (_showToAmountKeypad &&
                            MediaQuery.of(context).viewInsets.bottom < 100) ...[
                          const SizedBox(height: 8),
                          AppNumericKeypad(
                            compact: true,
                            controller: _toAmtCtrl,
                            onChanged: (_) => setState(() {}),
                            onDone: () =>
                                setState(() => _showToAmountKeypad = false),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ],
              const SizedBox(height: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: cs.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: cs.primary.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.swap_horiz_rounded,
                        size: 18, color: cs.primary),
                    const SizedBox(width: 8),
                    Text(
                      '${l10n.recurring_category}: ${l10n.presets_transfer}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: cs.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              const SizedBox(height: 16),
              // Category
              Text(l10n.recurring_category,
                  style: Theme.of(context).textTheme.labelMedium),
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
            ],
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
