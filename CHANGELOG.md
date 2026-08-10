# Changelog

## [1.1.0] - 2026-08-10
### Added
- Floating Material 3 Navigation Bar: Modern floating pill navigation bar (`extendBody: true`) with circular active tab selection indicator (`CircleBorder()`), 24px icon-only destinations (`alwaysHide` labels), and 48px horizontal margins.
- Expanded `ExpandableFab` (`ExpandableFabItem` list model) to the Transactions screen (Income/Expense actions) and the Budgets & Goals screen (Add Budget / Add Savings Goal actions, with matching green `0xFF2E7D32` buttons).
- Redesigned Yearly Analysis monthly cards: month-by-month planned cash flow forecast for a 24-month horizon, featuring visually readable summary grid cards for inflows and outflows, net cash flow balance pills, custom section icons, larger typography, and smooth expand animations.
- Multi-language support (English, Arabic, French, German, Hindi) for the new Yearly Analysis and Budgets & Goals ExpandableFab features.
- Loan Transfer Account feature: Setting up a loan automatically deposits the principal into a selected account, and deleting the loan (or undoing it) reverses the deposit.
- Redesigned Recurring Payment UI: payment history and recurring payment details are now shown in a dedicated `RecurringDetailScreen` with stats grids and card-based payment history lists.
- Restored progress bars inside the installment recurring cards on the main screen list and on the detail screen.
- Swipe/press back behavior on the Transactions screen multi-selection mode: pressing/swiping back now gracefully exits the selection mode instead of popping back to the home page.
- Added Undo button snackbar support when deleting budgets and savings goals, aligning them with the rest of the application's delete-undo pattern.

### Changed
- Shifted all Floating Action Buttons (FABs) down to a 76px bottom padding offset to float cleanly right above the new floating navigation bar.
- Updated main screen scroll view bottom paddings to 140px to ensure full scrolling space above the floating bar.
- Moved the delete button in the loan sheet form from the sheet header to a dedicated AppBar action in `LoanDetailScreen`.
- Restored the "Left to Spend" calculation on the budgets tab to show the subtraction between total monthly recurring income and total monthly budgeted amount.
- Restyled the budgets and goals cards to match the exact card style used in recurring payments.
- Changed the summary strip backgrounds in the budgets and goals tab to transparent to cleanly blend with the black AMOLED theme.
- Updated the Savings Goal sheet target date text field to open a native calendar date picker dialog instead of manual text input.

### Fixed
- **ProGuard / R8 Hardening**: Resolved app crashes and black-screen issues in Release builds by configuring `proguard-rules.pro` to keep GSON type parameters (resolving alarm manager trigger crash) and protecting `home_widget` communications from obfuscation.
- **Resource Shrinking Protection**: Prevented background service crashes by creating `keep.xml` to protect custom notification icons (`ic_notification`) from resource shrinking, and updating reminder services to use proper resource paths.
- **Savings Goal Detail Screen**: Fixed a white screen rendering crash caused by an invalid runtime cast of `DateTime` targetDate to `String?`.
- **UI Spacing Adjustments**: Optimized layout item spacing on the Transactions list screen to clean up empty spaces around date headers.
- **Codebase Cleanups**: Resolved 30+ compiler warnings and linting issues.

## [1.0.9] - 2026-08-07
### Added
- Linked Accounts feature: Cards can now be linked directly to Bank accounts.
- Bank accounts now compute their total balance, income, expense, and transaction history dynamically by summing up all their linked debit and credit cards.
- Added option to write card expiration dates (MM/YY) and display it on the real-world card UI.
- Added a toggle to exclude a specific linked card's balance from the bank account's total.
- Added an Advanced Filter sheet in the Transactions Screen to allow granular transaction searching by Amount Range (Min/Max) and Category.
- Added Bulk Selection mode in the Transactions Screen: Long-press to select multiple transactions and perform bulk category changes or bulk deletions.
- Global Form Keyboard Navigation: Added `TextInputAction.next` and `onSubmitted` handlers to text fields across the app (Add Transaction, Accounts, Categories, etc.) allowing users to smoothly advance to the next field using the soft keyboard's "Next/Enter" button.
- Drag-and-drop account and category reordering with strong/light haptic feedback globally synced across the app.
- Advanced reminder scheduling for Credit Cards (2 days early + specific time).
- Insights Screen: Added a new "Spending Forecast" card to project monthly expenses against the total budget.
- Insights Screen: Added projected spending amounts and budget percentage usage to the "Top Spending Categories" list.
- Insights Screen: Added a new "Net Worth" section displaying live totals for Accounts and Assets, alongside a historical trend graph.

