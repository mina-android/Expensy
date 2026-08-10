# Expensy — Codebase Audit: UI/UX, Dead Code, Performance & Bugs

> **Method:** This audit was produced by extracting and reading the actual uploaded source (`expensy.zip`), not by trusting `CLAUDE.md`/`AI_INSTRUCTIONS.md` claims — those files note their own history of drift, and this pass found *new* drift even against the more recent `AI_INSTRUCTIONS.md` (DB is v20, confirmed correct; several "known issues" have grown worse than documented, and some fixes claimed in prior planning conversations are not actually in this codebase snapshot).
>
> Nothing in this document has been implemented — it's an analysis only. Severity tags: 🔴 Critical · 🟠 High · 🟡 Medium · 🟢 Low/Polish.

---

## 0. Headline Findings (read this first)

1. 🔴 **Release builds are debug-signed and unminified**, despite a valid keystore (`expensy.jks`) and `key.properties` sitting unused on disk. Every release APK currently shipped from this `build.gradle` is signed with the debug key.
2. 🔴 **Two whole features (Loans, Yearly Analysis) are unlocalized in 6 of 11 languages** — Spanish, Italian, Portuguese, Russian, Japanese, Chinese users hit missing-translation fallbacks across two entire screens.
3. 🟠 **47% of bottom sheets violate the app's own no-`useSafeArea` rule**, which the project's own docs say causes keyboard-overlap bugs — this isn't a stray mistake, it's 8 sites across 6 screens.
4. 🟠 **`net_worth_snapshots` is dead-on-arrival**: the insert function exists, is never called, so the table is permanently empty and `NetWorthScreen` is unroutable dead code.
5. 🟠 **Two entire plugin dependencies (`android_alarm_manager_plus`, `shared_storage`) exist solely to support a service (`AutoBackupService`) that is never initialized** — pure APK/permission bloat for zero functionality.
6. 🟡 **Heavy `context.watch<AppProvider>()` usage (34 sites vs. 11 `select`)** means large screens like `accounts_screen.dart` (2655 lines) rebuild their entire tree on *any* app-wide state change, not just changes relevant to them.

---

## 1. UI/UX Consistency Issues

### 1.1 Bottom sheet keyboard-inset bug (violates the app's own documented rule) — 🟠 High
The project's own rules (`AI_INSTRUCTIONS.md` §2.3, `CLAUDE.md` §7 rule 4) explicitly say: *"do not pass `useSafeArea: true` — it conflicts with keyboard insets."* Yet **8 of 17** `showModalBottomSheet` calls do exactly that:

- `lended_screen.dart`
- `recurring_screen.dart`
- `assets_screen.dart`
- `categories_screen.dart`
- `budget_screen.dart` (two separate sheets)
- `lended_person_screen.dart` (two separate sheets)

**User impact:** on these specific forms, opening the keyboard while a text field near the bottom of the sheet is focused likely causes the field to be obscured or the sheet to jump/clip incorrectly — inconsistent with the smoother keyboard behavior on the other 9 sheets that already omit `useSafeArea`. This reads as an accidental copy-paste of an older sheet template rather than an intentional per-screen choice.

**Fix direction:** remove `useSafeArea: true` from all 8 sites to match the other 9 (and the documented rule); wrap sheet content in `SafeArea` manually only where truly needed for edge-to-edge devices.

### 1.2 Hardcoded, untranslated English strings scattered throughout — 🟠 High
Despite being an 11-language app, **50+ `Text('...')` literals bypass `AppLocalizations` entirely.** These are not edge cases — several are core interaction strings:

- **`accounts_screen.dart`**: `'You cannot pin more than 3 accounts'`, `'Unpin from Widget'` / `'Pin to Widget'` tooltips, `'Linked Bank Account (Optional)'`, `'Payment Reminder'`, `'Remind me at'`, `'Remind 2 days before'`, `'Exclude card balance from account balance'`, `'None'`, plus card-face labels `'CARD HOLDER'`, `'EXP'`, `'BALANCE'` — **duplicated near-identically at two separate line ranges** (~1160–1360 and ~2020–2220), suggesting the same form markup exists twice in this file (see §2.4).
- **`loan_detail_screen.dart`** / **`loans_screen.dart`**: entire confirmation dialogs are hardcoded — `'Are you sure you want to delete this loan and all its payments?'`, `'Delete Payment'`, `'Are you sure you want to delete this payment record?'`, `'Skip the next loan installment?'`, `'Notifications permission required'`, plus the payment-logged snackbar message.
- **`add_transaction_screen.dart`**: the duplicate-transaction warning dialog — `'Possible duplicate'`, `'Go back'`, `'Save anyway'`.
- **`net_worth_screen.dart`**: fully hardcoded (`'Net Worth'`, `'Current Net Worth'`, `'Accounts (Inc. Gold)'`, `'Assets'`, `' OVER TIME'`) — though moot until the screen is actually routed (see §3.2).
- **`insights_screen.dart`**: `'Current Net Worth'`, `'Accounts & Gold'`, `'Assets'`.
- **`onboarding_screen.dart`**: `'Skip for now'`, `'Add a Card'`, and the accompanying description line.
- **`recurring_detail_screen.dart`**: delete-confirmation dialog text.
- **`budget_screen.dart`**: `'Target / Saved'`.

**Fix direction:** audit every screen for `Text('literal')` (grep pattern: `Text\('[A-Z]`) and migrate to ARB keys, prioritizing confirmation dialogs (irreversible actions) and anything in the Loans/Accounts/Onboarding flows first since those are the newest/most-touched screens.

### 1.3 Loans & Yearly Analysis: incomplete localization — 🔴 Critical
Comparing `app_en.arb` (643 keys) against the other locale files:

| Locale | Key count | Missing vs. English |
|---|---|---|
| `en` | 643 | — |
| `ar`, `de`, `fr`, `hi` | 586 | 57 |
| `es`, `it`, `pt`, `ru`, `zh`, `ja` | 568 | **75** |

A concrete diff against `es.arb` shows the **entire `loans_*` key family (18 keys) and `yearly_*` key family (5 keys) missing**, plus `more_loans`/`more_loansSub`/`more_yearlyAnalysis`/`more_yearlyAnalysysSub` and two budget-goal keys. This means the Loans feature and Yearly Analysis feature — both flagged in project memory as "recently finalized/implemented" — **shipped without translation work for 6 of 11 supported languages**, and the More-menu entry points into them are untranslated too.

**Fix direction:** run `flutter gen-l10n` locally and treat any missing-key warning as a release blocker; add the ~75 missing keys to the six lagging ARB files before the next release. This should also become a CI/pre-commit check (see §4.5) so it can't silently recur with the next feature.

### 1.4 `MaterialPageRoute` stragglers (transition inconsistency) — 🟡 Medium
The docs claim only 2 known regression sites; the actual count is **6**:

- `recurring_screen.dart:396`
- `transactions_screen.dart:373` (push to `LoanDetailScreen`)
- `transactions_screen.dart:872` (push to `SavingsGoalDetailScreen`)
- `loans_screen.dart:96` and `:122` (both push to `LoanDetailScreen`)
- `budget_screen.dart:497` (push to `SavingsGoalDetailScreen`)

**User impact:** these specific pushes lose the app-wide `CupertinoPageTransitionsBuilder` swipe-to-go-back feel and use the plain Android/Material default transition instead — a small but perceptible inconsistency when a user backs out of a loan detail screen with a different gesture-feel than everywhere else in the app.

**Fix direction:** swap all 6 to `ExpensyRoute`. Given `LoanDetailScreen` and `SavingsGoalDetailScreen` are each pushed from more than one call site, consider adding a small helper (`pushLoanDetail(context, loan)`, `pushGoalDetail(context, goal)`) to prevent the same raw-route mistake from recurring at a third call site.

### 1.5 Raw `ScaffoldMessenger.showSnackBar` bypassing `showAppSnackbar` — 🟠 High
The docs' rationale for the custom snackbar utility is a real accessibility bug: Android accessibility services can keep an action-bearing native `SnackBar` on screen indefinitely, ignoring its `duration`. **9 sites** still use the raw API directly, meaning this bug is still live in those specific flows:

