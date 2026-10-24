# Expensy v1.2.2 Hotfix Release Notes

This hotfix release resolves bank account transfer limitations, improves credit card limit visibility on the Home screen, introduces system-wide pitch-black AMOLED theming across all popups and modals, adds an upcoming installments schedule to recurring payments, and significantly hardens data integrity, state reactivity, and financial calculations.

---

### 🔄 Bank Account Transfer Normalization
- **Transfer Origin & Destination Restrictions Lifted**:
  - Removed internal account filtering from `AccountCardPicker`, ensuring it transparently passes account selections to the caller.
  - Standardized transfer accounts in `TransferScreen` to filter strictly against cards and physical gold (`!a.isCard && !a.isGold`).
  - All liquid bank accounts (linked or unlinked), cash, digital wallets, and savings accounts can now be selected as transfer source or destination without restrictions.

### 💳 Home Screen Credit Card Available Limit
- **Available Limit Indicator**:
  - Added an `"Available: <amount>"` line directly below card balances in the Home Screen cards carousel for credit accounts with configured credit limits.
  - Full support for balance privacy obfuscation (`hideBalance`), displaying `"Available: • • •"` when privacy mode is enabled.
  - Adjusted card carousel container height to `124` to avoid vertical layout overflow across varying device displays.

### 🖤 Pure Pitch-Black AMOLED Popups, Dialogs & Menus
- **Theme-Adaptive Surface System**:
  - Centralized popup surface rendering via `popupSurfaceColor(cs)` and `popupBorderSide(cs)` in `AppTheme`.
  - In AMOLED black mode (`brightness == dark` and `surface == black`), all dialogs, bottom sheets, date/time pickers, popup menus, and dropdowns adapt to pitch black (`#000000`) with a subtle `outlineVariant` border (`alpha: 0.45`).
  - Configured global Material 3 theme properties (`dialogTheme`, `bottomSheetTheme`, `datePickerTheme`, `timePickerTheme`, `popupMenuTheme`, `dropdownMenuTheme`, `menuTheme`) to ensure uniform theme adaptation without manual per-widget overrides.
  - Harmonized custom modal sheets and dropdowns (`PresetSheet`, `CertificateSheet`, `CreditCardSettlementSheet`, `SelectiveBackupSheet`, `SelectiveRestoreSheet`, `LoanSheet`, `LogPaymentSheet`, `_AddTypeSheet`, `AppDropdownFormField`, `AppDropdown`).

### 📅 Recurring Installment Schedule & Quick Actions
- **Upcoming Payment Schedule**:
  - Added `upcomingPaymentDates` on `RecurringPayment` returning chronological installment dates up to `endDate` constrained by `remainingPayments`.
  - Transformed `RecurringDetailScreen` into a unified scrollable view to prevent screen overflows.
  - Added an **Upcoming Payments** schedule section directly above **Payment History** displaying installment index (`#i of N`), formatted dates, and amount.
  - Embedded quick actions on the next due installment:
    - **Pay**: Executes immediate payment recording and refreshes schedule and history.
    - **Skip**: Prompts confirmation dialog and advances the next due date without recording an expense.

### 🛡️ Enterprise Data Integrity, Reactivity & Safety Architecture
- **Reactive State Updates & Invalidation**:
  - Immutable list allocations in `AppProvider` for `transactions` and `accounts` on all write/delete operations, preventing stale memoized UI caches across tabs.
  - Defensive memoization invalidation across `HomeScreen`, `TransactionsScreen`, and `StatisticsScreen`.
- **Concurrency & Atomicity**:
  - Zone-based async mutex queue (`runZoned` with `#expMutex`) protecting all database and balance mutations against concurrent race conditions.
  - SQL-level atomic delta updates (`AppDatabase.applyBalanceDelta`) eliminating read-modify-write conflicts.
- **Pure Financial Aggregations Engine**:
  - Centralized financial aggregations in `lib/providers/aggregations.dart` (`periodTotals`, `categoryTotals`, `dayTotals`).
  - Enforced strict exclusion of internal transfers (`isTransfer`), certificates/investments (`isInvestment`), and excluded accounts from income/expense calculations.
- **Pre-Restore Safety Snapshots & Validation**:
  - Added `BackupValidator` and pre-flight validation preventing corrupt/incompatible restores.
  - Automatic rolling local pre-restore snapshots (`expensy_prerestore_<ts>.json`) enabling safe restoration rollback.

---

### 📦 Release Assets
- `app-arm64-v8a-release.apk` (64-bit ARM - modern devices)
- `app-armeabi-v7a-release.apk` (32-bit ARM - older devices)
- `app-x86_64-release.apk` (64-bit x86 - tablets / emulators)