- Unified all snackbars (including undo actions) across the app to force auto-hide strictly after 3 seconds.
- Fixed Home Page top bar alignment to sit cleanly behind the summary cards and properly spaced above the accounts text.

- Added left-to-right swipe-to-delete gesture and click-to-edit for recent transactions in the Home Screen.
- Home page account cards now retain beautifully rounded corners during the drag-and-drop reordering animation.
- Modified the bottom navigation bar to have circular top edges for a modern, softer look.
- Standardized haptics globally using a custom AppHaptics utility to ensure consistency.
- Fine-tuned the trash icon position on the Real Card UI.
- Fixed an issue where the Excel export screen showed a false "Export Complete" message when the system file picker was cancelled.
- Fixed an issue in the Transactions screen where long-pressing a transaction to select it would falsely prompt to delete it. Long-press now properly only selects the transaction.
- Fixed a rendering issue where bottom sheets pop-ups remained visible after switching navigation tabs.
- Onboarding updated: the 'Add a Credit Card' step is now 'Add a Card' with options for both Credit and Debit cards.
- Added a 'Skip for now' button to the Add Account and Add Card steps during onboarding.
- Replaced buggy automatic form slide-up effects with robust dynamic padding across all major forms (Budgets, Assets, Wishlists, Lent Money, Accounts) to ensure forms smoothly glide above the keyboard without layout stability issues.
- Tweaked home screen spacing by reducing the padding of the top header and tightening the space above the Accounts section.
- Replaced the two-tap delete confirmation dialog with a seamless one-tap delete action featuring an undo AppSnackbar across all major entities app-wide (Transactions, Assets, Budgets, Savings Goals, Wishlists, Lended Money, Accounts, Categories).
- Transactions Screen: Selection mode can now be exited cleanly using the system back swipe gesture or back button.
- Transactions Screen: The 'Change Category' button is dynamically hidden when the bulk selection contains Lent/Borrowed entries, preventing invalid category assignments.

### Changed
- Re-architected Accounts ordering: Accounts now accurately restore their user-defined layout ordering after an app restart instead of falling back to creation date.
- Redesigned Card Details UI: Swapped the generic wallet icon for a streamlined inline Delete icon for better accessibility, and made card corners smoothly rounded.
- Refined Card UI: Replaced the large central balance on Credit Cards with the credit limit elegantly displayed directly above the small bottom-right balance.
- Perfectly aligned the trash icon on the Card UI to be perfectly centered inside the top-right circular element.
- Improved the 'Linked Bank Account' chips in the Add Card form to be larger and more tactile.
- Decoupled the Add Card form from the Add Account form to ensure cleaner UI logic scaling and independent updates.
- Increased the speed of the Expandable FAB pop-up animations for a snappier, more responsive feel.
- Categories filter redesigned: Moved from a horizontal slider to scrollable chips integrated directly inside the Advanced Filter bottom sheet.
- Tabbed Account layout: Cleanly separated Cards from regular Accounts.
- Bank accounts now function strictly as containers and do not appear in transaction forms.
- Updated Onboarding: Now supports adding cards directly on the first launch instead of generic accounts.
- Simplified Net Worth Insights layout by removing redundant trend lines.
- **Architectural Overhaul**: Converted major screens to use `context.select` instead of `context.watch` to prevent full-app rebuilds.
- **Optimized Rendering**: Memoized heavy calculations and flattened nested lists in Transactions and Home screens to guarantee 120Hz smooth scrolling.

### Fixed
- Fixed an edge-case bug where users couldn't deselect a Linked Account once one was set (selecting "None" wouldn't save).
- Fixed an issue where the global Total Balance would double-count linked cards.
- Fixed Expandable FAB alignment by letting it naturally align to the ambient RTL/LTR layout instead of forcing LTR, keeping the popups perfectly stacked over the FAB across all languages.
- Fixed Credit Card 'Due Day' text fields across the app by capping length at 2 characters to prevent accidental long inputs.
- Fixed an issue where paying an installment erroneously converted it into a subscription.
- Fixed persistent Snackbars remaining on screen indefinitely; all Snackbars are now strictly enforced to vanish after 3 seconds by bypassing system accessibility overrides.
- Fixed background silent crashes caused by unhandled async and database exceptions by fully revamping `models.dart` to be 100% null-safe during database initialization.
- **Database I/O Spikes**: Fixed severe lag when saving transactions by implementing optimistic in-memory list updates instead of fully re-querying SQLite tables on every CRUD operation.
- Fixed backup normalisation to support new fields like `linked_account_id` and `order_index`.
- Cleaned up the codebase by removing numerous unused variables (e.g., `l10n`).
- Fixed an issue where the keyboard "Next"/"Done" button was not correctly adapting to the dynamic number of fields in the Account creation sheet, ensuring a smooth keyboard navigation experience across all account types (Bank, Cash, Gold, etc.).

