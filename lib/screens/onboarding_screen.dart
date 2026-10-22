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
import '../services/notification_service.dart';
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

Widget _fintechHeroIcon(BuildContext context, IconData icon, {Color? color}) {
  final cs = Theme.of(context).colorScheme;
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final accent = color ?? cs.primary;
  return Container(
    width: 68,
    height: 68,
    decoration: BoxDecoration(
      color: accent.withValues(alpha: isDark ? 0.2 : 0.12),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(
        color: accent.withValues(alpha: isDark ? 0.35 : 0.22),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: isDark ? 0.2 : 0.1),
          blurRadius: 18,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Center(
      child: Icon(icon, color: accent, size: 32),
    ),
  );
}

class _FintechPrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;
  final bool loading;

  const _FintechPrimaryButton({
    required this.onPressed,
    required this.label,
    this.icon,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = cs.primary;
    final fg = cs.onPrimary;

    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed == null
            ? null
            : () {
                AppHaptics.tap(context, HapticStrength.light);
                onPressed!();
              },
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                bg,
                Color.lerp(bg, Colors.black, isDark ? 0.25 : 0.15)!,
              ],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: isDark ? 0.25 : 0.35),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: bg.withValues(alpha: isDark ? 0.4 : 0.3),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: loading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: fg,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      icon!,
                      const SizedBox(width: 8),
                    ],
                    Text(
                      label,
                      style: TextStyle(
                        color: fg,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _FintechSecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;

  const _FintechSecondaryButton({
    required this.onPressed,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed == null
            ? null
            : () {
                AppHaptics.tap(context, HapticStrength.light);
                onPressed!();
              },
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: cs.surfaceContainerHigh.withValues(alpha: isDark ? 0.4 : 0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  // 7 Pages total:
  // 0: Language
  // 1: Welcome & Restore
  // 2: Name
  // 3: Currency
  // 4: First Account
  // 5: Debit Card (if Bank selected)
  // 6: Notifications Access Request
  static const int _totalPages = 7;

  bool _restoring = false;
  String? _restoreError;

  // Step 2 — Name
  final _nameCtrl = TextEditingController();
  String? _nameError;

  // Step 3 — Currency
  String _currency = 'USD';

  // Step 4 — First account
  final _accNameCtrl = TextEditingController(text: 'Main Bank');
  final _accBalCtrl = TextEditingController(text: '0');
  String _accType = 'bank';
  String _accCur = 'USD';
  int _accColor = 0xFF1565C0;
  bool _accExcludeFromTotal = false;

  // Step 5 — Debit Card
  final _cardNameCtrl = TextEditingController(text: 'Debit Card');
  final _cardHolderCtrl = TextEditingController();
  final _cardDigitsCtrl = TextEditingController(text: '1234');
  int _cardColor = 0xFF1565C0;

  @override
  void initState() {
    super.initState();
    _nameCtrl.addListener(() {
      if (_nameError != null && _nameCtrl.text.trim().isNotEmpty) {
        setState(() => _nameError = null);
      }
      if (_cardHolderCtrl.text.isEmpty || _cardHolderCtrl.text == 'EXPENSY MEMBER') {
        _cardHolderCtrl.text = _nameCtrl.text.trim().toUpperCase();
      }
    });
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    _nameCtrl.dispose();
    _accNameCtrl.dispose();
    _accBalCtrl.dispose();
    _cardNameCtrl.dispose();
    _cardHolderCtrl.dispose();
    _cardDigitsCtrl.dispose();
    super.dispose();
  }

  void _goTo(int page) {
    AppHaptics.tap(context, HapticStrength.light);
    _pageCtrl.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _next() {
    AppHaptics.tap(context, HapticStrength.light);
    if (_page == 2) {
      if (_nameCtrl.text.trim().isEmpty) {
        setState(() => _nameError = 'Name is required');
        return;
      }
    }

    if (_page == 4) {
      // Branching: If bank, advance to Debit Card (page 5). Else, jump to Notifications (page 6).
      if (_accType == 'bank') {
        _goTo(5);
      } else {
        _goTo(6);
      }
      return;
    }

    if (_page == 5) {
      _goTo(6);
      return;
    }

    if (_page < _totalPages - 1) {
      _pageCtrl.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  void _skip() {
    AppHaptics.tap(context, HapticStrength.light);
    if (_page == 4) {
      _accNameCtrl.clear();
      _accBalCtrl.clear();
      _goTo(6); // Skip account setup entirely, go to notifications
    } else if (_page == 5) {
      _cardNameCtrl.clear();
      _goTo(6); // Skip debit card setup, go to notifications
    }
  }

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
        if (mounted) setState(() => _restoring = false);
        return;
      }
      if (!app.settings.onboarded) {
        await app.completeOnboarding(
          name: app.settings.userName,
          currency: app.settings.currency,
        );
      }
      if (mounted) {
        setState(() => _restoring = false);
        // Direct to notification request page instead of immediately pushing MainShell
        _goTo(6);
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

      if (!app.settings.onboarded) {
        await app.completeOnboarding(
          name: app.settings.userName,
          currency: app.settings.currency,
        );
      }
      if (mounted) {
        setState(() => _restoring = false);
        _goTo(6);
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
    if (!app.settings.onboarded) {
      await app.completeOnboarding(
        name: _nameCtrl.text.trim().isEmpty ? 'User' : _nameCtrl.text.trim(),
        currency: _currency,
      );
    }

    final accName = _accNameCtrl.text.trim();
    String? bankAccId;
    if (accName.isNotEmpty) {
      bankAccId = app.newId();
      await app.addAccount(Account(
        id: bankAccId,
        name: accName,
        type: _accType,
        currency: _accCur,
        balance: double.tryParse(_accBalCtrl.text) ?? 0,
        colorValue: _accColor,
        excludeFromTotal: _accExcludeFromTotal,
      ));
    }

    final cardName = _cardNameCtrl.text.trim();
    if (cardName.isNotEmpty && _accType == 'bank' && bankAccId != null) {
      await app.addAccount(Account(
        id: app.newId(),
        name: cardName,
        type: 'debit',
        currency: _accCur,
        balance: 0,
        colorValue: _cardColor,
        linkedAccountId: bankAccId,
        cardHolderName: _cardHolderCtrl.text.trim().isNotEmpty
            ? _cardHolderCtrl.text.trim()
            : _nameCtrl.text.trim(),
        cardNumberLast4: _cardDigitsCtrl.text.trim().isNotEmpty
            ? _cardDigitsCtrl.text.trim()
            : '1234',
      ));
    }

    if (mounted) {
      Navigator.pushReplacement(
        context,
        ExpensyRoute(builder: (_) => const MainShell()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    // Show progress bar only on setup steps (hide on Page 1: Welcome and Page 6: Notification)
    final showProgress = _page != 1 && _page != 6;
    final showNavButtons = _page != 1 && _page != 6;

    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          AnimatedOpacity(
            opacity: showProgress ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: List.generate(
                  _totalPages,
                  (i) => Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: 5,
                      margin: EdgeInsets.only(
                        right: i < _totalPages - 1 ? 6 : 0,
                      ),
                      decoration: BoxDecoration(
                        color: i <= _page
                            ? cs.primary
                            : cs.surfaceContainerHighest.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: i == _page
                            ? [
                                BoxShadow(
                                  color: cs.primary.withValues(alpha: 0.35),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ]
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: PageView(
              key: const PageStorageKey('onboarding_pageview'),
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
                _PageName(
                  nameCtrl: _nameCtrl,
                  nameError: _nameError,
                ),
                _PageCurrency(
                  currency: _currency,
                  onChanged: (v) => setState(() {
                    _currency = v;
                    _accCur = v;
                  }),
                ),
                _PageAccount(
                  nameCtrl: _accNameCtrl,
                  balCtrl: _accBalCtrl,
                  type: _accType,
                  currency: _accCur,
                  color: _accColor,
                  excludeFromTotal: _accExcludeFromTotal,
                  onType: (v) => setState(() => _accType = v),
                  onCurrency: (v) => setState(() => _accCur = v),
                  onColor: (v) => setState(() => _accColor = v),
                  onExcludeFromTotal: (v) =>
                      setState(() => _accExcludeFromTotal = v),
                ),
                _PageDebitCard(
                  nameCtrl: _cardNameCtrl,
                  holderCtrl: _cardHolderCtrl,
                  digitsCtrl: _cardDigitsCtrl,
                  color: _cardColor,
                  currency: _accCur,
                  bankName: _accNameCtrl.text.trim(),
                  onColor: (c) => setState(() => _cardColor = c),
                ),
                _PageNotification(
                  onAllow: () async {
                    AppHaptics.tap(context, HapticStrength.light);
                    try {
                      await NotificationService().requestPermissions();
                    } catch (_) {}
                    await _finish();
                  },
                  onSkip: () async {
                    AppHaptics.tap(context, HapticStrength.light);
                    await _finish();
                  },
                ),
              ],
            ),
          ),

          if (showNavButtons)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(children: [
                    Expanded(
                      flex: 1,
                      child: _FintechSecondaryButton(
                        onPressed: _page == 0
                            ? null
                            : () {
                                if (_page == 5) {
                                  _goTo(4);
                                } else if (_page == 6) {
                                  _goTo(_accType == 'bank' ? 5 : 4);
                                } else {
                                  _pageCtrl.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                        label: l10n.onboarding_back,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: _FintechPrimaryButton(
                        onPressed: _next,
                        label: l10n.onboarding_continue,
                      ),
                    ),
                  ]),
                  if (_page == 4 || _page == 5)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: TextButton(
                        onPressed: _skip,
                        style: TextButton.styleFrom(
                          foregroundColor: cs.onSurface.withValues(alpha: 0.6),
                          textStyle: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
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
        const SizedBox(height: 12),
        _fintechHeroIcon(context, Icons.language_rounded, color: cs.primary),
        const SizedBox(height: 20),
        Text(
          l10n.onboarding_chooseLanguage,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          l10n.settings_language,
          style: TextStyle(
            fontSize: 14,
            color: cs.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 20),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 0,
      color: sel
          ? cs.primaryContainer.withValues(alpha: isDark ? 0.35 : 0.6)
          : cs.surfaceContainerLow,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: sel
              ? cs.primary
              : (isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : Colors.black.withValues(alpha: 0.04)),
          width: sel ? 1.5 : 1,
        ),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 15,
            fontWeight: sel ? FontWeight.w700 : FontWeight.w500,
            color: sel ? cs.primary : cs.onSurface,
          ),
        ),
        trailing: sel
            ? Icon(Icons.check_circle_rounded, color: cs.primary)
            : Icon(Icons.circle_outlined,
                color: cs.onSurface.withValues(alpha: 0.25)),
        onTap: () {
          AppHaptics.tap(context, HapticStrength.light);
          context.read<AppProvider>().updateSetting('languageCode', code);
          onNext();
        },
      ),
    );
  }
}

// ── Page 1: Welcome / Restore backup ──────────────────────────────────────────
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 12),
        _fintechHeroIcon(context, Icons.account_balance_wallet_rounded,
            color: cs.primary),
        const SizedBox(height: 20),
        Text(
          l10n.onboarding_welcomeToExpensy,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.onboarding_yourPersonalTracker,
          style: TextStyle(
            fontSize: 14,
            color: cs.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 28),

        // Restore Card
        Container(
          decoration: BoxDecoration(
            color: cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: cs.primary.withValues(alpha: isDark ? 0.2 : 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.restore_rounded, color: cs.primary, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.onboarding_restoreABackup,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 15),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.onboarding_loadAPreviouslySaved,
                      style: TextStyle(
                        fontSize: 12,
                        color: cs.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            const SizedBox(height: 16),
            _FintechPrimaryButton(
              onPressed: restoring ? null : onRestore,
              loading: restoring,
              icon: const Icon(Icons.upload_file_rounded,
                  size: 18, color: Colors.white),
              label: restoring
                  ? l10n.onboarding_restoring
                  : l10n.onboarding_chooseBackupFile,
            ),
            if (error != null) ...[
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: cs.errorContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: cs.error.withValues(alpha: 0.3), width: 1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.error_outline_rounded,
                        color: cs.error, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        error!,
                        style: TextStyle(
                            fontSize: 12, color: cs.onErrorContainer),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ]),
        ),

        const SizedBox(height: 12),
        // External GreenStash restore button
        _FintechSecondaryButton(
          onPressed: restoring ? null : () => onRestoreExternal('greenstash'),
          icon: Icon(Icons.savings_outlined, size: 18, color: cs.primary),
          label: l10n.onboarding_restoreGreenStash,
        ),

        const SizedBox(height: 20),
        Row(children: [
          Expanded(
            child: Divider(
              color: cs.outlineVariant.withValues(alpha: 0.4),
              height: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              l10n.onboarding_or,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: cs.onSurface.withValues(alpha: 0.45),
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: cs.outlineVariant.withValues(alpha: 0.4),
              height: 1,
            ),
          ),
        ]),
        const SizedBox(height: 20),

        _FintechPrimaryButton(
          onPressed: restoring ? null : onStartFresh,
          icon: const Icon(Icons.add_circle_outline_rounded,
              size: 18, color: Colors.white),
          label: l10n.onboarding_startFresh,
        ),
      ]),
    );
  }
}

// ── Page 2: Name ─────────────────────────────────────────────────────────────
class _PageName extends StatelessWidget {
  final TextEditingController nameCtrl;
  final String? nameError;
  const _PageName({
    required this.nameCtrl,
    required this.nameError,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 12),
        _fintechHeroIcon(context, Icons.waving_hand_rounded,
            color: const Color(0xFFFFB74D)),
        const SizedBox(height: 20),
        Text(
          l10n.onboarding_letsGetYouSetUp,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.onboarding_firstWhatShouldWeCal,
          style: TextStyle(
            fontSize: 14,
            color: cs.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 28),
        TextField(
          controller: nameCtrl,
          autofocus: true,
          decoration: InputDecoration(
            labelText: l10n.onboarding_yourName,
            errorText: nameError,
            prefixIcon: const Icon(Icons.person_outline_rounded),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  color: cs.outlineVariant.withValues(alpha: 0.6)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: cs.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: cs.error, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: cs.error, width: 2),
            ),
          ),
          textCapitalization: TextCapitalization.words,
        ),
      ]),
    );
  }
}

// ── Page 3: Currency ─────────────────────────────────────────────────────────
class _PageCurrency extends StatelessWidget {
  final String currency;
  final void Function(String) onChanged;
  const _PageCurrency({required this.currency, required this.onChanged});

  static const _popularCurrencies = ['USD', 'EUR', 'EGP', 'GBP', 'SAR', 'AED'];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final info = currencyInfo(currency);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 12),
        _fintechHeroIcon(context, Icons.currency_exchange_rounded,
            color: cs.secondary),
        const SizedBox(height: 20),
        Text(
          l10n.onboarding_defaultCurrency,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.onboarding_thisWillBeUsedAcross,
          style: TextStyle(
            fontSize: 14,
            color: cs.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 28),

        // Selected currency interactive display
        Material(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              AppHaptics.tap(context, HapticStrength.light);
              final picked =
                  await showCurrencyPicker(context, current: currency);
              if (picked != null) onChanged(picked);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.06),
                  width: 1,
                ),
              ),
              child: Row(children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: cs.primary.withValues(alpha: isDark ? 0.2 : 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    info.symbol,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: cs.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currency,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        info.name,
                        style: TextStyle(
                          fontSize: 13,
                          color: cs.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.swap_vert_rounded,
                      color: cs.primary, size: 20),
                ),
              ]),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Popular Currency quick-select chips
        Text(
          'Popular Currencies',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: cs.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _popularCurrencies.map((cur) {
            final isSelected = cur == currency;
            return ChoiceChip(
              label: Text(cur),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  AppHaptics.tap(context, HapticStrength.selection);
                  onChanged(cur);
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        OutlinedButton.icon(
          onPressed: () async {
            AppHaptics.tap(context, HapticStrength.light);
            final picked =
                await showCurrencyPicker(context, current: currency);
            if (picked != null) onChanged(picked);
          },
          icon: const Icon(Icons.search_rounded, size: 18),
          label: Text(l10n.onboarding_searchAllCurrencies),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            side: BorderSide(
                color: cs.outlineVariant.withValues(alpha: 0.6)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            textStyle:
                const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
          ),
        ),
      ]),
    );
  }
}

// ── Page 4: First Account ────────────────────────────────────────────────────
class _PageAccount extends StatefulWidget {
  final TextEditingController nameCtrl, balCtrl;
  final String type, currency;
  final int color;
  final bool excludeFromTotal;
  final void Function(String) onType, onCurrency;
  final void Function(int) onColor;
  final void Function(bool) onExcludeFromTotal;

  const _PageAccount({
    required this.nameCtrl,
    required this.balCtrl,
    required this.type,
    required this.currency,
    required this.color,
    required this.excludeFromTotal,
    required this.onType,
    required this.onCurrency,
    required this.onColor,
    required this.onExcludeFromTotal,
  });

  @override
  State<_PageAccount> createState() => _PageAccountState();
}

class _PageAccountState extends State<_PageAccount> {
  bool _showKeypad = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sym = currencyInfo(widget.currency).symbol;
    final kbOpen = MediaQuery.of(context).viewInsets.bottom > 100;
    final showPad = _showKeypad && !kbOpen;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 12),
        _fintechHeroIcon(context, Icons.account_balance_rounded,
            color: cs.tertiary),
        const SizedBox(height: 20),
        Text(
          l10n.onboarding_yourFirstAccount,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          l10n.onboarding_setUpYourMainAccount,
          style: TextStyle(
            fontSize: 14,
            color: cs.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 24),

        TextField(
          controller: widget.nameCtrl,
          onTap: () {
            if (_showKeypad) setState(() => _showKeypad = false);
          },
          decoration: InputDecoration(
            labelText: l10n.onboarding_accountName,
            prefixIcon: const Icon(Icons.label_outline_rounded),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  color: cs.outlineVariant.withValues(alpha: 0.6)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: cs.primary, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 18),

        // Account Type pills
        Text(
          l10n.onboarding_accountType,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: cs.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            for (final opt in [
              ('bank', l10n.onboarding_bank, Icons.account_balance_rounded),
              ('cash', l10n.onboarding_cash, Icons.payments_rounded),
              ('savings', l10n.onboarding_savings, Icons.savings_rounded),
              ('wallet', l10n.onboarding_wallet, Icons.account_balance_wallet_rounded),
            ])
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Material(
                  color: widget.type == opt.$1
                      ? (isDark
                          ? cs.primary.withValues(alpha: 0.25)
                          : cs.primary)
                      : cs.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      AppHaptics.tap(context, HapticStrength.selection);
                      widget.onType(opt.$1);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: widget.type == opt.$1
                              ? (isDark
                                  ? cs.primary.withValues(alpha: 0.5)
                                  : cs.primary)
                              : (isDark
                                  ? Colors.white.withValues(alpha: 0.06)
                                  : Colors.black.withValues(alpha: 0.04)),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            opt.$3,
                            size: 16,
                            color: widget.type == opt.$1
                                ? (isDark ? cs.primary : Colors.white)
                                : cs.onSurface.withValues(alpha: 0.7),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            opt.$2,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: widget.type == opt.$1
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: widget.type == opt.$1
                                  ? (isDark ? cs.primary : Colors.white)
                                  : cs.onSurface.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ]),
        ),
        const SizedBox(height: 18),

        // If Bank, show fintech helper note
        if (widget.type == 'bank') ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: cs.primaryContainer.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: cs.primary.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.credit_card_rounded, size: 20, color: cs.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'You can add a debit card for this bank account in the next step',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
        ],

        // Currency Selector Card
        Text(
          l10n.onboarding_currency,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: cs.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 10),
        Material(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () async {
              AppHaptics.tap(context, HapticStrength.light);
              final picked =
                  await showCurrencyPicker(context, current: widget.currency);
              if (picked != null) widget.onCurrency(picked);
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.05),
                  width: 1,
                ),
              ),
              child: Row(children: [
                Icon(Icons.monetization_on_outlined,
                    size: 20, color: cs.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${widget.currency}  ${currencyInfo(widget.currency).symbol}  —  ${currencyInfo(widget.currency).name}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13.5),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_rounded,
                    color: cs.onSurface.withValues(alpha: 0.5)),
              ]),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Starting Balance field is ALWAYS visible for all account types
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  color: cs.outlineVariant.withValues(alpha: 0.6)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: cs.primary, width: 2),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                showPad
                    ? Icons.keyboard_hide_outlined
                    : Icons.dialpad_outlined,
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
        const SizedBox(height: 16),

        // Exclude From Total Balance switch is ALWAYS visible
        Material(
          color: cs.surfaceContainerLow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.05),
            ),
          ),
          child: SwitchListTile.adaptive(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            title: Text(
              l10n.accounts_excludeFromTotalBala,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14),
            ),
            subtitle: Text(
              l10n.accounts_wontCountTowardYourHome,
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
        ),
        const SizedBox(height: 16),

        // Color selector
        Text(
          l10n.onboarding_color,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: cs.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 44,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _kColors
                  .map((col) => GestureDetector(
                        onTap: () {
                          AppHaptics.tap(context, HapticStrength.selection);
                          widget.onColor(col);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 120),
                          width: 36,
                          height: 36,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Color(col),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: widget.color == col
                                  ? (isDark ? Colors.white : Colors.black)
                                  : Colors.transparent,
                              width: 3,
                            ),
                            boxShadow: widget.color == col
                                ? [
                                    BoxShadow(
                                      color:
                                          Color(col).withValues(alpha: 0.5),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    )
                                  ]
                                : null,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        if (showPad) ...[
          const SizedBox(height: 16),
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

// ── Page 5: Add a Debit Card (Linked to Bank Account) ─────────────────────────
class _PageDebitCard extends StatefulWidget {
  final TextEditingController nameCtrl, holderCtrl, digitsCtrl;
  final int color;
  final String currency;
  final String bankName;
  final void Function(int) onColor;

  const _PageDebitCard({
    required this.nameCtrl,
    required this.holderCtrl,
    required this.digitsCtrl,
    required this.color,
    required this.currency,
    required this.bankName,
    required this.onColor,
  });

  @override
  State<_PageDebitCard> createState() => _PageDebitCardState();
}

class _PageDebitCardState extends State<_PageDebitCard> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardName = widget.nameCtrl.text.trim().isEmpty
        ? 'Debit Card'
        : widget.nameCtrl.text.trim();
    final holderName = widget.holderCtrl.text.trim().isEmpty
        ? 'EXPENSY MEMBER'
        : widget.holderCtrl.text.trim().toUpperCase();
    final digits = widget.digitsCtrl.text.trim().isEmpty
        ? '1234'
        : widget.digitsCtrl.text.trim();

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 12),
        _fintechHeroIcon(context, Icons.credit_card_rounded,
            color: Color(widget.color)),
        const SizedBox(height: 20),
        Text(
          'Add a Debit Card',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'Link a debit card to your new bank account for effortless expense tracking.',
          style: TextStyle(
            fontSize: 14,
            color: cs.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 20),

        // Realistic Fintech Debit Card Preview
        Container(
          height: 190,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(widget.color),
                Color.lerp(Color(widget.color), Colors.black, 0.45) ??
                    Color(widget.color),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(widget.color).withValues(alpha: 0.35),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(children: [
              Positioned(
                right: -30,
                top: -30,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                bottom: -50,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.04),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Container(
                            width: 32,
                            height: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD700)
                                  .withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.4),
                                  width: 0.5),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.contactless_rounded,
                            color: Colors.white70,
                            size: 20,
                          ),
                        ]),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                              width: 0.5,
                            ),
                          ),
                          child: const Text(
                            'DEBIT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cardName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '••••  ••••  ••••  $digits',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            letterSpacing: 2,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          holderName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.1,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red.withValues(alpha: 0.85),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(-6, 0),
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.amber.withValues(alpha: 0.85),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
        const SizedBox(height: 20),

        TextField(
          controller: widget.nameCtrl,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            labelText: 'Card Name',
            prefixIcon: const Icon(Icons.credit_card_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  color: cs.outlineVariant.withValues(alpha: 0.6)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: cs.primary, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 14),

        TextField(
          controller: widget.holderCtrl,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            labelText: 'Cardholder Name',
            prefixIcon: const Icon(Icons.person_outline_rounded),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  color: cs.outlineVariant.withValues(alpha: 0.6)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: cs.primary, width: 2),
            ),
          ),
          textCapitalization: TextCapitalization.characters,
        ),
        const SizedBox(height: 14),

        TextField(
          controller: widget.digitsCtrl,
          maxLength: 4,
          keyboardType: TextInputType.number,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            counterText: '',
            labelText: 'Last 4 Digits',
            prefixIcon: const Icon(Icons.numbers_rounded),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  color: cs.outlineVariant.withValues(alpha: 0.6)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: cs.primary, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 18),

        // Color Picker
        Text(
          'Card Color',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: cs.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 44,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _kColors
                  .map((col) => GestureDetector(
                        onTap: () {
                          AppHaptics.tap(context, HapticStrength.selection);
                          widget.onColor(col);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 120),
                          width: 36,
                          height: 36,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Color(col),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: widget.color == col
                                  ? (isDark ? Colors.white : Colors.black)
                                  : Colors.transparent,
                              width: 3,
                            ),
                            boxShadow: widget.color == col
                                ? [
                                    BoxShadow(
                                      color:
                                          Color(col).withValues(alpha: 0.5),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    )
                                  ]
                                : null,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ]),
    );
  }
}

