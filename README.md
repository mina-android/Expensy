<div align="center">

<img src="assets/splash_icon.png" alt="Expensy Logo" width="120" height="120" style="border-radius: 24px"/>

# Expensy

### Your personal, fully offline finance tracker

[![Flutter](https://img.shields.io/badge/Flutter-3.3%2B-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.3%2B-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Android](https://img.shields.io/badge/Android-5.0%2B-3DDC84?logo=android&logoColor=white)](https://android.com)
[![Version](https://img.shields.io/badge/Version-1.0.4-brightgreen)](https://github.com/mina-android/Expensy/releases)
[![License](https://img.shields.io/badge/License-MIT-blue)](LICENSE)

**Expensy** is a clean, fast, and fully offline expense manager built with Flutter.  
No accounts. No cloud. No ads. Your data stays on your device — always.

[**Download APK**](#installation) · [**Features**](#features) · [**Screenshots**](#screenshots) · [**Build It**](#building-from-source)

</div>

---

## Why Expensy?

Most finance apps require you to sign up, sync to the cloud, or show ads. Expensy does none of that. It stores everything locally using SQLite, works fully offline, and respects your privacy completely. Exchange rates and gold prices are fetched from free public APIs once a day — the rest needs no internet at all.

---

## Features

### 💰 Accounts
- Add unlimited accounts: **Bank**, **Cash**, **Savings**, **Credit Card**, **E-Wallet**, **Gold**
- Account type selected via **pill cards** — not a dropdown
- Each account has its own **currency** chosen from a searchable dialog of **65 currencies**
- Pick from **24 custom colours** (horizontally scrollable)
- **Exclude from Total Balance** toggle — hide investment accounts from the home screen total
- See balance, total income, total expense, and transaction count per account
- Edit or delete any account

### 🥇 Gold Accounts
- Track physical gold holdings by **karat** (24 / 22 / 21 / 18 / 14 / 10 / 9) and **grams**
- Balance is **automatically calculated** from live XAU spot rates — no manual entry
- Live **value preview** while entering karat and grams in the add/edit sheet
- Account cards show a **`"Xk · Y.YY g"` badge** and a dedicated stats row: Value / Karat / Weight / Per gram
- Gold accounts are automatically excluded from transfers, transactions, recurring, and lend pickers

### 📝 Transactions
- Add **income** and **expense** transactions
- Select account using **scrollable colour cards** (gold accounts excluded)
- Choose the **transaction currency** independently from the account currency — the balance delta is converted automatically via live rates
- Assign to any category using **coloured pill chips**
- Description is optional; add an optional note
- Full-text **search** and filter chips by type or account
- Grouped by date (Today, Yesterday, full date)
- Tap to edit, long-press to delete

### 🔄 Account Transfers
- Transfer between accounts using **FROM and TO card rows** (gold accounts excluded)
- **Cross-currency transfers** — when accounts use different currencies, a live conversion preview shows exactly how much the destination account will receive
- Auto-records a debit and a credit transaction, each tagged with its account's currency

### 📊 Statistics *(in More tab)*
- **6-month bar chart** — income vs expense side by side
- **Expense pie chart** — breakdown by category with percentage labels
- Navigate month by month with summary cards: Income, Expense, Net

### 🔁 Recurring Payments *(bottom bar tab)*
- Split into two tabs: **Expenses** and **Income**
- Track subscriptions, rent, instalments, salary, freelance income, and more
- Frequency: every X **days / weeks / months / years**
- **First Payment** date + optional **Last Payment** date
- Monthly and Weekly cost estimates shown as summary cards per tab
- Actions per payment: **Pay** (records transaction + advances date), **Skip** (advances count, no balance change), **Edit**, **Delete**
- Progress bar showing paid vs remaining; overdue badge if past due date
- **On-day reminder notification** — get notified on the payment due date at a time you choose
- **2-day advance reminder** — optional second notification fires 2 days before the due date
- Reminder badges shown on each card (bell icon + time, advance badge if enabled)

### 📈 Exchange Rates & Gold Prices
- **Daily rate fetch** from `open.er-api.com` (free, no API key needed)
- **Gold (XAU) price** fetched separately from the fawaz currency API, with automatic fallback URL
- **24-hour cache** — stale rates served immediately while a background refresh runs; works fully offline with cached data
- **Rates banner** in the Accounts screen: shows last-updated time, a fetching spinner, or an offline warning
- **↺ Sync button** in the Accounts AppBar (visible only when you have multi-currency accounts)
- Account totals and asset values are automatically converted to your main currency using live rates

### 📦 Assets
- Track physical and financial assets: property, vehicles, electronics, investments, collectibles
- Each asset has a **name**, **value**, **currency**, and optional **notes**
- Total asset value converted to your main currency using live exchange rates
- Accessible from the **More tab**
- Fully included in backup and restore

### ⭐ Wishlist
- Track items with a **target price** and **priority** (Low / Medium / High)
- Mark items as purchased
- Add notes

### 🤝 Lent Money
- Track money **lent** to or **borrowed** from someone
- Link to an account (gold accounts excluded) with a "None" option
- Account balance automatically adjusted when linked
- Set a due date and notes
- **Settle** reverses the balance effect
- Summary bar shows: They Owe Me / I Owe Them / Net

### 🏷️ Categories
- Default categories for income and expense — all editable and deletable
- Add custom categories with a name and colour

### 📤 Export Transactions
- Choose a **From → To date range** to filter which transactions to export
- Exports as **Excel (.xlsx)** with bold headers
- Columns: Date, Description, Type, Amount, **Currency**, Account, Category, Note
- **File picker** lets you choose exactly where to save on your device

### 💾 Backup & Restore
- **Full JSON backup** — accounts, transactions, categories, recurring, wishlist, lent, **assets**, settings
- **File picker** to choose where to save — no share sheet
- Live item counts for all 8 categories shown before backing up
- **Restore** from any `.json` backup file — old backup versions are automatically upgraded to the current schema
- Shows upgrade label when restoring from an older version (e.g. `upgraded from v3 → v7`)
- Invalid files detected and rejected with a clear error message

### ⚙️ Settings

**Theme mode** — 4 options in a 2×2 grid:
- **Follow System** — auto light/dark based on device setting
- **Light Mode** — always light
- **Dark Mode** — always dark
- **Black AMOLED** — true `#000000` background for OLED displays

**Accent colour** — 29 seeds displayed as coloured dots:  
Violet, Blue, Green, Rose, Amber, Teal, Orange, Indigo, Cyan, Pink, Lime, Deep Purple, Crimson, Midnight, Forest, Mint, Olive, Sage, Sky Blue, Navy, Cobalt, Ocean, Coral, Gold, Slate, Magenta, Turquoise, Brown, Lavender

**Currency** — searchable dialog (search by code or name) across **65 currencies**:
Global, Middle East & North Africa, Sub-Saharan Africa, Asia, Europe (includes GEL Georgian Lari)

**Other preferences:**
- Week starts on Monday or Sunday
- **Hide Balance** — shows •••••• throughout the app
- Edit your display name

**About:**
- Version badge, Privacy confirmation
- **GitHub** — view source code (`https://github.com/mina-android/Expensy`)
- **Developer** — discover more projects by Mina Android (`https://github.com/mina-android`)

### 🎨 App Icon
- 3D wallet illustration
- **Adaptive icon** — correct shape on all Android launchers (circle, squircle, rounded square, square)
- **Themed icon (Android 13+)** — outline silhouette automatically recoloured to match your wallpaper palette (uses a separate `ic_launcher_monochrome` asset, correctly inset for the adaptive icon system)
- **Notification icon** — dedicated `ic_notification` asset sized to fill the status bar slot at all screen densities (mdpi → xxxhdpi)

---

## Screenshots

> Place your screenshots in `screenshots/` with the filenames below.

| Home | Transactions | Recurring |
|------|-------------|-----------|
| ![Home](screenshots/home.png) | ![Transactions](screenshots/transactions.png) | ![Recurring](screenshots/recurring.png) |

| Accounts | Lent Money | Transfer |
|----------|-----------|---------| 
| ![Accounts](screenshots/accounts.png) | ![Lent](screenshots/lent.png) | ![Transfer](screenshots/transfer.png) |

| Statistics | Wishlist | Settings |
|-----------|---------|---------| 
| ![Statistics](screenshots/statistics.png) | ![Wishlist](screenshots/wishlist.png) | ![Settings](screenshots/settings.png) |

| Add Transaction | Assets | Onboarding |
|----------------|-------|-----------| 
| ![Add](screenshots/add_transaction.png) | ![Assets](screenshots/assets.png) | ![Onboarding](screenshots/onboarding.png) |

---

## Navigation

```
Bottom bar:  Home · Transactions · Recurring · Accounts · More
More tab:    Statistics · Wishlist · Lent Money · Assets · Categories · Export · Backup & Restore · Settings
```

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| **Framework** | Flutter 3.3+ |
| **Language** | Dart 3.3+ |
| **Database** | sqflite — local SQLite (v7, WAL mode) |
| **State** | provider (ChangeNotifier) |
| **Charts** | fl_chart |
| **Excel Export** | excel ^4.0.6 |
| **File I/O** | file_picker ^8.1.2 |
| **Preferences** | shared_preferences |
| **Date Formatting** | intl |
| **UUIDs** | uuid ^4.5.0 |
| **Exchange Rates** | http ^1.2.0 — open.er-api.com + fawaz currency API |
| **Notifications** | flutter_local_notifications ^18.0.0 + timezone ^0.9.4 |
| **External Links** | url_launcher ^6.3.0 |

Exchange rates and gold prices are fetched once a day and cached locally. All financial data lives in a local SQLite database (`expensy.db`). The app works fully without internet using cached rates.

---

## Project Structure

```
lib/
├── main.dart                       # Async entry point — awaits NotificationService.initialize()
│                                   #   and provider.load() before runApp(); no loading screen
├── models/models.dart              # 7 data classes: Account (+ gold fields), AppCategory,
│                                   #   AppTransaction (+ currency), RecurringPayment
│                                   #   (+ reminderTime, earlyReminderEnabled),
│                                   #   WishlistItem, LendedMoney, AssetItem
├── database/db_helper.dart         # SQLite v7 CRUD for all 7 tables + backup import/export
│                                   #   + _normaliseBackup() for safe cross-version restore
├── providers/app_provider.dart     # AppProvider (ChangeNotifier) + AppSettings
│                                   #   + exchange rate state + gold balance refresh
├── services/
│   ├── exchange_rate_service.dart  # Fetch/cache daily rates (USD pivot) + XAU gold price
│   └── notification_service.dart  # Schedule/cancel exact-alarm reminders; 2-day advance
├── theme/app_theme.dart            # buildTheme(), resolveThemeMode(), 29 seed colours,
│                                   #   65 currencies, formatAmount()
├── widgets/shared_widgets.dart     # EmptyState, CategoryDot, AccountTypeIcon (incl. gold),
│                                   #   AccountCardPicker, CategoryChipPicker,
│                                   #   showCurrencyPicker, etc.
└── screens/
    ├── main_shell.dart             # IndexedStack bottom nav (5 tabs)
    ├── home_screen.dart            # Dashboard — balance, gold sub-labels, summary chips
    ├── accounts_screen.dart        # Account list + rates banner + sync button + gold sheet
    ├── add_transaction_screen.dart # Add / edit a transaction with per-tx currency picker
    ├── transactions_screen.dart    # Transaction history — search, filter (incl. Lent & Borrowed)
    ├── recurring_screen.dart       # Tabbed recurring payments + notification reminders
    ├── transfer_screen.dart        # Cross-currency account transfer with conversion preview
    ├── more_screen.dart            # Hub screen for secondary features
    ├── statistics_screen.dart      # Bar chart + pie chart per month
    ├── categories_screen.dart      # Category management
    ├── wishlist_screen.dart        # Wishlist tracker
    ├── lended_screen.dart          # Lent / borrowed money tracker
    ├── assets_screen.dart          # Asset tracker (property, investments, etc.)
    ├── export_screen.dart          # Excel export with date range + Currency column
    ├── backup_screen.dart          # Full JSON backup & restore with live counts
    ├── settings_screen.dart        # Theme, accent, currency, preferences, About links
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
git clone https://github.com/mina-android/Expensy.git
cd Expensy

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

1. Go to [**Releases**](https://github.com/mina-android/Expensy/releases)
2. Download `app-release.apk`
3. On your phone: **Settings → Security → Install Unknown Apps** → enable for your file manager
4. Open the APK and install

> Minimum Android: **5.0 (API 21)**

---

## Gradle / Build Config

| Component | Version |
|-----------|---------|
| Gradle | **8.11.1** |
| Android Gradle Plugin | **8.9.1** |
| Kotlin | 2.1.0 |
| Java | 11 |
| Package | `com.ma.expensy` |
| Min SDK | 21 (Android 5.0) |

> **Gradle 9.x** causes a `BuildOperationDescriptor.metadata()` crash with Kotlin 2.1.0 — stay on 8.11.1.  
> **AGP 8.9.1** is required by `url_launcher_android` (pulls in `androidx.browser:1.9.0`).  
> **`flutter_timezone` must not be used** — incompatible with Kotlin 2.1.0. Timezone offset is computed via `DateTime.now().timeZoneOffset` instead.

---

## Android Permissions

| Permission | Purpose |
|-----------|---------|
| `INTERNET` | Fetch daily exchange rates and gold prices |
| `ACCESS_NETWORK_STATE` | Check connectivity before network calls |
| `POST_NOTIFICATIONS` | Show recurring payment reminders (Android 13+) |
| `SCHEDULE_EXACT_ALARM` | Precise notification timing (Android 12+) |
| `USE_EXACT_ALARM` | Default-granted exact alarm fallback (Android 13+) |
| `RECEIVE_BOOT_COMPLETED` | Reschedule reminders after device reboot |
| `READ_EXTERNAL_STORAGE` | File picker on Android ≤ 12 |
| `WRITE_EXTERNAL_STORAGE` | File save on Android ≤ 9 |
| `READ_MEDIA_IMAGES` | File picker on Android 13+ |

---

## Data & Privacy

- ✅ All financial data stored locally in SQLite — never leaves your device
- ✅ Exchange rates and gold prices fetched from free public APIs (no account, no key)
- ✅ No analytics, no crash reporting, no telemetry
- ✅ No ads
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

**Notifications not firing**  
Go to system Settings → Apps → Expensy → Notifications and ensure notifications are allowed. On Android 12+, also check that "Alarms & Reminders" permission is granted.

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

## Roadmap

- [ ] iOS support
- [ ] Home screen widget (current balance)
- [x] Push notifications for recurring payments due
- [ ] Multiple languages / localisation
- [ ] Custom currency input
- [ ] Recurring payment auto-pay

---

## Contributing

1. Fork the repository
2. Create a branch: `git checkout -b feature/my-feature`
3. Commit: `git commit -m "Add my feature"`
4. Push: `git push origin feature/my-feature`
5. Open a Pull Request

Code style: no `withOpacity()` (use `withValues(alpha:)`), `heroTag: null` on all FABs, `context.read<AppProvider>()` in callbacks, `flutter analyze` must pass.

---

## License

MIT License — see [LICENSE](LICENSE) for full text.  
Copyright © 2026 [Mina Android](https://github.com/mina-android)

---

<div align="center">

Made with ❤️ and Flutter · [**More projects by Mina Android**](https://github.com/mina-android) · [**⬆ Back to top**](#expensy)

</div>
