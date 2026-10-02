// lib/screens/main_shell.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../widgets/rounded_square_border.dart';

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final app = context.read<AppProvider>();
    app.tabIndexNotifier.removeListener(_onTabChange);
    app.tabIndexNotifier.addListener(_onTabChange);
    if (_index != app.tabIndexNotifier.value) {
      _index = app.tabIndexNotifier.value;
    }
  }

  void _onTabChange() {
    final app = context.read<AppProvider>();
    if (_index != app.tabIndexNotifier.value && mounted) {
      setState(() {
        _index = app.tabIndexNotifier.value;
      });
    }
  }

  static Color _getTabColor(int index, bool isDark) {
    switch (index) {
      case 0: // Home
        return isDark ? const Color(0xFF64B5F6) : const Color(0xFF1972E8);
      case 1: // Transactions
        return isDark ? const Color(0xFF81C784) : const Color(0xFF2E7D32);
      case 2: // Recurring
        return isDark ? const Color(0xFFBA68C8) : const Color(0xFF8E24AA);
      case 3: // Accounts
        return isDark ? const Color(0xFFFFB74D) : const Color(0xFFF57C00);
      case 4: // Budgets
        return isDark ? const Color(0xFFF06292) : const Color(0xFFD81B60);
      case 5: // More
        return isDark ? const Color(0xFF4DB6AC) : const Color(0xFF00897B);
      default:
        return isDark ? const Color(0xFF64B5F6) : const Color(0xFF1972E8);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final overlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: PopScope(
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
          extendBody: true,
          body: FadeIndexedStack(index: _index, children: _screens),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.12)
                      : Colors.black.withValues(alpha: 0.08),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Material(
                elevation: 0,
                borderRadius: BorderRadius.circular(22),
                clipBehavior: Clip.antiAlias,
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    child: NavigationBarTheme(
                      data: NavigationBarThemeData(
                        height: 64,
                        indicatorColor: _getTabColor(_index, isDark)
                            .withValues(alpha: isDark ? 0.22 : 0.16),
                        indicatorShape: const RoundedSquareBorder(
                          borderRadius: 14,
                          size: 40,
                        ),
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                        iconTheme: WidgetStateProperty.resolveWith((states) {
                          return const IconThemeData(size: 24);
                        }),
                      ),
                      child: NavigationBar(
                    labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
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
                        icon: Icon(
                          Icons.home_outlined,
                          color: _getTabColor(0, isDark).withValues(alpha: 0.6),
                        ),
                        selectedIcon: Icon(
                          Icons.home,
                          color: _getTabColor(0, isDark),
                        ),
                        label: l10n.main_home,
                      ),
                      NavigationDestination(
                        icon: Icon(
                          Icons.receipt_long_outlined,
                          color: _getTabColor(1, isDark).withValues(alpha: 0.6),
                        ),
                        selectedIcon: Icon(
                          Icons.receipt_long,
                          color: _getTabColor(1, isDark),
                        ),
                        label: l10n.main_transactions,
                      ),
                      NavigationDestination(
                        icon: Icon(
                          Icons.repeat_rounded,
                          color: _getTabColor(2, isDark).withValues(alpha: 0.6),
                        ),
                        selectedIcon: Icon(
                          Icons.repeat_rounded,
                          color: _getTabColor(2, isDark),
                        ),
                        label: l10n.main_recurring,
                      ),
                      NavigationDestination(
                        icon: Icon(
                          Icons.account_balance_wallet_outlined,
                          color: _getTabColor(3, isDark).withValues(alpha: 0.6),
                        ),
                        selectedIcon: Icon(
                          Icons.account_balance_wallet,
                          color: _getTabColor(3, isDark),
                        ),
                        label: l10n.main_accounts,
                      ),
                      NavigationDestination(
                        icon: Icon(
                          Icons.pie_chart_outline_rounded,
                          color: _getTabColor(4, isDark).withValues(alpha: 0.6),
                        ),
                        selectedIcon: Icon(
                          Icons.pie_chart_rounded,
                          color: _getTabColor(4, isDark),
                        ),
                        label: l10n.main_budgets,
                      ),
                      NavigationDestination(
                        icon: Icon(
                          Icons.more_horiz_outlined,
                          color: _getTabColor(5, isDark).withValues(alpha: 0.6),
                        ),
                        selectedIcon: Icon(
                          Icons.more_horiz,
                          color: _getTabColor(5, isDark),
                        ),
                        label: l10n.main_more,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
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