- `recurring_screen.dart` (notification-permission-denied message)
- `loan_detail_screen.dart`
- `loans_screen.dart` (notification-permission message)
- `budget_screen.dart`
- `lended_person_screen.dart` (×2)
- `accounts_screen.dart` (×3, including the widget-pin-limit and pin-toggle messages)

**Fix direction:** replace all 9 with `showAppSnackbar()`. Since several of these are permission-denial or limit-reached messages (not undo actions), confirm `showAppSnackbar`'s signature supports a plain message without an `onUndo` callback — if not, that's a one-line addition to the utility rather than reinventing snackbars per-screen.

### 1.6 Hardcoded `Colors.*` outside the theme system — 🟡 Medium
Rule #3 in the docs bans hardcoded Material colors except for genuinely fixed semantic/brand constants. Live violations:

- `insights_screen.dart` (×2): `Colors.orange` for a warning/threshold indicator.
- `budget_screen.dart` (×2): `Colors.orange` for budget-progress warning state.
- `lended_person_screen.dart`: `Colors.red` for an icon.
- **`yearly_analysis_screen.dart` (the newest screen) is the worst offender** — 8 separate hardcoded color references: `Colors.green` (×5, including two `.shade600`/`.shade700` variants), `Colors.teal`, `Colors.orange.shade700`, `Colors.purple.shade300` — used as fixed category-type indicator colors (recurring vs. loan vs. lent/borrowed).

**User impact:** these colors won't adapt to dark mode, AMOLED mode, or the user's chosen Material You seed — they'll look visually disconnected from the rest of the themed UI, most noticeably in dark/AMOLED mode where a flat `Colors.green` sits awkwardly against near-black surfaces.

**Fix direction:** either pull these from `cs.tertiary`/`cs.secondary`/semantic theme extensions, or — if these genuinely need to be fixed "type indicator" colors that don't shift with the user's theme (plausible, since they seem to distinguish transaction *categories* like recurring/loan/lent), promote them to real named constants (matching the existing category-color-palette / lended-person-color-palette pattern) rather than inline `Colors.x.shadeY` literals scattered through one file.

### 1.7 Duplicated form markup inside `accounts_screen.dart` — 🟡 Medium
The credit-card fields section (`'Linked Bank Account (Optional)'`, `'Payment Reminder'`, `'Remind me at'`, `'Remind 2 days before'`, `'Exclude card balance from account balance'`) appears **twice**, at two widely separated line ranges in the same file. This is almost certainly one code path for "add account" and one for "edit account" that have drifted into full duplication instead of sharing a single form-building method.

**User impact (indirect):** any future bug fix or copy change to this form has to be applied twice or it silently regresses in one of the two flows — this is very likely *why* several of the hardcoded-string issues above exist in the first place (a fix/translation applied to one copy and forgotten in the other).

**Fix direction:** extract the shared credit-card field block into one private widget-returning method taking the current form state, called from both add and edit paths.

### 1.8 Net Worth feature is visually two half-features — 🟡 Medium
`NetWorthScreen` is a fully built, polished standalone screen (own header, trend chart, breakdown) that is **completely unreachable** from any navigation path (see §2.2). Meanwhile `insights_screen.dart` shows a *smaller* net-worth section inline. A user has no way to discover the richer standalone view exists, and since `net_worth_snapshots` is never populated (§2.1), even the *reachable* Insights trend chart can only ever show a single live data point — never an actual trend line. The "trend" chart is currently incapable of showing a trend.

**Fix direction:** this is really one decision away from being fixed twice-over — see §2.1/§2.2 (write the snapshot + wire the route), after which this UX gap resolves itself.

---

## 2. Dead Code & Unused Code

### 2.1 `net_worth_snapshots` — write path never called — 🟠 High
`DBHelper.insertNetWorthSnapshot()` is fully implemented and exported/imported correctly in backup, but **no call site anywhere in the app ever invokes it.** The table is created on every fresh install and migrated correctly, but stays permanently empty. Net effect:
- `NetWorthScreen`'s entire premise (a snapshot-based trend) has no data to show even if routed.
- `insights_screen.dart`'s "net worth over time" chart can only ever plot the single current live point — it's not actually a historical trend, just a scatter of one dot.

