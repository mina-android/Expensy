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
import '../services/exchange_rate_service.dart';
import '../services/notification_service.dart';

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

  static const _validThemeModes = {'system', 'light', 'dark', 'amoled'};
  static const _validSeeds = {
    'violet','blue','green','rose','amber','teal','orange','indigo','cyan',
    'pink','lime','deep_purple','crimson','midnight','forest','mint','olive',
    'sage','sky','navy','cobalt','ocean','coral','gold','slate','magenta',
    'turquoise','brown','lavender',
  };

  static AppSettings fromJson(Map<String, dynamic> j) {
    // ── Seed colour migration ──────────────────────────────────────────
    String seed = (j['themeSeed'] as String?) ?? 'violet';
    bool   wasAmoled = seed == 'pitch_black';
    if (wasAmoled) seed = 'midnight';
    if (!_validSeeds.contains(seed)) seed = 'violet';

    // ── Theme mode migration ───────────────────────────────────────────
    String mode;
    if (j.containsKey('themeMode') && j['themeMode'] != null) {
      mode = j['themeMode'] as String;
      if (!_validThemeModes.contains(mode)) mode = 'dark';
    } else {
      mode = (j['darkMode'] as bool? ?? false) ? 'dark' : 'system';
    }
    if (wasAmoled) mode = 'amoled';

    return AppSettings(
      currency:    (j['currency']    as String?) ?? 'EGP',
      themeSeed:   seed,
      themeMode:   mode,
      weekStart:   (j['weekStart']   as String?) ?? 'monday',
      hideBalance: (j['hideBalance'] as bool?)   ?? false,
      userName:    (j['userName']    as String?) ?? '',
      onboarded:   (j['onboarded']   as bool?)   ?? false,
    );
  }
}

class AppProvider extends ChangeNotifier {
  AppSettings settings = AppSettings();
  List<Account>          accounts     = [];
  List<AppCategory>      categories   = [];
  List<AppTransaction>   transactions = [];
  List<RecurringPayment> recurring    = [];
  List<WishlistItem>     wishlist     = [];
  List<LendedMoney>      lended       = [];
  List<AssetItem>        assets       = [];

  // ── Exchange rates ────────────────────────────────────────────────────
  Map<String, double> exchangeRates = {};
  bool ratesLoaded    = false;
  bool ratesFetching  = false;
  DateTime? ratesLastFetched;

  final _erService = ExchangeRateService();
  final _notif     = NotificationService();

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
    assets       = await DBHelper.getAssets();
    _loaded = true;
    notifyListeners();

