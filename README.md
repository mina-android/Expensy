<div align="center">

<img src="assets/splash_icon.png" alt="Expensy Logo" width="120" height="120" style="border-radius: 24px"/>

# Expensy

### A finance tracker that stays on your phone, not in the cloud

[![Flutter](https://img.shields.io/badge/Flutter-3.3%2B-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Android](https://img.shields.io/badge/Android-5.0%2B-3DDC84?logo=android&logoColor=white)](https://android.com)
[![Version](https://img.shields.io/badge/Version-1.1.0-brightgreen)](https://github.com/mina-android/Expensy/releases)
[![License](https://img.shields.io/badge/License-MIT-blue)](LICENSE)

No sign-up. No cloud sync. No ads. Your data lives on your device and nowhere else.

[**Download**](#-installation) · [**Features**](#-features) · [**Screenshots**](#-screenshots) · [**Build from Source**](#-build-from-source)

</div>

---

## Why I built this

I got tired of finance apps that ask for an account before they'll even let you add a transaction, then quietly sync everything to a server somewhere. Expensy doesn't do any of that. There's no login screen, no backend, no analytics SDK phoning home. It's just a local SQLite database on your phone. The only time it touches the network is to fetch exchange rates and the day's gold price — everything else, from your account balances to your spending history, never leaves the device. Uninstall the app and there's nothing left behind to "delete your data" from, because it was never anywhere else to begin with.

---

## ✨ What's in it

I've tried to make this a genuinely complete money app rather than just a transaction logger:

- **Accounts** for however you actually keep money — bank, cash, savings, credit card, e-wallet, or gold — each with its own currency, and you can drag them into whatever order makes sense to you
- **Linked cards**, so a credit or debit card can sit under a parent bank account and roll up into one total instead of being tracked separately
- **Gold accounts** that value themselves automatically from live gold prices, tracked by karat and grams
- A unified **transaction list** — income, expenses, and lent/borrowed money all in one chronological view, with search, filters, swipe-to-delete, bulk selection, and tap-to-edit
- **Transfers** between accounts with automatic currency conversion baked in
- **Recurring payments** for subscriptions, installments, rent, salary — with reminders and a full payment history
- **Budgets**, monthly or weekly, per category, with progress bars and a push notification the moment you go over
- **Statistics & Insights** — charts, trends, month-over-month comparisons, the stuff that actually tells you where your money went
- A built-in **currency converter** using live rates
- **Savings goals** you can contribute to or withdraw from, with a nudge when you hit the target
- **Assets & a wishlist**, for tracking what you own and what you're saving up for
- **Lent & borrowed money**, so you can actually remember who owes who, with due-date reminders
- **Yearly Analysis** — a 24-month planned cash flow forecast for recurring income, expenses, loans, and lent/borrowed due dates
- An optional **nightly reminder** if you haven't logged anything that day
- **Backup & restore** to a single JSON file that's entirely yours — and if you're coming from GreenStash, it can import your data directly
- A UI that's meant to feel fast — smooth at 120Hz even with a few thousand transactions sitting in the list

And because a finance app is something you'll look at every day, I spent real time on how it looks: a sleek **floating Material 3 navigation bar**, Material You theming, 29 accent colors, 10 fonts, a proper AMOLED dark mode, and a few home-screen widgets (quick-add, accounts, budget progress) so you don't always have to open the app just to log something.

---

## 📸 Screenshots

<div align="center">
  <img src="screenshots/home.png" width="32%" alt="Home" />
  <img src="screenshots/transactions.png" width="32%" alt="Transactions" />
  <img src="screenshots/recurring.png" width="32%" alt="Recurring" />
  <br>
  <img src="screenshots/accounts.png" width="32%" alt="Accounts" />
  <img src="screenshots/budgets.png" width="32%" alt="Budgets" />
  <img src="screenshots/statistics.png" width="32%" alt="Statistics" />
</div>

---

## 🌍 Localization

I wanted this to feel native for more than just English speakers, so it's currently translated into 11 languages (see `lib/l10n/`):

🇺🇸 English · 🇪🇸 Spanish · 🇸🇦 Arabic (with RTL support) · 🇫🇷 French · 🇩🇪 German · 🇮🇳 Hindi · 🇮🇹 Italian · 🇯🇵 Japanese · 🇵🇹 Portuguese · 🇷🇺 Russian · 🇨🇳 Chinese

Some of these are more complete than others — check the `.arb` files under `lib/l10n/` if you're curious how far along a given language is. If you speak one of these natively and something reads awkwardly, a PR fixing it would genuinely make the app better for someone. See [Contributing](#-contributing).

---

## 📲 Installation

1. Grab the latest APK from [**Releases**](https://github.com/mina-android/Expensy/releases)
2. Enable **Install Unknown Apps** for your file manager (Settings → Security)
3. Open the APK and install it

That's it — no account to create. Requires Android 5.0 or newer.

---

## 🛠 Build from Source

**Prerequisites:** [Flutter SDK 3.3+](https://flutter.dev/docs/get-started/install), Java JDK 11+

```bash
git clone https://github.com/mina-android/Expensy.git
cd Expensy
flutter pub get
flutter run

# Signed release APK (universal)
flutter build apk --release

# Signed split-per-ABI APKs (smaller download per architecture)
flutter build apk --split-per-abi --release

# Signed Play Store bundle
flutter build appbundle --release
```

If `android/key.properties` is present, release builds automatically pick it up and sign with `expensy.jks`. You'll find the output in `build/app/outputs/flutter-apk/` (`app-release.apk`, `app-arm64-v8a-release.apk`, ...) and `build/app/outputs/bundle/release/` (`app-release.aab`).

<details>
<summary><strong>Running into build trouble?</strong></summary>

- **`flutter pub get` fails:** `flutter clean && flutter pub get`
- **Gradle errors:** make sure `gradle-wrapper.properties` points at Gradle **8.11.1**, not 9.x
- **Weird path/drive-letter errors on Windows:** add `kotlin.incremental=false` and `org.gradle.configuration-cache=false` to `android/gradle.properties`
- **Missing SDK licenses:** `flutter doctor --android-licenses`
- **Notifications not firing:** check Settings → Apps → Expensy → Notifications, and don't forget "Alarms & Reminders" on Android 12+

</details>

---

## 🔒 Privacy, actually

- Everything is stored locally in SQLite — nothing ever leaves your device
- Exchange rates come from free public APIs that don't need a key or an account
- No analytics, no crash reporting, no ads, no trackers of any kind
- Backups are plain JSON files that live wherever you put them, not on some server
- Uninstall the app and it's genuinely gone — there's nothing left in a cloud somewhere to worry about

---

## 🗺 Roadmap

- [ ] iOS support
- [x] Home screen widgets (quick-add, add transaction, accounts, budget progress)
- [x] Multiple languages (11 and counting)
- [ ] Recurring payment auto-pay
- [x] Budgets per category
- [x] Savings goals
- [x] Loans with reminders
- [x] Push notifications for recurring payments and lent/borrowed money

---

## 🤝 Contributing

1. Fork the repo
2. Create a branch: `git checkout -b feature/my-feature`
3. Commit and push your changes
4. Open a Pull Request

Please run `flutter analyze` before submitting — keeps the diff clean for review.

---

## License

MIT License — see [LICENSE](LICENSE) for details.
Copyright © 2026 [Mina Android](https://github.com/mina-android)

<div align="center">

Made with ❤️ and Flutter · [**More projects**](https://github.com/mina-android)

</div>
