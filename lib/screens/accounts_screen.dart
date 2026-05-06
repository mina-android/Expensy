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
    final cs = Theme.of(context).colorScheme;
    final currency = app.settings.currency;
    String fmt(double v) => formatAmount(v, currency);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(fmt(app.totalBalance),
                  style: TextStyle(
                      color: cs.onPrimary,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
      body: app.accounts.isEmpty
          ? const EmptyState(
              icon: Icons.account_balance_wallet_outlined,
              message: 'No accounts yet',
              subMessage: 'Add your first account below',
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
              itemCount: app.accounts.length,
              itemBuilder: (_, i) => _AccountCard(
                  account: app.accounts[i], app: app, fmt: fmt),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAccountSheet(context, app),
        child: const Icon(Icons.add),
      ),
    );
  }

  static void _showAccountSheet(BuildContext ctx, AppProvider app,
      {Account? existing}) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _AccountSheet(app: app, existing: existing),
    );
  }
}

class _AccountCard extends StatelessWidget {
  final Account account;
  final AppProvider app;
  final String Function(double) fmt;
  const _AccountCard({required this.account, required this.app, required this.fmt});

  @override
  Widget build(BuildContext context) {
    final txCount =
        app.transactions.where((t) => t.accountId == account.id).length;
    final totalIn = app.transactions
        .where((t) => t.accountId == account.id && t.type == 'income')
        .fold(0.0, (s, t) => s + t.amount);
    final totalOut = app.transactions
        .where((t) => t.accountId == account.id && t.type == 'expense')
        .fold(0.0, (s, t) => s + t.amount);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            color: Color(account.colorValue),
            padding: const EdgeInsets.fromLTRB(16, 20, 12, 18),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: AccountTypeIcon(
                          type: account.type, size: 22)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(account.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20)),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(6)),
                        child: Text(account.type.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined,
                          color: Colors.white70, size: 20),
                      onPressed: () => AccountsScreen._showAccountSheet(
                          context, app,
                          existing: account),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: Colors.white70, size: 20),
                      onPressed: () async {
                        final ok = await showDeleteConfirm(
                            context, account.name);
                        if (ok && context.mounted) {
                          app.deleteAccount(account.id);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Color(account.colorValue).withValues(alpha: 0.08),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                _Stat(label: 'Balance', value: fmt(account.balance),
                    color: account.balance >= 0
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFFC62828)),
                _divider(),
                _Stat(
                    label: 'Income',
                    value: '+${fmt(totalIn)}',
                    color: const Color(0xFF2E7D32)),
                _divider(),
                _Stat(
                    label: 'Expense',
                    value: '-${fmt(totalOut)}',
                    color: const Color(0xFFC62828)),
                _divider(),
                _Stat(
                    label: 'Txs',
                    value: '$txCount',
                    color: Colors.grey.shade600),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      Container(width: 1, height: 28, color: Colors.black12);
}

class _Stat extends StatelessWidget {
  final String label, value;
  final Color color;
  const _Stat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(children: [
          Text(label,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
              textAlign: TextAlign.center),
          const SizedBox(height: 2),
          Text(value,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: color),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center),
        ]),
      );
}

// ─── Add / Edit Account sheet ─────────────────────────────────────────────
class _AccountSheet extends StatefulWidget {
  final AppProvider app;
  final Account? existing;
  const _AccountSheet({required this.app, this.existing});

  @override
  State<_AccountSheet> createState() => _AccountSheetState();
}

class _AccountSheetState extends State<_AccountSheet> {
  final _nameCtrl = TextEditingController();
  final _balCtrl  = TextEditingController();
  String _type     = 'bank';
  int    _color     = 0xFF6750A4;
  String _currency  = 'EGP';

  static const _colors = [
    // Row 1 – originals
    0xFF6750A4, 0xFF7D5260, 0xFF1565C0,
    0xFF2E7D32, 0xFFE65100, 0xFF00897B,
    0xFFC62828, 0xFF37474F,
    // Row 2 – new
    0xFF0077B6, 0xFF9C27B0, 0xFF00BFA5,
    0xFFF9A825, 0xFF6D4C41, 0xFF283593,
    0xFFAD1457, 0xFF558B2F,
    // Row 3 – new
    0xFF00838F, 0xFFBF360C, 0xFF4527A0,
    0xFF1B5E20, 0xFF880E4F, 0xFF33691E,
    0xFF004D40, 0xFFB71C1C,
  ];

  @override
  void initState() {
    super.initState();
    _currency = widget.app.settings.currency;
    final e = widget.existing;
    if (e != null) {
      _nameCtrl.text = e.name;
      _balCtrl.text  = e.balance.toStringAsFixed(2);
      _type     = e.type;
      _color    = e.colorValue;
      _currency = e.currency;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _balCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_nameCtrl.text.trim().isEmpty) return;
    final app = widget.app;

    if (widget.existing != null) {
      final updated = widget.existing!.copyWith(
        name:       _nameCtrl.text.trim(),
        type:       _type,
        balance:    double.tryParse(_balCtrl.text) ?? widget.existing!.balance,
        colorValue: _color,
        currency:   _currency,
      );
      await app.updateAccount(updated);
    } else {
      final a = Account(
        id:          app.newId(),
        name:        _nameCtrl.text.trim(),
        type:        _type,
        balance:     double.tryParse(_balCtrl.text) ?? 0,
        currency:    _currency,
        colorValue:  _color,
      );
      await app.addAccount(a);
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 20, right: 20, top: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isEdit ? 'Edit Account' : 'Add Account',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 20),
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                  labelText: 'Account Name',
                  prefixIcon: Icon(Icons.label_outline)),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: _type,
              decoration: const InputDecoration(
                  labelText: 'Account Type',
                  prefixIcon: Icon(Icons.account_balance_outlined)),
              items: const [
                DropdownMenuItem(value: 'bank',    child: Text('Bank Account')),
                DropdownMenuItem(value: 'cash',    child: Text('Cash')),
                DropdownMenuItem(value: 'savings', child: Text('Savings')),
                DropdownMenuItem(value: 'credit',  child: Text('Credit Card')),
                DropdownMenuItem(value: 'wallet',  child: Text('E-Wallet')),
              ],
              onChanged: (v) => setState(() => _type = v!),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              value: _currency,
              decoration: const InputDecoration(
                  labelText: 'Currency',
                  prefixIcon: Icon(Icons.monetization_on_outlined)),
              items: kCurrencies.map((cur) => DropdownMenuItem<String>(
                  value: cur.code,
                  child: Text('${cur.code}  ${cur.symbol}  — ${cur.name}'))).toList(),
              onChanged: (v) => setState(() => _currency = v!),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _balCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                  labelText: isEdit ? 'Balance' : 'Initial Balance',
                  prefixText:
                      '${currencyInfo(widget.app.settings.currency).symbol} '),
            ),
            const SizedBox(height: 16),
            Text('Colour',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(letterSpacing: 1)),
            const SizedBox(height: 10),
            SizedBox(
              height: 46,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _colors.map((col) => GestureDetector(
                        onTap: () => setState(() => _color = col),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 80),
                          width: 34,
                          height: 34,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Color(col),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: _color == col
                                    ? Theme.of(context).colorScheme.onSurface
                                    : Colors.transparent,
                                width: 3),
                            boxShadow: _color == col
                                ? [BoxShadow(
                                    color: Color(col).withValues(alpha: 0.5),
                                    blurRadius: 6, spreadRadius: 1)]
                                : null,
                          ),
                        ),
                      )).toList(),
                ),
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
        ),
      ),
    );
  }
}
