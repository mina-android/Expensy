// lib/database/db_helper.dart
import 'package:sqflite/sqflite.dart' hide Transaction;
import 'package:path/path.dart';
import '../models/models.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 2;

  static Future<Database> get database async {
    _db ??= await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'expensy_v2.db');
    return openDatabase(
      path,
      version: _version,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // Migration: v1 → v2 adds account_id to lended_money
  static Future<void> _onUpgrade(Database db, int oldV, int newV) async {
    if (oldV < 2) {
      await db.execute(
          'ALTER TABLE lended_money ADD COLUMN account_id TEXT');
    }
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE accounts (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        balance REAL NOT NULL DEFAULT 0,
        currency TEXT NOT NULL DEFAULT 'EGP',
        color_value INTEGER NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE categories (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        color_value INTEGER NOT NULL,
        is_default INTEGER NOT NULL DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions (
        id TEXT PRIMARY KEY,
        account_id TEXT NOT NULL,
        category_id TEXT NOT NULL,
        amount REAL NOT NULL,
        type TEXT NOT NULL,
        description TEXT NOT NULL,
        date TEXT NOT NULL,
        note TEXT NOT NULL DEFAULT ''
      )
    ''');

    await db.execute('''
      CREATE TABLE recurring_payments (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        account_id TEXT NOT NULL,
        category_id TEXT NOT NULL,
        amount REAL NOT NULL,
        freq_val INTEGER NOT NULL DEFAULT 1,
        freq_unit TEXT NOT NULL DEFAULT 'months',
        start_date TEXT NOT NULL,
        next_date TEXT NOT NULL,
        end_date TEXT,
        paid_payments INTEGER NOT NULL DEFAULT 0,
        reminder_enabled INTEGER NOT NULL DEFAULT 1,
        notes TEXT NOT NULL DEFAULT ''
      )
    ''');

    await db.execute('''
      CREATE TABLE wishlist (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        priority TEXT NOT NULL,
        notes TEXT NOT NULL DEFAULT '',
        is_purchased INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE lended_money (
        id TEXT PRIMARY KEY,
        person_name TEXT NOT NULL,
        amount REAL NOT NULL,
        type TEXT NOT NULL,
        account_id TEXT,
        date TEXT NOT NULL,
        due_date TEXT,
        notes TEXT NOT NULL DEFAULT '',
        is_settled INTEGER NOT NULL DEFAULT 0
      )
    ''');

    await _insertDefaultCategories(db);
  }

  static Future<void> _insertDefaultCategories(Database db) async {
    final defaults = [
      {'id': 'def_salary',      'name': 'Salary',        'type': 'income',  'color_value': 0xFF2E7D32, 'is_default': 1},
      {'id': 'def_freelance',   'name': 'Freelance',     'type': 'income',  'color_value': 0xFF1565C0, 'is_default': 1},
      {'id': 'def_investment',  'name': 'Investment',    'type': 'income',  'color_value': 0xFFF57F17, 'is_default': 1},
      {'id': 'def_other_in',   'name': 'Other Income',  'type': 'income',  'color_value': 0xFF00897B, 'is_default': 1},
      {'id': 'def_food',        'name': 'Food & Dining', 'type': 'expense', 'color_value': 0xFFE53935, 'is_default': 1},
      {'id': 'def_transport',   'name': 'Transport',     'type': 'expense', 'color_value': 0xFFFB8C00, 'is_default': 1},
      {'id': 'def_shopping',    'name': 'Shopping',      'type': 'expense', 'color_value': 0xFF8E24AA, 'is_default': 1},
      {'id': 'def_entertain',   'name': 'Entertainment', 'type': 'expense', 'color_value': 0xFF1E88E5, 'is_default': 1},
      {'id': 'def_bills',       'name': 'Bills',         'type': 'expense', 'color_value': 0xFF00897B, 'is_default': 1},
      {'id': 'def_health',      'name': 'Health',        'type': 'expense', 'color_value': 0xFF43A047, 'is_default': 1},
      {'id': 'def_rent',        'name': 'Rent',          'type': 'expense', 'color_value': 0xFF5D4037, 'is_default': 1},
      {'id': 'def_education',   'name': 'Education',     'type': 'expense', 'color_value': 0xFF0277BD, 'is_default': 1},
      {'id': 'def_other_ex',   'name': 'Other',         'type': 'expense', 'color_value': 0xFF546E7A, 'is_default': 1},
    ];
    for (final cat in defaults) {
      await db.insert('categories', cat);
    }
  }

  // ─── ACCOUNTS ─────────────────────────────────────────────────────────────
  static Future<List<Account>> getAccounts() async {
    final db = await database;
    final maps = await db.query('accounts', orderBy: 'created_at ASC');
    return maps.map(Account.fromMap).toList();
  }

  static Future<void> insertAccount(Account a) async {
    final db = await database;
    await db.insert('accounts', a.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> updateAccount(Account a) async {
    final db = await database;
    await db.update('accounts', a.toMap(),
        where: 'id = ?', whereArgs: [a.id]);
  }

  static Future<void> deleteAccount(String id) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('transactions', where: 'account_id = ?', whereArgs: [id]);
      await txn.delete('recurring_payments', where: 'account_id = ?', whereArgs: [id]);
      await txn.delete('accounts', where: 'id = ?', whereArgs: [id]);
    });
  }



  // ─── CATEGORIES ───────────────────────────────────────────────────────────
  static Future<List<Category>> getCategories() async {
    final db = await database;
    final maps = await db.query('categories', orderBy: 'is_default DESC, name ASC');
    return maps.map(Category.fromMap).toList();
  }

  static Future<void> insertCategory(Category c) async {
    final db = await database;
    await db.insert('categories', c.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> updateCategory(Category c) async {
    final db = await database;
    await db.update('categories', c.toMap(), where: 'id = ?', whereArgs: [c.id]);
  }

  static Future<void> deleteCategory(String id) async {
    final db = await database;
    await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  // ─── TRANSACTIONS ─────────────────────────────────────────────────────────
  static Future<List<Transaction>> getTransactions() async {
    final db = await database;
    final maps = await db.query('transactions', orderBy: 'date DESC');
    return maps.map(Transaction.fromMap).toList();
  }

  static Future<void> insertTransaction(Transaction t) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.insert('transactions', t.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      final delta = t.type == 'income' ? t.amount : -t.amount;
      await txn.rawUpdate(
          'UPDATE accounts SET balance = balance + ? WHERE id = ?',
          [delta, t.accountId]);
    });
  }

  static Future<void> updateTransaction(
      Transaction oldTx, Transaction newTx) async {
    final db = await database;
    await db.transaction((txn) async {
      // Reverse old transaction effect
      final oldDelta = oldTx.type == 'income' ? -oldTx.amount : oldTx.amount;
      await txn.rawUpdate(
          'UPDATE accounts SET balance = balance + ? WHERE id = ?',
          [oldDelta, oldTx.accountId]);

      // Apply new transaction effect
      final newDelta = newTx.type == 'income' ? newTx.amount : -newTx.amount;
      await txn.rawUpdate(
          'UPDATE accounts SET balance = balance + ? WHERE id = ?',
          [newDelta, newTx.accountId]);

      await txn.update('transactions', newTx.toMap(),
          where: 'id = ?', whereArgs: [newTx.id]);
    });
  }

  static Future<void> deleteTransaction(Transaction t) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('transactions', where: 'id = ?', whereArgs: [t.id]);
      final delta = t.type == 'income' ? -t.amount : t.amount;
      await txn.rawUpdate(
          'UPDATE accounts SET balance = balance + ? WHERE id = ?',
          [delta, t.accountId]);
    });
  }

  // ─── RECURRING PAYMENTS ───────────────────────────────────────────────────
  static Future<List<RecurringPayment>> getRecurringPayments() async {
    final db = await database;
    final maps = await db.query('recurring_payments', orderBy: 'name ASC');
    return maps.map(RecurringPayment.fromMap).toList();
  }

  static Future<void> insertRecurringPayment(RecurringPayment r) async {
    final db = await database;
    await db.insert('recurring_payments', r.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> updateRecurringPayment(RecurringPayment r) async {
    final db = await database;
    await db.update('recurring_payments', r.toMap(),
        where: 'id = ?', whereArgs: [r.id]);
  }

  static Future<void> deleteRecurringPayment(String id) async {
    final db = await database;
    await db.delete('recurring_payments', where: 'id = ?', whereArgs: [id]);
  }

  // ─── WISHLIST ─────────────────────────────────────────────────────────────
  static Future<List<WishlistItem>> getWishlistItems() async {
    final db = await database;
    final maps = await db.query('wishlist', orderBy: 'created_at DESC');
    return maps.map(WishlistItem.fromMap).toList();
  }

  static Future<void> insertWishlistItem(WishlistItem w) async {
    final db = await database;
    await db.insert('wishlist', w.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> updateWishlistItem(WishlistItem w) async {
    final db = await database;
    await db.update('wishlist', w.toMap(),
        where: 'id = ?', whereArgs: [w.id]);
  }

  static Future<void> deleteWishlistItem(String id) async {
    final db = await database;
    await db.delete('wishlist', where: 'id = ?', whereArgs: [id]);
  }

  // ─── LENDED MONEY ─────────────────────────────────────────────────────────
  static Future<List<LendedMoney>> getLendedItems() async {
    final db = await database;
    final maps = await db.query('lended_money', orderBy: 'date DESC');
    return maps.map(LendedMoney.fromMap).toList();
  }

  static Future<void> insertLendedItem(LendedMoney l) async {
    final db = await database;
    await db.insert('lended_money', l.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> updateLendedItem(LendedMoney l) async {
    final db = await database;
    await db.update('lended_money', l.toMap(),
        where: 'id = ?', whereArgs: [l.id]);
  }

  static Future<void> deleteLendedItem(String id) async {
    final db = await database;
    await db.delete('lended_money', where: 'id = ?', whereArgs: [id]);
  }

  // ─── BACKUP / RESTORE ─────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> exportAll() async {
    return {
      'version': _version,
      'exported_at': DateTime.now().toIso8601String(),
      'accounts': (await getAccounts()).map((a) => a.toMap()).toList(),
      'categories': (await getCategories()).map((c) => c.toMap()).toList(),
      'transactions': (await getTransactions()).map((t) => t.toMap()).toList(),
      'recurring_payments':
          (await getRecurringPayments()).map((r) => r.toMap()).toList(),
      'wishlist': (await getWishlistItems()).map((w) => w.toMap()).toList(),
      'lended_money': (await getLendedItems()).map((l) => l.toMap()).toList(),
    };
  }

  static Future<void> importAll(Map<String, dynamic> data) async {
    final db = await database;
    await db.transaction((txn) async {
      for (final table in [
        'transactions',
        'recurring_payments',
        'wishlist',
        'lended_money',
        'accounts',
        'categories',
      ]) {
        await txn.delete(table);
      }

      for (final m in (data['accounts'] as List<dynamic>? ?? [])) {
        await txn.insert('accounts', Map<String, dynamic>.from(m as Map));
      }
      for (final m in (data['categories'] as List<dynamic>? ?? [])) {
        await txn.insert('categories', Map<String, dynamic>.from(m as Map));
      }
      for (final m in (data['transactions'] as List<dynamic>? ?? [])) {
        await txn.insert('transactions', Map<String, dynamic>.from(m as Map));
      }
      for (final m in (data['recurring_payments'] as List<dynamic>? ?? [])) {
        await txn.insert(
            'recurring_payments', Map<String, dynamic>.from(m as Map));
      }
      for (final m in (data['wishlist'] as List<dynamic>? ?? [])) {
        await txn.insert('wishlist', Map<String, dynamic>.from(m as Map));
      }
      for (final m in (data['lended_money'] as List<dynamic>? ?? [])) {
        await txn.insert('lended_money', Map<String, dynamic>.from(m as Map));
      }
    });
  }
}
