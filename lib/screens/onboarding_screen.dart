// lib/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/app_numeric_keypad.dart';
import '../utils/haptics.dart';
import 'main_shell.dart';

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

IconData _typeIcon(String type) {
  switch (type) {
    case 'cash':
      return Icons.payments_outlined;
    case 'savings':
      return Icons.savings_outlined;
    case 'credit':
    case 'debit':
      return Icons.credit_card_outlined;
    case 'wallet':
      return Icons.account_balance_wallet_outlined;
    default:
      return Icons.account_balance_outlined;
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageCtrl = PageController();
  int _page = 0;

  static const int _totalPages =
      6; // 0: language, 1: welcome/restore, 2-5: existing setup steps

  bool _restoring = false;
  String? _restoreError;

  // Step 1 — Name
  final _nameCtrl = TextEditingController();

  // Step 2 — Currency
  String _currency = 'EGP';

  // Step 3 — First account
  final _accNameCtrl = TextEditingController(text: 'Main Account');
  final _accBalCtrl = TextEditingController(text: '0');
  String _accType = 'bank';
  String _accCur = 'EGP';
  int _accColor = 0xFF6750A4;
  bool _accExcludeFromTotal = false;
  bool _accDontLinkToCard = false;

  // Step 4 — First Card
  final _cardNameCtrl = TextEditingController(text: 'Credit Card');
  final _cardBalCtrl = TextEditingController(text: '0');
  final _cardLimitCtrl = TextEditingController(text: '0');
  String _cardCur = 'EGP';
  String _cardType = 'credit';
  int _cardColor = 0xFF1565C0;

  @override
  void dispose() {
    _pageCtrl.dispose();
    _nameCtrl.dispose();
    _accNameCtrl.dispose();
    _accBalCtrl.dispose();
    _cardNameCtrl.dispose();
    _cardBalCtrl.dispose();
    _cardLimitCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_page == 2 && _nameCtrl.text.trim().isEmpty) return;
    if (_page < _totalPages - 1) {
      _pageCtrl.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      _finish();
    }
  }

  void _skip() {
    if (_page == 4) {
      _accNameCtrl.clear();
      _accBalCtrl.clear();
    } else if (_page == 5) {
      _cardNameCtrl.clear();
      _cardBalCtrl.clear();
      _cardLimitCtrl.clear();
    }
    _next();
  }

  /// Lets the user pick a backup JSON file right at the start, restoring it
  /// before they ever fill in a name/currency/account — avoids the old flow
  /// where restoring meant first clicking through the entire setup wizard
  /// with throwaway data just to overwrite it seconds later from Settings.
  Future<void> _restoreFromWelcome() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _restoring = true;
      _restoreError = null;
    });
    try {
      final app = context.read<AppProvider>();
      final originalVersion = await app.restoreBackup();
      if (originalVersion == 0) {
        // User cancelled the file picker — stay on this page, no error.
        if (mounted) setState(() => _restoring = false);
        return;
      }
      // A restored backup should always take the user straight into the
      // app rather than back through setup — force onboarded=true in case
      // an old/hand-edited backup file didn't carry that flag correctly.
      if (!app.settings.onboarded) {
        await app.completeOnboarding(
            name: app.settings.userName, currency: app.settings.currency);
      }
      if (mounted) {
        Navigator.pushReplacement(
            context, ExpensyRoute(builder: (_) => const MainShell()));
      }
    } on FormatException catch (e) {
      if (mounted) {
        setState(() {
          _restoring = false;
          _restoreError = e.message;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _restoring = false;
          _restoreError = l10n.onboarding_restoreFailed;
        });
      }
    }
  }

  Future<void> _restoreExternal(String source) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _restoring = true;
      _restoreError = null;
    });
    try {
      final app = context.read<AppProvider>();
      final success = await app.restoreExternalBackup(source);

      if (!success) {
        if (mounted) setState(() => _restoring = false);
        return;
      }

      // If we got here, it's successful and data is loaded.
      if (!app.settings.onboarded) {
        await app.completeOnboarding(
            name: app.settings.userName, currency: app.settings.currency);
      }
      if (mounted) {
        Navigator.pushReplacement(
            context, ExpensyRoute(builder: (_) => const MainShell()));
      }
    } on FormatException catch (e) {
      if (mounted) {
        setState(() {
          _restoring = false;
          _restoreError = e.message;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _restoring = false;
          _restoreError = l10n.onboarding_restoreFailed;
        });
      }
    }
  }

  Future<void> _finish() async {
    final app = context.read<AppProvider>();
    await app.completeOnboarding(
        name: _nameCtrl.text.trim(), currency: _currency);

    final accName = _accNameCtrl.text.trim();
    String? bankAccId;
    if (accName.isNotEmpty) {
      bankAccId = app.newId();
      await app.addAccount(Account(
        id: bankAccId,
        name: accName,
        type: _accType,
        currency: _accCur,
        balance: (_accType != 'bank' || _accDontLinkToCard)
            ? (double.tryParse(_accBalCtrl.text) ?? 0)
            : 0,
        colorValue: _accColor,
        excludeFromTotal: (_accType != 'bank' || _accDontLinkToCard)
            ? _accExcludeFromTotal
            : false,
        dontLinkToCard: _accType == 'bank' ? _accDontLinkToCard : false,
      ));
    }

    final cardName = _cardNameCtrl.text.trim();
    if (cardName.isNotEmpty) {
      await app.addAccount(Account(
        id: app.newId(),
        name: cardName,
        type: _cardType,
        currency: _cardCur,
        balance: double.tryParse(_cardBalCtrl.text) ?? 0,
        creditLimit: double.tryParse(_cardLimitCtrl.text) ?? 0,
        colorValue: _cardColor,
        linkedAccountId:
            (_accType == 'bank' && !_accDontLinkToCard) ? bankAccId : null,
      ));
    }

    if (mounted) {
      Navigator.pushReplacement(
          context, ExpensyRoute(builder: (_) => const MainShell()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          // Progress
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(
                children: List.generate(
                    _totalPages,
                    (i) => Expanded(
                          child: Container(
                            height: 4,
                            margin: EdgeInsets.only(
                                right: i < _totalPages - 1 ? 6 : 0),
                            decoration: BoxDecoration(
                              color: i <= _page
                                  ? cs.primary
                                  : cs.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ))),
          ),

          Expanded(
            child: PageView(
              controller: _pageCtrl,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (i) => setState(() => _page = i),
              children: [
                _PageLanguage(onNext: _next),
                _PageWelcome(
                  restoring: _restoring,
                  error: _restoreError,
                  onRestore: _restoreFromWelcome,
                  onRestoreExternal: _restoreExternal,
                  onStartFresh: _next,
                ),
                _PageOne(nameCtrl: _nameCtrl),
                _PageTwo(
                    currency: _currency,
                    onChanged: (v) => setState(() {
                          _currency = v;
                          _accCur = v;
                        })),
                _PageThree(
                  nameCtrl: _accNameCtrl,
                  balCtrl: _accBalCtrl,
                  type: _accType,
                  currency: _accCur,
                  color: _accColor,
                  dontLinkToCard: _accDontLinkToCard,
                  excludeFromTotal: _accExcludeFromTotal,
                  onType: (v) => setState(() => _accType = v),
                  onCurrency: (v) => setState(() => _accCur = v),
                  onColor: (v) => setState(() => _accColor = v),
                  onDontLinkToCard: (v) =>
                      setState(() => _accDontLinkToCard = v),
                  onExcludeFromTotal: (v) =>
                      setState(() => _accExcludeFromTotal = v),
                ),
                _PageFour(
                  nameCtrl: _cardNameCtrl,
                  balCtrl: _cardBalCtrl,
                  limitCtrl: _cardLimitCtrl,
                  currency: _cardCur,
                  color: _cardColor,
                  type: _cardType,
                  onType: (t) => setState(() => _cardType = t),
                  onCurrency: (c) => setState(() => _cardCur = c),
                  onColor: (c) => setState(() => _cardColor = c),
                ),
              ],
            ),
          ),

          // Navigation buttons — hidden on the welcome page, which has its
          // own inline actions (Restore Backup / Start Fresh).
          if (_page != 1)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                children: [
                  Row(children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: _page == 0
                            ? null
                            : () => _pageCtrl.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut),
                        style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28))),
                        child: Text(l10n.onboarding_back),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: FilledButton(
                        onPressed: _next,
                        style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28))),
                        child: Text(_page < _totalPages - 1
                            ? l10n.onboarding_continue
                            : l10n.onboarding_getStarted),
                      ),
                    ),
                  ]),
                  if (_page == 4 || _page == 5)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: TextButton(
                        onPressed: _skip,
                        child: Text(l10n.onboarding_skipForNow),
                      ),
                    ),
                ],
              ),
            ),
        ]),
      ),
    );
  }
}

