// lib/screens/accounts_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
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

    final hasMultiCurrency = app.accounts.any(
        (a) => a.currency != app.settings.currency);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
        actions: [
          if (hasMultiCurrency)
            IconButton(
              icon: app.ratesFetching
                  ? SizedBox(
                      width: 18, height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: cs.onPrimary),
                    )
                  : Icon(Icons.sync_rounded, color: cs.onPrimary),
              tooltip: 'Refresh exchange rates',
              onPressed: app.ratesFetching
                  ? null
                  : () => context.read<AppProvider>().refreshRates(),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text('Total Balance', style: TextStyle(
                  fontSize: 10, color: cs.onPrimary.withValues(alpha: 0.7))),
              Text(formatAmount(app.totalBalanceAll, app.settings.currency),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800,
                      color: cs.onPrimary)),
            ]),
          ),
        ],
      ),
      body: app.accounts.isEmpty
          ? const EmptyState(icon: Icons.account_balance_wallet_outlined,
              message: 'No accounts', subMessage: 'Tap + to add your first account')
          : Column(
              children: [
                if (hasMultiCurrency)
                  _RatesBanner(app: app),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
                    itemCount: app.accounts.length,
                    itemBuilder: (_, i) => _AccountCard(acc: app.accounts[i]),
                  ),
                ),
              ],
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

// ── Rates status banner ───────────────────────────────────────────────────────
class _RatesBanner extends StatelessWidget {
  final AppProvider app;
  const _RatesBanner({required this.app});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    String label;
    Color  bgColor;
    Color  fgColor;
    IconData icon;

    if (app.ratesFetching && !app.ratesLoaded) {
      label   = 'Fetching exchange rates…';
      bgColor = cs.surfaceContainerHigh;
      fgColor = cs.onSurface.withValues(alpha: 0.6);
      icon    = Icons.sync_rounded;
    } else if (app.exchangeRates.isEmpty) {
      label   = 'Exchange rates unavailable (offline). Balances shown in native currency.';
      bgColor = cs.errorContainer.withValues(alpha: 0.4);
      fgColor = cs.error;
      icon    = Icons.wifi_off_rounded;
    } else {
      final lastFetched = app.ratesLastFetched;
      final timeStr = lastFetched != null
          ? DateFormat('d MMM, HH:mm').format(lastFetched)
          : 'Unknown';
      label   = 'Rates updated $timeStr · Tap ↺ to refresh';
      bgColor = cs.surfaceContainerHigh;
      fgColor = cs.onSurface.withValues(alpha: 0.5);
      icon    = Icons.currency_exchange_rounded;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      color: bgColor,
      child: Row(children: [
        Icon(icon, size: 13, color: fgColor),
        const SizedBox(width: 6),
        Expanded(child: Text(label,
            style: TextStyle(fontSize: 11, color: fgColor))),
      ]),
    );
  }
}

// ── Account Card ──────────────────────────────────────────────────────────────
class _AccountCard extends StatelessWidget {
  final Account acc;
  const _AccountCard({required this.acc});