## [1.0.8] — 2026-07-28

### Fixed
- **Android Builds** — Fixed issues related to invalid APK builds.

### Removed
- **Auto Backup** — Completely removed the automatic backup feature, background workers, and associated dependencies to streamline the application architecture.

### Added
- **Spanish Language (Español)** — Fully translated the app into Spanish with 100% string coverage (512 strings), bringing the total supported languages to 6.
- **Brazilian Real (BRL)** — Added BRL (R$) to the built-in currency list and promoted it to the popular currencies row in the Currency Converter.

### Changed
- **Recurring Page UI** — Added a combined "Income / Expenses" summary label at the top of the Recurring page to match the visual styling of the Accounts page total balance.

---

## [1.0.8] — 2026-07-26

### Added
- **Savings Goals** — Create and track savings goals alongside your budgets, with visual progress bars and goal completion alerts.
- **Budget Alerts** — Receive instant push notifications the moment an expense pushes a category over its budgeted limit.
- **Daily Reminders** — Added a 10:00 PM daily reminder to log transactions, which can be toggled via Settings.
- **Haptic Feedback** — Implemented system haptic feedback for major navigation actions, button taps, and destructive confirmations.
- **Contributions & Withdrawals** — Goal contributions and withdrawals are natively recorded and interleaved seamlessly into the main Transactions list.
- **Global Validation** — Implemented global validation across all app forms to ensure mandatory fields are filled before saving.
- **Recurring Payment UI Improvements** — The Recurring Expenses tab has been split into 'Subscriptions' (ongoing) and 'Installments' (finite payments) for better categorization, featuring larger, more colorful toggle cards. The Add Recurring screen now also uses card selectors instead of a dropdown.
- **Import from Other Apps** — Added a dedicated "Import from Other Apps" section in the Backup & Restore screen to easily pull in GreenStash backups.

### Fixed
- **GreenStash Balance & File Picker** — Fixed an issue where the file picker menu was shown twice, and GreenStash imports now correctly calculate the goal balance based on contributions and withdrawals.
- **Recurring Filter UI** — The 'Subscriptions' and 'Installments' toggle buttons have been refined to be smaller, keeping text and icons neatly aligned on one line.
- **Predictive Back** — Enabled Android 15+ predictive back animations app-wide for a smoother navigation experience.
- **Haptic Feedback** — Expanded haptic feedback to plus icons and all 'Save' button actions across the app.
- **Fade Transitions** — Smooth fade animations are now used when switching between the main bottom navigation tabs.
- Fixed the Daily Reminder scheduling logic to fire reliably at the selected time.
- Fixed the Savings Goal sheet to dynamically follow the app's selected theme color instead of defaulting to purple.
- Fixed the 'Transactions' label text wrapping in the NavigationBar by slightly reducing the global navigation bar label font size.
- Added support for migrating and restoring backups from external apps like GreenStash (.json) directly from the Onboarding Screen.
- Introduced a new minimalist Android Homescreen Widget ("Quick Add - Nothing Style") to instantly launch the Add Transaction screen directly from your launcher. Features a 1x1 default size that is fully resizable, a custom sleek vector icon, and an accurate layout preview in the widget picker.
- Extended the global mandatory fields validation feature to the Assets screen.
- Fixed a visual jumping bug in the Add Transaction and Add Asset screens where the currency card would shift out of alignment when the mandatory field error text appeared, fixing it with a robust layout calculation.
- **GreenStash Restore Cancellation** — Fixed an issue where cancelling the file picker during GreenStash backup import would falsely show a "data restored successfully" message.
- **Android File Picker Glitch Fixed** — Removed `withData: true` from the `file_picker` config on the Onboarding screen to bypass a known Android intent bug that popped up the "Open With..." app chooser menu before the document picker.
- **Say App Support Removed** — Cleanly deprecated and removed all data import routes for the "Say" app per user preference.
- **GreenStash Withdrawals & Balance** — GreenStash imports now correctly parse 'Withdraw' and 'Deposit' type strings to accurately calculate the goal balance.
- **Dynamic Color Toggle** — Decoupled Dynamic Color from the System theme mode. A new independent toggle in Settings allows Material You wallpaper colors to be applied regardless of light/dark/system selection, and hides the accent color picker when enabled.
- **Haptic Feedback (VIBRATE Permission)** — Added the missing VIBRATE permission in AndroidManifest to ensure new tactile feedback works across all Android devices.
- **Predictive Back & Page Transitions** — Replaced the heavy Android Zoom transition with the smooth, iOS-style left-to-right `CupertinoPageTransitionsBuilder` across the app. This provides a clean, fluid swipe-to-go-back gesture that scales perfectly with the system's animation speed settings, natively tracking your finger's exact drag speed linearly.
- **Add Transaction Animation** — Restored the vertical slide-up animation for the Add Transaction and Transfer screens using a dedicated `ExpensySlideUpRoute`, keeping form screens visually distinct from regular page navigations.
- **Tab Switching** — Removed the tab switching fade animations in favor of a standard, instant `IndexedStack` switch for a snappier, more native feel without any stutter.
- **Recurring Income End Date** — Removed the unnecessary end date field from the Add Recurring Income form; income entries are now always ongoing.
- **Recurring Tab Switching** — Animated the monthly/weekly summary cards and subscriptions/installments filter cards with crossfade transitions for instant visual feedback when swiping between Expenses and Income tabs.
- **Currency Picker Autofocus** — Disabled the automatic keyboard popup when opening the currency picker to allow users to smoothly scroll the list without interruption.