    _loadRates();
  }

  Future<void> _loadRates({bool forceNetwork = false}) async {
    ratesFetching = true;
    notifyListeners();

    Map<String, double> rates;
    if (forceNetwork) {
      rates = await _erService.forceRefresh() ?? exchangeRates;
    } else {
      rates = await _erService.getRates();
    }

    // open.er-api.com free tier does not return XAU.
    // If it's missing (first launch, old cache, or API gap), fetch gold
    // price synchronously now so the UI gets a complete rates map.
    final hasXau = rates.containsKey('XAU') && (rates['XAU'] ?? 0) > 0;
    if (!hasXau) {
      final xauRate = await _erService.fetchGoldRate();
      if (xauRate != null) {
        rates = Map.from(rates)..['XAU'] = xauRate;
        // Persist so the next cache hit already has XAU.
        await _erService.patchCachedXau(xauRate);
      }
    }

    exchangeRates    = rates;
    ratesLoaded      = true;
    ratesFetching    = false;
    ratesLastFetched = await _erService.lastFetchedAt();
    notifyListeners();

    // Recalculate gold account balances with the freshly loaded rates.
    await _refreshGoldBalances();
  }

  Future<void> refreshRates() => _loadRates(forceNetwork: true);

  /// Recomputes the balance of every gold account from current exchange rates
  /// and persists any changes. Does nothing when rates are unavailable.
  Future<void> _refreshGoldBalances() async {
    if (exchangeRates.isEmpty) return;
    // XAU must be present in the rates map (open.er-api.com includes it).
    if (!exchangeRates.containsKey('XAU')) return;

    bool changed = false;
    for (int i = 0; i < accounts.length; i++) {
      final acc = accounts[i];
      if (!acc.isGold) continue;
      final grams = acc.goldGrams;
      final karat = acc.goldKarat;
      if (grams == null || grams <= 0 || karat == null) continue;

      // Convert weight to troy ounces of pure gold, then to the account currency.
      // 1 troy oz = 31.1035 g; XAU = 1 troy oz of gold.
      final xauAmount = grams * (karat / 24) / 31.1035;
      final newBalance =
          _erService.convert(xauAmount, 'XAU', acc.currency, exchangeRates)
          ?? acc.balance;

      // Skip if the change is negligible (avoid unnecessary DB writes).
      if ((newBalance - acc.balance).abs() < 0.001) continue;

      final updated = acc.copyWith(balance: newBalance);
      await DBHelper.updateAccount(updated);
      accounts[i] = updated;
      changed = true;
    }
    if (changed) notifyListeners();
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

  double get totalBalance => accounts
      .where((a) => !a.excludeFromTotal)
      .fold(0.0, (sum, a) {
        final absBalance = a.balance.abs();
        if (exchangeRates.isEmpty || a.currency == settings.currency) {
          return sum + absBalance;
        }
        return sum +
            (_erService.convert(
                    absBalance, a.currency, settings.currency, exchangeRates) ??
                absBalance);
      });

  /// Sum of ALL accounts including those marked "exclude from total".
  /// Used by the Accounts tab so nothing is hidden there.
  double get totalBalanceAll => accounts
      .fold(0.0, (sum, a) {
        final absBalance = a.balance.abs();
        if (exchangeRates.isEmpty || a.currency == settings.currency) {
          return sum + absBalance;
        }
        return sum +
            (_erService.convert(
                    absBalance, a.currency, settings.currency, exchangeRates) ??
                absBalance);
      });

  double convertToMain(double amount, String fromCurrency) {
    if (fromCurrency == settings.currency || exchangeRates.isEmpty) {
      return amount;
    }
    return _erService.convert(
            amount, fromCurrency, settings.currency, exchangeRates) ??
        amount;
  }

  /// Convert [amount] between any two currencies using exchange rates.
  /// Returns null when rates are unavailable.
  double? convertBetween(double amount, String from, String to) {
    if (from == to) return amount;
    if (exchangeRates.isEmpty) return null;
    return _erService.convert(amount, from, to, exchangeRates);
  }

  bool canShowConverted(Account account) =>
      ratesLoaded &&
      exchangeRates.isNotEmpty &&
      account.currency != settings.currency &&
      exchangeRates.containsKey(account.currency) &&
      exchangeRates.containsKey(settings.currency);

  /// True once XAU is present in the loaded rates and gold value
  /// calculations will succeed.
  bool get goldRatesAvailable =>
      ratesLoaded &&
      exchangeRates.containsKey('XAU') &&
      (exchangeRates['XAU'] ?? 0) > 0;

  /// Returns the current gold price per gram (24k) in [currency],
  /// or null when XAU rates are not loaded.
  double? goldPricePerGram(String currency) {
    if (exchangeRates.isEmpty || !exchangeRates.containsKey('XAU')) return null;
    // 1 XAU = 1 troy oz = 31.1035 g of pure (24k) gold
    return _erService.convert(1 / 31.1035, 'XAU', currency, exchangeRates);
  }

  /// Computes the current market value for [grams] of gold at [karat] purity
  /// in [currency]. Returns null when rates are unavailable.
  double? computeGoldValue({
    required double grams,
    required int karat,
    required String currency,
  }) {
    if (exchangeRates.isEmpty || !exchangeRates.containsKey('XAU')) return null;
    final xauAmount = grams * (karat / 24) / 31.1035;
    return _erService.convert(xauAmount, 'XAU', currency, exchangeRates);
  }

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
    // Never manually update the balance of a gold account; it is always
    // derived from the gold price.  Silently skip any delta attempts.
    if (acc.isGold) return;
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

  double _txDelta(AppTransaction t, {bool reverse = false}) {
    final acc = accountById(t.accountId);
    final accCurrency = acc?.currency ?? settings.currency;
    final txCurrency = t.currency.isEmpty ? accCurrency : t.currency;

    double amount = t.amount;
    if (txCurrency != accCurrency && exchangeRates.isNotEmpty) {
      amount = _erService.convert(amount, txCurrency, accCurrency, exchangeRates)
          ?? amount;
    }
    final sign = t.type == 'income' ? 1.0 : -1.0;
    return (reverse ? -sign : sign) * amount;
  }

  Future<void> addTransaction(AppTransaction t) async {
    await DBHelper.insertTransaction(t);
    await _updateAccountBalance(t.accountId, _txDelta(t));
    transactions = await DBHelper.getTransactions();
    notifyListeners();
  }

  Future<void> updateTransaction(AppTransaction updated,
      AppTransaction original) async {
    await _updateAccountBalance(original.accountId, _txDelta(original, reverse: true));
    await _updateAccountBalance(updated.accountId, _txDelta(updated));
    await DBHelper.updateTransaction(updated);
    transactions = await DBHelper.getTransactions();
    accounts     = await DBHelper.getAccounts();
    notifyListeners();
  }

  Future<void> deleteTransaction(String id) async {
    final t = transactions.where((x) => x.id == id).firstOrNull;
    if (t == null) return;
    await _updateAccountBalance(t.accountId, _txDelta(t, reverse: true));
    await DBHelper.deleteTransaction(id);
    transactions = await DBHelper.getTransactions();
    accounts     = await DBHelper.getAccounts();
    notifyListeners();
  }

  Future<void> addTransfer({
    required String fromId,
    required String toId,
    required double fromAmount,
    double? toAmount,
    String note = '',
  }) async {
    final fromAcc = accountById(fromId);
    final toAcc   = accountById(toId);
    final fromCurrency = fromAcc?.currency ?? settings.currency;
    final toCurrency   = toAcc?.currency   ?? settings.currency;

    final double creditAmount;
    if (toAmount != null) {
      creditAmount = toAmount;
    } else if (fromCurrency == toCurrency) {
      creditAmount = fromAmount;
    } else {
      creditAmount = convertBetween(fromAmount, fromCurrency, toCurrency)
          ?? fromAmount;
    }

    final now = DateTime.now();
    final catId = categories.where((c) => c.type == 'expense').isNotEmpty
        ? categories.firstWhere((c) => c.type == 'expense').id
        : '';

    final debit = AppTransaction(
      id: newId(), type: 'expense', amount: fromAmount,
      description: 'Transfer out', accountId: fromId,
      categoryId: catId, date: now, note: note,
      currency: fromCurrency,
    );
    final credit = AppTransaction(
      id: newId(), type: 'income', amount: creditAmount,
      description: 'Transfer in', accountId: toId,
      categoryId: catId, date: now, note: note,
      currency: toCurrency,
    );
    await DBHelper.insertTransaction(debit);
    await _updateAccountBalance(fromId, -fromAmount);
    await DBHelper.insertTransaction(credit);
    await _updateAccountBalance(toId, creditAmount);
    transactions = await DBHelper.getTransactions();
    accounts     = await DBHelper.getAccounts();
    notifyListeners();
  }

  // ── Recurring ─────────────────────────────────────────────────────────
  Future<void> addRecurring(RecurringPayment r) async {
    await DBHelper.insertRecurring(r);
    recurring = await DBHelper.getRecurring();
    notifyListeners();
    if (r.reminderEnabled) {
      await _notif.scheduleReminder(r, settings.currency);
    }
  }

  Future<void> updateRecurring(RecurringPayment r) async {
    await _notif.cancelReminder(r.id);
    await DBHelper.updateRecurring(r);
    recurring = await DBHelper.getRecurring();
    notifyListeners();
    if (r.reminderEnabled) {
      await _notif.scheduleReminder(r, settings.currency);
    }
  }

  Future<void> deleteRecurring(String id) async {
    await _notif.cancelReminder(id);
    await DBHelper.deleteRecurring(id);
    recurring = await DBHelper.getRecurring();
    notifyListeners();
  }

  Future<void> markRecurringPaid(RecurringPayment r) async {
    final t = AppTransaction(
      id: newId(), type: r.paymentType, amount: r.amount,
      description: '${r.name} (recurring)',
      accountId: r.accountId, categoryId: r.categoryId,
      date: DateTime.now(),
    );
    await addTransaction(t);
    final updated = RecurringPayment(
      id: r.id, name: r.name, accountId: r.accountId,
      categoryId: r.categoryId, amount: r.amount,
      paymentType: r.paymentType, freqVal: r.freqVal, freqUnit: r.freqUnit,
      startDate: r.startDate, nextDate: r.calcNextDate(),
      endDate: r.endDate, paidPayments: r.paidPayments + 1,
      reminderEnabled: r.reminderEnabled,
      reminderTime: r.reminderTime,
      earlyReminderEnabled: r.earlyReminderEnabled,
      notes: r.notes,
    );
    await DBHelper.updateRecurring(updated);
    recurring = await DBHelper.getRecurring();
    notifyListeners();
    await _notif.cancelReminder(r.id);
    await _notif.scheduleReminder(updated, settings.currency);
  }

  Future<void> skipNextRecurring(RecurringPayment r) async {
    final updated = RecurringPayment(
      id: r.id, name: r.name, accountId: r.accountId,
      categoryId: r.categoryId, amount: r.amount,
      paymentType: r.paymentType, freqVal: r.freqVal, freqUnit: r.freqUnit,
      startDate: r.startDate, nextDate: r.calcNextDate(),
      endDate: r.endDate, paidPayments: r.paidPayments + 1,
      reminderEnabled: r.reminderEnabled,
      reminderTime: r.reminderTime,
      earlyReminderEnabled: r.earlyReminderEnabled,
      notes: r.notes,
    );
    await DBHelper.updateRecurring(updated);
    recurring = await DBHelper.getRecurring();
    notifyListeners();
    await _notif.cancelReminder(r.id);
    await _notif.scheduleReminder(updated, settings.currency);
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
    lended   = await DBHelper.getLended();
    accounts = await DBHelper.getAccounts();
    notifyListeners();
  }

  Future<void> updateLended(LendedMoney updated, LendedMoney original) async {
    if (original.accountId != null && !original.isSettled) {
      final delta = original.type == 'lent' ? original.amount : -original.amount;
      await _updateAccountBalance(original.accountId!, delta);
    }
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

  // ── Assets ────────────────────────────────────────────────────────────
  Future<void> addAsset(AssetItem a) async {
    await DBHelper.insertAsset(a);
    assets = await DBHelper.getAssets();
    notifyListeners();
  }

  Future<void> updateAsset(AssetItem a) async {
    await DBHelper.updateAsset(a);
    assets = await DBHelper.getAssets();
    notifyListeners();
  }

  Future<void> deleteAsset(String id) async {
    await DBHelper.deleteAsset(id);
    assets = await DBHelper.getAssets();
    notifyListeners();
  }

  double get totalAssetsValue => assets.fold(0.0, (sum, a) {
    if (exchangeRates.isEmpty || a.currency == settings.currency) {
      return sum + a.value;
    }
    return sum +
        (_erService.convert(a.value, a.currency, settings.currency, exchangeRates)
            ?? a.value);
  });

  // ── Export ────────────────────────────────────────────────────────────
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

    const headers = ['Date','Description','Type','Amount','Currency','Account','Category','Note'];
    for (int col = 0; col < headers.length; col++) {
      final cell = sheet.cell(
          CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0));
      cell.value = TextCellValue(headers[col]);
      cell.cellStyle = CellStyle(bold: true);
    }
    for (int i = 0; i < filtered.length; i++) {
      final t = filtered[i];
      final accCurrency = accountById(t.accountId)?.currency ?? '';
      final displayCurrency = t.currency.isEmpty ? accCurrency : t.currency;
      final vals = [
        '${t.date.day}/${t.date.month}/${t.date.year}',
        t.description, t.type,
        t.amount.toStringAsFixed(2),
        displayCurrency,
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
    return savePath;
  }

  Future<int> restoreBackup() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) return 0;

    final bytes = result.files.first.bytes;
    String jsonStr;
    if (bytes != null) {
      jsonStr = utf8.decode(bytes);
    } else {
      final path = result.files.first.path;
      if (path == null) return 0;
      jsonStr = await File(path).readAsString();
    }

    final dynamic decoded = jsonDecode(jsonStr);
    if (decoded is! Map) {
      throw const FormatException(
          'Invalid backup file: top-level value is not a JSON object.');
    }
    final data = Map<String, dynamic>.from(decoded);

    const knownKeys = {
      'accounts', 'categories', 'transactions', 'recurring_payments',
      'wishlist', 'lended_money', 'assets', 'version', 'settings',
    };
    if (!data.keys.any(knownKeys.contains)) {
      throw const FormatException(
          'Invalid backup file: no recognisable Expensy data found.');
    }

    await DBHelper.importAll(data);

    if (data['settings'] is Map) {
      settings = AppSettings.fromJson(
          Map<String, dynamic>.from(data['settings'] as Map));
      await _saveSettings();
    }

    await load();
    await _notif.rescheduleAll(recurring, settings.currency);

    return (data['_originalVersion'] as int?) ?? (data['version'] as int?) ?? 1;
  }
}
