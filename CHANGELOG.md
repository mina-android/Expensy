# Changelog

## [1.2.0] - 2026-09-25
### Added
- **Auto Pay on Due Date for Recurring Payments & Incomes**:
  - Added `autoPayEnabled` and configurable `autoPayTime` (defaults to 09:00) to `RecurringPayment` model, SQLite schema v25, and Drift tables.
  - Added interactive "Auto pay on Due date" toggle with custom time picker in `_RecurringSheet` and status indicators in `RecurringDetailScreen`.
  - Added real-time auto-pay execution in `AppProvider` triggered upon adding or updating recurring payments, startup `load()`, and via a continuous 1-minute periodic timer so recurring payments due today at the chosen time are processed immediately without delay.
- **Enhanced Fintech Floating Navigation Bar**:
  - Upgraded floating nav bar shell with elevated glassmorphic container border (`1.2px`), outer shadow blur, and clean geometry matching rounded-square indicators.
- **Right-Aligned Purpose-Built Floating Action Buttons (FABs)**:
  - Re-aligned FABs across Home, Recurring, Accounts, and Budgets to `endFloat` (`padding: EdgeInsets.only(bottom: 84, right: 4)`).
  - Fixed expandable action buttons popup alignment to animate directly above the FAB button anchored to the right rather than popping up from the center.

### Changed & Fixed
- **Home Page**:
  - Removed emoji next to user greeting.
  - Made the "Good morning, user" header (with hide eye icon) and Total Balance card a static top bar rather than scrolling with the rest of the page.
  - Fixed excessive whitespace below the status bar in Home and More tabs by removing redundant sliver app bars and nested status bar insets.
  - Updated Total Balance card gradient in Home to dynamically follow the Home navbar tab color (`Color(0xFF64B5F6)` in dark mode, `Color(0xFF1972E8)` in light mode).
  - Added `clipBehavior: Clip.antiAlias` to Recent Transactions container so swipe-to-delete slides stay cleanly clipped within the rounded card boundaries.
- **More Tab**:
  - Made "More" header and settings button a static top bar anchored to the top of the screen with smooth non-overlapping scrolling for cards below.
- **Yearly Analysis Screen**:
  - Removed full-screen loading spinner blocker so the screen renders immediately without flash.
- **Transactions Screen**:
  - Fixed long-press item selection layout jump by rendering selection controls directly inside `FintechHeader` instead of toggling an Android `AppBar`.
  - Styled selection mode with Fintech circular tactile action buttons matching the app theme.
  - Rounded item selection highlights (`BorderRadius.circular(14)`) across `_TxTile`, `_LendedTile`, and `_LoanPaymentTile`.
- **More Tab**:
  - Removed duplicate Settings card from "Preferences & Data", keeping Settings exclusively in the top right Fintech header.
  - Fixed content scrolling behind transparent status bar using pinned background barrier.
- **Yearly Analysis Screen**:
  - Deferred heavy multi-year projection loops until after route transition finishes, eliminating screen opening animation stutter.
- **Recurring Screen**:
  - Wrapped sub-filters in `AnimatedSize` with smooth curves to eliminate layout stutter when switching between Expenses and Income tabs.
- **Wishlist**:
  - Added delete with undo snackbar inside `_WishSheet` modal in addition to item card actions.
- **Unified App-Wide Add Button Redesign & Purpose-Built Positioning Rules**:
  - **Home Screen (`HomeScreen`)**:
    - Relocated Add FAB to **Center Bottom** (`floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat`) with dedicated vertical clearance (`padding: EdgeInsets.only(bottom: 84)`) and expanded scroll viewport bottom spacing (`150px`) so no cards are obscured.
    - Updated `ExpandableFab` to support centered alignment, frosted glass capsules, hairline borders, and glowing multi-stop shadows.
  - **Transactions Screen (`TransactionsScreen`)**:
    - Repositioned Add action into the **Top App Header** as a circular frosted tactile button (`FintechCircleButton`), located on the right adjacent to the advanced filters button on its left.
    - Removed bottom FAB from Transactions to provide completely unobstructed ledger scrolling.
    - Added bottom action sheet with rounded category avatars for swift selection between Expense and Income entries.
  - **Recurring, Accounts & Budgets Tabs (`RecurringScreen`, `AccountsScreen`, `BudgetScreen`)**:
    - Retained bottom positioning while upgrading FAB to the Modern Premium Fintech capsule aesthetic with tab-specific glowing accent colors (Royal Purple for Recurring, Amber/Orange for Accounts, Rose/Pink for Budgets).
    - Adjusted vertical clearance to `bottom: 84` to float cleanly above the floating navbar.
  - **Sub-Pages & Satellite Views (`AssetsScreen`, `CategoriesScreen`, `WishlistScreen`, `LoansScreen`, `LendedScreen`, `LendedPersonScreen`, `LoanDetailScreen`)**:
    - Replaced raw Material 3 FABs with `FintechFab` (squircle container with multi-stop gradient, glassmorphic hairline border, and soft glowing shadow) and `FintechExtendedFab`.
    - Increased list bottom clearance across all sub-screens to `110px-140px` for consistent viewport accessibility.
