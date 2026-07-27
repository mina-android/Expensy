# Expensy — New Features Implementation Plan

**Scope:** (1) Budget-exceeded notifications, (2) daily 10 PM "add your transactions" reminder with a settings toggle, (3) haptic feedback on taps/navigation, (4) a new "Goals" sub-tab under a renamed "Budgets & Goals" tab, with reversible goal contributions and completion notifications.

**This is a plan only — no implementation.** Written against the actual v1.0.7+9 source (`expensy.zip` upload), referencing real classes, files, and method signatures so it can be handed to an implementer directly.

**Status:** All open questions from the previous draft are now resolved and incorporated below:
1. Savings goals use **Path A** (separate model, not a real `Account`) — locked in.
2. Goal contributions support **reversal/withdrawal** — in scope.
3. Goal contributions are surfaced in the main Transactions tab **the same way Lent/Borrowed entries are** — locked in.
4. Budget-exceeded alerts **stack** — one notification per over-limit transaction, not a single replaced alert.
5. Model is named **`SavingsGoal`**; the bottom-nav tab is renamed from **"Budgets" to "Budgets & Goals"**, internally split into two sub-tabs: **"Budgets"** and **"Goals"**.

---

## 1. Budget-Exceeded Notifications

### Trigger model
Every time an expense transaction is added against a category that has an active `Budget`, check whether that budget is now exceeded. This runs **on every add**, not just the first time it crosses the line — confirmed: repeated over-limit expenses each fire their **own** notification. A user who makes 5 over-budget purchases in a day gets 5 stacked notifications in the tray, not one replaced alert.

### Where this hooks in
- `AppProvider.addTransaction(AppTransaction t)` (`app_provider.dart`) is the single call site for all transaction inserts from the Add Transaction screen. Transfers use their own debit/credit path (`addTransfer()`) and should **not** trigger budget alerts, since a transfer isn't spending against a category budget in the same sense.
- After the existing `_updateAccountBalance()` + `notifyListeners()` sequence in `addTransaction()`, add: if `t.type == 'expense'`, look up `budgetForCategory(t.categoryId)`. If a budget exists, compute `budgetExceeded(budget)` (already exists as a provider getter) using the state **after** this transaction has been applied. No new spend-calculation logic needed — only a new notification hook consuming existing getters.
- Fire **only** when `budgetExceeded(budget) == true` after this transaction. Do not fire for transactions that keep the budget under its limit, and do not fire retroactively for a budget that was already over limit before this transaction if this specific transaction wasn't itself an expense against that category.
- Same hook logic is added to `updateTransaction(updated, original)` — check the **updated** transaction's budget state (not the original) after the update is applied. An edit that pushes a previously-under-budget category over the line fires the same way an add would.
- Transaction **delete**, or an edit that brings spend back under budget, **never** fires anything — this is a pure "money going out" trigger, never a "money coming back" trigger.

### New service: `BudgetNotificationService`
Following the codebase's established pattern of **one dedicated singleton service per notification concern** (`NotificationService` for recurring, `LendedNotificationService` for lent/borrowed — see CLAUDE.md §7/§15.35), add a third: `lib/services/budget_notification_service.dart`. This service is also used for goal-completion alerts (§4.6), since both are "fire immediately on an event" rather than "schedule for a future date" — structurally the two are the same underlying mechanism, so one service covers both triggers rather than creating a fourth near-identical file.

- New channel: `expensy_budget` / "Budget & Goal Alerts" — `Importance.high`, `enableVibration: true`, `playSound: true`, registered eagerly in `main.dart` alongside the existing two `initialize()` calls (`NotificationService().initialize()`, `LendedNotificationService().initialize()`).
- This is an **immediate** notification via `_plugin.show(...)`, not `zonedSchedule(...)` — it fires at the moment the triggering transaction is added, not on a future date. This is a genuinely new code path relative to every existing notification in the app (which are all pre-scheduled alarms).
- **Notification ID formula (stacking, confirmed):** each call generates a **distinct** ID so notifications accumulate in the tray rather than replacing each other. Recommended formula: `('budget_${budget.id}_${DateTime.now().millisecondsSinceEpoch}').hashCode & 0x7FFFFFFF` — timestamp-suffixed so the same budget can produce multiple simultaneous notifications, unlike every existing ID formula in the app which is deliberately stable/idempotent for replace-on-reschedule semantics. This is a deliberate, documented exception to the "stable ID" convention used everywhere else (CLAUDE.md §15.14) and should be commented as such in code so a future session doesn't "fix" it into a stable ID by mistake.
- Body text: category name, amount over budget (raw `spent - amount`, computed inline since `budgetRemaining()` is clamped to zero and unsuitable here), and the budget period (e.g. "🚨 Over Budget: {categoryName} — {overAmount} over your {period} limit"). Uses `formatAmount()` and `AppCategory.name` — both already available via `categoryById()` and `budgetSpent()`/`budget.amount`.

