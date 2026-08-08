// lib/screens/main_shell.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../l10n/app_localizations.dart';
import 'home_screen.dart';
import 'transactions_screen.dart';
import 'recurring_screen.dart';
import 'accounts_screen.dart';
import 'budget_screen.dart';
import 'more_screen.dart';
import '../utils/haptics.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _screens = [
    HomeScreen(),
    TransactionsScreen(),
    RecurringScreen(),
    AccountsScreen(),
    BudgetScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return PopScope(
      canPop: _index == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        final app = context.read<AppProvider>();
        if (app.isTransactionSelectionMode) return;
        setState(() {
          _index = 0;
          app.tabIndexNotifier.value = 0;
        });
      },
      child: Scaffold(
        body: FadeIndexedStack(index: _index, children: _screens),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: NavigationBar(
            selectedIndex: _index,
            animationDuration: const Duration(milliseconds: 120),
            onDestinationSelected: (i) {
              AppHaptics.tap(context, HapticStrength.selection);
              final app = context.read<AppProvider>();
              setState(() {
                _index = i;
                app.tabIndexNotifier.value = i;
              });
            },
            destinations: [
              NavigationDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home),
                  label: l10n.main_home),
              NavigationDestination(
                  icon: const Icon(Icons.receipt_long_outlined),
                  selectedIcon: const Icon(Icons.receipt_long),
                  label: l10n.main_transactions),
              NavigationDestination(
                  icon: const Icon(Icons.repeat_rounded),
                  selectedIcon: const Icon(Icons.repeat_rounded),
                  label: l10n.main_recurring),
              NavigationDestination(
                  icon: const Icon(Icons.account_balance_wallet_outlined),
                  selectedIcon: const Icon(Icons.account_balance_wallet),
                  label: l10n.main_accounts),
              NavigationDestination(
                  icon: const Icon(Icons.pie_chart_outline_rounded),
                  selectedIcon: const Icon(Icons.pie_chart_rounded),
                  label: l10n.main_budgets),
              NavigationDestination(
                  icon: const Icon(Icons.more_horiz_outlined),
                  selectedIcon: const Icon(Icons.more_horiz),
                  label: l10n.main_more),
            ],
          ),
        ),
      ),
    );
  }
}

class FadeIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  final Duration duration;

  const FadeIndexedStack({
    super.key,
    required this.index,
    required this.children,
    this.duration = const Duration(milliseconds: 250),
  });

  @override
  State<FadeIndexedStack> createState() => _FadeIndexedStackState();
}

class _FadeIndexedStackState extends State<FadeIndexedStack>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.forward();
  }

  @override
  void didUpdateWidget(FadeIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != oldWidget.index) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: IndexedStack(
        index: widget.index,
        children: widget.children,
      ),
    );
  }
}