- **Complete App-Wide Modern Premium Fintech Visual Redesign (All 6 Tabs & Status Bar)**:
  - **Guaranteed High-Contrast Edge-to-Edge Status Bar (`AppTheme`, `MainShell`):**
    - Wrapped root application shell in `AnnotatedRegion<SystemUiOverlayStyle>` and configured `ThemeData.appBarTheme.systemOverlayStyle` with `statusBarColor: Colors.transparent`, ensuring system status bar indicators (clock, battery, Wi-Fi, notifications) maintain 100% visible, high-contrast brightness (`Brightness.dark` icons in light mode, `Brightness.light` icons in dark mode) edge-to-edge across all screens without solid AppBars cutting off the viewport.
  - **Modern Reusable Fintech UI Primitives (`lib/widgets/fintech_components.dart`):**
    - `FintechHeader`: Edge-to-edge transparent top header with status-bar safe padding, bold typography, contextual metadata subtitles, and frosted circular tactile action buttons (`FintechCircleButton`).
    - `FintechHeroCard`: Elevated multi-stop gradient cards with glassmorphic hairline borders, dynamic theme-adaptive backgrounds, and tap interactions.
    - `FintechSegmentedControl<T>`: Pill-shaped segmented control replacing legacy underlined TabBars with tactile haptic feedback.
    - `FintechContainedLedger`: Rounded group containers eliminating individual card visual clutter and grouping activity with sleek inset dividers.
  - **Transactions Tab Redesign (`TransactionsScreen`):**
    - Edge-to-edge transparent header with dynamic entry count and filter button.
    - Pill-shaped soft-fill search bar (`BorderRadius.circular(22)`).
    - Modern filter pills with Emerald Green glowing active state.
    - Date-grouped contained ledgers displaying humanized day headings (Today, Yesterday, Date) paired with daily net cash flow (`+/- amount`), enclosing transaction tiles with subtle inset dividers.
    - Elevated category icons (`BorderRadius.circular(14)`) across transactions, lent money, loan repayments, and goal contributions.
  - **Accounts & Cards Tab Redesign (`AccountsScreen`):**
    - Converted to stateful view with `FintechSegmentedControl<int>` (Accounts vs Cards).
    - Amber/Orange Net Liquidity Hero Card showing aggregated balance and live multi-currency metadata.
    - Transparent fintech header with account count and live exchange rate synchronization trigger.
    - Contained account cards and credit card settlement tiles with glassmorphic borders.
  - **Recurring Cash Flow Tab Redesign (`RecurringScreen`):**
    - Converted to `FintechSegmentedControl<int>` (Expenses vs Income) with Royal Purple accent.
    - Elevated Committed Cash Flow Hero Card showing monthly burn rate, weekly rate, and real-time monthly income vs expenses breakdown.
    - Modernized subscription vs installment filter cards and rounded recurring payment containers (`BorderRadius.circular(20)`).
  - **Budgets & Savings Goals Tab Redesign (`BudgetScreen`):**
    - Rose/Pink fintech header with active budget and goal counts.
    - Elevated Safe-to-Spend Allowance Hero Card displaying daily pacing, monthly remaining allowance, dynamic pacing indicator badges, and monthly progress bar.
    - Replaced legacy TabBar with `FintechSegmentedControl<int>` for Budgets vs Savings Goals.
    - Modernized budget and savings goal cards with rounded containers (`BorderRadius.circular(20)`), subtle glass borders, and pacing indicator rows.
  - **More Hub Redesign (`MoreScreen`):**
    - Modernized header to transparent `FintechHeader` with Ocean Teal accent and live tool count metadata.
    - Elevated Total Wealth & Net Worth Hero Card (`FintechHeroCard`) with live aggregated net worth, asset vs liability breakdown, and direct 1-tap shortcut to Net Worth screen.
    - Redesigned 2-column grid cards with rounded containers (`BorderRadius.circular(20)`), subtle surface fill, hairline borders, and 38px rounded category badge icons.
  - **More Tab Sub-Screens Redesign (All 14 Screens & Satellite Flows):**
    - **Analytics & Insights Suite:**
      - `NetWorthScreen`: Replaced legacy material cards with `FintechHeroCard`, rounded trend chart container, quick nav shortcuts container, snapshot history container, and `_SectionBreakdownCard` rounded fintech container.
      - `StatisticsScreen`: Transparent AppBar, rounded month nav pill container, modern `_StatCard` rounded containers, 6-month bar chart container, and expense pie breakdown container.
      - `InsightsScreen`: Transparent AppBars, Expensy Wrapped banner container, This vs Last Month comparison container, Daily Average container, Spending Forecast container, Expense-to-Income Ratio container, Top Categories container, Biggest Expense container, Category Trends container, 12-Month Trend Chart container, and Net Worth + Loans containers modernized to Fintech containers.
      - `FinancialCalendarScreen`: Transparent AppBar, modernized month navigation header, calendar grid heatmap container, and selected day ledger & breakdown container with smooth ink splash support.
      - `YearlyAnalysisScreen`: Transparent AppBar, modernized year selector container, metric summary cards, and `_MonthCard` modernized to rounded Fintech container with dynamic net flow indicator colors.
    - **Financial Tools Suite:**
      - `LoansScreen`: Transparent AppBar, modernized summary chips, and `_LoanCard` rounded Fintech container with transparent Material InkWell.
      - `LoanDetailScreen`: Transparent AppBar, replaced solid primary header with Fintech rounded hero container, modernized metadata stats grid, and payment history items in rounded containers.
      - `LendedScreen`: Transparent AppBar, modernized summary row container, updated `_SumCol`, and `_PersonCard` rounded Fintech container.
      - `LendedPersonScreen`: Transparent AppBar, replaced solid primary header with Fintech rounded hero container, and modernized `_EntryCard` with rounded container.
      - `WishlistScreen`: Transparent AppBar, modernized `_WishCard` with rounded container and subtle celebration border.
      - `AssetsScreen`: Transparent AppBar, modernized summary row container, updated `_SumCol`, and `_AssetCard` rounded container.
      - `CurrencyConverterScreen`: Transparent AppBar, modernized swap button, converted result container, rate info container, and `_CurrencyPill`.
    - **Preferences & System Suite:**
      - `CategoriesScreen`: Transparent AppBar, modernized `_CatTile` into rounded container.
      - `ExportScreen`: Transparent AppBar, modernized summary box container, `_DateCard`, and `_Banner`.
      - `BackupScreen`: Transparent AppBar, modernized Create backup container, Restore backup container, Import from other apps container, and What's included container.
      - `SettingsScreen`: Transparent AppBar, modernized Appearance Card, App Font Card, Currency Card, Language Card, Preferences Card, Profile Card, About Card, and `_ThemeCard` into rounded containers (`BorderRadius.circular(20)`).
    - **Satellite Detail Screens & Modals:**
      - `RecurringDetailScreen`: Transparent AppBar, replaced solid primary header with Fintech rounded hero container, modernized metadata stats grid, and payment history items in rounded containers.
      - `SavingsGoalDetailScreen`: Transparent AppBar, replaced solid top banner with Fintech rounded hero card, modernized contribution tiles in rounded containers.
      - `TransferScreen` & `AddTransactionScreen`: Transparent AppBars guaranteeing edge-to-edge status bar visibility.
