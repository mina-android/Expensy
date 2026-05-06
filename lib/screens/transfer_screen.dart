// lib/screens/transfer_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});
  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  String? _fromId;
  String? _toId;
  final _amountCtrl = TextEditingController();
  final _noteCtrl   = TextEditingController();
  bool _done = false;

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final app   = context.read<AppProvider>();
    final amount = double.tryParse(_amountCtrl.text.replaceAll(',', ''));
    final from   = app.accountById(_fromId ?? '');
    final to     = app.accountById(_toId ?? '');

    if (from == null || to == null) {
      showError(context, 'Select valid accounts');
      return;
    }
    if (from.id == to.id) {
      showError(context, 'From and To must be different');
      return;
    }
    if (amount == null || amount <= 0) {
      showError(context, 'Enter a valid amount');
      return;
    }
    if (amount > from.balance) {
      showError(context, 'Insufficient balance in ${from.name}');
      return;
    }

    await app.transferBetweenAccounts(
      fromId: from.id,
      toId: to.id,
      amount: amount,
      note: _noteCtrl.text.trim(),
    );
    setState(() => _done = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final app      = context.watch<AppProvider>();
    final cs       = Theme.of(context).colorScheme;
    final currency = app.settings.currency;
    String fmt(double v) => formatAmount(v, currency);
    final sym      = currencyInfo(currency).symbol;

    final fromAcc = app.accountById(_fromId ?? '');
    final toAcc   = app.accountById(_toId   ?? '');
    final amount  = double.tryParse(_amountCtrl.text) ?? 0;
    final valid   = fromAcc != null &&
        toAcc != null &&
        fromAcc.id != toAcc.id &&
        amount > 0 &&
        amount <= (fromAcc.balance);

    if (_fromId == null && app.accounts.isNotEmpty) {
      _fromId = app.accounts.first.id;
      if (app.accounts.length > 1) _toId = app.accounts[1].id;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Between Accounts',
            style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: _done
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle_rounded,
                      size: 72, color: cs.primary),
                  const SizedBox(height: 16),
                  Text('Transfer Complete!',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text(fmt(amount),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: cs.primary)),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Amount (no card border)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(children: [
                      Text('Transfer Amount',
                          style: TextStyle(
                              fontSize: 12,
                              color: cs.onSurface.withValues(alpha: 0.6),
                              letterSpacing: 1)),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(sym,
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  color: cs.primary)),
                          SizedBox(
                            width: 180,
                            child: TextField(
                              controller: _amountCtrl,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              textAlign: TextAlign.center,
                              onChanged: (_) => setState(() {}),
                              style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w800,
                                  color: cs.primary),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  filled: false,
                                  hintText: '0.00',
                                  hintStyle: TextStyle(
                                      color: cs.primary.withValues(alpha: 0.4))),
                            ),
                          ),
                        ],
                      ),
                      if (fromAcc != null)
                        Text(
                          'Available: ${fmt(fromAcc.balance)}',
                          style: TextStyle(
                              fontSize: 12,
                              color: cs.onSurface.withValues(alpha: 0.55)),
                        ),
                    ]),
                  ),
                  const SizedBox(height: 20),

                  // FROM row — cards (fix 6)
                  Text('FROM',
                      style: Theme.of(context)
                          .textTheme.labelSmall?.copyWith(letterSpacing: 1)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 72,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: app.accounts.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (_, i) {
                        final acc = app.accounts[i];
                        final sel = _fromId == acc.id;
                        final color = Color(acc.colorValue);
                        return GestureDetector(
                          onTap: () => setState(() => _fromId = acc.id),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            width: 120,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: sel ? color : color.withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: sel ? color : color.withValues(alpha: 0.35),
                                  width: sel ? 2 : 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AccountTypeIcon(type: acc.type, size: 14,
                                    color: sel ? Colors.white : color),
                                const SizedBox(height: 3),
                                Text(acc.name, maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: sel ? Colors.white : color)),
                                Text(fmt(acc.balance),
                                    style: TextStyle(fontSize: 9,
                                        color: sel
                                            ? Colors.white.withValues(alpha: 0.8)
                                            : cs.onSurface.withValues(alpha: 0.5))),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 14),

                  // TO row — cards
                  Row(children: [
                    Text('TO',
                        style: Theme.of(context)
                            .textTheme.labelSmall?.copyWith(letterSpacing: 1)),
                    const Spacer(),
                    Icon(Icons.arrow_downward_rounded,
                        size: 16, color: cs.primary),
                  ]),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 72,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: app.accounts.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (_, i) {
                        final acc = app.accounts[i];
                        final sel = _toId == acc.id;
                        final color = Color(acc.colorValue);
                        final isSameAsFrom = acc.id == _fromId;
                        return GestureDetector(
                          onTap: isSameAsFrom
                              ? null
                              : () => setState(() => _toId = acc.id),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            width: 120,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSameAsFrom
                                  ? cs.surfaceContainerHigh
                                  : sel ? color : color.withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: isSameAsFrom
                                      ? Colors.transparent
                                      : sel ? color : color.withValues(alpha: 0.35),
                                  width: sel ? 2 : 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AccountTypeIcon(type: acc.type, size: 14,
                                    color: isSameAsFrom
                                        ? cs.onSurface.withValues(alpha: 0.3)
                                        : sel ? Colors.white : color),
                                const SizedBox(height: 3),
                                Text(acc.name, maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: isSameAsFrom
                                            ? cs.onSurface.withValues(alpha: 0.3)
                                            : sel ? Colors.white : color)),
                                Text(fmt(acc.balance),
                                    style: TextStyle(fontSize: 9,
                                        color: isSameAsFrom
                                            ? cs.onSurface.withValues(alpha: 0.25)
                                            : sel
                                                ? Colors.white.withValues(alpha: 0.8)
                                                : cs.onSurface.withValues(alpha: 0.5))),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Preview
                  if (fromAcc != null && toAcc != null && fromAcc.id != toAcc.id && amount > 0)
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(14)),
                      child: Column(children: [
                        _PreviewRow(
                          label: '${fromAcc.name} after',
                          value: fmt(fromAcc.balance - amount),
                          color: (fromAcc.balance - amount) < 0
                              ? const Color(0xFFC62828)
                              : null,
                        ),
                        const Divider(height: 14),
                        _PreviewRow(
                          label: '${toAcc.name} after',
                          value: fmt(toAcc.balance + amount),
                          color: const Color(0xFF2E7D32),
                        ),
                      ]),
                    ),
                  const SizedBox(height: 14),

                  TextField(
                    controller: _noteCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Note (optional)',
                      prefixIcon: Icon(Icons.sticky_note_2_outlined),
                    ),
                  ),
                  const SizedBox(height: 28),

                  FilledButton.icon(
                    onPressed: valid ? _submit : null,
                    icon: const Icon(Icons.swap_horiz_rounded),
                    label: const Text('Confirm Transfer',
                        style: TextStyle(fontSize: 16)),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
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

class _PreviewRow extends StatelessWidget {
  final String label, value;
  final Color? color;
  const _PreviewRow({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13)),
          Text(value,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: color ?? Theme.of(context).colorScheme.onSurface)),
        ],
      );
}
