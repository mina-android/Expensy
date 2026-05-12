// lib/screens/main_shell.dart
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'transactions_screen.dart';
import 'recurring_screen.dart';
import 'accounts_screen.dart';
import 'more_screen.dart';

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
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(index: _index, children: _screens),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.receipt_long_outlined),
                selectedIcon: Icon(Icons.receipt_long), label: 'Transactions'),
            NavigationDestination(icon: Icon(Icons.repeat_rounded),
                selectedIcon: Icon(Icons.repeat_rounded), label: 'Recurring'),
            NavigationDestination(
                icon: Icon(Icons.account_balance_wallet_outlined),
                selectedIcon: Icon(Icons.account_balance_wallet),
                label: 'Accounts'),
            NavigationDestination(icon: Icon(Icons.more_horiz_outlined),
                selectedIcon: Icon(Icons.more_horiz), label: 'More'),
          ],
        ),
      );
}