  @override
  Widget build(BuildContext context) {
    final cs    = Theme.of(context).colorScheme;
    final app   = context.watch<AppProvider>();
    final color = Color(acc.colorValue);
    final showConverted = app.canShowConverted(acc);

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
                // Type label row with optional gold badge
                Row(children: [
                  Text(acc.isGold ? 'GOLD' : acc.type.toUpperCase(),
                      style: TextStyle(
                          fontSize: 10, letterSpacing: 1,
                          color: color.withValues(alpha: 0.7))),
                  if (acc.isGold && acc.goldKarat != null && acc.goldGrams != null) ...[ 
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD700).withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${acc.goldKarat}k · ${acc.goldGrams!.toStringAsFixed(2)} g',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ]),
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
          child: acc.isGold
              ? _goldStatsRow(context, app, cs, color, showConverted)
              : _regularStatsRow(context, app, cs, color, showConverted),
        ),
      ]),
    );
  }

  Widget _regularStatsRow(BuildContext context, AppProvider app,
      ColorScheme cs, Color color, bool showConverted) {
    return Row(children: [
      _Stat(
        label: 'Balance',
        value: formatAmount(acc.balance, acc.currency),
        subValue: showConverted
            ? '≈ ${formatAmount(app.convertToMain(acc.balance, acc.currency), app.settings.currency)}'
            : null,
        color: color,
      ),
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
    ]);
  }

  Widget _goldStatsRow(BuildContext context, AppProvider app,
      ColorScheme cs, Color color, bool showConverted) {
    // Price per gram of this specific karat gold in account currency
    final karat = acc.goldKarat ?? 24;
    final grams = acc.goldGrams ?? 0;
    final pricePerGram = grams > 0 && acc.balance > 0
        ? acc.balance / grams
        : app.goldPricePerGram(acc.currency) != null
            ? (app.goldPricePerGram(acc.currency)! * karat / 24)
            : null;

    return Row(children: [
      _Stat(
        label: 'Value',
        value: formatAmount(acc.balance, acc.currency),
        subValue: showConverted
            ? '≈ ${formatAmount(app.convertToMain(acc.balance, acc.currency), app.settings.currency)}'
            : null,
        color: color,
      ),
      _Divider(),
      _Stat(
        label: 'Karat',
        value: '${karat}k',
        subValue: '${(karat / 24 * 100).toStringAsFixed(1)}% pure',
        color: const Color(0xFFB8860B),
      ),
      _Divider(),
      _Stat(
        label: 'Weight',
        value: '${grams.toStringAsFixed(2)} g',
        color: color,
      ),
      _Divider(),
      _Stat(
        label: 'Per gram',
        value: pricePerGram != null
            ? formatAmount(pricePerGram, acc.currency)
            : '—',
        color: cs.secondary,
      ),
    ]);
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
  final String? subValue;
  final Color color;
  const _Stat({required this.label, required this.value,
      this.subValue, required this.color});
  @override
  Widget build(BuildContext context) => Expanded(child: Column(children: [
    Text(label, style: TextStyle(fontSize: 10,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5))),
    const SizedBox(height: 2),
    Text(value, maxLines: 1, overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color)),
    if (subValue != null)
      Text(subValue!, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45),
          )),
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
  ['gold',    'Gold'],
];

// Supported gold karats
const _kKarats = [24, 22, 21, 18, 14, 10, 9];

