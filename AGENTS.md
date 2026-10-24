# Expensy AI Agent Instructions & Guidelines

This document outlines project-specific rules, requirements, and conventions for AI assistants working on Expensy. For full architectural guidelines, refer to [AI_INSTRUCTIONS.md](file:///c:/Projects/expensy/AI_INSTRUCTIONS.md) and [CLAUDE.md](file:///c:/Projects/expensy/CLAUDE.md).

## Critical Rules & Guidelines

1. **Database Decoupling**:
   - UI code (`lib/screens/`, `lib/widgets/`) must **NEVER** import `db_helper.dart` or `app_database.dart`.
   - All state mutations and data queries must route through `AppProvider`.
   - Enforced by `dart run tool/ci_guard.dart --enforce` (`[DB in UI] == 0`).

2. **Concurrency & Mutex**:
   - Database and balance mutations in `AppProvider` must execute inside the zone-based mutex:
     `await _mutex(() async { ... })`.
   - Never use simple counter locks that cause deadlocks when re-entered.

3. **Atomic Balance Updates**:
   - Account balances must be updated atomically using SQL deltas (`applyBalanceDelta` in `AppDatabase` and `DBHelper`) rather than read-modify-write patterns.

4. **Financial Aggregations**:
   - Core financial aggregation functions live in `lib/providers/aggregations.dart`.
   - Internal transfers (`isTransfer`) and certificate/investment principal transactions (`isInvestment`) must be strictly excluded from income, expense, and budget calculations.

5. **Safety Net**:
   - Backups must be validated with `BackupValidator` before restore.
   - Pre-restore safety snapshots (`expensy_prerestore_<ts>.json`) must be created before any restore operation.
   - Always verify changes against user backup fixtures in `test/fixtures/` using `flutter test test/golden_backup_roundtrip_test.dart`.

6. **Collection Immutability & Reactivity**:
   - `AppProvider` collection fields (`transactions`, `accounts`, etc.) must be reassigned with fresh list instances upon mutation (`transactions = next`). Never mutate provider collections in place (`transactions.add(...)`, `transactions.insert(...)`), as UI memoization caches rely on list reference inequality to trigger reactive updates across tabs.

7. **Theme Adaptation & AMOLED Popups**:
   - Popup surfaces (dialogs, bottom sheets, dropdowns, pickers) must use `popupSurfaceColor(cs)` and `popupBorderSide(cs)` from `lib/theme/app_theme.dart` (or inherit `ThemeData` defaults) to consistently adapt to `#000000` pitch black with a subtle border in black AMOLED mode, and container surfaces in dark/light modes. Avoid hardcoding custom modal sheet backgrounds or raw shape overrides.
