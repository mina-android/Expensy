# Changelog

All notable changes to Expensy are documented in this file.

---

## [1.0.3] — 2026-05-11

### Added
- **Recurring Income** — Recurring Payments now supports both `expense` and `income` payment types. A type toggle (Expense / Income) is shown in the add/edit sheet
- **Tabbed Recurring screen** — The Recurring tab is split into two pages: **Expenses** and **Income**, each with its own count badge in the tab label. Summary cards (Monthly / Weekly) update per active tab. The FAB label changes to "Add Expense" or "Add Income" accordingly
- **64 currencies** — Currency list expanded from 8 to 64, covering Global, Middle East & North Africa, Sub-Saharan Africa, Asia, and Europe. All currencies are searchable by code or name
- **Searchable currency dialog** — Default currency in Settings now opens a searchable popup dialog instead of a dropdown. Account currency picker also uses this dialog
- **Account type as cards** — Account type selection (Bank / Cash / Savings / Credit Card / E-Wallet) in Add Account and Onboarding uses pill cards instead of a dropdown
- **Exclude Account from Total Balance** — New toggle in Add/Edit Account. Excluded accounts are hidden from the home screen and accounts screen total, and are labelled with an "Excluded" badge on their card
- **Excel export (.xlsx)** — Export Transactions now generates a proper Excel file instead of CSV, with bold header row. Exported via the **file picker** so you choose the save location
- **Date range filter for export** — Export screen now has **From → To** date pickers. Only transactions in the chosen range are included; a live count is shown before exporting
- **File picker for backup** — Create Backup now uses the file picker so you choose exactly where the `.json` is saved, instead of the system share sheet
- **4-mode theme selector** — Settings now shows a 2×2 grid of pill cards: **Follow System**, **Light Mode**, **Dark Mode**, **Black AMOLED**
- **Black AMOLED theme** — Pure `#000000` surfaces for OLED displays. Still uses your chosen accent colour for interactive elements
- **29 accent colours** — Added 8 new colours: Forest, Mint, Olive, Sage (greens) + Sky Blue, Navy, Cobalt, Ocean (blues). Removed Pitch Black (replaced by AMOLED mode)
- **AMOLED accent colour support** — Black AMOLED mode now inherits the selected accent colour for primary/secondary elements; it only forces surfaces to pure black
- **Lent money accent bar** — The "They Owe Me / I Owe Them / Net" summary bar now uses the app's primary accent colour as its background
- **`CLAUDE.md`** — Developer reference file added at the project root, covering architecture, models, DB schema, theme system, screen-by-screen notes, and coding conventions

### Changed
- **Home screen header** — Reduced from a large `SliverAppBar` with `expandedHeight: 200` to a compact `SliverToBoxAdapter` that wraps tightly around the greeting and balance text. No empty scroll space above content
- **Transfer icon colour** — Now uses `cs.onPrimary` (adapts to theme) instead of hardcoded `Colors.white`
- **Total balance** — Now sums `balance.abs()` for all non-excluded accounts, so stored negative balances (from overspending past initial balance) no longer subtract from the displayed total
- **`formatAmount()`** — Now correctly prepends a `−` sign for negative amounts rather than always using `abs()`
- **Onboarding** — Redesigned as a clean 3-step `PageView` (Name → Currency → First Account) with a progress bar at the top. Account type selector uses pill cards. Colour picker horizontally scrollable with all 24 colours visible
- **Backup false positive fixed** — "Backup created" message is only shown when the user confirms a save location. Cancelling the file picker shows no message
- **Model names** — `Category` renamed to `AppCategory` and `Transaction` renamed to `AppTransaction` to eliminate ambiguous import conflicts with `sqflite` and `flutter/foundation.dart`
- **Version** — Bumped to `1.0.3+4`
- **Gradle** — Downgraded from 9.5.0 to **8.11.1** to fix `BuildOperationDescriptor.metadata()` crash with Kotlin 2.1.0 + AGP 8.7.3

### Fixed
- **Multiple heroes error** — `heroTag: null` added to every `FloatingActionButton` and `FloatingActionButton.extended` across all screens, eliminating the "multiple heroes share the same tag" warning that appeared on navigation
- **Account / Recurring / Lent submit buttons not working** — All bottom sheet `_submit()` methods now use `context.read<AppProvider>()` instead of the stale `widget.app` snapshot
- **Currency display showing raw code** — Fixed Python string-escaping corruption that caused currency picker to show `$_currency ${currencyInfo(_currency).symbol}` literally as text instead of interpolating the values
- **`ambiguous_import` for `Border`** — `excel` package imports now use `hide Border` to prevent collision with Flutter's `Border` class
- **`ambiguous_import` for `Transaction`** — `sqflite` imported with `hide Transaction`; model class renamed to `AppTransaction`
- **`deprecated 'value:'` in DropdownButtonFormField** — Replaced with `initialValue:` in Recurring sheet frequency dropdown
- **Curly braces in bare `if` statements** — Recurring card action buttons now wrap bodies in `{}`
- **Backup restore** — `importAll()` wraps all table operations in a single SQLite transaction; settings are correctly reloaded after restore
- **Unused import warnings** — Removed `dart:convert` from `db_helper.dart`, `path_provider` and `app_theme` from `app_provider.dart`, `typed_data`/`file_picker`/`excel`/`app_theme` from the old `export_screen.dart`, `shared_widgets` from `statistics_screen.dart`
- **Unnecessary casts** — `_kTypeOptions` in accounts screen changed from `List<Object>` to `List<String>`, removing the need for `as String` casts

---

## [1.0.2] — 2026-05-06

### Added
- **Themed monochrome icon (Android 13+)** — `ic_launcher_monochrome` layer using a clean wallet outline silhouette. On Android 13+ with Themed Icons enabled, the launcher recolours the icon to match your wallpaper palette
- **Adaptive icon — all density buckets** — Monochrome layer generated at all 5 density sizes (mdpi → xxxhdpi) at 32/108dp fill ratio
- **Account cards in Recurring Payments** — Account selection in the add/edit sheet replaced with horizontal scrollable coloured cards
- **Account cards in Lent Money** — Card-based account picker (includes a "None" card for optional linking)
- **Account cards in Transfer** — FROM and TO each have their own horizontal card row; same-as-FROM account is dimmed and non-tappable
- **Category chips in Recurring Payments** — Coloured pill chips in a wrapping layout replace the category dropdown
- **24 account colours** — Colour picker expanded from 8 to 24 colours

### Changed
- **App icon** — New 3D wallet PNG with white background, 45/108dp fill ratio, +1px right / −1px up offset
- **Splash screen** — Icon shown directly on app surface, no background container
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

## [1.0.1] — 2026-05-05

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

## [1.0.0] — 2026-05-03

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
