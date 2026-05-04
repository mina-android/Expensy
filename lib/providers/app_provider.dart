// lib/providers/app_provider.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' hide Category;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import '../database/db_helper.dart';
import '../models/models.dart';

class AppSettings {
  String currency;
  String themeSeed;
  bool darkMode;
  String weekStart;
  bool hideBalance;
  String userName;
  bool onboarded;

  AppSettings({
    this.currency    = 'EGP',
    this.themeSeed   = 'violet',
    this.darkMode    = false,
    this.weekStart   = 'monday',
    this.hideBalance = false,
    this.userName    = '',
    this.onboarded   = false,
  });

  Map<String, dynamic> toJson() => {
        'currency':    currency,
        'themeSeed':   themeSeed,
        'darkMode':    darkMode,
        'weekStart':   weekStart,
        'hideBalance': hideBalance,
        'userName':    userName,
        'onboarded':   onboarded,
      };

  factory AppSettings.fromJson(Map<String, dynamic> j) => AppSettings(
        currency:    (j['currency']    as String?) ?? 'EGP',
        themeSeed:   (j['themeSeed']   as String?) ?? 'violet',
        darkMode:    (j['darkMode']    as bool?)   ?? false,
        weekStart:   (j['weekStart']   as String?) ?? 'monday',
        hideBalance: (j['hideBalance'] as bool?)   ?? false,
        userName:    (j['userName']    as String?) ?? '',
        onboarded:   (j['onboarded']   as bool?)   ?? false,
      );
}

class AppProvider extends ChangeNotifier {
  final _uuid = const Uuid();

  AppSettings settings = AppSettings();
  List<Account>          accounts     = [];
  List<Category>         categories   = [];
  List<Transaction>      transactions = [];
  List<RecurringPayment> recurring    = [];
  List<WishlistItem>     wishlist     = [];
  List<LendedMoney>      lended       = [];
  bool isLoading = true;

