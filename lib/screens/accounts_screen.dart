// lib/screens/accounts_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text('Total Balance', style: TextStyle(
                  fontSize: 10, color: cs.onPrimary.withValues(alpha: 0.7))),
              Text(formatAmount(app.totalBalance, app.settings.currency),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800,
                      color: cs.onPrimary)),
            ]),
          ),
        ],
      ),
      body: app.accounts.isEmpty
          ? const EmptyState(icon: Icons.account_balance_wallet_outlined,
              message: 'No accounts', subMessage: 'Tap + to add your first account')
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
              itemCount: app.accounts.length,
              itemBuilder: (_, i) => _AccountCard(acc: app.accounts[i]),
            ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => _openSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  static void _openSheet(BuildContext context, {Account? existing}) {
    showModalBottomSheet(
      context: context, isScrollControlled: true, useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _AccountSheet(existing: existing),
    );
  }
}

class _AccountCard extends StatelessWidget {
  final Account acc;
  const _AccountCard({required this.acc});

  @override
  Widget build(BuildContext context) {
    final cs    = Theme.of(context).colorScheme;
    final app   = context.read<AppProvider>();
    final color = Color(acc.colorValue);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(children: [
        // Header
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Row(children: [
            AccountTypeIcon(type: acc.type, size: 28, color: color),
            const SizedBox(width: 12),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(acc.name, style: TextStyle(fontWeight: FontWeight.w800,
                      fontSize: 16, color: color)),
                  if (acc.excludeFromTotal) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: cs.errorContainer,
                          borderRadius: BorderRadius.circular(6)),
                      child: Text('Excluded', style: TextStyle(fontSize: 9,
                          color: cs.error, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ]),
                Text(acc.type.toUpperCase(), style: TextStyle(
                    fontSize: 10, letterSpacing: 1,
                    color: color.withValues(alpha: 0.7))),
              ],
            )),
            IconButton(icon: const Icon(Icons.edit_outlined, size: 20),
                color: color,
                onPressed: () => AccountsScreen._openSheet(context, existing: acc)),
            IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 20),
                color: cs.error,
                onPressed: () async {
                  if (await showDeleteConfirm(context, acc.name) && context.mounted) {
                    context.read<AppProvider>().deleteAccount(acc.id);
                  }
                }),
          ]),
        ),
        // Stats row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(children: [
            _Stat(label: 'Balance', value: formatAmount(acc.balance, acc.currency),
                color: color),
            _Divider(),
            _Stat(label: 'Income',
                value: '+${formatAmount(_income(app, acc.id), acc.currency)}',
                color: const Color(0xFF2E7D32)),
            _Divider(),
            _Stat(label: 'Expense',
                value: '-${formatAmount(_expense(app, acc.id), acc.currency)}',
                color: const Color(0xFFC62828)),
            _Divider(),
            _Stat(label: 'Txs',
                value: '${_txCount(app, acc.id)}',
                color: cs.secondary),
          ]),
        ),
      ]),
    );
  }

  double _income(AppProvider app, String id) => app.transactions
      .where((t) => t.accountId == id && t.type == 'income')
      .fold(0.0, (s, t) => s + t.amount);
  double _expense(AppProvider app, String id) => app.transactions
      .where((t) => t.accountId == id && t.type == 'expense')
      .fold(0.0, (s, t) => s + t.amount);
  int _txCount(AppProvider app, String id) =>
      app.transactions.where((t) => t.accountId == id).length;
}

class _Stat extends StatelessWidget {
  final String label, value;
  final Color color;
  const _Stat({required this.label, required this.value, required this.color});
  @override
  Widget build(BuildContext context) => Expanded(child: Column(children: [
    Text(label, style: TextStyle(fontSize: 10,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5))),
    const SizedBox(height: 2),
    Text(value, maxLines: 1, overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color)),
  ]));
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      height: 28, width: 1,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1));
}

// ── Account Sheet ─────────────────────────────────────────────────────────────
const _kTypeOptions = <List<String>>[
  ['bank',    'Bank'],
  ['cash',    'Cash'],
  ['savings', 'Savings'],
  ['credit',  'Credit Card'],
  ['wallet',  'E-Wallet'],
];

IconData _typeIcon(String type) {
  switch (type) {
    case 'cash':    return Icons.payments_outlined;
    case 'savings': return Icons.savings_outlined;
    case 'credit':  return Icons.credit_card_outlined;
    case 'wallet':  return Icons.account_balance_wallet_outlined;
    default:        return Icons.account_balance_outlined;
  }
}

const List<int> _kColors = [
  0xFF6750A4, 0xFF7D5260, 0xFF1565C0, 0xFF2E7D32, 0xFFE65100, 0xFF00897B,
  0xFFC62828, 0xFF37474F, 0xFF0077B6, 0xFF9C27B0, 0xFF00BFA5, 0xFFF9A825,
  0xFF6D4C41, 0xFF283593, 0xFFAD1457, 0xFF558B2F, 0xFF00838F, 0xFFBF360C,
  0xFF4527A0, 0xFF1B5E20, 0xFF880E4F, 0xFF33691E, 0xFF004D40, 0xFFB71C1C,
];