- **Vibrant Multi-Color Floating Navigation Bar (`MainShell`)**:
  - Replaced monochrome solid white icons in the bottom navigation bar with dedicated, theme-adaptive semantic colors for each tab destination:
    - **Home (Tab 0):** Vibrant Blue (`#1972E8` in light mode, `#64B5F6` in dark mode).
    - **Transactions (Tab 1):** Emerald Green (`#2E7D32` in light mode, `#81C784` in dark mode).
    - **Recurring (Tab 2):** Royal Violet/Purple (`#8E24AA` in light mode, `#BA68C8` in dark mode).
    - **Accounts (Tab 3):** Amber/Gold/Orange (`#F57C00` in light mode, `#FFB74D` in dark mode).
    - **Budgets (Tab 4):** Rose/Pink (`#D81B60` in light mode, `#F06292` in dark mode).
    - **More (Tab 5):** Teal/Cyan (`#00897B` in light mode, `#4DB6AC` in dark mode).
  - **Dynamic Tab Highlight & Soft Unselected State:** Unselected icons render with a soft 60% opacity tint of their respective tab color for immediate distinction without visual clutter, while the selected icon renders with 100% opacity inside a matching softly tinted rounded-corner square indicator (`indicatorColor` adapts dynamically to `tabColor.withValues(alpha: 0.16–0.22)`).
- **Modern Premium Fintech Home Screen Redesign (`HomeScreen`)**:
  - **Dynamic Time-of-Day Greeting & Native Localized Date:** Replaced the static header with a contextual time-of-day greeting ("Good morning / afternoon / evening, [Name]") accompanied by dynamic time emojis (☀️, 🌤️, 🌆, 🌙) and locale-native formatted dates (`DateFormat.MMMMEEEEd`).
  - **Elevated Hero Balance Card:** Transformed the top section into an elevated fintech hero card with dark/light adaptive gradients, subtle glassmorphic borders, currency pill badge, and high-impact balance typography (`hideBalance` masking supported).
  - **Accessible Labeled Quick Actions Row:** Replaced the overcrowded top-right icon cluster with a clean 4-button quick action row featuring circular tactile buttons with text labels for Transfer, Insights, Calendar, and Forecast (Yearly Analysis).
  - **Unified Monthly Cash Flow Card:** Replaced the 3 squished chips with a modern overview card featuring distinct Inflow and Outflow columns, real-time Net indicator badges, and a dynamic savings rate progress bar.
  - **Realistic Account Cards:** Redesigned the horizontal account carousel with realistic debit/credit card styling, card network and contactless antenna badges, cardholder last 4 digits (`•••• 1234`), gold weight stats, and converted currency amounts, alongside a dedicated "+ Add Account" card.
  - **Contained Activity Ledger:** Grouped recent transactions within an elegant rounded card container featuring category avatars, split transaction pill badges, clean item dividers, and a direct "See All →" shortcut.
  - **100% Comprehensive 11-Locale Localization:** Added all 12 new home keys (`home_goodMorning`, `home_goodAfternoon`, `home_goodEvening`, `home_transferAction`, `home_insightsAction`, `home_calendarAction`, `home_forecastAction`, `home_manage`, `home_seeAll`, `home_addAccount`, `home_monthlyOverview`, `home_savingsRate`) across all 11 languages (`en`, `ar`, `de`, `es`, `fr`, `hi`, `it`, `ja`, `pt`, `ru`, `zh`) with 0 untranslated strings.