## [1.0.7] — 2026-07-21

### Added
- **Localization Support** — Fully localized the app into 4 new languages: Arabic (ar), French (fr), German (de), and Hindi (hi). Translated over 450 UI strings and configured dynamic language switching.
- **Onboarding Language Selector** — Added a new Language Selection page to the start of the onboarding flow to immediately adapt the app to the user's preferred language.
- **Developer Links Dialog** — The "Developer" tile in Settings now opens a dialog offering links to both the GitHub Profile and the Developer Website (portfolio.minaashraf285.workers.dev).

### Changed
- **Bottom Navigation Bar** — Localized the `NavigationBar` labels (`Home`, `Transactions`, `Recurring`, etc.) which were previously hardcoded.
- **Refined English Text** — Polished English headers across several creation screens ("Enter Transaction", "Add a Recurring Payment", "Add New Account", "Add New Budget") for better clarity.
- **Back Navigation** — Pressing the back button from any tab now returns to the Home tab (Dashboard) instead of immediately exiting the app.

---

## [1.0.6] — 2026-07-14

### Fixed

- **Lent/borrowed reminders not firing.** `scheduleLendedReminder()` had drifted from `scheduleReminder()` (the recurring-payment reminder function it was modeled on) in a way that made a boot-time reschedule pass actively cancel legitimate lent/borrowed reminders without reliably re-adding them. Rewrote `scheduleLendedReminder()`, `rescheduleAll()`, and the lended notification-details builder to be a structural mirror of the recurring-payment path: identical guard clauses, identical `_toUtcTZDate()` skip-if-in-the-past behaviour, identical `zonedSchedule()` call shape, and reminders scheduled only from the same event-driven call sites (add/edit/restore) that recurring uses — no extra boot-time re-registration pass that recurring doesn't also have. If a lent/borrowed reminder still doesn't fire, the record's due date, reminder time, or the OS-level exact-alarm/notification permission is the next thing to check, since the two reminder types now share identical scheduling code.
- **"Add Record" silently failing for lent/borrowed people after updating from a pre-1.0.6 install.** The `lended_money` table upgrade path left the old `person_name TEXT NOT NULL` column physically in place; new rows never wrote a value for it (the model was rewritten to use `person_id`), so every insert failed a NOT NULL constraint and was swallowed by the app with no error shown. The v9→v10 migration now rebuilds `lended_money` to match the fresh-install schema (no `person_name` column) inside a single transaction, so upgraded installs behave identically to a fresh install. Hardened with proper error logging instead of a silent catch, in case a future device ever hits an edge case.
- **Backup screen out of date with the actual backup format.** The "what's included" counts only covered 8 of the (already) 10 backed-up tables and never mentioned Budgets, Recurring History, or the per-person lending structure, even though `exportAll()` always correctly included them. The screen is now fully data-driven off the live provider state, includes every table, and the stale hardcoded schema-version constant was replaced with a single source of truth (`DBHelper.schemaVersion`). Also removed the "Backup format · JSON · Generated on …" footer text.

### Added

