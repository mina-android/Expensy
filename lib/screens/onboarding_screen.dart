// lib/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import 'main_shell.dart';

const List<int> _kColors = [
  0xFF6750A4, 0xFF7D5260, 0xFF1565C0, 0xFF2E7D32, 0xFFE65100, 0xFF00897B,
  0xFFC62828, 0xFF37474F, 0xFF0077B6, 0xFF9C27B0, 0xFF00BFA5, 0xFFF9A825,
  0xFF6D4C41, 0xFF283593, 0xFFAD1457, 0xFF558B2F, 0xFF00838F, 0xFFBF360C,
  0xFF4527A0, 0xFF1B5E20, 0xFF880E4F, 0xFF33691E, 0xFF004D40, 0xFFB71C1C,
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

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageCtrl = PageController();
  int _page = 0;

  // Step 1 — Name
  final _nameCtrl = TextEditingController();

  // Step 2 — Currency
  String _currency = 'EGP';

  // Step 3 — First account
  final _accNameCtrl = TextEditingController(text: 'Main Account');
  final _accBalCtrl  = TextEditingController(text: '0');
  String _accType    = 'bank';
  String _accCur     = 'EGP';
  int    _accColor   = 0xFF6750A4;

  @override
  void dispose() {
    _pageCtrl.dispose();
    _nameCtrl.dispose();
    _accNameCtrl.dispose();
    _accBalCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_page == 0 && _nameCtrl.text.trim().isEmpty) return;
    if (_page < 2) {
      _pageCtrl.nextPage(duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut);
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    final app = context.read<AppProvider>();
    await app.completeOnboarding(
        name: _nameCtrl.text.trim(), currency: _currency);

    final accName = _accNameCtrl.text.trim();
    if (accName.isNotEmpty) {
      await app.addAccount(Account(
        id: app.newId(),
        name: accName,
        type: _accType,
        currency: _accCur,
        balance: double.tryParse(_accBalCtrl.text) ?? 0,
        colorValue: _accColor,
      ));
    }

    if (mounted) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const MainShell()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          // Progress
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(children: List.generate(3, (i) => Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(right: i < 2 ? 6 : 0),
                decoration: BoxDecoration(
                  color: i <= _page ? cs.primary : cs.surfaceContainerHigh,
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
                _PageOne(nameCtrl: _nameCtrl),
                _PageTwo(currency: _currency,
                    onChanged: (v) => setState(() { _currency = v; _accCur = v; })),
                _PageThree(
                  nameCtrl: _accNameCtrl, balCtrl: _accBalCtrl,
                  type: _accType, currency: _accCur, color: _accColor,
                  onType:     (v) => setState(() => _accType = v),
                  onCurrency: (v) => setState(() => _accCur = v),
                  onColor:    (v) => setState(() => _accColor = v),
                ),
              ],
            ),
          ),

          // Navigation buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Row(children: [
              if (_page > 0)
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: () => _pageCtrl.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut),
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28))),
                    child: const Text('Back'),
                  ),
                ),
              if (_page > 0) const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: FilledButton(
                  onPressed: _next,
                  style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28))),
                  child: Text(_page < 2 ? 'Continue' : 'Get Started'),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

// ── Page 1: Name ─────────────────────────────────────────────────────────────
class _PageOne extends StatelessWidget {
  final TextEditingController nameCtrl;
  const _PageOne({required this.nameCtrl});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 24),
        Container(
          width: 64, height: 64,
          decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.waving_hand_outlined, color: cs.primary, size: 32),
        ),
        const SizedBox(height: 20),
        Text('Welcome to Expensy!',
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text('Your personal, 100% offline finance tracker.\nLet\'s get you set up.',
            style: TextStyle(fontSize: 15,
                color: cs.onSurface.withValues(alpha: 0.6))),
        const SizedBox(height: 32),
        TextField(
          controller: nameCtrl,
          autofocus: true,
          decoration: const InputDecoration(
              labelText: 'Your name', prefixIcon: Icon(Icons.person_outline)),
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
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 24),
        Container(
          width: 64, height: 64,
          decoration: BoxDecoration(
              color: cs.secondaryContainer,
              borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.monetization_on_outlined,
              color: cs.secondary, size: 32),
        ),
        const SizedBox(height: 20),
        Text('Default Currency',
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text('This will be used across the app.\nYou can change it later in Settings.',
            style: TextStyle(fontSize: 15,
                color: cs.onSurface.withValues(alpha: 0.6))),
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800,
                      color: cs.primary)),
              const SizedBox(width: 14),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(currency,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800,
                          color: cs.onPrimaryContainer)),
                  Text(currencyInfo(currency).name,
                      style: TextStyle(fontSize: 13,
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
          label: const Text('Search all currencies'),
        ),
      ]),
    );
  }
}