- **Standalone Bank Accounts ("Don't link to Card", Schema v24)**:
  - Added a dedicated "Don't link to Card" toggle (`dontLinkToCard`) in Bank account creation/editing and Onboarding:
    - **Initial Balance & Exclude from Total:** When enabled, restores the starting/current balance field and the "Exclude from Total Balance" toggle for bank accounts (which are otherwise hidden under the assumption that card-linked bank balances are synthesized).
    - **Card Link Prevention:** Automatically excludes bank accounts with `dontLinkToCard == true` from card-linking selectors (`_AccountSheet` and `_CardSheet`), ensuring cards can only link to card-enabled bank accounts.
    - **Automatic Card Unlinking:** Editing an existing bank account and toggling "Don't link to Card" ON automatically unlinks any previously attached credit/debit cards in `AppProvider.updateAccount`.
    - **Onboarding Flow Integration:** Synchronized `_PageThree` (First Account) and `_finish()` in `OnboardingScreen` so users can create unlinked bank accounts with a custom starting balance and exclude preference, preventing subsequent cards in `_PageFour` from auto-linking to it.
    - **Database Migration:** Bumped schema version to `24` in `AppDatabase` (Drift) and `DBHelper` (SQLite) with an automated `dont_link_to_card` column migration and complete backup/restore serialization.
    - **Complete 11-Locale Localization:** Added `accounts_dontLinkToCard` and `accounts_dontLinkToCardDesc` across all 11 supported languages (`en`, `ar`, `de`, `es`, `fr`, `hi`, `it`, `ja`, `pt`, `ru`, `zh`).
- **100% Comprehensive App-Wide Localization Across All 11 Supported Languages**:
  - Full synchronization and coverage of 772 translation keys across all 11 supported languages: `en` (English), `ar` (Arabic), `de` (German), `es` (Spanish), `fr` (French), `hi` (Hindi), `it` (Italian), `ja` (Japanese), `pt` (Portuguese), `ru` (Russian), `zh` (Chinese).
  - Validated with `flutter gen-l10n` producing 0 missing/untranslated keys (`untranslated.json` evaluated to `{}`).
  - Extracted and localized remaining hardcoded strings across `AccountsScreen`, `TransactionsScreen`, `BudgetScreen`, `ExportScreen`, `LoansScreen`, `AddTransactionScreen`, `AssetsScreen`, `CategoriesScreen`, `HomeScreen`, `LendedPersonScreen`, `WishlistScreen`, `OnboardingScreen`, `PresetsCarousel`, `PresetSheet`, `SavingsGoalSheet`, `SavingsGoalDetailScreen`, `CreditCardSettlementSheet`, `NetWorthScreen`, `BackupScreen`, and `PdfReportService`.
  - Added new localized strings for confirmation dialogues, snackbar notifications with undo actions, card preview headers, settlement actions, statement cycle labels, and split-transaction validation errors.
- **Global Dedicated In-App Numeric Keypad & Calculator (`AppNumericKeypad`)**: Applied across every single numeric and monetary amount input in the entire application, eliminating Android system keyboard popups, lag, layout jumping, and viewport obstruction:
  - **In-App Calculator Engine with Percentage Calculation (`ExpressionEvaluator`):** Added a dedicated `%` key on the bottom-right of the keypad to calculate percentages seamlessly: direct percentages (`50%` $\rightarrow$ `0.5`), portion multiplication (`200 × 15%` $\rightarrow$ `30`), percentage markups and taxes (`100 + 15%` $\rightarrow$ `115`), and discount calculations (`100 − 20%` $\rightarrow$ `80`). Built-in real-time arithmetic operations (`+`, `−`, `×`, `÷`, `=`, `%`) with operator precedence parsing, evaluation preview, and haptic feedback.
  - **Compact Responsive Design:** Equipped `AppNumericKeypad` with a `compact: bool` mode (~200px height with 36px tactile button rows) specifically engineered for Material 3 modal bottom sheets and compact viewports.
- **Streamlined Quick Presets Carousel (`PresetsCarousel`)**: When presets exist, removed the duplicate "+ New" chip from the left of the horizontal scroll view, preserving a clean preset row alongside the header's "+ Add" button on the right.
  - **Complete 100% App-Wide Coverage:**
    - `AddTransactionScreen`: Main amount and multi-category split amounts.
    - `CurrencyConverterScreen`: Converted amount input with permanently docked keypad.
    - `PresetSheet`: Preset creation amount.
    - `SavingsGoalSheet`: Target savings goal amount.
    - `SavingsGoalDetailScreen` (`_ContributionSheet`): Contribution and withdrawal amounts.
    - `CreditCardSettlementSheet`: Custom settlement payment amount.
    - `BudgetScreen` (`_BudgetSheet`): Monthly budget allowance.
    - `LendedPersonScreen` (`_EntrySheet`): Lent and borrowed amounts.
    - `WishlistScreen`: Target price in `_WishSheet` and deduction amount in purchase dialog.
    - `AssetsScreen` (`_AssetSheet`): Asset valuation amount.
    - `TransactionsScreen` (`_AdvancedFilterSheet`): Minimum and maximum filter amounts.
    - `OnboardingScreen` (`_PageThree` & `_PageFour`): Initial account balance, card credit limit, and card amount used.
  - **Seamless Text/Keypad Focus Coordination:** Setting `readOnly: true` and `showCursor: true` eliminates system soft-keyboard popups on numeric fields, while tapping text fields (Title, Notes, Name) cleanly dismisses the numeric pad and restores the soft-keyboard smoothly.
