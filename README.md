<div align="center">

<img src="assets/splash_icon.png" alt="Expensy Logo" width="120" height="120" style="border-radius: 24px"/>

# Expensy

### Your personal, fully offline finance tracker

[![Flutter](https://img.shields.io/badge/Flutter-3.3%2B-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.3%2B-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Android](https://img.shields.io/badge/Android-5.0%2B-3DDC84?logo=android&logoColor=white)](https://android.com)
[![Version](https://img.shields.io/badge/Version-1.0.2-brightgreen)](https://github.com/yourusername/expensy/releases)
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
- Each account has its own **currency** (EGP, USD, EUR, GBP, SAR, AED, JPY, CAD)
- Pick from **24 custom colours**
- See balance, total income, total expense per account
- Edit or delete any account

### 📝 Transactions
- Add **income** and **expense** transactions
- Select account using **scrollable colour cards** (not a dropdown)
- Assign to any category; **description is optional**
- Full-text **search** and filter by type or account
- Grouped by date (Today, Yesterday, full date)

### 🔄 Account Transfers
- Transfer between your accounts using **FROM and TO card rows**
- FROM accounts shown on one line, TO accounts on the line below
- The same-as-FROM account is dimmed and non-selectable
- Live preview of both balances after transfer
- Auto-records a debit and a credit transaction

### 📊 Statistics *(in More tab)*
- **6-month bar chart** — income vs expense side by side
- **Expense pie chart** — breakdown by category
- Navigate month by month
- Summary cards: Income, Expense, Net

### 🔁 Recurring Payments *(bottom bar)*
- Track subscriptions, loan instalments, rent, any repeating payment
- Frequency: every X **days / weeks / months / years**
- **First Payment** date + optional **Last Payment** date
- When Last Payment is set: see total payment count and total cost (inclusive, both ends)
- **Monthly and Weekly** cost estimates shown as summary cards directly below the page title
- Select account using **horizontal colour cards**
- Select category using **coloured pill chips**
- Actions: **Pay** (records transaction), **Skip** (advances count without touching balance), **Edit**, **Delete**
- Progress bar showing paid vs remaining payments

### ⭐ Wishlist
- Track items with a **target price** and **priority** (Low / Medium / High)
- Mark items as **purchased**
- Add notes

### 🤝 Lent Money
- Track money **lent** to or **borrowed** from someone
- Link to an account using **colour cards** (optional — "None" card available)
- Account balance is automatically affected when linked
- Set a **due date** and notes
- **Settle** reverses the balance effect; net summary bar shows totals

### 🏷️ Categories
- Default categories for income and expense (editable and deletable)
- Add custom categories with a name and colour

### 📤 Export & Backup
- **Export transactions** to CSV via system share sheet
- **Full JSON backup** of all data
- **Restore** from any backup file

### ⚙️ Settings
- **Dark Mode** (on by default)
- **25 theme colours**: Violet, Blue, Green, Rose, Amber, Teal, Orange, Indigo, Cyan, Pink, Lime, Deep Purple, Crimson, Midnight, Pitch Black, Sky Blue, Forest, Coral, Gold, Slate, Magenta, Turquoise, Brown, Olive, Lavender
- **8 currencies**: EGP, USD, EUR, GBP, SAR, AED, JPY, CAD
- Per-account currency override
- Week starts on Monday or Sunday
- **Hide Balance** — shows •••••• on dashboard
- Edit your display name

### 🎨 App Icon
- 3D wallet illustration with white background
- **Adaptive icon** — correct shape on all Android launchers (circle, squircle, rounded square, square)
- **Themed icon (Android 13+)** — outline silhouette automatically recoloured to match your wallpaper palette

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

| Add Transaction | Categories | Onboarding |
|----------------|-----------|-----------|
| ![Add](screenshots/add_transaction.png) | ![Categories](screenshots/categories.png) | ![Onboarding](screenshots/onboarding.png) |

---

## Navigation

```
Bottom bar:  Home · Transactions · Recurring · Accounts · More
More tab:    Statistics · Wishlist · Lent Money · Categories · Export · Backup · Settings
```

---

## Installation

1. Go to [**Releases**](https://github.com/yourusername/expensy/releases)
2. Download `app-release.apk`
3. On your phone: **Settings → Security → Install Unknown Apps** → enable for your file manager
4. Open the APK and install

> Minimum Android: **5.0 (API 21)**

---

## Gradle / Build Config

| Component | Version |
|-----------|---------|
| Gradle | 9.5.0 |
| Android Gradle Plugin | 8.7.3 |
| Kotlin | 2.1.0 |
| Java | 11 |
| Package | `com.ma.expensy` |
| Min SDK | 21 (Android 5.0) |

---

## Data & Privacy

- ✅ Zero internet permission
- ✅ No accounts, no sign-up, no sync
- ✅ No analytics, no crash reporting, no telemetry
- ✅ No ads
- ✅ All data in local SQLite on your device
- ✅ Backup is a plain JSON file you control
- ✅ Uninstalling deletes all data — nothing left behind

---

## Contributing

1. Fork the repository
2. Create a branch: `git checkout -b feature/my-feature`
3. Commit: `git commit -m "Add my feature"`
4. Push: `git push origin feature/my-feature`
5. Open a Pull Request

Code style: no `withOpacity()` (use `withValues(alpha:)`), no unnecessary blank lines, `flutter analyze` must pass.

---

## License

MIT License — Copyright (c) 2026 Mina Ashraf

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

---

<div align="center">

Made with ❤️ and Flutter · **[⬆ Back to top](#expensy)**

</div>
