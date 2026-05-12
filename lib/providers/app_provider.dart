// lib/providers/app_provider.dart
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' hide Border;
import '../models/models.dart';
import '../database/db_helper.dart';

class AppSettings {
  String currency;
  String themeSeed;
  String themeMode;   // system|light|dark|amoled
  String weekStart;   // monday|sunday
  bool   hideBalance;
  String userName;
  bool   onboarded;

  AppSettings({
    this.currency   = 'EGP',
    this.themeSeed  = 'violet',
    this.themeMode  = 'dark',
    this.weekStart  = 'monday',
    this.hideBalance = false,
    this.userName   = '',
    this.onboarded  = false,
  });

  Map<String, dynamic> toJson() => {
    'currency': currency, 'themeSeed': themeSeed, 'themeMode': themeMode,
    'weekStart': weekStart, 'hideBalance': hideBalance,
    'userName': userName, 'onboarded': onboarded,
  };

  static AppSettings fromJson(Map<String, dynamic> j) => AppSettings(
    currency:    (j['currency']    as String?) ?? 'EGP',
    themeSeed:   (j['themeSeed']   as String?) ?? 'violet',
    themeMode:   (j['themeMode']   as String?) ??
        ((j['darkMode'] as bool? ?? false) ? 'dark' : 'system'),
    weekStart:   (j['weekStart']   as String?) ?? 'monday',
    hideBalance: (j['hideBalance'] as bool?)   ?? false,
    userName:    (j['userName']    as String?) ?? '',
    onboarded:   (j['onboarded']   as bool?)   ?? false,
  );
}

class AppProvider extends ChangeNotifier {
  AppSettings settings = AppSettings();
  List<Account>          accounts   = [];
  List<AppCategory>      categories = [];
  List<AppTransaction>   transactions = [];
  List<RecurringPayment> recurring  = [];
  List<WishlistItem>     wishlist   = [];
  List<LendedMoney>      lended     = [];

  bool _loaded = false;
  bool get loaded => _loaded;

  final _uuid = const Uuid();
  String newId() => _uuid.v4();

