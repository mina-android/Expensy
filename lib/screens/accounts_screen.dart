// lib/screens/accounts_screen.dart
import 'package:flutter/material.dart';
import '../utils/snackbar.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../utils/haptics.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;

    final hasMultiCurrency =
        app.accounts.any((a) => a.currency != app.settings.currency);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(l10n.accounts_accounts,
              style: const TextStyle(fontWeight: FontWeight.w800)),
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          actions: [
            if (hasMultiCurrency)
              IconButton(
                icon: app.ratesFetching
                    ? SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: cs.onPrimary),
                      )
                    : Icon(Icons.sync_rounded, color: cs.onPrimary),
                tooltip: l10n.accounts_refreshExchangeRates,
                onPressed: app.ratesFetching
                    ? null
                    : () => context.read<AppProvider>().refreshRates(),
              ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(l10n.accounts_totalBalance,
                        style: TextStyle(
                            fontSize: 10,
                            color: cs.onPrimary.withValues(alpha: 0.7))),
                    Text(
                        formatAmount(
                            app.totalBalanceAll, app.settings.currency),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: cs.onPrimary)),
                  ]),
            ),
          ],
          bottom: TabBar(
            indicatorColor: cs.onPrimary,
            labelColor: cs.onPrimary,
            unselectedLabelColor: cs.onPrimary.withValues(alpha: 0.6),
            tabs: const [
              Tab(text: 'Accounts'),
              Tab(text: 'Cards'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Accounts
            Builder(builder: (context) {
              final regularAccounts = app.accounts
                  .where((a) => !['credit', 'debit'].contains(a.type))
                  .toList();
              if (regularAccounts.isEmpty) {
                return EmptyState(
                    icon: Icons.account_balance_wallet_outlined,
                    message: l10n.accounts_noAccounts,
                    subMessage: l10n.accounts_tapPlusToAddYourFirst);
              }
              return Column(
                children: [
                  if (hasMultiCurrency) _RatesBanner(app: app),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 140),
                      itemCount: regularAccounts.length,
                      itemBuilder: (_, i) =>
                          _AccountCard(acc: regularAccounts[i]),
                    ),
                  ),
                ],
              );
            }),
            // Tab 2: Cards
            Builder(builder: (context) {
              final cardAccounts = app.accounts
                  .where((a) => ['credit', 'debit'].contains(a.type))
                  .toList();
              if (cardAccounts.isEmpty) {
                return const EmptyState(
                    icon: Icons.credit_card,
                    message: 'No Cards',
                    subMessage: 'Tap + to add your first card');
              }
              return Column(
                children: [
                  if (hasMultiCurrency) _RatesBanner(app: app),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 140),
                      itemCount: cardAccounts.length,
                      itemBuilder: (_, i) =>
                          _RealWorldCard(acc: cardAccounts[i]),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 76),
          child: ExpandableFab(
            label: l10n.home_add,
            items: [
              ExpandableFabItem(
                label: 'Add Account',
                icon: Icons.account_balance_wallet_rounded,
                color: const Color(0xFF2E7D32),
                onTap: () => openSheet(context, isCard: false),
              ),
              ExpandableFabItem(
                label: 'Add Card',
                icon: Icons.credit_card_rounded,
                color: const Color(0xFF2E7D32),
                onTap: () => openSheet(context, isCard: true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void openSheet(BuildContext context,
      {Account? existing, bool isCard = false}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => isCard
          ? _CardSheet(existing: existing, isCard: true)
          : _AccountSheet(existing: existing, isCard: false),
    );
  }
}

// ── Rates status banner ───────────────────────────────────────────────────────
class _RatesBanner extends StatelessWidget {
  final AppProvider app;
  const _RatesBanner({required this.app});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    String label;
    Color bgColor;
    Color fgColor;
    IconData icon;

    if (app.ratesFetching && !app.ratesLoaded) {
      label = l10n.accounts_fetchingExchangeRates;
      bgColor = cs.surfaceContainerHigh;
      fgColor = cs.onSurface.withValues(alpha: 0.6);
      icon = Icons.sync_rounded;
    } else if (app.exchangeRates.isEmpty) {
      label = l10n.accounts_exchangeRatesUnavailable;
      bgColor = cs.errorContainer.withValues(alpha: 0.4);
      fgColor = cs.error;
      icon = Icons.wifi_off_rounded;
    } else {
      final lastFetched = app.ratesLastFetched;
      final timeStr = lastFetched != null
          ? DateFormat('d MMM, HH:mm').format(lastFetched)
          : l10n.accounts_unknown;
      label = l10n.accounts_ratesUpdated(timeStr);
      bgColor = cs.surfaceContainerHigh;
      fgColor = cs.onSurface.withValues(alpha: 0.5);
      icon = Icons.currency_exchange_rounded;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      color: bgColor,
      child: Row(children: [
        Icon(icon, size: 13, color: fgColor),
        const SizedBox(width: 6),
        Expanded(
            child: Text(label, style: TextStyle(fontSize: 11, color: fgColor))),
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
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final app = context.watch<AppProvider>();
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
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(acc.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: color)),
                  if (acc.excludeFromTotal) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          color: cs.errorContainer,
                          borderRadius: BorderRadius.circular(6)),
                      child: Text(l10n.accounts_excluded,
                          style: TextStyle(
                              fontSize: 9,
                              color: cs.error,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ]),
                // Type label row with optional gold badge
                Row(children: [
                  Text(
                      acc.isGold
                          ? l10n.accounts_goldCaps
                          : acc.type.toUpperCase(),
                      style: TextStyle(
                          fontSize: 10,
                          letterSpacing: 1,
                          color: color.withValues(alpha: 0.7))),
                  if (acc.isGold &&
                      acc.goldKarat != null &&
                      acc.goldGrams != null) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
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
                  if (acc.type == 'credit' && acc.dueDay != null) ...[
                    Builder(builder: (context) {
                      final now = DateTime.now();
                      int maxDays = DateTime(now.year, now.month + 1, 0).day;
                      int safeDay =
                          acc.dueDay! > maxDays ? maxDays : acc.dueDay!;
                      DateTime due = DateTime(now.year, now.month, safeDay);
                      if (due
                          .isBefore(DateTime(now.year, now.month, now.day))) {
                        int nm = now.month + 1, ny = now.year;
                        if (nm > 12) {
                          nm = 1;
                          ny++;
                        }
                        maxDays = DateTime(ny, nm + 1, 0).day;
                        safeDay = acc.dueDay! > maxDays ? maxDays : acc.dueDay!;
                        due = DateTime(ny, nm, safeDay);
                      }
                      final diff = due
                          .difference(DateTime(now.year, now.month, now.day))
                          .inDays;
                      final isDueSoon = diff <= 5;

                      return Container(
                        margin: const EdgeInsets.only(left: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: isDueSoon
                              ? cs.errorContainer
                              : cs.primaryContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          isDueSoon
                              ? (diff == 0 ? 'Due Today' : 'Due in $diff days')
                              : 'Due on ${acc.dueDay}',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: isDueSoon ? cs.error : cs.primary,
                          ),
                        ),
                      );
                    }),
                  ],
                ]),
              ],
            )),
            Consumer<AppProvider>(builder: (context, ap, _) {
              final isPinned =
                  ap.settings.pinnedWidgetAccountIds.contains(acc.id);
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: IconButton(
                  key: ValueKey(isPinned),
                  icon: Icon(
                      isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                      size: 20),
                  color: isPinned ? cs.primary : color,
                  tooltip: isPinned ? 'Unpin from Widget' : 'Pin to Widget',
                  onPressed: () {
                    final success = ap.toggleWidgetPin(acc.id);
                    if (!success && context.mounted) {
                      showAppSnackbar(
                        context,
                        'You cannot pin more than 3 accounts',
                      );
                    }
                  },
                ),
              );
            }),
            IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                color: color,
                onPressed: () =>
                    AccountsScreen.openSheet(context, existing: acc)),
            IconButton(
                icon: const Icon(Icons.delete_outline_rounded, size: 20),
                color: cs.error,
                onPressed: () async {
                  final undo = await context
                      .read<AppProvider>()
                      .deleteAccountWithUndo(acc.id);
                  if (context.mounted) {
                    showAppSnackbar(context, 'Account deleted', onUndo: undo);
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

  Widget _regularStatsRow(BuildContext context, AppProvider app, ColorScheme cs,
      Color color, bool showConverted) {
    final l10n = AppLocalizations.of(context)!;
    final displayBalance =
        acc.type == 'bank' ? app.getBankTotalBalance(acc.id) : acc.balance;
    return Row(children: [
      _Stat(
        label: l10n.accounts_balance,
        value: formatAmount(displayBalance, acc.currency),
        subValue: showConverted
            ? '≈ ${formatAmount(app.convertToMain(displayBalance, acc.currency), app.settings.currency)}'
            : null,
        color: color,
      ),
      _Divider(),
      _Stat(
          label: l10n.accounts_income,
          value: '+${formatAmount(app.getAccountIncome(acc.id), acc.currency)}',
          color: const Color(0xFF2E7D32)),
      _Divider(),
      _Stat(
          label: l10n.accounts_expense,
          value:
              '-${formatAmount(app.getAccountExpense(acc.id), acc.currency)}',
          color: const Color(0xFFC62828)),
      _Divider(),
      _Stat(
          label: l10n.accounts_txs,
          value: '${app.getAccountTransactions(acc.id).length}',
          color: cs.secondary),
    ]);
  }

  Widget _goldStatsRow(BuildContext context, AppProvider app, ColorScheme cs,
      Color color, bool showConverted) {
    final l10n = AppLocalizations.of(context)!;
    final karat = acc.goldKarat ?? 24;
    final grams = acc.goldGrams ?? 0;
    final pricePerGram = grams > 0 && acc.balance > 0
        ? acc.balance / grams
        : app.goldPricePerGram(acc.currency) != null
            ? (app.goldPricePerGram(acc.currency)! * karat / 24)
            : null;

    return Row(children: [
      _Stat(
        label: l10n.accounts_value,
        value: formatAmount(acc.balance, acc.currency),
        subValue: showConverted
            ? '≈ ${formatAmount(app.convertToMain(acc.balance, acc.currency), app.settings.currency)}'
            : null,
        color: color,
      ),
      _Divider(),
      _Stat(
        label: l10n.accounts_karat,
        value: '${karat}k',
        subValue: l10n.accounts_pure((karat / 24 * 140).toStringAsFixed(1)),
        color: const Color(0xFFB8860B),
      ),
      _Divider(),
      _Stat(
        label: l10n.accounts_weightLabel,
        value: '${grams.toStringAsFixed(2)} g',
        color: color,
      ),
      _Divider(),
      _Stat(
        label: l10n.accounts_perGram,
        value: pricePerGram != null
            ? formatAmount(pricePerGram, acc.currency)
            : '—',
        color: cs.secondary,
      ),
    ]);
  }
}

class _Stat extends StatelessWidget {
  final String label, value;
  final String? subValue;
  final Color color;
  const _Stat(
      {required this.label,
      required this.value,
      this.subValue,
      required this.color});
  @override
  Widget build(BuildContext context) => Expanded(
          child: Column(children: [
        Text(label,
            style: TextStyle(
                fontSize: 10,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.5))),
        const SizedBox(height: 2),
        Text(value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w700, color: color)),
        if (subValue != null)
          Text(subValue!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.45),
              )),
      ]));
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      height: 28,
      width: 1,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1));
}