// ── Page 0: Welcome / Restore backup ──────────────────────────────────────────
class _PageWelcome extends StatelessWidget {
  final bool restoring;
  final String? error;
  final VoidCallback onRestore;
  final void Function(String) onRestoreExternal;
  final VoidCallback onStartFresh;
  const _PageWelcome({
    required this.restoring,
    required this.error,
    required this.onRestore,
    required this.onRestoreExternal,
    required this.onStartFresh,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 24),
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.account_balance_wallet_outlined,
              color: cs.primary, size: 32),
        ),
        const SizedBox(height: 20),
        Text(l10n.onboarding_welcomeToExpensy,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text(
          l10n.onboarding_yourPersonalTracker,
          style: TextStyle(
              fontSize: 15, color: cs.onSurface.withValues(alpha: 0.6)),
        ),
        const SizedBox(height: 32),

        // Restore card
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                        color: cs.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(Icons.restore_outlined, color: cs.primary)),
                const SizedBox(width: 14),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.onboarding_restoreABackup,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 15)),
                    Text(l10n.onboarding_loadAPreviouslySaved,
                        style: TextStyle(
                            fontSize: 12,
                            color: cs.onSurface.withValues(alpha: 0.6))),
                  ],
                )),
              ]),
              const SizedBox(height: 14),
              FilledButton.icon(
                onPressed: restoring ? null : onRestore,
                icon: restoring
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.upload_file_outlined),
                label: Text(restoring
                    ? l10n.onboarding_restoring
                    : l10n.onboarding_chooseBackupFile),
                style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24))),
              ),
              if (error != null) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: cs.errorContainer,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.error_outline, color: cs.error, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Text(error!,
                                style: TextStyle(
                                    fontSize: 12, color: cs.onErrorContainer))),
                      ]),
                ),
              ],
            ]),
          ),
        ),

        const SizedBox(height: 12),
        // External backup button
        OutlinedButton.icon(
          onPressed: restoring ? null : () => onRestoreExternal('greenstash'),
          icon: const Icon(Icons.savings),
          label: Text(l10n.onboarding_restoreGreenStash),
          style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24))),
        ),

        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: Divider(color: cs.outlineVariant)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(l10n.onboarding_or,
                style: TextStyle(
                    fontSize: 12, color: cs.onSurface.withValues(alpha: 0.5))),
          ),
          Expanded(child: Divider(color: cs.outlineVariant)),
        ]),
        const SizedBox(height: 16),

        OutlinedButton.icon(
          onPressed: restoring ? null : onStartFresh,
          icon: const Icon(Icons.add_circle_outline),
          label: Text(l10n.onboarding_startFresh),
          style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24))),
        ),
      ]),
    );
  }
}

