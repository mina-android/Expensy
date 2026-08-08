// lib/providers/app_provider.dart
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' hide Border;
import '../models/models.dart';
import '../database/db_helper.dart';
import '../services/exchange_rate_service.dart';
import '../services/notification_service.dart';
import '../services/lended_notification_service.dart';
import '../services/budget_notification_service.dart';
import '../services/daily_reminder_service.dart';

class AppSettings {
  String currency;
  String themeSeed;
  String themeMode;   // system|light|dark  ('amoled' is migrated on load)
  String weekStart;   // monday|sunday
  bool   hideBalance;
  String userName;
  bool   onboarded;
  String appFont;     // key into kFonts; 'default' = system/Roboto
  bool   amoledSurfaces;
  bool   dynamicColorEnabled; // pure-black surfaces when dark — decoupled from themeMode
  String languageCode; // 'system'|'en'|'ar'|'fr'|'de'|'hi'
  bool   budgetAlertsEnabled;
  bool   dailyReminderEnabled;
  String dailyReminderTime;
  bool   hapticsEnabled;
  List<String> pinnedWidgetAccountIds;

  AppSettings({
    this.currency      = 'EGP',
    this.themeSeed     = 'violet',
    this.themeMode     = 'dark',
    this.weekStart     = 'monday',
    this.hideBalance   = false,
    this.userName      = '',
    this.onboarded     = false,
    this.appFont       = 'default',
    this.amoledSurfaces = false,
    this.dynamicColorEnabled = false,
    this.languageCode  = 'system',
    this.budgetAlertsEnabled = true,
    this.dailyReminderEnabled = false,
    this.dailyReminderTime = '22:00',
    this.hapticsEnabled = true,
    this.pinnedWidgetAccountIds = const [],
  });

  Map<String, dynamic> toJson() => {
    'currency': currency, 'themeSeed': themeSeed, 'themeMode': themeMode,
    'weekStart': weekStart, 'hideBalance': hideBalance,
    'userName': userName, 'onboarded': onboarded,
    'appFont': appFont, 'amoledSurfaces': amoledSurfaces, 'dynamicColorEnabled': dynamicColorEnabled,
    'languageCode': languageCode,
    'budgetAlertsEnabled': budgetAlertsEnabled,
    'dailyReminderEnabled': dailyReminderEnabled,
    'dailyReminderTime': dailyReminderTime,
    'hapticsEnabled': hapticsEnabled,
    'pinnedWidgetAccountIds': pinnedWidgetAccountIds,
  };

  static const _validThemeModes = {'system', 'light', 'dark'};
  // 'amoled' is legacy — migrated to themeMode:'dark' + amoledSurfaces:true
  static const _validSeeds = {
    'violet','blue','green','rose','amber','teal','orange','indigo','cyan',
    'pink','lime','deep_purple','crimson','midnight','forest','mint','olive',
    'sage','sky','navy','cobalt','ocean','coral','gold','slate','magenta',
    'turquoise','brown','lavender',
  };
  static const _validFonts = {
    'default','plus_jakarta_sans','dm_sans','inter','nunito_sans',
    'space_grotesk','outfit','sora','poppins','nunito',
  };
  static const _validLanguages = {'system', 'en', 'ar', 'fr', 'de', 'hi'};