### New settings field
- `bool budgetAlertsEnabled` on `AppSettings` (default `true`), following the `amoledSurfaces` extension pattern — a `SwitchListTile` in the new Budgets sub-tab (or Settings) lets users mute this without deleting their budgets. Default **on** (unlike the daily reminder, this is reacting to data the user already opted into by creating a budget, so on-by-default is reasonable and consistent with how budgets already silently track overage today).

### Permission handling
- Respect `hasPermission()` gating the same way the other two services do — never attempt `_plugin.show()` without confirming permission first, and never prompt for permission mid-transaction-save (jarring UX). Permission should be requested the first time `budgetAlertsEnabled` is toggled on, mirroring how `LendedPersonScreen` requests permission on first reminder toggle (CLAUDE.md §16.3).

---

## 2. Daily 10 PM "Add Your Transactions" Reminder

### Nature of this reminder
Unlike recurring-payment or lent/borrowed reminders (tied to a specific data record with its own due date), this is a single **global, repeating** daily alarm — closer to a habit nudge than a data-driven reminder.

- `flutter_local_notifications`' `zonedSchedule()` supports `matchDateTimeComponents: DateTimeComponents.time`, specifically for "same time every day" repetition. This is different from every existing scheduled call in the codebase, all of which use `_toUtcTZDate()` for a **one-shot** specific date + time with no repeat semantics. This is a genuinely new scheduling pattern for the app.

### Where this lives
- New dedicated service: `lib/services/daily_reminder_service.dart`. `NotificationService` explicitly documents itself in its file header as "for RECURRING PAYMENT reminders only," so folding an unrelated global daily alarm into it would break that documented separation of concerns. A small standalone service keeps the one-service-per-concern convention intact.
- New channel: `expensy_daily_reminder` / "Daily Transaction Reminder" — `Importance.high`, same shape as the others.

