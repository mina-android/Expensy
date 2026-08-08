# Expensy — Optimization Implementation Plan (Phase 1)

> Generated after a full read of `AI_INSTRUCTIONS.md`, `CLAUDE.md`, `README.md`, and every file in `lib/` (~21,600 lines across providers, database, screens, services, widgets — l10n excluded). This is a **safety-first, additive** plan: every item below is an internal/structural change only. No widget tree, layout, color, animation, copy, or navigation flow changes. If an item can't be done without visibly changing something, it is explicitly called out as **not included**.

---

## How to read this document

Each item has:
- **What** — the concrete code change
- **Why** — the measurable cost it removes
- **Safety** — why it cannot change what the user sees or how the app behaves
- **Files touched**

Items are ordered by impact-to-risk ratio, highest first. All are independent — they can be implemented and tested one at a time, in any order, and each can be verified with `flutter analyze` + a manual smoke test of the affected screen(s) before moving to the next.

---

## 1. Stop refetching entire DB tables after single-row writes (Provider layer)

**What:** `AppProvider` currently has **71 call sites** of the shape:
```dart
await DBHelper.insertX(x);
xs = await DBHelper.getXs();   // ← re-reads and re-decodes the WHOLE table
notifyListeners();
```
This pattern appears in `addAccount`, `updateAccount`, `deleteAccount`, `addCategory`, `updateCategory`, `deleteCategory`, `addRecurring`, `updateRecurring`, `deleteRecurring`, `addWishlist`, `updateWishlist`, `deleteWishlist`, `addLendedPerson`, `updateLendedPerson`, `addLended`/`updateLended`/`settleLended`/`deleteLended`, `addAsset`/`updateAsset`/`deleteAsset`, `addBudget`/`updateBudget`/`deleteBudget`, `addSavingsGoal`/`updateSavingsGoal`/`deleteSavingsGoal`, and `addTransfer`.

The fix is to replace each full refetch with an in-memory patch of the already-known list, exactly like the codebase already does correctly in `_updateAccountBalance()` (line ~775) and `deleteTransaction()`:
```dart
final idx = accounts.indexWhere((a) => a.id == id);
if (idx != -1) {
  final newList = List<Account>.from(accounts);
  newList[idx] = updatedAcc;
  accounts = newList;
}
```
For inserts: `xs = [...xs, newX]` (with a re-sort only where the getter applies one, e.g. `orderBy` in the DB query — matched exactly). For deletes: `xs = xs.where((x) => x.id != id).toList()`.