IconData _typeIcon(String type) {
  switch (type) {
    case 'cash':    return Icons.payments_outlined;
    case 'savings': return Icons.savings_outlined;
    case 'credit':  return Icons.credit_card_outlined;
    case 'wallet':  return Icons.account_balance_wallet_outlined;
    case 'gold':    return Icons.diamond_outlined;
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
  final _nameCtrl  = TextEditingController();
  final _balCtrl   = TextEditingController();
  final _gramsCtrl = TextEditingController();

  String _type             = 'bank';
  String _currency         = 'EGP';
  int    _color            = 0xFF6750A4;
  bool   _excludeFromTotal = false;
  int    _goldKarat        = 24;

  bool get isEdit => widget.existing != null;
  bool get isGold => _type == 'gold';

  @override
  void initState() {
    super.initState();
    final app = context.read<AppProvider>();
    _currency = app.settings.currency;
    final e = widget.existing;
    if (e != null) {
      _nameCtrl.text    = e.name;
      _type             = e.type;
      _currency         = e.currency;
      _color            = e.colorValue;
      _excludeFromTotal = e.excludeFromTotal;
      if (e.isGold) {
        _goldKarat = e.goldKarat ?? 24;
        _gramsCtrl.text = e.goldGrams?.toStringAsFixed(2) ?? '';
      } else {
        _balCtrl.text = e.balance.toStringAsFixed(2);
      }
    }
    // Keep live preview updated as user types grams
    _gramsCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _balCtrl.dispose();
    _gramsCtrl.dispose();
    super.dispose();
  }

  /// Live-preview the gold value in the selected currency.
  double? _previewGoldValue(AppProvider app) {
    final grams = double.tryParse(_gramsCtrl.text);
    if (grams == null || grams <= 0) return null;
    return app.computeGoldValue(
      grams: grams,
      karat: _goldKarat,
      currency: _currency,
    );
  }

  Future<void> _submit() async {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) return;
    final app = context.read<AppProvider>();

    if (isGold) {
      final grams = double.tryParse(_gramsCtrl.text);
      if (grams == null || grams <= 0) return;

      // Guard: gold price must be available before saving.
      final computedBalance = app.computeGoldValue(
        grams: grams,
        karat: _goldKarat,
        currency: _currency,
      );
      if (computedBalance == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Gold price not yet loaded. Wait a moment and try again.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
        return;
      }

      if (isEdit) {
        await app.updateAccount(widget.existing!.copyWith(
          name: name, type: _type, currency: _currency,
          balance: computedBalance,
          colorValue: _color, excludeFromTotal: _excludeFromTotal,
          goldKarat: _goldKarat, goldGrams: grams,
        ));
      } else {
        await app.addAccount(Account(
          id: app.newId(), name: name, type: _type, currency: _currency,
          balance: computedBalance,
          colorValue: _color, excludeFromTotal: _excludeFromTotal,
          goldKarat: _goldKarat, goldGrams: grams,
        ));
      }
    } else {
      // Regular account
      if (isEdit) {
        await app.updateAccount(widget.existing!.copyWith(
          name: name, type: _type, currency: _currency,
          balance: double.tryParse(_balCtrl.text) ?? widget.existing!.balance,
          colorValue: _color, excludeFromTotal: _excludeFromTotal,
          clearGold: true,
        ));
      } else {
        await app.addAccount(Account(
          id: app.newId(), name: name, type: _type, currency: _currency,
          balance: double.tryParse(_balCtrl.text) ?? 0,
          colorValue: _color, excludeFromTotal: _excludeFromTotal,
        ));
      }
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // Watch so live gold preview rebuilds when rates arrive.
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    final preview = isGold ? _previewGoldValue(app) : null;

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

          // ── Type cards ──────────────────────────────────────────────
          Text('Account Type', style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: _kTypeOptions.map((opt) {
            final val = opt[0];
            final lbl = opt[1];
            final sel = _type == val;
            return GestureDetector(
              onTap: () => setState(() {
                _type = val;
                // When switching to gold, default currency to main currency.
                if (val == 'gold') {
                  _currency = app.settings.currency;
                }
              }),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                decoration: BoxDecoration(
                  color: sel
                      ? (val == 'gold' ? const Color(0xFFB8860B) : cs.primary)
                      : cs.surfaceContainerHigh,
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

          // ── Currency picker ─────────────────────────────────────────
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

          // ── Gold-specific fields ────────────────────────────────────
          if (isGold) ...[
            // Karat selector
            Text('Gold Purity (Karat)', style: Theme.of(context).textTheme.labelMedium
                ?.copyWith(letterSpacing: 1)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: _kKarats.map((k) {
                final sel = _goldKarat == k;
                return GestureDetector(
                  onTap: () => setState(() => _goldKarat = k),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                    decoration: BoxDecoration(
                      color: sel
                          ? const Color(0xFFB8860B)
                          : const Color(0xFFB8860B).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: sel
                            ? const Color(0xFFB8860B)
                            : const Color(0xFFB8860B).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text('${k}k', style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 14,
                          color: sel ? Colors.white : const Color(0xFFB8860B))),
                      Text('${(k / 24 * 100).toStringAsFixed(0)}%',
                          style: TextStyle(fontSize: 9,
                              color: sel
                                  ? Colors.white.withValues(alpha: 0.8)
                                  : const Color(0xFFB8860B).withValues(alpha: 0.7))),
                    ]),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 14),

            // Weight field
            Text('Weight', style: Theme.of(context).textTheme.labelMedium
                ?.copyWith(letterSpacing: 1)),
            const SizedBox(height: 8),
            TextField(
              controller: _gramsCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Weight in grams',
                prefixIcon: Icon(Icons.scale_outlined),
                suffixText: 'g',
              ),
            ),
            const SizedBox(height: 12),

            // Live value preview card
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: app.goldRatesAvailable
                  ? _GoldPreviewCard(
                      key: ValueKey(preview?.toStringAsFixed(0) ?? 'no'),
                      preview: preview,
                      currency: _currency,
                      karat: _goldKarat,
                      grams: double.tryParse(_gramsCtrl.text),
                      app: app,
                    )
                  : _GoldRatesUnavailableBanner(
                      key: ValueKey(app.ratesFetching),
                      fetching: app.ratesFetching,
                    ),
            ),
            const SizedBox(height: 14),
          ] else ...[
            // ── Regular balance field ─────────────────────────────────
            TextField(
              controller: _balCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                  labelText: isEdit ? 'Balance' : 'Initial Balance',
                  prefixText: '${currencyInfo(_currency).symbol} '),
            ),
            const SizedBox(height: 6),
          ],

          // ── Exclude from total ──────────────────────────────────────
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

          // ── Colour picker ───────────────────────────────────────────
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
                  duration: const Duration(milliseconds: 60),
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
                backgroundColor: isGold ? const Color(0xFFB8860B) : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28))),
            child: Text(isEdit ? 'Save Changes' : 'Add Account'),
          ),
        ],
      )),
    );
  }
}

