<div align="center">

<img src="assets/splash_icon.png" alt="Expensy Logo" width="112" height="112" />

# Expensy

[![Platform](https://img.shields.io/badge/Platform-Android-grey.svg?style=flat-square)](https://android.com) [![Release](https://img.shields.io/badge/Release-v1.2.3-blue.svg?style=flat-square)](https://github.com/mina-android/Expensy/releases) [![License](https://img.shields.io/badge/License-GPL--3.0-black.svg?style=flat-square)](LICENSE) [![Build](https://img.shields.io/badge/Build-Passing-brightgreen.svg?style=flat-square)](https://github.com/mina-android/Expensy/actions)

<p align="center">
  A local-first personal finance tracker and budget manager for Android that keeps all financial records, accounts, and transaction history strictly on your physical device.
</p>

</div>

---

## Navigation

[Features](#features) &bull; [Screenshots](#screenshots) &bull; [Downloads](#downloads) &bull; [Self Building & Local Setup](#self-building--local-setup) &bull; [Frequently Asked Questions](#frequently-asked-questions) &bull; [Contribution](#contribution) &bull; [About the Developer](#about-the-developer) &bull; [Donate](#donate) &bull; [License](#license)

---

## Features

### Core Capabilities

- **Account & Card Balance Management**: Manage liquid bank accounts, cash wallets, debit cards, credit cards, digital wallets, investments, and physical gold holdings. Debit cards inherit balances directly from linked bank accounts to prevent ledger duplication.
- **Categories & Subcategories**: Organize expenses and income with a clean `Parent › Subcategory` hierarchy, a two-tier progressive category picker, and automatic parent roll-up across budgets and reports.
- **Term Deposits & Certificates of Deposit**: Record fixed-term deposits with customizable yield collection frequencies (daily, monthly, yearly) crediting linked accounts automatically, complete with early redemption calculations.
- **Budgeting with Roll-Over Tracking**: Establish category or subcategory budgets where unused allocations carry forward into subsequent billing cycles, complemented by a Safe-to-Spend daily allowance pacer.
- **Fast Transaction Logging**: Register routine transactions using configurable one-tap presets, split transactions across multiple categories/subcategories, a dedicated `Transfer` category for internal transfers, and an integrated expression-evaluating numeric keypad.
- **Recurring Bills, Installments, Debt & Goals**: Track recurring subscriptions and installments (with background auto-pay and skip/pay progress tracking), incoming/outgoing loans, lent/borrowed contacts, wishlists, and savings goals.
- **Insights, Statistics & Expensy Wrapped**: Explore monthly spending trends, category-matched pie charts with subcategory drill-down, a financial calendar, and a story-style Expensy Wrapped summary.
- **Data Export, Encrypted Backups & Migration**: Export Excel (`.xlsx`) workbooks (with `Category` and `Subcategory` columns) and formatted PDF financial statements, create encrypted (`.enc`) or JSON backups with selective restore and scheduled SAF auto-backup, or migrate directly from **TrackWallet (`.csv`)** and **GreenStash (`.json`)**.
- **Multi-Language & Material You**: Supports Material You dynamic colors, pitch-black AMOLED mode, and 12 languages including English, Arabic, Bangla (`বাংলা`), French, German, Hindi, Spanish, Portuguese, Chinese, Japanese, Russian, and Italian.

### Architecture & Data Handling

- **Local-First Architecture**: All transactional ledgers, accounts, and preferences reside exclusively in an on-device SQLite database. No external account registration or cloud connectivity is required.
- **Zero Outbound Telemetry**: The application runs completely offline. No diagnostic events, behavioral metrics, or financial figures are transmitted across the network.
- **Resource Footprint**: Minimal storage footprint under 30 MB with near-instant startup times and zero persistent background services outside optional local notification triggers.

---

## Screenshots

<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="33.33%" align="center" valign="top">
      <img src="screenshots/home.png" alt="Home Overview" width="100%" />
    </td>
    <td width="33.33%" align="center" valign="top">
      <img src="screenshots/accounts.png" alt="Accounts & Cards" width="100%" />
    </td>
    <td width="33.33%" align="center" valign="top">
      <img src="screenshots/budgets.png" alt="Budgets & Goals" width="100%" />
    </td>
  </tr>
  <tr>
    <td width="33.33%" align="center" valign="top">
      <img src="screenshots/transactions.png" alt="Transaction History" width="100%" />
    </td>
    <td width="33.33%" align="center" valign="top">
      <img src="screenshots/recurring.png" alt="Recurring Payments" width="100%" />
    </td>
    <td width="33.33%" align="center" valign="top">
      <img src="screenshots/insights.png" alt="Financial Insights" width="100%" />
    </td>
  </tr>
  <tr>
    <td width="33.33%" align="center" valign="top">
      <img src="screenshots/financial_calendar.png" alt="Financial Calendar" width="100%" />
    </td>
    <td width="33.33%" align="center" valign="top">
      <img src="screenshots/currency_converter.png" alt="Currency Converter" width="100%" />
    </td>
    <td width="33.33%" align="center" valign="top">
      <img src="screenshots/more.png" alt="Settings & Data Management" width="100%" />
    </td>
  </tr>
</table>

---

## Downloads

Official release packages are published under the [GitHub Releases](https://github.com/mina-android/Expensy/releases) repository page.

| Platform | Architecture | Package Type | Download Link | Notes |
| :--- | :--- | :--- | :--- | :--- |
| **Android** | arm64-v8a | `.apk` | [Download (v1.2.3)](https://github.com/mina-android/Expensy/releases/latest) | Modern 64-bit devices (recommended) |
| **Android** | armeabi-v7a | `.apk` | [Download (v1.2.3)](https://github.com/mina-android/Expensy/releases/latest) | Legacy 32-bit devices |
| **Android** | x86_64 | `.apk` | [Download (v1.2.3)](https://github.com/mina-android/Expensy/releases/latest) | Android emulators and Intel-based tablets |
| **Android** | Universal | `.apk` | [Download (v1.2.3)](https://github.com/mina-android/Expensy/releases/latest) | Combined installer supporting all architectures |

---

## Self Building & Local Setup

### 1. Prerequisites

Ensure your development environment has the following software installed:

- **Flutter SDK**: `3.22.0` or higher (stable channel)
- **Dart SDK**: `3.4.0` or higher
- **Android SDK**: API level `34` (with Android Build Tools `34.0.0`)
- **Java Development Kit**: JDK `17`
- **Git**: `2.30+`

### 2. Repository Setup

```bash
# Clone the repository
git clone https://github.com/mina-android/Expensy.git

# Navigate into the project root
cd Expensy

# Verify Flutter environment
flutter doctor
```

### 3. Dependency Installation

```bash
# Fetch required Flutter and Dart dependencies
flutter pub get
```

### 4. Build Compilation

```bash
# Compile split per-ABI release APKs
flutter build apk --split-per-abi --release

# Or compile a single universal APK
flutter build apk --release
```

Compiled binaries will be generated inside `build/app/outputs/flutter-apk/`.

### 5. Running the Application Locally

```bash
# Connect a device or launch an emulator, then execute
flutter run --release
```

---

## Frequently Asked Questions

#### Where is my financial data stored?
All data is stored locally in an SQLite database file inside the application private directory on your device storage (`/data/user/0/com.ma.expensy/`). It is never synced to any remote server.

#### How do I transfer my records to a new phone or migrate from another app?
Navigate to **Settings → Backup & Restore** within Expensy. Generate an encrypted (`.enc`) or JSON backup, save the file to your external storage or transfer folder, and import it on your new phone (during Onboarding or from Backup & Restore). You can also import existing history from **TrackWallet (`.csv`)** or **GreenStash (`.json`)**.

#### How does balance inheritance work between Bank Accounts and Debit Cards?
When you link a Debit Card to a specific Bank Account, transactions recorded against the debit card deduct directly from the parent bank account balance. This accurately reflects real-world banking where debit cards do not maintain an independent balance ledger.

#### What happens if I delete an account with existing transactions?
The application prompts you to choose between archiving the account (which preserves historic transactional records and spending reports) or cascade-deleting linked transactions.

---

## Contribution

Contributions aimed at bug fixes, translation improvements, and performance optimizations are welcome.

### Contribution Process

1. **Check Issues**: Review existing GitHub Issues to verify whether a problem or enhancement is already documented.
2. **Open a Discussion**: For substantial structural or database schema alterations, open an issue first to discuss the design.
3. **Branching**: Branch off `main` using descriptive branch names (`fix/issue-description` or `feat/feature-name`).
4. **Code Quality**:
   - Ensure code passes static analysis: `flutter analyze`
   - Run unit and widget tests: `flutter test`
5. **Pull Request**: Open a pull request against `main` providing a clear breakdown of changes and relevant issue links.

---

## About the Developer

This project is authored and maintained by **mina-android**, focused on developing transparent, local-first Android utilities and privacy-conscious software.

- **Developer Portfolio**: [portfolio.minaashraf285.workers.dev](https://portfolio.minaashraf285.workers.dev/)
- **GitHub Profile**: [github.com/mina-android](https://github.com/mina-android)
- **Issue Tracker**: [github.com/mina-android/Expensy/issues](https://github.com/mina-android/Expensy/issues)

---

## Donate

Development and maintenance of this software are independent and self-supported. If this project helps you manage your finances reliably, consider supporting development:

- **PayPal**: [paypal.me/minaashraf285](https://paypal.me/minaashraf285)
- **GitHub Sponsors**: [github.com/sponsors/mina-android](https://github.com/sponsors/mina-android)

---

## License

Distributed under the **GNU General Public License v3.0**. See the [`LICENSE`](LICENSE) file in the root directory for the complete legal text.

```text
Copyright (c) 2026 mina-android
Licensed under the GNU General Public License v3.0.
```

---

<div align="center">
  <sub>Expensy &bull; Maintained by mina-android &bull; Local-first financial tracking for Android.</sub>
</div>