**Fix direction:** decide *when* a snapshot should be written (nightly, like the intended-but-dead auto-backup; or on each app open; or on any balance-affecting mutation) and wire exactly one call site for it in `AppProvider`.

### 2.2 `NetWorthScreen` — fully built, completely unrouted — 🟠 High
No `Navigator.push`/route anywhere references `NetWorthScreen`. It's not in `more_screen.dart`'s menu, not linked from `insights_screen.dart`'s net-worth section (which would be the natural "see more" entry point), not anywhere. This is a finished screen sitting invisible in the codebase.

**Fix direction:** either add a "View full history" tap target from the Insights net-worth card into `NetWorthScreen`, or add it to the More menu — and fix its hardcoded strings (§1.2) at the same time since it's about to become reachable.

### 2.3 `CreditReminderService` — fully implemented, never instantiated — 🟠 High
181 lines, its own notification channel (`expensy_credit`), complete logic — but it is never constructed or called from `main.dart` or anywhere else. Meanwhile the Accounts screen has a full, working, persisted UI for `creditReminderEnabled` / `creditReminderTime` / `creditEarlyReminderEnabled` on every credit-card account. **Users can enable a "remind me before my card is due" toggle that visually looks "on" forever and never fires a single notification.** This is the single most user-facing dead-code issue in the app — it isn't just unused code, it's a broken promise made by a visible toggle.

**Fix direction:** this needs a product decision, not just a code fix — either (a) wire `CreditReminderService().initialize()` into `main.dart` and call its schedule/cancel methods from the same place `Account` credit-reminder fields are saved (mirroring exactly how `NotificationService`/`LoanReminderService` are wired for their respective entities), or (b) if the feature is being deprioritized, hide the toggle from the UI until it's real — leaving a non-functional toggle visible is worse for trust than not having the feature at all.

### 2.4 `AutoBackupService` — never initialized, plus two dependencies exist only for it — 🟠 High
`AutoBackupService.initialize()` is never called from `main.dart`. Beyond the dead code itself, **`android_alarm_manager_plus` and `shared_storage` are two full plugin dependencies (native Android integration, additional permissions/manifest surface, APK size) that exist in `pubspec.yaml` for no reason other than this one unused service.** This is a heavier cost than typical dead code — it's actively bloating the shipped binary and the app's permission footprint for a feature that has never run.

Compounding this: per project memory, `AutoBackupService._backupCallback()` reads raw `SharedPreferences` keys (`user_name`, `theme_mode`, `accent_color`) that don't match what `AppSettings.toJson()` actually writes (`userName`, `themeMode`, `themeSeed`, all nested under one `'settings'` JSON blob key) — so even if it were wired up, the embedded settings in every nightly backup would silently be the hardcoded fallback values, not the user's real settings. **This service has two independent, stacked bugs on top of simply being disconnected.**

**Fix direction:** treat this as a genuine "finish or remove" decision:
- **If finishing it:** call `AutoBackupService.initialize()` from `main.dart`; fix the SharedPreferences key mismatch to read from the real `'settings'` JSON blob via `AppProvider`/`AppSettings.fromJson`, not flat guessed keys.
- **If removing it:** delete `auto_backup_service.dart`, and drop `android_alarm_manager_plus` + `shared_storage` from `pubspec.yaml` entirely — an immediate, low-risk APK size and permission-surface win.

### 2.5 `asset_items` table — orphaned schema — 🟡 Medium
Still created in `_onCreate()` on every fresh install, but excluded from both `exportAll()` and `importAll()` — only the newer `assets` table is live. It's dead weight in the schema (harmless but pure clutter) since `AssetItem`/live CRUD all target `assets`.

**Fix direction:** low priority since dropping tables mid-migration-chain is genuinely risky (SQLite can't cheaply drop columns/tables safely across all upgrade paths per the docs' own stated reasoning) — but at minimum, add a one-line comment directly above the `CREATE TABLE asset_items` block in `_onCreate()` stating it's intentionally orphaned/legacy, so a future contributor doesn't "helpfully" start writing to it.

