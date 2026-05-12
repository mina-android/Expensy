<div align="center">

<img src="assets/splash_icon.png" alt="Expensy Logo" width="120" height="120" style="border-radius: 24px"/>

# Expensy

### Your personal, fully offline finance tracker

[![Flutter](https://img.shields.io/badge/Flutter-3.3%2B-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.3%2B-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Android](https://img.shields.io/badge/Android-5.0%2B-3DDC84?logo=android&logoColor=white)](https://android.com)
[![Version](https://img.shields.io/badge/Version-1.0.3-brightgreen)](https://github.com/yourusername/expensy/releases)
[![License](https://img.shields.io/badge/License-MIT-blue)](LICENSE)

**Expensy** is a clean, fast, and fully offline expense manager built with Flutter.  
No accounts. No cloud. No ads. Your data stays on your device — always.

[**Download APK**](#installation) · [**Features**](#features) · [**Screenshots**](#screenshots) · [**Build It**](#building-from-source)

</div>

---

## Why Expensy?

Most finance apps require you to sign up, sync to the cloud, or show ads. Expensy does none of that. It stores everything locally using SQLite, works without internet, and respects your privacy completely.

---

## Features

### 💰 Accounts
- Add unlimited accounts: **Bank**, **Cash**, **Savings**, **Credit Card**, **E-Wallet**
- Account type selected via
- Each account has its own **currency** chosen from a searchable dialog of **64 currencies**
- Pick from **24 custom colours**
- **Exclude from Total Balance** toggle — hide savings or investment accounts from the home screen total
- See balance, total income, total expense, and transaction count per account
- Edit or delete any account

### 📝 Transactions
- Add **income** and **expense** transactions
- Select account using 
- Assign to any category using **coloured pill chips**
- Description is optional; add an optional note field
- Full-text **search** and filter chips by type or account
- Grouped by date (Today, Yesterday, full date)
- Tap to edit, long-press to delete

### 🔄 Account Transfers
- Transfer between accounts using **FROM and TO card rows**
- The same-as-FROM account is dimmed and non-selectable
- Live preview of both balances

### 📊 Statistics *(in More tab)*
- **6-month bar chart** — income vs expense side by side
- **Expense pie chart** — breakdown by category with percentage labels
- Navigate month by month
- Summary cards: Income, Expense, Net

### 🔁 Recurring Payments *(bottom bar tab)*
- Split into two tabs: **Expenses** and **Income**
- Track both recurring costs (subscriptions, rent, instalments) and recurring income (salary, freelance)
- Frequency: every X **days / weeks / months / years**
- **First Payment** date + optional **Last Payment** date
- When Last Payment is set: total payment count + total cost calculated (inclusive, both ends)
- **Monthly and Weekly** cost estimates shown as summary cards per tab
- Select account using **horizontal colour cards**
- Select category using **coloured pill chips**
- Actions per payment: **Pay** (records transaction + advances date), **Skip** (advances count without touching balance), **Edit**, **Delete**
- Progress bar showing paid vs remaining; overdue badge if past due date

### ⭐ Wishlist
- Track items with a **target price** and **priority** (Low / Medium / High)
- Mark items as purchased
- Add notes

### 🤝 Lent Money
- Track money **lent** to or **borrowed** from someone
- Link to an account using **colour cards** with a "None" option
- Account balance automatically adjusted when linked
- Set a due date and notes
- **Settle** reverses the balance effect

### 🏷️ Categories
- Default categories for income and expense — all editable and deletable
- Add custom categories with a name and colour (12 colour options)

### 📤 Export Transactions
- Choose a **From → To date range** to filter which transactions to export
- Exports as **Excel (.xlsx)** with bold headers
- **File picker** lets you choose exactly where to save on your device
- Columns: Date, Description, Type, Amount, Account, Category, Note

### 💾 Backup & Restore
- **Full JSON backup** of all data (accounts, transactions, categories, recurring, wishlist, lent, settings)
- **File picker** to choose where to save
- **Restore** from any `.json` backup file — replaces all current data after a confirmation prompt

### ⚙️ Settings

**Theme mode** — 4 options in a 2×2 grid:
- **Follow System** — auto light/dark based on device setting
- **Light Mode** — always light
- **Dark Mode** — always dark  
- **Black AMOLED** — true `#000000` background for OLED displays

**Accent colour** — 29 seeds displayed as coloured dots:  
Violet, Blue, Green, Rose, Amber, Teal, Orange, Indigo, Cyan, Pink, Lime, Deep Purple, Crimson, Midnight, Forest, Mint, Olive, Sage, Sky Blue, Navy, Cobalt, Ocean, Coral, Gold, Slate, Magenta, Turquoise, Brown, Lavender  

**Currency** — searchable dialog (search by code or name) across **64 currencies**:
- Global, Middle East & North Africa, Sub-Saharan Africa, Asia, Europe

**Other preferences:**
- Week starts on Monday or Sunday
- **Hide Balance** — shows •••••• throughout the app
- Edit your display name

### 🎨 App Icon
- 3D wallet illustration with white background
- **Adaptive icon** — correct shape on all Android launchers (circle, squircle, rounded square, square)
- **Themed icon (Android 13+)** — outline silhouette automatically recoloured to match your wallpaper palette

---

## Screenshots

| Home | Transactions | Recurring |
|------|-------------|-----------|
| ![Home](screenshots/home.png) | ![Transactions](screenshots/transactions.png) | ![Recurring](screenshots/recurring.png) |

| Accounts | Lent Money | Transfer |
|----------|-----------|---------| 
| ![Accounts](screenshots/accounts.png) | ![Lent](screenshots/lent.png) | ![Transfer](screenshots/transfer.png) |

| Statistics | Wishlist | Settings |
|-----------|---------|---------| 
| ![Statistics](screenshots/statistics.png) | ![Wishlist](screenshots/wishlist.png) | ![Settings](screenshots/settings.png) |

| Add Transaction | Categories | Onboarding |
|----------------|-----------|-----------| 
| ![Add](screenshots/add_transaction.png) | ![Categories](screenshots/categories.png) | ![Onboarding](screenshots/onboarding.png) |

---

## Navigation

```
Bottom bar:  Home · Transactions · Recurring · Accounts · More
More tab:    Statistics · Wishlist · Lent Money · Categories · Export · Backup & Restore · Settings
```

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| **Framework** | Flutter 3.3+ |
| **Language** | Dart 3.3+ |
| **Database** | sqflite — local SQLite (v2, WAL mode) |
| **State** | provider (ChangeNotifier) |
| **Charts** | fl_chart |
| **Excel Export** | excel ^4.0.6 |
| **File I/O** | file_picker ^8.1.2 |
| **Preferences** | shared_preferences |
| **Date Formatting** | intl |
| **UUIDs** | uuid ^4.5.0 |

No internet permission. All data lives in a local SQLite database (`expensy.db`).

---

## Project Structure

```
lib/
├── main.dart                       # Entry point, loading screen, MaterialApp theme wiring
├── models/models.dart              # 6 data classes: Account, AppCategory, AppTransaction,
│                                   #   RecurringPayment, WishlistItem, LendedMoney
├── database/db_helper.dart         # SQLite CRUD for all 6 tables + backup import/export
├── providers/app_provider.dart     # AppProvider (ChangeNotifier) + AppSettings
├── theme/app_theme.dart            # buildTheme(), resolveThemeMode(), 29 seed colours,
│                                   #   64 currencies, formatAmount()
├── widgets/shared_widgets.dart     # EmptyState, CategoryDot, AccountCardPicker,
│                                   #   CategoryChipPicker, showCurrencyPicker, etc.
└── screens/
    ├── main_shell.dart             # IndexedStack bottom nav (5 tabs)
    ├── home_screen.dart            # Dashboard — compact header, balance, summary chips
    ├── accounts_screen.dart        # Account list + add/edit sheet (type cards, currency dialog)
    ├── add_transaction_screen.dart # Add / edit a transaction
    ├── transactions_screen.dart    # Transaction history — search, filter, grouped by date
    ├── recurring_screen.dart       # Tabbed Expenses / Income recurring payments
    ├── transfer_screen.dart        # Account-to-account transfer
    ├── more_screen.dart            # Hub screen for secondary features
    ├── statistics_screen.dart      # Bar chart + pie chart per month
    ├── categories_screen.dart      # Category management
    ├── wishlist_screen.dart        # Wishlist tracker
    ├── lended_screen.dart          # Lent / borrowed money tracker
    ├── export_screen.dart          # Excel export with date range + file picker
    ├── backup_screen.dart          # Full JSON backup & restore
    ├── settings_screen.dart        # Theme, accent, currency, preferences
    └── onboarding_screen.dart      # 3-step first-launch setup
```

---

## Building from Source

### Prerequisites

| Tool | Version | Download |
|------|---------|---------|
| Flutter SDK | 3.3+ | [flutter.dev](https://flutter.dev/docs/get-started/install) |
| Android Studio | Latest | [developer.android.com/studio](https://developer.android.com/studio) |
| Java JDK | 11+ | [adoptium.net](https://adoptium.net/) |

```bash
flutter doctor
```

### Steps

```bash
# 1. Clone
git clone https://github.com/yourusername/expensy.git
cd expensy

# 2. Install dependencies
flutter pub get

# 3. Run in development
flutter run

# 4. Build release APK
flutter build apk --release

# Split by CPU architecture (smaller files, recommended)
flutter build apk --split-per-abi --release
```

Output: `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk`

---

## Installation

1. Go to [**Releases**](https://github.com/mina-android/expensy/releases)
2. Download `app-release.apk`
3. On your phone: **Settings → Security → Install Unknown Apps** → enable for your file manager
4. Open the APK and install

> Minimum Android: **5.0 (API 21)**

---

## Gradle / Build Config

| Component | Version |
|-----------|---------|
| Gradle | **8.11.1** |
| Android Gradle Plugin | 8.7.3 |
| Kotlin | 2.1.0 |
| Java | 11 |
| Package | `com.ma.expensy` |
| Min SDK | 21 (Android 5.0) |

> **Important:** Gradle 9.x causes a `BuildOperationDescriptor.metadata()` crash with Kotlin 2.1.0. Stay on 8.11.1.

---

## Data & Privacy

- ✅ Zero internet permission
- ✅ No accounts, no sign-up, no sync
- ✅ No analytics, no crash reporting, no telemetry
- ✅ No ads
- ✅ All data in local SQLite on your device
- ✅ Backup is a plain JSON file you fully control
- ✅ Uninstalling deletes all data — nothing left behind

---

## Troubleshooting

**`flutter pub get` fails**
```bash
flutter clean && flutter pub get
```

**Gradle build fails (`BuildOperationDescriptor` error)**  
Ensure `gradle-wrapper.properties` uses Gradle 8.11.1, not 9.x:
```properties
distributionUrl=https\://services.gradle.org/distributions/gradle-8.11.1-bin.zip
```

**Gradle build fails on Windows (different drive letters)**  
Add to `android/gradle.properties`:
```properties
kotlin.incremental=false
org.gradle.configuration-cache=false
```
Then `flutter clean && flutter run`.

**Accept Android SDK licenses**
```bash
flutter doctor --android-licenses
```

---

## .gitignore

```gitignore
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
build/
*.iml
android/.gradle/
android/local.properties
android/key.properties
*.jks
*.keystore
.idea/
.vscode/
.DS_Store
```

---


## Contributing

1. Fork the repository
2. Create a branch: `git checkout -b feature/my-feature`
3. Commit: `git commit -m "Add my feature"`
4. Push: `git push origin feature/my-feature`
5. Open a Pull Request

Code style: no `withOpacity()` (use `withValues(alpha:)`), `heroTag: null` on all FABs, `context.read<AppProvider>()` in callbacks not `widget.app`, `flutter analyze` must pass.

---

## License

MIT License — Copyright (c) 2026 Mina

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

---

<div align="center">

Made with ❤️ and Flutter · **[⬆ Back to top](#expensy)**

</div>