// ── Page 1: Name ─────────────────────────────────────────────────────────────
class _PageOne extends StatelessWidget {
  final TextEditingController nameCtrl;
  const _PageOne({required this.nameCtrl});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 24),
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.waving_hand_outlined, color: cs.primary, size: 32),
        ),
        const SizedBox(height: 20),
        Text(l10n.onboarding_letsGetYouSetUp,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text(l10n.onboarding_firstWhatShouldWeCal,
            style: TextStyle(
                fontSize: 15, color: cs.onSurface.withValues(alpha: 0.6))),
        const SizedBox(height: 32),
        TextField(
          controller: nameCtrl,
          autofocus: true,
          decoration: InputDecoration(
              labelText: l10n.onboarding_yourName,
              prefixIcon: const Icon(Icons.person_outline)),
          textCapitalization: TextCapitalization.words,
        ),
      ]),
    );
  }
}

// ── Page 2: Currency ─────────────────────────────────────────────────────────
class _PageTwo extends StatelessWidget {
  final String currency;
  final void Function(String) onChanged;
  const _PageTwo({required this.currency, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 24),
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
              color: cs.secondaryContainer,
              borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.monetization_on_outlined,
              color: cs.secondary, size: 32),
        ),
        const SizedBox(height: 20),
        Text(l10n.onboarding_defaultCurrency,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text(l10n.onboarding_thisWillBeUsedAcross,
            style: TextStyle(
                fontSize: 15, color: cs.onSurface.withValues(alpha: 0.6))),
        const SizedBox(height: 24),
        // Selected currency display
        GestureDetector(
          onTap: () async {
            final picked = await showCurrencyPicker(context, current: currency);
            if (picked != null) onChanged(picked);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: cs.primary.withValues(alpha: 0.5)),
            ),
            child: Row(children: [
              Text(currencyInfo(currency).symbol,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: cs.primary)),
              const SizedBox(width: 14),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(currency,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: cs.onPrimaryContainer)),
                  Text(currencyInfo(currency).name,
                      style: TextStyle(
                          fontSize: 13,
                          color: cs.onPrimaryContainer.withValues(alpha: 0.7))),
                ],
              )),
              Icon(Icons.swap_vert_rounded, color: cs.primary),
            ]),
          ),
        ),
        const SizedBox(height: 14),
        TextButton.icon(
          onPressed: () async {
            final picked = await showCurrencyPicker(context, current: currency);
            if (picked != null) onChanged(picked);
          },
          icon: const Icon(Icons.search),
          label: Text(l10n.onboarding_searchAllCurrencies),
        ),
      ]),
    );
  }
}