// ── Page 6: Notification Access Request ───────────────────────────────────────
class _PageNotification extends StatelessWidget {
  final VoidCallback onAllow;
  final VoidCallback onSkip;

  const _PageNotification({
    required this.onAllow,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          // Hero Glowing Bell Icon
          Center(
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: isDark ? 0.22 : 0.12),
                shape: BoxShape.circle,
                border: Border.all(
                  color: cs.primary.withValues(alpha: isDark ? 0.4 : 0.25),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: cs.primary.withValues(alpha: 0.25),
                    blurRadius: 28,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.notifications_active_rounded,
                  size: 42,
                  color: cs.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),

          Text(
            l10n.onboarding_stayOnTopOfFinances,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.onboarding_stayOnTopOfFinancesDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: cs.onSurface.withValues(alpha: 0.65),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 32),

          // 3 Feature Value Props
          _featureTile(
            context,
            icon: Icons.event_available_rounded,
            title: l10n.onboarding_featureBillTitle,
            desc: l10n.onboarding_featureBillDesc,
          ),
          const SizedBox(height: 14),
          _featureTile(
            context,
            icon: Icons.pie_chart_rounded,
            title: l10n.onboarding_featureBudgetTitle,
            desc: l10n.onboarding_featureBudgetDesc,
          ),
          const SizedBox(height: 14),
          _featureTile(
            context,
            icon: Icons.repeat_rounded,
            title: l10n.onboarding_featureRecurringTitle,
            desc: l10n.onboarding_featureRecurringDesc,
          ),
          const SizedBox(height: 40),

          // Primary and secondary fintech buttons
          _FintechPrimaryButton(
            onPressed: onAllow,
            label: l10n.onboarding_allowNotifications,
            icon: Icon(
              Icons.notifications_active_rounded,
              color: cs.onPrimary,
              size: 20,
            ),
          ),
          const SizedBox(height: 12),
          _FintechSecondaryButton(
            onPressed: onSkip,
            label: l10n.onboarding_maybeLater,
          ),
        ],
      ),
    );
  }

  Widget _featureTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String desc,
  }) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: cs.primary, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: cs.onSurface.withValues(alpha: 0.6),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