- **Unified Transactions & Lent/Borrowed Money integration.** Surfaced `LendedMoney` ledger entries directly in the main `TransactionsScreen` list view alongside standard `AppTransaction` objects using a lightweight wrapper, preserving chronological date ordering and grouping.
- **Lent & Borrowed filters.** Added "Lent" (deep blue) and "Borrowed" (deep orange) filter pills to the top selection bar, allowing users to isolate personal debt ledger entries.
- **Interactive `_LendedTile` UI.** Built a custom list tile displaying custom colored avatar containers, direction-coded arrows (Upward/outflow for Lent, Downward/inflow for Borrowed), settlement badges with visual fading, and support for quick actions: `onTap` (opens `LendedPersonScreen` detail ledger) and `onLongPress` (delete confirmation dialog).
- **Search & Account Filter compatibility.** Extended search queries to match notes, person names, and type strings on lended items, and allowed account-filtering based on the lended record's source/target funding account.
- **"Restore a Backup" step at the very start of onboarding.** New users (or anyone reinstalling/switching devices) can now restore an existing Expensy backup file immediately, before filling in a name/currency/first account, instead of clicking through the whole setup wizard with throwaway data first.

### Changed

- **Stripped release APK build optimization.** Removed the debug symbol retention workaround (`keepDebugSymbols`) in `build.gradle` to re-enable native `llvm-strip`. This successfully reduced production signed split-per-ABI APK sizes back to `~23-26 MB` (down from `~154 MB`) and the universal APK size to `~62 MB` (down from `~440 MB`).

### Architectural Rework & Build Improvements (v1.0.6)

- **Standalone `LendedNotificationService` (`lib/services/lended_notification_service.dart`).** Decoupled all lent/borrowed money reminder logic out of the combined `NotificationService`. The new service is a dedicated singleton that manages its own `expensy_lended` channel (`Lent & Borrowed Reminders`), initializes eagerly at startup (`main.dart`), and exposes direct permission methods (`hasPermission()`, `requestPermissions()`) invoked by `LendedPersonScreen`. `NotificationService` (`notification_service.dart`) is now 100% focused on recurring payment reminders without cross-concern interference.
- **Dynamic Production Release Signing Setup.** Configured `android/app/build.gradle` and `android/key.properties` to dynamically enable production signing (`signingConfigs.release`) with `expensy.jks` when available, gracefully falling back to debug signing if key files are omitted (`signingConfig = keystorePropertiesFile.exists() ? signingConfigs.release : signingConfigs.debug`).

---

## [1.0.5] — 2026-06-20

### Added

#### Budgets (new bottom-nav tab)
- **Per-category spending limits** — set a Monthly or Weekly amount against any expense category from a new **Budgets** tab in the bottom navigation bar
- **Progress bar per budget** — colour-coded green → orange (≥75%) → red (≥100% / exceeded), with "X left" or "X over" label
- **Summary strip** — total Budgeted, total Spent, and a live "Over limit" count across all budgets
- **Live preview while creating a budget** — shows current spend against the entered amount before saving
- **Budgets surfaced on the Statistics pie chart** — each category's legend row shows "% of budget" and a mini progress bar when a budget exists for that category

#### Insights (More tab)
- **New Insights screen** — month-over-month spending comparison with an up/down trend badge
- **Daily average spend** — this month's expense total divided by days elapsed
- **Biggest single transaction** this month, with description and date
- **Top 3 spending categories** with amount and share of total
- **Category trends vs last month** — per-category up/down comparison rows
- **12-month trend line chart** — income vs expense over the last year

#### Currency Converter (More tab)
- **New Currency Converter screen** — instant conversion between any two supported currencies using live exchange rates
- **Swap button** to flip the From/To currencies instantly
- **Offline banner** shown when rates have not loaded yet


#### Category Icons
- **57 selectable icons** (Finance, Food & Home, Transport, Shopping, Health, Entertainment & Education, Work & Business, Misc groups) plus an **"Auto" mode** that picks an icon from the category name, shown in a 7-column grid in the Add/Edit Category sheet with a live preview chip
- Stored as a **1-based index** (`icon_code_point`) into a constant icon list rather than a raw `IconData` — keeps Flutter's release-mode icon tree-shaking intact
- **Category colour palette expanded from 12 to 40 colours**, grouped into Purples, Blues, Teals, Greens, Reds/Pinks, Oranges/Ambers, Browns, and Slates

#### Recurring Payment History
- Every **Pay** or **Skip** action on a recurring payment is now logged with its date, amount, and currency
- Each recurring card has an expandable **"Payment history"** panel listing every past Pay/Skip entry, loaded on demand and cached in memory
- History entries for a payment are deleted automatically when the payment itself is deleted