// ── Page 3: First Account ────────────────────────────────────────────────────
class _PageThree extends StatefulWidget {
  final TextEditingController nameCtrl, balCtrl;
  final String type, currency;
  final int color;
  final bool dontLinkToCard;
  final bool excludeFromTotal;
  final void Function(String) onType, onCurrency;
  final void Function(int) onColor;
  final void Function(bool) onDontLinkToCard;
  final void Function(bool) onExcludeFromTotal;

  const _PageThree({
    required this.nameCtrl,
    required this.balCtrl,
    required this.type,
    required this.currency,
    required this.color,
    required this.dontLinkToCard,
    required this.excludeFromTotal,
    required this.onType,
    required this.onCurrency,
    required this.onColor,
    required this.onDontLinkToCard,
    required this.onExcludeFromTotal,
  });

  @override
  State<_PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<_PageThree> {
  bool _showKeypad = false;

  @override
  void didUpdateWidget(_PageThree oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((widget.type == 'bank' && !widget.dontLinkToCard) && _showKeypad) {
      setState(() => _showKeypad = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final sym = currencyInfo(widget.currency).symbol;
    final kbOpen = MediaQuery.of(context).viewInsets.bottom > 100;
    final showPad = _showKeypad && !kbOpen;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 24, right: 24, top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 24),
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
              color: cs.tertiaryContainer,
              borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.account_balance_wallet_outlined,
              color: cs.tertiary, size: 32),
        ),
        const SizedBox(height: 20),
        Text(l10n.onboarding_yourFirstAccount,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text(l10n.onboarding_setUpYourMainAccount,
            style: TextStyle(
                fontSize: 15, color: cs.onSurface.withValues(alpha: 0.6))),
        const SizedBox(height: 24),

        TextField(
          controller: widget.nameCtrl,
          onTap: () {
            if (_showKeypad) setState(() => _showKeypad = false);
          },
          decoration: InputDecoration(
              labelText: l10n.onboarding_accountName,
              prefixIcon: const Icon(Icons.label_outline)),
        ),
        const SizedBox(height: 14),

        // Type cards
        Text(l10n.onboarding_accountType,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(letterSpacing: 1)),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            for (final opt in [
              ('bank', l10n.onboarding_bank, 'account_balance'),
              ('cash', l10n.onboarding_cash, 'payments'),
              ('savings', l10n.onboarding_savings, 'savings'),
              ('credit', 'Credit Card', 'credit_card'),
              ('debit', 'Debit Card', 'credit_card'),
              ('wallet', l10n.onboarding_wallet, 'account_balance_wallet'),
            ])
              GestureDetector(
                onTap: () => widget.onType(opt.$1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  margin: const EdgeInsets.only(right: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color:
                        widget.type == opt.$1 ? cs.primary : cs.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(_typeIcon(opt.$1),
                        size: 14,
                        color: widget.type == opt.$1 ? Colors.white : cs.onSurface),
                    const SizedBox(width: 6),
                    Text(opt.$2,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color:
                                widget.type == opt.$1 ? Colors.white : cs.onSurface)),
                  ]),
                ),
              ),
          ]),
        ),
        const SizedBox(height: 14),

        // Currency
        Text(l10n.onboarding_currency,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(letterSpacing: 1)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final picked = await showCurrencyPicker(context, current: widget.currency);
            if (picked != null) widget.onCurrency(picked);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.primary.withValues(alpha: 0.4)),
            ),
            child: Row(children: [
              Icon(Icons.monetization_on_outlined, size: 18, color: cs.primary),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(
                      '${widget.currency}  ${currencyInfo(widget.currency).symbol}  —  ${currencyInfo(widget.currency).name}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13))),
              const Icon(Icons.arrow_drop_down_rounded),
            ]),
          ),
        ),
        const SizedBox(height: 14),

        if (widget.type == 'bank') ...[
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: Text(
              l10n.accounts_dontLinkToCard,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            subtitle: Text(
              l10n.accounts_dontLinkToCardDesc,
              style: TextStyle(
                  fontSize: 12,
                  color: cs.onSurface.withValues(alpha: 0.5)),
            ),
            value: widget.dontLinkToCard,
            onChanged: (v) {
              AppHaptics.tap(context, HapticStrength.light);
              widget.onDontLinkToCard(v);
            },
          ),
          const SizedBox(height: 14),
        ],

        if (widget.type != 'bank' || widget.dontLinkToCard) ...[
          TextField(
            controller: widget.balCtrl,
            readOnly: true,
            showCursor: true,
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() => _showKeypad = true);
            },
            decoration: InputDecoration(
              labelText: l10n.onboarding_startingBalance,
              prefixText: '$sym ',
              suffixIcon: IconButton(
                icon: Icon(
                  showPad ? Icons.keyboard_hide_outlined : Icons.dialpad_outlined,
                  size: 20,
                  color: cs.primary,
                ),
                onPressed: () {
                  AppHaptics.tap(context, HapticStrength.light);
                  FocusScope.of(context).unfocus();
                  setState(() => _showKeypad = !_showKeypad);
                },
              ),
            ),
          ),
          const SizedBox(height: 14),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.accounts_excludeFromTotalBala,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 14)),
            subtitle: Text(l10n.accounts_wontCountTowardYourHome,
                style: TextStyle(
                    fontSize: 12,
                    color: cs.onSurface.withValues(alpha: 0.5)),
            ),
            value: widget.excludeFromTotal,
            onChanged: (v) {
              AppHaptics.tap(context, HapticStrength.light);
              widget.onExcludeFromTotal(v);
            },
          ),
          const SizedBox(height: 14),
        ],

        // Color
        Text(l10n.onboarding_color,
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
                children: _kColors
                    .map((col) => GestureDetector(
                          onTap: () => widget.onColor(col),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 60),
                            width: 34,
                            height: 34,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Color(col),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: widget.color == col
                                      ? cs.onSurface
                                      : Colors.transparent,
                                  width: 3),
                              boxShadow: widget.color == col
                                  ? [
                                      BoxShadow(
                                          color:
                                              Color(col).withValues(alpha: 0.5),
                                          blurRadius: 6,
                                          spreadRadius: 1)
                                    ]
                                  : null,
                            ),
                          ),
                        ))
                    .toList()),
          ),
        ),
        if (showPad && (widget.type != 'bank' || widget.dontLinkToCard)) ...[
          const SizedBox(height: 12),
          AppNumericKeypad(
            controller: widget.balCtrl,
            compact: true,
            onDone: () => setState(() => _showKeypad = false),
          ),
        ],
        const SizedBox(height: 20),
      ]),
    );
  }
}

