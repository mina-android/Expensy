# Expensy — Home Screen Widgets Architecture

This document describes the native Android App Widget integration for Expensy.

---

## §0 Overview

Expensy supports three Android Home Screen Widgets:
1. **Quick Add Transaction Widget** (`QuickAddWidgetProvider.kt`) — One-tap shortcut that launches `AddTransactionScreen` via a native `MethodChannel` / `EventChannel` bridge.
2. **Accounts Widget** (`AccountsWidgetProvider.kt`) — Displays the user's top 3 pinned accounts and balances, updated via `home_widget` SharedPreferences.
3. **Budget Widget** (`BudgetWidgetProvider.kt`) — Displays active category budgets and spending progress, updated via `home_widget` SharedPreferences.

---

## §3.3 Native ↔ Dart Bridge Architecture

The widgets communicate with the Flutter app through two channels:

1. **`home_widget` Package (Data Sync)**
   - Dart side calls `HomeWidget.saveWidgetData(key, json)` and `HomeWidget.updateWidget(name: providerName)`.
   - `AppProvider.updateHomeWidgets()` runs on app startup (`load()`) and on relevant balance or budget mutations.
   - Native providers read JSON arrays from `HomeWidgetPreferences` SharedPreferences:
     - `accounts_widget_data` → `AccountsWidgetProvider.kt`
     - `budget_widget_data` → `BudgetWidgetProvider.kt`

2. **Hand-Rolled `MethodChannel` + `EventChannel` (Quick Add Fast Path)**
   - Defined in `lib/services/quick_add_service.dart` (`com.ma.expensy/quick_add`).
   - Does not use `home_widget` to avoid overhead on single-tap launches.

---

## §4.1 Quick Add Intent Flow

- **Cold Start**: When the user taps the Quick Add widget while the app is closed, `MainActivity.kt` sets an Intent extra `route = "quick_add_transaction"`.
- `QuickAddService.getInitialRoute()` reads the extra during initial frame rendering and triggers `_pushQuickAdd()`.

---

## §4.2 Root Navigator Push Pattern

- `main.dart` maintains a `rootNavigatorKey = GlobalKey<NavigatorState>()`.
- Widget taps push `AddTransactionScreen` on top of `rootNavigatorKey.currentState`.
- This ensures `MainShell` remains the true root of the app hierarchy, and standard `ExpensySlideUpRoute` back navigation works seamlessly.