// ── Gold rates unavailable banner ──────────────────────────────────────────────
class _GoldRatesUnavailableBanner extends StatelessWidget {
  final bool fetching;
  const _GoldRatesUnavailableBanner({super.key, required this.fetching});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(children: [
        if (fetching)
          SizedBox(
            width: 14, height: 14,
            child: CircularProgressIndicator(
                strokeWidth: 2,
                color: cs.onSurface.withValues(alpha: 0.4)),
          )
        else
          Icon(Icons.wifi_off_rounded, size: 16,
              color: cs.onSurface.withValues(alpha: 0.4)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            fetching
                ? 'Fetching gold price…'
                : 'Gold price unavailable — check your connection',
            style: TextStyle(
                fontSize: 12, color: cs.onSurface.withValues(alpha: 0.5)),
          ),
        ),
      ]),
    );
  }
}

// ── Gold value live preview card ───────────────────────────────────────────────
class _GoldPreviewCard extends StatelessWidget {
  final double? preview;
  final String  currency;
  final int     karat;
  final double? grams;
  final AppProvider app;

  const _GoldPreviewCard({
    super.key,
    required this.preview,
    required this.currency,
    required this.karat,
    required this.grams,
    required this.app,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final goldColor = const Color(0xFFB8860B);

    // Price per gram of this karat in the chosen currency
    final pricePerGram24k = app.goldPricePerGram(currency);
    final pricePerGramKarat = pricePerGram24k != null
        ? pricePerGram24k * karat / 24
        : null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: goldColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: goldColor.withValues(alpha: 0.3)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(Icons.diamond_outlined, size: 14, color: goldColor),
          const SizedBox(width: 6),
          Text('Live Gold Value', style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w700,
              color: goldColor, letterSpacing: 0.5)),
        ]),
        const SizedBox(height: 8),

        // Big value display
        if (preview != null)
          Text(formatAmount(preview!, currency),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                  color: goldColor))
        else
          Text('Enter weight above to see value',
              style: TextStyle(fontSize: 13,
                  color: cs.onSurface.withValues(alpha: 0.4))),

        // Breakdown info
        if (pricePerGramKarat != null) ...[
          const SizedBox(height: 6),
          Divider(color: goldColor.withValues(alpha: 0.2), height: 12),
          _InfoRow(
            label: 'Spot price (${karat}k gold/g)',
            value: formatAmount(pricePerGramKarat, currency),
            color: goldColor,
          ),
          if (grams != null && grams! > 0) ...[
            _InfoRow(
              label: 'Weight × purity',
              value: '${grams!.toStringAsFixed(2)} g × ${(karat / 24 * 100).toStringAsFixed(1)}%',
              color: cs.onSurface.withValues(alpha: 0.6),
            ),
          ],
        ],
      ]),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label, value;
  final Color  color;
  const _InfoRow({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 3),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: TextStyle(fontSize: 11,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5))),
      Text(value, style: TextStyle(fontSize: 11,
          fontWeight: FontWeight.w600, color: color)),
    ]),
  );
}
