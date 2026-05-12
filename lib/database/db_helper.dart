// lib/database/db_helper.dart
import 'package:sqflite/sqflite.dart' hide Transaction;
import 'package:path/path.dart';
import '../models/models.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 2;

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
    // v1 → v2
    try {
      await db.execute(
          'ALTER TABLE accounts ADD COLUMN exclude_from_total INTEGER NOT NULL DEFAULT 0');
    } catch (_) {}
    try {
      await db.execute(
          "ALTER TABLE recurring_payments ADD COLUMN payment_type TEXT NOT NULL DEFAULT 'expense'");
    } catch (_) {}
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE accounts (
        id TEXT PRIMARY KEY, name TEXT NOT NULL, type TEXT NOT NULL,
        balance REAL NOT NULL, currency TEXT NOT NULL DEFAULT 'EGP',
        color_value INTEGER NOT NULL, exclude_from_total INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL
      )''');
    await db.execute('''
      CREATE TABLE categories (
        id TEXT PRIMARY KEY, name TEXT NOT NULL,
        type TEXT NOT NULL, color_value INTEGER NOT NULL
      )''');
    await db.execute('''
      CREATE TABLE transactions (
        id TEXT PRIMARY KEY, type TEXT NOT NULL, amount REAL NOT NULL,
        description TEXT NOT NULL, account_id TEXT NOT NULL,
        category_id TEXT NOT NULL, date TEXT NOT NULL, note TEXT NOT NULL DEFAULT ''
      )''');
    await db.execute('''
      CREATE TABLE recurring_payments (
        id TEXT PRIMARY KEY, name TEXT NOT NULL, account_id TEXT NOT NULL,
        category_id TEXT NOT NULL, amount REAL NOT NULL,
        payment_type TEXT NOT NULL DEFAULT 'expense',
        freq_val INTEGER NOT NULL DEFAULT 1, freq_unit TEXT NOT NULL DEFAULT 'months',
        start_date TEXT NOT NULL, next_date TEXT NOT NULL, end_date TEXT,
        paid_payments INTEGER NOT NULL DEFAULT 0,
        reminder_enabled INTEGER NOT NULL DEFAULT 0, notes TEXT NOT NULL DEFAULT ''
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
        date TEXT NOT NULL, due_date TEXT, notes TEXT NOT NULL DEFAULT ''
      )''');

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
      'version':             _version,
    };
  }

  static Future<void> importAll(Map<String, dynamic> data) async {
    final db = await database;
    await db.transaction((txn) async {
      for (final table in ['accounts','categories','transactions',
                            'recurring_payments','wishlist','lended_money']) {
        await txn.delete(table);
        final rows = (data[table] as List?)?.cast<Map<String, dynamic>>() ?? [];
        for (final row in rows) {
          await txn.insert(table, Map<String, dynamic>.from(row),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
      }
    });
  }
}
