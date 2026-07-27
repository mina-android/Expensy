// lib/database/db_helper.dart
import 'package:sqflite/sqflite.dart' hide Transaction;
import 'package:path/path.dart';
import '../models/models.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 12;

  /// Public accessor for the current DB/backup schema version, so UI code
  /// (e.g. the Backup screen) never has to hardcode a copy that can drift
  /// out of sync with the real schema version.
  static int get schemaVersion => _version;


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
    // v9 → v10: lended money becomes account-based (per-person ledger)
    if (oldV < 10) {
      try {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS lended_people (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            color_value INTEGER NOT NULL,
            notes TEXT NOT NULL DEFAULT '',
            created_at TEXT NOT NULL
          )''');
      } catch (_) {}
      try {
        await db.execute('ALTER TABLE lended_money ADD COLUMN person_id TEXT');
      } catch (_) {}
      // Backfill: create one LendedPerson per distinct legacy person_name,
      // then point every lended_money row at the matching person_id.
      try {
        final rows = await db.rawQuery(
            'SELECT DISTINCT person_name FROM lended_money WHERE person_id IS NULL');
        final nameToId = <String, String>{};
        var colorIdx = 0;
        const palette = [
          0xFF6750A4, 0xFF1565C0, 0xFF2E7D32, 0xFFC62828, 0xFFE65100,
          0xFF00838F, 0xFF6A1B9A, 0xFF37474F, 0xFFAD1457, 0xFF827717,
        ];
        for (final row in rows) {
          final name = row['person_name'] as String?;
          if (name == null || name.trim().isEmpty) continue;
          if (nameToId.containsKey(name)) continue;
          final id = 'legacy_${DateTime.now().microsecondsSinceEpoch}_$colorIdx';
          nameToId[name] = id;
          await db.insert('lended_people', {
            'id': id,
            'name': name,
            'color_value': palette[colorIdx % palette.length],
            'notes': '',
            'created_at': DateTime.now().toIso8601String(),
          });
          colorIdx++;
        }
        for (final entry in nameToId.entries) {
          await db.update('lended_money', {'person_id': entry.value},
              where: 'person_name = ? AND person_id IS NULL',
              whereArgs: [entry.key]);
        }
      } catch (_) {}

      // Catch-all: any row that still has no person_id (e.g. a null/blank
      // legacy person_name) gets bucketed into a single "Unknown" person
      // instead of being silently dropped by the table rebuild below.
      try {
        final orphans = await db.rawQuery(
            'SELECT COUNT(*) AS c FROM lended_money WHERE person_id IS NULL');
        final orphanCount = (orphans.first['c'] as int?) ?? 0;
        if (orphanCount > 0) {
          final unknownId =
              'legacy_unknown_${DateTime.now().microsecondsSinceEpoch}';
          await db.insert('lended_people', {
            'id': unknownId,
            'name': 'Unknown',
            'color_value': 0xFF757575,
            'notes': '',
            'created_at': DateTime.now().toIso8601String(),
          });
          await db.update('lended_money', {'person_id': unknownId},
              where: 'person_id IS NULL');
        }
      } catch (_) {}

      // The upgraded `lended_money` table still physically carries the old
      // `person_name TEXT NOT NULL` column (SQLite can't drop a NOT NULL
      // constraint via ALTER TABLE). LendedMoney.toMap() no longer writes
      // person_name at all, so every new insert on an upgraded DB was
      // failing the NOT NULL check and throwing silently — "Add Record"
      // looked like it did nothing. Rebuild the table to match the fresh-
      // install schema exactly (no person_name column) and copy rows over.
      //
      // Run as one transaction so a failure partway through (e.g. device
      // killed mid-migration) can't leave the DB with `lended_money` dropped
      // but `lended_money_new` not yet renamed — either the whole rebuild
      // commits, or none of it does and the original table survives intact
      // for the next launch to retry.
      try {
        final cols = await db.rawQuery('PRAGMA table_info(lended_money)');
        final hasPersonName =
            cols.any((c) => c['name'] == 'person_name');
        if (hasPersonName) {
          await db.transaction((txn) async {
            await txn.execute('''
              CREATE TABLE lended_money_new (
                id TEXT PRIMARY KEY, person_id TEXT NOT NULL, amount REAL NOT NULL,
                type TEXT NOT NULL, account_id TEXT, is_settled INTEGER NOT NULL DEFAULT 0,
                date TEXT NOT NULL, due_date TEXT, notes TEXT NOT NULL DEFAULT '',
                reminder_enabled INTEGER NOT NULL DEFAULT 0,
                reminder_time TEXT NOT NULL DEFAULT '09:00'
              )''');
            await txn.execute('''
              INSERT INTO lended_money_new
                (id, person_id, amount, type, account_id, is_settled, date,
                 due_date, notes, reminder_enabled, reminder_time)
              SELECT id, person_id, amount, type, account_id, is_settled, date,
                     due_date, notes, reminder_enabled, reminder_time
              FROM lended_money
              WHERE person_id IS NOT NULL
            ''');
            await txn.execute('DROP TABLE lended_money');
            await txn.execute(
                'ALTER TABLE lended_money_new RENAME TO lended_money');
          });
        }
      } catch (e) {
        // If this ever fails, the old person_name-carrying table survives
        // untouched (transaction rolled back) and inserts will keep failing
        // until it's retried on a future launch. Surface it loudly in debug
        // builds instead of failing completely silently.
        // ignore: avoid_print
        // ignore: avoid_print
        print('Expensy DB migration warning: lended_money rebuild failed: $e');
      }
    }
    // v10 → v11: savings goals and contributions
    if (oldV < 11) {
      try {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS savings_goals (
            id TEXT PRIMARY KEY, name TEXT NOT NULL, target_amount REAL NOT NULL,
            current_amount REAL NOT NULL DEFAULT 0, currency TEXT NOT NULL,
            target_date TEXT, color_value INTEGER NOT NULL,
            is_completed INTEGER NOT NULL DEFAULT 0,
            created_at TEXT NOT NULL, completed_at TEXT
          )''');
      } catch (_) {}
      try {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS savings_contributions (
            id TEXT PRIMARY KEY, goal_id TEXT NOT NULL, amount REAL NOT NULL,
            account_id TEXT NOT NULL, type TEXT NOT NULL, date TEXT NOT NULL,
            note TEXT NOT NULL DEFAULT ''
          )''');
      } catch (_) {}
    }
    // v11 → v12: recurring subscriptions vs installments
    if (oldV < 12) {
      try { await db.execute("ALTER TABLE recurring_payments ADD COLUMN recurring_type TEXT NOT NULL DEFAULT 'subscription'"); } catch (_) {}
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
        notes TEXT NOT NULL DEFAULT '',
        recurring_type TEXT NOT NULL DEFAULT 'subscription'
      )''');
    await db.execute('''
      CREATE TABLE wishlist (
        id TEXT PRIMARY KEY, name TEXT NOT NULL, target_price REAL NOT NULL,
        priority TEXT NOT NULL, is_purchased INTEGER NOT NULL DEFAULT 0,
        notes TEXT NOT NULL DEFAULT '', created_at TEXT NOT NULL
      )''');
    await db.execute('''
      CREATE TABLE lended_people (
        id TEXT PRIMARY KEY, name TEXT NOT NULL,
        color_value INTEGER NOT NULL,
        notes TEXT NOT NULL DEFAULT '', created_at TEXT NOT NULL
      )''');
    await db.execute('''
      CREATE TABLE lended_money (
        id TEXT PRIMARY KEY, person_id TEXT NOT NULL, amount REAL NOT NULL,
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
    await db.execute('''
      CREATE TABLE savings_goals (
        id TEXT PRIMARY KEY, name TEXT NOT NULL, target_amount REAL NOT NULL,
        current_amount REAL NOT NULL DEFAULT 0, currency TEXT NOT NULL,
        target_date TEXT, color_value INTEGER NOT NULL,
        is_completed INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL, completed_at TEXT
      )''');
    await db.execute('''
      CREATE TABLE savings_contributions (
        id TEXT PRIMARY KEY, goal_id TEXT NOT NULL, amount REAL NOT NULL,
        account_id TEXT NOT NULL, type TEXT NOT NULL, date TEXT NOT NULL,
        note TEXT NOT NULL DEFAULT ''
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

  // ── Lended People ────────────────────────────────────────────────────
  static Future<List<LendedPerson>> getLendedPeople() async {
    final db = await database;
    final rows = await db.query('lended_people', orderBy: 'created_at ASC');
    return rows.map(LendedPerson.fromMap).toList();
  }
  static Future<void> insertLendedPerson(LendedPerson p) async =>
      (await database).insert('lended_people', p.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
  static Future<void> updateLendedPerson(LendedPerson p) async =>
      (await database).update('lended_people', p.toMap(), where: 'id=?', whereArgs: [p.id]);
  static Future<void> deleteLendedPerson(String id) async =>
      (await database).delete('lended_people', where: 'id=?', whereArgs: [id]);

  // ── Lended Money (per-person ledger entries) ────────────────────────────
  static Future<List<LendedMoney>> getLended() async {
    final db = await database;
    final rows = await db.query('lended_money', orderBy: 'date DESC');
    return rows.map(LendedMoney.fromMap).toList();
  }
  static Future<List<LendedMoney>> getLendedForPerson(String personId) async {
    final db = await database;
    final rows = await db.query('lended_money',
        where: 'person_id = ?', whereArgs: [personId], orderBy: 'date DESC');
    return rows.map(LendedMoney.fromMap).toList();
  }
  static Future<void> insertLended(LendedMoney l) async =>
      (await database).insert('lended_money', l.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
  static Future<void> updateLended(LendedMoney l) async =>
      (await database).update('lended_money', l.toMap(), where: 'id=?', whereArgs: [l.id]);
  static Future<void> deleteLended(String id) async =>
      (await database).delete('lended_money', where: 'id=?', whereArgs: [id]);
  static Future<void> deleteLendedForPerson(String personId) async =>
      (await database).delete('lended_money', where: 'person_id=?', whereArgs: [personId]);

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

  // ── Savings Goals ──────────────────────────────────────────────────────────
  static Future<List<SavingsGoal>> getSavingsGoals() async {
    final db = await database;
    final rows = await db.query('savings_goals', orderBy: 'created_at ASC');
    return rows.map(SavingsGoal.fromMap).toList();
  }
  static Future<int> getSavingsGoalsCount() async {
    final db = await database;
    final rows = await db.rawQuery('SELECT COUNT(*) AS c FROM savings_goals');
    return (rows.first['c'] as int?) ?? 0;
  }
  static Future<void> insertSavingsGoal(SavingsGoal g) async =>
      (await database).insert('savings_goals', g.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
  static Future<void> updateSavingsGoal(SavingsGoal g) async =>
      (await database).update('savings_goals', g.toMap(), where: 'id=?', whereArgs: [g.id]);
  static Future<void> deleteSavingsGoal(String id) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('savings_contributions', where: 'goal_id=?', whereArgs: [id]);
      await txn.delete('savings_goals', where: 'id=?', whereArgs: [id]);
    });
  }

  // ── Savings Contributions ─────────────────────────────────────────────────
  static Future<List<SavingsContribution>> getSavingsContributionsFor(String goalId) async {
    final db = await database;
    final rows = await db.query('savings_contributions',
        where: 'goal_id = ?', whereArgs: [goalId], orderBy: 'date DESC');
    return rows.map(SavingsContribution.fromMap).toList();
  }
  static Future<List<SavingsContribution>> getAllSavingsContributions() async {
    final db = await database;
    final rows = await db.query('savings_contributions', orderBy: 'date DESC');
    return rows.map(SavingsContribution.fromMap).toList();
  }
  static Future<int> getSavingsContributionsCount() async {
    final db = await database;
    final rows = await db.rawQuery('SELECT COUNT(*) AS c FROM savings_contributions');
    return (rows.first['c'] as int?) ?? 0;
  }
  static Future<void> insertSavingsContribution(SavingsContribution c) async =>
      (await database).insert('savings_contributions', c.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);

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

  /// Lightweight total row count for `recurring_history` — used by the
  /// Backup screen's "what's included" list so it can show an accurate
  /// number without loading every history row into memory.
  static Future<int> getRecurringHistoryCount() async {
    final db = await database;
    final rows =
        await db.rawQuery('SELECT COUNT(*) AS c FROM recurring_history');
    return (rows.first['c'] as int?) ?? 0;
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
      'lended_people':       await db.query('lended_people'),
      'lended_money':        await db.query('lended_money'),
      'assets':              await db.query('assets'),
      'budgets':             await db.query('budgets'),
      'recurring_history':   await db.query('recurring_history'),
      'savings_goals':       await db.query('savings_goals'),
      'savings_contributions': await db.query('savings_contributions'),
      'version':             _version,
    };
  }

  static Future<void> importAll(Map<String, dynamic> data) async {
    final db = await database;
    _normaliseBackup(data);

    await db.transaction((txn) async {
      for (final table in [
        'accounts', 'categories', 'transactions',
        'recurring_payments', 'wishlist', 'lended_people', 'lended_money',
        'assets', 'budgets', 'recurring_history',
        'savings_goals', 'savings_contributions',
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

    // v9 → v10: lended money becomes account-based (per-person ledger).
    // Old backups have `person_name` on each lended_money row and no
    // `lended_people` table at all. Synthesize a LendedPerson per distinct
    // name and rewrite each row to carry `person_id` instead.
    data.putIfAbsent('lended_people', () => <dynamic>[]);
    final peopleRows = _rows(data, 'lended_people');
    final lendedRows = _rows(data, 'lended_money');
    final needsBackfill = lendedRows.isNotEmpty &&
        lendedRows.any((r) => r['person_id'] == null);
    if (needsBackfill) {
      final nameToId = <String, String>{};
      for (final p in peopleRows) {
        final nm = p['name'] as String?;
        final id = p['id'] as String?;
        if (nm != null && id != null) nameToId[nm] = id;
      }
      const palette = [
        0xFF6750A4, 0xFF1565C0, 0xFF2E7D32, 0xFFC62828, 0xFFE65100,
        0xFF00838F, 0xFF6A1B9A, 0xFF37474F, 0xFFAD1457, 0xFF827717,
      ];
      var colorIdx = peopleRows.length;
      var seq = 0;
      for (final row in lendedRows) {
        if (row['person_id'] != null) continue;
        final name = (row['person_name'] as String?)?.trim();
        final key = (name == null || name.isEmpty) ? 'Unknown' : name;
        var id = nameToId[key];
        if (id == null) {
          id = 'restored_${DateTime.now().microsecondsSinceEpoch}_${seq++}';
          nameToId[key] = id;
          peopleRows.add({
            'id': id,
            'name': key,
            'color_value': palette[colorIdx % palette.length],
            'notes': '',
            'created_at': DateTime.now().toIso8601String(),
          });
          colorIdx++;
        }
        row['person_id'] = id;
      }
      data['lended_people'] = peopleRows;
      data['lended_money'] = lendedRows;
    }
    // The legacy `person_name` key (if present) must never reach the raw
    // `txn.insert()` in importAll() — the live `lended_money` table (v10+)
    // has no such column, and sqflite would throw "no such column:
    // person_name" for every restored row, aborting the whole restore.
    for (final row in _rows(data, 'lended_money')) {
      row.remove('person_name');
    }
    for (final row in _rows(data, 'lended_people')) {
      row.putIfAbsent('color_value', () => 0xFF6750A4);
      row.putIfAbsent('notes', () => '');
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

    // v11: savings goals and contributions
    data.putIfAbsent('savings_goals', () => <dynamic>[]);
    for (final row in _rows(data, 'savings_goals')) {
      row.putIfAbsent('is_completed', () => 0);
      row.putIfAbsent('current_amount', () => 0.0);
    }
    data.putIfAbsent('savings_contributions', () => <dynamic>[]);
    for (final row in _rows(data, 'savings_contributions')) {
      row.putIfAbsent('note', () => '');
      row.putIfAbsent('type', () => 'contribution');
    }

    data['_originalVersion'] = backupVersion;
    if (data['settings'] is Map) {
      final settings = data['settings'] as Map;
      settings.putIfAbsent('languageCode', () => 'system');
    }
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
