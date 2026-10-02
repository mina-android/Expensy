// lib/providers/app_provider.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
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
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import 'package:home_widget/home_widget.dart';
import '../services/credit_reminder_service.dart';
import '../services/loan_reminder_service.dart';
import '../theme/app_theme.dart';

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
  static final _validLanguages = {
    'system',
    ...AppLocalizations.supportedLocales.map((l) => l.languageCode),
  };

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
      if (mode == 'amoled') {
        mode = 'dark';
        legacyAmoled = true;
      } else if (!_validThemeModes.contains(mode)) {
        mode = 'dark';
      }
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
  List<TransactionPreset>     presets      = [];
  List<TransactionSplit>      splits       = [];
  Map<String, List<TransactionSplit>> _splitsByTxId = {};

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

  List<Loan> loans = [];
  List<LoanPayment> loanPayments = [];

  final _erService = ExchangeRateService();
  final _notif       = NotificationService();
  final _lendedNotif = LendedNotificationService();
  final _budgetNotif = BudgetNotificationService();
  final _dailyNotif  = DailyReminderService();
  final _loanNotif   = LoanReminderService();

  bool _loaded = false;
  bool get loaded => _loaded;

  Timer? _autoPayTimer;

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
    loans        = await DBHelper.getLoans();
    loanPayments = await DBHelper.getAllLoanPayments();
    netWorthSnapshots = await DBHelper.getNetWorthSnapshots();
    recurringHistoryCount = await DBHelper.getRecurringHistoryCount();
    presets      = await DBHelper.getPresets();
    splits       = await DBHelper.getAllSplits();
    _rebuildSplitsCache();
    _loaded = true;
    notifyListeners();

    if (settings.dailyReminderEnabled) {
      await _dailyNotif.scheduleDailyReminder(settings.dailyReminderTime);
    } else {
      await _dailyNotif.cancelDailyReminder();
    }

    _loadRates();
    await _recordNetWorthSnapshot();
    await checkAndProcessAutoPay();
    await updateHomeWidgets();

    _autoPayTimer?.cancel();
    _autoPayTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      checkAndProcessAutoPay();
    });
  }

  @override
  void dispose() {
    _autoPayTimer?.cancel();
    super.dispose();
  }

  Future<void> updateHomeWidgets() async {
    try {
      final pinnedIds = settings.pinnedWidgetAccountIds;
      final pinnedAccounts = accounts.where((a) => pinnedIds.contains(a.id)).take(3).toList();
      if (pinnedAccounts.isEmpty) {
        pinnedAccounts.addAll(accounts.take(3));
      }
      final accountsJson = jsonEncode(pinnedAccounts.map((a) => {
        'name': a.name,
        'balance': formatAmount(a.balance, a.currency.isNotEmpty ? a.currency : settings.currency),
      }).toList());
      await HomeWidget.saveWidgetData('accounts_widget_data', accountsJson);
      await HomeWidget.updateWidget(name: 'AccountsWidgetProvider');

      final budgetData = budgets.map((b) {
        final spent = budgetSpent(b);
        final allowance = budgetEffectiveAllowance(b);
        return {
          'category': categoryById(b.categoryId)?.name ?? 'Budget',
          'spent': spent,
          'amount': allowance,
          'progress': budgetProgress(b),
          'exceeded': budgetExceeded(b),
          'currency': settings.currency,
        };
      }).toList();
      await HomeWidget.saveWidgetData('budget_widget_data', jsonEncode(budgetData));
      await HomeWidget.updateWidget(name: 'BudgetWidgetProvider');
    } catch (e) {
      debugPrint('Error updating home widgets: $e');
    }
  }

  Future<void> recordNetWorthSnapshot() async {
    try {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final existing = await DBHelper.getNetWorthSnapshotForDate(today);
      final snap = NetWorthSnapshot(
        id: existing?.id ?? const Uuid().v4(),
        date: today,
        totalAccounts: totalLiquidAccountsValue + totalGoldValue,
        totalAssets: totalAssetsValue + totalLentMoneyValue,
        netWorth: liveNetWorth,
        currency: settings.currency,
      );
      await DBHelper.insertNetWorthSnapshot(snap);
      final idx = netWorthSnapshots.indexWhere((s) => s.date == today);
      if (idx != -1) {
        netWorthSnapshots[idx] = snap;
      } else {
        netWorthSnapshots.add(snap);
        netWorthSnapshots.sort((a, b) => a.date.compareTo(b.date));
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error recording net worth snapshot: $e');
    }
  }

  Future<void> _recordNetWorthSnapshot() => recordNetWorthSnapshot();

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
    if (changed) {
      notifyListeners();
      await recordNetWorthSnapshot();
    }
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
    updateHomeWidgets();

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

  // ── Wealth Management & Net Worth Helpers ──────────────────────────────

  /// Liquid Cash and Bank accounts with positive balances converted to main currency.
  double get totalLiquidAccountsValue => accounts
      .where((a) => a.balance > 0 && !a.isGold)
      .fold(0.0, (sum, a) => sum + convertToMain(a.balance, a.currency));

  /// Physical Gold holding value converted to main currency.
  double get totalGoldValue => accounts
      .where((a) => a.balance > 0 && a.isGold)
      .fold(0.0, (sum, a) => sum + convertToMain(a.balance, a.currency));

  /// Unsettled money lent to others (receivables) converted to main currency.
  double get totalLentMoneyValue => lended
      .where((l) => !l.isSettled && l.type == 'lent')
      .fold(0.0, (sum, l) {
        final cur = l.accountId != null
            ? (accountById(l.accountId!)?.currency ?? settings.currency)
            : settings.currency;
        return sum + convertToMain(l.amount, cur);
      });

  /// Total combined assets: liquid accounts + gold + fixed/investment assets + lent money.
  double get totalWealthAssets =>
      totalLiquidAccountsValue +
      totalGoldValue +
      totalAssetsValue +
      totalLentMoneyValue;

  /// Credit card debt and overdraft accounts (accounts with negative balances) converted to main currency.
  double get totalDebtAccounts => accounts
      .where((a) => a.balance < 0)
      .fold(0.0, (sum, a) => sum + convertToMain(-a.balance, a.currency));

  /// Unsettled money borrowed from others (payables) converted to main currency.
  double get totalBorrowedMoneyValue => lended
      .where((l) => !l.isSettled && l.type == 'borrowed')
      .fold(0.0, (sum, l) {
        final cur = l.accountId != null
            ? (accountById(l.accountId!)?.currency ?? settings.currency)
            : settings.currency;
        return sum + convertToMain(l.amount, cur);
      });

  /// Total combined liabilities: credit/overdraft debt + outstanding loan debt + borrowed money.
  double get totalWealthLiabilities =>
      totalDebtAccounts + totalOutstandingLoanDebt + totalBorrowedMoneyValue;

  /// Real net worth = Total Assets - Total Liabilities.
  double get liveNetWorth => totalWealthAssets - totalWealthLiabilities;

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
    if (a.type == 'credit' && a.creditReminderEnabled) {
      await CreditReminderService().scheduleReminder(a);
    }
    notifyListeners();
    updateHomeWidgets();
    recordNetWorthSnapshot();
  }

  Future<void> updateAccount(Account a) async {
    await DBHelper.updateAccount(a);
    accounts = await DBHelper.getAccounts();
    if (a.dontLinkToCard) {
      final linkedCards = accounts.where((acc) => acc.linkedAccountId == a.id).toList();
      for (final card in linkedCards) {
        await DBHelper.updateAccount(card.copyWith(clearLinkedAccount: true));
      }
      if (linkedCards.isNotEmpty) {
        accounts = await DBHelper.getAccounts();
      }
    }
    if (a.type == 'credit') {
      await CreditReminderService().cancelReminder(a.id);
      if (a.creditReminderEnabled) {
        await CreditReminderService().scheduleReminder(a);
      }
    }
    notifyListeners();
    updateHomeWidgets();
    recordNetWorthSnapshot();
  }

  Future<VoidCallback> deleteAccountWithUndo(String id) async {
    final a = accounts.firstWhere((acc) => acc.id == id);
    await deleteAccount(id);
    return () async {
      await addAccount(a);
    };
  }

  Future<void> deleteAccount(String id) async {
    await CreditReminderService().cancelReminder(id);
    await DBHelper.deleteAccount(id);
    accounts     = await DBHelper.getAccounts();
    transactions = await DBHelper.getTransactions();
    notifyListeners();
    updateHomeWidgets();
    recordNetWorthSnapshot();
  }

  Future<void> _updateAccountBalance(String id, double delta) async {
    final acc = accountById(id);
    if (acc == null) return;
    if (acc.isGold) return;
    await DBHelper.updateAccount(acc.copyWith(balance: acc.balance + delta));
    accounts = await DBHelper.getAccounts();
  }

  /// Calculates the billing cycle, statement balance, unbilled charges, and utilization for a credit card.
  CreditCardStatement getCreditCardStatement(Account acc) {
    assert(acc.type == 'credit', 'Account must be of type credit');

    final debt = acc.balance < 0 ? -acc.balance : 0.0;
    final isFullyPaid = debt <= 0.0;
    final limit = acc.creditLimit ?? 0.0;
    final availableCredit =
        limit > 0 ? (limit - debt).clamp(0.0, double.infinity) : 0.0;
    final utilization = limit > 0 ? (debt / limit) * 100.0 : 0.0;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    DateTime? statementDate;
    DateTime? prevStatementDate;
    DateTime? dueDate;
    int? daysUntilDue;
    bool isDueSoon = false;
    bool isOverdue = false;

    if (acc.statementDay != null) {
      final sDay = acc.statementDay!;
      final daysInThisMonth = DateTime(now.year, now.month + 1, 0).day;
      final thisMonthStatement =
          DateTime(now.year, now.month, sDay.clamp(1, daysInThisMonth));

      if (today.isBefore(thisMonthStatement)) {
        // Latest closed statement was previous month
        final prevYear = now.month == 1 ? now.year - 1 : now.year;
        final prevMonth = now.month == 1 ? 12 : now.month - 1;
        final prevDays = DateTime(prevYear, prevMonth + 1, 0).day;
        statementDate = DateTime(prevYear, prevMonth, sDay.clamp(1, prevDays));

        final p2Year = prevMonth == 1 ? prevYear - 1 : prevYear;
        final p2Month = prevMonth == 1 ? 12 : prevMonth - 1;
        final p2Days = DateTime(p2Year, p2Month + 1, 0).day;
        prevStatementDate = DateTime(p2Year, p2Month, sDay.clamp(1, p2Days));
      } else {
        // Latest closed statement is this month
        statementDate = thisMonthStatement;

        final prevYear = now.month == 1 ? now.year - 1 : now.year;
        final prevMonth = now.month == 1 ? 12 : now.month - 1;
        final prevDays = DateTime(prevYear, prevMonth + 1, 0).day;
        prevStatementDate = DateTime(prevYear, prevMonth, sDay.clamp(1, prevDays));
      }
    } else {
      // Default statement period to start of calendar month
      statementDate = DateTime(now.year, now.month, 1);
      final prevYear = now.month == 1 ? now.year - 1 : now.year;
      final prevMonth = now.month == 1 ? 12 : now.month - 1;
      prevStatementDate = DateTime(prevYear, prevMonth, 1);
    }

    if (acc.dueDay != null) {
      final dDay = acc.dueDay!;
      final sDate = statementDate;
      final sYear = sDate.year;
      final sMonth = sDate.month;
      final sDays = DateTime(sYear, sMonth + 1, 0).day;
      final sameMonthDue = DateTime(sYear, sMonth, dDay.clamp(1, sDays));

      if (sameMonthDue.isAfter(sDate)) {
        dueDate = sameMonthDue;
      } else {
        final nYear = sMonth == 12 ? sYear + 1 : sYear;
        final nMonth = sMonth == 12 ? 1 : sMonth + 1;
        final nDays = DateTime(nYear, nMonth + 1, 0).day;
        dueDate = DateTime(nYear, nMonth, dDay.clamp(1, nDays));
      }

      daysUntilDue = dueDate.difference(today).inDays;
      isOverdue = daysUntilDue < 0 && debt > 0.0;
      isDueSoon = daysUntilDue >= 0 && daysUntilDue <= 5 && debt > 0.0;
    }

    // Isolate statement window vs unbilled charges
    double cycleNetExpenses = 0.0;

    final cardTxs = transactions.where((t) => t.accountId == acc.id);
    final stmtEnd = DateTime(statementDate.year, statementDate.month,
        statementDate.day, 23, 59, 59);

    for (final t in cardTxs) {
      final sign = t.type == 'expense' ? 1.0 : -1.0;
      final amt = convertBetween(t.amount,
              t.currency.isEmpty ? acc.currency : t.currency, acc.currency) ??
          t.amount;
      final delta = amt * sign;

      if (!t.date.isAfter(stmtEnd) && t.date.isAfter(prevStatementDate)) {
        cycleNetExpenses += delta;
      }
    }

    double statementBalance = 0.0;
    double unbilledBalance = 0.0;

    if (isFullyPaid) {
      statementBalance = 0.0;
      unbilledBalance = 0.0;
    } else {
      if (cycleNetExpenses > 0.0) {
        statementBalance = math.min(cycleNetExpenses, debt);
        unbilledBalance = (debt - statementBalance).clamp(0.0, double.infinity);
      } else {
        statementBalance = debt;
        unbilledBalance = 0.0;
      }
    }

    double minPayment = 0.0;
    if (!isFullyPaid) {
      if (acc.minPaymentAmount != null && acc.minPaymentAmount! > 0) {
        minPayment = math.min(acc.minPaymentAmount!, debt);
      } else if (acc.minPaymentPercent != null &&
          acc.minPaymentPercent! > 0) {
        minPayment = math.min(debt * (acc.minPaymentPercent! / 100.0), debt);
      } else {
        minPayment =
            math.min(math.max(debt * 0.05, math.min(25.0, debt)), debt);
      }
    }

    return CreditCardStatement(
      account: acc,
      statementDate: statementDate,
      previousStatementDate: prevStatementDate,
      dueDate: dueDate,
      statementBalance: statementBalance,
      unbilledBalance: unbilledBalance,
      totalOutstandingDebt: debt,
      creditLimit: limit,
      availableCredit: availableCredit,
      utilizationPercent: utilization,
      minPaymentAmount: minPayment,
      daysUntilDue: daysUntilDue,
      isDueSoon: isDueSoon,
      isOverdue: isOverdue,
      isFullyPaid: isFullyPaid,
    );
  }

  /// Settles a credit card bill from a funding account.
  Future<void> settleCreditCard({
    required Account cardAccount,
    required Account fromAccount,
    required double amount,
    String? note,
  }) async {
    assert(amount > 0, 'Payment amount must be greater than zero');
    await addTransfer(
      fromId: fromAccount.id,
      toId: cardAccount.id,
      fromAmount: amount,
      note: note ?? 'Credit card bill payment — ${cardAccount.name}',
    );

    final refreshedCard = accountById(cardAccount.id);
    if (refreshedCard != null && refreshedCard.creditReminderEnabled) {
      await CreditReminderService().cancelReminder(refreshedCard.id);
      if (refreshedCard.balance < 0) {
        await CreditReminderService().scheduleReminder(refreshedCard);
      }
    }
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
    updateHomeWidgets();
    recordNetWorthSnapshot();
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
    updateHomeWidgets();
    recordNetWorthSnapshot();
  }

  Future<void> _checkBudgetAlert(AppTransaction t) async {
    if (!settings.budgetAlertsEnabled) return;
    if (t.type != 'expense') return;
    if (isTransactionSplit(t.id)) {
      final txSplits = getSplits(t.id);
      for (final s in txSplits) {
        final b = budgetForCategory(s.categoryId);
        if (b != null && budgetExceeded(b)) {
          final cat = categoryById(s.categoryId);
          if (cat != null) {
            await _budgetNotif.showBudgetExceeded(
                b, cat, budgetSpent(b), budgetEffectiveAllowance(b));
          }
        }
      }
    } else {
      final b = budgetForCategory(t.categoryId);
      if (b == null) return;
      if (budgetExceeded(b)) {
        final cat = categoryById(t.categoryId);
        if (cat != null) {
          await _budgetNotif.showBudgetExceeded(
              b, cat, budgetSpent(b), budgetEffectiveAllowance(b));
        }
      }
    }
  }

  Future<void> deleteTransaction(String id) async {
    final t = transactions.where((x) => x.id == id).firstOrNull;
    if (t == null) return;
    await _updateAccountBalance(t.accountId, _txDelta(t, reverse: true));
    await DBHelper.deleteTransaction(id);
    splits.removeWhere((s) => s.transactionId == id);
    _splitsByTxId.remove(id);
    transactions = await DBHelper.getTransactions();
    accounts     = await DBHelper.getAccounts();
    notifyListeners();
    updateHomeWidgets();
    recordNetWorthSnapshot();
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
    updateHomeWidgets();
    recordNetWorthSnapshot();
  }

  // ── Presets ───────────────────────────────────────────────────────────
  Future<void> addPreset(TransactionPreset p) async {
    await DBHelper.insertPreset(p);
    presets = await DBHelper.getPresets();
    notifyListeners();
  }

  Future<void> updatePreset(TransactionPreset p) async {
    await DBHelper.updatePreset(p);
    presets = await DBHelper.getPresets();
    notifyListeners();
  }

  Future<void> deletePreset(String id) async {
    await DBHelper.deletePreset(id);
    presets.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  /// 1-Tap Log a Transaction from a Preset for the current time
  Future<AppTransaction> logPreset(TransactionPreset preset) async {
    final acc = accountById(preset.accountId);
    final accCurrency = acc?.currency ?? settings.currency;
    final storeCurrency = preset.currency == accCurrency ? '' : preset.currency;

    final tx = AppTransaction(
      id: newId(),
      type: preset.type,
      amount: preset.amount,
      description: preset.title,
      accountId: preset.accountId,
      categoryId: preset.categoryId,
      date: DateTime.now(),
      note: preset.note,
      currency: storeCurrency,
    );

    await addTransaction(tx);
    return tx;
  }

  // ── Splits ────────────────────────────────────────────────────────────
  void _rebuildSplitsCache() {
    _splitsByTxId = {};
    for (final s in splits) {
      _splitsByTxId.putIfAbsent(s.transactionId, () => []).add(s);
    }
  }

  @visibleForTesting
  void rebuildSplitsCache() => _rebuildSplitsCache();

  bool isTransactionSplit(String txId) =>
      _splitsByTxId.containsKey(txId) && _splitsByTxId[txId]!.isNotEmpty;

  List<TransactionSplit> getSplits(String txId) =>
      _splitsByTxId[txId] ?? const [];

  Future<List<TransactionSplit>> getSplitsForTransaction(String transactionId) =>
      DBHelper.getSplitsForTransaction(transactionId);

  Future<void> saveTransactionSplits(
      String transactionId, List<TransactionSplit> newSplits) async {
    await DBHelper.saveTransactionSplits(transactionId, newSplits);
    splits = await DBHelper.getAllSplits();
    _rebuildSplitsCache();
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
    if (r.autoPayEnabled) {
      await checkAndProcessAutoPay();
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
    if (r.autoPayEnabled) {
      await checkAndProcessAutoPay();
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
      recurringType: r.recurringType,
      autoPayEnabled: r.autoPayEnabled,
      autoPayTime: r.autoPayTime,
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
      recurringType: r.recurringType,
      autoPayEnabled: r.autoPayEnabled,
      autoPayTime: r.autoPayTime,
    );
    await DBHelper.updateRecurring(updated);
    recurring = await DBHelper.getRecurring();
    notifyListeners();
    await _notif.cancelReminder(r.id);
    await _notif.scheduleReminder(updated, settings.currency);
  }

  /// Automatically marks any recurring items paid if they are due today or overdue
  /// and have auto-pay enabled.
  Future<void> checkAndProcessAutoPay() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final autoPayList = recurring.where((r) {
      if (!r.autoPayEnabled) return false;
      final dueDate = DateTime(r.nextDate.year, r.nextDate.month, r.nextDate.day);
      if (dueDate.isBefore(today)) return true;
      if (dueDate.isAtSameMomentAs(today)) {
        // Compare autoPayTime with current time
        final parts = r.autoPayTime.split(':');
        final targetHour = int.tryParse(parts[0]) ?? 9;
        final targetMinute = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;
        final currentMinutes = now.hour * 60 + now.minute;
        final targetMinutes = targetHour * 60 + targetMinute;
        return currentMinutes >= targetMinutes;
      }
      return false;
    }).toList();

    for (final r in autoPayList) {
      await markRecurringPaid(r);
    }
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
    for (final g in savingsGoals.where((g) => g.wishlistItemId == id)) {
      await DBHelper.updateSavingsGoal(g.copyWith(clearWishlistItemId: true));
    }
    savingsGoals = await DBHelper.getSavingsGoals();
    await DBHelper.deleteWishlist(id);
    wishlist = await DBHelper.getWishlist();
    notifyListeners();
  }

  SavingsGoal? goalForWishlist(WishlistItem item) {
    if (item.goalId == null) return null;
    return savingsGoals.where((g) => g.id == item.goalId).firstOrNull;
  }

  WishlistItem? wishlistForGoal(SavingsGoal goal) {
    if (goal.wishlistItemId == null) return null;
    return wishlist.where((w) => w.id == goal.wishlistItemId).firstOrNull;
  }

  Future<void> createGoalForWishlist(WishlistItem item, SavingsGoal goal) async {
    final updatedGoal = goal.copyWith(wishlistItemId: item.id);
    final updatedItem = item.copyWith(goalId: goal.id);
    await DBHelper.insertSavingsGoal(updatedGoal);
    await DBHelper.updateWishlist(updatedItem);
    savingsGoals = await DBHelper.getSavingsGoals();
    wishlist = await DBHelper.getWishlist();
    notifyListeners();
  }

  Future<void> unlinkWishlistAndGoal({
    required String wishlistItemId,
    required String goalId,
  }) async {
    final w = wishlist.where((x) => x.id == wishlistItemId).firstOrNull;
    if (w != null) {
      await DBHelper.updateWishlist(w.copyWith(clearGoalId: true));
    }
    final g = savingsGoals.where((x) => x.id == goalId).firstOrNull;
    if (g != null) {
      await DBHelper.updateSavingsGoal(g.copyWith(clearWishlistItemId: true));
    }
    wishlist = await DBHelper.getWishlist();
    savingsGoals = await DBHelper.getSavingsGoals();
    notifyListeners();
  }

  Future<void> purchaseWishlistItem({
    required WishlistItem item,
    String? accountId,
    String? categoryId,
    double? amount,
    String? note,
  }) async {
    if (accountId != null) {
      final txAmount = amount ?? item.targetPrice;
      final defaultCat =
          categories.where((c) => c.type == 'expense').firstOrNull?.id ?? '';
      final tx = AppTransaction(
        id: newId(),
        type: 'expense',
        amount: txAmount,
        description: item.name,
        accountId: accountId,
        categoryId: (categoryId != null && categoryId.isNotEmpty)
            ? categoryId
            : defaultCat,
        date: DateTime.now(),
        note: note ?? (item.notes.isNotEmpty ? item.notes : ''),
      );
      await addTransaction(tx);
    }

    final updatedItem = item.copyWith(isPurchased: true);
    await updateWishlist(updatedItem);

    if (item.goalId != null) {
      final goal = savingsGoals.where((g) => g.id == item.goalId).firstOrNull;
      if (goal != null && !goal.isCompleted) {
        final completedGoal = goal.copyWith(
          isCompleted: true,
          completedAt: DateTime.now(),
        );
        await updateSavingsGoal(completedGoal);
      }
    }
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
    recordNetWorthSnapshot();
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
    recordNetWorthSnapshot();
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
    recordNetWorthSnapshot();
    await _lendedNotif.cancelLendedReminder(l.id); // no reminder needed after settlement
  }

  Future<void> deleteLended(String id) async {
    await _lendedNotif.cancelLendedReminder(id);
    await DBHelper.deleteLended(id);
    lended = await DBHelper.getLended();
    notifyListeners();
    recordNetWorthSnapshot();
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
    recordNetWorthSnapshot();
  }

  Future<void> updateAsset(AssetItem a) async {
    await DBHelper.updateAsset(a);
    assets = await DBHelper.getAssets();
    notifyListeners();
    recordNetWorthSnapshot();
  }

  Future<void> deleteAsset(String id) async {
    await DBHelper.deleteAsset(id);
    assets = await DBHelper.getAssets();
    notifyListeners();
    recordNetWorthSnapshot();
  }

  Future<VoidCallback> deleteAssetWithUndo(String id) async {
    final asset = assets.firstWhere((a) => a.id == id);
    await deleteAsset(id);
    return () async {
      await DBHelper.insertAsset(asset);
      assets = await DBHelper.getAssets();
      notifyListeners();
      recordNetWorthSnapshot();
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
    updateHomeWidgets();
  }

  Future<void> updateBudget(Budget b) async {
    await DBHelper.updateBudget(b);
    budgets = await DBHelper.getBudgets();
    notifyListeners();
    updateHomeWidgets();
  }

  Future<void> deleteBudget(String id) async {
    await DBHelper.deleteBudget(id);
    budgets = await DBHelper.getBudgets();
    notifyListeners();
    updateHomeWidgets();
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

  DateTime getCurrentPeriodStart(Budget budget, [DateTime? referenceDate]) {
    final now = referenceDate ?? DateTime.now();
    if (budget.period == 'weekly') {
      final dow = now.weekday; // 1=Mon, 7=Sun
      final offset = settings.weekStart == 'monday' ? (dow - 1) : (dow % 7);
      return DateTime(now.year, now.month, now.day - offset);
    } else {
      return DateTime(now.year, now.month, 1);
    }
  }

  DateTime getPreviousPeriodStart(Budget budget, [DateTime? referenceDate]) {
    final now = referenceDate ?? DateTime.now();
    if (budget.period == 'weekly') {
      final currentStart = getCurrentPeriodStart(budget, now);
      return currentStart.subtract(const Duration(days: 7));
    } else {
      return DateTime(now.year, now.month - 1, 1);
    }
  }

  /// Calculates spending for a budget's category within the half-open date interval [start, end).
  double budgetSpentInPeriod(Budget budget, DateTime start, DateTime end) {
    return transactions
        .where((t) =>
            t.type == 'expense' &&
            !t.date.isBefore(start) &&
            t.date.isBefore(end))
        .fold(0.0, (sum, t) {
      final acct = accountById(t.accountId);
      final txCur = t.currency.isNotEmpty
          ? t.currency
          : (acct?.currency ?? settings.currency);
      if (isTransactionSplit(t.id)) {
        final txSplits =
            getSplits(t.id).where((s) => s.categoryId == budget.categoryId);
        if (txSplits.isEmpty) return sum;
        final splitSum = txSplits.fold(0.0, (s, item) => s + item.amount);
        return sum + convertToMain(splitSum, txCur);
      } else {
        if (t.categoryId != budget.categoryId) return sum;
        return sum + convertToMain(t.amount, txCur);
      }
    });
  }

  /// Sum of all expenses for [budget]'s category in the current period,
  /// converted to the main currency.
  double budgetSpent(Budget budget, [DateTime? referenceDate]) {
    final now = referenceDate ?? DateTime.now();
    final periodStart = getCurrentPeriodStart(budget, now);
    final periodEnd = budget.period == 'weekly'
        ? periodStart.add(const Duration(days: 7))
        : DateTime(now.year, now.month + 1, 1);
    return budgetSpentInPeriod(budget, periodStart, periodEnd);
  }

  /// Computes the rollover surplus (positive) or overspending deficit (negative)
  /// from the previous period if [budget.allowRollover] is true.
  /// If rollover is disabled, returns 0.0.
  double budgetRollover(Budget budget, [DateTime? referenceDate]) {
    if (!budget.allowRollover) return 0.0;
    final now = referenceDate ?? DateTime.now();
    final prevStart = getPreviousPeriodStart(budget, now);
    final currentStart = getCurrentPeriodStart(budget, now);

    final prevSpent = budgetSpentInPeriod(budget, prevStart, currentStart);

    // If the budget was created in the current period and there was no spending
    // in the previous period, don't generate an unearned rollover surplus.
    if (!budget.createdAt.isBefore(currentStart) && prevSpent == 0.0) {
      return 0.0;
    }

    return budget.amount - prevSpent;
  }

  /// Effective budget allowance for the current period:
  /// Base Budget + Rollover (if enabled). Clamped to at least 0.
  double budgetEffectiveAllowance(Budget budget, [DateTime? referenceDate]) {
    if (!budget.allowRollover) return budget.amount;
    final rollover = budgetRollover(budget, referenceDate);
    final effective = budget.amount + rollover;
    return effective < 0 ? 0.0 : effective;
  }

  /// Progress against the effective budget allowance (0.0 to 1.0).
  double budgetProgress(Budget b) {
    final allowance = budgetEffectiveAllowance(b);
    if (allowance <= 0) {
      return budgetSpent(b) > 0 ? 1.0 : 0.0;
    }
    return (budgetSpent(b) / allowance).clamp(0.0, 1.0);
  }

  /// Remaining amount of effective budget allowance.
  double budgetRemaining(Budget b) {
    final allowance = budgetEffectiveAllowance(b);
    final rem = allowance - budgetSpent(b);
    return rem < 0 ? 0.0 : rem;
  }

  /// True if current spending exceeds the effective budget allowance.
  bool budgetExceeded(Budget b) =>
      budgetSpent(b) > budgetEffectiveAllowance(b);

  /// Label of the previous period (e.g. "Aug", "Last Week") for rollover subheaders.
  String previousPeriodName(Budget budget,
      [String? lastWeekLabel, DateTime? referenceDate]) {
    final now = referenceDate ?? DateTime.now();
    if (budget.period == 'weekly') {
      return lastWeekLabel ?? 'Last Week';
    } else {
      final prevMonthDate = DateTime(now.year, now.month - 1, 1);
      return DateFormat.MMM().format(prevMonthDate);
    }
  }

  /// Computes the daily Safe-to-Spend pacing analysis for [budget].
  BudgetPacingInfo budgetPacing(Budget budget, [DateTime? referenceDate]) {
    final now = referenceDate ?? DateTime.now();
    final periodStart = getCurrentPeriodStart(budget, now);
    final int totalDays;
    final int elapsedDays;

    if (budget.period == 'weekly') {
      totalDays = 7;
      final diff = now.difference(periodStart).inDays + 1;
      elapsedDays = diff.clamp(1, 7);
    } else {
      totalDays = DateTime(now.year, now.month + 1, 0).day;
      elapsedDays = now.day.clamp(1, totalDays);
    }

    final daysRemaining = (totalDays - elapsedDays + 1).clamp(1, totalDays);
    final allowance = budgetEffectiveAllowance(budget, now);
    final spent = budgetSpent(budget, now);
    final remaining = allowance - spent;
    final safeDaily = (allowance > 0 && remaining > 0)
        ? remaining / daysRemaining
        : 0.0;

    final double pacingRatio;
    if (allowance <= 0) {
      pacingRatio = spent > 0 ? 999.0 : 1.0;
    } else {
      final spentFrac = spent / allowance;
      final timeFrac = elapsedDays / totalDays;
      pacingRatio = timeFrac > 0 ? (spentFrac / timeFrac) : 1.0;
    }

    final BudgetPacingStatus status;
    if (spent > allowance) {
      status = BudgetPacingStatus.exceeded;
    } else if (pacingRatio > 1.25) {
      status = BudgetPacingStatus.overPaced;
    } else if (pacingRatio > 1.0) {
      status = BudgetPacingStatus.caution;
    } else {
      status = BudgetPacingStatus.onTrack;
    }

    return BudgetPacingInfo(
      safeDailyAllowance: safeDaily,
      pacingRatio: pacingRatio,
      daysRemaining: daysRemaining,
      totalDaysInPeriod: totalDays,
      elapsedDays: elapsedDays,
      spent: spent,
      allowance: allowance,
      remainingAmount: remaining < 0 ? 0.0 : remaining,
      status: status,
    );
  }

  /// Aggregated Safe-to-Spend daily pacing analysis across all monthly category budgets.
  /// Returns null if no monthly budgets are configured.
  BudgetPacingInfo? overallMonthlyBudgetPacing([DateTime? referenceDate]) {
    final monthlyBudgets =
        budgets.where((b) => b.period == 'monthly').toList();
    if (monthlyBudgets.isEmpty) return null;

    final now = referenceDate ?? DateTime.now();
    final totalDays = DateTime(now.year, now.month + 1, 0).day;
    final elapsedDays = now.day.clamp(1, totalDays);
    final daysRemaining = (totalDays - elapsedDays + 1).clamp(1, totalDays);

    double totalAllowance = 0.0;
    double totalSpent = 0.0;

    for (final b in monthlyBudgets) {
      totalAllowance += budgetEffectiveAllowance(b, now);
      totalSpent += budgetSpent(b, now);
    }

    final remaining = totalAllowance - totalSpent;
    final safeDaily = (totalAllowance > 0 && remaining > 0)
        ? remaining / daysRemaining
        : 0.0;

    final double pacingRatio;
    if (totalAllowance <= 0) {
      pacingRatio = totalSpent > 0 ? 999.0 : 1.0;
    } else {
      final spentFrac = totalSpent / totalAllowance;
      final timeFrac = elapsedDays / totalDays;
      pacingRatio = timeFrac > 0 ? (spentFrac / timeFrac) : 1.0;
    }

    final BudgetPacingStatus status;
    if (totalSpent > totalAllowance) {
      status = BudgetPacingStatus.exceeded;
    } else if (pacingRatio > 1.25) {
      status = BudgetPacingStatus.overPaced;
    } else if (pacingRatio > 1.0) {
      status = BudgetPacingStatus.caution;
    } else {
      status = BudgetPacingStatus.onTrack;
    }

    return BudgetPacingInfo(
      safeDailyAllowance: safeDaily,
      pacingRatio: pacingRatio,
      daysRemaining: daysRemaining,
      totalDaysInPeriod: totalDays,
      elapsedDays: elapsedDays,
      spent: totalSpent,
      allowance: totalAllowance,
      remainingAmount: remaining < 0 ? 0.0 : remaining,
      status: status,
    );
  }

  // ── Financial Calendar & Spending Heatmap ──────────────────────────────────

  /// Returns all transactions recorded on [day] (matching year, month, and day).
  List<AppTransaction> transactionsForDay(DateTime day) {
    return transactions.where((t) =>
        t.date.year == day.year &&
        t.date.month == day.month &&
        t.date.day == day.day).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  /// Total expense for [day] converted to main currency, correctly handling split transactions.
  double dayExpense(DateTime day) {
    final dayTxs = transactions.where((t) =>
        t.type == 'expense' &&
        t.date.year == day.year &&
        t.date.month == day.month &&
        t.date.day == day.day);

    return dayTxs.fold(0.0, (sum, t) {
      final acct = accountById(t.accountId);
      final txCur = t.currency.isNotEmpty
          ? t.currency
          : (acct?.currency ?? settings.currency);
      return sum + convertToMain(t.amount, txCur);
    });
  }

  /// Total income for [day] converted to main currency.
  double dayIncome(DateTime day) {
    final dayTxs = transactions.where((t) =>
        t.type == 'income' &&
        t.date.year == day.year &&
        t.date.month == day.month &&
        t.date.day == day.day);

    return dayTxs.fold(0.0, (sum, t) {
      final acct = accountById(t.accountId);
      final txCur = t.currency.isNotEmpty
          ? t.currency
          : (acct?.currency ?? settings.currency);
      return sum + convertToMain(t.amount, txCur);
    });
  }

  /// Recurring payments due on [day].
  List<RecurringPayment> recurringDueOnDay(DateTime day) {
    return recurring.where((r) =>
        r.nextDate.year == day.year &&
        r.nextDate.month == day.month &&
        r.nextDate.day == day.day).toList();
  }

  /// Active loans with a payment due on [day].
  List<Loan> loansDueOnDay(DateTime day) {
    return loans.where((l) =>
        !l.isSettled &&
        !day.isBefore(DateTime(l.startDate.year, l.startDate.month, l.startDate.day)) &&
        !day.isAfter(DateTime(l.endDate.year, l.endDate.month, l.endDate.day)) &&
        l.reminderDay == day.day).toList();
  }

  /// Unsettled lent money records expected to be repaid on [day].
  List<LendedMoney> lendedDueOnDay(DateTime day) {
    return lended.where((m) =>
        !m.isSettled &&
        m.dueDate != null &&
        m.dueDate!.year == day.year &&
        m.dueDate!.month == day.month &&
        m.dueDate!.day == day.day).toList();
  }

  /// Number of zero-spend days in [month] up to [referenceDate] (or end of month).
  int zeroSpendDaysCount(DateTime month, [DateTime? referenceDate]) {
    final now = referenceDate ?? DateTime.now();
    final totalDaysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final int maxDay;
    if (month.year == now.year && month.month == now.month) {
      maxDay = now.day.clamp(1, totalDaysInMonth);
    } else if (month.isBefore(DateTime(now.year, now.month, 1))) {
      maxDay = totalDaysInMonth;
    } else {
      return 0;
    }

    int zeroDays = 0;
    for (int d = 1; d <= maxDay; d++) {
      final dayDate = DateTime(month.year, month.month, d);
      if (dayExpense(dayDate) <= 0.001) {
        zeroDays++;
      }
    }
    return zeroDays;
  }

  /// Total expense for the whole [month] converted to main currency.
  double monthTotalExpense(DateTime month) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 1);
    return transactions.where((t) =>
        t.type == 'expense' &&
        !t.date.isBefore(start) &&
        t.date.isBefore(end)).fold(0.0, (sum, t) {
      final acct = accountById(t.accountId);
      final txCur = t.currency.isNotEmpty
          ? t.currency
          : (acct?.currency ?? settings.currency);
      return sum + convertToMain(t.amount, txCur);
    });
  }

  /// Total income for the whole [month] converted to main currency.
  double monthTotalIncome(DateTime month) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 1);
    return transactions.where((t) =>
        t.type == 'income' &&
        !t.date.isBefore(start) &&
        t.date.isBefore(end)).fold(0.0, (sum, t) {
      final acct = accountById(t.accountId);
      final txCur = t.currency.isNotEmpty
          ? t.currency
          : (acct?.currency ?? settings.currency);
      return sum + convertToMain(t.amount, txCur);
    });
  }

  /// Computes monthly story digest metrics for Expensy Wrapped.
  ExpensyWrappedData getWrappedData(DateTime month) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 1);
    final totalDays = DateTime(month.year, month.month + 1, 0).day;
    final inflow = monthTotalIncome(month);
    final outflow = monthTotalExpense(month);
    final net = inflow - outflow;
    final savingsRate =
        inflow > 0 ? ((net / inflow) * 100).clamp(0.0, 100.0) : 0.0;
    final zeroDays = zeroSpendDaysCount(month);

    final monthExpenses = transactions
        .where((t) =>
            t.type == 'expense' &&
            !t.date.isBefore(start) &&
            t.date.isBefore(end))
        .toList();

    // Top spending category
    final Map<String, double> catTotals = {};
    for (final t in monthExpenses) {
      if (t.categoryId.isNotEmpty) {
        final acct = accountById(t.accountId);
        final txCur = t.currency.isNotEmpty
            ? t.currency
            : (acct?.currency ?? settings.currency);
        final amt = convertToMain(t.amount, txCur);
        catTotals[t.categoryId] = (catTotals[t.categoryId] ?? 0.0) + amt;
      }
    }

    String? topCatId;
    double topCatAmt = 0.0;
    for (final entry in catTotals.entries) {
      if (entry.value > topCatAmt) {
        topCatAmt = entry.value;
        topCatId = entry.key;
      }
    }
    final topCatPct =
        outflow > 0 ? (topCatAmt / outflow * 100).clamp(0.0, 100.0) : 0.0;

    // Single biggest splurge
    AppTransaction? biggest;
    double biggestAmt = 0.0;
    for (final t in monthExpenses) {
      final acct = accountById(t.accountId);
      final txCur = t.currency.isNotEmpty
          ? t.currency
          : (acct?.currency ?? settings.currency);
      final amt = convertToMain(t.amount, txCur);
      if (amt > biggestAmt) {
        biggestAmt = amt;
        biggest = t;
      }
    }

    return ExpensyWrappedData(
      month: month,
      totalInflow: inflow,
      totalOutflow: outflow,
      netSaved: net,
      savingsRate: savingsRate,
      topCategoryId: topCatId,
      topCategoryAmount: topCatAmt,
      topCategoryPercent: topCatPct,
      biggestSplurge: biggest,
      biggestSplurgeAmount: biggestAmt,
      zeroSpendDays: zeroDays,
      totalDaysInMonth: totalDays,
    );
  }

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
    for (final w in wishlist.where((w) => w.goalId == id)) {
      await DBHelper.updateWishlist(w.copyWith(clearGoalId: true));
    }
    wishlist = await DBHelper.getWishlist();
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

  // ── Loans ────────────────────────────────────────────────────────────
  Future<void> addLoan(Loan l) async {
    await DBHelper.insertLoan(l);
    if (l.transferAccountId != null) {
      await _updateAccountBalance(l.transferAccountId!, l.principal);
    }
    loans = await DBHelper.getLoans();
    accounts = await DBHelper.getAccounts();
    notifyListeners();
    recordNetWorthSnapshot();
    if (l.reminderEnabled) await _loanNotif.scheduleReminder(l);
  }

  Future<void> updateLoan(Loan l) async {
    await _loanNotif.cancelReminder(l.id);
    final oldL = loans.firstWhere((x) => x.id == l.id);
    
    // Reverse old principal transfer if any
    if (oldL.transferAccountId != null) {
      await _updateAccountBalance(oldL.transferAccountId!, -oldL.principal);
    }
    // Apply new principal transfer if any
    if (l.transferAccountId != null) {
      await _updateAccountBalance(l.transferAccountId!, l.principal);
    }

    await DBHelper.updateLoan(l);
    loans = await DBHelper.getLoans();
    accounts = await DBHelper.getAccounts();
    notifyListeners();
    recordNetWorthSnapshot();
    if (l.reminderEnabled) await _loanNotif.scheduleReminder(l);
  }

  Future<void> deleteLoan(String id) async {
    await _loanNotif.cancelReminder(id);
    final l = loans.firstWhere((x) => x.id == id);
    
    // Reverse principal transfer if any
    if (l.transferAccountId != null) {
      await _updateAccountBalance(l.transferAccountId!, -l.principal);
    }

    for (final p in loanPaymentsFor(id)) {
      if (p.accountId != null) {
        await _updateAccountBalance(p.accountId!, p.amount); // reverse debit
      }
    }
    await DBHelper.deleteLoan(id);
    loans = await DBHelper.getLoans();
    loanPayments = await DBHelper.getAllLoanPayments();
    accounts = await DBHelper.getAccounts();
    notifyListeners();
    recordNetWorthSnapshot();
  }

  Future<VoidCallback> deleteLoanWithUndo(String id) async {
    final l = loans.firstWhere((x) => x.id == id);
    final payments = loanPaymentsFor(id);
    await deleteLoan(id);
    return () async {
      await DBHelper.insertLoan(l);
      if (l.transferAccountId != null) {
        await _updateAccountBalance(l.transferAccountId!, l.principal);
      }
      for (final p in payments) {
        await DBHelper.insertLoanPayment(p);
        if (p.accountId != null) {
          await _updateAccountBalance(p.accountId!, -p.amount);
        }
      }
      loans = await DBHelper.getLoans();
      loanPayments = await DBHelper.getAllLoanPayments();
      accounts = await DBHelper.getAccounts();
      notifyListeners();
      recordNetWorthSnapshot();
      if (l.reminderEnabled) await _loanNotif.scheduleReminder(l);
    };
  }

  Future<void> payLoanInstallment(Loan l, {double? amount, String? accountId, String notes = ''}) async {
    final payAmount = amount ?? l.monthlyPayment;
    final useAccount = accountId ?? l.accountId;

    final payment = LoanPayment(
      id: newId(),
      loanId: l.id,
      date: DateTime.now(),
      amount: payAmount,
      currency: l.currency,
      accountId: useAccount,
      notes: notes,
    );
    await DBHelper.insertLoanPayment(payment);
    if (useAccount != null) {
      await _updateAccountBalance(useAccount, -payAmount); // expense-like debit
    }
    loanPayments = await DBHelper.getAllLoanPayments();
    accounts = await DBHelper.getAccounts();

    // Auto-settle when the loan is fully paid off
    final totalPaid = loanTotalPaid(l) + payAmount;
    if (totalPaid >= l.totalPayable && !l.isSettled) {
      final settled = l.copyWith(isSettled: true);
      await DBHelper.updateLoan(settled);
      loans = await DBHelper.getLoans();
      await _loanNotif.cancelReminder(l.id);
    }
    notifyListeners();
    recordNetWorthSnapshot();
  }

  Future<void> skipLoanInstallment(Loan l, {String notes = 'Skipped'}) async {
    final payment = LoanPayment(
      id: newId(),
      loanId: l.id,
      date: DateTime.now(),
      amount: 0.0,
      currency: l.currency,
      accountId: null,
      notes: notes,
    );
    await DBHelper.insertLoanPayment(payment);
    loanPayments = await DBHelper.getAllLoanPayments();
    notifyListeners();
  }

  Future<void> deleteLoanPayment(String id) async {
    final p = loanPayments.firstWhere((x) => x.id == id);
    if (p.accountId != null) {
      await _updateAccountBalance(p.accountId!, p.amount); // reverse the debit
    }
    await DBHelper.deleteLoanPayment(id);
    loanPayments = await DBHelper.getAllLoanPayments();
    accounts = await DBHelper.getAccounts();
    notifyListeners();
    recordNetWorthSnapshot();
  }

  Future<VoidCallback> deleteLoanPaymentWithUndo(String id) async {
    final p = loanPayments.firstWhere((x) => x.id == id);
    await deleteLoanPayment(id);
    return () async {
      await DBHelper.insertLoanPayment(p);
      if (p.accountId != null) {
        await _updateAccountBalance(p.accountId!, -p.amount);
      }
      loanPayments = await DBHelper.getAllLoanPayments();
      accounts = await DBHelper.getAccounts();
      notifyListeners();
      recordNetWorthSnapshot();
    };
  }

  List<LoanPayment> loanPaymentsFor(String loanId) =>
      loanPayments.where((p) => p.loanId == loanId).toList()
        ..sort((a, b) => b.date.compareTo(a.date));

  double loanTotalPaid(Loan l) =>
      loanPaymentsFor(l.id).fold(0.0, (s, p) => s + p.amount);

  double loanRemaining(Loan l) =>
      (l.totalPayable - loanTotalPaid(l)).clamp(0.0, double.infinity);

  double loanProgress(Loan l) =>
      l.totalPayable <= 0 ? 0.0 : (loanTotalPaid(l) / l.totalPayable).clamp(0.0, 1.0);

  double get totalMonthlyLoanObligation => loans
      .where((l) => !l.isSettled)
      .fold(0.0, (s, l) => s + convertToMain(l.monthlyPayment, l.currency));

  double get totalOutstandingLoanDebt => loans
      .where((l) => !l.isSettled)
      .fold(0.0, (s, l) => s + convertToMain(loanRemaining(l), l.currency));

  // ── Export ────────────────────────────────────────────────────────────
  Future<String?> exportTransactionsExcel({
    required DateTime from,
    required DateTime to,
    String? dialogTitle,
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

    final saveUri = await FilePickerPlatform.instance.saveFile(
      dialogTitle: dialogTitle,
      fileName: fileName,
      bytes: uint8,
      mimeType: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    );
    return saveUri?.toString();
  }

  // ── Backup ────────────────────────────────────────────────────────────
  Future<String?> createBackup({String? dialogTitle}) async {
    final data = await DBHelper.exportAll();
    data['settings'] = settings.toJson();
    final json  = const JsonEncoder.withIndent('  ').convert(data);
    final uint8 = Uint8List.fromList(utf8.encode(json));
    final ts    = DateTime.now().millisecondsSinceEpoch;

    final saveUri = await FilePickerPlatform.instance.saveFile(
      dialogTitle: dialogTitle,
      fileName: 'expensy_backup_$ts.json',
      bytes: uint8,
      mimeType: 'application/json',
    );
    return saveUri?.toString();
  }

  Future<int> restoreBackup() async {
    final pickedFiles = await FilePickerPlatform.instance.pickFiles(
    );
    if (pickedFiles.isEmpty) return 0;
    final picked = pickedFiles.first;
    final ext = picked.extension?.toLowerCase();
    if (ext != 'json') {
      throw const FormatException('Please select a .json file.');
    }

    String jsonStr;
    final path = picked.path;
    if (path != null) {
      jsonStr = await File(path).readAsString();
    } else {
      final bytes = await picked.readAsBytes();
      jsonStr = utf8.decode(bytes);
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
    await _loanNotif.rescheduleAllLoans(loans, settings.currency);
    await CreditReminderService().rescheduleAll(accounts);

    return (data['_originalVersion'] as int?) ?? (data['version'] as int?) ?? 1;
  }

  // ── External Backups ──────────────────────────────────────────────────
  Future<bool> restoreExternalBackup(String source) async {
    final pickedFiles = await FilePickerPlatform.instance.pickFiles(
      type: source == 'greenstash' ? FileType.custom : FileType.any,
      allowedExtensions: source == 'greenstash' ? ['json'] : null,
    );
    if (pickedFiles.isEmpty) return false;

    final ext = pickedFiles.first.extension?.toLowerCase();
    if (source == 'greenstash' && ext != 'json') {
      throw const FormatException('Please select a .json file.');
    }

    final picked = pickedFiles.first;
    String contentStr;
    final path = picked.path;
    if (path != null) {
      contentStr = await File(path).readAsString();
    } else {
      final bytes = await picked.readAsBytes();
      contentStr = utf8.decode(bytes);
    }

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
          if (isDeposit) {
            currentAmount += amt;
          } else {
            currentAmount -= amt;
          }
        }
      }
      sg.currentAmount = currentAmount;
      await DBHelper.updateSavingsGoal(sg);
    }
    await load();
  }

  Future<void> restoreSay(String csvContent) async {
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
  void setTransactionSelectionMode(bool value) {
    if (isTransactionSelectionMode != value) {
      isTransactionSelectionMode = value;
      notifyListeners();
    }
  }
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
    final txSplits = List<TransactionSplit>.from(getSplits(id));
    await deleteTransaction(id);
    return () async {
      await addTransaction(tx);
      if (txSplits.isNotEmpty) {
        await saveTransactionSplits(tx.id, txSplits);
      }
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