// ── Page 4: Credit Card (Optional) ───────────────────────────────────────────
class _PageFour extends StatefulWidget {
  final TextEditingController nameCtrl, balCtrl, limitCtrl;
  final String currency;
  final int color;
  final String type;
  final void Function(String) onCurrency;
  final void Function(int) onColor;
  final void Function(String) onType;

  const _PageFour({
    required this.nameCtrl,
    required this.balCtrl,
    required this.limitCtrl,
    required this.currency,
    required this.color,
    required this.type,
    required this.onCurrency,
    required this.onColor,
    required this.onType,
  });

  @override
  State<_PageFour> createState() => _PageFourState();
}

class _PageFourState extends State<_PageFour> {
  TextEditingController? _activeNumericCtrl;
  bool _showKeypad = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final sym = currencyInfo(widget.currency).symbol;
    final kbOpen = MediaQuery.of(context).viewInsets.bottom > 100;
    final showPad = _showKeypad && !kbOpen;

    return Padding(
      padding: EdgeInsets.only(
        left: 24, right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: ListView(children: [
        const SizedBox(height: 24),
        Text(l10n.onboarding_addCard,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text(l10n.onboarding_skipCardDesc,
            style: TextStyle(
                fontSize: 15, color: cs.onSurface.withValues(alpha: 0.6))),
        const SizedBox(height: 24),

        // Type
        Text(l10n.onboarding_accountType,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(letterSpacing: 1)),
        const SizedBox(height: 8),
        SizedBox(
          height: 38,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              for (final opt in [
                ('credit', l10n.accounts_creditCard, 'credit_card'),
                ('debit', l10n.onboarding_debitCard, 'credit_card'),
              ])
                GestureDetector(
                  onTap: () => widget.onType(opt.$1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    margin: const EdgeInsets.only(right: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color:
                          widget.type == opt.$1 ? cs.primary : cs.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(_typeIcon(opt.$1),
                          size: 14,
                          color: widget.type == opt.$1 ? Colors.white : cs.onSurface),
                      const SizedBox(width: 6),
                      Text(opt.$2,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color:
                                  widget.type == opt.$1 ? Colors.white : cs.onSurface)),
                    ]),
                  ),
                ),
            ]),
          ),
        ),
        const SizedBox(height: 14),