  // ── Boot ─────────────────────────────────────────────────────────────
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('settings');
    if (raw != null) {
      settings = AppSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    }
    accounts     = await DBHelper.getAccounts();
    categories   = await DBHelper.getCategories();
    transactions = await DBHelper.getTransactions();
    recurring    = await DBHelper.getRecurring();
    wishlist     = await DBHelper.getWishlist();
    lended       = await DBHelper.getLended();
    _loaded = true;
    notifyListeners();
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('settings', jsonEncode(settings.toJson()));
    notifyListeners();
  }

  void updateSetting(String key, dynamic value) {
    switch (key) {
      case 'currency':    settings.currency    = value as String; break;
      case 'themeSeed':   settings.themeSeed   = value as String; break;
      case 'themeMode':   settings.themeMode   = value as String; break;
      case 'weekStart':   settings.weekStart   = value as String; break;
      case 'hideBalance': settings.hideBalance = value as bool;   break;
      case 'userName':    settings.userName    = value as String; break;
    }
    _saveSettings();
  }

  Future<void> completeOnboarding({
    required String name,
    required String currency,
  }) async {
    settings.userName  = name;
    settings.currency  = currency;
    settings.onboarded = true;
    await _saveSettings();
  }

  // ── Helpers ───────────────────────────────────────────────────────────
  /// Sum of non-excluded account balances (actual signed values).
  double get totalBalance => accounts
      .where((a) => !a.excludeFromTotal)
      .fold(0.0, (s, a) => s + a.balance.abs());

  Account?        accountById(String id)  =>
      accounts.where((a) => a.id == id).firstOrNull;
  AppCategory?    categoryById(String id) =>
      categories.where((c) => c.id == id).firstOrNull;

  // ── Accounts ─────────────────────────────────────────────────────────
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
    accounts     = await DBHelper.getAccounts();
    transactions = await DBHelper.getTransactions();
    notifyListeners();
  }

  Future<void> _updateAccountBalance(String id, double delta) async {
    final acc = accountById(id);
    if (acc == null) return;
    await DBHelper.updateAccount(acc.copyWith(balance: acc.balance + delta));
    accounts = await DBHelper.getAccounts();
  }

  // ── Categories ────────────────────────────────────────────────────────
  Future<void> addCategory(AppCategory c) async {
    await DBHelper.insertCategory(c);
    categories = await DBHelper.getCategories();
    notifyListeners();
  }

  Future<void> updateCategory(AppCategory c) async {
    await DBHelper.updateCategory(c);
    categories = await DBHelper.getCategories();
    notifyListeners();
  }

  Future<void> deleteCategory(String id) async {
    await DBHelper.deleteCategory(id);
    categories = await DBHelper.getCategories();
    notifyListeners();
  }

  // ── Transactions ──────────────────────────────────────────────────────
  Future<void> addTransaction(AppTransaction t) async {
    await DBHelper.insertTransaction(t);
    final delta = t.type == 'income' ? t.amount : -t.amount;
    await _updateAccountBalance(t.accountId, delta);
    transactions = await DBHelper.getTransactions();
    notifyListeners();
  }

  Future<void> updateTransaction(AppTransaction updated,
      AppTransaction original) async {
    // Reverse old balance effect
    final oldDelta = original.type == 'income' ? -original.amount : original.amount;
    await _updateAccountBalance(original.accountId, oldDelta);
    // Apply new balance effect
    final newDelta = updated.type == 'income' ? updated.amount : -updated.amount;
    await _updateAccountBalance(updated.accountId, newDelta);
    await DBHelper.updateTransaction(updated);
    transactions = await DBHelper.getTransactions();
    accounts     = await DBHelper.getAccounts();
    notifyListeners();
  }

  Future<void> deleteTransaction(String id) async {
    final t = transactions.where((x) => x.id == id).firstOrNull;
    if (t == null) return;
    final delta = t.type == 'income' ? -t.amount : t.amount;
    await _updateAccountBalance(t.accountId, delta);
    await DBHelper.deleteTransaction(id);
    transactions = await DBHelper.getTransactions();
    accounts     = await DBHelper.getAccounts();
    notifyListeners();
  }

  Future<void> addTransfer({
    required String fromId, required String toId, required double amount,
    String note = '',
  }) async {
    final now = DateTime.now();
    final catId = categories.where((c) => c.type == 'expense').isNotEmpty
        ? categories.firstWhere((c) => c.type == 'expense').id
        : '';
    // Debit from source
    final debit = AppTransaction(
      id: newId(), type: 'expense', amount: amount,
      description: 'Transfer out', accountId: fromId,
      categoryId: catId, date: now, note: note,
    );
    // Credit to destination
    final credit = AppTransaction(
      id: newId(), type: 'income', amount: amount,
      description: 'Transfer in', accountId: toId,
      categoryId: catId, date: now, note: note,
    );
    await DBHelper.insertTransaction(debit);
    await _updateAccountBalance(fromId, -amount);
    await DBHelper.insertTransaction(credit);
    await _updateAccountBalance(toId, amount);
    transactions = await DBHelper.getTransactions();
    accounts     = await DBHelper.getAccounts();
    notifyListeners();
  }

  // ── Recurring ─────────────────────────────────────────────────────────
  Future<void> addRecurring(RecurringPayment r) async {
    await DBHelper.insertRecurring(r);
    recurring = await DBHelper.getRecurring();
    notifyListeners();
  }

  Future<void> updateRecurring(RecurringPayment r) async {
    await DBHelper.updateRecurring(r);
    recurring = await DBHelper.getRecurring();
    notifyListeners();
  }

  Future<void> deleteRecurring(String id) async {
    await DBHelper.deleteRecurring(id);
    recurring = await DBHelper.getRecurring();
    notifyListeners();
  }

  Future<void> markRecurringPaid(RecurringPayment r) async {
    // Record transaction
    final t = AppTransaction(
      id: newId(), type: r.paymentType, amount: r.amount,
      description: '${r.name} (recurring)',
      accountId: r.accountId, categoryId: r.categoryId,
      date: DateTime.now(),
    );
    await addTransaction(t);
    // Advance next date and increment paid count
    final updated = RecurringPayment(
      id: r.id, name: r.name, accountId: r.accountId,
      categoryId: r.categoryId, amount: r.amount,
      paymentType: r.paymentType, freqVal: r.freqVal, freqUnit: r.freqUnit,
      startDate: r.startDate, nextDate: r.calcNextDate(),
      endDate: r.endDate, paidPayments: r.paidPayments + 1,
      reminderEnabled: r.reminderEnabled, notes: r.notes,
    );
    await DBHelper.updateRecurring(updated);
    recurring = await DBHelper.getRecurring();
    notifyListeners();
  }

  Future<void> skipNextRecurring(RecurringPayment r) async {
    // Advance date and increment paid count WITHOUT recording a transaction
    final updated = RecurringPayment(
      id: r.id, name: r.name, accountId: r.accountId,
      categoryId: r.categoryId, amount: r.amount,
      paymentType: r.paymentType, freqVal: r.freqVal, freqUnit: r.freqUnit,
      startDate: r.startDate, nextDate: r.calcNextDate(),
      endDate: r.endDate, paidPayments: r.paidPayments + 1,
      reminderEnabled: r.reminderEnabled, notes: r.notes,
    );
    await DBHelper.updateRecurring(updated);
    recurring = await DBHelper.getRecurring();
    notifyListeners();
  }

  // ── Wishlist ──────────────────────────────────────────────────────────
  Future<void> addWishlist(WishlistItem w) async {
    await DBHelper.insertWishlist(w);
    wishlist = await DBHelper.getWishlist();
    notifyListeners();
  }

  Future<void> updateWishlist(WishlistItem w) async {
    await DBHelper.updateWishlist(w);
    wishlist = await DBHelper.getWishlist();
    notifyListeners();
  }

  Future<void> deleteWishlist(String id) async {
    await DBHelper.deleteWishlist(id);
    wishlist = await DBHelper.getWishlist();
    notifyListeners();
  }

  // ── Lended Money ──────────────────────────────────────────────────────
  Future<void> addLended(LendedMoney l) async {
    await DBHelper.insertLended(l);
    if (l.accountId != null) {
      final delta = l.type == 'lent' ? -l.amount : l.amount;
      await _updateAccountBalance(l.accountId!, delta);
    }
    lended = await DBHelper.getLended();
    accounts = await DBHelper.getAccounts();
    notifyListeners();
  }

  Future<void> updateLended(LendedMoney updated, LendedMoney original) async {
    // Reverse original effect
    if (original.accountId != null && !original.isSettled) {
      final delta = original.type == 'lent' ? original.amount : -original.amount;
      await _updateAccountBalance(original.accountId!, delta);
    }
    // Apply new effect
    if (updated.accountId != null && !updated.isSettled) {
      final delta = updated.type == 'lent' ? -updated.amount : updated.amount;
      await _updateAccountBalance(updated.accountId!, delta);
    }
    await DBHelper.updateLended(updated);
    lended   = await DBHelper.getLended();
    accounts = await DBHelper.getAccounts();
    notifyListeners();
  }

  Future<void> settleLended(LendedMoney l) async {
    if (l.accountId != null) {
      // Reverse the balance effect
      final delta = l.type == 'lent' ? l.amount : -l.amount;
      await _updateAccountBalance(l.accountId!, delta);
    }
    final settled = l.copyWith(isSettled: true);
    await DBHelper.updateLended(settled);
    lended   = await DBHelper.getLended();
    accounts = await DBHelper.getAccounts();
    notifyListeners();
  }

  Future<void> deleteLended(String id) async {
    await DBHelper.deleteLended(id);
    lended = await DBHelper.getLended();
    notifyListeners();
  }

  // ── Export ────────────────────────────────────────────────────────────
  /// Export filtered transactions to .xlsx via file picker.
  /// Returns save path or null if cancelled.
  Future<String?> exportTransactionsExcel({
    required DateTime from, required DateTime to,
  }) async {
    final fromStart = DateTime(from.year, from.month, from.day);
    final toEnd     = DateTime(to.year, to.month, to.day, 23, 59, 59);
    final filtered  = transactions
        .where((t) => !t.date.isBefore(fromStart) && !t.date.isAfter(toEnd))
        .toList();
    if (filtered.isEmpty) throw Exception('No transactions in this date range');

    final excel = Excel.createExcel();
    final sheet = excel['Transactions'];
    try { excel.delete('Sheet1'); } catch (_) {}

    const headers = ['Date','Description','Type','Amount','Account','Category','Note'];
    for (int col = 0; col < headers.length; col++) {
      final cell = sheet.cell(
          CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0));
      cell.value = TextCellValue(headers[col]);
      cell.cellStyle = CellStyle(bold: true);
    }
    for (int i = 0; i < filtered.length; i++) {
      final t = filtered[i];
      final vals = [
        '${t.date.day}/${t.date.month}/${t.date.year}',
        t.description, t.type,
        t.amount.toStringAsFixed(2),
        accountById(t.accountId)?.name   ?? '',
        categoryById(t.categoryId)?.name ?? '',
        t.note,
      ];
      for (int col = 0; col < vals.length; col++) {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: i + 1))
            .value = TextCellValue(vals[col]);
      }
    }

    final bytes = excel.encode();
    if (bytes == null) throw Exception('Excel encoding failed');
    final uint8 = Uint8List.fromList(bytes);

    final fileName =
        'expensy_${from.year}-${from.month.toString().padLeft(2,'0')}'
        '_to_${to.year}-${to.month.toString().padLeft(2,'0')}.xlsx';

    final savePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save transactions as Excel',
      fileName: fileName,
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      bytes: uint8,
    );
    return savePath;
  }

  // ── Backup ────────────────────────────────────────────────────────────
  /// Returns save path or null if user cancelled.
  Future<String?> createBackup() async {
    final data = await DBHelper.exportAll();
    data['settings'] = settings.toJson();
    final json  = const JsonEncoder.withIndent('  ').convert(data);
    final uint8 = Uint8List.fromList(utf8.encode(json));
    final ts    = DateTime.now().millisecondsSinceEpoch;

    final savePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Expensy Backup',
      fileName: 'expensy_backup_$ts.json',
      type: FileType.custom,
      allowedExtensions: ['json'],
      bytes: uint8,
    );
    return savePath; // null if cancelled
  }

  Future<bool> restoreBackup() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) return false;

    final bytes = result.files.first.bytes;
    String jsonStr;
    if (bytes != null) {
      jsonStr = utf8.decode(bytes);
    } else {
      final path = result.files.first.path;
      if (path == null) return false;
      jsonStr = await File(path).readAsString();
    }

    final data = jsonDecode(jsonStr) as Map<String, dynamic>;
    await DBHelper.importAll(data);
    if (data['settings'] != null) {
      settings = AppSettings.fromJson(
          data['settings'] as Map<String, dynamic>);
      await _saveSettings();
    }
    await load();
    return true;
  }
}