#### Lent / Borrowed Due-Date Reminders
- **Optional reminder notification** on a lent/borrowed record's due date, with a time picker (same permission flow as recurring reminders)
- **"Overdue!" badge** replaces the due-date label once the date has passed without being settled
- Dedicated **`expensy_lended`** notification channel, separate from recurring payment reminders
- Reminder is automatically cancelled on settle or delete, and re-scheduled on edit or backup restore

#### Material You Dynamic Colour
- When theme mode is **"System"** on Android 12+, Expensy now extracts its colour scheme from the device wallpaper (Material You) instead of the chosen accent seed
- Falls back to the selected seed colour automatically on older devices, or whenever System mode is not active

#### App Fonts
- **10 font options** in Settings: System Default plus 9 Google Fonts — Plus Jakarta Sans, DM Sans, Inter, Nunito Sans, Space Grotesk, Outfit, Sora, Poppins, Nunito

#### Statistics
- **Per-account filter pills** above the month navigator — restrict the summary cards, 6-month bar chart, and expense pie chart to a single account

#### Other
- **AUD (Australian Dollar)** added to the currency list
- **Custom page transitions** — a new `ExpensyRoute` (220 ms push / 160 ms pop, upward 8 px slide + fade, `easeOutCubic` / `easeIn`) replaces `MaterialPageRoute` for every screen-to-screen navigation in the app

### Changed
- **AMOLED decoupled from theme mode** — "Black AMOLED" is now an independent `amoledSurfaces` toggle layered on top of System / Light / Dark, instead of being its own theme-mode value. Settings now shows a single row of 3 cards (**System / Light / Dark**) instead of a 2×2 grid of 4; the AMOLED switch appears below it and is hidden while Light mode is selected
- **Themed filter pills** — the Transactions screen's type/account filters and the new Statistics account filter now use coloured pill buttons matching each item's own colour, replacing the default Material `FilterChip`
- **Snappier micro-interactions** — most pill/chip/colour-swatch tap animations were shortened (typically 140 ms → 100 ms, 80 ms → 60 ms) for a more responsive feel
- **Assets screen header simplified** — removed the redundant "Currency" summary column; now shows only Total Value and Item count
- **Bottom navigation** — now 6 tabs: Home · Transactions · Recurring · Accounts · **Budgets** · More
- **Backup format** — exported JSON now includes `budgets` and `recurring_history`; `_normaliseBackup()` patches both new tables (and the new `categories.icon_code_point` / `lended_money.reminder_enabled`/`reminder_time` columns) for every older backup version
- **`AppSettings`** gained `appFont` and `amoledSurfaces`; legacy `themeMode: 'amoled'` values are migrated automatically to `themeMode: 'dark'` + `amoledSurfaces: true` on load
- **Version** — bumped to `1.0.5+6`
- **DB schema** — version bumped from 7 to **9**, adding the `budgets` and `recurring_history` tables, `categories.icon_code_point`, and `lended_money.reminder_enabled` / `reminder_time`

### Fixed
- **Exchange rates lagging one refresh cycle behind** — `ExchangeRateService.getRates()` previously kicked off a stale-cache background refresh and returned immediately without ever surfacing the result, so the freshly fetched rates only appeared on the *next* app launch. Rate loading was rewritten in `AppProvider._loadRates()` as an explicit two-phase stale-while-revalidate: cached rates are served and rendered immediately, then a background `forceRefresh()` runs when the cache is stale and the UI is notified a second time when it completes. `ExchangeRateService` gained `getCached()` and `isFresh()` so the provider can drive this without triggering an implicit fetch

### Known Issues
- The **Backup screen**'s "what's included" live-count list was not updated for this release — it still shows the original categories (Accounts, Transactions, Recurring, Wishlist, Lent & Borrowed, Assets, Categories, Settings) and does not yet display a row for Budgets or Recurring History, even though both are now included in the exported JSON and fully restored

### Technical
- **New screens** — `budget_screen.dart`, `currency_converter_screen.dart`, `insights_screen.dart`
- **New models** — `Budget`, `RecurringHistoryEntry`; `AppCategory` gained `iconCodePoint`; `LendedMoney` gained `reminderEnabled` / `reminderTime`
- **New provider state** — `budgets` list, recurring-history cache + `getHistoryFor()`, budget CRUD (`addBudget`/`updateBudget`/`deleteBudget`) and `budgetSpent()` / `budgetRemaining()` / `budgetProgress()` / `budgetExceeded()`
- **New widget catalogue** — `kCategoryIconOptions` (57 entries) and `CategoryIconOption` in `shared_widgets.dart`
- **New theme additions** — `kFonts` map + `_applyFont()`, `dynamicScheme` parameter on `buildTheme()`, `ExpensyRoute` and `_FadeUpTransitionBuilder` in `app_theme.dart`
- **`main.dart`** wrapped in `DynamicColorBuilder` to source the Material You palette on supported devices
- **New packages** — `google_fonts ^6.2.1`, `dynamic_color ^1.7.0`