- **Professional PDF Financial Report Generator (`PdfReportService`)**: Multi-page vector PDF financial statement generation built 100% offline with zero cloud tracking:
  - **Comprehensive Report Layout:** Features Expensy branding header, date range filter, base currency indicator, Executive Summary table (Total Inflow, Total Outflow, Net Savings, Savings Rate, Transaction count), Assets & Liabilities snapshot, Category Breakdown table with expense percentage allocations, and an Itemized Transaction Ledger with color-coded badges.
  - **ExportScreen Format Switcher:** Added a modern SegmentedButton to `ExportScreen` allowing users to toggle between Excel (.xlsx) and PDF Report (.pdf).
  - **Print, Preview & Share:** Integrated direct 1-tap print/preview sheets (`Printing.layoutPdf`), system share sheets (`Printing.sharePdf`), and local storage saving via platform file picker (`FilePicker.platform.saveFile`).
  - **Complete 11-Locale Localization:** Added `export_pdf*` keys across all 11 supported languages (`en, ar, de, es, fr, hi, it, ja, pt, ru, zh`).
- **Android App Shortcuts & Quick Settings Tile (`QuickAddTileService`, `shortcuts.xml`)**: Instant entry points directly from the Android operating system without navigating the full app first:
  - **Static App Shortcuts (`shortcuts.xml`):** Long-pressing the Expensy app launcher icon provides 1-tap shortcuts for Add Expense (`com.ma.expensy.ACTION_ADD_EXPENSE`), Add Income (`com.ma.expensy.ACTION_ADD_INCOME`), Transfer (`com.ma.expensy.ACTION_TRANSFER`), and Quick Presets (`com.ma.expensy.ACTION_PRESETS`).
  - **Theme-Adaptive Shortcut Icons:** Converted shortcut icons to Android Adaptive Icons (`ic_shortcut_expense`, `ic_shortcut_income`, `ic_shortcut_transfer`, `ic_shortcut_presets` in `res/drawable-anydpi-v26/` and fallback vectors in `res/drawable/`). The circular container background dynamically adapts to the device theme (`@color/shortcut_background` — light surface in light mode, dark surface in dark mode), while the refined line drawings adapt to pure black in light mode and pure white in dark mode (`@color/shortcut_icon_color`).
  - **"Quick Add" Quick Settings Tile (`QuickAddTileService`, `ic_qs_quick_add.xml`):** Dedicated quick tile in Android's notification shade for 1-tap quick expense logging titled "Quick Add" with Android 14+ (API 34) `PendingIntent` compatibility, featuring a theme-adaptive vector plus icon that dynamically adapts to pure black in light mode and pure white in dark mode (`@color/quick_tile_icon_color`).
  - **Dynamic Routing in `main.dart` & `MainActivity.kt`:** Automatically extracts intents on both cold starts and warm background resumes, seamlessly pushing slide-up routes to `AddTransactionScreen` (pre-configured for expense or income), `TransferScreen`, or opening `PresetSheet`.
- **"Expensy Wrapped" Monthly Story Digest (`WrappedScreen`)**: Spotify-Wrapped-style interactive monthly financial recap computed 100% locally from the on-device database:
  - **5 Interactive Story Slides:** The Big Picture (Inflows, Outflows, Net Saved, Savings Rate), Where Did It Go (dominant spending category and percentage share), Biggest Splurge (single largest expense highlight card), Hero Habit (Zero-Spend days count and discipline streak), and Shareable Monthly Receipt Card.
  - **Story Controls & Gestures:** 5-segment animated top progress indicators, left/right tap navigation, long-press to pause, and a 1-tap Replay button.
  - **Privacy-First Obscure Amounts Toggle:** A prominent "Hide amounts for sharing" action on the final receipt card replaces monetary figures with `***` while preserving percentages and streak stats for safe sharing on social media.
  - **Navigation Integration:** Prominently featured via an Expensy Wrapped banner card in `InsightsScreen` and as a permanent tool in `MoreScreen`.
  - **Full 11-Locale Localization:** Added all 22 `wrapped_*` keys across all 11 supported languages (`en, ar, de, es, fr, hi, it, ja, pt, ru, zh`).
