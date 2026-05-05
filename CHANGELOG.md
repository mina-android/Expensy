# Changelog

All notable changes to Expensy are documented in this file.

---

## [1.0.1] — 2025-05-05

### Added
- **Account currency** — each account now has its own independent currency setting; choose it when creating or editing an account (`Accounts → + / Edit`)
- **10 new theme colours** — total themes expanded from 15 to 25: Sky Blue, Forest, Coral, Gold, Slate, Magenta, Turquoise, Brown, Olive, Lavender
- **Account cards in Add Transaction** — instead of a dropdown, accounts are now shown as horizontal scrollable cards with their colour, name, and current balance; tap a card to select it

### Changed
- **Dark mode on by default** — new installs start in dark mode
- **"Hi, [name]" greeting** — font size increased from 14 to 22px (Bold) on the Home dashboard
- **Recurring payment cards** — larger padding (16 → 20px), bigger icon (44 → 50px), larger name font (15 → 17px) and amount font (12 → 14px)
- **Recurring app bar** — Monthly and Weekly estimates are now properly centred vertically in the app bar
- **Version** — bumped to `1.0.1+2`

### Fixed
- Monthly and Weekly estimates in the Recurring Payments header were slightly top-aligned; now centred

---

## [1.0.0] — 2025-05-03

### Initial Release

#### Core features
- **Multi-account management** — Bank, Cash, Savings, Credit Card, E-Wallet; custom colours
- **Transactions** — Add, edit, delete income and expense transactions; search and filter by type/account; group by date
- **Account transfers** — Move money between accounts with live balance preview; auto-records debit + credit
- **Statistics** — 6-month side-by-side bar chart (income vs expense); monthly expense pie chart; navigate by month
- **Recurring payments** — Track subscriptions and instalments; set First Payment / Last Payment dates; see total payments and total cost (inclusive count); frequency: days / weeks / months / years; Skip next payment; Pay (records expense); Edit; Delete; monthly + weekly estimate in header
- **Wishlist** — Track items to save for with target price and priority (Low / Medium / High); mark as purchased
- **Lent Money** — Track money lent or borrowed; link to account (balance affected automatically); due dates; settle (reverses balance); net summary
- **Categories** — Custom income and expense categories with colour picker; default categories editable and deletable
- **Export** — CSV export via system share sheet; compatible with Excel and Google Sheets
- **Backup & Restore** — Full JSON backup of all data; restore from file

#### Settings
- Dark mode toggle
- 15 theme colour seeds: Violet, Blue, Green, Rose, Amber, Teal, Orange, Indigo, Cyan, Pink, Lime, Deep Purple, Crimson, Midnight, Pitch Black
- 8 currency options: EGP, USD, EUR, GBP, SAR, AED, JPY, CAD
- Per-account currency
- Week starts on Monday or Sunday
- Hide balance (shows •••••• in dashboard)
- Display name

#### Technical
- 100% offline — no internet permission
- SQLite local database (`sqflite`)
- Material You design system with adaptive themes
- Provider state management
- Adaptive Android launcher icon (supports circle, squircle, square, and all launcher shapes)
- Custom app icon with light-blue background
- Package: `com.ma.expensy`
- Min Android: 5.0 (API 21)
