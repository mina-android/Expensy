// lib/database/db_helper.dart
import 'package:sqflite/sqflite.dart' hide Transaction;
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'app_database.dart';
import '../models/models.dart';

class DBHelper {
  static Database? _db;
  static const String _dbName = 'expensy.db';
  static const int _version = 25;

  /// Public accessor for the current DB/backup schema version, so UI code
  /// (e.g. the Backup screen) never has to hardcode a copy that can drift
  /// out of sync with the real schema version.
  static int get schemaVersion => _version;

  static Future<Database> get database async {
    _db ??= await _open();
    return _db!;
  }

  static Future<Database> _open() async {
    final path = join(await getDatabasesPath(), _dbName);
    return openDatabase(path,
        version: _version, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  static Future<void> _onUpgrade(Database db, int oldV, int newV) async {
    if (oldV < 2) {
      try {
        await db.execute(
            'ALTER TABLE accounts ADD COLUMN exclude_from_total INTEGER NOT NULL DEFAULT 0');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db.execute(
            "ALTER TABLE recurring_payments ADD COLUMN payment_type TEXT NOT NULL DEFAULT 'expense'");
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    if (oldV < 3) {
      try {
        await db.execute(
            "ALTER TABLE recurring_payments ADD COLUMN reminder_time TEXT NOT NULL DEFAULT '09:00'");
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    if (oldV < 4) {
      try {
        await db.execute(
            "ALTER TABLE transactions ADD COLUMN currency TEXT NOT NULL DEFAULT ''");
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    if (oldV < 5) {
      try {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS assets (
            id TEXT PRIMARY KEY, name TEXT NOT NULL, value REAL NOT NULL,
            currency TEXT NOT NULL DEFAULT 'EGP',
            notes TEXT NOT NULL DEFAULT '', created_at TEXT NOT NULL
          )''');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    if (oldV < 6) {
      try {
        await db.execute('ALTER TABLE accounts ADD COLUMN gold_karat INTEGER');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db.execute('ALTER TABLE accounts ADD COLUMN gold_grams REAL');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    if (oldV < 7) {
      try {
        await db.execute(
            'ALTER TABLE recurring_payments ADD COLUMN early_reminder_enabled INTEGER NOT NULL DEFAULT 0');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
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
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
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
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db.execute(
            'CREATE INDEX IF NOT EXISTS idx_rh_recurring_id ON recurring_history(recurring_id)');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    // v8 → v9: category icon + lended_money reminders
    if (oldV < 9) {
      try {
        await db.execute(
            'ALTER TABLE categories ADD COLUMN icon_code_point INTEGER NOT NULL DEFAULT 0');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db.execute(
            'ALTER TABLE lended_money ADD COLUMN reminder_enabled INTEGER NOT NULL DEFAULT 0');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db.execute(
            "ALTER TABLE lended_money ADD COLUMN reminder_time TEXT NOT NULL DEFAULT '09:00'");
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
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
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db.execute('ALTER TABLE lended_money ADD COLUMN person_id TEXT');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      // Backfill: create one LendedPerson per distinct legacy person_name,
      // then point every lended_money row at the matching person_id.
      try {
        final rows = await db.rawQuery(
            'SELECT DISTINCT person_name FROM lended_money WHERE person_id IS NULL');
        final nameToId = <String, String>{};
        var colorIdx = 0;
        const palette = [
          0xFF6750A4,
          0xFF1565C0,
          0xFF2E7D32,
          0xFFC62828,
          0xFFE65100,
          0xFF00838F,
          0xFF6A1B9A,
          0xFF37474F,
          0xFFAD1457,
          0xFF827717,
        ];
        for (final row in rows) {
          final name = row['person_name'] as String?;
          if (name == null || name.trim().isEmpty) continue;
          if (nameToId.containsKey(name)) continue;
          final id =
              'legacy_${DateTime.now().microsecondsSinceEpoch}_$colorIdx';
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
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }

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
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }

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
        final hasPersonName = cols.any((c) => c['name'] == 'person_name');
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
            await txn
                .execute('ALTER TABLE lended_money_new RENAME TO lended_money');
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
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS savings_contributions (
            id TEXT PRIMARY KEY, goal_id TEXT NOT NULL, amount REAL NOT NULL,
            account_id TEXT NOT NULL, type TEXT NOT NULL, date TEXT NOT NULL,
            note TEXT NOT NULL DEFAULT ''
          )''');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    // v11 → v12: recurring subscriptions vs installments
    if (oldV < 12) {
      try {
        await db.execute(
            "ALTER TABLE recurring_payments ADD COLUMN recurring_type TEXT NOT NULL DEFAULT 'subscription'");
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    if (oldV < 13) {
      try {
        await db.execute('''
          CREATE TABLE net_worth_snapshots (
            id TEXT PRIMARY KEY,
            date TEXT NOT NULL,
            total_accounts REAL NOT NULL,
            total_assets REAL NOT NULL,
            net_worth REAL NOT NULL,
            currency TEXT NOT NULL
          )''');
        await db.execute(
            'CREATE UNIQUE INDEX idx_nws_date ON net_worth_snapshots(date)');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    if (oldV < 14) {
      try {
        await db
            .execute("ALTER TABLE accounts ADD COLUMN card_holder_name TEXT");
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db
            .execute("ALTER TABLE accounts ADD COLUMN card_number_last4 TEXT");
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db.execute("ALTER TABLE accounts ADD COLUMN card_expiry TEXT");
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db
            .execute("ALTER TABLE accounts ADD COLUMN statement_day INTEGER");
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db.execute("ALTER TABLE accounts ADD COLUMN due_day INTEGER");
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db.execute("ALTER TABLE accounts ADD COLUMN credit_limit REAL");
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db
            .execute("ALTER TABLE accounts ADD COLUMN min_payment_amount REAL");
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db.execute(
            "ALTER TABLE accounts ADD COLUMN min_payment_percent REAL");
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db.execute(
            "ALTER TABLE accounts ADD COLUMN credit_reminder_enabled INTEGER NOT NULL DEFAULT 0");
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db.execute(
            "ALTER TABLE accounts ADD COLUMN credit_reminder_time TEXT NOT NULL DEFAULT '09:00'");
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    if (oldV < 15) {
      try {
        await db.execute(
            "ALTER TABLE categories ADD COLUMN order_index INTEGER NOT NULL DEFAULT 0");
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    if (oldV < 16) {
      try {
        await db.execute(
            "ALTER TABLE accounts ADD COLUMN credit_early_reminder_enabled INTEGER NOT NULL DEFAULT 0");
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    if (oldV < 17) {
      try {
        await db
            .execute('ALTER TABLE accounts ADD COLUMN linked_account_id TEXT');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db.execute(
            'ALTER TABLE accounts ADD COLUMN order_index INTEGER DEFAULT 0');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    if (oldV < 18) {
      try {
        await db.execute(
            'ALTER TABLE accounts ADD COLUMN exclude_from_bank_total INTEGER NOT NULL DEFAULT 0');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    if (oldV < 19) {
      try {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS loans (
            id TEXT PRIMARY KEY, name TEXT NOT NULL, principal REAL NOT NULL,
            currency TEXT NOT NULL DEFAULT 'EGP',
            start_date TEXT NOT NULL, end_date TEXT NOT NULL,
            interest_rate REAL,
            account_id TEXT,
            reminder_enabled INTEGER NOT NULL DEFAULT 0,
            reminder_day INTEGER NOT NULL DEFAULT 1,
            reminder_time TEXT NOT NULL DEFAULT '09:00',
            is_settled INTEGER NOT NULL DEFAULT 0,
            notes TEXT NOT NULL DEFAULT '',
            created_at TEXT NOT NULL
          )''');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS loan_payments (
            id TEXT PRIMARY KEY,
            loan_id TEXT NOT NULL,
            date TEXT NOT NULL,
            amount REAL NOT NULL,
            currency TEXT NOT NULL,
            account_id TEXT,
            notes TEXT NOT NULL DEFAULT ''
          )''');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db.execute(
            'CREATE INDEX IF NOT EXISTS idx_lp_loan_id ON loan_payments(loan_id)');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    if (oldV < 20) {
      try {
        await db.execute(
            'ALTER TABLE loans ADD COLUMN transfer_account_id TEXT');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    if (oldV < 22) {
      try {
        await db.execute(
            'ALTER TABLE budgets ADD COLUMN allow_rollover INTEGER NOT NULL DEFAULT 0');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    if (oldV < 23) {
      try {
        await db.execute('ALTER TABLE wishlist ADD COLUMN goal_id TEXT');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db.execute(
            'ALTER TABLE savings_goals ADD COLUMN wishlist_item_id TEXT');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    if (oldV < 24) {
      try {
        await db.execute(
            'ALTER TABLE accounts ADD COLUMN dont_link_to_card INTEGER NOT NULL DEFAULT 0');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
    }
    if (oldV < 25) {
      try {
        await db.execute(
            'ALTER TABLE recurring_payments ADD COLUMN auto_pay_enabled INTEGER NOT NULL DEFAULT 0');
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
      try {
        await db.execute(
            "ALTER TABLE recurring_payments ADD COLUMN auto_pay_time TEXT NOT NULL DEFAULT '09:00'");
      } catch (e) {
        debugPrint('Migration v$oldV step error: $e');
      }
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
        gold_grams REAL,
        card_holder_name TEXT,
        card_number_last4 TEXT,
        card_expiry TEXT,
        statement_day INTEGER,
        due_day INTEGER,
        credit_limit REAL,
        min_payment_amount REAL,
        min_payment_percent REAL,
        credit_reminder_enabled INTEGER NOT NULL DEFAULT 0,
        credit_reminder_time TEXT DEFAULT '09:00',
        credit_early_reminder_enabled INTEGER DEFAULT 0,
        linked_account_id TEXT,
        order_index INTEGER DEFAULT 0,
        exclude_from_bank_total INTEGER NOT NULL DEFAULT 0,
        dont_link_to_card INTEGER NOT NULL DEFAULT 0
      )''');
    await db.execute('''
      CREATE TABLE categories (
        id TEXT PRIMARY KEY, name TEXT NOT NULL,
        type TEXT NOT NULL, color_value INTEGER NOT NULL,
        icon_code_point INTEGER NOT NULL DEFAULT 0,
        order_index INTEGER NOT NULL DEFAULT 0
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
        recurring_type TEXT NOT NULL DEFAULT 'subscription',
        auto_pay_enabled INTEGER NOT NULL DEFAULT 0,
        auto_pay_time TEXT NOT NULL DEFAULT '09:00'
      )''');
    await db.execute('''
      CREATE TABLE wishlist (
        id TEXT PRIMARY KEY, name TEXT NOT NULL, target_price REAL NOT NULL,
        priority TEXT NOT NULL, is_purchased INTEGER NOT NULL DEFAULT 0,
        notes TEXT NOT NULL DEFAULT '', created_at TEXT NOT NULL,
        goal_id TEXT
      )''');
    // LEGACY: orphaned table from pre-v5 schema. Not used by any live CRUD —
    // all asset operations target the 'assets' table (created in v5 migration).
    // Retained here because SQLite cannot safely DROP TABLE mid-migration-chain.
    await db.execute('''
      CREATE TABLE asset_items (
        id TEXT PRIMARY KEY, name TEXT NOT NULL, value REAL NOT NULL,
        color_value INTEGER NOT NULL, notes TEXT, created_at TEXT NOT NULL
      )''');
    await db.execute('''
      CREATE TABLE net_worth_snapshots (
        id TEXT PRIMARY KEY,
        date TEXT NOT NULL,
        total_accounts REAL NOT NULL,
        total_assets REAL NOT NULL,
        net_worth REAL NOT NULL,
        currency TEXT NOT NULL
      )''');
    await db.execute(
        'CREATE UNIQUE INDEX idx_nws_date ON net_worth_snapshots(date)');
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
        created_at TEXT NOT NULL,
        allow_rollover INTEGER NOT NULL DEFAULT 0
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
        created_at TEXT NOT NULL, completed_at TEXT,
        wishlist_item_id TEXT
      )''');
    await db.execute('''
      CREATE TABLE savings_contributions (
        id TEXT PRIMARY KEY, goal_id TEXT NOT NULL, amount REAL NOT NULL,
        account_id TEXT NOT NULL, type TEXT NOT NULL, date TEXT NOT NULL,
        note TEXT NOT NULL DEFAULT ''
      )''');
    await db.execute(
        'CREATE INDEX idx_rh_recurring_id ON recurring_history(recurring_id)');

    await db.execute('''
      CREATE TABLE loans (
        id TEXT PRIMARY KEY, name TEXT NOT NULL, principal REAL NOT NULL,
        currency TEXT NOT NULL DEFAULT 'EGP',
        start_date TEXT NOT NULL, end_date TEXT NOT NULL,
        interest_rate REAL,
        account_id TEXT,
        transfer_account_id TEXT,
        reminder_enabled INTEGER NOT NULL DEFAULT 0,
        reminder_day INTEGER NOT NULL DEFAULT 1,
        reminder_time TEXT NOT NULL DEFAULT '09:00',
        is_settled INTEGER NOT NULL DEFAULT 0,
        notes TEXT NOT NULL DEFAULT '',
        created_at TEXT NOT NULL
      )''');
    await db.execute('''
      CREATE TABLE loan_payments (
        id TEXT PRIMARY KEY,
        loan_id TEXT NOT NULL,
        date TEXT NOT NULL,
        amount REAL NOT NULL,
        currency TEXT NOT NULL,
        account_id TEXT,
        notes TEXT NOT NULL DEFAULT ''
      )''');
    await db.execute(
        'CREATE INDEX idx_lp_loan_id ON loan_payments(loan_id)');

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
        'id': c.$1,
        'name': c.$2,
        'type': c.$3,
        'color_value': c.$4,
      });
    }
  }

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