- **Smart "Safe-to-Spend" Daily Budget Pacer (`BudgetPacingInfo`, `BudgetPacingStatus`)**: Replaces passive budget progress bars with actionable daily spending guidance:
  - **Mathematical Pacing Engine:** Computes real-time Safe Daily Allowance ($\frac{\max(0, \text{Allowance} - \text{Spent})}{\text{Days Remaining}}$) and Pacing Ratio ($\frac{\text{Spent} / \text{Allowance}}{\text{Elapsed} / \text{Total Days}}$) across monthly and 7-day weekly budget cycles.
  - **Dynamic Pacing Classification (`BudgetPacingStatus`):** Classifies spending into `onTrack` ($\le 1.0$, emerald), `caution` ($1.01 - 1.25$, amber), `overPaced` ($> 1.25$, coral/red), and `exceeded` (budget exhausted).
  - **BudgetCard Pacing Indicator (`_BudgetPacingRow`):** In `BudgetScreen`, category cards feature a dedicated pacing badge with status icon, safe daily spending rate, and remaining days.
  - **Budget Screen Summary Strip:** Top horizontal strip includes a live Safe-to-Spend aggregate chip alongside total budgeted, spent, and left-to-spend.
  - **HomeScreen Smart Pacer Integration:** Revamped the home Daily Pace card into an interactive Safe-to-Spend Daily Pacer card with visual status tinting, status badges, daily allowance, countdown, and 1-tap haptic navigation to the Budgets tab.
  - **Full 11-Locale Localization:** Added all necessary strings across all 11 supported languages.
- **Wishlist-to-Savings Goal Bridge ("Dream & Fund", Schema v23)**: Connects desires in the Wishlist directly to structured Savings Goals:
  - **Database Expansion:** Added `goal_id` to `wishlist` and `wishlist_item_id` to `savings_goals` tables with automatic migrations and backup interoperability.
  - **"Fund Item" 1-Tap Bridge:** Wishlist cards for unpurchased items feature a 1-tap "Fund Item" action that opens the goal creation sheet prefilled with the item's name and target price.
  - **Live Savings Progress & Quick Navigation:** Linked wishlist cards display real-time savings progress bars with itemized amounts and percentages, linking directly to `SavingsGoalDetailScreen`.
  - **Celebration State & "Buy Now":** When linked savings reach 100% or the goal completes, wishlist cards highlight with an emerald celebration border, celebration badge, and a prominent "Buy Now" button.
  - **Lifecycle Purchase & Account Deduction Flow:** Marking an item as purchased offers an interactive dialog to record an expense transaction, choose the funding account and category, deduct the balance, and complete the linked savings goal.
  - **Bidirectional Cascade Handling:** Deleting a savings goal safely unlinks its wishlist item, and deleting a wishlist item safely unlinks its savings goal.
  - **SavingsGoalDetailScreen Indicator:** Shows an emerald banner when a savings goal is linked to a wishlist item with current status.
  - **Full 11-Locale Localization:** Localized across all 11 languages.
- **Rollover (Envelope) Budgeting (Schema v22)**: Carries over unspent surplus or overspending deficits into subsequent budget periods:
  - **Calculation Engine:** Computes previous period's unspent surplus or deficit and adjusts current period allowance: $\text{EffectiveAllowance} = \max(0.0, \text{BaseBudget} + \text{Rollover})$.
  - **Visual Breakdown:** Budget cards display "Rollover" badges and itemized strips: *"Base: \$300.00 • Rollover (Aug): +\$45.00 • Total Available: \$345.00"*.
  - **Envelope Toggle:** Material 3 SwitchListTile in budget sheet allows enabling rollover per category.
  - **Notifications & Home Widget:** Budget alert thresholds and widget sync track dynamic effective allowances.
- **Credit Card Statement & Settlement Workflow (`CreditCardSettlementSheet`)**: Fully integrated statement billing cycle tracker and 1-tap bill payment workflow:
  - **Statement Billing Cycle Engine (`getCreditCardStatement`):** Calculates statement date, statement period expenses vs. unbilled charges, available credit, and credit utilization percentage ($\text{Current Outstanding Debt} / \text{Credit Limit}$).
  - **AccountsScreen Credit Card UI Overhaul:** Rendered cards in the "Cards" tab feature a multi-tier color-coded utilization progress bar (Green: $< 30\%$, Amber: $30\% - 70\%$, Red: $> 70\%$), statement cycle vs. unbilled breakdown, due date countdown with overdue/due-soon alerts, and an "All caught up" banner when debt-free.
  - **1-Tap Settlement Modal (`CreditCardSettlementSheet`):** Seamless bill payment sheet auto-selecting the user's linked/primary funding account, offering 1-tap choices (Full Statement Balance, Total Balance, Minimum Payment, or Custom Amount), performing an instant bank-to-card transfer, and rescheduling reminders.
  - **Credit Card Setup Parity:** Added Statement Day and Minimum Payment Amount fields to `_CardSheet` and `_AccountSheet`.
  - **Notification Synchronization:** Updated `CreditReminderService` to automatically cancel due reminders when a credit card's outstanding balance is paid in full.
  - **Full 11-Locale Localization:** Added `creditCard_*` keys across all 11 supported languages.