---

## [1.0.4] — 2026-05-27

### Added

#### Gold Accounts
- **Gold account type** — New account type alongside Bank / Cash / Savings / Credit Card / E-Wallet. Gold accounts track a physical gold holding by karat and grams rather than a manual balance
- **Karat picker** — Pill cards for 24 / 22 / 21 / 18 / 14 / 10 / 9 karat, each labelled with its purity percentage
- **Live gold value preview** — A preview card in the add/edit sheet shows the current market value as you enter grams and karat, sourced from live XAU rates
- **Auto-calculated balance** — Gold account balance is computed from `grams × (karat/24) / 31.1035 × XAU_rate` and refreshed every time exchange rates load or refresh; the balance can never be set manually
- **Gold badge on cards** — Account cards show a `"Xk · Y.YY g"` pill badge (e.g. `21k · 10.00 g`). Home screen account scroll and Accounts screen both display this sub-label in place of a converted amount
- **Dedicated stats row** — Gold account cards in the Accounts screen show Value / Karat / Weight / Per-gram stats instead of the standard Income / Expense / Txs row
- **Gold filtered from pickers** — Gold accounts are excluded from the account picker in Add Transaction, Transfer, Recurring Payments, and Lent Money, since their balance is always synthetic

#### Live Exchange Rates
- **Daily exchange rates** — Rates fetched from `open.er-api.com/v6/latest/USD` (free tier, no API key, USD pivot). Results cached in `SharedPreferences` for 24 hours; stale cache is served immediately while a background refresh runs
- **XAU / Gold price** — Gold price fetched separately from the fawaz currency API (`cdn.jsdelivr.net/npm/@fawazahmed0/currency-api`) with an automatic fallback URL. Injected into the rates map and persisted alongside the other rates
- **Multi-currency total balance** — `totalBalance` (Home) and `totalBalanceAll` (Accounts tab) now convert each account's balance to the main currency before summing, using live rates. When rates are unavailable, native amounts are summed directly
- **`totalBalanceAll`** — New computed property that always includes every account regardless of the "Exclude from Total" toggle. The Accounts tab AppBar shows this value; the Home screen continues to use the filtered `totalBalance`
- **Accounts rates banner** — A thin strip below the Accounts AppBar shows the rates status: fetching spinner, last-updated timestamp, or an offline warning when rates could not be loaded
- **Sync button in Accounts AppBar** — A `↺` icon appears whenever at least one account uses a currency different from the main currency. Tapping it triggers a forced network refresh; the icon is replaced by a spinner while fetching
- **Transfer cross-currency preview** — When FROM and TO accounts have different currencies, the Transfer screen shows a live conversion preview card below the amount field
- **GEL (Georgian Lari ₾) added** — Currencies list grows from 64 to 65

#### Recurring Payment Reminders (Notifications)
- **On-day reminder** — Each recurring payment can have a daily notification at a chosen time on its due date. The reminder shows the payment name and amount
- **2-day advance reminder** — An optional second notification fires at the same time 2 days before the due date, giving early notice for bills and subscriptions
- **Time picker** — Tapping the reminder time in the add/edit sheet opens a system time picker
- **Reminder badges on cards** — Active reminders are indicated by a bell icon + time label on the recurring payment card. Advance reminders show an additional `2d` badge
- **Permission flow** — Enabling a reminder checks for `POST_NOTIFICATIONS` and `SCHEDULE_EXACT_ALARM` permissions at runtime and prompts if missing. The toggle stays off if the user denies
- **Reschedule on restore** — After a backup restore, all active reminders are rescheduled automatically
- **Boot persistence** — A boot receiver in the manifest reschedules all reminders after device reboot

#### Assets Tracker
- **New Assets screen** — Track physical and financial assets (property, equipment, investments, collectibles) with a name, value, currency, and optional notes
- **Currency-aware total** — The Assets summary bar shows total value converted to the main currency using live exchange rates
- **Assets in More tab** — Assets is listed between Lent Money and Categories in the More tab menu
- **Assets in backup** — The full backup JSON includes all asset records; restoring a backup fully restores assets