// ── Account Sheet ─────────────────────────────────────────────────────────────
// _kTypeOptions removed, initialized in build method instead

// Supported gold karats
const _kKarats = [24, 22, 21, 18, 14, 10, 9];

IconData _typeIcon(String type) {
  switch (type) {
    case 'cash':
      return Icons.payments_outlined;
    case 'savings':
      return Icons.savings_outlined;
    case 'credit':
      return Icons.credit_card_outlined;
    case 'wallet':
      return Icons.account_balance_wallet_outlined;
    case 'gold':
      return Icons.diamond_outlined;
    default:
      return Icons.account_balance_outlined;
  }
}

const List<int> _kColors = [
  0xFF6750A4,
  0xFF7D5260,
  0xFF1565C0,
  0xFF2E7D32,
  0xFFE65100,
  0xFF00897B,
  0xFFC62828,
  0xFF37474F,
  0xFF0077B6,
  0xFF9C27B0,
  0xFF00BFA5,
  0xFFF9A825,
  0xFF6D4C41,
  0xFF283593,
  0xFFAD1457,
  0xFF558B2F,
  0xFF00838F,
  0xFFBF360C,
  0xFF4527A0,
  0xFF1B5E20,
  0xFF880E4F,
  0xFF33691E,
  0xFF004D40,
  0xFFB71C1C,
];

class _AccountSheet extends StatefulWidget {
  final Account? existing;
  final bool isCard;
  const _AccountSheet({this.existing, this.isCard = false});
  @override
  State<_AccountSheet> createState() => _AccountSheetState();
}

