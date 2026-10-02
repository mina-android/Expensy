import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import 'app_numeric_keypad.dart';

class SavingsGoalSheet extends StatefulWidget {
  final SavingsGoal? existing;
  final String? initialName;
  final double? initialTargetAmount;
  final String? wishlistItemId;

  const SavingsGoalSheet({
    super.key,
    this.existing,
    this.initialName,
    this.initialTargetAmount,
    this.wishlistItemId,
  });

  @override
  State<SavingsGoalSheet> createState() => _SavingsGoalSheetState();
}

class _SavingsGoalSheetState extends State<SavingsGoalSheet> {
  late TextEditingController _nameCtrl, _amountCtrl, _dateCtrl;
  int? _colorValue;
  late List<int> _colors;
  bool _submitted = false;
  bool _showAmountKeypad = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_colorValue == null) {
      final primary = Theme.of(context).colorScheme.primary.toARGB32();
      _colors = [
        primary,
        0xFF1565C0,
        0xFF2E7D32,
        0xFFC62828,
        0xFFE65100,
        0xFF00838F,
        0xFF6A1B9A,
        0xFF37474F,
      ];
      _colorValue = widget.existing?.colorValue ?? primary;
    }
  }

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _nameCtrl = TextEditingController(text: e?.name ?? widget.initialName);
    _amountCtrl = TextEditingController(
        text: e != null
            ? e.targetAmount.toStringAsFixed(2).replaceAll('.00', '')
            : (widget.initialTargetAmount != null &&
                    widget.initialTargetAmount! > 0
                ? widget.initialTargetAmount!
                    .toStringAsFixed(2)
                    .replaceAll('.00', '')
                : ''));
    _dateCtrl = TextEditingController(
        text: e?.targetDate != null
            ? DateFormat('yyyy-MM-dd').format(e!.targetDate!)
            : '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _amountCtrl.dispose();
    _dateCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _submitted = true);
    final name = _nameCtrl.text.trim();
    final amount = double.tryParse(_amountCtrl.text.replaceAll(',', '')) ?? 0.0;
    if (name.isEmpty || amount <= 0) return;

    final app = context.read<AppProvider>();
    final isNew = widget.existing == null;
    final linkedWishlistItemId =
        widget.existing?.wishlistItemId ?? widget.wishlistItemId;

    final goal = SavingsGoal(
      id: widget.existing?.id ?? app.newId(),
      name: name,
      targetAmount: amount,
      currentAmount: widget.existing?.currentAmount ?? 0.0,
      currency: widget.existing?.currency ?? app.settings.currency,
      targetDate: _dateCtrl.text.trim().isEmpty
          ? null
          : DateTime.tryParse(_dateCtrl.text.trim()),
      colorValue: _colorValue!,
      isCompleted: widget.existing?.isCompleted ?? false,
      createdAt: widget.existing?.createdAt ?? DateTime.now(),
      completedAt: widget.existing?.completedAt,
      wishlistItemId: linkedWishlistItemId,
    );

    if (isNew) {
      if (linkedWishlistItemId != null) {
        final w = app.wishlist
            .where((item) => item.id == linkedWishlistItemId)
            .firstOrNull;
        if (w != null) {
          await app.createGoalForWishlist(w, goal);
        } else {
          await app.addSavingsGoal(goal);
        }
      } else {
        await app.addSavingsGoal(goal);
      }
    } else {
      await app.updateSavingsGoal(goal);
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final isNew = widget.existing == null;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(isNew ? 'New Savings Goal' : 'Edit Savings Goal',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w800)),
              if (widget.wishlistItemId != null ||
                  widget.existing?.wishlistItemId != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: const Color(0xFF2E7D32).withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          size: 16, color: Color(0xFF2E7D32)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          l10n.savings_linkedWishlist(widget.initialName ??
                              widget.existing?.name ??
                              ''),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 16),
              TextField(
                controller: _nameCtrl,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                onTap: () {
                  if (_showAmountKeypad) setState(() => _showAmountKeypad = false);
                },
                decoration: InputDecoration(
                  labelText: l10n.savings_goalName,
                  hintText: l10n.savings_goalNameHint,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.stars_rounded),
                  errorText: _submitted && _nameCtrl.text.trim().isEmpty
                      ? l10n.error_required
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _amountCtrl,
                readOnly: true,
                showCursor: true,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  setState(() => _showAmountKeypad = true);
                },
                decoration: InputDecoration(
                  labelText: l10n.savings_targetAmount,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                  suffixIcon: _showAmountKeypad
                      ? IconButton(
                          icon: const Icon(Icons.keyboard_hide_outlined),
                          onPressed: () =>
                              setState(() => _showAmountKeypad = false),
                        )
                      : null,
                  errorText: _submitted &&
                          (double.tryParse(
                                      _amountCtrl.text.replaceAll(',', '')) ??
                                  0.0) <=
                              0
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
              TextField(
                controller: _dateCtrl,
                readOnly: true,
                onTap: () async {
                  final initial = _dateCtrl.text.isNotEmpty
                      ? DateTime.tryParse(_dateCtrl.text) ?? DateTime.now()
                      : DateTime.now();
                  final res = await showDatePicker(
                    context: context,
                    initialDate: initial,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 36500)),
                  );
                  if (res != null) {
                    setState(() {
                      _dateCtrl.text = DateFormat('yyyy-MM-dd').format(res);
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: l10n.savings_targetDateOptional,
                  hintText: l10n.savings_selectDate,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.date_range_outlined),
                  suffixIcon: _dateCtrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _dateCtrl.clear();
                            });
                          },
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 24),
              Text(l10n.categories_color,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _colors.map((c) {
                  final color = Color(c);
                  final sel = _colorValue == c;
                  return GestureDetector(
                    onTap: () => setState(() => _colorValue = c),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: sel
                            ? Border.all(color: cs.onSurface, width: 3)
                            : null,
                      ),
                      child: sel
                          ? Icon(Icons.check,
                              color: color.computeLuminance() > 0.5
                                  ? Colors.black
                                  : Colors.white)
                          : null,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: _save,
                style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: Text(l10n.savings_saveGoal,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
