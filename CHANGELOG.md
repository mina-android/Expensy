# Changelog

All notable changes to Expensy are documented in this file.

---

## [1.0.2] — 2025-05-06

### Added
- **Themed monochrome icon (Android 13+)** — Expensy now ships an `ic_launcher_monochrome` layer using a clean wallet outline silhouette. On Android 13+ with Themed Icons enabled, the launcher automatically recolours the icon to match your wallpaper palette
- **Adaptive icon — all density buckets** — Monochrome layer generated at all 5 density sizes (mdpi → xxxhdpi) at 32/108dp fill ratio
- **Account cards in Recurring Payments** — Account selection in the add/edit sheet replaced with horizontal scrollable coloured cards
- **Account cards in Lent Money** — Card-based account picker (includes a "None" card for optional linking)
- **Account cards in Transfer** — FROM and TO each have their own horizontal card row; same-as-FROM account is dimmed and non-tappable
- **Category chips in Recurring Payments** — Coloured pill chips in a wrapping layout replace the category dropdown
- **24 account colours** — Colour picker expanded from 8 to 24 colours

### Changed
- **App icon** — New 3D wallet PNG with white background, 45/108dp fill ratio, +1px right / −1px up offset
- **Splash screen** — Icon shown directly on app surface, no background container
- **Onboarding welcome** — Icon shown without a background container, same as splash
- **Navigation restructured** — Bottom bar: Home · Transactions · **Recurring** · Accounts · More. Statistics moved to the More tab
- **Recurring — Monthly/Weekly** — Moved from inside the AppBar into two separate summary cards below the title bar
- **Skip button** — Now increments `paidPayments` (advances progress bar) without touching the account balance or recording a transaction
- **Description field** — No longer required when adding a transaction
- **Colour picker scrollable** — All 24 account colours now horizontally scrollable; no longer clipped on small screens
- **Version** — Bumped to `1.0.2+3`

### Fixed
- Account colour picker clipped on narrow screens — wrapped in `SingleChildScrollView`
- Monthly/Weekly estimates were inside the AppBar rectangle; now below it

---

## [1.0.1] — 2025-05-05

### Added
- **Account currency** — each account has its own independent currency setting
- **10 new theme colours** — total 25: Sky Blue, Forest, Coral, Gold, Slate, Magenta, Turquoise, Brown, Olive, Lavender
- **Account cards in Add Transaction** — horizontal scrollable cards replace the account dropdown

### Changed
- **Dark mode on by default** — new installs start in dark mode
- **"Hi, [name]" greeting** — font size 14 → 22px, weight w500 → w800
- **Recurring payment cards** — padding 16 → 20px, icon 44 → 50px, fonts larger
- **App icon** — updated to new 3D wallet PNG with white background
- **Version** — bumped to `1.0.1+2`

### Fixed
- Monthly/Weekly estimates in Recurring header slightly top-aligned; now centred

---

## [1.0.0] — 2025-05-03

### Initial Release

#### Core features
- Multi-account management (Bank, Cash, Savings, Credit Card, E-Wallet; custom colours)
- Transactions — add, edit, delete, search, filter by type/account, grouped by date
- Account transfers — live balance preview, auto debit + credit records
- Statistics — 6-month bar chart, expense pie chart, month navigation
- Recurring payments — First/Last payment dates, inclusive count, skip, pay, edit, delete
- Wishlist — target price, priority, mark purchased
- Lent Money — lent/borrowed, link account, due dates, settle
- Categories — custom income/expense categories, colour picker, default categories editable
- Export — CSV via share sheet
- Backup & Restore — full JSON backup

#### Settings
- Dark mode, 15 theme colours, 8 currencies, per-account currency, week start day, hide balance, display name

#### Technical
- 100% offline, SQLite, Material You, Provider state management
- Adaptive launcher icon, `com.ma.expensy`, min Android 5.0 (API 21)