class _AccountSheetState extends State<_AccountSheet> {
  final _nameCtrl = TextEditingController();
  final _balCtrl = TextEditingController();
  final _gramsCtrl = TextEditingController();

  // Card specific
  final _creditLimitCtrl = TextEditingController();
  final _dueDayCtrl = TextEditingController();
  final _cardHolderNameCtrl = TextEditingController();
  final _cardNumberLast4Ctrl = TextEditingController();
  final _cardExpiryCtrl = TextEditingController();
  String? _linkedAccountId;

  late String _type;
  String _currency = 'EGP';
  int _color = 0xFF6750A4;
  bool _excludeFromTotal = false;
  bool _excludeFromBankTotal = false;
  int _goldKarat = 24;

  // Reminders
  bool _creditReminderEnabled = false;
  bool _creditEarlyReminderEnabled = false;
  TimeOfDay _creditReminderTime = const TimeOfDay(hour: 9, minute: 0);

  bool _submitted = false;

  bool get isEdit => widget.existing != null;
  bool get isGold => _type == 'gold';
  bool get isCredit => _type == 'credit';
  bool get isCard => widget.isCard;

  @override
  void initState() {
    super.initState();
    final app = context.read<AppProvider>();
    _currency = app.settings.currency;
    _type = isCard ? 'credit' : 'bank';

    final e = widget.existing;
    if (e != null) {
      _nameCtrl.text = e.name;
      _type = e.type;
      _currency = e.currency;
      _color = e.colorValue;
      _excludeFromTotal = e.excludeFromTotal;
      if (e.isGold) {
        _goldKarat = e.goldKarat ?? 24;
        _gramsCtrl.text = e.goldGrams?.toStringAsFixed(2) ?? '';
      } else {
        _balCtrl.text = e.balance.toStringAsFixed(2);
      }
      if (e.type == 'credit' || e.type == 'debit') {
        _cardHolderNameCtrl.text = e.cardHolderName ?? '';
        _cardNumberLast4Ctrl.text = e.cardNumberLast4 ?? '';
        _cardExpiryCtrl.text = e.cardExpiry ?? '';
        _linkedAccountId = e.linkedAccountId;
        _excludeFromBankTotal = e.excludeFromBankTotal;
        if (e.type == 'credit') {
          _creditLimitCtrl.text = e.creditLimit?.toString() ?? '';
          _dueDayCtrl.text = e.dueDay?.toString() ?? '';
          _creditReminderEnabled = e.creditReminderEnabled;
          _creditEarlyReminderEnabled = e.creditEarlyReminderEnabled;
          final parts = e.creditReminderTime.split(':');
          if (parts.length == 2) {
            _creditReminderTime = TimeOfDay(
              hour: int.tryParse(parts[0]) ?? 9,
              minute: int.tryParse(parts[1]) ?? 0,
            );
          }
        }
      }
    }
    // (Live preview now updated via ValueListenableBuilder)
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _balCtrl.dispose();
    _gramsCtrl.dispose();
    _creditLimitCtrl.dispose();
    _dueDayCtrl.dispose();
    _cardHolderNameCtrl.dispose();
    _cardNumberLast4Ctrl.dispose();
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

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _creditReminderTime,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          timePickerTheme: TimePickerThemeData(
            backgroundColor: Theme.of(context).colorScheme.surface,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _creditReminderTime = picked);
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    final l10n = AppLocalizations.of(context)!;
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
          showAppSnackbar(context, l10n.accounts_goldPriceNotYetLoade);
        }
        return;
      }

      if (isEdit) {
        await app.updateAccount(widget.existing!.copyWith(
          name: name,
          type: _type,
          currency: _currency,
          balance: computedBalance,
          colorValue: _color,
          excludeFromTotal: _excludeFromTotal,
          goldKarat: _goldKarat,
          goldGrams: grams,
        ));
      } else {
        await app.addAccount(Account(
          id: app.newId(),
          name: name,
          type: _type,
          currency: _currency,
          balance: computedBalance,
          colorValue: _color,
          excludeFromTotal: _excludeFromTotal,
          goldKarat: _goldKarat,
          goldGrams: grams,
        ));
      }
    } else {
      // Regular account or Card
      final balance = double.tryParse(_balCtrl.text) ??
          (isEdit ? widget.existing!.balance : 0);
      double? creditLimit;
      int? dueDay;
      String? cardHolderName;
      String? cardNumberLast4;
      String? cardExpiry;
      String? linkedAccountId;

      if (isCard) {
        cardHolderName = _cardHolderNameCtrl.text.trim();
        cardNumberLast4 = _cardNumberLast4Ctrl.text.trim();
        cardExpiry = _cardExpiryCtrl.text.trim();
        linkedAccountId = _linkedAccountId;
        if (isCredit) {
          creditLimit = double.tryParse(_creditLimitCtrl.text);
          dueDay = int.tryParse(_dueDayCtrl.text);
        }
      }

      final reminderTimeStr =
          '${_creditReminderTime.hour.toString().padLeft(2, '0')}:${_creditReminderTime.minute.toString().padLeft(2, '0')}';

      if (isEdit) {
        await app.updateAccount(widget.existing!.copyWith(
          name: name,
          type: _type,
          currency: _currency,
          balance: balance,
          colorValue: _color,
          excludeFromTotal: _excludeFromTotal,
          excludeFromBankTotal: _excludeFromBankTotal,
          cardHolderName: cardHolderName,
          cardNumberLast4: cardNumberLast4,
          cardExpiry: cardExpiry,
          creditLimit: creditLimit,
          dueDay: dueDay,
          creditReminderEnabled: _creditReminderEnabled,
          creditEarlyReminderEnabled: _creditEarlyReminderEnabled,
          creditReminderTime: reminderTimeStr,
          linkedAccountId: linkedAccountId,
          clearLinkedAccount: _linkedAccountId == null,
          clearGold: true,
          clearCredit: !isCredit && !isCard,
        ));
      } else {
        await app.addAccount(Account(
          id: app.newId(),
          name: name,
          type: _type,
          currency: _currency,
          balance: balance,
          colorValue: _color,
          excludeFromTotal: _excludeFromTotal,
          excludeFromBankTotal: _excludeFromBankTotal,
          cardHolderName: cardHolderName,
          cardNumberLast4: cardNumberLast4,
          cardExpiry: cardExpiry,
          creditLimit: creditLimit,
          linkedAccountId: linkedAccountId,
          dueDay: dueDay,
          creditReminderEnabled: _creditReminderEnabled,
          creditEarlyReminderEnabled: _creditEarlyReminderEnabled,
          creditReminderTime: reminderTimeStr,
        ));
      }
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Watch so live gold preview rebuilds when rates arrive.
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    final preview = isGold ? _previewGoldValue(app) : null;

    final typeOptions = isCard
        ? [
            ['credit', 'Credit Card'],
            ['debit', 'Debit Card'],
          ]
        : [
            ['bank', l10n.accounts_bank],
            ['cash', l10n.accounts_cash],
            ['savings', l10n.accounts_savings],
            ['wallet', l10n.accounts_eWallet],
            ['gold', l10n.accounts_gold],
          ];

    return Padding(
      padding: const EdgeInsets.only(
          bottom: 16,
          left: 20,
          right: 20,
          top: 20),
      child: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              isEdit
                  ? (isCard ? 'Edit Card' : l10n.accounts_editAccount)
                  : (isCard ? 'Add Card' : l10n.accounts_addAccount),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),

          TextField(
            textInputAction: (isCard || _type != 'bank') ? TextInputAction.next : TextInputAction.done,
            onSubmitted: (isCard || _type != 'bank') ? null : (_) => _submit(),
            controller: _nameCtrl,
            decoration: InputDecoration(
              labelText: isCard
                  ? 'Card Name (e.g. Visa Platinum)'
                  : l10n.accounts_accountName,
              prefixIcon: const Icon(Icons.label_outline),
              errorText: _submitted && _nameCtrl.text.trim().isEmpty
                  ? l10n.error_required
                  : null,
            ),
          ),
          const SizedBox(height: 14),

          // ── Type cards ──────────────────────────────────────────────
          Text(l10n.accounts_accountType,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 8),
          Wrap(
              spacing: 8,
              runSpacing: 8,
              children: typeOptions.map((opt) {
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
                    duration: const Duration(milliseconds: 140),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                    decoration: BoxDecoration(
                      color: sel
                          ? (val == 'gold'
                              ? const Color(0xFFB8860B)
                              : cs.primary)
                          : cs.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(_typeIcon(val),
                          size: 16, color: sel ? Colors.white : cs.onSurface),
                      const SizedBox(width: 6),
                      Text(lbl,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: sel ? Colors.white : cs.onSurface)),
                    ]),
                  ),
                );
              }).toList()),
          const SizedBox(height: 14),

          // ── Currency picker ─────────────────────────────────────────
          Text(l10n.accounts_currency,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () async {
              final picked =
                  await showCurrencyPicker(context, current: _currency);
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
                Icon(Icons.monetization_on_outlined,
                    size: 18, color: cs.primary),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(
                        '$_currency  ${currencyInfo(_currency).symbol}  —  ${currencyInfo(_currency).name}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14))),
                const Icon(Icons.arrow_drop_down_rounded),
              ]),
            ),
          ),
          const SizedBox(height: 14),

          // ── Gold-specific fields ────────────────────────────────────
          if (isGold) ...[
            // Karat selector
            Text(l10n.accounts_goldPurityKarat,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(letterSpacing: 1)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _kKarats.map((k) {
                final sel = _goldKarat == k;
                return GestureDetector(
                  onTap: () => setState(() => _goldKarat = k),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 140),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
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
                      Text('${k}k',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: sel
                                  ? Colors.white
                                  : const Color(0xFFB8860B))),
                      Text('${(k / 24 * 140).toStringAsFixed(0)}%',
                          style: TextStyle(
                              fontSize: 9,
                              color: sel
                                  ? Colors.white.withValues(alpha: 0.8)
                                  : const Color(0xFFB8860B)
                                      .withValues(alpha: 0.7))),
                    ]),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 14),

            // Weight field
            Text(l10n.accounts_weight,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(letterSpacing: 1)),
            const SizedBox(height: 8),
            TextField(textInputAction: TextInputAction.done, onSubmitted: (_) => _submit(), 
              controller: _gramsCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: l10n.accounts_weightInGrams,
                prefixIcon: const Icon(Icons.scale_outlined),
                suffixText: 'g',
                errorText:
                    _submitted && (double.tryParse(_gramsCtrl.text) ?? 0) <= 0
                        ? l10n.error_required
                        : null,
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
          ] else if (_type != 'bank') ...[
            // ── Regular balance field ─────────────────────────────────
            TextField(textInputAction: TextInputAction.done, onSubmitted: (_) => _submit(), 
              controller: _balCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                  labelText: isEdit
                      ? l10n.accounts_balance
                      : l10n.accounts_initialBalance,
                  prefixText: '${currencyInfo(_currency).symbol} '),
            ),
          ],
          if (_type != 'gold') const SizedBox(height: 6),

          if (isCard) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(textInputAction: TextInputAction.next, 
                    controller: _cardHolderNameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Card Holder Name (Optional)',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(textInputAction: TextInputAction.next, 
                    controller: _cardNumberLast4Ctrl,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: const InputDecoration(
                      labelText: 'Last 4 Digits',
                      prefixIcon: Icon(Icons.numbers),
                      counterText: '',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(textInputAction: TextInputAction.done, onSubmitted: (_) => _submit(), 
              controller: _cardExpiryCtrl,
              keyboardType: TextInputType.datetime,
              maxLength: 5,
              decoration: const InputDecoration(
                labelText: 'Expiry Date (MM/YY)',
                prefixIcon: Icon(Icons.calendar_month),
                counterText: '',
              ),
            ),
            const SizedBox(height: 16),
          ],

          if (isCredit) ...[
            Row(
              children: [
                Expanded(
                  child: TextField(textInputAction: TextInputAction.next, 
                    controller: _creditLimitCtrl,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Credit Limit (Optional)',
                      prefixText: '${currencyInfo(_currency).symbol} ',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(textInputAction: TextInputAction.done, onSubmitted: (_) => _submit(), 
                    controller: _dueDayCtrl,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    decoration: const InputDecoration(
                      labelText: 'Due Day (Optional)',
                      hintText: 'e.g. 25',
                      counterText: '',
                    ),
                  ),
                ),
              ],
            ),
          ],

          if (isCard) ...[
            const SizedBox(height: 16),
            Text('Linked Bank Account (Optional)',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(letterSpacing: 1)),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _linkedAccountId = null),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 140),
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        color: _linkedAccountId == null
                            ? cs.primary
                            : cs.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text('None',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _linkedAccountId == null
                                  ? Colors.white
                                  : cs.onSurface)),
                    ),
                  ),
                  ...app.accounts.where((a) => a.type == 'bank').map((a) {
                    final sel = _linkedAccountId == a.id;
                    return GestureDetector(
                      onTap: () => setState(() => _linkedAccountId = a.id),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 140),
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        decoration: BoxDecoration(
                          color: sel ? cs.primary : cs.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(a.name,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: sel ? Colors.white : cs.onSurface)),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 4),
          ],

          if (isCredit) ...[
            const SizedBox(height: 16),
            _CreditReminderSection(
              enabled: _creditReminderEnabled,
              earlyEnabled: _creditEarlyReminderEnabled,
              time: _creditReminderTime,
              onEnabledChanged: (v) => setState(() => _creditReminderEnabled = v),
              onEarlyEnabledChanged: (v) => setState(() => _creditEarlyReminderEnabled = v),
              onPickTime: _pickTime,
            ),
          ],

          // ── Exclude from total ──────────────────────────────────────
          if (_type != 'bank')
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.accounts_excludeFromTotalBala,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14)),
              subtitle: Text(l10n.accounts_wontCountTowardYourHome,
                  style: TextStyle(
                      fontSize: 12,
                      color: cs.onSurface.withValues(alpha: 0.5))),
              value: _excludeFromTotal,
              onChanged: (v) => setState(() => _excludeFromTotal = v),
            ),
          if (isCard && _linkedAccountId != null) ...[
            const SizedBox(height: 14),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: const Text('Exclude card balance from account balance',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              subtitle: Text(
                  'This card\'s balance will not be added to its linked bank account.',
                  style: TextStyle(
                      fontSize: 12,
                      color: cs.onSurface.withValues(alpha: 0.5))),
              value: _excludeFromBankTotal,
              onChanged: (v) => setState(() => _excludeFromBankTotal = v),
            ),
          ],
          const SizedBox(height: 14),

          // ── Color picker ────────────────────────────────────────────
          Text(l10n.accounts_color,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 8),
          SizedBox(
            height: 44,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _kColors.map((c) {
                  final sel = _color == c;
                  return GestureDetector(
                    onTap: () => setState(() => _color = c),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 36,
                      height: 36,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Color(c),
                        shape: BoxShape.circle,
                        border: sel
                            ? Border.all(color: cs.onSurface, width: 2)
                            : null,
                        boxShadow: sel
                            ? [
                                BoxShadow(
                                    color: Color(c).withValues(alpha: 0.4),
                                    blurRadius: 8)
                              ]
                            : [],
                      ),
                      child: sel
                          ? const Icon(Icons.check,
                              color: Colors.white, size: 18)
                          : null,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // ── Actions ─────────────────────────────────────────────────
          Row(children: [
            Expanded(
                child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.shared_widgets_cancel),
            )),
            const SizedBox(width: 12),
            Expanded(
                child: FilledButton(
              onPressed: () {
                AppHaptics.tap(context, HapticStrength.light);
                _submit();
              },
              child: Text(isEdit
                  ? l10n.accounts_saveChanges
                  : l10n.accounts_addAccount),
            )),
          ]),
        ],
      )),
    );
  }
}