### 2.6 `home_widget` package — declared, unreferenced in Dart — 🟢 Low
Confirmed: no `.dart` file imports `package:home_widget`. The real bridge for the Quick Add widget is a hand-rolled `MethodChannel`/`EventChannel` (`quick_add_service.dart`, which even has a comment noting this explicitly). However, `AccountsWidgetProvider.kt` and `BudgetWidgetProvider.kt` (native Kotlin) still expect `home_widget`-shaped SharedPreferences keys (`accounts_widget_data`, `budget_widget_data`) that nothing on the Dart side ever writes — so those two specific home-screen widgets will always render empty/stale if a user adds them.

**Fix direction:** same "finish or remove" framing as §2.4 — either add the missing `HomeWidget.saveWidgetData()` calls in `AppProvider` (on relevant balance/budget changes) to make those two widgets real, or delete `AccountsWidgetProvider.kt`/`BudgetWidgetProvider.kt` and the `home_widget` pubspec entry if only the Quick Add widget is actually supported going forward.

### 2.7 `HOMESCREEN_WIDGET.md` — referenced, missing — 🟢 Low
`quick_add_service.dart` and `MainActivity.kt` both cite specific sections (`§4.1`, `§4.2`, `§0`, `§3.3`) of a file that does not exist anywhere in the repo. Either it was lost from version control, or the comments are stale.

**Fix direction:** recreate the doc (even a short one) or strip the section references from the comments so they don't point future readers at a nonexistent source of truth.

---

## 3. Performance & Optimization

### 3.1 Excessive `context.watch<AppProvider>()` — full-tree rebuild risk — 🟡 Medium
34 call sites use `context.watch<AppProvider>()` (subscribes to *every* field of the provider) versus only 11 using `context.select<AppProvider, T>()` (subscribes narrowly). `accounts_screen.dart` — the largest screen in the app at 2655 lines — has 4 separate `watch()` calls. Since `AppProvider` is a single monolithic `ChangeNotifier` covering accounts, transactions, budgets, loans, lended money, exchange rates, and settings all in one object, **any `notifyListeners()` call anywhere in the app (e.g. a background exchange-rate refresh, or a transaction added on a completely different screen) will trigger a full rebuild of every currently-mounted screen using `watch()`** — not just the screen relevant to that change.

Because `MainShell` keeps all 6 tabs mounted via `FadeIndexedStack` (a deliberate and otherwise-good choice for instant tab switching), this means an unrelated background rate refresh can silently trigger a full rebuild of, say, the Accounts screen even while the user is looking at Home.

**Fix direction:** progressively migrate `watch()` sites to `context.select()` on the specific list/field each screen actually needs (the pattern is already established and used correctly in 11 places — this is applying an existing convention more consistently, not introducing a new one). Prioritize `accounts_screen.dart` first since it's both the largest screen and the heaviest offender.

### 3.2 Unmemoized filter/sort/group chains inside build-adjacent methods — 🟡 Medium
`transactions_screen.dart`, `insights_screen.dart`, `statistics_screen.dart`, and `yearly_analysis_screen.dart` all run `.where()`/`.map()`/`.sort()`/`.fold()` chains directly inside methods called from `build()`, with no caching keyed on the underlying data. Combined with §3.1's rebuild frequency, this means **the same category-grouping/sorting work can re-run on every incidental app-wide state change**, not just when the underlying transaction list actually changes. This is currently invisible at small data volumes but will show up as real jank as a user's transaction history grows over months/years of daily use — which, for a personal finance tracker, is the expected long-term usage pattern.

**Fix direction:** for the heavier screens (Insights, Statistics, Yearly Analysis), consider computing derived data (category totals, sorted top-N lists, year groupings) once in `AppProvider` or a dedicated selector/memoization layer keyed on a cheap "did the transaction list actually change" check, rather than recomputing inline in every build. Doesn't need to be a full state-management rewrite — even a simple manual memoization (cache last input length/hash → cached output) on the expensive methods would help.