  // ── Init ──────────────────────────────────────────────────────────────────
  Future<void> init() async {
    isLoading = true;
    notifyListeners();
    try {
      await _loadSettings();
      await _loadAll();
    } catch (e) {
      debugPrint('AppProvider init error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('app_settings');
    if (raw != null) {
      try {
        settings = AppSettings.fromJson(
            jsonDecode(raw) as Map<String, dynamic>);
      } catch (_) {
        settings = AppSettings();
      }
    }
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_settings', jsonEncode(settings.toJson()));
  }

  Future<void> _loadAll() async {
    accounts     = await DBHelper.getAccounts();
    categories   = await DBHelper.getCategories();
    transactions = (await DBHelper.getTransactions()).cast<Transaction>();
    recurring    = await DBHelper.getRecurringPayments();
    wishlist     = await DBHelper.getWishlistItems();
    lended       = await DBHelper.getLendedItems();
  }

  // ── Onboarding ────────────────────────────────────────────────────────────
  Future<void> completeOnboarding({
    required String name,
    required String currency,
  }) async {
    settings.userName  = name;
    settings.currency  = currency;
    settings.onboarded = true;
    await _saveSettings();
    await _loadAll();
    notifyListeners();
  }

  // ── Settings ──────────────────────────────────────────────────────────────
  Future<void> updateSetting(String key, dynamic value) async {
    switch (key) {
      case 'currency':    settings.currency    = value as String; break;
      case 'themeSeed':   settings.themeSeed   = value as String; break;
      case 'darkMode':    settings.darkMode    = value as bool;   break;
      case 'weekStart':   settings.weekStart   = value as String; break;
      case 'hideBalance': settings.hideBalance = value as bool;   break;
      case 'userName':    settings.userName    = value as String; break;
    }
    await _saveSettings();
    notifyListeners();
  }

  // ── Computed ──────────────────────────────────────────────────────────────
  double get totalBalance => accounts.fold(0.0, (s, a) => s + a.balance);

  double get monthIncome {
    final now = DateTime.now();
    return transactions
        .where((t) => t.type == 'income' &&
            t.date.month == now.month && t.date.year == now.year)
        .fold(0.0, (s, t) => s + t.amount);
  }

  double get monthExpense {
    final now = DateTime.now();
    return transactions
        .where((t) => t.type == 'expense' &&
            t.date.month == now.month && t.date.year == now.year)
        .fold(0.0, (s, t) => s + t.amount);
  }

  Category? categoryById(String id) {
    for (final c in categories) { if (c.id == id) return c; }
    return null;
  }

  Account? accountById(String id) {
    for (final a in accounts) { if (a.id == id) return a; }
    return null;
  }

  // ── Accounts ──────────────────────────────────────────────────────────────
  Future<void> addAccount(Account a) async {
    await DBHelper.insertAccount(a);
    accounts = await DBHelper.getAccounts();
    notifyListeners();
  }

  Future<void> updateAccount(Account a) async {
    await DBHelper.updateAccount(a);
    accounts = await DBHelper.getAccounts();
    notifyListeners();
  }

  Future<void> deleteAccount(String id) async {
    await DBHelper.deleteAccount(id);
    await _loadAll();
    notifyListeners();
  }

  Future<void> transferBetweenAccounts({
    required String fromId,
    required String toId,
    required double amount,
    String note = '',
  }) async {
    final fromAcc = accountById(fromId);
    final toAcc   = accountById(toId);
    if (fromAcc == null || toAcc == null || fromId == toId) return;
    if (amount <= 0 || amount > fromAcc.balance) return;

    Category? expCat;
    Category? incCat;
    for (final c in categories) {
      if (c.type == 'expense' && expCat == null) expCat = c;
      if (c.type == 'income'  && incCat == null) incCat = c;
      if (expCat != null && incCat != null) break;
    }
    if (expCat == null || incCat == null) return;

    final now = DateTime.now();
    await DBHelper.insertTransaction(Transaction(
      id: _uuid.v4(), accountId: fromId, categoryId: expCat.id,
      amount: amount, type: 'expense',
      description: 'Transfer to ${toAcc.name}', date: now, note: note,
    ));
    await DBHelper.insertTransaction(Transaction(
      id: _uuid.v4(), accountId: toId, categoryId: incCat.id,
      amount: amount, type: 'income',
      description: 'Transfer from ${fromAcc.name}', date: now, note: note,
    ));
    await _loadAll();
    notifyListeners();
  }

  // ── Categories ────────────────────────────────────────────────────────────
  Future<void> addCategory(Category c) async {
    await DBHelper.insertCategory(c);
    categories = await DBHelper.getCategories();
    notifyListeners();
  }

  Future<void> updateCategory(Category c) async {
    await DBHelper.updateCategory(c);
    final idx = categories.indexWhere((x) => x.id == c.id);
    if (idx >= 0) categories[idx] = c;
    notifyListeners();
  }

  Future<void> deleteCategory(String id) async {
    await DBHelper.deleteCategory(id);
    categories = await DBHelper.getCategories();
    notifyListeners();
  }

  // ── Transactions ──────────────────────────────────────────────────────────
  Future<void> addTransaction(Transaction t) async {
    await DBHelper.insertTransaction(t);
    await _loadAll();
    notifyListeners();
  }

  Future<void> updateTransaction(Transaction oldTx, Transaction newTx) async {
    await DBHelper.updateTransaction(oldTx, newTx);
    await _loadAll();
    notifyListeners();
  }

  Future<void> deleteTransaction(Transaction t) async {
    await DBHelper.deleteTransaction(t);
    await _loadAll();
    notifyListeners();
  }

  // ── Recurring ─────────────────────────────────────────────────────────────
  Future<void> addRecurring(RecurringPayment r) async {
    await DBHelper.insertRecurringPayment(r);
    recurring = await DBHelper.getRecurringPayments();
    notifyListeners();
  }

  Future<void> updateRecurring(RecurringPayment r) async {
    await DBHelper.updateRecurringPayment(r);
    final idx = recurring.indexWhere((x) => x.id == r.id);
    if (idx >= 0) recurring[idx] = r;
    notifyListeners();
  }

  Future<void> markRecurringPaid(RecurringPayment r) async {
    final updated = RecurringPayment(
      id: r.id, name: r.name, accountId: r.accountId,
      categoryId: r.categoryId, amount: r.amount,
      freqVal: r.freqVal, freqUnit: r.freqUnit,
      startDate: r.startDate, nextDate: r.calcNextDate(),
      endDate: r.endDate, paidPayments: r.paidPayments + 1,
      reminderEnabled: r.reminderEnabled, notes: r.notes,
    );
    await DBHelper.updateRecurringPayment(updated);
    await DBHelper.insertTransaction(Transaction(
      id: _uuid.v4(), accountId: r.accountId, categoryId: r.categoryId,
      amount: r.amount, type: 'expense',
      description: '${r.name} (recurring)', date: DateTime.now(),
    ));
    await _loadAll();
    notifyListeners();
  }

  Future<void> skipNextRecurring(RecurringPayment r) async {
    final updated = RecurringPayment(
      id: r.id, name: r.name, accountId: r.accountId,
      categoryId: r.categoryId, amount: r.amount,
      freqVal: r.freqVal, freqUnit: r.freqUnit,
      startDate: r.startDate, nextDate: r.calcNextDate(),
      endDate: r.endDate, paidPayments: r.paidPayments,
      reminderEnabled: r.reminderEnabled, notes: r.notes,
    );
    await DBHelper.updateRecurringPayment(updated);
    recurring = await DBHelper.getRecurringPayments();
    notifyListeners();
  }

  Future<void> deleteRecurring(String id) async {
    await DBHelper.deleteRecurringPayment(id);
    recurring = await DBHelper.getRecurringPayments();
    notifyListeners();
  }

  // ── Wishlist ──────────────────────────────────────────────────────────────
  Future<void> addWishlistItem(WishlistItem w) async {
    await DBHelper.insertWishlistItem(w);
    wishlist = await DBHelper.getWishlistItems();
    notifyListeners();
  }

  Future<void> updateWishlistItemFull(WishlistItem w) async {
    await DBHelper.updateWishlistItem(w);
    final idx = wishlist.indexWhere((x) => x.id == w.id);
    if (idx >= 0) wishlist[idx] = w;
    notifyListeners();
  }

  Future<void> toggleWishlistPurchased(String id) async {
    final idx = wishlist.indexWhere((w) => w.id == id);
    if (idx < 0) return;
    final updated = wishlist[idx].copyWith(
        isPurchased: !wishlist[idx].isPurchased);
    await DBHelper.updateWishlistItem(updated);
    wishlist[idx] = updated;
    notifyListeners();
  }

  Future<void> deleteWishlistItem(String id) async {
    await DBHelper.deleteWishlistItem(id);
    wishlist = await DBHelper.getWishlistItems();
    notifyListeners();
  }

  // ── Lended ────────────────────────────────────────────────────────────────
  Future<void> addLendedItem(LendedMoney l) async {
    await DBHelper.insertLendedItem(l);
    lended = await DBHelper.getLendedItems();
    if (l.accountId != null) {
      final acc = accountById(l.accountId!);
      if (acc != null) {
        final delta = l.type == 'lent' ? -l.amount : l.amount;
        final updated = acc.copyWith(balance: acc.balance + delta);
        await DBHelper.updateAccount(updated);
        final idx = accounts.indexWhere((a) => a.id == acc.id);
        if (idx >= 0) accounts[idx] = updated;
      }
    }
    notifyListeners();
  }

  Future<void> settleLendedItem(String id) async {
    final idx = lended.indexWhere((l) => l.id == id);
    if (idx < 0) return;
    final old = lended[idx];
    if (old.accountId != null) {
      final acc = accountById(old.accountId!);
      if (acc != null) {
        final delta = old.type == 'lent' ? old.amount : -old.amount;
        final updated = acc.copyWith(balance: acc.balance + delta);
        await DBHelper.updateAccount(updated);
        final accIdx = accounts.indexWhere((a) => a.id == acc.id);
        if (accIdx >= 0) accounts[accIdx] = updated;
      }
    }
    final settled = old.copyWith(isSettled: true);
    await DBHelper.updateLendedItem(settled);
    lended[idx] = settled;
    notifyListeners();
  }

  Future<void> updateLendedItemFull(
      LendedMoney updated, LendedMoney original) async {
    if (original.accountId != null && !original.isSettled) {
      final acc = accountById(original.accountId!);
      if (acc != null) {
        final reversal =
            original.type == 'lent' ? original.amount : -original.amount;
        final reverted = acc.copyWith(balance: acc.balance + reversal);
        await DBHelper.updateAccount(reverted);
        final idx = accounts.indexWhere((a) => a.id == acc.id);
        if (idx >= 0) accounts[idx] = reverted;
      }
    }
    if (updated.accountId != null && !updated.isSettled) {
      final acc = accountById(updated.accountId!);
      if (acc != null) {
        final delta =
            updated.type == 'lent' ? -updated.amount : updated.amount;
        final newAcc = acc.copyWith(balance: acc.balance + delta);
        await DBHelper.updateAccount(newAcc);
        final idx = accounts.indexWhere((a) => a.id == acc.id);
        if (idx >= 0) accounts[idx] = newAcc;
      }
    }
    await DBHelper.updateLendedItem(updated);
    lended = await DBHelper.getLendedItems();
    notifyListeners();
  }

  Future<void> deleteLendedItem(String id) async {
    await DBHelper.deleteLendedItem(id);
    lended = await DBHelper.getLendedItems();
    notifyListeners();
  }

  // ── Export ────────────────────────────────────────────────────────────────
  Future<void> exportTransactionsCSV() async {
    final rows = <List<dynamic>>[
      ['Date', 'Description', 'Type', 'Amount', 'Account', 'Category', 'Note'],
    ];
    for (final t in transactions) {
      rows.add([
        '${t.date.day}/${t.date.month}/${t.date.year}',
        t.description, t.type, t.amount.toStringAsFixed(2),
        accountById(t.accountId)?.name  ?? '',
        categoryById(t.categoryId)?.name ?? '',
        t.note,
      ]);
    }
    final csv  = ListToCsvConverter().convert(rows);
    final dir  = await getTemporaryDirectory();
    final file = File('${dir.path}/expensy_export.csv');
    await file.writeAsString(csv);
    await Share.shareXFiles(
        [XFile(file.path)], text: 'Expensy Transactions Export');
  }

  // ── Backup / Restore ──────────────────────────────────────────────────────
  Future<void> createBackup() async {
    final data = await DBHelper.exportAll();
    data['settings'] = settings.toJson();
    final dir  = await getTemporaryDirectory();
    final ts   = DateTime.now().millisecondsSinceEpoch;
    final file = File('${dir.path}/expensy_backup_$ts.json');
    await file.writeAsString(
        const JsonEncoder.withIndent('  ').convert(data));
    await Share.shareXFiles([XFile(file.path)], text: 'Expensy Backup');
  }

  Future<bool> restoreBackup() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    if (result == null || result.files.single.path == null) return false;
    final content = await File(result.files.single.path!).readAsString();
    final data    = jsonDecode(content) as Map<String, dynamic>;
    await DBHelper.importAll(data);
    if (data['settings'] != null) {
      settings = AppSettings.fromJson(
          data['settings'] as Map<String, dynamic>);
      await _saveSettings();
    }
    await _loadAll();
    notifyListeners();
    return true;
  }

  String newId() => _uuid.v4();
}