// ── Real World Card UI ────────────────────────────────────────────────────────
class _CardSheet extends StatefulWidget {
  final Account? existing;
  final bool isCard;
  const _CardSheet({this.existing, this.isCard = false});
  @override
  State<_CardSheet> createState() => _CardSheetState();
}

class _CardSheetState extends State<_CardSheet> {
  final _nameCtrl = TextEditingController();
  final _balCtrl = TextEditingController();
  final _gramsCtrl = TextEditingController();

  // Card specific
  final _creditLimitCtrl = TextEditingController();
  final _dueDayCtrl = TextEditingController();
  final _cardHolderNameCtrl = TextEditingController();
  final _cardNumberLast4Ctrl = TextEditingController();
  final _cardExpiryCtrl = TextEditingController();
  String? _linkedAccountId;

  late String _type;
  String _currency = 'EGP';
  int _color = 0xFF6750A4;
  bool _excludeFromTotal = false;
  bool _excludeFromBankTotal = false;
  int _goldKarat = 24;

  // Reminders
  bool _creditReminderEnabled = false;
  bool _creditEarlyReminderEnabled = false;
  TimeOfDay _creditReminderTime = const TimeOfDay(hour: 9, minute: 0);

  bool _submitted = false;

  bool get isEdit => widget.existing != null;
  bool get isGold => _type == 'gold';
  bool get isCredit => _type == 'credit';
  bool get isCard => widget.isCard;