// ── Page 3: First Account ────────────────────────────────────────────────────
class _PageThree extends StatelessWidget {
  final TextEditingController nameCtrl, balCtrl;
  final String type, currency;
  final int color;
  final void Function(String) onType, onCurrency;
  final void Function(int)    onColor;

  const _PageThree({
    required this.nameCtrl, required this.balCtrl,
    required this.type, required this.currency, required this.color,
    required this.onType, required this.onCurrency, required this.onColor,
  });

  @override
  Widget build(BuildContext context) {
    final cs  = Theme.of(context).colorScheme;
    final sym = currencyInfo(currency).symbol;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 24),
        Container(
          width: 64, height: 64,
          decoration: BoxDecoration(
              color: cs.tertiaryContainer,
              borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.account_balance_wallet_outlined,
              color: cs.tertiary, size: 32),
        ),
        const SizedBox(height: 20),
        Text('Your First Account',
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text('Set up your main account to start tracking.',
            style: TextStyle(fontSize: 15,
                color: cs.onSurface.withValues(alpha: 0.6))),
        const SizedBox(height: 24),

        TextField(
          controller: nameCtrl,
          decoration: const InputDecoration(
              labelText: 'Account Name',
              prefixIcon: Icon(Icons.label_outline)),
        ),
        const SizedBox(height: 14),

        // Type cards
        Text('Account Type', style: Theme.of(context).textTheme.labelMedium
            ?.copyWith(letterSpacing: 1)),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            for (final opt in const [
              ('bank',    'Bank',   'account_balance'),
              ('cash',    'Cash',   'payments'),
              ('savings', 'Savings','savings'),
              ('credit',  'Credit', 'credit_card'),
              ('wallet',  'Wallet', 'account_balance_wallet'),
            ])
              GestureDetector(
                onTap: () => onType(opt.$1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 140),
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: type == opt.$1 ? cs.primary : cs.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(_typeIcon(opt.$1), size: 14,
                        color: type == opt.$1 ? Colors.white : cs.onSurface),
                    const SizedBox(width: 6),
                    Text(opt.$2, style: TextStyle(fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: type == opt.$1 ? Colors.white : cs.onSurface)),
                  ]),
                ),
              ),
          ]),
        ),
        const SizedBox(height: 14),

        // Currency
        Text('Currency', style: Theme.of(context).textTheme.labelMedium
            ?.copyWith(letterSpacing: 1)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final picked = await showCurrencyPicker(context, current: currency);
            if (picked != null) onCurrency(picked);
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
              Expanded(child: Text('$currency  ${currencyInfo(currency).symbol}  —  ${currencyInfo(currency).name}',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
              const Icon(Icons.arrow_drop_down_rounded),
            ]),
          ),
        ),
        const SizedBox(height: 14),

        TextField(
          controller: balCtrl,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
              labelText: 'Starting Balance',
              prefixText: '$sym '),
        ),
        const SizedBox(height: 14),

        // Colour
        Text('Colour', style: Theme.of(context).textTheme.labelMedium
            ?.copyWith(letterSpacing: 1)),
        const SizedBox(height: 8),
        SizedBox(
          height: 44,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: _kColors.map((col) => GestureDetector(
              onTap: () => onColor(col),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 80),
                width: 34, height: 34,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Color(col), shape: BoxShape.circle,
                  border: Border.all(
                      color: color == col ? cs.onSurface : Colors.transparent,
                      width: 3),
                  boxShadow: color == col ? [BoxShadow(
                      color: Color(col).withValues(alpha: 0.5),
                      blurRadius: 6, spreadRadius: 1)] : null,
                ),
              ),
            )).toList()),
          ),
        ),
        const SizedBox(height: 20),
      ]),
    );
  }
}