#### Multi-currency Transactions
- **Per-transaction currency** — The Add Transaction screen includes a currency picker. The selected currency is stored on the transaction; if it differs from the account currency, the balance delta is converted via live exchange rates before being applied
- **Currency column in export** — The Excel export now includes a `Currency` column showing the effective currency of each transaction

#### Settings → About
- **Developer link** — New tile below the GitHub row: "Discover more projects by Mina Android" opens `https://github.com/mina-android` in the browser

### Changed
- **Startup flow** — `main()` is now `async`. It awaits `NotificationService().initialize()` then `provider.load()` (DB reads) before calling `runApp()`. The native launch background stays visible during startup; Flutter draws the real app as its very first frame — no intermediate loading screen
- **Loading screen removed** — The `_LoadingScreen` widget and its `!app.loaded` guard are gone. `ChangeNotifierProvider.value` is used instead of `create` so the already-loaded provider is passed directly
- **`restoreBackup()` returns `int`** — Previously returned `bool`. Now returns `0` if the user cancelled the file picker (no message shown), or the source backup's version number on success. Throws `FormatException` with a human-readable message for invalid files
- **Backup screen live counts** — The "what's included" section now shows live item counts for all 8 categories: Accounts, Transactions, Recurring, Wishlist, Lent & Borrowed, Assets, Categories, Settings
- **Backup upgrade label** — When restoring from an older backup version, the success message includes `"upgraded from vX → vY"`
- **Accounts tab shows `totalBalanceAll`** — The Accounts tab AppBar total now always includes every account, matching the account cards listed below it
- **`_AccountCard` watches provider** — Changed from `context.read` to `context.watch` so each card rebuilds automatically when exchange rates arrive after the initial load
- **Version** — Bumped to `1.0.4+5`
- **DB schema** — Version bumped from 2 (old zip) to 7, adding: `reminder_time` on recurring, `currency` on transactions, `assets` table, `gold_karat`/`gold_grams` on accounts, `early_reminder_enabled` on recurring

### Fixed
- **Notification icon too small** — `ic_notification` PNG assets had 32 px of transparent padding on all sides, making the graphic fill only 36 % of the canvas. All five density variants (mdpi → xxxhdpi) plus the `drawable/` fallback have been regenerated with content scaled to fill the full canvas (94–100 % fill)
- **Themed icon oversized after notification icon fix** — The adaptive icon `<monochrome>` layer was pointing at `@drawable/ic_notification`. After the notification icon was made full-canvas, the themed icon on Android 13+ appeared too large. The `<monochrome>` attribute now references `@drawable/ic_launcher_monochrome` (the correct ~29 % fill inset asset). `@drawable/ic_notification` is now used exclusively by `NotificationService`
- **Backup restore validation** — `restoreBackup()` now validates that the decoded JSON is a `Map` and contains at least one recognisable Expensy key before touching the database. Previously any valid JSON would pass
- **Backup normalisation** — `_normaliseBackup()` patches every table in every old backup so missing columns (from any version) are filled with safe defaults before the DB insert. This prevents `NOT NULL` constraint failures when restoring v1 or v2 backups into the current v7 schema
- **Transfer multi-currency** — `addTransfer()` now accepts separate `fromAmount` / `toAmount`. When currencies differ, the credit amount is independently converted rather than assuming a 1:1 rate
- **Transaction balance conversion** — `addTransaction` and `deleteTransaction` convert the transaction currency to the account's currency via exchange rates before applying or reversing the balance delta

### Technical
- **New packages** — `http ^1.2.0`, `url_launcher ^6.3.0`, `flutter_local_notifications ^18.0.0`, `timezone ^0.9.4`
- **New services** — `ExchangeRateService` (singleton, rate fetch + gold price + cache) and `NotificationService` (singleton, schedule/cancel/reschedule, exact alarms, timezone via `DateTime.now().timeZoneOffset`)
- **New screen** — `assets_screen.dart`
- **Android permissions added** — `INTERNET`, `ACCESS_NETWORK_STATE`, `POST_NOTIFICATIONS`, `SCHEDULE_EXACT_ALARM`, `USE_EXACT_ALARM`, `RECEIVE_BOOT_COMPLETED`
- **Boot receiver registered** — `ScheduledNotificationBootReceiver` declared in `AndroidManifest.xml`
- **AGP** — bumped to 8.9.1 (required by `url_launcher_android` which pulls in `androidx.browser:1.9.0` and `androidx.core:1.17.0`)
- **`coreLibraryDesugaringEnabled: true`** — added to `app/build.gradle` for `flutter_local_notifications` compatibility on API < 26

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