  @override
  void initState() {
    super.initState();
    final app = context.read<AppProvider>();
    _currency = app.settings.currency;
    _type = isCard ? 'credit' : 'bank';

    final e = widget.existing;
    if (e != null) {
      _nameCtrl.text = e.name;
      _type = e.type;
      _currency = e.currency;
      _color = e.colorValue;
      _excludeFromTotal = e.excludeFromTotal;
      if (e.isGold) {
        _goldKarat = e.goldKarat ?? 24;
        _gramsCtrl.text = e.goldGrams?.toStringAsFixed(2) ?? '';
      } else {
        _balCtrl.text = e.balance.toStringAsFixed(2);
      }
      if (e.type == 'credit' || e.type == 'debit') {
        _cardHolderNameCtrl.text = e.cardHolderName ?? '';
        _cardNumberLast4Ctrl.text = e.cardNumberLast4 ?? '';
        _cardExpiryCtrl.text = e.cardExpiry ?? '';
        _linkedAccountId = e.linkedAccountId;
        _excludeFromBankTotal = e.excludeFromBankTotal;
        if (e.type == 'credit') {
          _creditLimitCtrl.text = e.creditLimit?.toString() ?? '';
          _dueDayCtrl.text = e.dueDay?.toString() ?? '';
          _creditReminderEnabled = e.creditReminderEnabled;
          _creditEarlyReminderEnabled = e.creditEarlyReminderEnabled;
          final parts = e.creditReminderTime.split(':');
          if (parts.length == 2) {
            _creditReminderTime = TimeOfDay(
              hour: int.tryParse(parts[0]) ?? 9,
              minute: int.tryParse(parts[1]) ?? 0,
            );
          }
        }
      }
    }
    // (Live preview now updated via ValueListenableBuilder)
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _balCtrl.dispose();
    _gramsCtrl.dispose();
    _creditLimitCtrl.dispose();
    _dueDayCtrl.dispose();
    _cardHolderNameCtrl.dispose();
    _cardNumberLast4Ctrl.dispose();
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

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _creditReminderTime,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          timePickerTheme: TimePickerThemeData(
            backgroundColor: Theme.of(context).colorScheme.surface,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _creditReminderTime = picked);
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    final l10n = AppLocalizations.of(context)!;
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
          showAppSnackbar(context, l10n.accounts_goldPriceNotYetLoade);
        }
        return;
      }

      if (isEdit) {
        await app.updateAccount(widget.existing!.copyWith(
          name: name,
          type: _type,
          currency: _currency,
          balance: computedBalance,
          colorValue: _color,
          excludeFromTotal: _excludeFromTotal,
          goldKarat: _goldKarat,
          goldGrams: grams,
        ));
      } else {
        await app.addAccount(Account(
          id: app.newId(),
          name: name,
          type: _type,
          currency: _currency,
          balance: computedBalance,
          colorValue: _color,
          excludeFromTotal: _excludeFromTotal,
          goldKarat: _goldKarat,
          goldGrams: grams,
        ));
      }
    } else {
      // Regular account or Card
      final balance = double.tryParse(_balCtrl.text) ??
          (isEdit ? widget.existing!.balance : 0);
      double? creditLimit;
      int? dueDay;
      String? cardHolderName;
      String? cardNumberLast4;
      String? cardExpiry;
      String? linkedAccountId;

      if (isCard) {
        cardHolderName = _cardHolderNameCtrl.text.trim();
        cardNumberLast4 = _cardNumberLast4Ctrl.text.trim();
        cardExpiry = _cardExpiryCtrl.text.trim();
        linkedAccountId = _linkedAccountId;
        if (isCredit) {
          creditLimit = double.tryParse(_creditLimitCtrl.text);
          dueDay = int.tryParse(_dueDayCtrl.text);
        }
      }

      final reminderTimeStr =
          '${_creditReminderTime.hour.toString().padLeft(2, '0')}:${_creditReminderTime.minute.toString().padLeft(2, '0')}';

      if (isEdit) {
        await app.updateAccount(widget.existing!.copyWith(
          name: name,
          type: _type,
          currency: _currency,
          balance: balance,
          colorValue: _color,
          excludeFromTotal: _excludeFromTotal,
          excludeFromBankTotal: _excludeFromBankTotal,
          cardHolderName: cardHolderName,
          cardNumberLast4: cardNumberLast4,
          cardExpiry: cardExpiry,
          creditLimit: creditLimit,
          dueDay: dueDay,
          creditReminderEnabled: _creditReminderEnabled,
          creditEarlyReminderEnabled: _creditEarlyReminderEnabled,
          creditReminderTime: reminderTimeStr,
          linkedAccountId: linkedAccountId,
          clearLinkedAccount: _linkedAccountId == null,
          clearGold: true,
          clearCredit: !isCredit && !isCard,
        ));
      } else {
        await app.addAccount(Account(
          id: app.newId(),
          name: name,
          type: _type,
          currency: _currency,
          balance: balance,
          colorValue: _color,
          excludeFromTotal: _excludeFromTotal,
          excludeFromBankTotal: _excludeFromBankTotal,
          cardHolderName: cardHolderName,
          cardNumberLast4: cardNumberLast4,
          cardExpiry: cardExpiry,
          creditLimit: creditLimit,
          linkedAccountId: linkedAccountId,
          dueDay: dueDay,
          creditReminderEnabled: _creditReminderEnabled,
          creditEarlyReminderEnabled: _creditEarlyReminderEnabled,
          creditReminderTime: reminderTimeStr,
        ));
      }
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Watch so live gold preview rebuilds when rates arrive.
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    final preview = isGold ? _previewGoldValue(app) : null;

    final typeOptions = isCard
        ? [
            ['credit', 'Credit Card'],
            ['debit', 'Debit Card'],
          ]
        : [
            ['bank', l10n.accounts_bank],
            ['cash', l10n.accounts_cash],
            ['savings', l10n.accounts_savings],
            ['wallet', l10n.accounts_eWallet],
            ['gold', l10n.accounts_gold],
          ];

    return Padding(
      padding: const EdgeInsets.only(
          bottom: 16,
          left: 20,
          right: 20,
          top: 20),
      child: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              isEdit
                  ? (isCard ? 'Edit Card' : l10n.accounts_editAccount)
                  : (isCard ? 'Add Card' : l10n.accounts_addAccount),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),

          TextField(textInputAction: TextInputAction.next, 
            controller: _nameCtrl,
            decoration: InputDecoration(
              labelText: isCard
                  ? 'Card Name (e.g. Visa Platinum)'
                  : l10n.accounts_accountName,
              prefixIcon: const Icon(Icons.label_outline),
              errorText: _submitted && _nameCtrl.text.trim().isEmpty
                  ? l10n.error_required
                  : null,
            ),
          ),
          const SizedBox(height: 14),

          // ── Type cards ──────────────────────────────────────────────
          Text(l10n.accounts_accountType,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 8),
          Wrap(
              spacing: 8,
              runSpacing: 8,
              children: typeOptions.map((opt) {
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
                    duration: const Duration(milliseconds: 140),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                    decoration: BoxDecoration(
                      color: sel
                          ? (val == 'gold'
                              ? const Color(0xFFB8860B)
                              : cs.primary)
                          : cs.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(_typeIcon(val),
                          size: 16, color: sel ? Colors.white : cs.onSurface),
                      const SizedBox(width: 6),
                      Text(lbl,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: sel ? Colors.white : cs.onSurface)),
                    ]),
                  ),
                );
              }).toList()),
          const SizedBox(height: 14),

          // ── Currency picker ─────────────────────────────────────────
          Text(l10n.accounts_currency,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () async {
              final picked =
                  await showCurrencyPicker(context, current: _currency);
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
                Icon(Icons.monetization_on_outlined,
                    size: 18, color: cs.primary),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(
                        '$_currency  ${currencyInfo(_currency).symbol}  —  ${currencyInfo(_currency).name}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14))),
                const Icon(Icons.arrow_drop_down_rounded),
              ]),
            ),
          ),
          const SizedBox(height: 14),

          // ── Gold-specific fields ────────────────────────────────────
          if (isGold) ...[
            // Karat selector
            Text(l10n.accounts_goldPurityKarat,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(letterSpacing: 1)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _kKarats.map((k) {
                final sel = _goldKarat == k;
                return GestureDetector(
                  onTap: () => setState(() => _goldKarat = k),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 140),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
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
                      Text('${k}k',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: sel
                                  ? Colors.white
                                  : const Color(0xFFB8860B))),
                      Text('${(k / 24 * 140).toStringAsFixed(0)}%',
                          style: TextStyle(
                              fontSize: 9,
                              color: sel
                                  ? Colors.white.withValues(alpha: 0.8)
                                  : const Color(0xFFB8860B)
                                      .withValues(alpha: 0.7))),
                    ]),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 14),

            // Weight field
            Text(l10n.accounts_weight,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(letterSpacing: 1)),
            const SizedBox(height: 8),
            TextField(textInputAction: TextInputAction.next, 
              controller: _gramsCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: l10n.accounts_weightInGrams,
                prefixIcon: const Icon(Icons.scale_outlined),
                suffixText: 'g',
                errorText:
                    _submitted && (double.tryParse(_gramsCtrl.text) ?? 0) <= 0
                        ? l10n.error_required
                        : null,
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
          ] else if (_type != 'bank') ...[
            // ── Regular balance field ─────────────────────────────────
            TextField(textInputAction: TextInputAction.next, 
              controller: _balCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                  labelText: isEdit
                      ? l10n.accounts_balance
                      : l10n.accounts_initialBalance,
                  prefixText: '${currencyInfo(_currency).symbol} '),
            ),
          ],
          if (_type != 'gold') const SizedBox(height: 6),

          if (isCard) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(textInputAction: TextInputAction.next, 
                    controller: _cardHolderNameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Card Holder Name (Optional)',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(textInputAction: TextInputAction.next, 
                    controller: _cardNumberLast4Ctrl,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: const InputDecoration(
                      labelText: 'Last 4 Digits',
                      prefixIcon: Icon(Icons.numbers),
                      counterText: '',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(textInputAction: isCredit ? TextInputAction.next : TextInputAction.done, onSubmitted: (_) { if (!isCredit) _submit(); },
              controller: _cardExpiryCtrl,
              keyboardType: TextInputType.datetime,
              maxLength: 5,
              decoration: const InputDecoration(
                labelText: 'Expiry Date (MM/YY)',
                prefixIcon: Icon(Icons.calendar_month),
                counterText: '',
              ),
            ),
            const SizedBox(height: 16),
          ],

          if (isCredit) ...[
            Row(
              children: [
                Expanded(
                  child: TextField(textInputAction: TextInputAction.next, 
                    controller: _creditLimitCtrl,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Credit Limit (Optional)',
                      prefixText: '${currencyInfo(_currency).symbol} ',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(textInputAction: TextInputAction.done, onSubmitted: (_) => _submit(), 
                    controller: _dueDayCtrl,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    decoration: const InputDecoration(
                      labelText: 'Due Day (Optional)',
                      hintText: 'e.g. 25',
                      counterText: '',
                    ),
                  ),
                ),
              ],
            ),
          ],

          if (isCard) ...[
            const SizedBox(height: 16),
            Text('Linked Bank Account (Optional)',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(letterSpacing: 1)),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _linkedAccountId = null),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 140),
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        color: _linkedAccountId == null
                            ? cs.primary
                            : cs.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text('None',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _linkedAccountId == null
                                  ? Colors.white
                                  : cs.onSurface)),
                    ),
                  ),
                  ...app.accounts.where((a) => a.type == 'bank').map((a) {
                    final sel = _linkedAccountId == a.id;
                    return GestureDetector(
                      onTap: () => setState(() => _linkedAccountId = a.id),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 140),
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        decoration: BoxDecoration(
                          color: sel ? cs.primary : cs.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(a.name,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: sel ? Colors.white : cs.onSurface)),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 4),
          ],

          if (isCredit) ...[
            const SizedBox(height: 8),
            _CreditReminderSection(
              enabled: _creditReminderEnabled,
              earlyEnabled: _creditEarlyReminderEnabled,
              time: _creditReminderTime,
              onEnabledChanged: (v) => setState(() => _creditReminderEnabled = v),
              onEarlyEnabledChanged: (v) => setState(() => _creditEarlyReminderEnabled = v),
              onPickTime: _pickTime,
            ),
          ],

          // ── Exclude from total ──────────────────────────────────────
          if (_type != 'bank')
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.accounts_excludeFromTotalBala,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14)),
              subtitle: Text(l10n.accounts_wontCountTowardYourHome,
                  style: TextStyle(
                      fontSize: 12,
                      color: cs.onSurface.withValues(alpha: 0.5))),
              value: _excludeFromTotal,
              onChanged: (v) => setState(() => _excludeFromTotal = v),
            ),
          if (isCard && _linkedAccountId != null) ...[
            const SizedBox(height: 14),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: const Text('Exclude card balance from account balance',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              subtitle: Text(
                  'This card\'s balance will not be added to its linked bank account.',
                  style: TextStyle(
                      fontSize: 12,
                      color: cs.onSurface.withValues(alpha: 0.5))),
              value: _excludeFromBankTotal,
              onChanged: (v) => setState(() => _excludeFromBankTotal = v),
            ),
          ],
          const SizedBox(height: 14),

          // ── Color picker ────────────────────────────────────────────
          Text(l10n.accounts_color,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 8),
          SizedBox(
            height: 44,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _kColors.map((c) {
                  final sel = _color == c;
                  return GestureDetector(
                    onTap: () => setState(() => _color = c),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 36,
                      height: 36,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Color(c),
                        shape: BoxShape.circle,
                        border: sel
                            ? Border.all(color: cs.onSurface, width: 2)
                            : null,
                        boxShadow: sel
                            ? [
                                BoxShadow(
                                    color: Color(c).withValues(alpha: 0.4),
                                    blurRadius: 8)
                              ]
                            : [],
                      ),
                      child: sel
                          ? const Icon(Icons.check,
                              color: Colors.white, size: 18)
                          : null,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // ── Actions ─────────────────────────────────────────────────
          Row(children: [
            Expanded(
                child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.shared_widgets_cancel),
            )),
            const SizedBox(width: 12),
            Expanded(
                child: FilledButton(
              onPressed: () {
                AppHaptics.tap(context, HapticStrength.light);
                _submit();
              },
              child: Text(isEdit ? l10n.accounts_saveChanges : 'Add New Card'),
            )),
          ]),
        ],
      )),
    );
  }
}