- **Wealth Management Engine & Net Worth Reactivation (`NetWorthScreen`, `NetWorthSnapshot`)**: Fully implemented accurate Assets vs. Liabilities financial mathematics in `AppProvider`:
  - **Assets Breakdown:** Liquid bank/cash/wallet balances (`totalLiquidAccountsValue`), physical gold spot valuation (`totalGoldValue`), fixed and financial assets (`totalAssetsValue`), and unsettled money lent to others (`totalLentMoneyValue`).
  - **Liabilities Breakdown:** Negative account balances / credit card debts (`totalDebtAccounts`), outstanding loan balances payable (`totalOutstandingLoanDebt`), and unsettled money borrowed from others (`totalBorrowedMoneyValue`).
  - **Live Net Worth:** Dynamically computed as $\text{Total Assets} - \text{Total Liabilities}$.
  - **Automated Daily Snapshots (`recordNetWorthSnapshot`):** Automatically captures and updates daily net worth snapshots in `net_worth_snapshots` on startup and on any balance-affecting transaction, transfer, account, loan, loan payment, asset, or debt change.
  - **Modernized Net Worth Screen (`NetWorthScreen`):** Revamped standalone view featuring a hero card with debt-to-asset ratio badges, interactive trend chart with multi-timeframe filter chips (`7D, 30D, 90D, 1Y, ALL`), touch tooltips, proportional visual distribution bars, itemized asset/liability cards with direct drill-down navigation, quick action shortcuts, and historical snapshot ledger with day-over-day deltas.
  - **Navigation Integration:** Prominently exposed `NetWorthScreen` in `MoreScreen` and updated the `InsightsScreen` Net Worth card with live assets/liabilities breakdown and 1-tap routing.
  - **Complete 11-Locale Localization:** Added `netWorth_*` keys across all 11 supported languages.
- **Split Transactions (Multi-Category Splitting, `SplitTransactionSheet`)**:
  - Distributed expense logging across multiple categories in `AddTransactionScreen` with live validation header (`Total | Allocated | Remaining`), 1-tap "Fill Remaining" balance auto-fill, individual split category selectors and note fields, and full integration with the docked `AppNumericKeypad`.
  - **Split Breakdown Bottom Sheet (`SplitTransactionSheet`):** Interactive inspection modal showing itemized breakdown with category dots, percentage allocation pills, item notes, and 1-tap edit navigation.
  - **Split-Aware Financial Aggregations:** `AppProvider.budgetSpent`, budget alert notifications, and `StatisticsScreen` category breakdown charts now itemize split transactions into their respective category amounts rather than lumping into a single category.
  - **Complete 11-Locale Localization:** Added localized translations for split transactions across all 11 languages.
- **Quick Presets & 1-Tap Transaction Logging (Schema v21, `PresetsCarousel`, `PresetSheet`)**: Added `transaction_presets` and `transaction_splits` tables with automated Drift schema migration from v20 to v21. Users can create reusable presets for frequent expenses (e.g., daily coffee, commute fare, lunch), log them with 1-tap directly from `HomeScreen` via `PresetsCarousel` (with instant Undo snackbar), and quick-fill `AddTransactionScreen` via preset chips. Includes full management modal `PresetSheet`.
- **Database Engine Upgrade to Drift (`AppDatabase`)**: Migrated database layer from legacy Sqflite to Drift (`drift: ^2.35.0` + `sqlite3_flutter_libs`) running asynchronously via Dart FFI in a background isolate, delivering type-safe queries, isolate multi-threading, and robust compile-time schema validation.
  - **Zero-Downtime Database Bridge:** `DBHelper` now seamlessly routes all CRUD queries, aggregations, transactions, and JSON backup/restore methods through `AppDatabase.instance`, preserving 100% backward compatibility with all providers and UI screens.
  - **Comprehensive Drift In-Memory Unit Test Suite:** Added tests covering table schema generation, category seeding, account and transaction CRUD, and JSON backup/restore integrity.
- **More Tab 2-Column Sectioned Grid (`MoreScreen`)**: Reorganized the entire More screen into an intuitive, responsive 2-column grid categorized into three distinct functional sections with standard 140px bottom spacing:
  - **Financial Tools:** Currency Converter, Wishlist, Lent Money, Assets, and Loans.
  - **Analytics & Insights:** Net Worth, Statistics, Insights, Yearly Analysis, Financial Calendar, and Expensy Wrapped.
  - **Preferences & Data:** Categories, Export Transactions, Backup & Restore, and Settings.
  - Features compact card tiles with semantic icon badges, chevron indicators, and haptic feedback.
- **Floating Rounded-Corners Navigation Bar**: Redesigned floating navigation bar (`extendBody: true`) to a floating rounded corners rectangle (`BorderRadius.circular(22)`), enlarged height (64px) and comfortable width (20px horizontal margins), with the active tab selection highlight redesigned to a rounded corner square (`RoundedSquareBorder(borderRadius: 14, size: 40)`), 24px icon-only destinations (`alwaysHide` labels), and elevation shadow.
- **Expanded `ExpandableFab` (`ExpandableFabItem` list model)**: Added to the Transactions screen (Income/Expense actions) and the Budgets & Goals screen (Add Budget / Add Savings Goal actions, with matching green `0xFF2E7D32` buttons).
- **Redesigned Yearly Analysis Monthly Cards (`YearlyAnalysisScreen`)**: Month-by-month planned cash flow forecast for a 24-month horizon, featuring visually readable summary grid cards for inflows and outflows, net cash flow balance pills, custom section icons, larger typography, and smooth expand animations.
- **Loan Transfer Account Feature**: Setting up a loan automatically deposits the principal into a selected account, and deleting the loan (or undoing it) reverses the deposit.
- **Redesigned Recurring Payment UI (`RecurringDetailScreen`)**: Payment history and recurring payment details are now shown in a dedicated `RecurringDetailScreen` with stats grids and card-based payment history lists. Restored progress bars inside installment recurring cards.