**Why:** Every one of these methods currently does an unnecessary round trip through SQLite — a full table `SELECT`, deserialization of every row back into Dart objects, and a full list replacement — to reflect a change to **one row**. On a phone with thousands of transactions/accounts/recurring entries (the exact scenario README's "High Performance... thousands of transactions" claims to target), this is O(n) disk + CPU work on every single add/edit/delete, where the change is only ever O(1). This is the single biggest, safest win in the codebase.

**Safety:** The resulting in-memory list is **byte-for-byte identical** to what a fresh `DBHelper.getXs()` call would return immediately after the write — same rows, same order (as long as insert/sort logic mirrors the `orderBy` clause used by each `getXs()`, which is straightforward to match per table since each is a single, fixed `orderBy`). No screen re-renders differently: `notifyListeners()` still fires at the same point, with equivalent data. This is invisible to the user by construction — it only removes redundant work, not different work.

**Caveat to implement carefully:** A few tables have non-trivial sort orders (`accounts` → `order_index ASC`, `categories` → `order_index ASC`, `transactions`/`lended_money` → `date DESC`, `wishlist`/`lended_people` → `created_at ASC/DESC`, `recurring_payments` → `start_date ASC`). Each patch must insert/sort to match. Where a mismatch risk exists (e.g. `reorderAccounts`/`reorderCategories`, which already patch in-memory and batch-write order_index), leave the existing logic untouched — it's already correct — and only change the simple CRUD methods listed above.

**Files touched:** `lib/providers/app_provider.dart` only. No screen files change.

---

## 2. Replace O(n) linear-scan lookups with O(1) map-based lookups

**What:** `accountById()`, `categoryById()`, and `personById()` are defined as:
```dart
Account? accountById(String id) => accounts.where((a) => a.id == id).firstOrNull;
```
These are called **inside loops** in several hot paths — `budgetSpent()` (once per transaction, called once per budget), `getAccountIncome`/`getAccountExpense` (once per transaction), `_txDelta()` (every add/update/delete transaction), and screen-level per-item builders (`_AccountCard`, transaction tiles, etc.). Each call is currently O(n) over the full list.

The fix: maintain a `Map<String, Account>`, `Map<String, AppCategory>`, and `Map<String, LendedPerson>` inside `AppProvider`, rebuilt (a single O(n) pass) only when the underlying list itself is reassigned (i.e., inside the same methods touched in Item 1, plus `load()`), and have `accountById`/`categoryById`/`personById` read from the map instead of scanning.

**Why:** Turns every lookup from O(n) into O(1). Since these lookups happen inside loops over transactions (which is the largest, fastest-growing table), the combined effect compounds: `budgetSpent()` alone is currently O(budgets × transactions × accounts) in the worst case; this reduces it to O(budgets × transactions).

**Safety:** Pure data-structure substitution behind an unchanged public method signature (`Account? accountById(String id)`). Every call site keeps working exactly as before, with the exact same return value for the exact same input — a map keyed by `id` returns the identical object a linear `id`-match scan would find, since `id` is the primary key. No UI, layout, or behavior changes anywhere.

**Files touched:** `lib/providers/app_provider.dart` only.

---

## 3. Add `context.select<AppProvider, T>()` at the top of each of the 6 main-nav screens

**What:** Every single screen in the app (`accounts_screen.dart`, `home_screen.dart`, `transactions_screen.dart`, `recurring_screen.dart`, `budget_screen.dart`, `more_screen.dart`, and all sub-screens) currently calls **`context.watch<AppProvider>()`** — a blanket subscription to the *entire* provider. `CLAUDE.md` (§ "State management") documents `context.select` as the intended pattern for "preventing full-app rebuilds," but it is used **zero times** anywhere in the current codebase — every screen uses the broad `watch`.

Because `MainShell` uses an `IndexedStack` (all 6 tabs mounted and alive simultaneously, per `AI_INSTRUCTIONS.md` §2.6 / `CLAUDE.md` §2), a single `notifyListeners()` call anywhere — an exchange-rate refresh tick, a budget check after adding one transaction, a widget-pin toggle — currently rebuilds **all six tab widget trees at once**, including the five the user isn't even looking at.

The fix is additive, not a rewrite: keep `context.watch<AppProvider>()` where a screen genuinely needs many different fields off the provider (this is most of them, and `watch` is fine there), but for the handful of narrow, high-frequency-rebuild cases, swap to `context.select`:
- `_RatesBanner` / the AppBar sync icon in `accounts_screen.dart` — only needs `app.ratesFetching` and `app.exchangeRates`, not the whole provider.
- The Home screen's balance-visibility icon and `hideBalance` toggle — only needs `app.settings.hideBalance`.
- Any other single-field read currently done via a full `watch` where the enclosing widget is otherwise `const`-able.

**Why:** Reduces the blast radius of unrelated state changes. Right now, e.g., background exchange-rate polling (which calls `notifyListeners()` twice per `_loadRates()` per `CLAUDE.md` §6) forces a full rebuild of the Accounts screen, the Home screen, the Transactions screen, the Recurring screen, the Budget screen, and the More screen simultaneously — even though only the currency-display widgets in Accounts/Home actually depend on rates.

**Safety:** `context.select` is a drop-in Provider API — it still rebuilds the widget whenever the selected value changes, so anything currently correct stays correct. Nothing currently re-rendered will stop being re-rendered; we are only preventing re-renders of widgets whose relevant data provably did not change. Because `select` uses `==` comparison on the selected value, and we'll only apply it to primitive fields (`bool`, `Map` identity, etc.) that already change atomically with `notifyListeners()`, there is no scenario where the UI ends up stale. This is the standard, textbook-recommended optimization for exactly this situation (a `ChangeNotifier` used across many screens kept alive in an `IndexedStack`), and it's already the documented intent for this codebase — we're just finishing what §2 of `CLAUDE.md` says should already be there.

**Files touched:** `lib/screens/accounts_screen.dart`, `lib/screens/home_screen.dart` (only the widget-level reads named above — the rest of each screen's `context.watch<AppProvider>()` stays as-is).

---

## 4. Memoize `BudgetScreen`'s and `HomeScreen`'s per-build aggregate computation

**What:** Two screens recompute expensive aggregates unconditionally on every `build()`, with no guard — unlike `transactions_screen.dart` and `insights_screen.dart`, which already correctly use an `identical()` cache-check pattern to skip recomputation when the underlying data hasn't actually changed:

- `home_screen.dart`'s `_computeTransactions(app)` — filters the full transaction list down to "this month" and sums income/expense, on every build.
- `budget_screen.dart`'s `build()` — calls `app.budgetSpent(b)` (a full transaction-list scan per budget) inside a `.fold()` over all budgets, every time the screen rebuilds.

The fix: add the same `identical(_prevTransactions, app.transactions) && _prevX == x` guard already used in `transactions_screen.dart` (`_computeList`) and `insights_screen.dart` (`_computeData`) to `home_screen.dart` and `budget_screen.dart`, so the aggregate is only recomputed when the transactions list, exchange rates, or budgets list actually changed identity (i.e., something relevant was actually added/edited/deleted), not on every rebuild triggered by unrelated state.

**Why:** Right now, any `notifyListeners()` call anywhere in the app — including ones wired up in Item 3 that we're *not* fully eliminating, and ones unrelated to budgets/transactions at all — causes `BudgetScreen` (if visible) to re-scan every transaction for every budget, and `HomeScreen` (if visible) to re-filter and re-sum the whole transaction list. Combined with Item 3, this closes the loop: rebuilds that do still happen become cheap no-ops when the data hasn't changed.

**Safety:** This is the exact same, already-shipped-and-working pattern from two sibling screens (`transactions_screen.dart`, `insights_screen.dart`), applied to two more. The `identical()` check only skips recomputation when the input references are literally the same objects as last time — meaning the output would have been byte-identical anyway. There is no code path where this produces a different number on screen than before.

**Files touched:** `lib/screens/home_screen.dart`, `lib/screens/budget_screen.dart`.

---

## 5. Cache `formatAmount` / `NumberFormat` currency formatters

**What:** `formatAmount(double, String)` in `lib/theme/app_theme.dart` is called on essentially every money value shown anywhere in the app (every list tile, every card, every summary chip). If it constructs a `NumberFormat` (or equivalent `intl` formatter) fresh on every call rather than reusing one per currency code, this is unnecessary allocation on every single rebuild of every single money-displaying widget.

**What to check first (this is a "verify, then fix if present" item):** Read the current body of `formatAmount()`; if it already caches formatters (e.g. in a static `Map<String, NumberFormat>`), skip this item entirely — nothing to do. If it constructs a new formatter per call, add a small static cache keyed by currency code.

**Why:** `NumberFormat` construction involves locale data lookup — trivial once, wasteful thousands of times per scroll/rebuild across a long transaction list.

**Safety:** A cached formatter for a given currency code produces identical output to a freshly constructed one for that same code — this is purely reusing an equivalent, stateless object. Zero visible difference.

**Files touched:** `lib/theme/app_theme.dart` only.

---

## 6. Const-ify remaining eligible widget subtrees

**What:** A pass over the screens with the lowest current `const` density relative to their size (`home_screen.dart` — 36 `const` occurrences over 433 lines vs. `accounts_screen.dart`'s 219 over 2647 lines is a reasonable ratio; home_screen's is comparatively low) to mark any `Widget` subtree that takes no runtime-varying arguments as `const`. This is a mechanical, `dart fix`-assisted pass — the Dart analyzer with `flutter_lints` already flags `prefer_const_constructors` opportunities; this item is "run that fix and review the diff," not manual rewriting.

**Why:** `const` widgets are built once and reused across rebuilds instead of being reallocated; on a screen that rebuilds as often as `HomeScreen` will (see Items 3–4), maximizing the const-eligible portion of the tree reduces the per-rebuild allocation cost of the parts that genuinely don't change (icons, fixed padding, static labels).

**Safety:** `const` is a purely mechanical marker Dart already validates at compile time — code that isn't actually constant will fail to compile with `const` added, so there is no risk of silently changing behavior. This is the lowest-risk item in this entire plan.

**Files touched:** Primarily `lib/screens/home_screen.dart`; secondarily a light pass over any other screen `flutter analyze --fatal-infos` flags.

---

## 7. Dead / unused code audit

**What:** A systematic scan for code that is written but never executed — unused private members (checked against every use within their own file, since Dart scoping makes this a reliable signal) and unused public methods (checked against every file in `lib/`). This turned up five concrete, verified findings:

**7a. `AppProvider._restoreSay()` — fully unreachable, 115-line dead method** (`lib/providers/app_provider.dart`, ~line 1976)
A complete CSV-parsing implementation for importing a "Say" app backup (mirrors the working `_restoreGreenStash()` next to it). It is `private`, so it can only ever be called from within `app_provider.dart` — and it is not. Its only possible caller, `restoreExternalBackup(String source)`, checks `if (source == 'greenstash')` and has no `'say'` branch; the only UI call site (`backup_screen.dart`, one `_restoreExternal('greenstash')` button) never passes `'say'` either. This is a fully finished feature that was never wired up to anything — either remove it, or (if "Say" import is still wanted) add the missing `else if (source == 'say') await _restoreSay(contentStr);` branch plus a UI entry point. **Recommendation: remove**, since silently carrying a large, untested, unreachable code path is a maintenance liability either way, and re-adding it later from git history is trivial if the feature is revived.

**7b. `HomeScreen._cachedTransactions` — declared, never read or assigned** (`lib/screens/home_screen.dart`, line 23)
This field exists but nothing in `_computeTransactions()` ever checks or updates it — it sits alongside `_income`, `_expense`, and `_recent`, but unlike them, it's dead weight. This is direct evidence that a memoization guard (identical to `transactions_screen.dart`'s `_prevTxs` / `insights_screen.dart`'s `_cachedTxs` pattern, both of which *do* work correctly) was intended here but never finished — which is exactly the gap **Item 4** above already targets. **Recommendation: this field should be deleted and replaced by the real guard added in Item 4**, not kept — don't fix both separately.

**7c. `DBHelper.getSavingsGoalsCount()` and `DBHelper.getSavingsContributionsCount()` — unused DB methods** (`lib/database/db_helper.dart`, lines 682 and 717)
Both run a query against the database to return a row count, but nothing anywhere in the codebase calls either one — not the provider, not any screen, not even another method inside `db_helper.dart`. The one place that displays these counts, `backup_screen.dart`'s "what's included" list, correctly uses `app.savingsGoals.length` / `app.savingsContributions.length` off the already-loaded in-memory lists instead (the right approach, since those lists are always fully loaded — unlike `recurring_history`, which has its own `recurringHistoryCount` precisely so it *doesn't* need to be loaded in full). **Recommendation: remove both methods** — they're redundant DB round-trips with zero callers.

**7d. `AppProvider.budgetRemaining(Budget b)` — unused provider method, *and* a duplicated-with-a-difference inline version** (`lib/providers/app_provider.dart`, line 1576)
Documented in `CLAUDE.md` §6 as part of the public budgets API (`double budgetRemaining(Budget b)`), but nothing calls it. Instead, `budget_screen.dart` (line ~359) computes the same "remaining" figure inline as `budget.amount - spent` for the spent/remaining pill. The catch: `budgetRemaining()` clamps the result to a minimum of `0`, while the screen's inline version does not — so today, a budget that's over its limit shows a **negative** remaining amount in that pill, whereas calling the existing provider method would show `0` instead. This is a two-part item:
  - Removing `budgetRemaining()` outright would be the "pure dead code" answer, but it's better-tested, already-documented logic that's arguably more correct than what's live.
  - **Recommendation:** replace the inline `budget.amount - spent` at that call site with `app.budgetRemaining(budget)`. This isn't a pure no-op deletion like the other three items — it changes the displayed text in the specific case of an over-budget category (negative amount → `0`) — so it's flagged separately for a deliberate decision rather than bundled into the silent, zero-visible-change items above. If the negative-number display for over-budget categories is intentional (e.g. to visually signal "you're $12 over"), leave the inline version as-is and instead just delete the now-confirmed-unused `budgetRemaining()` method from the provider.

**7e. `NetWorthScreen` — a complete, fully-functional screen with no navigation entry point anywhere** (`lib/screens/net_worth_screen.dart`, 209 lines)
This is a different flavor of "unused" from 7a–7d: it's not unreachable *code*, it's an unreachable *screen*. `NetWorthSnapshot` is a fully modeled DB table (`db_helper.dart`), actively written to by the provider on nearly every account/asset mutation via `updateNetWorthSnapshotForToday()`/`_maybeSnapshotNetWorth()` (so the data is being collected continuously, right now, in every install), and `NetWorthScreen` itself is a complete, working `StatelessWidget` that reads `app.netWorthSnapshots` and would render correctly if shown. But `more_screen.dart`'s menu list — Statistics, Insights, Currency Converter, Wishlist, Lent Money, Assets, Categories, Export, Backup, Settings — has no Net Worth entry, and nothing else in the app pushes this route either. **This is a genuine gap, not something to silently delete**: unlike 7a–7d, real user data (snapshots) is already accumulating for a feature nobody can currently see. Recommendation: this needs your decision, not a mechanical fix —
  - **Wire it in** (likely a 10-minute change): add one `_Item` entry to `more_screen.dart`'s list, matching the existing style, pointing at `const NetWorthScreen()`.
  - **Or confirm it's intentionally shelved** (e.g. superseded by something else, or mid-development), in which case it's fine to leave as-is for now — it costs nothing at runtime since it's simply never built — but it should stay flagged rather than forgotten.

**Why:** Dead code has a real, ongoing cost even though it never runs: it's read during every code review, it's a false signal to future-you (or another AI assistant) about what's actually wired up, it can bit-rot in ways that cause confusing compiler errors after unrelated refactors (e.g. Item 1/2's changes to `accounts`/`categories` list-patching would need to account for `_restoreSay`'s account/category auto-creation logic if it were ever left in place unmaintained), and in `_restoreSay`'s case specifically, it's 115 lines of untested parsing logic for a third-party CSV format that would fail in an unknown way if it were ever accidentally wired up without proper testing. 7e carries a different cost: user data is being collected for a feature they can't reach, which is arguably worse than dead code — it's dead *storage*.

**Safety:** 7a–7c are pure removals of code with **zero call sites** anywhere in `lib/` — deleting them cannot change anything the user sees or any code path the app executes, by definition (nothing was calling them, so nothing observable depends on their presence). 7d is flagged as a **choice**, not an automatic safe removal, precisely because the two ways of resolving it produce different output in one edge case (an over-budget category). 7e is **not a code deletion at all** — it's a documentation/decision flag; wiring it in is additive (one new menu row, matching every existing row's style exactly) and doesn't touch any other screen's behavior. No item in this section touches DB schema, migrations, or backup/restore file formats — `_restoreSay`'s removal doesn't affect `_normaliseBackup()` or the JSON backup format at all, since it was for a completely separate, unrelated third-party CSV import path.

**Files touched:** `lib/providers/app_provider.dart` (7a, 7d), `lib/screens/home_screen.dart` (7b — folded into Item 4's edit), `lib/database/db_helper.dart` (7c), `lib/screens/budget_screen.dart` (7d, only if the "replace inline calc" resolution is chosen), `lib/screens/more_screen.dart` (7e, only if "wire it in" is chosen).

**Not included in this section:** A full unused-import sweep was attempted but produced no reliable results without running the Dart analyzer directly (which isn't available in this environment) — `flutter analyze` (or `dart fix --dry-run`) should be run once as a follow-up to catch any unused-import warnings mechanically; it's a zero-risk, fully-automated check that doesn't need to be hand-verified item by item the way the above findings were.

---

## What is deliberately **not** in this phase

To keep this phase's risk at zero, the following were considered and explicitly excluded because they'd require judgment calls that could subtly change behavior or would need dedicated review/testing beyond a mechanical refactor:

- **Restructuring `totalBalance` / `totalBalanceAll`'s duplicated bank-linking logic into a shared helper.** These two getters are near-identical (~30 lines duplicated). Deduplicating is good practice, but merits its own small, isolated PR with explicit before/after test cases for linked-card accounts, since a subtle sign/filter mistake here would silently corrupt a balance figure — the app's single most important displayed number. Recommended for Phase 2, done in isolation with a written test matrix, not bundled with the broader pass in this document.
- **Pagination / lazy-loading for the transactions list.** `transactions_screen.dart` already uses `ListView.builder`-style flattening efficiently for what's rendered; introducing true pagination would change scroll behavior and is a UX decision, not a pure optimization — out of scope here.
- **Converting `ReorderableListView.builder`/small `ListView(children:)` instances (settings color pickers, category lists, onboarding) to lazy builders.** These lists are small and bounded (≤~60 items, typically far fewer); building them eagerly costs nothing measurable, and converting them adds indirection for no gain.
- **Database indices beyond the existing `idx_rh_recurring_id`.** Given `sqflite`'s per-query cost is already small relative to Dart-side full-list refetches (Item 1), and every additional index is a schema/migration change with its own risk surface, this is deferred to a dedicated data-layer review rather than folded into this UI-safe pass.
- **Any change to `AI_INSTRUCTIONS.md`'s note that the DB is "Isar (NoSQL)."** The actual code uses `sqflite`/SQLite throughout (confirmed in `CLAUDE.md` §5 and `lib/database/db_helper.dart`). This is a documentation-only discrepancy, not a code change, and is flagged here only for awareness — not actioned in this plan since it doesn't affect the app.

---

## Suggested implementation order & verification

1. Item 1 (provider refetch removal) — verify by exercising every CRUD screen (add/edit/delete an account, category, transaction, recurring payment, wishlist item, lent/borrowed entry, asset, budget, savings goal) and confirming lists update identically to current behavior, including undo-snackbar flows.
2. Item 2 (map-based lookups) — verify budgets, statistics, and insights screens show identical numbers before/after.
3. Item 3 (`context.select`) — verify the Accounts screen's sync icon and rates banner still update live during a rate refresh, and the Home screen's balance-hide toggle still works instantly.
4. Item 4 + 7b together (memoization, including removing the dead `_cachedTransactions` field and replacing it with a working guard) — verify Budget and Home screens still update immediately after adding/editing/deleting a transaction, and don't show stale numbers.
5. Item 5 (formatter cache) — verify currency formatting output (symbol, decimal places, negative sign placement) is unchanged across a few different currencies.
6. Item 6 (const pass) — run `flutter analyze`, review diff, done.
7. Item 7a + 7c (delete `_restoreSay`, `getSavingsGoalsCount`, `getSavingsContributionsCount`) — these are pure deletions with zero callers; verify only that the app still compiles and the Backup screen's restore flows (both the main JSON restore and the GreenStash import) still work exactly as before.
8. Item 7d — **requires your decision first** (clamp-to-zero via `app.budgetRemaining()` vs. keep the unclamped inline calculation and just delete the unused method): implement whichever is chosen, then verify the Budget screen's remaining-amount pill for both an under-budget and an over-budget category.
9. Item 7e — **requires your decision first** (wire `NetWorthScreen` into `more_screen.dart`'s menu vs. leave it unreached for now): if wiring it in, verify the new menu row matches the existing rows' styling exactly and that the screen renders correctly with real snapshot data.

After each item, run `flutter analyze` (should show no new issues) and do a manual pass over the affected screen(s) to confirm pixel-for-pixel identical appearance and identical behavior before moving to the next item. Items 7d and 7e are the only two in this entire plan (across both phases so far) that involve a visible or behavioral choice rather than a guaranteed no-op — flag these for explicit sign-off before implementing, rather than folding them silently into the same pass as everything else.
