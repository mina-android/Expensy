// lib/screens/add_transaction_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/app_numeric_keypad.dart';
import '../utils/haptics.dart';
import '../utils/snackbar.dart';

class AddTransactionScreen extends StatefulWidget {
  final AppTransaction? existing;
  final String initialType;
  const AddTransactionScreen(
      {super.key, this.existing, this.initialType = 'expense'});
  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _SplitDraft {
  String id;
  String categoryId;
  final TextEditingController amountCtrl;
  final TextEditingController noteCtrl;

  _SplitDraft({
    String? id,
    required this.categoryId,
    required this.amountCtrl,
    required this.noteCtrl,
  }) : id = id ?? '';

  double get amount {
    final eval = ExpressionEvaluator.evaluate(amountCtrl.text);
    return eval ?? double.tryParse(amountCtrl.text) ?? 0.0;
  }

  void dispose() {
    amountCtrl.dispose();
    noteCtrl.dispose();
  }
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

  // ── Split Transaction State ───────────────────────────────────────────────
  bool _isSplit = false;
  List<_SplitDraft> _splits = [];
  TextEditingController? _activeAmountController;
  late final FocusNode _amtFocusNode;

  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    _amtFocusNode = FocusNode();
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

      _loadExistingSplits();
    }
  }

  Future<void> _loadExistingSplits() async {
    final e = widget.existing;
    if (e == null) return;
    final splits =
        await context.read<AppProvider>().getSplitsForTransaction(e.id);
    if (splits.isNotEmpty && mounted) {
      setState(() {
        _isSplit = true;
        _splits = splits
            .map((s) => _SplitDraft(
                  id: s.id,
                  categoryId: s.categoryId,
                  amountCtrl: TextEditingController(
                      text: ExpressionEvaluator.formatResult(s.amount)),
                  noteCtrl: TextEditingController(text: s.note),
                ))
            .toList();
        if (_splits.isNotEmpty) {
          _activeAmountController = _splits.first.amountCtrl;
        }
      });
    }
  }

  @override
  void dispose() {
    _amtCtrl.dispose();
    _amtFocusNode.dispose();
    _descCtrl.dispose();
    _noteCtrl.dispose();
    for (final s in _splits) {
      s.dispose();
    }
    super.dispose();
  }

  void _setType(String t) {
    final app = context.read<AppProvider>();
    final cats = app.categories.where((c) => c.type == t).toList();
    setState(() {
      _type = t;
      _categoryId = cats.isNotEmpty ? cats.first.id : null;
      if (t != 'expense' && _isSplit) {
        _isSplit = false;
        _activeAmountController = _amtCtrl;
      }
    });
  }

  void _applyPreset(TransactionPreset p) {
    AppHaptics.tap(context, HapticStrength.light);
    setState(() {
      _isSplit = false;
      _activeAmountController = _amtCtrl;
      _amtCtrl.text = ExpressionEvaluator.formatResult(p.amount);
      _descCtrl.text = p.title;
      _type = p.type;
      _accountId = p.accountId;
      _categoryId = p.categoryId;
      _currency = p.currency;
      if (p.note.isNotEmpty) _noteCtrl.text = p.note;
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

  void _toggleSplit(bool val, List<AppCategory> cats) {
    AppHaptics.tap(context, HapticStrength.light);
    setState(() {
      _isSplit = val;
      if (_isSplit) {
        if (_splits.isEmpty) {
          final evalAmount = ExpressionEvaluator.evaluate(_amtCtrl.text);
          final total = evalAmount ?? double.tryParse(_amtCtrl.text) ?? 0.0;
          final half = total > 0 ? (total / 2) : 0.0;
          final cat1 = _categoryId ?? (cats.isNotEmpty ? cats.first.id : '');
          final cat2 = cats.length > 1
              ? cats[1].id
              : (cats.isNotEmpty ? cats.first.id : '');
          _splits = [
            _SplitDraft(
              categoryId: cat1,
              amountCtrl: TextEditingController(
                  text: half > 0 ? ExpressionEvaluator.formatResult(half) : ''),
              noteCtrl: TextEditingController(),
            ),
            _SplitDraft(
              categoryId: cat2,
              amountCtrl: TextEditingController(
                  text: half > 0
                      ? ExpressionEvaluator.formatResult(total - half)
                      : ''),
              noteCtrl: TextEditingController(),
            ),
          ];
        }
        _activeAmountController = _splits.first.amountCtrl;
      } else {
        _activeAmountController = _amtCtrl;
      }
    });
  }

  void _addSplit(List<AppCategory> cats) {
    AppHaptics.tap(context, HapticStrength.light);
    final evalAmount = ExpressionEvaluator.evaluate(_amtCtrl.text);
    final total = evalAmount ?? double.tryParse(_amtCtrl.text) ?? 0.0;
    final allocated = _splits.fold(0.0, (s, item) => s + item.amount);
    final remaining = total - allocated;

    final usedCatIds = _splits.map((s) => s.categoryId).toSet();
    final unusedCat = cats.where((c) => !usedCatIds.contains(c.id)).firstOrNull;
    final catId = unusedCat?.id ?? (cats.isNotEmpty ? cats.first.id : '');

    final newSplit = _SplitDraft(
      categoryId: catId,
      amountCtrl: TextEditingController(
        text: remaining > 0 ? ExpressionEvaluator.formatResult(remaining) : '',
      ),
      noteCtrl: TextEditingController(),
    );

    setState(() {
      _splits.add(newSplit);
      _activeAmountController = newSplit.amountCtrl;
    });
  }

  void _removeSplit(int index) {
    if (_splits.length <= 2) return;
    AppHaptics.tap(context, HapticStrength.light);
    final removed = _splits.removeAt(index);
    if (_activeAmountController == removed.amountCtrl) {
      _activeAmountController = _splits.first.amountCtrl;
    }
    removed.dispose();
    setState(() {});
  }

  void _fillRemaining() {
    AppHaptics.tap(context, HapticStrength.light);
    final evalAmount = ExpressionEvaluator.evaluate(_amtCtrl.text);
    final total = evalAmount ?? double.tryParse(_amtCtrl.text) ?? 0.0;
    final allocated = _splits.fold(0.0, (s, item) => s + item.amount);
    final remaining = total - allocated;
    if (remaining <= 0) return;

    setState(() {
      final target = _splits.firstWhere(
        (s) => s.amountCtrl == _activeAmountController,
        orElse: () => _splits.last,
      );
      final newAmt = target.amount + remaining;
      target.amountCtrl.text = ExpressionEvaluator.formatResult(newAmt);
    });
  }

  Future<void> _pickCategoryForSplit(int index, List<AppCategory> cats) async {
    AppHaptics.tap(context, HapticStrength.light);
    final picked = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        final l10n = AppLocalizations.of(ctx)!;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(ctx).colorScheme.onSurface.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.add_transaction_category,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(ctx).size.height * 0.45,
                ),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: cats.map((c) {
                      final isSelected = c.id == _splits[index].categoryId;
                      return ChoiceChip(
                        selected: isSelected,
                        avatar: CategoryDot(category: c, size: 18),
                        label: Text(c.name,
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600)),
                        onSelected: (_) => Navigator.pop(ctx, c.id),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (picked != null && mounted) {
      setState(() => _splits[index].categoryId = picked);
    }
  }

  Future<bool?> _showDuplicateWarningDialog(List<AppTransaction> dupes) {
    final l10n = AppLocalizations.of(context)!;
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.add_transaction_possibleDuplicate),
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
              child: Text(l10n.add_transaction_goBack)),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l10n.add_transaction_saveAnyway)),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    final evalAmount = ExpressionEvaluator.evaluate(_amtCtrl.text);
    final amount = evalAmount ?? double.tryParse(_amtCtrl.text);
    if (amount == null || amount <= 0) return;
    if (_accountId == null) return;

    final app = context.read<AppProvider>();
    final l10n = AppLocalizations.of(context)!;

    if (_isSplit) {
      if (_splits.length < 2) {
        showAppSnackbar(context, l10n.split_atLeastTwoCategories);
        return;
      }
      for (final s in _splits) {
        if (s.categoryId.isEmpty || s.amount <= 0) {
          showAppSnackbar(context, l10n.split_categoryAndAmountRequired);
          return;
        }
      }
      final allocated = _splits.fold(0.0, (sum, s) => sum + s.amount);
      if ((amount - allocated).abs() > 0.01) {
        showAppSnackbar(context, l10n.split_transactions_mismatchError);
        return;
      }
      _categoryId = _splits.first.categoryId;
    } else {
      if (_categoryId == null) return;
    }

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

    if (_isSplit) {
      final splitEntities = _splits
          .map((s) => TransactionSplit(
                id: s.id.isNotEmpty ? s.id : app.newId(),
                transactionId: targetTx.id,
                categoryId: s.categoryId,
                amount: s.amount,
                note: s.noteCtrl.text.trim(),
              ))
          .toList();
      await app.saveTransactionSplits(targetTx.id, splitEntities);
    } else if (isEdit) {
      await app.saveTransactionSplits(targetTx.id, []);
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
    final evalAmount = ExpressionEvaluator.evaluate(_amtCtrl.text);
    final inputAmount = evalAmount ?? double.tryParse(_amtCtrl.text);
    final convertedPreview = showConversion && inputAmount != null
        ? app.convertBetween(inputAmount, _currency, accCurrency)
        : null;

    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            isEdit
                ? l10n.add_transaction_editTransaction
                : l10n.add_transaction_addTransaction,
            style: const TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // ── Quick Presets ─────────────────────────────────────────────
              if (!isEdit && app.presets.isNotEmpty) ...[
                SizedBox(
                  height: 34,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: app.presets.length,
                    itemBuilder: (context, i) {
                      final p = app.presets[i];
                      final color = Color(p.colorValue);
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ActionChip(
                          avatar: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                          ),
                          label: Text(p.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                          onPressed: () => _applyPreset(p),
                          backgroundColor: cs.surfaceContainerHigh.withValues(alpha: 0.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
              ],

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
                    focusNode: _amtFocusNode,
                    readOnly: true,
                    showCursor: true,
                    onTap: () {
                      AppHaptics.tap(context, HapticStrength.light);
                      setState(() => _activeAmountController = _amtCtrl);
                      _amtFocusNode.requestFocus();
                    },
                    decoration: InputDecoration(
                      labelText: l10n.add_transaction_amount,
                      prefixText: '$sym ',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: (_activeAmountController == _amtCtrl ||
                                  _activeAmountController == null)
                              ? cs.primary
                              : cs.outline.withValues(alpha: 0.4),
                          width: (_activeAmountController == _amtCtrl ||
                                  _activeAmountController == null)
                              ? 2
                              : 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: cs.primary, width: 2),
                      ),
                      errorText: _submitted &&
                              ((evalAmount ?? double.tryParse(_amtCtrl.text) ?? 0) <= 0)
                          ? l10n.error_required
                          : null,
                      helperText: (_amtCtrl.text.contains('+') ||
                                  _amtCtrl.text.contains('-') ||
                                  _amtCtrl.text.contains('×') ||
                                  _amtCtrl.text.contains('÷')) &&
                              evalAmount != null
                          ? '= ${formatAmount(evalAmount, _currency.isNotEmpty ? _currency : accCurrency)}'
                          : ' ',
                    ),
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w700),
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
              Row(
                children: [
                  Text(l10n.add_transaction_category,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(letterSpacing: 1)),
                  const Spacer(),
                  if (_type == 'expense')
                    FilterChip(
                      selected: _isSplit,
                      onSelected: (val) => _toggleSplit(val, cats),
                      avatar: Icon(Icons.call_split_rounded,
                          size: 14,
                          color: _isSplit ? cs.onPrimaryContainer : cs.primary),
                      label: Text(l10n.split_transactions_title,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: _isSplit ? cs.onPrimaryContainer : cs.primary)),
                      backgroundColor: cs.surfaceContainerHigh.withValues(alpha: 0.5),
                      selectedColor: cs.primaryContainer,
                      showCheckmark: false,
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),
              const SizedBox(height: 8),
              if (!_isSplit)
                CategoryChipPicker(
                  categories: cats,
                  selectedId: _categoryId,
                  onSelected: (id) => setState(() => _categoryId = id),
                )
              else
                _buildSplitEditor(context, app, cats, sym),
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
              const SizedBox(height: 12),
            ]),
          )),
          if (!isKeyboardOpen)
            SafeArea(
              top: false,
              bottom: false,
              child: AppNumericKeypad(
                controller: _activeAmountController ?? _amtCtrl,
                onChanged: (_) => setState(() => _submitted = false),
                onDone: _submit,
              ),
            ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: FilledButton.icon(
                onPressed: () {
                  AppHaptics.tap(context, HapticStrength.light);
                  _submit();
                },
                icon: Icon(isEdit ? Icons.save_outlined : Icons.add),
                label: Text(isEdit
                    ? l10n.add_transaction_saveChanges
                    : l10n.add_transaction_addTransaction),
                style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSplitEditor(
    BuildContext context,
    AppProvider app,
    List<AppCategory> cats,
    String sym,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final evalAmount = ExpressionEvaluator.evaluate(_amtCtrl.text);
    final total = evalAmount ?? double.tryParse(_amtCtrl.text) ?? 0.0;
    final allocated = _splits.fold(0.0, (sum, s) => sum + s.amount);
    final remaining = total - allocated;
    final isBalanced = remaining.abs() < 0.005;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Validation Header Banner ─────────────────────────────────────────
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isBalanced
                ? const Color(0xFF2E7D32).withValues(alpha: 0.12)
                : (remaining < 0
                    ? cs.errorContainer.withValues(alpha: 0.5)
                    : const Color(0xFFE65100).withValues(alpha: 0.12)),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isBalanced
                  ? const Color(0xFF2E7D32).withValues(alpha: 0.4)
                  : (remaining < 0
                      ? cs.error.withValues(alpha: 0.4)
                      : const Color(0xFFE65100).withValues(alpha: 0.4)),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${l10n.split_transactions_allocated}: $sym${allocated.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isBalanced
                            ? Icons.check_circle_rounded
                            : Icons.info_outline_rounded,
                        size: 15,
                        color: isBalanced
                            ? const Color(0xFF2E7D32)
                            : (remaining < 0
                                ? cs.error
                                : const Color(0xFFE65100)),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isBalanced
                            ? 'Balanced'
                            : '${l10n.split_transactions_remaining}: $sym${remaining.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: isBalanced
                              ? const Color(0xFF2E7D32)
                              : (remaining < 0
                                  ? cs.error
                                  : const Color(0xFFE65100)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (!isBalanced && remaining > 0) ...[
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: _fillRemaining,
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.auto_fix_high, size: 13, color: cs.primary),
                          const SizedBox(width: 4),
                          Text(
                            l10n.split_transactions_fillRemaining,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: cs.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),

        // ── Split Rows ────────────────────────────────────────────────────────
        ...List.generate(_splits.length, (i) {
          final split = _splits[i];
          final cat = app.categoryById(split.categoryId);
          final isActive = _activeAmountController == split.amountCtrl;

          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(
                color: isActive
                    ? cs.primary
                    : cs.outline.withValues(alpha: 0.2),
                width: isActive ? 2 : 1,
              ),
            ),
            color: isActive
                ? cs.primaryContainer.withValues(alpha: 0.15)
                : cs.surface,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Category picker button
                      Expanded(
                        flex: 3,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () => _pickCategoryForSplit(i, cats),
                          child: Container(
                            height: 44,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: cs.surfaceContainerHighest
                                  .withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                CategoryDot(category: cat, size: 22),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    cat?.name ?? 'Category',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Amount display / input box
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            AppHaptics.tap(context, HapticStrength.light);
                            _amtFocusNode.unfocus();
                            setState(
                                () => _activeAmountController = split.amountCtrl);
                          },
                          child: Container(
                            height: 44,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? cs.primaryContainer.withValues(alpha: 0.3)
                                  : cs.surfaceContainerHighest
                                      .withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isActive
                                    ? cs.primary
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text(
                                  '$sym ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: cs.onSurface.withValues(alpha: 0.6),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    split.amountCtrl.text.isEmpty
                                        ? '0.00'
                                        : split.amountCtrl.text,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: split.amountCtrl.text.isEmpty
                                          ? cs.onSurface.withValues(alpha: 0.4)
                                          : cs.onSurface,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Delete split button
                      IconButton(
                        icon: Icon(
                          Icons.remove_circle_outline,
                          size: 20,
                          color: _splits.length > 2
                              ? cs.error
                              : cs.outline.withValues(alpha: 0.3),
                        ),
                        onPressed:
                            _splits.length > 2 ? () => _removeSplit(i) : null,
                        tooltip: l10n.split_transactions_removeSplit,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Optional note field
                  TextField(
                    controller: split.noteCtrl,
                    decoration: InputDecoration(
                      hintText: l10n.add_transaction_noteOptional,
                      hintStyle: TextStyle(
                          fontSize: 12,
                          color: cs.onSurface.withValues(alpha: 0.4)),
                      prefixIcon:
                          const Icon(Icons.sticky_note_2_outlined, size: 16),
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: cs.outline.withValues(alpha: 0.2)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: cs.outline.withValues(alpha: 0.2)),
                      ),
                    ),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        }),

        // ── Add Split Button ──────────────────────────────────────────────────
        OutlinedButton.icon(
          onPressed: () => _addSplit(cats),
          icon: const Icon(Icons.add, size: 16),
          label: Text(l10n.split_transactions_addSplit),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}
