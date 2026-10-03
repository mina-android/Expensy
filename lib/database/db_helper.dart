// lib/database/db_helper.dart
import 'app_database.dart';
import '../models/models.dart';

/// Static facade providing zero-breakage backward compatibility across the app
/// by delegating all CRUD and aggregate operations directly to [AppDatabase.instance]
/// (Drift backed by SQLite in a background isolate).
class DBHelper {
  static const int _version = 25;

  /// Public accessor for the current DB/backup schema version, so UI code
  /// (e.g. the Backup screen) never has to hardcode a copy that can drift
  /// out of sync with the real schema version.
  static int get schemaVersion => _version;
  // ── Accounts ─────────────────────────────────────────────────────────
  static Future<List<Account>> getAccounts() =>
      AppDatabase.instance.getAccounts();

  static Future<void> insertAccount(Account a) =>
      AppDatabase.instance.insertAccount(a);

  static Future<void> updateAccount(Account a) =>
      AppDatabase.instance.updateAccount(a);

  static Future<void> deleteAccount(String id) =>
      AppDatabase.instance.deleteAccount(id);

  // ── Categories ───────────────────────────────────────────────────────
  static Future<List<AppCategory>> getCategories() =>
      AppDatabase.instance.getCategories();

  static Future<void> insertCategory(AppCategory c) =>
      AppDatabase.instance.insertCategory(c);

  static Future<void> updateCategory(AppCategory c) =>
      AppDatabase.instance.updateCategory(c);

  static Future<void> deleteCategory(String id) =>
      AppDatabase.instance.deleteCategory(id);

  // ── Transactions ─────────────────────────────────────────────────────
  static Future<List<AppTransaction>> getTransactions(
          {int? limit, int offset = 0}) =>
      AppDatabase.instance.getTransactions(limit: limit, offset: offset);

  static Future<List<AppTransaction>> getTransactionsForAccount(
          String accountId,
          {int? limit, int offset = 0}) =>
      AppDatabase.instance.getTransactionsForAccount(accountId,
          limit: limit, offset: offset);

  static Future<void> insertTransaction(AppTransaction t) =>
      AppDatabase.instance.insertTransaction(t);

  static Future<void> updateTransaction(AppTransaction t) =>
      AppDatabase.instance.updateTransaction(t);

  static Future<void> deleteTransaction(String id) =>
      AppDatabase.instance.deleteTransaction(id);

  // ── Recurring ────────────────────────────────────────────────────────
  static Future<List<RecurringPayment>> getRecurring() =>
      AppDatabase.instance.getRecurring();

  static Future<void> insertRecurring(RecurringPayment r) =>
      AppDatabase.instance.insertRecurring(r);

  static Future<void> updateRecurring(RecurringPayment r) =>
      AppDatabase.instance.updateRecurring(r);

  static Future<void> deleteRecurring(String id) =>
      AppDatabase.instance.deleteRecurring(id);

  // ── Wishlist ─────────────────────────────────────────────────────────
  static Future<List<WishlistItem>> getWishlist() =>
      AppDatabase.instance.getWishlist();

  static Future<void> insertWishlist(WishlistItem w) =>
      AppDatabase.instance.insertWishlist(w);

  static Future<void> updateWishlist(WishlistItem w) =>
      AppDatabase.instance.updateWishlist(w);

  static Future<void> deleteWishlist(String id) =>
      AppDatabase.instance.deleteWishlist(id);

  // ── Lended People ────────────────────────────────────────────────────
  static Future<List<LendedPerson>> getLendedPeople() =>
      AppDatabase.instance.getLendedPeople();

  static Future<void> insertLendedPerson(LendedPerson p) =>
      AppDatabase.instance.insertLendedPerson(p);

  static Future<void> updateLendedPerson(LendedPerson p) =>
      AppDatabase.instance.updateLendedPerson(p);

  static Future<void> deleteLendedPerson(String id) =>
      AppDatabase.instance.deleteLendedPerson(id);

  // ── Lended Money (per-person ledger entries) ────────────────────────────
  static Future<List<LendedMoney>> getLended() =>
      AppDatabase.instance.getLended();

  static Future<List<LendedMoney>> getLendedForPerson(String personId) =>
      AppDatabase.instance.getLendedForPerson(personId);

  static Future<void> insertLended(LendedMoney l) =>
      AppDatabase.instance.insertLended(l);

  static Future<void> updateLended(LendedMoney l) =>
      AppDatabase.instance.updateLended(l);

  static Future<void> deleteLended(String id) =>
      AppDatabase.instance.deleteLended(id);

  static Future<void> deleteLendedForPerson(String personId) =>
      AppDatabase.instance.deleteLendedForPerson(personId);

  // ── Assets ────────────────────────────────────────────────────────────
  static Future<List<AssetItem>> getAssets() =>
      AppDatabase.instance.getAssets();

  static Future<void> insertAsset(AssetItem a) =>
      AppDatabase.instance.insertAsset(a);

  static Future<void> updateAsset(AssetItem a) =>
      AppDatabase.instance.updateAsset(a);

  static Future<void> deleteAsset(String id) =>
      AppDatabase.instance.deleteAsset(id);

  // ── Budgets ───────────────────────────────────────────────────────────
  static Future<List<Budget>> getBudgets() =>
      AppDatabase.instance.getBudgets();

  static Future<void> insertBudget(Budget b) =>
      AppDatabase.instance.insertBudget(b);

  static Future<void> updateBudget(Budget b) =>
      AppDatabase.instance.updateBudget(b);

  static Future<void> deleteBudget(String id) =>
      AppDatabase.instance.deleteBudget(id);

  // ── Savings Goals ──────────────────────────────────────────────────────
  static Future<List<SavingsGoal>> getSavingsGoals() =>
      AppDatabase.instance.getSavingsGoals();