        TextField(
          controller: widget.nameCtrl,
          onTap: () {
            if (_showKeypad) setState(() => _showKeypad = false);
          },
          decoration: InputDecoration(
              labelText: l10n.onboarding_cardNameLabel,
              prefixIcon: const Icon(Icons.credit_card)),
        ),
        const SizedBox(height: 14),

        // Currency
        Text(l10n.onboarding_currency,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(letterSpacing: 1)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final picked = await showCurrencyPicker(context, current: widget.currency);
            if (picked != null) widget.onCurrency(picked);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.primary.withValues(alpha: 0.4)),
            ),
            child: Row(children: [
              Icon(Icons.monetization_on_outlined, size: 18, color: cs.primary),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(
                      '${widget.currency}  ${currencyInfo(widget.currency).symbol}  —  ${currencyInfo(widget.currency).name}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13))),
              const Icon(Icons.arrow_drop_down_rounded),
            ]),
          ),
        ),
        const SizedBox(height: 14),

        Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.limitCtrl,
                readOnly: true,
                showCursor: true,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    _activeNumericCtrl = widget.limitCtrl;
                    _showKeypad = true;
                  });
                },
                decoration: InputDecoration(
                  labelText: l10n.onboarding_creditLimit,
                  prefixText: '$sym ',
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPad && _activeNumericCtrl == widget.limitCtrl
                          ? Icons.keyboard_hide_outlined
                          : Icons.dialpad_outlined,
                      size: 20,
                      color: cs.primary,
                    ),
                    onPressed: () {
                      AppHaptics.tap(context, HapticStrength.light);
                      FocusScope.of(context).unfocus();
                      setState(() {
                        if (_showKeypad && _activeNumericCtrl == widget.limitCtrl) {
                          _showKeypad = false;
                        } else {
                          _activeNumericCtrl = widget.limitCtrl;
                          _showKeypad = true;
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: widget.balCtrl,
                readOnly: true,
                showCursor: true,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    _activeNumericCtrl = widget.balCtrl;
                    _showKeypad = true;
                  });
                },
                decoration: InputDecoration(
                  labelText: l10n.onboarding_amountUsed,
                  prefixText: '$sym ',
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPad && _activeNumericCtrl == widget.balCtrl
                          ? Icons.keyboard_hide_outlined
                          : Icons.dialpad_outlined,
                      size: 20,
                      color: cs.primary,
                    ),
                    onPressed: () {
                      AppHaptics.tap(context, HapticStrength.light);
                      FocusScope.of(context).unfocus();
                      setState(() {
                        if (_showKeypad && _activeNumericCtrl == widget.balCtrl) {
                          _showKeypad = false;
                        } else {
                          _activeNumericCtrl = widget.balCtrl;
                          _showKeypad = true;
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Color
        Text(l10n.onboarding_color,
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
                children: _kColors
                    .map((col) => GestureDetector(
                          onTap: () => widget.onColor(col),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 60),
                            width: 34,
                            height: 34,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Color(col),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: widget.color == col
                                      ? cs.onSurface
                                      : Colors.transparent,
                                  width: 3),
                              boxShadow: widget.color == col
                                  ? [
                                      BoxShadow(
                                          color:
                                              Color(col).withValues(alpha: 0.5),
                                          blurRadius: 6,
                                          spreadRadius: 1)
                                    ]
                                  : null,
                            ),
                          ),
                        ))
                    .toList()),
          ),
        ),
        if (showPad && _activeNumericCtrl != null) ...[
          const SizedBox(height: 12),
          AppNumericKeypad(
            controller: _activeNumericCtrl!,
            compact: true,
            onDone: () => setState(() => _showKeypad = false),
          ),
        ],
        const SizedBox(height: 20),
      ]),
    );
  }
}