// ── Real World Card UI ────────────────────────────────────────────────────────

class _RealWorldCard extends StatelessWidget {
  final Account acc;
  const _RealWorldCard({required this.acc});

  @override
  Widget build(BuildContext context) {

    final color = Color(acc.colorValue);

    return GestureDetector(
      onTap: () =>
          AccountsScreen.openSheet(context, existing: acc, isCard: true),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 200,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.9),
              color.withValues(alpha: 0.6),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Decorative elements
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            Positioned(
              left: -30,
              bottom: -40,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),
            Positioned(
              top: 11,
              right: 12,
              child: IconButton(
                icon: const Icon(Icons.delete_outline,
                    color: Colors.white70, size: 28),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () async {
                  if (await showDeleteConfirm(context, acc.name) &&
                      context.mounted) {
                    final undo = await context
                        .read<AppProvider>()
                        .deleteAccountWithUndo(acc.id);
                    if (context.mounted) {
                      showAppSnackbar(context, 'Card deleted', onUndo: undo);
                    }
                  }
                },
              ),
            ),
            // Card Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(acc.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('**** **** **** ',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              letterSpacing: 2)),
                      Text(
                          acc.cardNumberLast4?.isNotEmpty == true
                              ? acc.cardNumberLast4!
                              : '0000',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('CARD HOLDER',
                              style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 9,
                                  letterSpacing: 1)),
                          const SizedBox(height: 2),
                          Text(
                              (acc.cardHolderName?.isNotEmpty == true
                                      ? acc.cardHolderName!
                                      : 'YOUR NAME')
                                  .toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1)),
                        ],
                      ),
                      if (acc.cardExpiry?.isNotEmpty == true)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('EXP',
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 9,
                                    letterSpacing: 1)),
                            const SizedBox(height: 2),
                            Text(acc.cardExpiry!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1)),
                          ],
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (acc.type == 'credit' &&
                              (acc.creditLimit ?? 0) > 0) ...[
                            Text(
                                'LIMIT: ${formatAmount(acc.creditLimit!, acc.currency)}',
                                style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 9,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                          ],
                          const Text('BALANCE',
                              style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 9,
                                  letterSpacing: 1)),
                          const SizedBox(height: 2),
                          Text(formatAmount(acc.balance, acc.currency),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Delete button removed from here and moved into the Row above
          ],
        ),
      ),
    );
  }
}