### 3.3 41 empty `catch (_) {}` blocks in `db_helper.dart` migrations — 🟠 High (correctness + debuggability risk, not just performance)
Every single `ADD COLUMN` statement inside `_onUpgrade()` is wrapped in a bare `try { ... } catch (_) {}`. This pattern likely exists as an idempotency guard (so a partially-applied migration on some device doesn't crash by re-adding an already-existing column) — but it also **silently swallows genuine failures**: a real syntax error in a migration, a disk-full write failure, or a corrupted DB file all fail exactly as silently as "column already exists." This directly contradicts the project's own rule #18 in `CLAUDE.md`, which explicitly calls for "real error logging (not a bare `catch (_) {}`)."

**User/dev impact:** if a migration genuinely fails on a real user's device, the app will likely continue running with a partially-migrated schema and no diagnostic trail — which is very hard to debug later from a bug report ("app is behaving weirdly since the update") with zero logged error to point at.

**Fix direction:** distinguish "column already exists" (safe to ignore) from other failures. Either check `PRAGMA table_info` before attempting the `ADD COLUMN` (avoiding the try/catch pattern entirely), or at minimum log the caught exception (even just `debugPrint`) with the migration step number, so a failure is at least visible in a bug report or crash log rather than fully invisible.

### 3.4 `AutoBackupService`/`android_alarm_manager_plus`/`shared_storage` — see §2.4
Cross-referenced here because it's as much a performance/binary-size issue as a dead-code issue — removing unused native plugin integrations is a direct, measurable APK size and cold-start init win if the decision is to not finish the feature.

### 3.5 Release build isn't actually optimized — 🔴 Critical
Covered fully in §4.1, but worth flagging here too: `minifyEnabled = false` and `shrinkResources = false` on the release build type means **the app currently ships without R8/ProGuard code shrinking or resource shrinking at all** — every release APK is larger and slower to cold-start than it needs to be, independent of any Dart-level optimization work above.

---

## 4. Bugs, Errors & Correctness Issues

### 4.1 Release build config: debug-signed, unminified — 🔴 Critical
Verified directly in `android/app/build.gradle`:
```gradle
buildTypes {
    release {
        signingConfig signingConfigs.debug
        minifyEnabled = false
        shrinkResources = false
    }
}
```
There is **no `signingConfigs.release` block at all** — yet `android/key.properties` and `android/app/expensy.jks` both exist on disk, fully populated with real credentials. This means the wiring to read the keystore file and register it as `signingConfigs.release` was either removed or never added to this Gradle file, while the keystore itself was left in place. **Every release build produced by this exact Gradle config right now is signed with the debug key** — which typically means it can't be uploaded as an update to an existing Play Store listing (Play Store enforces consistent signing across app updates), and if it *could* be installed over a previous properly-signed release, Android would reject the install entirely due to a signature mismatch.

**Fix direction:** add the standard Flutter release-signing block to `build.gradle` — read `key.properties`, define `signingConfigs.release` from its four fields, point `buildTypes.release.signingConfig` at it, and re-enable `minifyEnabled true` / `shrinkResources true` (with a `proguard-rules.pro` if any reflection-based libraries need keep rules — `flutter_local_notifications` and `google_fonts` sometimes do). This should be treated as a release-blocking fix, not a nice-to-have — it affects the ability to ship updates at all.

### 4.2 Credit-card reminder toggle is fully non-functional — 🟠 High
Already covered in §2.3, listed here too because it's a correctness bug from the user's point of view, not just dead code: **the UI actively lies about a feature's state.** A user toggles "remind me before my card is due," the toggle persists as ON, and nothing ever happens. There's no error, no indication, just silent non-function.

### 4.3 `_validLanguages` whitelist doesn't match the 11 offered languages — 🟠 High
`AppSettings._validLanguages` in `app_provider.dart` is hardcoded to `{'system', 'en', 'ar', 'fr', 'de', 'hi'}` — 6 entries — while `AppLocalizations.supportedLocales` and the Settings language picker both offer 11. **Selecting Spanish, Italian, Japanese, Portuguese, Russian, or Chinese works immediately but silently reverts to `'system'` on the next app restart** (confirmed live in `AppSettings.fromJson`'s validation step). This is a genuinely confusing bug from a user's perspective — the setting "randomly resets itself" with no error message, and will disproportionately affect exactly the 6 languages that (per §1.3) are also the ones with incomplete Loans/Yearly-Analysis translations, compounding into a worse experience for those specific users.

**Fix direction:** derive `_validLanguages` directly from `AppLocalizations.supportedLocales.map((l) => l.languageCode)` plus `'system'`, so the two lists structurally cannot drift apart again — rather than fixing the current hardcoded set and leaving the same class of bug possible for the next language added.

### 4.4 `restoreBackup()` doesn't reschedule loan or budget reminders — 🟡 Medium
Confirmed: `AppProvider.restoreBackup()` reschedules recurring-payment and lended-money reminders, but not loan or budget-related ones. A user restoring a backup that contains loans/budgets with reminders enabled will have those reminders silently not fire again until each one is individually touched/re-saved.

**Fix direction:** mirror the existing `NotificationService().rescheduleAll(...)` / `LendedNotificationService().rescheduleAllLended(...)` calls with equivalent reschedule calls for `LoanReminderService` and `BudgetNotificationService`, in the same place in `restoreBackup()`.

### 4.5 No CI/tooling guard against localization drift — 🟡 Medium (process, not code)
Given §1.3 shows a real, shipped feature-localization gap, there's currently no automated check catching this before release — `flutter gen-l10n` will warn about missing keys, but nothing in the repo appears to run that as a gate (no CI config observed for this).

**Fix direction:** even a lightweight pre-commit or CI step running `flutter gen-l10n --arb-dir=lib/l10n` (which errors/warns on missing keys across locales) would have caught the Loans/Yearly-Analysis gap immediately at the PR stage rather than needing an audit to surface it after the fact.

### 4.6 Duplicate account-form code (§1.7) is itself a bug-multiplication risk — 🟡 Medium
Listed here as well as in UI/UX because it's not just a code-cleanliness issue — it's a *mechanism* by which future correctness bugs get introduced (a fix applied to the add-account copy of the credit-card form but missed in the edit-account copy, or vice versa). Worth prioritizing the dedup specifically because of this compounding risk, not just for line-count tidiness.

---

## 5. Suggested Prioritization

If tackled in order of user-facing impact vs. effort:

1. **🔴 Fix release signing/minification** (`build.gradle`) — small, mechanical, unblocks real releases.
2. **🔴 Close the Loans/Yearly-Analysis localization gap** — add ~75 missing ARB keys across 6 languages.
3. **🟠 Fix `_validLanguages` whitelist** to derive from `supportedLocales` — one-line structural fix, kills a recurring bug class.
4. **🟠 Decide fate of `CreditReminderService`** (wire it up or hide the toggle) — currently actively misleading users.
5. **🟠 Fix the 8 `useSafeArea: true` bottom sheets** and **9 raw `ScaffoldMessenger` snackbars** — mechanical, consistent with existing documented rules, no new patterns needed.
6. **🟠 Decide fate of `AutoBackupService`** (finish + fix its settings-key bug, or delete it and its two dependencies) — real APK/permission cost either way.
7. **🟡 Wire or delete `NetWorthScreen`/snapshot-writing** — currently a fully-built feature invisible to users.
8. **🟡 Dedupe the accounts-screen credit-card form** — reduces future bug-multiplication risk.
9. **🟡 Migrate remaining `MaterialPageRoute` → `ExpensyRoute`** sites (6 found).
10. **🟡 Progressively replace `context.watch` → `context.select`** starting with `accounts_screen.dart`.
11. **🟡 Add error logging to the 41 empty `catch` blocks** in DB migrations (distinguish "already exists" from real failures).
12. **🟢 Audit remaining hardcoded `Text('...')` literals** app-wide and hardcoded `Colors.*` in `yearly_analysis_screen.dart`.
13. **🟢 Clean up orphaned schema/doc references** (`asset_items` comment, `HOMESCREEN_WIDGET.md`, `home_widget` package decision).