### Settings field & UI
- New `AppSettings` fields, following the `amoledSurfaces`/`appFont` extension pattern exactly:
  - `bool dailyReminderEnabled` — default `false` (opt-in; don't surprise existing users with a new nightly notification on upgrade).
  - `String dailyReminderTime` — default `'22:00'`, stored as an `'HH:mm'` string mirroring `RecurringPayment.reminderTime`'s exact format, even though the picker UI is fixed/hidden for this pass (per the literal spec: "everyday at 10:00PM"). Storing it as a configurable-shaped field now — rather than hardcoding `22` and `0` directly in the service — means a future version can expose a time picker with zero schema change, just a new UI control bound to an already-existing field.
- New Settings UI: a `SwitchListTile` ("Daily Reminder — 10:00 PM") in `settings_screen.dart`, in a new small section near the other toggles (AMOLED toggle is the closest existing analog — same widget type, same on-toggle permission-request behavior).
- On enable: request notification permission if not already granted (`requestPermissions()`, same pattern as the other two services), then schedule the repeating alarm. On disable: cancel it (`_plugin.cancel(dailyReminderId)`).

### Rescheduling considerations
- Not tied to any data record, so it doesn't fit into the existing event-driven reschedule points (`addRecurring`/`updateLended`/etc., CLAUDE.md §6). It's (re)scheduled only when the setting is toggled, **and** re-armed on `restoreBackup()` if `dailyReminderEnabled` was `true` in the restored settings — following the same spirit as `rescheduleAll()` being called post-restore for the other two notification types.
- **Boot-time re-confirmation (decision, not left open):** re-confirm the schedule on every `AppProvider.load()` when `dailyReminderEnabled == true`, rather than relying solely on `RECEIVE_BOOT_COMPLETED` to survive reboots. This is a single idempotent `zonedSchedule()` call with a stable ID — cheap to re-arm every launch, and more robust against OEM background-restriction quirks (which `matchDateTimeComponents` repeating alarms are more exposed to than the app's existing one-shot alarms) than a register-once-and-hope approach.

### Notification content
Simple, static text — no dynamic data, no currency formatting: e.g. "📝 Don't forget to log today's spending." No payload/deep-link behavior for this pass, since the existing notification tap-handling (`payload:` field on other notification types) is not confirmed to be consumed anywhere in `_plugin.initialize()`'s callback — adding tap-to-navigate would be new plumbing outside this feature's scope, not a copy of existing behavior.

---

## 3. Haptic Feedback on Taps & Major Navigation

### Current state
No haptics package or `HapticFeedback` call exists anywhere in the codebase today — a clean, additive feature with no conflicting prior art to reconcile.

### Package choice
Flutter's built-in `HapticFeedback` class (`flutter/services.dart`) — **no new pubspec dependency needed**, it's part of the Flutter SDK. Preferred over a third-party haptics package unless a specific custom-pattern need emerges; the four built-in intensities (`selectionClick`, `lightImpact`, `mediumImpact`, `heavyImpact`) cover "clicks and major navigation" fully.

### Scoping (two tiers)
- **Tier 1 — Navigation:**
  - Bottom `NavigationBar` tab switches in `main_shell.dart` — `HapticFeedback.selectionClick()` (standard convention for tab/segment selection)
  - Screen pushes from primary entry points (More-tab list items, FAB-triggered pushes, tapping a `_BudgetCard`/`_SavingsGoalCard`/account card into its detail screen) — **not** hooked at the generic `ExpensyRoute` level, since that would also fire on every sub-sheet push and feel noisy
  - Bottom sheet open (`showModalBottomSheet` call sites: `_AccountSheet`, `_BudgetSheet`, `_SavingsGoalSheet`, `_ContributeSheet`, `_EntrySheet`, `_RecurringSheet`, etc.) — a light haptic on open
- **Tier 2 — Confirming/destructive actions:**
  - FAB taps (add account, add transaction, add budget, add goal, etc.) — `HapticFeedback.lightImpact()`
  - Delete confirmations via `showDeleteConfirm()` — a single shared helper in `shared_widgets.dart`, so this is a **one-line change with app-wide effect**, the highest-leverage single hook in the whole feature — `HapticFeedback.mediumImpact()` (destructive but not alarming)
  - Settle/Pay/Skip actions (lended entries, recurring payments) and goal contribute/withdraw actions — `HapticFeedback.lightImpact()`
  - Toggle switches (AMOLED, daily reminder, budget alerts, haptics itself) — `HapticFeedback.selectionClick()`

**Explicitly excluded** from this pass: generic list-item taps, text field focus, scrolling — these would make the app feel buzzy rather than polished.

### Settings toggle
`bool hapticsEnabled` on `AppSettings`, default `true`. A `SwitchListTile` in Settings. All haptic calls are gated through this single flag.

### Implementation shape
A single small wrapper rather than raw calls scattered at 15–20 sites — e.g. a static helper `HapticsHelper.tap(HapticStrength strength)` (or a top-level function taking the provider's `hapticsEnabled` value) that checks the setting once and dispatches to the right underlying `HapticFeedback` method. Keeps every call site a one-liner and makes the global on/off toggle correct everywhere at once.

---

## 4. "Budgets & Goals" Tab — Savings Goals with Reversible Contributions

This is the largest feature of the four — new data models, two new DB tables, a schema migration, a tab rename + sub-tab split, integration into the unified Transactions view, and reuse of the immediate-notification service from §1.

### 4.0 Naming & tab structure (locked in)
- Bottom-nav tab label changes from **"Budgets"** to **"Budgets & Goals"** (`main_shell.dart` `NavigationDestination` label + `budget_screen.dart` `AppBar` title).
- The tab's icon (`Icons.pie_chart_outline_rounded` / `Icons.pie_chart_rounded`) stays the same — no icon change requested or needed, since the icon isn't specifically "budget-only" in meaning.
- Internally, `BudgetScreen` gains a `TabBar` with exactly two sub-tabs: **"Budgets"** (existing content, unchanged) and **"Goals"** (new).
- The savings-goal model itself is named **`SavingsGoal`**, not `SavingsAccount` — this avoids colliding with the existing literal `Account.type == 'savings'` value (CLAUDE.md §4). All UI copy inside the Goals sub-tab says "Savings Goal" / "Goal," never bare "Savings account," to keep the two concepts visually and linguistically distinct for the user.

### 4.1 New data model — `SavingsGoal`
Following the exact shape of existing simple models (`WishlistItem`, `AssetItem`):
```
id, name, targetAmount, currentAmount, currency, targetDate (nullable),
colorValue, isCompleted, createdAt, completedAt (nullable)
```
- `currentAmount` is the running total contributed, maintained by the provider (not derived by summing on every read, though summing-on-read from `SavingsContribution` rows is also a valid implementation choice worth weighing for correctness-over-cache-invalidation reasons — see §4.4/§4.5).
- `isCompleted` flips to `true` (with `completedAt` stamped) the moment `currentAmount >= targetAmount`; flips back to `false` (with `completedAt` cleared) if a withdrawal brings `currentAmount` back under `targetAmount` (reversal is in scope, so completion state must be re-evaluated on every contribution **and** every withdrawal, not just contributions).
- Needs `toMap()`/`fromMap()`/`copyWith()` matching every other model's convention.

### 4.2 New data model — `SavingsContribution`
Mirrors `LendedMoney`'s shape, since a goal's ledger is structurally the same idea as a person's lend/borrow ledger:
```
id, goalId, amount, accountId, type, date, note
type: contribution | withdrawal
```
- `type` distinguishes money moving **into** the goal (`contribution`, debits the real account, credits the goal) from money moving **out** (`withdrawal`, credits the real account back, debits the goal) — this single field is what makes reversal possible without a separate table or a signed-amount convention that's easy to misread later. An explicit `type` string (matching the existing `LendedMoney.type: lent | borrowed` convention) is preferred over a signed/negative `amount` for the same readability reasons that pattern was chosen there.

### 4.3 Architecture — confirmed Path A
`SavingsGoal` is a genuinely separate model from `Account`, architected like `LendedPerson`:
- Has its own table, own ledger (`SavingsContribution`, like `LendedMoney`), and a computed or maintained running balance (`currentAmount`, like `personBalance()`).
- **Never** added to `app.accounts`, never appears in `AccountCardPicker`, `totalBalance`, `totalBalanceAll`, or transfer pickers — the same isolation `LendedPerson` already has from real `Account`s (CLAUDE.md §15.32).
- **Net-worth treatment (decision):** money sitting inside a `SavingsGoal.currentAmount` is **excluded** from `totalBalance`/`totalBalanceAll`/`totalAssetsValue`. The money already left a real `Account` (via the contribution's debit) and is being tracked separately by the goal — counting it again in a goal-aware net-worth figure would double-count it. If a "total net worth including goals" figure is ever wanted, it should be a distinct new computed getter, not a change to the existing `totalBalance` semantics.

### 4.4 Contribute (deposit into a goal)
New provider method:
```dart
Future<void> contributeToGoal({
  required String goalId,
  required String fromAccountId,
  required double amount,
  String note = '',
}) async
```
- Deducts `amount` from the real `Account` (`fromAccountId`) exactly like a transfer's debit side — reuse `addTransfer()`'s existing currency-conversion logic if the goal's currency differs from the source account's currency.
- Inserts a `SavingsContribution` row with `type: 'contribution'`.
- Increments `SavingsGoal.currentAmount`.
- Checks for goal completion: `if (!wasCompletedBefore && currentAmount >= targetAmount)` → sets `isCompleted = true`, stamps `completedAt`, and fires the completion notification (§4.6) via `BudgetNotificationService`. The `!wasCompletedBefore` guard is required so re-contributing to an already-completed goal (if the UI allows over-funding past the target) never re-fires the notification.
- All of this — account balance update, contribution insert, goal update, and any notification-triggering state flip — happens inside a single `db.transaction()`, per the project's non-negotiable finance-correctness rule (never a silent `catch (_) {}`, always transactional multi-step writes).

### 4.5 Withdraw (reversal — in scope)
New provider method:
```dart
Future<void> withdrawFromGoal({
  required String goalId,
  required String toAccountId,
  required double amount,
  String note = '',
}) async
```
- Mirror image of `contributeToGoal()`: credits `amount` back to the real `Account` (`toAccountId`), inserts a `SavingsContribution` row with `type: 'withdrawal'`, decrements `SavingsGoal.currentAmount`.
- **Validation:** `amount` cannot exceed the goal's current `currentAmount` (can't withdraw more than has been saved) — enforced in the provider method itself, not just the UI, consistent with the project's "silent data errors are unacceptable" principle. Surface a clear error (not a silent clamp) if the UI somehow allows an over-withdrawal attempt to reach the provider.
- If this withdrawal brings `currentAmount` below `targetAmount` on an already-completed goal: `isCompleted` flips back to `false`, `completedAt` is cleared. This does **not** fire any notification — going below target is a neutral/negative event, not a milestone worth alerting on, and un-firing a past notification isn't meaningful (the tray notification, if still present, is simply left as historical — no attempt is made to retract it).
- Same single-`db.transaction()` requirement as §4.4.
- UI entry point: a "Withdraw" action alongside "Contribute" on the goal detail screen (§4.10), and/or a type toggle (Contribute/Withdraw) inside a single combined `_ContributeSheet`, mirroring how `_EntrySheet` in `lended_person_screen.dart` already uses a Lent/Borrowed toggle inside one sheet rather than two separate sheets — the same UI pattern applies directly here (Contribute/Withdraw toggle in one sheet).

### 4.6 Completion notification
- Reuses `BudgetNotificationService` (§1) — same channel family, same immediate `_plugin.show()` mechanism, different body copy: e.g. "🎉 Goal reached: {goalName}!" including the target amount via `formatAmount()`.
- Fired exactly once per completion crossing, per the `!wasCompletedBefore` guard in §4.4. If a goal is completed, later withdrawn-below-target, then re-contributed back up to target, the notification **does** fire again on that second crossing — this is intentional (each time the milestone is genuinely reached is worth celebrating again), not a bug to guard against.
- Same `budgetAlertsEnabled` setting from §1 gates this notification too (rename the setting's UI label to "Budget & Goal Alerts" to reflect that one toggle now covers both triggers) — no separate settings field needed since both are the same underlying "milestone alert" concept firing through the same service.

### 4.7 Visibility in the main Transactions tab (confirmed: Lent/Borrowed-style)
Per your confirmation, goal contributions and withdrawals appear in `transactions_screen.dart` the same way lent/borrowed entries already do (CLAUDE.md §16.1):
- A lightweight `_TxItem`-style display wrapper surfaces `SavingsContribution` rows alongside `AppTransaction` rows in the unified list.
- Two new filter pills added to the existing filter chips bar, alongside the existing `Lent` (blue `#1565C0`) / `Borrowed` (orange `#E65100`) pills: **`Saved`** (contribution, suggest a distinct green, e.g. `#2E7D32`, consistent with the app's existing "positive/income" green used elsewhere) and **`Withdrawn`** (suggest a neutral amber/grey, e.g. `#6D4C41`, to read as "reversal," distinct from both the expense-red and income-green vocabulary already in use).
- A `_GoalContributionTile` (parallel to the existing `_LendedTile`) shows: goal name + colour swatch, cash-flow indicator (`-` for contribution — money leaving the source account — `+` for withdrawal — money returning), amount, date, and a tap target that navigates to the goal's detail screen (`ExpensyRoute` → `SavingsGoalDetailScreen`), mirroring `_LendedTile`'s `onTap` → `LendedPersonScreen` behavior exactly.
- These rows are included in the existing search query and account-filter logic the same way `LendedMoney` records already are (CLAUDE.md §16.1's "Integrated `LendedMoney` records into transactions search queries and account filters" — the same integration point gets a second data source added to it).
- **Sign convention note:** unlike `LendedMoney` where `lent` is money leaving your control and `borrowed` is money you now hold, a goal **contribution** is money leaving a real spendable account (economically similar to `lent` in cash-flow direction, even though it's not a loan) and a **withdrawal** is money returning to a spendable account (similar direction to `borrowed` being settled). Keep this distinct in code/comments from the lended sign convention (CLAUDE.md §15.33) so a future reader doesn't conflate "contribution = borrowed-like" as anything other than a surface-level cash-flow-direction analogy.

### 4.8 New DB tables & migration
- Schema bump: **v10 → v11**, following the exact migration discipline in CLAUDE.md §5/§15.19/§15.36 — new tables via `CREATE TABLE IF NOT EXISTS`, guarded by `if (oldV < 11)`.
```sql
savings_goals(id, name, target_amount, current_amount, currency,
              target_date, color_value, is_completed INTEGER NOT NULL DEFAULT 0,
              created_at, completed_at)
savings_contributions(id, goal_id, amount, account_id, type, date, note)
```
- `_normaliseBackup()` needs new entries for both tables (empty-list defaults for old backups; per-row field defaults — e.g. `type → 'contribution'` for any hypothetically malformed row, `notes → ''`), following the exact pattern used for `lended_people`/`lended_money` in the v9→v10 migration.
- `exportAll()`/`importAll()` need both new table keys added to the known-tables set, inserting `savings_goals` **before** `savings_contributions` (same ordering discipline as `lended_people` before `lended_money`, so contribution rows always find their parent goal already present on restore).
- Backup format version bumps to 11. The backup screen's data-driven table list (CLAUDE.md §15.31) picks up the two new tables automatically **if** their counts are added as live getters (e.g. `savingsGoalsCount`, `savingsContributionsCount` or a combined count) the same way `recurringHistoryCount` was added — not hardcoded.
- `deleteSavingsGoal(id)` cascades: deletes all `SavingsContribution` rows for that goal before deleting the `SavingsGoal` row itself, inside one `db.transaction()` — mirroring `deleteLendedPerson()`'s cascade exactly (CLAUDE.md §6). Does **not** reverse any account balance effects from past contributions/withdrawals tied to that goal, for the same reason `deleteLendedPerson()` doesn't reverse historical balance deltas (CLAUDE.md §6) — if this matters for a given workflow, withdraw everything back to zero first.

### 4.9 UI — `budget_screen.dart` restructure
- Currently a flat `StatelessWidget` with a single `Scaffold` and no `TabController`/`TabBar` (confirmed in source). Converts to a `StatefulWidget` wrapping a `DefaultTabController` (2 tabs: **"Budgets"**, **"Goals"**) with a `TabBar` below the `AppBar` — structurally modeled on `recurring_screen.dart`'s existing 2-tab (Expenses/Income) `TabController`, the closest existing precedent for this exact pattern in the codebase.
- `AppBar` title changes to **"Budgets & Goals"**.
- **Budgets sub-tab:** existing content (summary strip + `_BudgetCard` list + `_BudgetSheet`) moves in unchanged — no behavior change to existing budget functionality.
- **Goals sub-tab (new):** `SavingsGoalsView` —
  - Summary strip mirroring the existing `_SumChip` row pattern: **Total Saved** (sum of all `currentAmount` across goals, converted to main currency), **Active Goals** count, **Completed** count.
  - List of `_SavingsGoalCard`s: name + colour swatch, progress bar toward target (visual language matches `_BudgetCard`'s progress bar but with **inverted colour meaning** — more progress is good here, not a warning, so recommend green-trending-toward-primary as progress increases rather than budget's primary→orange→error escalation), amount saved / target amount, optional target date with a countdown or overdue-style label if past due and incomplete.
  - Tap → `SavingsGoalDetailScreen` (§4.10) via `ExpensyRoute`.
  - Long-press → `showDeleteConfirm()` → `deleteSavingsGoal()`.
- **FAB behavior:** becomes tab-aware, same pattern already used in `recurring_screen.dart` ("FAB label changes per active tab," CLAUDE.md §10) — "Add Budget" on the Budgets sub-tab, "Add Goal" on the Goals sub-tab.
- New `_SavingsGoalSheet`: name, target amount, currency, optional target date picker, colour picker (reuse `kSeedColours` or a dedicated palette following the `kLendedPersonColors` precedent — a new `kSavingsGoalColors` palette is cleaner than overloading an existing one, since goals are visually distinct entities from both categories and lent/borrowed people).

### 4.10 `SavingsGoalDetailScreen` (new screen)
Modeled directly on `lended_person_screen.dart` — the established precedent for "detail screen for a ledger-owning non-`Account` entity":
- Header card (on `cs.primary`): goal colour/icon, big progress figure ("{currentAmount} of {targetAmount}"), progress bar, completion badge if `isCompleted`.
- Body: `_ContributionCard` list, most recent first, each showing type (Contribution/Withdrawal with up/down arrow + colour matching the Transactions-tab pills from §4.7), date, amount, note.
- FAB → `_ContributeSheet` with a Contribute/Withdraw toggle (§4.5's UI note) — amount field, source/destination `AccountCardPicker` (filtered `!a.isGold`, per CLAUDE.md §15.20 — no need to also filter out goals themselves since they're never real `Account`s in the first place, so no new filter predicate is needed beyond the existing gold filter).
- AppBar actions: edit goal (name/target/date/colour — a `_EditGoalInlineSheet` mirroring `_EditPersonInlineSheet`), delete goal (`showDeleteConfirm` → `deleteSavingsGoal`, cascades and pops back to the Goals sub-tab).

### 4.11 Provider additions (`AppProvider`)
```dart
List<SavingsGoal> savingsGoals
List<SavingsContribution> savingsContributions      // or lazy-load per-goal like recurring history, see below

Future<void> addSavingsGoal(SavingsGoal g)
Future<void> updateSavingsGoal(SavingsGoal g)
Future<void> deleteSavingsGoal(String id)             // cascade-delete contributions, mirrors deleteLendedPerson()
Future<void> contributeToGoal({required goalId, required fromAccountId, required amount, note})   // §4.4
Future<void> withdrawFromGoal({required goalId, required toAccountId, required amount, note})      // §4.5

List<SavingsContribution> contributionsFor(String goalId)   // sorted date DESC, mirrors lendedFor()
double goalProgress(SavingsGoal g)                            // (currentAmount / targetAmount).clamp(0,1)
double get totalSaved                                          // sum of currentAmount across all goals, converted to main currency
```
- `load()` boot sequence gains `savingsGoals` and either eager-loads all `savingsContributions` or lazy-caches them per goal the way `_historyCache` does for recurring history — recommend the lazy-cache approach for consistency with the existing precedent and to avoid loading potentially-large contribution history for goals the user never opens.

### 4.12 Interaction with Section 1 (Budget Alerts)
Since §4.6 reuses `BudgetNotificationService`, the rename of that service's settings toggle (`budgetAlertsEnabled` → surfaced in UI as "Budget & Goal Alerts") needs to happen as part of this feature, not deferred — otherwise the Goals sub-tab would ship with a completion notification gated behind a setting still labeled purely "Budget Alerts," which would confuse users into thinking it doesn't apply to goals.

---

## 5. Cross-Cutting Notes

- **Three notification services / four channels total after this work**: `expensy_recurring` (existing), `expensy_lended` (existing), `expensy_budget` (new — covers both budget-exceeded and goal-completed, since §4.6 reuses `BudgetNotificationService`), plus `expensy_daily_reminder` (new, kept separate — a habit nudge is a different notification "flavor" from a milestone alert, worth its own channel so a user can mute the nightly nudge without muting budget/goal milestones).
- **Permission requests stay contextual, not batched** — each feature requests notification permission the first time its own toggle is used, continuing the existing `LendedPersonScreen` precedent, rather than one blanket prompt.
- **Every new multi-step DB write goes through `db.transaction()`** — goal completion state flip + notification trigger, contribution/withdrawal insert + goal balance update, cascade deletes — per the project's non-negotiable finance-correctness rule. No silent `catch (_) {}` anywhere in this feature set.
- **New `AppSettings` fields introduced by this work:** `budgetAlertsEnabled` (bool, default true), `dailyReminderEnabled` (bool, default false), `dailyReminderTime` (String, default `'22:00'`), `hapticsEnabled` (bool, default true). All four follow the exact `amoledSurfaces`/`appFont` extension pattern — added to `toJson()`/`fromJson()` with safe-default fallbacks, and added to `_normaliseBackup()`'s settings-defaults table in `db_helper.dart` so old backups restore cleanly.
- **`CLAUDE.md` needs a full resync** after this work: new models (`SavingsGoal`, `SavingsContribution`), new DB tables + v10→v11 migration, three new/changed services, the `BudgetScreen` tab-split restructure, the new `SavingsGoalDetailScreen`, new Transactions-tab filter pills, and new numbered "Known Conventions & Rules" entries (continuing past #37) covering: the deliberately-non-idempotent budget-alert notification ID exception, the `SavingsGoal`-is-not-an-`Account` distinction, the shared `BudgetNotificationService` covering two trigger types, and the four new settings fields — so a future session doesn't need to re-derive any of this from source.