class _GoldPreviewCard extends StatelessWidget {
  final double? preview;
  final String currency;
  final int karat;
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
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    const goldColor = Color(0xFFB8860B);

    // Price per gram of this karat in the chosen currency
    final pricePerGram24k = app.goldPricePerGram(currency);
    final pricePerGramKarat =
        pricePerGram24k != null ? pricePerGram24k * karat / 24 : null;

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
          const Icon(Icons.diamond_outlined, size: 14, color: goldColor),
          const SizedBox(width: 6),
          Text(l10n.accounts_liveGoldValue,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: goldColor,
                  letterSpacing: 0.5)),
        ]),
        const SizedBox(height: 8),

        // Big value display
        if (preview != null)
          Text(formatAmount(preview!, currency),
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w800, color: goldColor))
        else
          Text(l10n.accounts_enterWeightAboveToSe,
              style: TextStyle(
                  fontSize: 13, color: cs.onSurface.withValues(alpha: 0.4))),

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
              label: 'Weight Ã— purity',
              value:
                  '${grams!.toStringAsFixed(2)} g Ã— ${(karat / 24 * 140).toStringAsFixed(1)}%',
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
  final Color color;
  const _InfoRow(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.5))),
          Text(value,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w600, color: color)),
        ]),
      );
}

class _GoldRatesUnavailableBanner extends StatelessWidget {
  final bool fetching;
  const _GoldRatesUnavailableBanner({super.key, required this.fetching});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
            width: 14,
            height: 14,
            child: CircularProgressIndicator(
                strokeWidth: 2, color: cs.onSurface.withValues(alpha: 0.4)),
          )
        else
          Icon(Icons.wifi_off_rounded,
              size: 16, color: cs.onSurface.withValues(alpha: 0.4)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            fetching
                ? l10n.accounts_fetchingGoldPrice
                : l10n.accounts_goldPriceUnavailable,
            style: TextStyle(
                fontSize: 12, color: cs.onSurface.withValues(alpha: 0.5)),
          ),
        ),
      ]),
    );
  }
}