### Changed
- **Transaction Form Save Button Repositioned Under Keypad (`AddTransactionScreen`)**: Moved the primary submit / Save action ("Save Changes" / "Add Transaction") out of the scrollable form body and docked it directly underneath the permanently docked `AppNumericKeypad` (and floating above the soft-keyboard when editing text fields), providing effortless 1-tap accessibility without requiring users to scroll through the form.
- **Backup & Restore Action Hierarchy Optimization (`BackupScreen`)**: Moved actionable cards ("Create Backup", "Restore Backup", and "Import from Other Apps") to the very top of the screen, placing the informational "What's Included" breakdown and count indicators underneath them for a significantly faster user workflow.
- **Floating Navigation Bar Layout Clearances**: Shifted all Floating Action Buttons (FABs) down to a 76px bottom padding offset to float cleanly right above the new floating navigation bar, and updated main screen scroll view bottom paddings to 140px to ensure full scrolling space above the bar.
- **Loan Management**: Moved the delete button in the loan sheet form from the sheet header to a dedicated AppBar action in `LoanDetailScreen`.
- **Budget Metrics**: Restored the "Left to Spend" calculation on the budgets tab to show the subtraction between total monthly recurring income and total monthly budgeted amount.
- **Card Styling Parity**: Restyled the budgets and goals cards to match the exact card style used in recurring payments, and changed summary strip backgrounds to transparent to cleanly blend with the black AMOLED theme.
- **Savings Goal Date Selection**: Updated the Savings Goal sheet target date text field to open a native calendar date picker dialog instead of manual text input.

### Fixed
- **Navigation Bar Tab Press Highlight Artifact (`MainShell`, `AppTheme`)**: Fixed a visual glitch where tapping or pressing any navigation destination rendered an unshaped rectangular Material ink splash/highlight overlay inside the rounded-corner square indicator. Configured `overlayColor: WidgetStateProperty.all(Colors.transparent)` on `NavigationBarThemeData` and wrapped the navigation bar with `splashFactory: NoSplash.splashFactory`, ensuring only the clean rounded-square selection indicator (`RoundedSquareBorder(borderRadius: 14, size: 40)`) displays without rectangular state layer clipping artifacts.
- **Onboarding Skip for Now Button (`OnboardingScreen`)**: Fixed a page index mismatch in the onboarding wizard where the "Skip for now" button was improperly displayed on the Currency selection screen and missing from the "Add a Card" screen. Corrected step index routing (`_page == 4` for Account, `_page == 5` for Card) so users can skip card creation cleanly, and localized the button across all 11 supported languages (`onboarding_skipForNow`).
- **Gold Purity Percentage Above 100% (`AccountsScreen`)**: Fixed a calculation typo where gold karat purity was multiplied by 140 instead of 100 (`karat / 24 * 100`), which caused 24k gold to erroneously show as 140% and inflated all karat chips, account cards, and live breakdown percentages. Karat chips and cards now properly show 100% (24k), 92% (22k), 88% (21k), 75% (18k), 58% (14k), 42% (10k), and 38% (9k).
- **Gold Sheet Character Encoding Artifact (`_GoldPreviewCard`)**: Fixed an encoding issue where the multiplication sign in the live gold breakdown was displaying as a corrupted `Ã—` (`Weight Ã— purity` and `${grams} g Ã— ${purity}%`), replacing it with a clean Unicode multiplication sign (`×`).
- **Transaction Form Amount Field Highlight Alignment (`AddTransactionScreen`)**: Resolved an issue where tapping the amount input caused an ink highlight to appear underneath the input container in the helper text area rather than surrounding the field. Replaced the outer `InkWell` and `IgnorePointer` wrapper with direct `TextField` focus management and a focused primary border outline cleanly surrounding the field boundaries.
- **Transactions Screen Multi-Selection Back Gesture**: Pressing/swiping back while in multi-selection mode on the Transactions screen now gracefully exits the selection mode instead of popping back to the home page.
- **Budget & Savings Goal Deletion Undo**: Added Undo snackbar support when deleting budgets and savings goals, aligning them with the rest of the application's delete-undo pattern.
- **Home Screen Stale Record on Edit**: Fixed an issue where editing a transaction without changing its amount caused the home screen to display the stale record until app restart or adding a new record.
- **Recurring Payments Installment Reset**: Fixed an issue where clicking Pay or Skip on an installment recurring payment reset its type to subscription and incorrectly moved it to the Subscriptions tab.
- **ProGuard / R8 Hardening**: Resolved app crashes and black-screen issues in Release builds by configuring `proguard-rules.pro` to keep GSON type parameters (resolving alarm manager trigger crash) and protecting `home_widget` communications from obfuscation.
- **Resource Shrinking Protection**: Prevented background service crashes by creating `keep.xml` to protect custom notification icons (`ic_notification`) from resource shrinking, and updating reminder services to use proper resource paths.
- **Savings Goal Detail Screen Cast Exception**: Fixed a white screen rendering crash caused by an invalid runtime cast of `DateTime` targetDate to `String?`.
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

