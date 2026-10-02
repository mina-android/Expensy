// lib/database/app_database.dart
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart' as sqflite show getDatabasesPath;
import '../models/models.dart';
import 'tables.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await sqflite.getDatabasesPath();
    final file = File(p.join(dbFolder, 'expensy.db'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: [
  Accounts,
  Categories,
  Transactions,
  RecurringPayments,
  Wishlist,
  AssetItems,
  NetWorthSnapshots,
  LendedPeople,
  LendedMoneyTable,
  Assets,
  Budgets,
  RecurringHistory,
  SavingsGoals,
  SavingsContributions,
  Loans,
  LoanPayments,
  TransactionPresets,
  TransactionSplits,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  static AppDatabase? _instance;
  static AppDatabase get instance => _instance ??= AppDatabase();

  @visibleForTesting
  static void setInstanceForTesting(AppDatabase? db) {
    _instance = db;
  }

  static const int _version = 25;
  static int get currentSchemaVersion => _version;

  @override
  int get schemaVersion => _version;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await customStatement(
              'CREATE UNIQUE INDEX IF NOT EXISTS idx_nws_date ON net_worth_snapshots(date);');
          await customStatement(
              'CREATE INDEX IF NOT EXISTS idx_rh_recurring_id ON recurring_history(recurring_id);');
          await customStatement(
              'CREATE INDEX IF NOT EXISTS idx_lp_loan_id ON loan_payments(loan_id);');
          await customStatement(
              'CREATE INDEX IF NOT EXISTS idx_ts_transaction_id ON transaction_splits(transaction_id);');
          await customStatement(
              'CREATE INDEX IF NOT EXISTS idx_tp_order_index ON transaction_presets(order_index);');
          await _insertDefaultCategories();
        },
        onUpgrade: (m, from, to) async {
          if (from < 21) {
            await m.createTable(transactionPresets);
            await m.createTable(transactionSplits);
            await customStatement(
                'CREATE INDEX IF NOT EXISTS idx_ts_transaction_id ON transaction_splits(transaction_id);');
            await customStatement(
                'CREATE INDEX IF NOT EXISTS idx_tp_order_index ON transaction_presets(order_index);');
          }
          if (from < 22) {
            await m.addColumn(budgets, budgets.allowRollover);
          }
          if (from < 23) {
            await m.addColumn(wishlist, wishlist.goalId);
            await m.addColumn(savingsGoals, savingsGoals.wishlistItemId);
          }
          if (from < 24) {
            await m.addColumn(accounts, accounts.dontLinkToCard);
          }
          if (from < 25) {
            await m.addColumn(recurringPayments, recurringPayments.autoPayEnabled);
            await m.addColumn(recurringPayments, recurringPayments.autoPayTime);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON;');
        },
      );

  Future<void> _insertDefaultCategories() async {
    const defaultCats = [
      ('food_exp', 'Food & Dining', 'expense', 0xFFE65100),
      ('transport', 'Transport', 'expense', 0xFF1565C0),
      ('shopping', 'Shopping', 'expense', 0xFF7D5260),
      ('bills', 'Bills & Utilities', 'expense', 0xFF827717),
      ('health', 'Health', 'expense', 0xFF2E7D32),
      ('entertainment', 'Entertainment', 'expense', 0xFF00838F),
      ('education', 'Education', 'expense', 0xFF283593),
      ('personal', 'Personal Care', 'expense', 0xFF4E342E),
      ('salary', 'Salary', 'income', 0xFF2E7D32),
      ('freelance', 'Freelance', 'income', 0xFF1565C0),
      ('investments', 'Investments', 'income', 0xFF6A1B9A),
      ('gifts', 'Gifts', 'income', 0xFFC2185B),
      ('other_inc', 'Other Income', 'income', 0xFF00695C),
      ('other_exp', 'Other Expense', 'expense', 0xFF37474F),
    ];
    for (final c in defaultCats) {
      await into(categories).insert(
        CategoriesCompanion.insert(
          id: c.$1,
          name: c.$2,
          type: c.$3,
          colorValue: c.$4,
        ),
        mode: InsertMode.insertOrIgnore,
      );
    }
  }

  // ── Generic Map Helpers ───────────────────────────────────────────────────
  Future<void> insertMap(String table, Map<String, dynamic> map) async {
    final keys = map.keys.toList();
    final placeholders = List.filled(keys.length, '?').join(', ');
    final cols = keys.join(', ');
    final sql = 'INSERT OR REPLACE INTO $table ($cols) VALUES ($placeholders)';
    final values = keys.map((k) => Variable<Object>(map[k])).toList();
    await customInsert(sql, variables: values);
  }

  Future<void> updateMap(
      String table, Map<String, dynamic> map, String idCol, String idVal) async {
    final keys = map.keys.where((k) => k != idCol).toList();
    final setClause = keys.map((k) => '$k = ?').join(', ');
    final sql = 'UPDATE $table SET $setClause WHERE $idCol = ?';
    final values = [
      ...keys.map((k) => Variable<Object>(map[k])),
      Variable<String>(idVal)
    ];
    await customUpdate(sql, variables: values);
  }

  Future<void> deleteRow(String table, String idCol, String idVal) async {
    await customUpdate('DELETE FROM $table WHERE $idCol = ?',
        variables: [Variable<String>(idVal)]);
  }

  // ── Accounts ─────────────────────────────────────────────────────────────
  Future<List<Account>> getAccounts() async {
    final rows = await customSelect(
        'SELECT * FROM accounts ORDER BY order_index ASC').get();
    return rows.map((r) => Account.fromMap(r.data)).toList();
  }

  Future<void> insertAccount(Account a) async => insertMap('accounts', a.toMap());

  Future<void> updateAccount(Account a) async =>
      updateMap('accounts', a.toMap(), 'id', a.id);

  Future<void> deleteAccount(String id) async {
    await transaction(() async {
      await customUpdate('DELETE FROM transactions WHERE account_id = ?',
          variables: [Variable<String>(id)]);
      await customUpdate('DELETE FROM accounts WHERE id = ?',
          variables: [Variable<String>(id)]);
    });
  }

  // ── Categories ───────────────────────────────────────────────────────────
  Future<List<AppCategory>> getCategories() async {
    final rows = await customSelect(
        'SELECT * FROM categories ORDER BY order_index ASC').get();
    return rows.map((r) => AppCategory.fromMap(r.data)).toList();
  }

  Future<void> insertCategory(AppCategory c) async =>
      insertMap('categories', c.toMap());

  Future<void> updateCategory(AppCategory c) async =>
      updateMap('categories', c.toMap(), 'id', c.id);

  Future<void> deleteCategory(String id) async =>
      deleteRow('categories', 'id', id);

  // ── Transactions ─────────────────────────────────────────────────────────
  Future<List<AppTransaction>> getTransactions({int? limit, int offset = 0}) async {
    String query = 'SELECT * FROM transactions ORDER BY date DESC';
    if (limit != null) {
      query += ' LIMIT $limit OFFSET $offset';
    } else if (offset > 0) {
      query += ' LIMIT -1 OFFSET $offset';
    }
    final rows = await customSelect(query).get();
    return rows.map((r) => AppTransaction.fromMap(r.data)).toList();
  }

  Future<List<AppTransaction>> getTransactionsForAccount(String accountId,
      {int? limit, int offset = 0}) async {
    String query = 'SELECT * FROM transactions WHERE account_id = ? ORDER BY date DESC';
    if (limit != null) {
      query += ' LIMIT $limit OFFSET $offset';
    } else if (offset > 0) {
      query += ' LIMIT -1 OFFSET $offset';
    }
    final rows = await customSelect(query,
        variables: [Variable<String>(accountId)]).get();
    return rows.map((r) => AppTransaction.fromMap(r.data)).toList();
  }

  Future<void> insertTransaction(AppTransaction t) async =>
      insertMap('transactions', t.toMap());

  Future<void> updateTransaction(AppTransaction t) async =>
      updateMap('transactions', t.toMap(), 'id', t.id);

  Future<void> deleteTransaction(String id) async {
    await transaction(() async {
      await customUpdate(
          'DELETE FROM transaction_splits WHERE transaction_id = ?',
          variables: [Variable<String>(id)]);
      await customUpdate('DELETE FROM transactions WHERE id = ?',
          variables: [Variable<String>(id)]);
    });
  }

  // ── Recurring Payments ───────────────────────────────────────────────────
  Future<List<RecurringPayment>> getRecurring() async {
    final rows = await customSelect(
        'SELECT * FROM recurring_payments ORDER BY start_date ASC').get();
    return rows.map((r) => RecurringPayment.fromMap(r.data)).toList();
  }

  Future<void> insertRecurring(RecurringPayment r) async =>
      insertMap('recurring_payments', r.toMap());

  Future<void> updateRecurring(RecurringPayment r) async =>
      updateMap('recurring_payments', r.toMap(), 'id', r.id);

  Future<void> deleteRecurring(String id) async =>
      deleteRow('recurring_payments', 'id', id);

  // ── Wishlist ─────────────────────────────────────────────────────────────
  Future<List<WishlistItem>> getWishlist() async {
    final rows = await customSelect(
        'SELECT * FROM wishlist ORDER BY created_at DESC').get();
    return rows.map((r) => WishlistItem.fromMap(r.data)).toList();
  }

  Future<void> insertWishlist(WishlistItem w) async =>
      insertMap('wishlist', w.toMap());

  Future<void> updateWishlist(WishlistItem w) async =>
      updateMap('wishlist', w.toMap(), 'id', w.id);

  Future<void> deleteWishlist(String id) async =>
      deleteRow('wishlist', 'id', id);

  // ── Lended People ────────────────────────────────────────────────────────
  Future<List<LendedPerson>> getLendedPeople() async {
    final rows = await customSelect(
        'SELECT * FROM lended_people ORDER BY created_at ASC').get();
    return rows.map((r) => LendedPerson.fromMap(r.data)).toList();
  }

  Future<void> insertLendedPerson(LendedPerson p) async =>
      insertMap('lended_people', p.toMap());

  Future<void> updateLendedPerson(LendedPerson p) async =>
      updateMap('lended_people', p.toMap(), 'id', p.id);

  Future<void> deleteLendedPerson(String id) async {
    await transaction(() async {
      await customUpdate('DELETE FROM lended_money WHERE person_id = ?',
          variables: [Variable<String>(id)]);
      await customUpdate('DELETE FROM lended_people WHERE id = ?',
          variables: [Variable<String>(id)]);
    });
  }

  // ── Lended Money ─────────────────────────────────────────────────────────
  Future<List<LendedMoney>> getLended() async {
    final rows = await customSelect(
        'SELECT * FROM lended_money ORDER BY date DESC').get();
    return rows.map((r) => LendedMoney.fromMap(r.data)).toList();
  }

  Future<List<LendedMoney>> getLendedForPerson(String personId) async {
    final rows = await customSelect(
        'SELECT * FROM lended_money WHERE person_id = ? ORDER BY date DESC',
        variables: [Variable<String>(personId)]).get();
    return rows.map((r) => LendedMoney.fromMap(r.data)).toList();
  }

  Future<void> insertLended(LendedMoney l) async =>
      insertMap('lended_money', l.toMap());

  Future<void> updateLended(LendedMoney l) async =>
      updateMap('lended_money', l.toMap(), 'id', l.id);

  Future<void> deleteLended(String id) async =>
      deleteRow('lended_money', 'id', id);

  Future<void> deleteLendedForPerson(String personId) async =>
      deleteRow('lended_money', 'person_id', personId);

  // ── Assets ───────────────────────────────────────────────────────────────
  Future<List<AssetItem>> getAssets() async {
    final rows =
        await customSelect('SELECT * FROM assets ORDER BY created_at ASC').get();
    return rows.map((r) => AssetItem.fromMap(r.data)).toList();
  }

  Future<void> insertAsset(AssetItem a) async => insertMap('assets', a.toMap());

  Future<void> updateAsset(AssetItem a) async =>
      updateMap('assets', a.toMap(), 'id', a.id);

  Future<void> deleteAsset(String id) async => deleteRow('assets', 'id', id);

  // ── Budgets ──────────────────────────────────────────────────────────────
  Future<List<Budget>> getBudgets() async {
    final rows =
        await customSelect('SELECT * FROM budgets ORDER BY created_at ASC').get();
    return rows.map((r) => Budget.fromMap(r.data)).toList();
  }

  Future<void> insertBudget(Budget b) async => insertMap('budgets', b.toMap());

  Future<void> updateBudget(Budget b) async =>
      updateMap('budgets', b.toMap(), 'id', b.id);

  Future<void> deleteBudget(String id) async => deleteRow('budgets', 'id', id);

  // ── Savings Goals ────────────────────────────────────────────────────────
  Future<List<SavingsGoal>> getSavingsGoals() async {
    final rows = await customSelect(
        'SELECT * FROM savings_goals ORDER BY created_at ASC').get();
    return rows.map((r) => SavingsGoal.fromMap(r.data)).toList();
  }

  Future<void> insertSavingsGoal(SavingsGoal g) async =>
      insertMap('savings_goals', g.toMap());

  Future<void> updateSavingsGoal(SavingsGoal g) async =>
      updateMap('savings_goals', g.toMap(), 'id', g.id);

  Future<void> deleteSavingsGoal(String id) async {
    await transaction(() async {
      await customUpdate(
          'DELETE FROM savings_contributions WHERE goal_id = ?',
          variables: [Variable<String>(id)]);
      await customUpdate('DELETE FROM savings_goals WHERE id = ?',
          variables: [Variable<String>(id)]);
    });
  }

  // ── Savings Contributions ────────────────────────────────────────────────
  Future<List<SavingsContribution>> getSavingsContributionsFor(
      String goalId) async {
    final rows = await customSelect(
        'SELECT * FROM savings_contributions WHERE goal_id = ? ORDER BY date DESC',
        variables: [Variable<String>(goalId)]).get();
    return rows.map((r) => SavingsContribution.fromMap(r.data)).toList();
  }

  Future<List<SavingsContribution>> getAllSavingsContributions() async {
    final rows = await customSelect(
        'SELECT * FROM savings_contributions ORDER BY date DESC').get();
    return rows.map((r) => SavingsContribution.fromMap(r.data)).toList();
  }

  Future<void> insertSavingsContribution(SavingsContribution c) async =>
      insertMap('savings_contributions', c.toMap());

  // ── Recurring History ────────────────────────────────────────────────────
  Future<List<RecurringHistoryEntry>> getRecurringHistory(
      String recurringId) async {
    final rows = await customSelect(
        'SELECT * FROM recurring_history WHERE recurring_id = ? ORDER BY date DESC',
        variables: [Variable<String>(recurringId)]).get();
    return rows.map((r) => RecurringHistoryEntry.fromMap(r.data)).toList();
  }

  Future<List<RecurringHistoryEntry>> getAllRecurringHistory() async {
    final rows = await customSelect(
        'SELECT * FROM recurring_history ORDER BY date DESC').get();
    return rows.map((r) => RecurringHistoryEntry.fromMap(r.data)).toList();
  }

  Future<int> getRecurringHistoryCount() async {
    final rows =
        await customSelect('SELECT COUNT(*) AS c FROM recurring_history').get();
    return (rows.first.data['c'] as int?) ?? 0;
  }

  Future<void> insertRecurringHistory(RecurringHistoryEntry e) async =>
      insertMap('recurring_history', e.toMap());

  Future<void> deleteRecurringHistoryFor(String recurringId) async =>
      customUpdate('DELETE FROM recurring_history WHERE recurring_id = ?',
          variables: [Variable<String>(recurringId)]);

  // ── Loans ────────────────────────────────────────────────────────────────
  Future<List<Loan>> getLoans() async {
    final rows =
        await customSelect('SELECT * FROM loans ORDER BY created_at ASC').get();
    return rows.map((r) => Loan.fromMap(r.data)).toList();
  }

  Future<void> insertLoan(Loan l) async => insertMap('loans', l.toMap());

  Future<void> updateLoan(Loan l) async =>
      updateMap('loans', l.toMap(), 'id', l.id);

  Future<void> deleteLoan(String id) async {
    await transaction(() async {
      await customUpdate('DELETE FROM loan_payments WHERE loan_id = ?',
          variables: [Variable<String>(id)]);
      await customUpdate('DELETE FROM loans WHERE id = ?',
          variables: [Variable<String>(id)]);
    });
  }

  // ── Loan Payments ────────────────────────────────────────────────────────
  Future<List<LoanPayment>> getLoanPayments(String loanId) async {
    final rows = await customSelect(
        'SELECT * FROM loan_payments WHERE loan_id = ? ORDER BY date DESC',
        variables: [Variable<String>(loanId)]).get();
    return rows.map((r) => LoanPayment.fromMap(r.data)).toList();
  }

  Future<List<LoanPayment>> getAllLoanPayments() async {
    final rows = await customSelect(
        'SELECT * FROM loan_payments ORDER BY date DESC').get();
    return rows.map((r) => LoanPayment.fromMap(r.data)).toList();
  }

  Future<void> insertLoanPayment(LoanPayment p) async =>
      insertMap('loan_payments', p.toMap());

  Future<void> deleteLoanPayment(String id) async =>
      deleteRow('loan_payments', 'id', id);

  Future<void> deleteLoanPaymentsFor(String loanId) async =>
      deleteRow('loan_payments', 'loan_id', loanId);

  // ── Transaction Presets ──────────────────────────────────────────────────
  Future<List<TransactionPreset>> getPresets() async {
    final rows = await customSelect(
        'SELECT * FROM transaction_presets ORDER BY order_index ASC, created_at DESC').get();
    return rows.map((r) => TransactionPreset.fromMap(r.data)).toList();
  }

  Future<void> insertPreset(TransactionPreset p) async =>
      insertMap('transaction_presets', p.toMap());

  Future<void> updatePreset(TransactionPreset p) async =>
      updateMap('transaction_presets', p.toMap(), 'id', p.id);

  Future<void> deletePreset(String id) async =>
      deleteRow('transaction_presets', 'id', id);

  // ── Transaction Splits ───────────────────────────────────────────────────
  Future<List<TransactionSplit>> getAllSplits() async {
    final rows = await customSelect('SELECT * FROM transaction_splits').get();
    return rows.map((r) => TransactionSplit.fromMap(r.data)).toList();
  }

  Future<List<TransactionSplit>> getSplitsForTransaction(
      String transactionId) async {
    final rows = await customSelect(
        'SELECT * FROM transaction_splits WHERE transaction_id = ?',
        variables: [Variable<String>(transactionId)]).get();
    return rows.map((r) => TransactionSplit.fromMap(r.data)).toList();
  }

  Future<void> saveTransactionSplits(
      String transactionId, List<TransactionSplit> splits) async {
    await transaction(() async {
      await customUpdate(
          'DELETE FROM transaction_splits WHERE transaction_id = ?',
          variables: [Variable<String>(transactionId)]);
      for (final s in splits) {
        await insertMap('transaction_splits', s.toMap());
      }
    });
  }

  Future<void> deleteSplitsForTransaction(String transactionId) async =>
      deleteRow('transaction_splits', 'transaction_id', transactionId);

  // ── Net Worth Snapshots ──────────────────────────────────────────────────
  Future<List<NetWorthSnapshot>> getNetWorthSnapshots(
      {DateTime? since, int? limit}) async {
    final dateStr =
        since != null ? DateFormat('yyyy-MM-dd').format(since) : null;
    String query;
    List<Variable> vars = [];
    if (dateStr != null) {
      query =
          'SELECT * FROM net_worth_snapshots WHERE date >= ? ORDER BY date ASC';
      vars.add(Variable<String>(dateStr));
    } else {
      query = 'SELECT * FROM net_worth_snapshots ORDER BY date ASC';
    }
    if (limit != null) {
      query += ' LIMIT $limit';
    }
    final rows = await customSelect(query, variables: vars).get();
    return rows.map((r) => NetWorthSnapshot.fromMap(r.data)).toList();
  }

  Future<NetWorthSnapshot?> getNetWorthSnapshotForDate(String date) async {
    final rows = await customSelect(
        'SELECT * FROM net_worth_snapshots WHERE date = ?',
        variables: [Variable<String>(date)]).get();
    if (rows.isEmpty) return null;
    return NetWorthSnapshot.fromMap(rows.first.data);
  }

  Future<void> insertNetWorthSnapshot(NetWorthSnapshot snap) async =>
      insertMap('net_worth_snapshots', snap.toMap());

  // ── Aggregations ─────────────────────────────────────────────────────────
  Future<double> getMonthlySpentForCategory(
      String categoryId, DateTime month) async {
    final start = DateTime(month.year, month.month, 1).toIso8601String();
    final end =
        DateTime(month.year, month.month + 1, 0, 23, 59, 59).toIso8601String();
    final result = await customSelect(
        "SELECT SUM(amount) as total FROM transactions WHERE category_id = ? AND type = 'expense' AND date >= ? AND date <= ?",
        variables: [
          Variable<String>(categoryId),
          Variable<String>(start),
          Variable<String>(end)
        ]).get();
    return (result.first.data['total'] as num?)?.toDouble() ?? 0.0;
  }

  Future<Map<String, double>> getTotalIncomeAndExpenseForMonth(
      DateTime month) async {
    final start = DateTime(month.year, month.month, 1).toIso8601String();
    final end =
        DateTime(month.year, month.month + 1, 0, 23, 59, 59).toIso8601String();
    final result = await customSelect(
        "SELECT type, SUM(amount) as total FROM transactions WHERE date >= ? AND date <= ? GROUP BY type",
        variables: [Variable<String>(start), Variable<String>(end)]).get();

    double income = 0;
    double expense = 0;
    for (final row in result) {
      if (row.data['type'] == 'income') {
        income = (row.data['total'] as num?)?.toDouble() ?? 0.0;
      } else if (row.data['type'] == 'expense') {
        expense = (row.data['total'] as num?)?.toDouble() ?? 0.0;
      }
    }
    return {'income': income, 'expense': expense};
  }

  Future<double> getTotalBudgetSpent(
      String categoryId, DateTime start, DateTime end) async {
    final result = await customSelect(
        "SELECT SUM(amount) as total FROM transactions WHERE category_id = ? AND type = 'expense' AND date >= ? AND date <= ?",
        variables: [
          Variable<String>(categoryId),
          Variable<String>(start.toIso8601String()),
          Variable<String>(end.toIso8601String())
        ]).get();
    return (result.first.data['total'] as num?)?.toDouble() ?? 0.0;
  }

  Future<List<Map<String, dynamic>>> getCategoryExpensesForMonth(
      DateTime month) async {
    final start = DateTime(month.year, month.month, 1).toIso8601String();
    final end =
        DateTime(month.year, month.month + 1, 0, 23, 59, 59).toIso8601String();
    final rows = await customSelect(
        "SELECT category_id, SUM(amount) as total FROM transactions WHERE type = 'expense' AND date >= ? AND date <= ? GROUP BY category_id",
        variables: [Variable<String>(start), Variable<String>(end)]).get();
    return rows.map((r) => r.data).toList();
  }

  // ── Backup / Export / Import ──────────────────────────────────────────────
  Future<Map<String, dynamic>> exportAll() async {
    final tables = [
      'accounts',
      'categories',
      'transactions',
      'recurring_payments',
      'wishlist',
      'lended_people',
      'lended_money',
      'assets',
      'budgets',
      'recurring_history',
      'savings_goals',
      'savings_contributions',
      'loans',
      'loan_payments',
      'transaction_presets',
      'transaction_splits',
    ];
    final results = await Future.wait(
      tables.map((t) async {
        final rows = await customSelect('SELECT * FROM $t').get();
        return rows.map((r) => r.data).toList();
      }),
    );
    return {
      for (int i = 0; i < tables.length; i++) tables[i]: results[i],
      'version': _version,
    };
  }

  Future<void> importAll(Map<String, dynamic> data) async {
    _normaliseBackup(data);
    await transaction(() async {
      for (final table in [
        'accounts',
        'categories',
        'transactions',
        'recurring_payments',
        'wishlist',
        'lended_people',
        'lended_money',
        'assets',
        'budgets',
        'recurring_history',
        'savings_goals',
        'savings_contributions',
        'loans',
        'loan_payments',
        'transaction_presets',
        'transaction_splits',
      ]) {
        await customStatement('DELETE FROM $table');
        final rows =
            (data[table] as List?)?.cast<Map<String, dynamic>>() ?? [];
        for (final raw in rows) {
          final row = Map<String, dynamic>.from(raw);
          await insertMap(table, row);
        }
      }
    });
  }

  static void _normaliseBackup(Map<String, dynamic> data) {
    for (final row in _rows(data, 'transaction_presets')) {
      row.putIfAbsent('currency', () => '');
      row.putIfAbsent('note', () => '');
      row.putIfAbsent('icon_code_point', () => 0);
      row.putIfAbsent('order_index', () => 0);
    }

    for (final row in _rows(data, 'transaction_splits')) {
      row.putIfAbsent('note', () => '');
    }

    for (final row in _rows(data, 'accounts')) {
      row.putIfAbsent('exclude_from_total', () => 0);
      row.putIfAbsent('currency', () => 'EGP');
      if (!row.containsKey('gold_karat')) row['gold_karat'] = null;
      if (!row.containsKey('gold_grams')) row['gold_grams'] = null;
      row.putIfAbsent('credit_early_reminder_enabled', () => 0);
      if (!row.containsKey('linked_account_id')) {
        row['linked_account_id'] = null;
      }
      row.putIfAbsent('exclude_from_bank_total', () => 0);
      row.putIfAbsent('order_index', () => 0);
    }

    for (final row in _rows(data, 'transactions')) {
      row.putIfAbsent('note', () => '');
      row.putIfAbsent('currency', () => '');
    }

    for (final row in _rows(data, 'recurring_payments')) {
      row.putIfAbsent('payment_type', () => 'expense');
      row.putIfAbsent('reminder_enabled', () => 0);
      row.putIfAbsent('reminder_time', () => '09:00');
      row.putIfAbsent('early_reminder_enabled', () => 0);
      row.putIfAbsent('notes', () => '');
      row.putIfAbsent('paid_payments', () => 0);
      row.putIfAbsent('recurring_type', () => 'subscription');
      if (row.containsKey('freq_unit')) {
        final u = row['freq_unit'] as String? ?? 'months';
        const map = {
          'day': 'days',
          'week': 'weeks',
          'month': 'months',
          'year': 'years',
        };
        row['freq_unit'] = map[u] ?? u;
      }
    }

    for (final row in _rows(data, 'wishlist')) {
      row.putIfAbsent('is_purchased', () => 0);
      row.putIfAbsent('notes', () => '');
      row.putIfAbsent('priority', () => 'low');
      row.putIfAbsent('goal_id', () => null);
    }

    for (final row in _rows(data, 'lended_money')) {
      row.putIfAbsent('is_settled', () => 0);
      row.putIfAbsent('notes', () => '');
      row.putIfAbsent('due_date', () => null);
      row.putIfAbsent('account_id', () => null);
      row.putIfAbsent('reminder_enabled', () => 0);
      row.putIfAbsent('reminder_time', () => '09:00');
    }

    data.putIfAbsent('lended_people', () => <dynamic>[]);
    final peopleRows = _rows(data, 'lended_people');
    final lendedRows = _rows(data, 'lended_money');
    final needsBackfill =
        lendedRows.isNotEmpty && lendedRows.any((r) => r['person_id'] == null);
    if (needsBackfill) {
      final nameToId = <String, String>{};
      for (final r in peopleRows) {
        final name = (r['name'] as String?)?.trim();
        final id = r['id'] as String?;
        if (name != null && name.isNotEmpty && id != null) {
          nameToId[name] = id;
        }
      }
      var colorIdx = 0;
      const palette = [
        0xFF1E88E5,
        0xFF43A047,
        0xFFE53935,
        0xFFFB8C00,
        0xFF8E24AA,
        0xFF00ACC1,
        0xFF3949AB,
        0xFFD81B60,
      ];
      for (final row in lendedRows) {
        if (row['person_id'] != null) continue;
        final rawName = (row['person_name'] as String?)?.trim();
        final name =
            (rawName != null && rawName.isNotEmpty) ? rawName : 'Unknown';
        var personId = nameToId[name];
        if (personId == null) {
          personId =
              'migrated_${DateTime.now().microsecondsSinceEpoch}_$colorIdx';
          nameToId[name] = personId;
          peopleRows.add({
            'id': personId,
            'name': name,
            'color_value': palette[colorIdx % palette.length],
            'notes': '',
            'created_at': DateTime.now().toIso8601String(),
          });
          colorIdx++;
        }
        row['person_id'] = personId;
      }
    }

    for (final row in _rows(data, 'lended_people')) {
      row.putIfAbsent('notes', () => '');
      row.putIfAbsent('color_value', () => 0xFF1E88E5);
      row.putIfAbsent('created_at', () => DateTime.now().toIso8601String());
    }

    for (final row in _rows(data, 'assets')) {
      row.putIfAbsent('currency', () => 'EGP');
      row.putIfAbsent('notes', () => '');
      row.putIfAbsent('created_at', () => DateTime.now().toIso8601String());
    }

    for (final row in _rows(data, 'budgets')) {
      row.putIfAbsent('period', () => 'monthly');
      row.putIfAbsent('created_at', () => DateTime.now().toIso8601String());
      row.putIfAbsent('allow_rollover', () => 0);
    }

    for (final row in _rows(data, 'savings_goals')) {
      row.putIfAbsent('current_amount', () => 0);
      row.putIfAbsent('is_completed', () => 0);
      row.putIfAbsent('color_value', () => 0xFF2E7D32);
      row.putIfAbsent('created_at', () => DateTime.now().toIso8601String());
      row.putIfAbsent('wishlist_item_id', () => null);
    }

    for (final row in _rows(data, 'savings_contributions')) {
      row.putIfAbsent('note', () => '');
    }

    for (final row in _rows(data, 'loans')) {
      row.putIfAbsent('currency', () => 'EGP');
      row.putIfAbsent('reminder_enabled', () => 0);
      row.putIfAbsent('reminder_day', () => 1);
      row.putIfAbsent('reminder_time', () => '09:00');
      row.putIfAbsent('is_settled', () => 0);
      row.putIfAbsent('notes', () => '');
      row.putIfAbsent('created_at', () => DateTime.now().toIso8601String());
    }

    for (final row in _rows(data, 'loan_payments')) {
      row.putIfAbsent('notes', () => '');
    }
  }

  static List<Map<String, dynamic>> _rows(
      Map<String, dynamic> data, String table) {
    return (data[table] as List?)?.cast<Map<String, dynamic>>() ??
        <Map<String, dynamic>>[];
  }
}