class _AccountSheet extends StatefulWidget {
  final Account? existing;
  const _AccountSheet({this.existing});
  @override
  State<_AccountSheet> createState() => _AccountSheetState();
}

class _AccountSheetState extends State<_AccountSheet> {
  final _nameCtrl = TextEditingController();
  final _balCtrl  = TextEditingController();
  String _type            = 'bank';
  String _currency        = 'EGP';
  int    _color           = 0xFF6750A4;
  bool   _excludeFromTotal = false;

  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final app = context.read<AppProvider>();
    _currency = app.settings.currency;
    final e = widget.existing;
    if (e != null) {
      _nameCtrl.text    = e.name;
      _balCtrl.text     = e.balance.toStringAsFixed(2);
      _type             = e.type;
      _currency         = e.currency;
      _color            = e.colorValue;
      _excludeFromTotal = e.excludeFromTotal;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose(); _balCtrl.dispose(); super.dispose();
  }

  Future<void> _submit() async {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) return;
    final app = context.read<AppProvider>();
    if (isEdit) {
      await app.updateAccount(widget.existing!.copyWith(
        name: name, type: _type, currency: _currency,
        balance: double.tryParse(_balCtrl.text) ?? widget.existing!.balance,
        colorValue: _color, excludeFromTotal: _excludeFromTotal,
      ));
    } else {
      await app.addAccount(Account(
        id: app.newId(), name: name, type: _type, currency: _currency,
        balance: double.tryParse(_balCtrl.text) ?? 0,
        colorValue: _color, excludeFromTotal: _excludeFromTotal,
      ));
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 20, right: 20, top: 20),
      child: SingleChildScrollView(child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isEdit ? 'Edit Account' : 'Add Account',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),

          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(labelText: 'Account Name',
                prefixIcon: Icon(Icons.label_outline)),
          ),
          const SizedBox(height: 14),

          // Type cards
          Text('Account Type', style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: _kTypeOptions.map((opt) {
            final val = opt[0];
            final lbl = opt[1];
            final sel = _type == val;
            return GestureDetector(
              onTap: () => setState(() => _type = val),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 140),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                decoration: BoxDecoration(
                  color: sel ? cs.primary : cs.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(_typeIcon(val), size: 16,
                      color: sel ? Colors.white : cs.onSurface),
                  const SizedBox(width: 6),
                  Text(lbl, style: TextStyle(fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: sel ? Colors.white : cs.onSurface)),
                ]),
              ),
            );
          }).toList()),
          const SizedBox(height: 14),

          // Currency picker
          Text('Currency', style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () async {
              final picked = await showCurrencyPicker(context, current: _currency);
              if (picked != null) setState(() => _currency = picked);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: cs.primary.withValues(alpha: 0.5)),
              ),
              child: Row(children: [
                Icon(Icons.monetization_on_outlined, size: 18, color: cs.primary),
                const SizedBox(width: 10),
                Expanded(child: Text(
                    '$_currency  ${currencyInfo(_currency).symbol}  —  ${currencyInfo(_currency).name}',
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
                const Icon(Icons.arrow_drop_down_rounded),
              ]),
            ),
          ),
          const SizedBox(height: 14),

          TextField(
            controller: _balCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                labelText: isEdit ? 'Balance' : 'Initial Balance',
                prefixText: '${currencyInfo(_currency).symbol} '),
          ),
          const SizedBox(height: 6),

          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: const Text('Exclude from Total Balance',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            subtitle: Text('Won\'t count toward your home screen total',
                style: TextStyle(fontSize: 12,
                    color: cs.onSurface.withValues(alpha: 0.5))),
            value: _excludeFromTotal,
            onChanged: (v) => setState(() => _excludeFromTotal = v),
          ),
          const SizedBox(height: 6),

          Text('Colour', style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 8),
          SizedBox(
            height: 44,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: _kColors.map((col) => GestureDetector(
                onTap: () => setState(() => _color = col),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 80),
                  width: 34, height: 34,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Color(col), shape: BoxShape.circle,
                    border: Border.all(
                        color: _color == col ? cs.onSurface : Colors.transparent,
                        width: 3),
                    boxShadow: _color == col ? [BoxShadow(
                        color: Color(col).withValues(alpha: 0.5),
                        blurRadius: 6, spreadRadius: 1)] : null,
                  ),
                ),
              )).toList()),
            ),
          ),
          const SizedBox(height: 20),

          FilledButton(
            onPressed: _submit,
            style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28))),
            child: Text(isEdit ? 'Save Changes' : 'Add Account'),
          ),
        ],
      )),
    );
  }
}
