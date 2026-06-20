// lib/database/db_helper.dart
import 'package:sqflite/sqflite.dart' hide Transaction;
import 'package:path/path.dart';
import '../models/models.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 9;

  static Future<Database> get database async {
    _db ??= await _open();
    return _db!;
  }

  static Future<Database> _open() async {
    final path = join(await getDatabasesPath(), 'expensy.db');
    return openDatabase(path, version: _version,
        onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  static Future<void> _onUpgrade(Database db, int oldV, int newV) async {
    if (oldV < 2) {
      try { await db.execute('ALTER TABLE accounts ADD COLUMN exclude_from_total INTEGER NOT NULL DEFAULT 0'); } catch (_) {}
      try { await db.execute("ALTER TABLE recurring_payments ADD COLUMN payment_type TEXT NOT NULL DEFAULT 'expense'"); } catch (_) {}
    }
    if (oldV < 3) {
      try { await db.execute("ALTER TABLE recurring_payments ADD COLUMN reminder_time TEXT NOT NULL DEFAULT '09:00'"); } catch (_) {}
    }
    if (oldV < 4) {
      try { await db.execute("ALTER TABLE transactions ADD COLUMN currency TEXT NOT NULL DEFAULT ''"); } catch (_) {}
    }
    if (oldV < 5) {
      try {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS assets (
            id TEXT PRIMARY KEY, name TEXT NOT NULL, value REAL NOT NULL,
            currency TEXT NOT NULL DEFAULT 'EGP',
            notes TEXT NOT NULL DEFAULT '', created_at TEXT NOT NULL
          )''');
      } catch (_) {}
    }
    if (oldV < 6) {
      try { await db.execute('ALTER TABLE accounts ADD COLUMN gold_karat INTEGER'); } catch (_) {}
      try { await db.execute('ALTER TABLE accounts ADD COLUMN gold_grams REAL'); } catch (_) {}
    }
    if (oldV < 7) {
      try { await db.execute('ALTER TABLE recurring_payments ADD COLUMN early_reminder_enabled INTEGER NOT NULL DEFAULT 0'); } catch (_) {}
    }
    if (oldV < 8) {
      try {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS budgets (
            id TEXT PRIMARY KEY,
            category_id TEXT NOT NULL,
            amount REAL NOT NULL,
            period TEXT NOT NULL DEFAULT 'monthly',
            created_at TEXT NOT NULL
          )''');
      } catch (_) {}
      try {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS recurring_history (
            id TEXT PRIMARY KEY,
            recurring_id TEXT NOT NULL,
            action TEXT NOT NULL,
            date TEXT NOT NULL,
            amount REAL NOT NULL,
            currency TEXT NOT NULL
          )''');
      } catch (_) {}
      try {
        await db.execute(
            'CREATE INDEX IF NOT EXISTS idx_rh_recurring_id ON recurring_history(recurring_id)');
      } catch (_) {}
    }
    // v8 → v9: category icon + lended_money reminders
    if (oldV < 9) {
      try {
        await db.execute(
            'ALTER TABLE categories ADD COLUMN icon_code_point INTEGER NOT NULL DEFAULT 0');
      } catch (_) {}
      try {
        await db.execute(
            'ALTER TABLE lended_money ADD COLUMN reminder_enabled INTEGER NOT NULL DEFAULT 0');
      } catch (_) {}
      try {
        await db.execute(
            "ALTER TABLE lended_money ADD COLUMN reminder_time TEXT NOT NULL DEFAULT '09:00'");
      } catch (_) {}
    }
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE accounts (
        id TEXT PRIMARY KEY, name TEXT NOT NULL, type TEXT NOT NULL,
        balance REAL NOT NULL, currency TEXT NOT NULL DEFAULT 'EGP',
        color_value INTEGER NOT NULL, exclude_from_total INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        gold_karat INTEGER,
        gold_grams REAL
      )''');
    await db.execute('''
      CREATE TABLE categories (
        id TEXT PRIMARY KEY, name TEXT NOT NULL,
        type TEXT NOT NULL, color_value INTEGER NOT NULL,
        icon_code_point INTEGER NOT NULL DEFAULT 0
      )''');
    await db.execute('''
      CREATE TABLE transactions (
        id TEXT PRIMARY KEY, type TEXT NOT NULL, amount REAL NOT NULL,
        description TEXT NOT NULL, account_id TEXT NOT NULL,
        category_id TEXT NOT NULL, date TEXT NOT NULL,
        note TEXT NOT NULL DEFAULT '',
        currency TEXT NOT NULL DEFAULT ''
      )''');
    await db.execute('''
      CREATE TABLE recurring_payments (
        id TEXT PRIMARY KEY, name TEXT NOT NULL, account_id TEXT NOT NULL,
        category_id TEXT NOT NULL, amount REAL NOT NULL,
        payment_type TEXT NOT NULL DEFAULT 'expense',
        freq_val INTEGER NOT NULL DEFAULT 1, freq_unit TEXT NOT NULL DEFAULT 'months',
        start_date TEXT NOT NULL, next_date TEXT NOT NULL, end_date TEXT,
        paid_payments INTEGER NOT NULL DEFAULT 0,
        reminder_enabled INTEGER NOT NULL DEFAULT 0,
        reminder_time TEXT NOT NULL DEFAULT '09:00',
        early_reminder_enabled INTEGER NOT NULL DEFAULT 0,
        notes TEXT NOT NULL DEFAULT ''
      )''');
    await db.execute('''
      CREATE TABLE wishlist (
        id TEXT PRIMARY KEY, name TEXT NOT NULL, target_price REAL NOT NULL,
        priority TEXT NOT NULL, is_purchased INTEGER NOT NULL DEFAULT 0,
        notes TEXT NOT NULL DEFAULT '', created_at TEXT NOT NULL
      )''');
    await db.execute('''
      CREATE TABLE lended_money (
        id TEXT PRIMARY KEY, person_name TEXT NOT NULL, amount REAL NOT NULL,
        type TEXT NOT NULL, account_id TEXT, is_settled INTEGER NOT NULL DEFAULT 0,
        date TEXT NOT NULL, due_date TEXT, notes TEXT NOT NULL DEFAULT '',
        reminder_enabled INTEGER NOT NULL DEFAULT 0,
        reminder_time TEXT NOT NULL DEFAULT '09:00'
      )''');
    await db.execute('''
      CREATE TABLE assets (
        id TEXT PRIMARY KEY, name TEXT NOT NULL, value REAL NOT NULL,
        currency TEXT NOT NULL DEFAULT 'EGP',
        notes TEXT NOT NULL DEFAULT '', created_at TEXT NOT NULL
      )''');
    await db.execute('''
      CREATE TABLE budgets (
        id TEXT PRIMARY KEY,
        category_id TEXT NOT NULL,
        amount REAL NOT NULL,
        period TEXT NOT NULL DEFAULT 'monthly',
        created_at TEXT NOT NULL
      )''');
    await db.execute('''
      CREATE TABLE recurring_history (
        id TEXT PRIMARY KEY,
        recurring_id TEXT NOT NULL,
        action TEXT NOT NULL,
        date TEXT NOT NULL,
        amount REAL NOT NULL,
        currency TEXT NOT NULL
      )''');
    await db.execute(
        'CREATE INDEX idx_rh_recurring_id ON recurring_history(recurring_id)');

    await _insertDefaults(db);
  }

  static Future<void> _insertDefaults(Database db) async {
    const cats = [
      ('food_exp', 'Food & Dining', 'expense', 0xFFE65100),
      ('transport', 'Transport', 'expense', 0xFF1565C0),
      ('shopping', 'Shopping', 'expense', 0xFF7D5260),
      ('bills', 'Bills & Utilities', 'expense', 0xFF827717),
      ('health', 'Health', 'expense', 0xFF2E7D32),
      ('entertainment', 'Entertainment', 'expense', 0xFF6750A4),
      ('education', 'Education', 'expense', 0xFF37474F),
      ('other_exp', 'Other', 'expense', 0xFF546E7A),
      ('salary', 'Salary', 'income', 0xFF1B5E20),
      ('freelance', 'Freelance', 'income', 0xFF0D47A1),
      ('business', 'Business', 'income', 0xFF4A148C),
      ('investment', 'Investment', 'income', 0xFF1A237E),
      ('gift', 'Gift', 'income', 0xFF880E4F),
    ];
    for (final c in cats) {
      await db.insert('categories', {
        'id': c.$1, 'name': c.$2, 'type': c.$3, 'color_value': c.$4,
      });
    }
  }

  // ── Accounts ─────────────────────────────────────────────────────────
  static Future<List<Account>> getAccounts() async {
    final db = await database;
    final rows = await db.query('accounts', orderBy: 'created_at ASC');
    return rows.map(Account.fromMap).toList();
  }
  static Future<void> insertAccount(Account a) async =>
      (await database).insert('accounts', a.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
  static Future<void> updateAccount(Account a) async =>
      (await database).update('accounts', a.toMap(), where: 'id=?', whereArgs: [a.id]);
  static Future<void> deleteAccount(String id) async {
    final db = await database;
    await db.delete('transactions', where: 'account_id=?', whereArgs: [id]);
    await db.delete('accounts', where: 'id=?', whereArgs: [id]);
  }

  // ── Categories ───────────────────────────────────────────────────────
  static Future<List<AppCategory>> getCategories() async {
    final db = await database;
    final rows = await db.query('categories');
    return rows.map(AppCategory.fromMap).toList();
  }
  static Future<void> insertCategory(AppCategory c) async =>
      (await database).insert('categories', c.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
  static Future<void> updateCategory(AppCategory c) async =>
      (await database).update('categories', c.toMap(), where: 'id=?', whereArgs: [c.id]);
  static Future<void> deleteCategory(String id) async =>
      (await database).delete('categories', where: 'id=?', whereArgs: [id]);

  // ── Transactions ─────────────────────────────────────────────────────
  static Future<List<AppTransaction>> getTransactions() async {
    final db = await database;
    final rows = await db.query('transactions', orderBy: 'date DESC');
    return rows.map(AppTransaction.fromMap).toList();
  }
  static Future<void> insertTransaction(AppTransaction t) async =>
      (await database).insert('transactions', t.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
  static Future<void> updateTransaction(AppTransaction t) async =>
      (await database).update('transactions', t.toMap(), where: 'id=?', whereArgs: [t.id]);
  static Future<void> deleteTransaction(String id) async =>
      (await database).delete('transactions', where: 'id=?', whereArgs: [id]);

  // ── Recurring ────────────────────────────────────────────────────────
  static Future<List<RecurringPayment>> getRecurring() async {
    final db = await database;
    final rows = await db.query('recurring_payments', orderBy: 'start_date ASC');
    return rows.map(RecurringPayment.fromMap).toList();
  }
  static Future<void> insertRecurring(RecurringPayment r) async =>
      (await database).insert('recurring_payments', r.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
  static Future<void> updateRecurring(RecurringPayment r) async =>
      (await database).update('recurring_payments', r.toMap(),
          where: 'id=?', whereArgs: [r.id]);
  static Future<void> deleteRecurring(String id) async =>
      (await database).delete('recurring_payments', where: 'id=?', whereArgs: [id]);

  // ── Wishlist ─────────────────────────────────────────────────────────
  static Future<List<WishlistItem>> getWishlist() async {
    final db = await database;
    final rows = await db.query('wishlist', orderBy: 'created_at DESC');
    return rows.map(WishlistItem.fromMap).toList();
  }
  static Future<void> insertWishlist(WishlistItem w) async =>
      (await database).insert('wishlist', w.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
  static Future<void> updateWishlist(WishlistItem w) async =>
      (await database).update('wishlist', w.toMap(), where: 'id=?', whereArgs: [w.id]);
  static Future<void> deleteWishlist(String id) async =>
      (await database).delete('wishlist', where: 'id=?', whereArgs: [id]);

  // ── Lended Money ─────────────────────────────────────────────────────
  static Future<List<LendedMoney>> getLended() async {
    final db = await database;
    final rows = await db.query('lended_money', orderBy: 'date DESC');
    return rows.map(LendedMoney.fromMap).toList();
  }
  static Future<void> insertLended(LendedMoney l) async =>
      (await database).insert('lended_money', l.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
  static Future<void> updateLended(LendedMoney l) async =>
      (await database).update('lended_money', l.toMap(), where: 'id=?', whereArgs: [l.id]);
  static Future<void> deleteLended(String id) async =>
      (await database).delete('lended_money', where: 'id=?', whereArgs: [id]);

  // ── Assets ────────────────────────────────────────────────────────────
  static Future<List<AssetItem>> getAssets() async {
    final db = await database;
    final rows = await db.query('assets', orderBy: 'created_at ASC');
    return rows.map(AssetItem.fromMap).toList();
  }
  static Future<void> insertAsset(AssetItem a) async =>
      (await database).insert('assets', a.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
  static Future<void> updateAsset(AssetItem a) async =>
      (await database).update('assets', a.toMap(), where: 'id=?', whereArgs: [a.id]);
  static Future<void> deleteAsset(String id) async =>
      (await database).delete('assets', where: 'id=?', whereArgs: [id]);

  // ── Budgets ───────────────────────────────────────────────────────────
  static Future<List<Budget>> getBudgets() async {
    final db = await database;
    final rows = await db.query('budgets', orderBy: 'created_at ASC');
    return rows.map(Budget.fromMap).toList();
  }
  static Future<void> insertBudget(Budget b) async =>
      (await database).insert('budgets', b.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
  static Future<void> updateBudget(Budget b) async =>
      (await database).update('budgets', b.toMap(), where: 'id=?', whereArgs: [b.id]);
  static Future<void> deleteBudget(String id) async =>
      (await database).delete('budgets', where: 'id=?', whereArgs: [id]);

  // ── Recurring History ─────────────────────────────────────────────────
  static Future<List<RecurringHistoryEntry>> getRecurringHistory(
      String recurringId) async {
    final db = await database;
    final rows = await db.query('recurring_history',
        where: 'recurring_id = ?',
        whereArgs: [recurringId],
        orderBy: 'date DESC');
    return rows.map(RecurringHistoryEntry.fromMap).toList();
  }

  static Future<List<RecurringHistoryEntry>> getAllRecurringHistory() async {
    final db = await database;
    final rows = await db.query('recurring_history', orderBy: 'date DESC');
    return rows.map(RecurringHistoryEntry.fromMap).toList();
  }

  static Future<void> insertRecurringHistory(RecurringHistoryEntry e) async =>
      (await database).insert('recurring_history', e.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);

  static Future<void> deleteRecurringHistoryFor(String recurringId) async =>
      (await database).delete('recurring_history',
          where: 'recurring_id = ?', whereArgs: [recurringId]);

  // ── Backup / Restore ──────────────────────────────────────────────────
  static Future<Map<String, dynamic>> exportAll() async {
    final db = await database;
    return {
      'accounts':            await db.query('accounts'),
      'categories':          await db.query('categories'),
      'transactions':        await db.query('transactions'),
      'recurring_payments':  await db.query('recurring_payments'),
      'wishlist':            await db.query('wishlist'),
      'lended_money':        await db.query('lended_money'),
      'assets':              await db.query('assets'),
      'budgets':             await db.query('budgets'),
      'recurring_history':   await db.query('recurring_history'),
      'version':             _version,
    };
  }

  static Future<void> importAll(Map<String, dynamic> data) async {
    final db = await database;
    _normaliseBackup(data);

    await db.transaction((txn) async {
      for (final table in [
        'accounts', 'categories', 'transactions',
        'recurring_payments', 'wishlist', 'lended_money', 'assets',
        'budgets', 'recurring_history',
      ]) {
        await txn.delete(table);
        final rows =
            (data[table] as List?)?.cast<Map<String, dynamic>>() ?? [];
        for (final raw in rows) {
          final row = Map<String, dynamic>.from(raw);
          await txn.insert(table, row,
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
      }
    });
  }

  static void _normaliseBackup(Map<String, dynamic> data) {
    final backupVersion = (data['version'] as int?) ?? 1;

    for (final row in _rows(data, 'accounts')) {
      row.putIfAbsent('exclude_from_total', () => 0);
      row.putIfAbsent('currency', () => 'EGP');
      if (!row.containsKey('gold_karat')) row['gold_karat'] = null;
      if (!row.containsKey('gold_grams')) row['gold_grams'] = null;
    }

    for (final row in _rows(data, 'transactions')) {
      row.putIfAbsent('note', () => '');
      row.putIfAbsent('currency', () => '');
    }

    for (final row in _rows(data, 'recurring_payments')) {
      row.putIfAbsent('payment_type',            () => 'expense');
      row.putIfAbsent('reminder_enabled',        () => 0);
      row.putIfAbsent('reminder_time',           () => '09:00');
      row.putIfAbsent('early_reminder_enabled',  () => 0);
      row.putIfAbsent('notes',                   () => '');
      row.putIfAbsent('paid_payments',           () => 0);
      if (row.containsKey('freq_unit')) {
        final u = row['freq_unit'] as String? ?? 'months';
        const map = {
          'day': 'days', 'week': 'weeks', 'month': 'months', 'year': 'years',
        };
        row['freq_unit'] = map[u] ?? u;
      }
    }

    for (final row in _rows(data, 'wishlist')) {
      row.putIfAbsent('is_purchased', () => 0);
      row.putIfAbsent('notes',        () => '');
      row.putIfAbsent('priority',     () => 'low');
    }

    for (final row in _rows(data, 'lended_money')) {
      row.putIfAbsent('is_settled',       () => 0);
      row.putIfAbsent('notes',            () => '');
      row.putIfAbsent('due_date',         () => null);
      row.putIfAbsent('account_id',       () => null);
      row.putIfAbsent('reminder_enabled', () => 0);    // v8→v9
      row.putIfAbsent('reminder_time',    () => '09:00'); // v8→v9
    }

    data.putIfAbsent('assets', () => <dynamic>[]);
    for (final row in _rows(data, 'assets')) {
      row.putIfAbsent('currency', () => 'EGP');
      row.putIfAbsent('notes',    () => '');
    }

    // v9: category icon
    for (final row in _rows(data, 'categories')) {
      row.putIfAbsent('icon_code_point', () => 0);
    }

    // v8: budgets and recurring_history
    data.putIfAbsent('budgets', () => <dynamic>[]);
    for (final row in _rows(data, 'budgets')) {
      row.putIfAbsent('period', () => 'monthly');
    }
    data.putIfAbsent('recurring_history', () => <dynamic>[]);

    data['_originalVersion'] = backupVersion;
  }

  static List<Map<String, dynamic>> _rows(
      Map<String, dynamic> data, String table) {
    final raw = data[table];
    if (raw == null) {
      data[table] = <Map<String, dynamic>>[];
      return data[table] as List<Map<String, dynamic>>;
    }
    final list = (raw as List)
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
    data[table] = list;
    return list;
  }
}