  static AppSettings fromJson(Map<String, dynamic> j) {
    String seed = (j['themeSeed'] as String?) ?? 'violet';
    bool   wasAmoled = seed == 'pitch_black';
    if (wasAmoled) seed = 'midnight';
    if (!_validSeeds.contains(seed)) seed = 'violet';

    String mode;
    bool   legacyAmoled = false;
    if (j.containsKey('themeMode') && j['themeMode'] != null) {
      mode = j['themeMode'] as String;
      // Migrate legacy 'amoled' themeMode → 'dark' + amoledSurfaces:true
      if (mode == 'amoled') { mode = 'dark'; legacyAmoled = true; }
      else if (!_validThemeModes.contains(mode)) mode = 'dark';
    } else {
      mode = (j['darkMode'] as bool? ?? false) ? 'dark' : 'system';
    }
    if (wasAmoled) mode = 'dark';

    // amoledSurfaces: prefer stored value; fall back to any legacy amoled flag.
    final amoled = (j['amoledSurfaces'] as bool?) ?? (wasAmoled || legacyAmoled);

    String font = (j['appFont'] as String?) ?? 'default';
    if (!_validFonts.contains(font)) font = 'default';

    String lang = (j['languageCode'] as String?) ?? 'system';
    if (!_validLanguages.contains(lang)) lang = 'system';

    return AppSettings(
      currency:       (j['currency']    as String?) ?? 'EGP',
      themeSeed:      seed,
      themeMode:      mode,
      weekStart:      (j['weekStart']   as String?) ?? 'monday',
      hideBalance:    (j['hideBalance'] as bool?)   ?? false,
      userName:       (j['userName']    as String?) ?? '',
      onboarded:      (j['onboarded']   as bool?)   ?? false,
      appFont:        font,
      amoledSurfaces: amoled,
      dynamicColorEnabled: (j['dynamicColorEnabled'] as bool?) ?? false,
      languageCode:   lang,
      budgetAlertsEnabled: (j['budgetAlertsEnabled'] as bool?) ?? true,
      dailyReminderEnabled: (j['dailyReminderEnabled'] as bool?) ?? false,
      dailyReminderTime: (j['dailyReminderTime'] as String?) ?? '22:00',
      hapticsEnabled: (j['hapticsEnabled'] as bool?) ?? true,
      pinnedWidgetAccountIds: (j['pinnedWidgetAccountIds'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}

class AppProvider extends ChangeNotifier {
  AppSettings settings = AppSettings();
  List<Account>               accounts     = [];
  List<AppCategory>           categories   = [];
  List<AppTransaction>        transactions = [];
  List<RecurringPayment>      recurring    = [];
  List<WishlistItem>          wishlist     = [];
  List<LendedPerson>          lendedPeople = [];
  List<LendedMoney>           lended       = [];
  List<AssetItem>             assets       = [];
  List<Budget>                budgets      = [];
  List<SavingsGoal>           savingsGoals = [];
  List<SavingsContribution>   savingsContributions = [];
  List<NetWorthSnapshot>      netWorthSnapshots = [];

  /// Total row count in `recurring_history` — kept for display purposes
  /// (e.g. the Backup screen's "what's included" list) without needing to
  /// load every history row for every recurring payment into memory.
  int recurringHistoryCount = 0;

  // ── Exchange rates ────────────────────────────────────────────────────
  Map<String, double> exchangeRates = {};
  bool ratesLoaded    = false;
  bool ratesFetching  = false;
  DateTime? ratesLastFetched;

  // ── Recurring history (lazy cache) ────────────────────────────────────
  final Map<String, List<RecurringHistoryEntry>> _historyCache = {};

  final _erService = ExchangeRateService();
  final _notif       = NotificationService();
  final _lendedNotif = LendedNotificationService();
  final _budgetNotif = BudgetNotificationService();
  final _dailyNotif  = DailyReminderService();

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
    lendedPeople = await DBHelper.getLendedPeople();
    lended       = await DBHelper.getLended();
    assets       = await DBHelper.getAssets();
    budgets      = await DBHelper.getBudgets();
    savingsGoals = await DBHelper.getSavingsGoals();
    savingsContributions = await DBHelper.getAllSavingsContributions();
    netWorthSnapshots = await DBHelper.getNetWorthSnapshots();
    recurringHistoryCount = await DBHelper.getRecurringHistoryCount();
    _loaded = true;
    notifyListeners();

    _lendedNotif.rescheduleAllLended(lended, settings.currency);
    _notif.rescheduleAll(recurring, settings.currency);
    if (settings.dailyReminderEnabled) {
      await _dailyNotif.scheduleDailyReminder(settings.dailyReminderTime);
    } else {
      await _dailyNotif.cancelDailyReminder();
    }

    _loadRates();
  }

  Future<void> _loadRates({bool forceNetwork = false}) async {
    ratesFetching = true;
    notifyListeners();

    if (forceNetwork) {
      // Full blocking refresh — fetch main rates + gold, then update UI once.
      final fresh = await _erService.forceRefresh();
      Map<String, double> rates = fresh ?? exchangeRates;
      final hasXau = rates.containsKey('XAU') && (rates['XAU'] ?? 0) > 0;
      if (!hasXau) {
        final xauRate = await _erService.fetchGoldRate();
        if (xauRate != null) {
          rates = Map.from(rates)..['XAU'] = xauRate;
          await _erService.patchCachedXau(xauRate);
        }
      }
      exchangeRates    = rates;
      ratesLoaded      = true;
      ratesFetching    = false;
      ratesLastFetched = await _erService.lastFetchedAt();
      notifyListeners();
      await _refreshGoldBalances();
    } else {
      // 1. Serve cached rates immediately so the UI is not blocked.
      final cached = await _erService.getCached();
      if (cached != null && cached.isNotEmpty) {
        var rates = cached;
        final hasXauCached = rates.containsKey('XAU') && (rates['XAU'] ?? 0) > 0;
        if (!hasXauCached) {
          final xauRate = await _erService.fetchGoldRate();
          if (xauRate != null) {
            rates = Map.from(rates)..['XAU'] = xauRate;
            await _erService.patchCachedXau(xauRate);
          }
        }
        exchangeRates    = rates;
        ratesLoaded      = true;
        ratesFetching    = false;
        ratesLastFetched = await _erService.lastFetchedAt();
        notifyListeners();
        await _refreshGoldBalances();
      }

      // 2. If cache is stale (or empty), fetch fresh in the background and
      //    update the provider when done — this is what was missing before.
      final isStale = !(await _erService.isFresh());
      if (isStale) {
        // Re-set fetching flag so UI shows spinner during background fetch.
        ratesFetching = true;
        notifyListeners();
        final fresh = await _erService.forceRefresh();
        if (fresh != null && fresh.isNotEmpty) {
          var rates = fresh;
          final hasXau = rates.containsKey('XAU') && (rates['XAU'] ?? 0) > 0;
          if (!hasXau) {
            final xauRate = await _erService.fetchGoldRate();
            if (xauRate != null) {
              rates = Map.from(rates)..['XAU'] = xauRate;
              await _erService.patchCachedXau(xauRate);
            }
          }
          exchangeRates    = rates;
          ratesLoaded      = true;
          ratesLastFetched = await _erService.lastFetchedAt();
        }
        ratesFetching = false;
        notifyListeners();
        await _refreshGoldBalances();
      }
    }
  }

  Future<void> refreshRates() => _loadRates(forceNetwork: true);

  Future<void> _refreshGoldBalances() async {
    if (exchangeRates.isEmpty) return;
    if (!exchangeRates.containsKey('XAU')) return;

    bool changed = false;
    for (int i = 0; i < accounts.length; i++) {
      final acc = accounts[i];
      if (!acc.isGold) continue;
      final grams = acc.goldGrams;
      final karat = acc.goldKarat;
      if (grams == null || grams <= 0 || karat == null) continue;

      final xauAmount = grams * (karat / 24) / 31.1035;
      final newBalance =
          _erService.convert(xauAmount, 'XAU', acc.currency, exchangeRates)
          ?? acc.balance;

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

  void updateSetting(String key, dynamic value) async {
    final oldDailyEnabled = settings.dailyReminderEnabled;
    final oldDailyTime = settings.dailyReminderTime;
    final oldLang = settings.languageCode;

    switch (key) {
      case 'currency':       settings.currency       = value as String; break;
      case 'themeSeed':      settings.themeSeed      = value as String; break;
      case 'themeMode':      settings.themeMode      = value as String; break;
      case 'weekStart':      settings.weekStart      = value as String; break;
      case 'hideBalance':    settings.hideBalance    = value as bool;   break;
      case 'userName':       settings.userName       = value as String; break;
      case 'appFont':        settings.appFont        = value as String; break;
      case 'amoledSurfaces': settings.amoledSurfaces = value as bool;  break;
      case 'dynamicColorEnabled': settings.dynamicColorEnabled = value as bool;  break;
      case 'languageCode':   settings.languageCode   = value as String; break;
      case 'budgetAlertsEnabled':  settings.budgetAlertsEnabled  = value as bool;   break;
      case 'dailyReminderEnabled': settings.dailyReminderEnabled = value as bool;   break;
      case 'dailyReminderTime':    settings.dailyReminderTime    = value as String; break;
      case 'hapticsEnabled': settings.hapticsEnabled = value as bool;   break;
      case 'pinnedWidgetAccountIds': settings.pinnedWidgetAccountIds = value as List<String>; break;
    }

    _saveSettings();
    notifyListeners();

    if (oldLang != settings.languageCode) {
      // Handled in main by restarting or notifying.
    }

    if (oldDailyEnabled != settings.dailyReminderEnabled || oldDailyTime != settings.dailyReminderTime) {
      if (settings.dailyReminderEnabled) {
        await _dailyNotif.scheduleDailyReminder(settings.dailyReminderTime);
      } else {
        await _dailyNotif.cancelDailyReminder();
      }
    }
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

  bool get goldRatesAvailable =>
      ratesLoaded &&
      exchangeRates.containsKey('XAU') &&
      (exchangeRates['XAU'] ?? 0) > 0;

  double? goldPricePerGram(String currency) {
    if (exchangeRates.isEmpty || !exchangeRates.containsKey('XAU')) return null;
    return _erService.convert(1 / 31.1035, 'XAU', currency, exchangeRates);
  }

  double? computeGoldValue({
    required double grams,
    required int karat,
    required String currency,
  }) {
    if (exchangeRates.isEmpty || !exchangeRates.containsKey('XAU')) return null;
    final xauAmount = grams * (karat / 24) / 31.1035;
    return _erService.convert(xauAmount, 'XAU', currency, exchangeRates);
  }

  Account?     accountById(String id)  =>
      accounts.where((a) => a.id == id).firstOrNull;
  AppCategory? categoryById(String id) =>
      categories.where((c) => c.id == id).firstOrNull;
  LendedPerson? personById(String id) =>
      lendedPeople.where((p) => p.id == id).firstOrNull;

  // ── Accounts ─────────────────────────────────────────────────────────
  bool toggleWidgetPin(String id) {
    final pins = List<String>.from(settings.pinnedWidgetAccountIds);
    if (pins.contains(id)) {
      pins.remove(id);
    } else {
      if (pins.length >= 3) return false;
      pins.add(id);
    }
    updateSetting('pinnedWidgetAccountIds', pins);
    return true;
  }

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

  Future<VoidCallback> deleteAccountWithUndo(String id) async {
    final a = accounts.firstWhere((acc) => acc.id == id);
    await deleteAccount(id);
    return () async {
      await addAccount(a);
    };
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
    await _checkBudgetAlert(t);
  }

  Future<void> updateTransaction(AppTransaction updated,
      AppTransaction original) async {
    await _updateAccountBalance(original.accountId, _txDelta(original, reverse: true));
    await _updateAccountBalance(updated.accountId, _txDelta(updated));
    await DBHelper.updateTransaction(updated);
    transactions = await DBHelper.getTransactions();
    accounts     = await DBHelper.getAccounts();
    notifyListeners();
    await _checkBudgetAlert(updated);
  }

  Future<void> _checkBudgetAlert(AppTransaction t) async {
    if (!settings.budgetAlertsEnabled) return;
    if (t.type != 'expense') return;
    final b = budgetForCategory(t.categoryId);
    if (b == null) return;
    if (budgetExceeded(b)) {
      final cat = categoryById(t.categoryId);
      if (cat != null) {
        await _budgetNotif.showBudgetExceeded(b, cat, budgetSpent(b));
      }
    }
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
    await DBHelper.deleteRecurringHistoryFor(id);
    _historyCache.remove(id);
    recurring = await DBHelper.getRecurring();
    recurringHistoryCount = await DBHelper.getRecurringHistoryCount();
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
    await _recordHistory(r, 'paid');

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
    await _recordHistory(r, 'skipped');

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

  // ── Recurring History ─────────────────────────────────────────────────

  Future<void> _recordHistory(RecurringPayment r, String action) async {
    final acct = accountById(r.accountId);
    final entry = RecurringHistoryEntry(
      id: newId(),
      recurringId: r.id,
      action: action,
      date: DateTime.now(),
      amount: r.amount,
      currency: acct?.currency ?? settings.currency,
    );
    await DBHelper.insertRecurringHistory(entry);
    _historyCache.remove(r.id); // invalidate cache for this payment
    recurringHistoryCount = await DBHelper.getRecurringHistoryCount();
  }

  /// Loads history for [recurringId] from DB, caching in memory.
  /// Returns immediately if already cached.
  Future<List<RecurringHistoryEntry>> getHistoryFor(String recurringId) async {
    if (_historyCache.containsKey(recurringId)) {
      return _historyCache[recurringId]!;
    }
    final entries = await DBHelper.getRecurringHistory(recurringId);
    _historyCache[recurringId] = entries;
    return entries;
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

  // ── Lended People (per-person ledger "accounts") ────────────────────────
  Future<void> addLendedPerson(LendedPerson p) async {
    await DBHelper.insertLendedPerson(p);
    lendedPeople = await DBHelper.getLendedPeople();
    notifyListeners();
  }

  Future<void> updateLendedPerson(LendedPerson p) async {
    await DBHelper.updateLendedPerson(p);
    lendedPeople = await DBHelper.getLendedPeople();
    notifyListeners();
  }

  /// Deletes a person along with every lended-money entry that belongs to
  /// them, cancelling any pending reminders first.
  Future<void> deleteLendedPerson(String id) async {
    for (final l in lended.where((l) => l.personId == id)) {
      await _lendedNotif.cancelLendedReminder(l.id);
    }
    await DBHelper.deleteLendedForPerson(id);
    await DBHelper.deleteLendedPerson(id);
    lended       = await DBHelper.getLended();
    lendedPeople = await DBHelper.getLendedPeople();
    notifyListeners();
  }

  /// All ledger entries belonging to [personId], most recent first.
  List<LendedMoney> lendedFor(String personId) =>
      lended.where((l) => l.personId == personId).toList()
        ..sort((a, b) => b.date.compareTo(a.date));

  /// Net balance for a person: positive = they owe the user money,
  /// negative = the user owes them. Only unsettled entries count, mirroring
  /// how an [Account.balance] only reflects committed state.
  double personBalance(String personId) => lended
      .where((l) => l.personId == personId && !l.isSettled)
      .fold(0.0, (sum, l) => sum + (l.type == 'lent' ? l.amount : -l.amount));

  bool personHasOverdue(String personId) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return lended.any((l) =>
        l.personId == personId &&
        !l.isSettled &&
        l.dueDate != null &&
        l.dueDate!.isBefore(today));
  }

  // ── Lended Money (ledger entries) ───────────────────────────────────────
  Future<void> addLended(LendedMoney l) async {
    await DBHelper.insertLended(l);
    if (l.accountId != null) {
      final delta = l.type == 'lent' ? -l.amount : l.amount;
      await _updateAccountBalance(l.accountId!, delta);
    }
    lended   = await DBHelper.getLended();
    accounts = await DBHelper.getAccounts();
    notifyListeners();
    if (l.reminderEnabled && l.dueDate != null) {
      await _lendedNotif.scheduleLendedReminder(l, settings.currency,
          personName: personById(l.personId)?.name ?? '');
    }
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
    // Always cancel old reminder, then reschedule if still enabled
    await _lendedNotif.cancelLendedReminder(original.id);
    if (updated.reminderEnabled && updated.dueDate != null && !updated.isSettled) {
      await _lendedNotif.scheduleLendedReminder(updated, settings.currency,
          personName: personById(updated.personId)?.name ?? '');
    }
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
    await _lendedNotif.cancelLendedReminder(l.id); // no reminder needed after settlement
  }

  Future<void> deleteLended(String id) async {
    await _lendedNotif.cancelLendedReminder(id);
    await DBHelper.deleteLended(id);
    lended = await DBHelper.getLended();
    notifyListeners();
  }

  Future<VoidCallback> deleteLendedWithUndo(String id) async {
    final record = lended.firstWhere((l) => l.id == id);
    await deleteLended(id);
    return () async {
      await DBHelper.insertLended(record);
      lended = await DBHelper.getLended();
      if (!record.isSettled) {
        final p = lendedPeople.firstWhere((p) => p.id == record.personId);
        _lendedNotif.scheduleLendedReminder(record, settings.currency, personName: p.name);
      }
      notifyListeners();
    };
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

  Future<VoidCallback> deleteAssetWithUndo(String id) async {
    final asset = assets.firstWhere((a) => a.id == id);
    await deleteAsset(id);
    return () async {
      await DBHelper.insertAsset(asset);
      assets = await DBHelper.getAssets();
      notifyListeners();
    };
  }

  double get totalAssetsValue => assets.fold(0.0, (sum, a) {
    if (exchangeRates.isEmpty || a.currency == settings.currency) {
      return sum + a.value;
    }
    return sum +
        (_erService.convert(a.value, a.currency, settings.currency, exchangeRates)
            ?? a.value);
  });

  // ── Budgets ───────────────────────────────────────────────────────────
  Future<void> addBudget(Budget b) async {
    await DBHelper.insertBudget(b);
    budgets = await DBHelper.getBudgets();
    notifyListeners();
  }

  Future<void> updateBudget(Budget b) async {
    await DBHelper.updateBudget(b);
    budgets = await DBHelper.getBudgets();
    notifyListeners();
  }

  Future<void> deleteBudget(String id) async {
    await DBHelper.deleteBudget(id);
    budgets = await DBHelper.getBudgets();
    notifyListeners();
  }

  Future<VoidCallback> deleteBudgetWithUndo(String id) async {
    final b = budgets.firstWhere((b) => b.id == id);
    await deleteBudget(id);
    return () async {
      await addBudget(b);
    };
  }

  Budget? budgetForCategory(String categoryId) =>
      budgets.where((b) => b.categoryId == categoryId).firstOrNull;

  /// Sum of all expenses for [budget]'s category in the current period,
  /// converted to the main currency.
  double budgetSpent(Budget budget) {
    final now = DateTime.now();
    final DateTime periodStart;
    if (budget.period == 'weekly') {
      final dow = now.weekday; // 1=Mon, 7=Sun
      final offset = settings.weekStart == 'monday' ? (dow - 1) : (dow % 7);
      periodStart = DateTime(now.year, now.month, now.day - offset);
    } else {
      periodStart = DateTime(now.year, now.month, 1);
    }

    return transactions
        .where((t) =>
            t.type == 'expense' &&
            t.categoryId == budget.categoryId &&
            !t.date.isBefore(periodStart))
        .fold(0.0, (sum, t) {
      final acct = accountById(t.accountId);
      final txCur = t.currency.isNotEmpty
          ? t.currency
          : (acct?.currency ?? settings.currency);
      return sum + convertToMain(t.amount, txCur);
    });
  }

  double budgetProgress(Budget b) =>
      (budgetSpent(b) / b.amount).clamp(0.0, 1.0);

  double budgetRemaining(Budget b) {
    final rem = b.amount - budgetSpent(b);
    return rem < 0 ? 0 : rem;
  }

  bool budgetExceeded(Budget b) => budgetSpent(b) > b.amount;

  // ── Savings Goals ──────────────────────────────────────────────────────────

  double get totalSaved {
    double sum = 0.0;
    for (final g in savingsGoals) {
      sum += convertToMain(g.currentAmount, g.currency);
    }
    return sum;
  }

  double goalProgress(SavingsGoal g) {
    if (g.targetAmount <= 0) return 0.0;
    return (g.currentAmount / g.targetAmount).clamp(0.0, 1.0);
  }

  Future<void> addSavingsGoal(SavingsGoal g) async {
    await DBHelper.insertSavingsGoal(g);
    savingsGoals = await DBHelper.getSavingsGoals();
    notifyListeners();
  }

  Future<void> updateSavingsGoal(SavingsGoal g) async {
    await DBHelper.updateSavingsGoal(g);
    savingsGoals = await DBHelper.getSavingsGoals();
    notifyListeners();
  }

  Future<void> deleteSavingsGoal(String id) async {
    await DBHelper.deleteSavingsGoal(id);
    savingsGoals = await DBHelper.getSavingsGoals();
    notifyListeners();
  }

  Future<VoidCallback> deleteSavingsGoalWithUndo(String id) async {
    final s = savingsGoals.firstWhere((s) => s.id == id);
    await deleteSavingsGoal(id);
    return () async {
      await addSavingsGoal(s);
    };
  }

  List<SavingsContribution> contributionsFor(String goalId) {
    return savingsContributions.where((c) => c.goalId == goalId).toList();
  }

  Future<void> contributeToGoal({
    required String goalId,
    required String fromAccountId,
    required double amount,
    String note = '',
  }) async {
    final goal = savingsGoals.firstWhere((g) => g.id == goalId);
    final fromAcc = accountById(fromAccountId);
    if (fromAcc == null) return;
    
    // Amount is in the account's currency, we need to convert it to goal's currency.
    final double goalAmount = convertBetween(amount, fromAcc.currency, goal.currency) ?? amount;
    
    final contrib = SavingsContribution(
      id: newId(),
      goalId: goalId,
      amount: goalAmount,
      accountId: fromAccountId,
      type: 'contribution',
      date: DateTime.now(),
      note: note,
    );

    await DBHelper.insertSavingsContribution(contrib);
    await _updateAccountBalance(fromAccountId, -amount);
    
    final wasCompleted = goal.isCompleted;
    var updatedGoal = goal.copyWith(currentAmount: goal.currentAmount + goalAmount);
    
    if (!wasCompleted && updatedGoal.currentAmount >= updatedGoal.targetAmount) {
      updatedGoal = updatedGoal.copyWith(isCompleted: true, completedAt: DateTime.now());
      if (settings.budgetAlertsEnabled) {
        await _budgetNotif.showGoalCompleted(updatedGoal);
      }
    }
    
    await DBHelper.updateSavingsGoal(updatedGoal);
    savingsGoals = await DBHelper.getSavingsGoals();
    savingsContributions = await DBHelper.getAllSavingsContributions();
    accounts = await DBHelper.getAccounts();
    notifyListeners();
  }

  Future<void> withdrawFromGoal({
    required String goalId,
    required String toAccountId,
    required double amount, // amount in goal currency
    String note = '',
  }) async {
    final goal = savingsGoals.firstWhere((g) => g.id == goalId);
    final toAcc = accountById(toAccountId);
    if (toAcc == null) return;
    
    // Cannot withdraw more than we have
    if (amount > goal.currentAmount) return;

    final double accountAmount = convertBetween(amount, goal.currency, toAcc.currency) ?? amount;
    
    final withdrawal = SavingsContribution(
      id: newId(),
      goalId: goalId,
      amount: amount,
      accountId: toAccountId,
      type: 'withdrawal',
      date: DateTime.now(),
      note: note,
    );

    await DBHelper.insertSavingsContribution(withdrawal);
    await _updateAccountBalance(toAccountId, accountAmount);
    
    var updatedGoal = goal.copyWith(currentAmount: goal.currentAmount - amount);
    
    if (updatedGoal.isCompleted && updatedGoal.currentAmount < updatedGoal.targetAmount) {
      updatedGoal = updatedGoal.copyWith(isCompleted: false, clearCompletedAt: true);
    }
    
    await DBHelper.updateSavingsGoal(updatedGoal);
    savingsGoals = await DBHelper.getSavingsGoals();
    savingsContributions = await DBHelper.getAllSavingsContributions();
    accounts = await DBHelper.getAccounts();
    notifyListeners();
  }

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
      type: FileType.any,
      withData: true,
    );
    if (result == null || result.files.isEmpty) return 0;
    final ext = result.files.first.extension?.toLowerCase();
    if (ext != 'json') {
      throw const FormatException('Please select a .json file.');
    }

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
      'wishlist', 'lended_people', 'lended_money', 'assets', 'budgets',
      'recurring_history', 'version', 'settings',
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

    _historyCache.clear();
    await load();
    // Re-register every recurring and lent/borrowed reminder from the
    // restored data — same call the original (pre-account-based-lending)
    // codebase made here.
    await _notif.rescheduleAll(recurring, settings.currency);
    await _lendedNotif.rescheduleAllLended(lended, settings.currency,
        personNameOf: (id) => personById(id)?.name ?? '');

    return (data['_originalVersion'] as int?) ?? (data['version'] as int?) ?? 1;
  }

  // ── External Backups ──────────────────────────────────────────────────
  Future<bool> restoreExternalBackup(String source) async {
    final result = await FilePicker.platform.pickFiles(
      type: source == 'greenstash' ? FileType.custom : FileType.any,
      allowedExtensions: source == 'greenstash' ? ['json'] : null,
    );
    if (result == null || result.files.isEmpty) return false;

    final ext = result.files.first.extension?.toLowerCase();
    if (source == 'greenstash' && ext != 'json') {
      throw const FormatException('Please select a .json file.');
    }

    final bytes = result.files.first.bytes;
    if (bytes == null && result.files.first.path == null) return false;

    String contentStr = bytes != null 
        ? utf8.decode(bytes) 
        : await File(result.files.first.path!).readAsString();

    if (source == 'greenstash') {
      await _restoreGreenStash(contentStr);
    }
    return true;
  }


  Future<void> _restoreGreenStash(String jsonStr) async {
    final decoded = jsonDecode(jsonStr);
    if (decoded is! Map || decoded['data'] is! List) {
      throw const FormatException('Invalid GreenStash format.');
    }

    for (var item in decoded['data']) {
      final goal = item['goal'];
      if (goal == null) continue;

      final sg = SavingsGoal(
        id: newId(),
        name: goal['title'] ?? 'GreenStash Goal',
        targetAmount: (goal['targetAmount'] ?? 0).toDouble(),
        currency: settings.currency,
        colorValue: 0xFF386A1F, // Greenish
        targetDate: goal['deadline'] != null && goal['deadline'] > 0
            ? DateTime.fromMillisecondsSinceEpoch(goal['deadline'])
            : null,
      );
      await addSavingsGoal(sg);

      double currentAmount = 0.0;
      if (item['transactions'] is List) {
        for (var tx in item['transactions']) {
          bool isDeposit = true;
          if (tx['type'] == 1 || tx['type'] == 'withdrawal' || tx['type'] == 'Withdraw' || tx['isDeposit'] == false) {
             isDeposit = false;
          }
          double amt = (tx['amount'] ?? 0).toDouble().abs();
          
          await DBHelper.insertSavingsContribution(SavingsContribution(
            id: newId(),
            goalId: sg.id,
            amount: amt,
            accountId: '', 
            type: isDeposit ? 'contribution' : 'withdrawal',
            date: DateTime.fromMillisecondsSinceEpoch(tx['timeStamp'] ?? DateTime.now().millisecondsSinceEpoch),
            note: tx['notes'] ?? '',
          ));
          if (isDeposit) currentAmount += amt;
          else currentAmount -= amt;
        }
      }
      sg.currentAmount = currentAmount;
      await DBHelper.updateSavingsGoal(sg);
    }
    await load();
  }

  Future<void> _restoreSay(String csvContent) async {
    final lines = csvContent.split('\n');
    // Say CSVs typically have a summary in the first ~9 lines, followed by empty line, then headers at line 10.
    // We'll just look for the header row 'Date,Description,Amount,Currency,Account,Category,Type,Hint'
    // or just assume data rows start after a certain point.
    // A safer way is to find the header row, then parse the following rows.
    int startIndex = -1;
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].toLowerCase().startsWith('date,description,amount')) {
        startIndex = i + 1;
        break;
      }
    }
    if (startIndex == -1) {
      throw const FormatException('Invalid Say CSV format: Header row not found.');
    }

    for (int i = startIndex; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isEmpty) continue;

      try {
        // Simple CSV splitting (Say doesn't typically escape commas in its basic export, but this might break if descriptions have commas)
        // A more robust regex to handle quoted commas could be used, but for now simple split by comma.
        // Actually, we can just use a simple regex for CSV parsing if needed, but a basic split is often sufficient if fields are simple.
        // Let's use a regex that handles basic quoted fields just in case.
        List<String> row = [];
        final regex = RegExp(r',(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)');
        final parts = line.split(regex);
        for (var p in parts) {
          if (p.startsWith('"') && p.endsWith('"') && p.length >= 2) {
            row.add(p.substring(1, p.length - 1).replaceAll('""', '"'));
          } else {
            row.add(p);
          }
        }

        if (row.length < 7) continue;

        final dateStr = row[0];
        final desc = row[1];
        final amountStr = row[2];
        final currencyStr = row[3];
        final accountName = row[4];
        final categoryName = row[5];
        final typeStr = row[6]; // Expense, Income, Adjustment
        final hint = row.length > 7 ? row[7] : '';

        final date = DateTime.tryParse(dateStr) ?? DateTime.now();
        final amount = double.tryParse(amountStr) ?? 0.0;
        
        if (amount == 0 && typeStr != 'Adjustment') continue;

        // Find or create account
        var acc = accounts.firstWhere(
          (a) => a.name.toLowerCase() == accountName.toLowerCase(),
          orElse: () {
            final newAcc = Account(
              id: newId(), name: accountName, type: 'bank',
              currency: currencyStr, balance: 0, colorValue: 0xFF6750A4,
            );
            DBHelper.insertAccount(newAcc);
            accounts.add(newAcc);
            return newAcc;
          }
        );

        // Find or create category
        final isIncome = typeStr == 'Income' || typeStr == 'Adjustment';
        final catType = isIncome ? 'income' : 'expense';
        final catNameToUse = typeStr == 'Adjustment' && categoryName.isEmpty ? 'Balance Adjustment' : categoryName;
        var cat = categories.firstWhere(
          (c) => c.name.toLowerCase() == catNameToUse.toLowerCase() && c.type == catType,
          orElse: () {
            final newCat = AppCategory(
              id: newId(), name: catNameToUse, type: catType, colorValue: 0xFF9C27B0,
            );
            DBHelper.insertCategory(newCat);
            categories.add(newCat);
            return newCat;
          }
        );

        // Create transaction
        final tx = AppTransaction(
          id: newId(),
          type: catType,
          amount: amount,
          description: typeStr == 'Adjustment' && desc.isEmpty ? 'Initial Balance' : desc,
          accountId: acc.id,
          categoryId: cat.id,
          date: date,
          note: hint,
          currency: currencyStr,
        );

        await addTransaction(tx);

      } catch (e) {
        // Skip malformed rows
        continue;
      }
    }
    await load();
  }
  
  bool isTransactionSelectionMode = false;
  final ValueNotifier<int> tabIndexNotifier = ValueNotifier<int>(0);

  List<Account> get nonBankAccounts => accounts.where((a) => a.type != 'bank').toList();

  void reorderCategories(int oldIndex, int newIndex, String type) {
    if (oldIndex < newIndex) newIndex -= 1;
    
    final typedCats = categories.where((c) => c.type == type).toList();
    if (oldIndex < 0 || oldIndex >= typedCats.length || newIndex < 0 || newIndex >= typedCats.length) return;
    
    final item = typedCats[oldIndex];
    
    categories.remove(item);
    
    int insertionIndex = 0;
    int currentTypedIndex = 0;
    for (int i = 0; i < categories.length; i++) {
      if (categories[i].type == type) {
        if (currentTypedIndex == newIndex) {
          insertionIndex = i;
          break;
        }
        currentTypedIndex++;
      }
      insertionIndex = i + 1;
    }
    
    categories.insert(insertionIndex, item);
    notifyListeners();
  }

  Future<VoidCallback> deleteCategoryWithUndo(String id) async {
    final cat = categories.firstWhere((c) => c.id == id);
    final idx = categories.indexOf(cat);
    categories.removeAt(idx);
    await DBHelper.deleteCategory(id);
    notifyListeners();
    return () async {
      categories.insert(idx, cat);
      await DBHelper.insertCategory(cat);
      notifyListeners();
    };
  }

  void reorderAccounts(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    final item = accounts.removeAt(oldIndex);
    accounts.insert(newIndex, item);
    notifyListeners();
  }

  double getBankTotalBalance(String id) {
    final acc = accountById(id);
    if (acc == null) return 0;
    return acc.balance; // Simplified. You could sum transactions if needed.
  }

  Future<VoidCallback> deleteTransactionWithUndo(String id) async {
    final tx = transactions.firstWhere((t) => t.id == id);
    await deleteTransaction(id);
    return () async {
      await addTransaction(tx);
    };
  }

  Future<VoidCallback> deleteLendedPersonWithUndo(String id) async {
    final person = lendedPeople.firstWhere((p) => p.id == id);
    final personLended = lended.where((l) => l.personId == id).toList();
    
    await DBHelper.deleteLendedPerson(id);
    for (final l in personLended) {
      await DBHelper.deleteLended(l.id);
    }
    await load();
    return () async {
      await DBHelper.insertLendedPerson(person);
      for (final l in personLended) {
        await DBHelper.insertLended(l);
      }
      await load();
    };
  }

  Future<VoidCallback> deleteRecurringWithUndo(String id) async {
    final rec = recurring.firstWhere((r) => r.id == id);
    await DBHelper.deleteRecurring(id);
    await load();
    return () async {
      await DBHelper.insertRecurring(rec);
      await load();
    };
  }

  Future<VoidCallback> deleteWishlistWithUndo(String id) async {
    final item = wishlist.firstWhere((w) => w.id == id);
    await DBHelper.deleteWishlist(id);
    await load();
    return () async {
      await DBHelper.insertWishlist(item);
      await load();
    };
  }

  List<AppTransaction> getAccountTransactions(String id) {
    return transactions.where((t) => t.accountId == id).toList();
  }

  double getAccountIncome(String id) {
    return getAccountTransactions(id)
        .where((t) => t.type == 'income')
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double getAccountExpense(String id) {
    return getAccountTransactions(id)
        .where((t) => t.type == 'expense')
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  List<AppTransaction> findPossibleDuplicates(AppTransaction tx, {String? excludeId}) {
    return transactions.where((t) => 
      t.id != excludeId &&
      t.accountId == tx.accountId && 
      t.amount == tx.amount && 
      t.type == tx.type && 
      t.date.difference(tx.date).inDays.abs() <= 2
    ).toList();
  }
}