  static Future<void> insertSavingsGoal(SavingsGoal g) =>
      AppDatabase.instance.insertSavingsGoal(g);

  static Future<void> updateSavingsGoal(SavingsGoal g) =>
      AppDatabase.instance.updateSavingsGoal(g);

  static Future<void> deleteSavingsGoal(String id) =>
      AppDatabase.instance.deleteSavingsGoal(id);

  // ── Savings Contributions ─────────────────────────────────────────────
  static Future<List<SavingsContribution>> getSavingsContributionsFor(
          String goalId) =>
      AppDatabase.instance.getSavingsContributionsFor(goalId);

  static Future<List<SavingsContribution>> getAllSavingsContributions() =>
      AppDatabase.instance.getAllSavingsContributions();

  static Future<void> insertSavingsContribution(SavingsContribution c) =>
      AppDatabase.instance.insertSavingsContribution(c);

  // ── Recurring History ─────────────────────────────────────────────────
  static Future<List<RecurringHistoryEntry>> getRecurringHistory(
          String recurringId) =>
      AppDatabase.instance.getRecurringHistory(recurringId);

  static Future<List<RecurringHistoryEntry>> getAllRecurringHistory() =>
      AppDatabase.instance.getAllRecurringHistory();

  static Future<int> getRecurringHistoryCount() =>
      AppDatabase.instance.getRecurringHistoryCount();

  static Future<void> insertRecurringHistory(RecurringHistoryEntry e) =>
      AppDatabase.instance.insertRecurringHistory(e);

  static Future<void> deleteRecurringHistoryFor(String recurringId) =>
      AppDatabase.instance.deleteRecurringHistoryFor(recurringId);

  // ── Loans ─────────────────────────────────────────────────────────────
  static Future<List<Loan>> getLoans() =>
      AppDatabase.instance.getLoans();

  static Future<void> insertLoan(Loan l) =>
      AppDatabase.instance.insertLoan(l);

  static Future<void> updateLoan(Loan l) =>
      AppDatabase.instance.updateLoan(l);

  static Future<void> deleteLoan(String id) =>
      AppDatabase.instance.deleteLoan(id);

  // ── Loan Payments ─────────────────────────────────────────────────────
  static Future<List<LoanPayment>> getLoanPayments(String loanId) =>
      AppDatabase.instance.getLoanPayments(loanId);

  static Future<List<LoanPayment>> getAllLoanPayments() =>
      AppDatabase.instance.getAllLoanPayments();

  static Future<void> insertLoanPayment(LoanPayment p) =>
      AppDatabase.instance.insertLoanPayment(p);

  static Future<void> deleteLoanPayment(String id) =>
      AppDatabase.instance.deleteLoanPayment(id);

  static Future<void> deleteLoanPaymentsFor(String loanId) =>
      AppDatabase.instance.deleteLoanPaymentsFor(loanId);

  // ── Aggregations ──────────────────────────────────────────────────────
  static Future<double> getMonthlySpentForCategory(
          String categoryId, DateTime month) =>
      AppDatabase.instance.getMonthlySpentForCategory(categoryId, month);

  static Future<Map<String, double>> getTotalIncomeAndExpenseForMonth(
          DateTime month) =>
      AppDatabase.instance.getTotalIncomeAndExpenseForMonth(month);

  static Future<double> getTotalBudgetSpent(
          String categoryId, DateTime start, DateTime end) =>
      AppDatabase.instance.getTotalBudgetSpent(categoryId, start, end);

  static Future<List<Map<String, dynamic>>> getCategoryExpensesForMonth(
          DateTime month) =>
      AppDatabase.instance.getCategoryExpensesForMonth(month);

  // ── Transaction Presets ───────────────────────────────────────────────
  static Future<List<TransactionPreset>> getPresets() =>
      AppDatabase.instance.getPresets();

  static Future<void> insertPreset(TransactionPreset p) =>
      AppDatabase.instance.insertPreset(p);

  static Future<void> updatePreset(TransactionPreset p) =>
      AppDatabase.instance.updatePreset(p);

  static Future<void> deletePreset(String id) =>
      AppDatabase.instance.deletePreset(id);

  // ── Transaction Splits ────────────────────────────────────────────────
  static Future<List<TransactionSplit>> getAllSplits() =>
      AppDatabase.instance.getAllSplits();

  static Future<List<TransactionSplit>> getSplitsForTransaction(
          String transactionId) =>
      AppDatabase.instance.getSplitsForTransaction(transactionId);

  static Future<void> saveTransactionSplits(
          String transactionId, List<TransactionSplit> splits) =>
      AppDatabase.instance.saveTransactionSplits(transactionId, splits);

  static Future<void> deleteSplitsForTransaction(String transactionId) =>
      AppDatabase.instance.deleteSplitsForTransaction(transactionId);

  // ── Backup / Restore ──────────────────────────────────────────────────
  static Future<Map<String, dynamic>> exportAll() =>
      AppDatabase.instance.exportAll();

  static Future<void> importAll(Map<String, dynamic> data) =>
      AppDatabase.instance.importAll(data);

  // ── Net Worth Snapshots ───────────────────────────────────────────────
  static Future<List<NetWorthSnapshot>> getNetWorthSnapshots(
          {DateTime? since, int? limit}) =>
      AppDatabase.instance.getNetWorthSnapshots(since: since, limit: limit);

  static Future<NetWorthSnapshot?> getNetWorthSnapshotForDate(String date) =>
      AppDatabase.instance.getNetWorthSnapshotForDate(date);

  static Future<void> insertNetWorthSnapshot(NetWorthSnapshot snap) =>
      AppDatabase.instance.insertNetWorthSnapshot(snap);
}