class _CreditReminderSection extends StatelessWidget {
  final bool enabled;
  final bool earlyEnabled;
  final TimeOfDay time;
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<bool> onEarlyEnabledChanged;
  final VoidCallback onPickTime;

  const _CreditReminderSection({
    required this.enabled,
    required this.earlyEnabled,
    required this.time,
    required this.onEnabledChanged,
    required this.onEarlyEnabledChanged,
    required this.onPickTime,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: enabled ? cs.primaryContainer.withValues(alpha: 0.2) : null,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: enabled ? cs.primary.withValues(alpha: 0.3) : Colors.transparent,
        ),
      ),
      child: Column(
        children: [
          SwitchListTile.adaptive(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            secondary: Icon(
              enabled ? Icons.notifications_active_rounded : Icons.notifications_none_rounded,
              color: enabled ? cs.primary : null,
            ),
            title: Text('Payment Reminder',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: enabled ? cs.primary : null)),
            subtitle: Text(
              enabled
                  ? 'You\'ll be notified on the due date'
                  : 'Get notified when payment is due',
              style: TextStyle(
                  fontSize: 12,
                  color: cs.onSurface.withValues(alpha: 0.5)),
            ),
            value: enabled,
            onChanged: onEnabledChanged,
          ),
          if (enabled) ...[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: InkWell(
                onTap: onPickTime,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: cs.primary.withValues(alpha: 0.35)),
                  ),
                  child: Row(children: [
                    Icon(Icons.access_time_rounded, size: 20, color: cs.primary),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text('Remind me at',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: cs.onSurface.withValues(alpha: 0.55))),
                          Text(time.format(context),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: cs.primary)),
                        ])),
                    Icon(Icons.chevron_right_rounded, color: cs.primary),
                  ]),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SwitchListTile.adaptive(
              contentPadding: const EdgeInsets.only(left: 12, right: 12),
              secondary: Icon(
                earlyEnabled
                    ? Icons.notifications_active_outlined
                    : Icons.notifications_outlined,
                color: earlyEnabled ? cs.secondary : null,
                size: 22,
              ),
              title: Text('Remind 2 days before',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: earlyEnabled ? cs.secondary : null)),
              subtitle: Text('Get an advance heads-up 2 days before due date',
                  style: TextStyle(
                      fontSize: 11,
                      color: cs.onSurface.withValues(alpha: 0.45))),
              value: earlyEnabled,
              onChanged: onEarlyEnabledChanged,
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

// â”€â”€ Gold value live preview card â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€



