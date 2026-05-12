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
  final _amtCtrl  = TextEditingController();
  final _noteCtrl = TextEditingController();
  String? _fromId;
  String? _toId;

  @override
  void initState() {
    super.initState();
    final app = context.read<AppProvider>();
    if (app.accounts.length >= 2) {
      _fromId = app.accounts[0].id;
      _toId   = app.accounts[1].id;
    } else if (app.accounts.length == 1) {
      _fromId = app.accounts[0].id;
    }
  }

  @override
  void dispose() { _amtCtrl.dispose(); _noteCtrl.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (_fromId == null || _toId == null || _fromId == _toId) return;
    final amount = double.tryParse(_amtCtrl.text);
    if (amount == null || amount <= 0) return;
    await context.read<AppProvider>().addTransfer(
      fromId: _fromId!, toId: _toId!, amount: amount,
      note: _noteCtrl.text.trim(),
    );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    final sym = currencyInfo(app.settings.currency).symbol;
    final from = app.accountById(_fromId ?? '');
    final to   = app.accountById(_toId   ?? '');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // From row
          Text('FROM', style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 8),
          AccountCardPicker(
            accounts: app.accounts, selectedId: _fromId,
            onSelected: (id) => setState(() {
              _fromId = id;
              if (_toId == id) _toId = null;
            }),
          ),
          const SizedBox(height: 14),

          // To row
          Row(children: [
            Text('TO', style: Theme.of(context).textTheme.labelMedium
                ?.copyWith(letterSpacing: 1)),
            const Spacer(),
            Icon(Icons.arrow_downward_rounded, size: 16, color: cs.primary),
          ]),
          const SizedBox(height: 8),
          SizedBox(
            height: 76,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: app.accounts.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final acc   = app.accounts[i];
                final isSame = acc.id == _fromId;
                final sel    = _toId == acc.id;
                final color  = Color(acc.colorValue);
                return GestureDetector(
                  onTap: isSame ? null : () => setState(() => _toId = acc.id),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 140),
                    width: 125,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSame ? cs.surfaceContainerHigh
                          : sel ? color : color.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: isSame ? Colors.transparent
                              : sel ? color : color.withValues(alpha: 0.35),
                          width: sel ? 2 : 1),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center, children: [
                      AccountTypeIcon(type: acc.type, size: 14,
                          color: isSame
                              ? cs.onSurface.withValues(alpha: 0.3)
                              : sel ? Colors.white : color),
                      const SizedBox(height: 3),
                      Text(acc.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
                              color: isSame
                                  ? cs.onSurface.withValues(alpha: 0.3)
                                  : sel ? Colors.white : color)),
                      Text(formatAmount(acc.balance, acc.currency),
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 9,
                              color: isSame
                                  ? cs.onSurface.withValues(alpha: 0.2)
                                  : sel
                                      ? Colors.white.withValues(alpha: 0.8)
                                      : cs.onSurface.withValues(alpha: 0.5))),
                    ]),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Preview
          if (from != null && to != null)
            Container(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(14)),
              child: Row(children: [
                Expanded(child: _BalanceCol(name: from.name,
                    balance: formatAmount(from.balance, from.currency),
                    label: 'From')),
                Icon(Icons.arrow_forward_rounded, color: cs.primary),
                Expanded(child: _BalanceCol(name: to.name,
                    balance: formatAmount(to.balance, to.currency),
                    label: 'To', align: CrossAxisAlignment.end)),
              ]),
            ),

          TextField(
            controller: _amtCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: 'Amount', prefixText: '$sym '),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          TextField(controller: _noteCtrl,
              decoration: const InputDecoration(labelText: 'Note (optional)',
                  prefixIcon: Icon(Icons.sticky_note_2_outlined))),
          const SizedBox(height: 24),

          FilledButton.icon(
            onPressed: (_fromId != null && _toId != null && _fromId != _toId)
                ? _submit : null,
            icon: const Icon(Icons.swap_horiz_rounded),
            label: const Text('Transfer'),
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

class _BalanceCol extends StatelessWidget {
  final String name, balance, label;
  final CrossAxisAlignment align;
  const _BalanceCol({required this.name, required this.balance,
      required this.label, this.align = CrossAxisAlignment.start});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(crossAxisAlignment: align, children: [
      Text(label, style: TextStyle(fontSize: 10,
          color: cs.onPrimaryContainer.withValues(alpha: 0.6))),
      Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
      Text(balance, style: TextStyle(
          fontSize: 12, color: cs.primary, fontWeight: FontWeight.w600)),
    ]);
  }
}
