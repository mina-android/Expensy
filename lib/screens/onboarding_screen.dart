// lib/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/app_provider.dart';
import '../database/db_helper.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _uuid = const Uuid();
  int _step = 0;

  final _nameCtrl   = TextEditingController();
  String _currency  = 'EGP';

  final List<Account> _accounts  = [];
  final _accNameCtrl = TextEditingController();
  String _accType    = 'bank';
  final _accBalCtrl  = TextEditingController(text: '0');
  int _accColor      = 0xFF6750A4;

  static const List<int> _colors = [
    0xFF6750A4, 0xFF7D5260, 0xFF1565C0,
    0xFF2E7D32, 0xFFE65100, 0xFF00897B,
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _accNameCtrl.dispose();
    _accBalCtrl.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    // Capture provider before any awaits to avoid async context issues
    final app  = context.read<AppProvider>();
    final name = _nameCtrl.text.trim().isEmpty
        ? 'Friend'
        : _nameCtrl.text.trim();

    final accs = _accounts.isEmpty
        ? [
            Account(
              id:         _uuid.v4(),
              name:       'Main Account',
              type:       'bank',
              balance:    0,
              currency:   _currency,
              colorValue: 0xFF6750A4,
            )
          ]
        : List<Account>.from(_accounts);

    for (final a in accs) {
      await DBHelper.insertAccount(a);
    }
    await app.completeOnboarding(name: name, currency: _currency);
  }

  void _addAccount() {
    final name = _accNameCtrl.text.trim();
    if (name.isEmpty) return;
    setState(() {
      _accounts.add(Account(
        id:         _uuid.v4(),
        name:       name,
        type:       _accType,
        balance:    double.tryParse(_accBalCtrl.text) ?? 0,
        currency:   _currency,
        colorValue: _accColor,
      ));
      _accNameCtrl.clear();
      _accBalCtrl.text = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress dots
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Row(
                children: List.generate(4, (i) {
                  return Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: i <= _step
                            ? cs.primary
                            : cs.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: [
                    _buildWelcome(cs),
                    _buildName(cs),
                    _buildCurrency(cs),
                    _buildAccounts(cs),
                  ][_step],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Step 0: Welcome ──────────────────────────────────────────────────────
  Widget _buildWelcome(ColorScheme cs) {
    return Column(
      key: const ValueKey(0),
      children: [
        const SizedBox(height: 40),
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(
            'assets/splash_icon.png',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'Welcome to Expensy',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),
        Text(
          'Track expenses, manage accounts,\nand reach your financial goals — fully offline.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: cs.onSurface.withValues(alpha: 0.65),
                height: 1.6),
        ),
        const SizedBox(height: 48),
        _nextBtn('Get Started', () => setState(() => _step = 1), cs),
      ],
    );
  }

  // ── Step 1: Name ─────────────────────────────────────────────────────────
  Widget _buildName(ColorScheme cs) {
    return Column(
      key: const ValueKey(1),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text("What's your name?",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text('So we can personalise your experience',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: cs.onSurface.withValues(alpha: 0.6))),
        const SizedBox(height: 32),
        TextField(
          controller: _nameCtrl,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Your name',
            prefixIcon: Icon(Icons.person_outline_rounded),
          ),
          onSubmitted: (_) => setState(() => _step = 2),
        ),
        const SizedBox(height: 32),
        _nextBtn('Continue', () => setState(() => _step = 2), cs),
      ],
    );
  }

  // ── Step 2: Currency ─────────────────────────────────────────────────────
  Widget _buildCurrency(ColorScheme cs) {
    return Column(
      key: const ValueKey(2),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text('Choose your currency',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text('Default for all your accounts',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: cs.onSurface.withValues(alpha: 0.6))),
        const SizedBox(height: 24),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.6,
          children: kCurrencies.map((c) {
            final sel = _currency == c.code;
            return GestureDetector(
              onTap: () => setState(() => _currency = c.code),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: sel ? cs.primary : cs.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: sel ? cs.primary : cs.outlineVariant,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.symbol,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: sel ? cs.onPrimary : cs.primary),
                    ),
                    const SizedBox(height: 4),
                    Text(c.code,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: sel ? cs.onPrimary : cs.onSurface)),
                    Text(c.name,
                        style: TextStyle(
                            fontSize: 10,
                            color: sel
                                ? cs.onPrimary.withValues(alpha: 0.7)
                                : cs.onSurface.withValues(alpha: 0.55))),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 32),
        _nextBtn('Continue', () => setState(() => _step = 3), cs),
      ],
    );
  }

  // ── Step 3: Accounts ─────────────────────────────────────────────────────
  Widget _buildAccounts(ColorScheme cs) {
    final sym = currencyInfo(_currency).symbol;
    return Column(
      key: const ValueKey(3),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text('Set up your accounts',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text('Add your bank, cash, savings accounts',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: cs.onSurface.withValues(alpha: 0.6))),
        const SizedBox(height: 20),

        // Already-added accounts
        ..._accounts.map((a) => Card(
              color: cs.surfaceContainerLow,
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(a.colorValue),
                  child: Icon(Icons.account_balance_outlined,
                      color: Colors.white, size: 18),
                ),
                title: Text(a.name,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle:
                    Text('$sym${a.balance.toStringAsFixed(2)} · ${a.type}'),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(
                      () => _accounts.removeWhere((x) => x.id == a.id)),
                ),
              ),
            )),

        const SizedBox(height: 8),

        // Add account form
        Card(
          color: cs.surfaceContainerLow,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Account',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                TextField(
                  controller: _accNameCtrl,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Account Name',
                    prefixIcon: Icon(Icons.account_balance_outlined),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _accType,
                  decoration: const InputDecoration(
                      labelText: 'Type', isDense: true),
                  items: const [
                    DropdownMenuItem(value: 'bank',    child: Text('Bank Account')),
                    DropdownMenuItem(value: 'cash',    child: Text('Cash')),
                    DropdownMenuItem(value: 'savings', child: Text('Savings')),
                    DropdownMenuItem(value: 'credit',  child: Text('Credit Card')),
                    DropdownMenuItem(value: 'wallet',  child: Text('E-Wallet')),
                  ],
                  onChanged: (v) => setState(() => _accType = v!),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _accBalCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Initial Balance',
                    prefixText: '$sym ',
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 12),
                // Colour picker
                Row(children: [
                  Text('Colour:',
                      style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(width: 10),
                  ..._colors.map((c) => GestureDetector(
                        onTap: () => setState(() => _accColor = c),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: 26,
                          height: 26,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Color(c),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _accColor == c
                                  ? cs.onSurface
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                      )),
                ]),
                const SizedBox(height: 14),
                OutlinedButton.icon(
                  onPressed: _addAccount,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Account'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(42),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        FilledButton(
          onPressed: _finish,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28)),
          ),
          child: Text(
            _accounts.isEmpty
                ? 'Skip & Use Default Account'
                : 'Enter Expensy →',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _nextBtn(String label, VoidCallback onTap, ColorScheme cs) {
    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}