// ── Page 0: Language ─────────────────────────────────────────────────────────
class _PageLanguage extends StatelessWidget {
  final VoidCallback onNext;
  const _PageLanguage({required this.onNext});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final s = context.watch<AppProvider>().settings;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 24),
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.language_outlined, color: cs.primary, size: 32),
        ),
        const SizedBox(height: 20),
        Text(l10n.onboarding_chooseLanguage,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 24),
        Expanded(
          child: ListView(
            children: [
              _langTile('system', l10n.settings_systemDefault, s.languageCode,
                  context),
              _langTile('en', 'English', s.languageCode, context),
              _langTile('ar', 'العربية', s.languageCode, context),
              _langTile('fr', 'Français', s.languageCode, context),
              _langTile('de', 'Deutsch', s.languageCode, context),
              _langTile('es', 'Español', s.languageCode, context),
              _langTile('hi', 'हिन्दी', s.languageCode, context),
              _langTile('pt', 'Português', s.languageCode, context),
              _langTile('zh', '中文', s.languageCode, context),
              _langTile('ja', '日本語', s.languageCode, context),
              _langTile('ru', 'Русский', s.languageCode, context),
              _langTile('it', 'Italiano', s.languageCode, context),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _langTile(
      String code, String name, String current, BuildContext context) {
    final sel = code == current;
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: sel ? 2 : 0,
      color: sel ? cs.primaryContainer : cs.surfaceContainerLow,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: sel ? BorderSide(color: cs.primary, width: 2) : BorderSide.none,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(name,
            style:
                TextStyle(fontWeight: sel ? FontWeight.w700 : FontWeight.w500)),
        trailing:
            sel ? Icon(Icons.check_circle_rounded, color: cs.primary) : null,
        onTap: () {
          context.read<AppProvider>().updateSetting('languageCode', code);
          Future.delayed(const Duration(milliseconds: 300), onNext);
        },
      ),
    );
  }
}
