// lib/providers/app_provider.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' hide Border;
import '../models/models.dart';
import 'aggregations.dart';
import '../database/app_database.dart';
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
import '../services/certificate_reminder_service.dart';
import '../services/backup_builder.dart';
import '../services/backup_encryption_service.dart';
import '../services/auto_backup_service.dart';
import '../services/recurring_payment_processor.dart';
import '../services/backup_validator.dart';
import 'package:sqflite/sqflite.dart' as sqflite show getDatabasesPath;
import 'package:path/path.dart' as p;
import 'package:expensy_saf/expensy_saf.dart';
import '../theme/app_theme.dart';
import '../utils/service_localizations.dart';

// Thrown when a cross-currency transaction or transfer is attempted before
// live or cached exchange rates have loaded.
class RatesUnavailableException implements Exception {
  final String? _message;
  const RatesUnavailableException([String? message]) : _message = message;
  String get message =>
      _message ?? ServiceLocalizations.current.transfer_exchangeRatesNotLoaded;
  @override
  String toString() => 'RatesUnavailableException: $message';
}

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
    this.themeMode     = 'system',
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
  List<Account> _accounts = [];
  Map<String, Account> _accountsById = {};
  List<Account> get accounts => _accounts;
  set accounts(List<Account> value) {
    _accounts = value;
    _accountsById = {for (final a in value) a.id: a};
  }

  List<AppCategory> _categories = [];
  Map<String, AppCategory> _categoriesById = {};
  List<AppCategory> get categories => _categories;
  set categories(List<AppCategory> value) {
    _categories = value;
    _categoriesById = {for (final c in value) c.id: c};
  }

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
  int get schemaVersion => AppDatabase.currentSchemaVersion;

  // ── Exchange rates ────────────────────────────────────────────────────
  Map<String, double> exchangeRates = {};
  bool ratesLoaded    = false;
  bool ratesFetching  = false;
  DateTime? ratesLastFetched;

  // ── Recurring history (lazy cache) ────────────────────────────────────
  final Map<String, List<RecurringHistoryEntry>> _historyCache = {};

  List<Loan> loans = [];
  List<LoanPayment> loanPayments = [];
  List<Certificate> certificates = [];

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

  Future<void> _mutationQueue = Future.value();
  static const _mutexZoneKey = #expMutex;

  Future<T> _serializeMutation<T>(Future<T> Function() action) async {
    if (Zone.current[_mutexZoneKey] == true) {
      return await action();
    }
    final completer = Completer<T>();
    _mutationQueue = _mutationQueue.then((_) async {
      try {
        final result = await runZoned(
          () => action(),
          zoneValues: {_mutexZoneKey: true},
        );
        completer.complete(result);
      } catch (e, stack) {
        completer.completeError(e, stack);
      }
    });
    return completer.future;
  }

  // ── Boot ─────────────────────────────────────────────────────────────
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('settings');
    if (raw != null) {
      settings = AppSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    }
    ServiceLocalizations.setLanguageCode(settings.languageCode);
    final results = await Future.wait<dynamic>([
      DBHelper.getAccounts(),
      DBHelper.getCategories(),
      DBHelper.getTransactions(),
      DBHelper.getRecurring(),
      DBHelper.getWishlist(),
      DBHelper.getLendedPeople(),
      DBHelper.getLended(),
      DBHelper.getAssets(),
      DBHelper.getBudgets(),
      DBHelper.getSavingsGoals(),
      DBHelper.getAllSavingsContributions(),
      DBHelper.getLoans(),
      DBHelper.getAllLoanPayments(),
      DBHelper.getNetWorthSnapshots(),
      DBHelper.getRecurringHistoryCount(),
      DBHelper.getPresets(),
      DBHelper.getAllSplits(),
      DBHelper.getCertificates(),
    ]);
    accounts             = results[0] as List<Account>;
    categories           = results[1] as List<AppCategory>;
    transactions         = results[2] as List<AppTransaction>;
    recurring            = results[3] as List<RecurringPayment>;
    wishlist             = results[4] as List<WishlistItem>;
    lendedPeople         = results[5] as List<LendedPerson>;
    lended               = results[6] as List<LendedMoney>;
    assets               = results[7] as List<AssetItem>;
    budgets              = results[8] as List<Budget>;
    savingsGoals         = results[9] as List<SavingsGoal>;
    savingsContributions = results[10] as List<SavingsContribution>;
    loans                = results[11] as List<Loan>;
    loanPayments         = results[12] as List<LoanPayment>;
    netWorthSnapshots    = results[13] as List<NetWorthSnapshot>;
    recurringHistoryCount = results[14] as int;
    presets              = results[15] as List<TransactionPreset>;
    splits               = results[16] as List<TransactionSplit>;
    certificates         = results[17] as List<Certificate>;
    _rebuildSplitsCache();
    _loaded = true;
    notifyListeners();

    try {
      if (settings.dailyReminderEnabled) {
        await _dailyNotif.scheduleDailyReminder(settings.dailyReminderTime);
      } else {
        await _dailyNotif.cancelDailyReminder();
      }
    } catch (_) {}

    _loadRates();
    await _recordNetWorthSnapshot();
    await checkAndProcessAutoPay();
    await checkAndProcessCertificates();
    try {
      await CertificateReminderService().rescheduleAllCertificates(certificates);
    } catch (_) {}
    updateHomeWidgets();
    await refreshAutoBackupState();
    AutoBackupService.runCatchUpIfNeeded();

    startAutoPayTimer();
  }

  /// Schedules a one-shot evaluation timer for the next upcoming auto-pay payment
  /// rather than running a battery-draining continuous 1-minute periodic timer.
  void scheduleNextAutoPayTimer() {
    _autoPayTimer?.cancel();
    _autoPayTimer = null;

    final autoPayItems = recurring.where((r) => r.autoPayEnabled).toList();
    if (autoPayItems.isEmpty) return;

    final now = DateTime.now();
    DateTime? earliestDue;

    for (final item in autoPayItems) {
      final parts = item.autoPayTime.split(':');
      final hour = parts.isNotEmpty ? (int.tryParse(parts[0]) ?? 9) : 9;
      final minute = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;

      final nextD = item.nextDate;
      var candidate = DateTime(nextD.year, nextD.month, nextD.day, hour, minute);
      if (candidate.isBefore(now)) {
        earliestDue = now;
        break;
      }
      if (earliestDue == null || candidate.isBefore(earliestDue)) {
        earliestDue = candidate;
      }
    }

    if (earliestDue != null) {
      final delay = earliestDue.isBefore(now)
          ? Duration.zero
          : earliestDue.difference(now);
      _autoPayTimer = Timer(delay, () async {
        await checkAndProcessAutoPay();
        scheduleNextAutoPayTimer();
      });
    }
  }

  /// Starts evaluation for auto-pay via next-due timer.
  void startAutoPayTimer() => scheduleNextAutoPayTimer();

  /// Pauses the auto-pay timer while the application is in the background or paused to save battery.
  void pauseAutoPayTimer() {
    _autoPayTimer?.cancel();
    _autoPayTimer = null;
  }

  @override
  void dispose() {
    pauseAutoPayTimer();
    _homeWidgetDebounceTimer?.cancel();
    _netWorthDebounceTimer?.cancel();
    super.dispose();
  }

  Timer? _homeWidgetDebounceTimer;

  void updateHomeWidgets() {
    _homeWidgetDebounceTimer?.cancel();
    _homeWidgetDebounceTimer = Timer(const Duration(milliseconds: 750), () {
      _executeWidgetUpdate();
    });
  }

  Future<void> _executeWidgetUpdate() async {
    try {
      final pinnedIds = settings.pinnedWidgetAccountIds;
      final pinnedAccounts = accounts.where((a) => pinnedIds.contains(a.id)).take(3).toList();
      if (pinnedAccounts.isEmpty) {
        pinnedAccounts.addAll(accounts.take(3));
      }
      final accountsJson = jsonEncode(pinnedAccounts.map((a) => {
        'name': a.name,
        'balance': settings.hideBalance
            ? '••••••'
            : formatAmount(a.balance, a.currency.isNotEmpty ? a.currency : settings.currency),
      }).toList());
      await HomeWidget.saveWidgetData('accounts_widget_data', accountsJson);
      await HomeWidget.updateWidget(name: 'AccountsWidgetProvider');

      final budgetData = nonOverlappingBudgets.map((b) {
        final spent = budgetSpent(b);
        final allowance = budgetEffectiveAllowance(b);
        return {
          'category': categoryDisplayName(b.categoryId, fallback: 'Budget'),
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

  Timer? _netWorthDebounceTimer;

  Future<void> _executeRecordNetWorthSnapshot() async {
    await _serializeMutation(() async {
      try {
        final today = DateFormat('yyyy-MM-dd', 'en_US').format(DateTime.now());
        final existing = await DBHelper.getNetWorthSnapshotForDate(today);
        final snap = NetWorthSnapshot(
          id: existing?.id ?? const Uuid().v4(),
          date: today,
          totalAccounts: totalLiquidAccountsValue + totalGoldValue,
          totalAssets:
              totalAssetsValue + totalLentMoneyValue + totalCertificatesValue,
          netWorth: liveNetWorth,
          currency: settings.currency,
        );
        await DBHelper.insertNetWorthSnapshot(snap);
        final idx = netWorthSnapshots.indexWhere((s) => s.date == today);
        final nextSnaps = List<NetWorthSnapshot>.from(netWorthSnapshots);
        if (idx != -1) {
          nextSnaps[idx] = snap;
        } else {
          nextSnaps.add(snap);
          nextSnaps.sort((a, b) => a.date.compareTo(b.date));
        }
        netWorthSnapshots = nextSnaps;
        notifyListeners();
      } catch (e) {
        debugPrint('Error recording net worth snapshot: $e');
      }
    });
  }

  Future<void> recordNetWorthSnapshot() async {
    _netWorthDebounceTimer?.cancel();
    _netWorthDebounceTimer = Timer(const Duration(milliseconds: 300), () async {
      await _executeRecordNetWorthSnapshot();
    });
  }

  Future<void> _recordNetWorthSnapshot() => _executeRecordNetWorthSnapshot();

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

      // 2. If cache is stale (or empty) and cooldown elapsed, fetch fresh in the background.
      final shouldFetch = await _erService.shouldAttemptFetch();
      if (shouldFetch) {
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
    final nextAccounts = List<Account>.from(accounts);
    for (int i = 0; i < nextAccounts.length; i++) {
      final acc = nextAccounts[i];
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
      nextAccounts[i] = updated;
      changed = true;
    }
    if (changed) {
      accounts = nextAccounts;
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
      case 'languageCode':
        settings.languageCode = value as String;
        ServiceLocalizations.setLanguageCode(settings.languageCode);
        break;
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

  /// Effective balance for display: debit cards mirror their parent bank account balance,
  /// other accounts return their stored balance.
  double getEffectiveBalance(Account acc) {
    if (acc.isDebit && acc.linkedAccountId != null) {
      final parent = accountById(acc.linkedAccountId!);
      if (parent != null) {
        return parent.balance;
      }
    }
    return acc.balance;
  }

  /// Display balance for account/card pickers in forms:
  /// - Credit cards with a positive [creditLimit] return [Account.availableCredit].
  /// - Debit cards mirror their parent linked bank account balance.
  /// - All other accounts return their stored [Account.balance].
  double getPickerDisplayBalance(Account acc) {
    if (acc.isCredit && (acc.creditLimit ?? 0) > 0) {
      return acc.availableCredit;
    }
    return getEffectiveBalance(acc);
  }

  /// Signed net total balance across all active accounts (liquid assets minus credit debt).
  /// Debit cards are excluded to prevent double-counting their linked bank account funds.
  double get totalBalance {
    double sum = 0.0;
    for (final a in accounts) {
      if (a.isDebit) continue;
      if (a.excludeFromTotal || a.excludeFromBankTotal) continue;
      sum += convertToMain(a.balance, a.currency);
    }
    return sum;
  }

  double get totalBalanceAll {
    double sum = 0.0;
    for (final a in accounts) {
      if (a.isDebit) continue;
      sum += convertToMain(a.balance, a.currency);
    }
    return sum;
  }

  // ── Wealth Management & Net Worth Helpers ──────────────────────────────

  /// Liquid Cash and Bank accounts with positive balances converted to main currency,
  /// honoring excludeFromTotal and excluding credit/debit cards.
  double get totalLiquidAccountsValue => accounts
      .where((a) => a.balance > 0 && !a.isGold && !a.isDebit && !a.isCredit && !a.excludeFromTotal && !a.excludeFromBankTotal)
      .fold(0.0, (sum, a) => sum + convertToMain(a.balance, a.currency));

  /// Physical Gold holding value converted to main currency.
  double get totalGoldValue => accounts
      .where((a) => a.balance > 0 && a.isGold)
      .fold(0.0, (sum, a) => sum + convertToMain(a.balance, a.currency));

  /// Active Time Deposits & Certificates value converted to main currency.
  double get totalCertificatesValue => certificates
      .where((c) => !c.isSettled)
      .fold(0.0, (sum, c) => sum + convertToMain(c.amount, c.currency));

  /// Unsettled money lent to others (receivables) converted to main currency.
  double get totalLentMoneyValue => lended
      .where((l) => !l.isSettled && l.type == 'lent')
      .fold(0.0, (sum, l) {
        final cur = l.accountId != null
            ? (accountById(l.accountId!)?.currency ?? settings.currency)
            : settings.currency;
        return sum + convertToMain(l.amount, cur);
      });

  /// Total combined assets: liquid accounts + gold + fixed/investment assets + certificates + lent money.
  double get totalWealthAssets =>
      totalLiquidAccountsValue +
      totalGoldValue +
      totalAssetsValue +
      totalCertificatesValue +
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

  Account? accountById(String id) => _accountsById[id];

  AppCategory get transferCategory =>
      _categoriesById['sys_transfer'] ??
      AppCategory(
        id: 'sys_transfer',
        name: 'Transfer',
        type: 'transfer',
        colorValue: 0xFF4CAF50,
      );

  AppCategory? categoryById(String id) {
    if (id == 'sys_transfer') return transferCategory;
    return _categoriesById[id];
  }

  /// User-editable categories (excludes hidden system categories like sys_transfer).
  List<AppCategory> get userCategories =>
      categories.where((c) => !c.isSystem).toList();

  /// Top-level categories for [type] ('expense' | 'income').
  List<AppCategory> rootCategoriesForType(String type) =>
      categories.where((c) => !c.isSystem && c.type == type && !c.isSubcategory).toList();

  /// Child subcategories belonging to [parentId].
  List<AppCategory> subcategoriesOf(String parentId) =>
      categories.where((c) => !c.isSystem && c.parentId == parentId).toList();

  /// Resolves [categoryId] to its root parent category ID (or itself if root).
  String rootCategoryIdOf(String categoryId) {
    final cat = categoryById(categoryId);
    if (cat == null) return categoryId;
    return (cat.parentId != null && cat.parentId!.isNotEmpty)
        ? cat.parentId!
        : cat.id;
  }

  /// Resolves [categoryId] to its root parent [AppCategory].
  AppCategory? rootCategoryOf(String categoryId) =>
      categoryById(rootCategoryIdOf(categoryId));

  /// Returns [categoryId] plus all of its child subcategory IDs.
  Set<String> categoryFamilyIds(String categoryId) {
    final ids = <String>{categoryId};
    for (final c in categories) {
      if (c.parentId == categoryId) ids.add(c.id);
    }
    return ids;
  }

  /// Localizes a seeded default category or subcategory when its name still
  /// matches the original English default; preserves custom user-renamed names.
  static String localizeCategoryName(AppCategory cat, AppLocalizations loc) {
    final lower = cat.name.trim();
    switch (cat.id) {
      case 'food_exp':
        if (lower == 'Food & Dining') return loc.cat_food_exp;
      case 'transport':
        if (lower == 'Transport') return loc.cat_transport;
      case 'shopping':
        if (lower == 'Shopping') return loc.cat_shopping;
      case 'bills':
        if (lower == 'Bills & Utilities') return loc.cat_bills;
      case 'health':
        if (lower == 'Health') return loc.cat_health;
      case 'entertainment':
        if (lower == 'Entertainment') return loc.cat_entertainment;
      case 'education':
        if (lower == 'Education') return loc.cat_education;
      case 'personal':
        if (lower == 'Personal Care') return loc.cat_personal;
      case 'salary':
        if (lower == 'Salary') return loc.cat_salary;
      case 'freelance':
        if (lower == 'Freelance') return loc.cat_freelance;
      case 'investments':
        if (lower == 'Investments') return loc.cat_investments;
      case 'gifts':
        if (lower == 'Gifts') return loc.cat_gifts;
      case 'other_inc':
        if (lower == 'Other Income') return loc.cat_other_inc;
      case 'other_exp':
        if (lower == 'Other Expense') return loc.cat_other_exp;
      case 'sys_transfer':
        if (lower == 'Transfer') return loc.cat_sys_transfer;
      case 'sys_investment':
        if (lower == 'Investment') return loc.cat_sys_investment;
      case 'sub_food_exp_groceries':
        if (lower == 'Groceries') return loc.sub_groceries;
      case 'sub_food_exp_restaurants':
        if (lower == 'Restaurants') return loc.sub_restaurants;
      case 'sub_food_exp_delivery':
        if (lower == 'Delivery') return loc.sub_delivery;
      case 'sub_food_exp_coffee_tea':
        if (lower == 'Coffee & Tea') return loc.sub_coffee_tea;
      case 'sub_transport_fuel':
        if (lower == 'Fuel') return loc.sub_fuel;
      case 'sub_transport_public_transit':
        if (lower == 'Public Transit') return loc.sub_public_transit;
      case 'sub_transport_taxi_ride':
        if (lower == 'Taxi & Ride') return loc.sub_taxi_ride;
      case 'sub_transport_maintenance':
        if (lower == 'Maintenance') return loc.sub_maintenance;
      case 'sub_transport_parking_tolls':
        if (lower == 'Parking & Tolls') return loc.sub_parking_tolls;
      case 'sub_shopping_clothing':
        if (lower == 'Clothing') return loc.sub_clothing;
      case 'sub_shopping_electronics':
        if (lower == 'Electronics') return loc.sub_electronics;
      case 'sub_shopping_home_furniture':
        if (lower == 'Home & Furniture') return loc.sub_home_furniture;
      case 'sub_shopping_gifts':
        if (lower == 'Gifts') return loc.sub_gifts;
      case 'sub_bills_electricity':
        if (lower == 'Electricity') return loc.sub_electricity;
      case 'sub_bills_internet':
        if (lower == 'Internet') return loc.sub_internet;
      case 'sub_bills_water':
        if (lower == 'Water') return loc.sub_water;
      case 'sub_bills_phone':
        if (lower == 'Phone') return loc.sub_phone;
      case 'sub_health_medicine':
        if (lower == 'Medicine') return loc.sub_medicine;
      case 'sub_health_doctor':
        if (lower == 'Doctor') return loc.sub_doctor;
      case 'sub_entertainment_movies':
        if (lower == 'Movies') return loc.sub_movies;
      case 'sub_entertainment_games':
        if (lower == 'Games') return loc.sub_games;
      case 'sub_entertainment_subscriptions':
        if (lower == 'Subscriptions') return loc.sub_subscriptions;
    }
    return cat.name;
  }

  /// Instance convenience wrapper using active [AppLocalizations].
  String localizedCategoryName(AppCategory cat, [AppLocalizations? l10n]) =>
      localizeCategoryName(cat, l10n ?? ServiceLocalizations.current);

  /// Returns "Parent › Subcategory" for subcategories, or "Category" for roots.
  String categoryDisplayName(String categoryId,
      {String fallback = '', AppLocalizations? l10n}) {
    final loc = l10n ?? ServiceLocalizations.current;
    final cat = categoryById(categoryId);
    if (cat == null) return fallback;
    final catLabel = localizeCategoryName(cat, loc);
    if (cat.isSubcategory) {
      final parent = categoryById(cat.parentId!);
      if (parent != null) {
        return '${localizeCategoryName(parent, loc)} › $catLabel';
      }
    }
    return catLabel;
  }

  /// Seeds curated default subcategories under matching default parent categories.
  /// Returns the number of newly created subcategories.
  Future<int> seedDefaultSubcategories() async {
    return await _serializeMutation(() async {
      const defaults = <String, List<String>>{
        'food_exp': ['Groceries', 'Restaurants', 'Delivery', 'Coffee & Tea'],
        'transport': ['Fuel', 'Public Transit', 'Taxi & Ride', 'Maintenance', 'Parking & Tolls'],
        'shopping': ['Clothing', 'Electronics', 'Home & Furniture', 'Gifts'],
        'bills': ['Electricity', 'Internet', 'Water', 'Phone'],
        'health': ['Medicine', 'Doctor'],
        'entertainment': ['Movies', 'Games', 'Subscriptions'],
      };

      int added = 0;
      int nextOrder = categories.length;
      for (final entry in defaults.entries) {
        final parent = categories.where((c) => c.id == entry.key).firstOrNull;
        if (parent == null) continue;
        final existingNames = categories
            .where((c) => c.parentId == parent.id)
            .map((c) => c.name.toLowerCase())
            .toSet();
        for (final subName in entry.value) {
          if (existingNames.contains(subName.toLowerCase())) continue;
          final slug = subName.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_');
          final sub = AppCategory(
            id: 'sub_${parent.id}_$slug',
            name: subName,
            type: parent.type,
            colorValue: parent.colorValue,
            iconCodePoint: 0,
            orderIndex: nextOrder++,
            parentId: parent.id,
          );
          await DBHelper.insertCategory(sub);
          added++;
        }
      }
      if (added > 0) {
        categories = await DBHelper.getCategories();
        notifyListeners();
      }
      return added;
    });
  }

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
    await _serializeMutation(() async {
      await DBHelper.insertAccount(a);
      accounts = await DBHelper.getAccounts();
      if (a.type == 'credit' && a.creditReminderEnabled) {
        await CreditReminderService().scheduleReminder(a);
      }
      notifyListeners();
      updateHomeWidgets();
      recordNetWorthSnapshot();
    });
  }

  Future<void> updateAccount(Account a) async {
    await _serializeMutation(() async {
      final old = accountById(a.id);
      final balanceDelta = old != null ? (a.balance - old.balance) : null;
      await DBHelper.updateAccount(a, balanceDelta: balanceDelta);
      accounts = await DBHelper.getAccounts();
      if (a.dontLinkToCard) {
        final linkedCards =
            accounts.where((acc) => acc.linkedAccountId == a.id).toList();
        for (final card in linkedCards) {
          await DBHelper.updateAccount(
            card.copyWith(clearLinkedAccount: true),
            balanceDelta: 0.0,
          );
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
    });
  }

  /// Resolves the balance-holding account id for mutations.
  /// Debit cards redirect balance mutations to their parent linked bank account.
  String balanceAccountIdFor(String accountId) {
    final acc = accountById(accountId);
    if (acc != null && acc.isDebit && acc.linkedAccountId != null && acc.linkedAccountId!.isNotEmpty) {
      return acc.linkedAccountId!;
    }
    return accountId;
  }

  String? getAccountDeletionBlockReason(String id, [AppLocalizations? l10n]) {
    final activeRecurring = recurring
        .where((r) => r.accountId == id || r.toAccountId == id)
        .length;
    if (activeRecurring > 0) {
      return l10n?.accounts_blockDeleteRecurring(activeRecurring) ??
          'Account has $activeRecurring active recurring payments. Please reassign or delete them first.';
    }
    final activeLoans = loans
        .where((l) => l.accountId == id || l.transferAccountId == id)
        .length;
    if (activeLoans > 0) {
      return l10n?.accounts_blockDeleteLoans(activeLoans) ??
          'Account has $activeLoans active loans. Please reassign or delete them first.';
    }
    final activeCerts =
        certificates.where((c) => c.accountId == id && !c.isSettled).length;
    if (activeCerts > 0) {
      return l10n?.accounts_blockDeleteCertificates(activeCerts) ??
          'Account has $activeCerts active certificates. Please redeem or delete them first.';
    }
    final activeLended =
        lended.where((l) => l.accountId == id && !l.isSettled).length;
    if (activeLended > 0) {
      return l10n?.accounts_blockDeleteLended(activeLended) ??
          'Account has $activeLended unsettled lend/borrow records. Please settle them first.';
    }
    final usedContribs =
        savingsContributions.where((s) => s.accountId == id).length;
    if (usedContribs > 0) {
      return l10n?.accounts_blockDeleteSavings(usedContribs) ??
          'Account is referenced by $usedContribs savings contributions. Please reassign or delete them first.';
    }
    final usedPresets = presets
        .where((p) => p.accountId == id || p.toAccountId == id)
        .length;
    if (usedPresets > 0) {
      return l10n?.accounts_blockDeletePresets(usedPresets) ??
          'Account is used by $usedPresets transaction presets. Please reassign or delete them first.';
    }
    final linkedCards = accounts.where((a) => a.linkedAccountId == id).length;
    if (linkedCards > 0) {
      return l10n?.accounts_blockDeleteCards(linkedCards) ??
          'Account is linked to $linkedCards cards. Please unlink or delete them first.';
    }
    return null;
  }

  Future<VoidCallback> deleteAccountWithUndo(String id) async {
    final a = accounts.firstWhere((acc) => acc.id == id);
    final txs = transactions.where((t) => t.accountId == id).toList();
    final txIds = txs.map((t) => t.id).toSet();
    final attachedSplits =
        splits.where((s) => txIds.contains(s.transactionId)).toList();

    await deleteAccount(id);

    return () async {
      await _serializeMutation(() async {
        await DBHelper.restoreAccountSnapshot(
          a,
          txs,
          attachedSplits,
        );
        accounts = [...accounts, a];
        final nextTxs = [...transactions, ...txs]
          ..sort((x, y) => y.date.compareTo(x.date));
        transactions = nextTxs;
        splits = [...splits, ...attachedSplits];
        _rebuildSplitsCache();
        notifyListeners();
        updateHomeWidgets();
        recordNetWorthSnapshot();
      });
    };
  }

  Future<void> deleteAccount(String id) async {
    await _serializeMutation(() async {
      await CreditReminderService().cancelReminder(id);
      await DBHelper.deleteAccountCascade(id);
      accounts = accounts.where((a) => a.id != id).toList();
      final txIds = transactions
          .where((t) => t.accountId == id)
          .map((t) => t.id)
          .toSet();
      transactions = transactions.where((t) => t.accountId != id).toList();
      splits = splits.where((s) => !txIds.contains(s.transactionId)).toList();
      _rebuildSplitsCache();

      if (settings.pinnedWidgetAccountIds.contains(id)) {
        settings.pinnedWidgetAccountIds.remove(id);
        _saveSettings();
      }

      notifyListeners();
      updateHomeWidgets();
      recordNetWorthSnapshot();
    });
  }

  Future<void> _updateAccountBalance(String id, double delta) async {
    final targetId = balanceAccountIdFor(id);
    final acc = accountById(targetId);
    if (acc == null || acc.isGold || delta == 0) return;
    await DBHelper.applyBalanceDelta(targetId, delta);
    _patchAccountBalance(targetId, delta);
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

    // Isolate statement window vs unbilled post-statement charges (B11)
    double unbilledNetExpenses = 0.0;

    final cardTxs = transactions.where((t) => t.accountId == acc.id);
    final stmtEnd = DateTime(statementDate.year, statementDate.month,
        statementDate.day, 23, 59, 59, 999);

    for (final t in cardTxs) {
      if (t.isTransfer || t.isInvestment) continue;
      final sign = t.type == 'expense' ? 1.0 : -1.0;
      final amt = convertBetween(t.amount,
              t.currency.isEmpty ? acc.currency : t.currency, acc.currency) ??
          t.amount;
      final delta = amt * sign;

      if (t.date.isAfter(stmtEnd)) {
        unbilledNetExpenses += delta;
      }
    }

    double statementBalance = 0.0;
    double unbilledBalance = 0.0;

    if (isFullyPaid) {
      statementBalance = 0.0;
      unbilledBalance = 0.0;
    } else {
      unbilledBalance = unbilledNetExpenses.clamp(0.0, debt);
      // Statement balance includes both current-cycle net flow and any unpaid
      // remainder carried over from previous statements.
      statementBalance = (debt - unbilledBalance).clamp(0.0, debt);
    }

    double minPayment = 0.0;
    if (!isFullyPaid) {
      if (acc.minPaymentAmount != null && acc.minPaymentAmount! > 0) {
        minPayment = math.min(acc.minPaymentAmount!, debt);
      } else if (acc.minPaymentPercent != null &&
          acc.minPaymentPercent! > 0) {
        minPayment = math.min(
          math.max(debt * (acc.minPaymentPercent! / 100.0), 25.0),
          debt,
        );
      } else {
        minPayment = math.min(math.max(debt * 0.05, 25.0), debt);
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

  // Resolves the effective currency of transaction [t]: explicit [t.currency],
  // else the source/balance account's currency, else the global app currency.
  String txCurrency(AppTransaction t) {
    if (t.currency.isNotEmpty) return t.currency;
    final srcAcc = accountById(t.paidViaAccountId ?? t.accountId) ??
        accountById(balanceAccountIdFor(t.accountId));
    return srcAcc?.currency ?? settings.currency;
  }

  // Computes the signed balance delta in the balance-holding account's currency.
  // When [requireRates] is true, throws [RatesUnavailableException] if a
  // cross-currency conversion is required while [exchangeRates] is unavailable.
  double _txDelta(
    AppTransaction t, {
    bool reverse = false,
    bool requireRates = false,
  }) {
    final balAccId = balanceAccountIdFor(t.accountId);
    final balAcc = accountById(balAccId);
    final accCurrency = balAcc?.currency ?? settings.currency;
    final effTxCurrency = txCurrency(t);

    double amount = t.amount;
    if (effTxCurrency != accCurrency) {
      if (exchangeRates.isEmpty) {
        if (requireRates) throw const RatesUnavailableException();
      } else {
        final converted =
            _erService.convert(amount, effTxCurrency, accCurrency, exchangeRates);
        if (converted == null) {
          if (requireRates) throw const RatesUnavailableException();
        } else {
          amount = converted;
        }
      }
    }
    final sign = t.type == 'income' ? 1.0 : -1.0;
    return (reverse ? -sign : sign) * amount;
  }

  void _patchAccountBalance(String accountId, double delta) {
    final idx = accounts.indexWhere((a) => a.id == accountId);
    if (idx != -1) {
      final a = accounts[idx];
      if (a.isGold) return;
      final next = List<Account>.from(accounts);
      next[idx] = a.copyWith(balance: a.balance + delta);
      accounts = next;
    }
  }

  void _insertTransactionInMemory(AppTransaction t) {
    final next = List<AppTransaction>.from(transactions);
    next.add(t);
    next.sort((a, b) => b.date.compareTo(a.date));
    transactions = next;
  }

  void _updateTransactionInMemory(AppTransaction t) {
    final next = List<AppTransaction>.from(transactions);
    final idx = next.indexWhere((existing) => existing.id == t.id);
    if (idx != -1) {
      next[idx] = t;
      next.sort((a, b) => b.date.compareTo(a.date));
      transactions = next;
    } else {
      _insertTransactionInMemory(t);
    }
  }

  Future<void> addTransaction(
    AppTransaction t, {
    List<TransactionSplit>? splits,
  }) async {
    await _serializeMutation(() async {
      final delta = _txDelta(t, requireRates: true);
      final balanceAccountId = balanceAccountIdFor(t.accountId);
      final normalizedCurrency = txCurrency(t);
      final txToSave = balanceAccountId != t.accountId
          ? t.copyWith(
              accountId: balanceAccountId,
              paidViaAccountId: t.paidViaAccountId ?? t.accountId,
              currency: normalizedCurrency,
            )
          : (t.currency.isEmpty ? t.copyWith(currency: normalizedCurrency) : t);

      await DBHelper.applyTransactionWithBalance(txToSave, delta);
      if (splits != null) {
        await DBHelper.saveTransactionSplits(txToSave.id, splits);
        this.splits = await DBHelper.getAllSplits();
        _rebuildSplitsCache();
      }

      _patchAccountBalance(balanceAccountId, delta);
      _insertTransactionInMemory(txToSave);

      notifyListeners();
      await _checkBudgetAlert(txToSave);
      updateHomeWidgets();
      recordNetWorthSnapshot();
    });
  }

  Future<void> updateTransaction(
    AppTransaction updated,
    AppTransaction original, {
    List<TransactionSplit>? splits,
  }) async {
    await _serializeMutation(() async {
      final oldDelta = _txDelta(original, reverse: true);
      final newDelta = _txDelta(updated, requireRates: true);

      final oldBalanceAccId = balanceAccountIdFor(original.accountId);
      final newBalanceAccId = balanceAccountIdFor(updated.accountId);
      final normalizedCurrency = txCurrency(updated);

      // Enforce 'sys_transfer' and preserve transferGroupId on transfer legs.
      final isTransferTx = original.isTransfer || updated.isTransfer;
      final enforcedUpdated = isTransferTx
          ? updated.copyWith(
              categoryId: 'sys_transfer',
              transferGroupId: original.transferGroupId ?? updated.transferGroupId,
            )
          : updated;

      final txToSave = newBalanceAccId != enforcedUpdated.accountId
          ? enforcedUpdated.copyWith(
              accountId: newBalanceAccId,
              paidViaAccountId:
                  enforcedUpdated.paidViaAccountId ?? enforcedUpdated.accountId,
              currency: normalizedCurrency,
            )
          : (enforcedUpdated.currency.isEmpty
              ? enforcedUpdated.copyWith(currency: normalizedCurrency)
              : enforcedUpdated);

      await DBHelper.applyTransactionEdit(
        updated: txToSave,
        oldAccountId: oldBalanceAccId,
        oldDelta: oldDelta,
        newAccountId: newBalanceAccId,
        newDelta: newDelta,
      );
      if (splits != null) {
        await DBHelper.saveTransactionSplits(txToSave.id, splits);
        this.splits = await DBHelper.getAllSplits();
        _rebuildSplitsCache();
      }

      if (oldBalanceAccId == newBalanceAccId) {
        _patchAccountBalance(oldBalanceAccId, oldDelta + newDelta);
      } else {
        _patchAccountBalance(oldBalanceAccId, oldDelta);
        _patchAccountBalance(newBalanceAccId, newDelta);
      }

      _updateTransactionInMemory(txToSave);
      notifyListeners();
      await _checkBudgetAlert(txToSave);
      updateHomeWidgets();
      recordNetWorthSnapshot();
    });
  }

  final Set<String> _alertedBudgetPeriods = {};

  // Keys budget alert deduplication off the exact period start date (C7).
  String _budgetPeriodKey(Budget b, [DateTime? referenceDate]) {
    final start = getCurrentPeriodStart(b, referenceDate);
    return '${b.id}_${start.year}_${start.month}_${start.day}';
  }

  Future<void> _checkBudgetAlert(AppTransaction t) async {
    if (!settings.budgetAlertsEnabled) return;
    if (t.type != 'expense' || t.isTransfer || t.isInvestment) return;

    final candidateCatIds = <String>{};
    if (isTransactionSplit(t.id)) {
      for (final s in getSplits(t.id)) {
        candidateCatIds.add(s.categoryId);
        final parentId = categoryById(s.categoryId)?.parentId;
        if (parentId != null && parentId.isNotEmpty) {
          candidateCatIds.add(parentId);
        }
      }
    } else {
      candidateCatIds.add(t.categoryId);
      final parentId = categoryById(t.categoryId)?.parentId;
      if (parentId != null && parentId.isNotEmpty) {
        candidateCatIds.add(parentId);
      }
    }

    for (final catId in candidateCatIds) {
      final b = budgetForCategory(catId);
      if (b == null || !budgetExceeded(b)) continue;
      final pKey = _budgetPeriodKey(b);
      if (_alertedBudgetPeriods.contains(pKey)) continue;
      final cat = categoryById(catId);
      if (cat == null) continue;
      _alertedBudgetPeriods.add(pKey);
      await _budgetNotif.showBudgetExceeded(
        b,
        cat.copyWith(name: categoryDisplayName(cat.id)),
        budgetSpent(b),
        budgetEffectiveAllowance(b),
      );
    }
  }

  Future<void> deleteTransaction(String id) async {
    await _serializeMutation(() async {
      final t = transactions.where((x) => x.id == id).firstOrNull;
      if (t != null) {
        if (t.transferGroupId != null && t.transferGroupId!.isNotEmpty) {
          final pair = transactions
              .where((tx) => tx.transferGroupId == t.transferGroupId)
              .toList();
          for (final member in pair) {
            final delta = _txDelta(member, reverse: true);
            final balAccId = balanceAccountIdFor(member.accountId);
            await DBHelper.applyDeleteTransactionWithBalance(
                member.id, balAccId, delta);
            _patchAccountBalance(balAccId, delta);
            splits.removeWhere((s) => s.transactionId == member.id);
            _splitsByTxId.remove(member.id);
          }
          transactions = transactions
              .where((tx) => tx.transferGroupId != t.transferGroupId)
              .toList();
          notifyListeners();
          updateHomeWidgets();
          recordNetWorthSnapshot();
          return;
        }

        final delta = _txDelta(t, reverse: true);
        final balAccId = balanceAccountIdFor(t.accountId);
        await DBHelper.applyDeleteTransactionWithBalance(
            t.id, balAccId, delta);
        _patchAccountBalance(balAccId, delta);
      } else {
        await DBHelper.deleteTransaction(id);
      }

      splits.removeWhere((s) => s.transactionId == id);
      _splitsByTxId.remove(id);
      transactions = transactions.where((tx) => tx.id != id).toList();
      notifyListeners();
      updateHomeWidgets();
      recordNetWorthSnapshot();
    });
  }

  Future<AppTransaction?> addTransfer({
    required String fromId,
    required String toId,
    required double fromAmount,
    double? toAmount,
    String note = '',
    String? title,
    DateTime? date,
  }) async {
    if (fromId == toId || fromAmount <= 0) return null;
    return await _serializeMutation<AppTransaction?>(() async {
      final effFromId = balanceAccountIdFor(fromId);
      final effToId = balanceAccountIdFor(toId);
      if (effFromId == effToId) return null;

      final fromAcc = accountById(effFromId);
      final toAcc   = accountById(effToId);
      final fromCurrency = fromAcc?.currency ?? settings.currency;
      final toCurrency   = toAcc?.currency   ?? settings.currency;

      final double creditAmount;
      if (toAmount != null && toAmount > 0) {
        creditAmount = toAmount;
      } else if (fromCurrency == toCurrency) {
        creditAmount = fromAmount;
      } else {
        if (exchangeRates.isEmpty) {
          throw const RatesUnavailableException();
        }
        final converted = convertBetween(fromAmount, fromCurrency, toCurrency);
        if (converted == null) {
          throw const RatesUnavailableException();
        }
        creditAmount = converted;
      }

      final txDate = date ?? DateTime.now();
      const catId = 'sys_transfer';
      final transferGroupId = newId();
      final cleanTitle = title?.trim() ?? '';
      final outDesc = cleanTitle.isNotEmpty
          ? '$cleanTitle (Transfer out)'
          : 'Transfer out';
      final inDesc = cleanTitle.isNotEmpty
          ? '$cleanTitle (Transfer in)'
          : 'Transfer in';

      final debit = AppTransaction(
        id: newId(),
        type: 'expense',
        amount: fromAmount,
        description: outDesc,
        accountId: effFromId,
        paidViaAccountId: effFromId != fromId ? fromId : null,
        categoryId: catId,
        date: txDate,
        note: note,
        currency: fromCurrency,
        transferGroupId: transferGroupId,
      );
      final credit = AppTransaction(
        id: newId(),
        type: 'income',
        amount: creditAmount,
        description: inDesc,
        accountId: effToId,
        paidViaAccountId: effToId != toId ? toId : null,
        categoryId: catId,
        date: txDate,
        note: note,
        currency: toCurrency,
        transferGroupId: transferGroupId,
      );

      await DBHelper.applyTransferWithBalances(
        debit,
        credit,
        -fromAmount,
        creditAmount,
      );

      _patchAccountBalance(effFromId, -fromAmount);
      _patchAccountBalance(effToId, creditAmount);
      _insertTransactionInMemory(debit);
      _insertTransactionInMemory(credit);

      notifyListeners();
      updateHomeWidgets();
      recordNetWorthSnapshot();
      return debit;
    });
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
    presets = presets.where((p) => p.id != id).toList();
    notifyListeners();
  }

  /// 1-Tap Log a Transaction or Transfer from a Preset for the current time.
  Future<AppTransaction> logPreset(TransactionPreset preset) async {
    if (preset.isTransfer &&
        preset.toAccountId != null &&
        preset.toAccountId!.isNotEmpty) {
      final debit = await addTransfer(
        fromId: preset.accountId,
        toId: preset.toAccountId!,
        fromAmount: preset.amount,
        toAmount: preset.toAmount,
        note: preset.note,
        title: preset.title,
      );
      if (debit != null) return debit;
    }

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
    await _serializeMutation(() async {
      await DBHelper.saveTransactionSplits(transactionId, newSplits);
      splits = await DBHelper.getAllSplits();
      _rebuildSplitsCache();
      notifyListeners();
    });
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

  Future<void> markRecurringPaid(RecurringPayment r, {DateTime? occurrenceDate}) async {
    await _serializeMutation(() async {
      final effectiveDate = occurrenceDate ?? r.nextDate;
      // Idempotency guard (B10): skip if this cycle date was already paid (e.g. by auto-pay)
      final processor = RecurringPaymentProcessor(AppDatabase.instance);
      if (await processor.hasHistoryForDate(r.id, effectiveDate, action: 'paid')) {
        return;
      }

      final txDate = occurrenceDate ?? DateTime.now();
      if (r.isTransfer) {
        if (r.toAccountId == null || r.toAccountId!.isEmpty) return;
        await addTransfer(
          fromId: r.accountId,
          toId: r.toAccountId!,
          fromAmount: r.amount,
          toAmount: r.toAmount,
          note: r.notes,
          title: r.name,
          date: txDate,
        );
      } else {
        final t = AppTransaction(
          id: newId(),
          type: r.paymentType,
          amount: r.amount,
          description: '${r.name} (recurring)',
          accountId: r.accountId,
          categoryId: r.categoryId,
          date: txDate,
        );
        await addTransaction(t);
      }
      await _recordHistory(r, 'paid', date: effectiveDate);

      final updated = r.copyWith(
        nextDate: r.calcNextDate(),
        paidPayments: r.paidPayments + 1,
      );
      await DBHelper.updateRecurring(updated);
      final idx = recurring.indexWhere((item) => item.id == r.id);
      if (idx != -1) {
        final nextRec = List<RecurringPayment>.from(recurring);
        nextRec[idx] = updated;
        recurring = nextRec;
      }
      notifyListeners();
      await _notif.cancelReminder(r.id);
      await _notif.scheduleReminder(updated, settings.currency);
    });
  }

  Future<void> skipNextRecurring(RecurringPayment r) async {
    await _serializeMutation(() async {
      final processor = RecurringPaymentProcessor(AppDatabase.instance);
      if (await processor.hasHistoryForDate(r.id, r.nextDate)) {
        return;
      }
      await _recordHistory(r, 'skipped', date: r.nextDate);

      final updated = r.copyWith(
        nextDate: r.calcNextDate(),
        paidPayments: r.paidPayments + 1,
      );
      await DBHelper.updateRecurring(updated);
      final idx = recurring.indexWhere((item) => item.id == r.id);
      if (idx != -1) {
        final nextRec = List<RecurringPayment>.from(recurring);
        nextRec[idx] = updated;
        recurring = nextRec;
      }
      notifyListeners();
      await _notif.cancelReminder(r.id);
      await _notif.scheduleReminder(updated, settings.currency);
    });
  }

  /// Automatically marks any recurring items paid if they are due today or overdue
  /// and have auto-pay enabled using the shared RecurringPaymentProcessor.
  Future<void> checkAndProcessAutoPay() async {
    await _serializeMutation(() async {
      final processor = RecurringPaymentProcessor(AppDatabase.instance);
      final processed = await processor.processDuePayments();
      if (processed.isNotEmpty) {
        transactions = await DBHelper.getTransactions();
        accounts = await DBHelper.getAccounts();
        recurring = await DBHelper.getRecurring();
        _historyCache.clear();
        recurringHistoryCount = await DBHelper.getRecurringHistoryCount();
        notifyListeners();
        recordNetWorthSnapshot();
      }
    });
  }

  // ── Recurring History ─────────────────────────────────────────────────

  Future<void> _recordHistory(RecurringPayment r, String action,
      {DateTime? date}) async {
    final acct = accountById(r.accountId);
    final entry = RecurringHistoryEntry(
      id: newId(),
      recurringId: r.id,
      action: action,
      date: date ?? DateTime.now(),
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
  /// them, cancelling any pending reminders first, and reversing unsettled balances.
  Future<void> deleteLendedPerson(String id) async {
    await _serializeMutation(() async {
      for (final l in lended.where((l) => l.personId == id)) {
        await _lendedNotif.cancelLendedReminder(l.id);
        if (l.accountId != null && !l.isSettled) {
          final delta = -_lendedBalanceEffect(l);
          if (delta != 0) {
            final target = balanceAccountIdFor(l.accountId!);
            await DBHelper.applyBalanceDelta(target, delta);
          }
        }
      }
      await DBHelper.deleteLendedForPerson(id);
      await DBHelper.deleteLendedPerson(id);
      lended       = await DBHelper.getLended();
      lendedPeople = await DBHelper.getLendedPeople();
      accounts     = await DBHelper.getAccounts();
      notifyListeners();
      recordNetWorthSnapshot();
    });
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

  double _lendedBalanceEffect(LendedMoney entry) {
    if (entry.isSettled) return 0.0;
    return entry.type == 'lent' ? -entry.amount : entry.amount;
  }

  // ── Lended Money (ledger entries) ───────────────────────────────────────
  Future<void> addLended(LendedMoney l) async {
    await _serializeMutation(() async {
      await DBHelper.insertLended(l);
      if (l.accountId != null) {
        final delta = _lendedBalanceEffect(l);
        if (delta != 0) {
          final target = balanceAccountIdFor(l.accountId!);
          await DBHelper.applyBalanceDelta(target, delta);
        }
      }
      lended   = await DBHelper.getLended();
      accounts = await DBHelper.getAccounts();
      notifyListeners();
      recordNetWorthSnapshot();
      if (l.reminderEnabled && l.dueDate != null) {
        await _lendedNotif.scheduleLendedReminder(l, settings.currency,
            personName: personById(l.personId)?.name ?? '');
      }
    });
  }

  Future<void> updateLended(LendedMoney updated, LendedMoney original) async {
    await _serializeMutation(() async {
      final oldEffect = _lendedBalanceEffect(original);
      final newEffect = _lendedBalanceEffect(updated);
      final oldAcc = original.accountId != null ? balanceAccountIdFor(original.accountId!) : null;
      final newAcc = updated.accountId != null ? balanceAccountIdFor(updated.accountId!) : null;

      if (oldAcc != null && oldAcc == newAcc) {
        final netDelta = newEffect - oldEffect;
        if (netDelta != 0) {
          await DBHelper.applyBalanceDelta(oldAcc, netDelta);
        }
      } else {
        if (oldAcc != null && oldEffect != 0) {
          await DBHelper.applyBalanceDelta(oldAcc, -oldEffect);
        }
        if (newAcc != null && newEffect != 0) {
          await DBHelper.applyBalanceDelta(newAcc, newEffect);
        }
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
    });
  }

  Future<void> settleLended(LendedMoney l) async {
    await _serializeMutation(() async {
      if (l.accountId != null && !l.isSettled) {
        final delta = -_lendedBalanceEffect(l);
        if (delta != 0) {
          final target = balanceAccountIdFor(l.accountId!);
          await DBHelper.applyBalanceDelta(target, delta);
        }
      }
      final settled = l.copyWith(isSettled: true);
      await DBHelper.updateLended(settled);
      lended   = await DBHelper.getLended();
      accounts = await DBHelper.getAccounts();
      notifyListeners();
      recordNetWorthSnapshot();
      await _lendedNotif.cancelLendedReminder(l.id); // no reminder needed after settlement
    });
  }

  Future<void> deleteLended(String id) async {
    await _serializeMutation(() async {
      final idx = lended.indexWhere((l) => l.id == id);
      if (idx != -1) {
        final record = lended[idx];
        if (record.accountId != null && !record.isSettled) {
          final delta = -_lendedBalanceEffect(record);
          if (delta != 0) {
            final target = balanceAccountIdFor(record.accountId!);
            await DBHelper.applyBalanceDelta(target, delta);
          }
        }
      }
      await _lendedNotif.cancelLendedReminder(id);
      await DBHelper.deleteLended(id);
      lended   = await DBHelper.getLended();
      accounts = await DBHelper.getAccounts();
      notifyListeners();
      recordNetWorthSnapshot();
    });
  }

  Future<VoidCallback> deleteLendedWithUndo(String id) async {
    final record = lended.firstWhere((l) => l.id == id);
    await deleteLended(id);
    return () async {
      await _serializeMutation(() async {
        await DBHelper.insertLended(record);
        if (record.accountId != null && !record.isSettled) {
          final delta = _lendedBalanceEffect(record);
          if (delta != 0) {
            final target = balanceAccountIdFor(record.accountId!);
            await DBHelper.applyBalanceDelta(target, delta);
          }
        }
        lended   = await DBHelper.getLended();
        accounts = await DBHelper.getAccounts();
        if (!record.isSettled) {
          final p = lendedPeople.firstWhereOrNull((p) => p.id == record.personId);
          if (p != null) {
            _lendedNotif.scheduleLendedReminder(record, settings.currency, personName: p.name);
          }
        }
        notifyListeners();
        recordNetWorthSnapshot();
      });
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

  /// Returns budgets excluding child subcategory budgets whose parent category
  /// also has an active budget of the same period, preventing double-counting
  /// in aggregate budget totals and pacing.
  List<Budget> get nonOverlappingBudgets {
    final activeKeys = {
      for (final b in budgets) '${b.categoryId}:${b.period}',
    };
    return budgets.where((b) {
      final cat = categoryById(b.categoryId);
      if (cat == null || !cat.isSubcategory) return true;
      return !activeKeys.contains('${cat.parentId}:${b.period}');
    }).toList();
  }

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

  /// Calculates spending for a budget's category (including any child
  /// subcategories) within the half-open date interval [start, end).
  double budgetSpentInPeriod(Budget budget, DateTime start, DateTime end) {
    final familyIds = categoryFamilyIds(budget.categoryId);
    return transactions
        .where((t) =>
            t.type == 'expense' &&
            !FinancialAggregations.isExcludedFromTotals(t) &&
            !t.date.isBefore(start) &&
            t.date.isBefore(end))
        .fold(0.0, (sum, t) {
      final acct = accountById(t.accountId);
      final txCur = t.currency.isNotEmpty
          ? t.currency
          : (acct?.currency ?? settings.currency);
      if (isTransactionSplit(t.id)) {
        final txSplits =
            getSplits(t.id).where((s) => familyIds.contains(s.categoryId));
        if (txSplits.isEmpty) return sum;
        final splitSum = txSplits.fold(0.0, (s, item) => s + item.amount);
        return sum + convertToMain(splitSum, txCur);
      } else {
        if (!familyIds.contains(t.categoryId)) return sum;
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

    // Brand-new budgets created in the current period must not inherit a
    // synthetic surplus or deficit from pre-budget transactions (C6).
    if (!budget.createdAt.isBefore(currentStart)) {
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
        nonOverlappingBudgets.where((b) => b.period == 'monthly').toList();
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
        !FinancialAggregations.isExcludedFromTotals(t) &&
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
        !FinancialAggregations.isExcludedFromTotals(t) &&
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
    return FinancialAggregations.periodTotals(
      transactions,
      start: start,
      end: end,
      resolveCurrency: txCurrency,
      convert: convertToMain,
    ).expense;
  }

  /// Total income for the whole [month] converted to main currency.
  double monthTotalIncome(DateTime month) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 1);
    return FinancialAggregations.periodTotals(
      transactions,
      start: start,
      end: end,
      resolveCurrency: txCurrency,
      convert: convertToMain,
    ).income;
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
            !FinancialAggregations.isExcludedFromTotals(t) &&
            !t.date.isBefore(start) &&
            t.date.isBefore(end))
        .toList();

    // Top spending category (rolled up to root parent category, including splits)
    final Map<String, double> catTotals = {};
    for (final t in monthExpenses) {
      final acct = accountById(t.accountId);
      final txCur = t.currency.isNotEmpty
          ? t.currency
          : (acct?.currency ?? settings.currency);
      if (isTransactionSplit(t.id)) {
        for (final s in getSplits(t.id)) {
          if (s.categoryId.isEmpty) continue;
          final rootId = rootCategoryIdOf(s.categoryId);
          final amt = convertToMain(s.amount, txCur);
          catTotals[rootId] = (catTotals[rootId] ?? 0.0) + amt;
        }
      } else if (t.categoryId.isNotEmpty) {
        final rootId = rootCategoryIdOf(t.categoryId);
        final amt = convertToMain(t.amount, txCur);
        catTotals[rootId] = (catTotals[rootId] ?? 0.0) + amt;
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
    await _serializeMutation(() async {
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
      notifyListeners();
    });
  }

  Future<void> withdrawFromGoal({
    required String goalId,
    required String toAccountId,
    required double amount, // amount in goal currency
    String note = '',
  }) async {
    await _serializeMutation(() async {
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
      notifyListeners();
    });
  }

  // ── Loans ────────────────────────────────────────────────────────────
  Future<void> addLoan(Loan l) async {
    await _serializeMutation(() async {
      await DBHelper.insertLoan(l);
      if (l.transferAccountId != null) {
        await _updateAccountBalance(l.transferAccountId!, l.principal);
      }
      loans = await DBHelper.getLoans();
      notifyListeners();
      recordNetWorthSnapshot();
      if (l.reminderEnabled) await _loanNotif.scheduleReminder(l);
    });
  }

  Future<void> updateLoan(Loan l) async {
    await _serializeMutation(() async {
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
      notifyListeners();
      recordNetWorthSnapshot();
      if (l.reminderEnabled) await _loanNotif.scheduleReminder(l);
    });
  }

  Future<void> deleteLoan(String id) async {
    await _serializeMutation(() async {
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
      notifyListeners();
      recordNetWorthSnapshot();
    });
  }

  Future<VoidCallback> deleteLoanWithUndo(String id) async {
    final l = loans.firstWhere((x) => x.id == id);
    final payments = loanPaymentsFor(id);
    await deleteLoan(id);
    return () async {
      await _serializeMutation(() async {
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
        notifyListeners();
        recordNetWorthSnapshot();
        if (l.reminderEnabled) await _loanNotif.scheduleReminder(l);
      });
    };
  }

  Future<void> payLoanInstallment(Loan l, {double? amount, String? accountId, String notes = ''}) async {
    await _serializeMutation(() async {
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

      // Auto-settle when the loan is fully paid off (loanTotalPaid already includes the inserted payment)
      final totalPaid = loanTotalPaid(l);
      if (totalPaid >= l.totalPayable && !l.isSettled) {
        final settled = l.copyWith(isSettled: true);
        await DBHelper.updateLoan(settled);
        loans = await DBHelper.getLoans();
        await _loanNotif.cancelReminder(l.id);
      }
      notifyListeners();
      recordNetWorthSnapshot();
    });
  }

  Future<void> skipLoanInstallment(Loan l, {String notes = 'Skipped'}) async {
    await _serializeMutation(() async {
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
    });
  }

  Future<void> deleteLoanPayment(String id) async {
    await _serializeMutation(() async {
      final p = loanPayments.firstWhere((x) => x.id == id);
      if (p.accountId != null) {
        await _updateAccountBalance(p.accountId!, p.amount); // reverse the debit
      }
      await DBHelper.deleteLoanPayment(id);
      loanPayments = await DBHelper.getAllLoanPayments();

      // Re-evaluate settlement if total paid fell below totalPayable (A2b)
      final loan = loans.where((l) => l.id == p.loanId).firstOrNull;
      if (loan != null &&
          loan.isSettled &&
          loanTotalPaid(loan) < loan.totalPayable) {
        final unsettled = loan.copyWith(isSettled: false);
        await DBHelper.updateLoan(unsettled);
        loans = await DBHelper.getLoans();
        if (unsettled.reminderEnabled) {
          await _loanNotif.scheduleReminder(unsettled);
        }
      }

      notifyListeners();
      recordNetWorthSnapshot();
    });
  }

  Future<VoidCallback> deleteLoanPaymentWithUndo(String id) async {
    final p = loanPayments.firstWhere((x) => x.id == id);
    await deleteLoanPayment(id);
    return () async {
      await _serializeMutation(() async {
        await DBHelper.insertLoanPayment(p);
        if (p.accountId != null) {
          await _updateAccountBalance(p.accountId!, -p.amount);
        }
        loanPayments = await DBHelper.getAllLoanPayments();

        final loan = loans.where((l) => l.id == p.loanId).firstOrNull;
        if (loan != null &&
            !loan.isSettled &&
            loanTotalPaid(loan) >= loan.totalPayable) {
          final settled = loan.copyWith(isSettled: true);
          await DBHelper.updateLoan(settled);
          loans = await DBHelper.getLoans();
          await _loanNotif.cancelReminder(loan.id);
        }

        notifyListeners();
        recordNetWorthSnapshot();
      });
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

  /// Total loan installment payments recorded within [start, end), converted to main currency (C11).
  double periodLoanPaymentsTotal(DateTime start, DateTime end) {
    return loanPayments
        .where((p) =>
            p.amount > 0 && !p.date.isBefore(start) && p.date.isBefore(end))
        .fold(0.0, (sum, p) {
      final cur = p.currency.isNotEmpty ? p.currency : settings.currency;
      return sum + convertToMain(p.amount, cur);
    });
  }

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

    final l10n = ServiceLocalizations.current;
    final excel = Excel.createExcel();
    final sheet = excel[l10n.export_excelSheetName];
    try { excel.delete('Sheet1'); } catch (_) {}

    final headers = [
      l10n.export_headerDate,
      l10n.export_headerDescription,
      l10n.export_headerType,
      l10n.export_headerAmount,
      l10n.export_headerCurrency,
      l10n.export_headerAccount,
      l10n.export_headerCategory,
      l10n.export_headerSubcategory,
      l10n.export_headerNote,
    ];
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
      final cat = categoryById(t.categoryId);
      final String parentCatName;
      final String subCatName;
      if (isTransactionSplit(t.id)) {
        final txSplits = getSplits(t.id);
        parentCatName = txSplits
            .map((s) => rootCategoryOf(s.categoryId)?.name ?? '')
            .where((n) => n.isNotEmpty)
            .toSet()
            .join(', ');
        subCatName = txSplits
            .map((s) => categoryDisplayName(s.categoryId))
            .where((n) => n.isNotEmpty)
            .join(', ');
      } else if (cat != null && cat.isSubcategory) {
        parentCatName = categoryById(cat.parentId!)?.name ?? cat.name;
        subCatName = cat.name;
      } else {
        parentCatName = cat?.name ?? '';
        subCatName = '';
      }
      final vals = [
        '${t.date.day}/${t.date.month}/${t.date.year}',
        t.description,
        t.type,
        t.amount.toStringAsFixed(2),
        displayCurrency,
        accountById(t.accountId)?.name ?? '',
        parentCatName,
        subCatName,
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

  // ── Auto Backup ────────────────────────────────────────────────────────
  AutoBackupState _autoBackup = const AutoBackupState(
    enabled: false,
    folderUri: '',
    folderName: '',
    retention: 7,
    encrypted: false,
    lastSuccessMs: 0,
    lastAttemptMs: 0,
    lastError: '',
    lastFile: '',
    lastSize: 0,
    nextRunMs: 0,
  );
  AutoBackupState get autoBackup => _autoBackup;

  Future<void> refreshAutoBackupState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    _autoBackup = AutoBackupState.fromPrefs(prefs);
    notifyListeners();
  }

  Future<bool> chooseAutoBackupFolder() async {
    final picked = await ExpensySaf.pickDirectory();
    if (picked == null) return false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ab_tree_uri', picked.uri);
    await prefs.setString('ab_folder_name', picked.name);
    await prefs.remove('ab_last_error');
    await refreshAutoBackupState();
    await AutoBackupService.scheduleNext(force: true);
    return true;
  }

  Future<void> setAutoBackupEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    if (enabled && (prefs.getString('ab_tree_uri')?.isEmpty ?? true)) {
      final success = await chooseAutoBackupFolder();
      if (!success) return;
    }
    await prefs.setBool('ab_enabled', enabled);
    if (!enabled) {
      final oldUri = prefs.getString('ab_tree_uri');
      if (oldUri != null && oldUri.isNotEmpty) {
        await ExpensySaf.releaseDirectory(oldUri);
      }
      await ExpensySaf.clearSecret(AutoBackupService.secretKey);
      await prefs.remove('ab_tree_uri');
      await prefs.remove('ab_folder_name');
      await prefs.setBool('ab_encrypted', false);
    }
    await refreshAutoBackupState();
    await AutoBackupService.scheduleNext(force: true);
  }

  Future<void> setAutoBackupRetention(int retention) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('ab_retention', retention);
    await refreshAutoBackupState();
  }

  Future<void> setAutoBackupEncryption({required bool on, String? password}) async {
    final prefs = await SharedPreferences.getInstance();
    if (on) {
      if (password == null || password.isEmpty) {
        throw const FormatException('Password cannot be empty');
      }
      const sample = '{"test":true}';
      final enc = await BackupEncryptionService.encrypt(jsonStr: sample, password: password);
      final dec = await BackupEncryptionService.decrypt(bytes: enc, password: password);
      if (dec != sample) {
        throw const FormatException('Encryption self-test verification failed');
      }
      final saved = await ExpensySaf.setSecret(AutoBackupService.secretKey, password);
      if (!saved) {
        throw const FormatException('Failed to securely store encryption key in Android KeyStore');
      }
      await prefs.setBool('ab_encrypted', true);
    } else {
      await ExpensySaf.clearSecret(AutoBackupService.secretKey);
      await prefs.setBool('ab_encrypted', false);
    }
    await refreshAutoBackupState();
  }

  Future<AutoBackupResult> runAutoBackupNow() async {
    final result = await AutoBackupService.runNow(BackupTrigger.manual);
    await refreshAutoBackupState();
    return result;
  }

  // ── Certificates ──────────────────────────────────────────────────────────
  Future<void> addCertificate(Certificate c) async {
    await _serializeMutation(() async {
      final now = DateTime.now();
      final tx = AppTransaction(
        id: newId(),
        type: 'expense',
        amount: c.amount,
        description: 'Certificate Principal: ${c.name}',
        accountId: c.accountId,
        categoryId: 'sys_investment',
        date: now,
        note: 'Deposit for certificate: ${c.name} [cert:${c.id}]',
        currency: c.currency,
        certificateId: c.id,
      );
      await addTransaction(tx);

      await DBHelper.insertCertificate(c);
      certificates = [c, ...certificates];
      notifyListeners();
      recordNetWorthSnapshot();
      await CertificateReminderService().scheduleReminder(c);
    });
  }

  Future<void> updateCertificate(Certificate c) async {
    await _serializeMutation(() async {
      final oldCert = certificates.firstWhereOrNull((item) => item.id == c.id);
      if (oldCert != null &&
          (oldCert.amount != c.amount || oldCert.accountId != c.accountId)) {
        final principalTx = transactions.firstWhereOrNull((t) =>
            (t.certificateId == c.id || t.note.contains('[cert:${c.id}]')) &&
            (t.description.startsWith('Certificate Principal:') ||
                t.note.contains('Deposit for certificate:')));
        if (principalTx != null) {
          final updatedTx = principalTx.copyWith(
            amount: c.amount,
            accountId: c.accountId,
            currency: c.currency,
          );
          await updateTransaction(updatedTx, principalTx);
        }
      }
      await DBHelper.updateCertificate(c);
      final idx = certificates.indexWhere((item) => item.id == c.id);
      if (idx != -1) {
        final next = List<Certificate>.from(certificates);
        next[idx] = c;
        certificates = next;
      }
      notifyListeners();
      recordNetWorthSnapshot();
      await CertificateReminderService().scheduleReminder(c);
    });
  }

  Future<void> deleteCertificate(String id) async {
    await _serializeMutation(() async {
      await CertificateReminderService().cancelReminder(id);
      final cert = certificates.firstWhereOrNull((c) => c.id == id);
      if (cert != null) {
        // Find all transactions associated with this certificate via ID, tag, or exact legacy prefix (B12)
        final relatedTxs = transactions.where((t) {
          final hasCertId = t.certificateId == id;
          final hasCertTag = t.note.contains('[cert:$id]');
          final matchesLegacyExact = t.certificateId == null &&
              t.accountId == cert.accountId &&
              (t.description == 'Certificate Principal: ${cert.name}' ||
                  t.description == 'Certificate Yield: ${cert.name}' ||
                  t.description == 'Certificate Redemption: ${cert.name}');
          return hasCertId || hasCertTag || matchesLegacyExact;
        }).toList();

        // Delete each transaction, automatically reverting its balance delta
        for (final tx in relatedTxs) {
          final delta = _txDelta(tx, reverse: true);
          final balAccId = balanceAccountIdFor(tx.accountId);
          await DBHelper.applyDeleteTransactionWithBalance(
              tx.id, balAccId, delta);
          _patchAccountBalance(balAccId, delta);
          splits.removeWhere((s) => s.transactionId == tx.id);
          _splitsByTxId.remove(tx.id);
        }
        if (relatedTxs.isNotEmpty) {
          final relIds = relatedTxs.map((t) => t.id).toSet();
          transactions = transactions.where((t) => !relIds.contains(t.id)).toList();
        }
      }

      await DBHelper.deleteCertificate(id);
      certificates = certificates.where((item) => item.id != id).toList();
      notifyListeners();
      updateHomeWidgets();
      recordNetWorthSnapshot();
    });
  }

  Future<void> redeemCertificate(String id, {bool returnPrincipal = true}) async {
    await _serializeMutation(() async {
      await CertificateReminderService().cancelReminder(id);
      final cert = certificates.firstWhereOrNull((c) => c.id == id);
      if (cert == null || cert.isSettled) return;

      if (returnPrincipal) {
        final now = DateTime.now();
        final tx = AppTransaction(
          id: newId(),
          type: 'income',
          amount: cert.amount,
          description: 'Certificate Redemption: ${cert.name}',
          accountId: cert.accountId,
          categoryId: 'sys_investment',
          date: now,
          note: 'Principal return for ${cert.name} [cert:${cert.id}]',
          currency: cert.currency,
          certificateId: cert.id,
        );
        await addTransaction(tx);
      }

      final settled = cert.copyWith(isSettled: true);
      await DBHelper.updateCertificate(settled);
      final idx = certificates.indexWhere((item) => item.id == id);
      if (idx != -1) {
        certificates[idx] = settled;
      }
      notifyListeners();
      recordNetWorthSnapshot();
    });
  }

  Future<void> checkAndProcessCertificates() async {
    await _serializeMutation(() async {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final endOfToday =
          DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
      for (var c in List<Certificate>.from(certificates)) {
        if (c.isSettled) continue;

        final endOfCert = DateTime(
          c.endDate.year,
          c.endDate.month,
          c.endDate.day,
          23,
          59,
          59,
          999,
        );

        // Catch-up due payouts up to maturity date (bounded to 24 cycles)
        int iterations = 0;
        while (iterations < 24) {
          final nextDate = c.nextUncollectedPeriodDate;
          if (nextDate != null &&
              !nextDate.isAfter(endOfToday) &&
              !nextDate.isAfter(endOfCert)) {
            final payout = c.periodicPayout;
            if (payout > 0) {
              final tx = AppTransaction(
                id: newId(),
                type: 'income',
                amount: payout,
                description: 'Certificate Yield: ${c.name}',
                accountId: c.accountId,
                categoryId: 'sys_investment',
                date: nextDate,
                note: 'Yield collection for ${c.name} [cert:${c.id}]',
                currency: c.currency,
                certificateId: c.id,
              );
              await addTransaction(tx);

              c = c.copyWith(
                lastCollectedDate: nextDate,
                totalCollectedAmount: c.totalCollectedAmount + payout,
              );
              await DBHelper.updateCertificate(c);
              final idx = certificates.indexWhere((item) => item.id == c.id);
              if (idx != -1) {
                final nextCerts = List<Certificate>.from(certificates);
                nextCerts[idx] = c;
                certificates = nextCerts;
              }
              iterations++;
            } else {
              break;
            }
          } else {
            break;
          }
        }

        // Only redeem after due yield has been collected up to endDate
        final endDay = DateTime(c.endDate.year, c.endDate.month, c.endDate.day);
        if (today.isAfter(endDay)) {
          await redeemCertificate(c.id, returnPrincipal: true);
        }
      }
    });
  }

  // ── Backup ────────────────────────────────────────────────────────────
  Future<String?> createBackup({String? dialogTitle, String? password}) async {
    final artifact = await BackupBuilder.build(
      settingsJson: settings.toJson(),
      password: password,
      namePrefix: 'expensy_backup',
    );

    final saveUri = await FilePickerPlatform.instance.saveFile(
      dialogTitle: dialogTitle,
      fileName: artifact.fileName,
      bytes: artifact.bytes,
      mimeType: artifact.mimeType,
    );
    return saveUri?.toString();
  }

  /// Parses and optionally decrypts raw backup [bytes].
  /// Throws `FormatException('NEEDS_PASSWORD')` if the payload is encrypted and
  /// [password] is null or empty.
  Future<Map<String, dynamic>> parseBackupBytes(
    List<int> bytes, {
    String? password,
    String? extension,
  }) async {
    final ext = extension?.toLowerCase();
    String jsonStr;
    if (BackupEncryptionService.isEncrypted(bytes) || ext == 'enc') {
      if (password == null || password.isEmpty) {
        throw const FormatException('NEEDS_PASSWORD');
      }
      jsonStr = await BackupEncryptionService.decrypt(
        bytes: bytes,
        password: password,
      );
    } else {
      try {
        jsonStr = utf8.decode(bytes);
      } catch (_) {
        throw const FormatException(
          'Please select a valid .json or .enc Expensy backup file.',
        );
      }
    }

    final dynamic decoded = jsonDecode(jsonStr);
    if (decoded is! Map) {
      throw const FormatException(
        'Invalid backup file: top-level value is not a JSON object.',
      );
    }
    final data = Map<String, dynamic>.from(decoded);

    const knownKeys = {
      'accounts',
      'categories',
      'transactions',
      'recurring_payments',
      'wishlist',
      'lended_people',
      'lended_money',
      'assets',
      'budgets',
      'recurring_history',
      'certificates',
      'net_worth_snapshots',
      'version',
      'settings',
      'savings_goals',
      'savings_contributions',
      'loans',
      'loan_payments',
      'transaction_presets',
      'transaction_splits',
      'selective',
    };
    if (!data.keys.any(knownKeys.contains)) {
      throw const FormatException(
        'Invalid backup file: no recognisable Expensy data found.',
      );
    }
    return data;
  }

  /// Picks a backup file from the device and parses it.
  /// If [onPasswordRequired] is supplied and the file is encrypted, invokes it
  /// to prompt the user for the decryption password without re-opening the file picker.
  Future<Map<String, dynamic>?> pickAndParseBackupFile({
    String? password,
    Future<String?> Function()? onPasswordRequired,
  }) async {
    final pickedFiles = await FilePickerPlatform.instance.pickFiles();
    if (pickedFiles.isEmpty) return null;
    final picked = pickedFiles.first;
    final ext = picked.extension?.toLowerCase();

    List<int> bytes;
    try {
      bytes = await picked.readAsBytes();
    } catch (_) {
      final path = picked.path;
      if (path != null) {
        bytes = await File(path).readAsBytes();
      } else {
        rethrow;
      }
    }

    String? effectivePassword = password;
    if ((BackupEncryptionService.isEncrypted(bytes) || ext == 'enc') &&
        (effectivePassword == null || effectivePassword.isEmpty) &&
        onPasswordRequired != null) {
      effectivePassword = await onPasswordRequired();
      if (effectivePassword == null || effectivePassword.isEmpty) {
        return null; // User cancelled password dialog
      }
    }

    return parseBackupBytes(
      bytes,
      password: effectivePassword,
      extension: ext,
    );
  }

  String? lastPreRestoreSnapshotPath;

  Future<void> _createSafetySnapshot() async {
    final snapshot = await DBHelper.exportAll();
    final jsonStr = jsonEncode(snapshot);
    final ts = DateTime.now()
        .toIso8601String()
        .replaceAll(':', '-')
        .replaceAll('.', '-');
    final fileName = 'expensy_prerestore_$ts.json';

    Directory? targetDir;
    try {
      final dbFolder = await sqflite.getDatabasesPath();
      final primaryDir = Directory(p.join(dbFolder, 'safety_snapshots'));
      if (!primaryDir.existsSync()) {
        primaryDir.createSync(recursive: true);
      }
      final file = File(p.join(primaryDir.path, fileName));
      await file.writeAsString(jsonStr);
      lastPreRestoreSnapshotPath = file.path;
      targetDir = primaryDir;
    } catch (primaryErr) {
      try {
        final fallbackDir =
            Directory(p.join(Directory.systemTemp.path, 'expensy_safety_snapshots'));
        if (!fallbackDir.existsSync()) {
          fallbackDir.createSync(recursive: true);
        }
        final file = File(p.join(fallbackDir.path, fileName));
        await file.writeAsString(jsonStr);
        lastPreRestoreSnapshotPath = file.path;
        targetDir = fallbackDir;
      } catch (fallbackErr) {
        throw StateError(
          'Pre-restore safety snapshot failed ($primaryErr / $fallbackErr). Restore aborted to protect existing data.',
        );
      }
    }

    // Retain only last 3 snapshots in targetDir
    try {
      final files = targetDir.listSync().whereType<File>().toList()
        ..sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
      if (files.length > 3) {
        for (int i = 3; i < files.length; i++) {
          try {
            files[i].deleteSync();
          } catch (_) {}
        }
      }
    } catch (_) {}
  }

  Future<bool> undoLastRestore() async {
    return _serializeMutation(() async {
      final path = lastPreRestoreSnapshotPath;
      if (path == null) return false;
      final file = File(path);
      if (!file.existsSync()) return false;
      final jsonStr = await file.readAsString();
      final data = jsonDecode(jsonStr) as Map<String, dynamic>;
      await DBHelper.importAll(data);
      await load();
      return true;
    });
  }

  Future<int> restoreBackupData(Map<String, dynamic> data) async {
    return _serializeMutation(() async {
      if (data['selective'] == true) {
        throw const FormatException(
          'Cannot perform Full Restore on a selective backup. Please use Selective Restore instead.',
        );
      }
      final preview = BackupValidator.validate(data);
      if (!preview.isValid) {
        throw FormatException(
          preview.errorMessage ?? 'Invalid backup file: schema incompatible.',
        );
      }

      // Parse & validate settings before wiping the database (B9)
      AppSettings? parsedSettings;
      if (data['settings'] is Map) {
        parsedSettings = AppSettings.fromJson(
          Map<String, dynamic>.from(data['settings'] as Map),
        );
      }

      await _createSafetySnapshot();
      await DBHelper.importAll(data);

      if (parsedSettings != null) {
        settings = parsedSettings;
        await _saveSettings();
      }

      _historyCache.clear();
      await load();
      if (netWorthSnapshots.isEmpty) {
        await _executeRecordNetWorthSnapshot();
      }
      try {
        await _notif.rescheduleAll(recurring, settings.currency);
        await _lendedNotif.rescheduleAllLended(
          lended,
          settings.currency,
          personNameOf: (id) => personById(id)?.name ?? '',
        );
        await _loanNotif.rescheduleAllLoans(loans, settings.currency);
        await CreditReminderService().rescheduleAll(accounts);
        await CertificateReminderService()
            .rescheduleAllCertificates(certificates);
      } catch (_) {}

      return (data['_originalVersion'] as int?) ??
          (data['version'] as int?) ??
          1;
    });
  }

  Future<int> restoreBackup({
    String? password,
    Future<String?> Function()? onPasswordRequired,
  }) async {
    final data = await pickAndParseBackupFile(
      password: password,
      onPasswordRequired: onPasswordRequired,
    );
    if (data == null) return 0;
    return restoreBackupData(data);
  }

  static const Map<String, List<String>> entityGroupTables = {
    'accounts': ['accounts'],
    'transactions': [
      'transactions',
      'transaction_splits',
      'transaction_presets'
    ],
    'categories': ['categories'],
    'recurring': ['recurring_payments', 'recurring_history'],
    'loans': ['loans', 'loan_payments'],
    'lent_money': ['lended_people', 'lended_money'],
    'certificates': ['certificates'],
    'budgets': ['budgets'],
    'assets': ['assets'],
    'wishlist_goals': ['wishlist', 'savings_goals', 'savings_contributions'],
  };

  Future<String?> createSelectiveBackup(Set<String> selectedGroups,
      {String? dialogTitle}) async {
    final tables = <String>{};
    for (final group in selectedGroups) {
      final tList = entityGroupTables[group];
      if (tList != null) tables.addAll(tList);
    }
    final dt = DateTime.now();
    final timestamp = DateFormat('yyyyMMdd_HHmmss', 'en_US').format(dt);
    final data = await DBHelper.exportSelective(tables);
    data['exported_at'] = dt.toIso8601String();

    final jsonStr = const JsonEncoder.withIndent('  ').convert(data);
    final bytes = Uint8List.fromList(utf8.encode(jsonStr));

    final saveUri = await FilePickerPlatform.instance.saveFile(
      dialogTitle: dialogTitle,
      fileName: 'expensy_selective_backup_$timestamp.json',
      bytes: bytes,
      mimeType: 'application/json',
    );
    return saveUri?.toString();
  }

  Future<void> restoreSelective(
      Map<String, dynamic> data, Set<String> selectedGroups) async {
    await _serializeMutation(() async {
      final preview = BackupValidator.validate(data);
      if (!preview.isValid) {
        throw FormatException(
          preview.errorMessage ?? 'Invalid backup file: schema incompatible.',
        );
      }

      await _createSafetySnapshot();
      final tables = <String>{};
      for (final group in selectedGroups) {
        final tList = entityGroupTables[group];
        if (tList != null) tables.addAll(tList);
      }

      await DBHelper.importSelective(data, tables);
      _historyCache.clear();
      await load();

      try {
        if (selectedGroups.contains('recurring')) {
          await _notif.rescheduleAll(recurring, settings.currency);
        }
        if (selectedGroups.contains('lent_money')) {
          await _lendedNotif.rescheduleAllLended(
            lended,
            settings.currency,
            personNameOf: (id) => personById(id)?.name ?? '',
          );
        }
        if (selectedGroups.contains('loans')) {
          await _loanNotif.rescheduleAllLoans(loans, settings.currency);
        }
        if (selectedGroups.contains('accounts')) {
          await CreditReminderService().rescheduleAll(accounts);
        }
        if (selectedGroups.contains('certificates')) {
          await CertificateReminderService()
              .rescheduleAllCertificates(certificates);
        }
      } catch (_) {}
    });
  }

  // ── External Backups ──────────────────────────────────────────────────
  int lastExternalImportCount = 0;

  Future<bool> restoreExternalBackup(String source) async {
    final isJson = source == 'greenstash';
    final isCsv = source == 'trackwallet';
    final pickedFiles = await FilePickerPlatform.instance.pickFiles(
      type: (isJson || isCsv) ? FileType.custom : FileType.any,
      allowedExtensions: isJson ? ['json'] : (isCsv ? ['csv'] : null),
    );
    if (pickedFiles.isEmpty) return false;

    final ext = pickedFiles.first.extension?.toLowerCase();
    if (isJson && ext != 'json') {
      throw const FormatException('Please select a .json file.');
    }
    if (isCsv && ext != 'csv') {
      throw const FormatException('Please select a .csv file.');
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
    } else if (source == 'trackwallet') {
      lastExternalImportCount = await restoreTrackWallet(contentStr);
    }
    return true;
  }

  /// Imports transactions, accounts, parent categories, subcategories, and
  /// paired/single-leg transfers from a TrackWallet CSV export.
  /// Returns the number of imported transactions.
  Future<int> restoreTrackWallet(String csvContent) async {
    return await _serializeMutation(() async {
      // Strip optional UTF-8 BOM.
      final cleaned = csvContent.startsWith('\uFEFF')
          ? csvContent.substring(1)
          : csvContent;
      final lines = cleaned.split(RegExp(r'\r?\n'));

      int startIndex = -1;
      for (int i = 0; i < lines.length; i++) {
        final lower = lines[i].trim().toLowerCase();
        if (lower.startsWith('date,transaction,account,currency,amount')) {
          startIndex = i + 1;
          break;
        }
      }
      if (startIndex == -1) {
        throw const FormatException(
          'Invalid TrackWallet CSV format: Header row not found.',
        );
      }

      if (transactions.isNotEmpty || accounts.isNotEmpty) {
        await _createSafetySnapshot();
      }

      const palette = <int>[
        0xFF1565C0,
        0xFFE65100,
        0xFF2E7D32,
        0xFF880E4F,
        0xFF00838F,
        0xFF6A1B9A,
        0xFFF9A825,
        0xFFAD1457,
        0xFF00695C,
        0xFFD84315,
        0xFF283593,
        0xFF558B2F,
      ];

      // Smart parent category aliases (TrackWallet -> Expensy default names).
      const parentAliases = <String, List<String>>{
        'food': ['food & dining', 'food'],
        'bills': ['bills & utilities', 'bills'],
        'transport': ['transport', 'transportation'],
        'shopping': ['shopping'],
        'health': ['health', 'medical'],
        'leisure': ['entertainment', 'leisure'],
        'personal care': ['personal care'],
        'misc': ['other expense', 'misc', 'miscellaneous'],
        'miscellaneous': ['other expense', 'miscellaneous', 'misc'],
        'salary': ['salary'],
        'investments': ['investments'],
        'gifts': ['gifts'],
        'education': ['education'],
      };

      final parsedRows = <({
        DateTime date,
        String txType,
        String accountName,
        String currency,
        double signedAmount,
        String categoryName,
        String subcategoryName,
        String note,
      })>[];

      final currencyCounts = <String, int>{};

      for (int i = startIndex; i < lines.length; i++) {
        final line = lines[i].trim();
        if (line.isEmpty) continue;
        final row = _parseCsvRow(line);
        if (row.length < 7) continue;

        final date = DateTime.tryParse(row[0].trim());
        if (date == null) continue;
        final txType = row[1].trim();
        final accountName = row[2].trim();
        final currency = row[3].trim().isNotEmpty
            ? row[3].trim().toUpperCase()
            : settings.currency;
        final signedAmount = double.tryParse(row[4].trim());
        if (signedAmount == null || signedAmount == 0) continue;

        final categoryName = row[6].trim();
        final subcategoryName = row.length > 7 ? row[7].trim() : '';
        final note = row.length > 8 ? row[8].trim() : '';

        currencyCounts[currency] = (currencyCounts[currency] ?? 0) + 1;
        parsedRows.add((
          date: date,
          txType: txType,
          accountName: accountName.isEmpty ? 'Imported Account' : accountName,
          currency: currency,
          signedAmount: signedAmount,
          categoryName: categoryName,
          subcategoryName: subcategoryName,
          note: note,
        ));
      }

      if (parsedRows.isEmpty) {
        throw const FormatException(
          'No valid transactions found in TrackWallet CSV.',
        );
      }

      // Adopt CSV primary currency during initial onboarding.
      if (!settings.onboarded && currencyCounts.isNotEmpty) {
        final primaryCur = (currencyCounts.entries.toList()
              ..sort((a, b) => b.value.compareTo(a.value)))
            .first
            .key;
        if (primaryCur.isNotEmpty) {
          updateSetting('currency', primaryCur);
        }
      }

      final workingAccounts = List<Account>.from(accounts);
      final newAccounts = <Account>[];
      final accountDeltas = <String, double>{};

      Account resolveAccount(String name, String currency) {
        final existing = workingAccounts.firstWhereOrNull(
          (a) => a.name.toLowerCase() == name.toLowerCase(),
        );
        if (existing != null) return existing;
        final acc = Account(
          id: newId(),
          name: name,
          type: 'bank',
          currency: currency,
          balance: 0,
          colorValue: palette[workingAccounts.length % palette.length],
          orderIndex: workingAccounts.length,
        );
        workingAccounts.add(acc);
        newAccounts.add(acc);
        return acc;
      }

      final workingCategories = List<AppCategory>.from(categories);
      final newCategories = <AppCategory>[];

      AppCategory resolveParentCategory(String rawName, String catType) {
        final cleanName = rawName.isEmpty
            ? (catType == 'income' ? 'Other Income' : 'Other Expense')
            : rawName;
        final lower = cleanName.toLowerCase();
        final aliases = parentAliases[lower] ?? [lower];

        final existing = workingCategories.firstWhereOrNull(
          (c) =>
              !c.isSystem &&
              !c.isSubcategory &&
              c.type == catType &&
              aliases.contains(c.name.toLowerCase()),
        );
        if (existing != null) return existing;

        final cat = AppCategory(
          id: newId(),
          name: cleanName,
          type: catType,
          colorValue: palette[workingCategories.length % palette.length],
          iconCodePoint: 0,
          orderIndex: workingCategories.length,
        );
        workingCategories.add(cat);
        newCategories.add(cat);
        return cat;
      }

      AppCategory resolveSubcategory(AppCategory parent, String subName) {
        final lower = subName.toLowerCase();
        final existing = workingCategories.firstWhereOrNull(
          (c) =>
              !c.isSystem &&
              c.parentId == parent.id &&
              c.name.toLowerCase() == lower,
        );
        if (existing != null) return existing;

        final sub = AppCategory(
          id: newId(),
          name: subName,
          type: parent.type,
          colorValue: parent.colorValue,
          iconCodePoint: 0,
          orderIndex: workingCategories.length,
          parentId: parent.id,
        );
        workingCategories.add(sub);
        newCategories.add(sub);
        return sub;
      }

      // Pair matching opposite-sign Transfer rows (same timestamp to second & amount).
      final transferGroupByIndex = <int, String>{};
      for (int i = 0; i < parsedRows.length; i++) {
        final r = parsedRows[i];
        if (r.txType.toLowerCase() != 'transfer' ||
            transferGroupByIndex.containsKey(i)) {
          continue;
        }
        final absAmt = r.signedAmount.abs();
        int? matchIdx;
        for (int j = i + 1; j < parsedRows.length; j++) {
          if (transferGroupByIndex.containsKey(j)) continue;
          final cand = parsedRows[j];
          if (cand.txType.toLowerCase() != 'transfer') continue;
          if ((cand.signedAmount.abs() - absAmt).abs() < 0.001 &&
              cand.signedAmount * r.signedAmount < 0 &&
              cand.accountName.toLowerCase() != r.accountName.toLowerCase() &&
              cand.date.difference(r.date).inSeconds.abs() <= 5) {
            matchIdx = j;
            break;
          }
        }
        final groupId = matchIdx != null
            ? newId()
            : 'tr_tw_single_${newId()}';
        transferGroupByIndex[i] = groupId;
        if (matchIdx != null) {
          transferGroupByIndex[matchIdx] = groupId;
        }
      }

      final newTransactions = <AppTransaction>[];
      for (int i = 0; i < parsedRows.length; i++) {
        final r = parsedRows[i];
        final acc = resolveAccount(r.accountName, r.currency);
        final absAmt = r.signedAmount.abs();
        final lowerType = r.txType.toLowerCase();

        if (lowerType == 'transfer') {
          final isIncoming = r.signedAmount > 0;
          final tx = AppTransaction(
            id: newId(),
            type: isIncoming ? 'income' : 'expense',
            amount: absAmt,
            description: isIncoming ? 'Transfer in' : 'Transfer out',
            accountId: acc.id,
            categoryId: 'sys_transfer',
            date: r.date,
            note: r.note,
            currency: r.currency == acc.currency ? '' : r.currency,
            transferGroupId: transferGroupByIndex[i],
          );
          newTransactions.add(tx);
          accountDeltas[acc.id] =
              (accountDeltas[acc.id] ?? 0.0) + (isIncoming ? absAmt : -absAmt);
        } else {
          final isIncome = lowerType == 'income' ||
              (lowerType != 'expense' && r.signedAmount > 0);
          final catType = isIncome ? 'income' : 'expense';
          final parentCat = resolveParentCategory(r.categoryName, catType);
          final targetCat = r.subcategoryName.isNotEmpty
              ? resolveSubcategory(parentCat, r.subcategoryName)
              : parentCat;

          final desc = r.note.isNotEmpty
              ? r.note
              : (r.subcategoryName.isNotEmpty
                  ? r.subcategoryName
                  : parentCat.name);

          final tx = AppTransaction(
            id: newId(),
            type: catType,
            amount: absAmt,
            description: desc,
            accountId: acc.id,
            categoryId: targetCat.id,
            date: r.date,
            note: r.note,
            currency: r.currency == acc.currency ? '' : r.currency,
          );
          newTransactions.add(tx);
          accountDeltas[acc.id] =
              (accountDeltas[acc.id] ?? 0.0) + (isIncome ? absAmt : -absAmt);
        }
      }

      await DBHelper.batchImportExternal(
        newAccounts: newAccounts,
        newCategories: newCategories,
        newTransactions: newTransactions,
        accountBalanceDeltas: accountDeltas,
      );
      await load();
      return newTransactions.length;
    });
  }


  Future<void> _restoreGreenStash(String jsonStr) async {
    await _serializeMutation(() async {
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
          colorValue: 0xFF386A1F,
          targetDate: goal['deadline'] != null && goal['deadline'] > 0
              ? DateTime.fromMillisecondsSinceEpoch(goal['deadline'])
              : null,
        );
        await addSavingsGoal(sg);

        double currentAmount = 0.0;
        if (item['transactions'] is List) {
          for (var tx in item['transactions']) {
            bool isDeposit = true;
            if (tx['type'] == 1 ||
                tx['type'] == 'withdrawal' ||
                tx['type'] == 'Withdraw' ||
                tx['isDeposit'] == false) {
              isDeposit = false;
            }
            double amt = (tx['amount'] ?? 0).toDouble().abs();

            await DBHelper.insertSavingsContribution(SavingsContribution(
              id: newId(),
              goalId: sg.id,
              amount: amt,
              accountId: '',
              type: isDeposit ? 'contribution' : 'withdrawal',
              date: DateTime.fromMillisecondsSinceEpoch(
                  tx['timeStamp'] ?? DateTime.now().millisecondsSinceEpoch),
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
    });
  }

  // Parses a single CSV line according to RFC-4180 rules (quoted fields and "" escapes).
  static List<String> _parseCsvRow(String line) {
    final fields = <String>[];
    final buf = StringBuffer();
    bool inQuotes = false;

    for (int i = 0; i < line.length; i++) {
      final ch = line[i];
      if (inQuotes) {
        if (ch == '"') {
          if (i + 1 < line.length && line[i + 1] == '"') {
            buf.write('"');
            i++;
          } else {
            inQuotes = false;
          }
        } else {
          buf.write(ch);
        }
      } else {
        if (ch == '"') {
          inQuotes = true;
        } else if (ch == ',') {
          fields.add(buf.toString());
          buf.clear();
        } else {
          buf.write(ch);
        }
      }
    }
    fields.add(buf.toString());
    return fields;
  }

  bool isTransactionSelectionMode = false;
  void setTransactionSelectionMode(bool value) {
    if (isTransactionSelectionMode != value) {
      isTransactionSelectionMode = value;
      notifyListeners();
    }
  }
  final ValueNotifier<int> tabIndexNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> accountsTabNotifier = ValueNotifier<int>(0);

  Set<String> get _linkedBankAccountIds => accounts
      .where((a) =>
          a.isDebit &&
          a.linkedAccountId != null &&
          a.linkedAccountId!.isNotEmpty)
      .map((a) => a.linkedAccountId!)
      .toSet();

  List<Account> get nonBankAccounts {
    final linkedBankIds = _linkedBankAccountIds;
    return accounts
        .where((a) =>
            a.type != 'bank' ||
            a.dontLinkToCard ||
            !linkedBankIds.contains(a.id))
        .toList();
  }

  /// Accounts directly usable for expense/income/loan/lended transactions:
  /// Cards, Cash, Wallets, Savings, plus Bank accounts with no linked Debit Card
  /// (or [dontLinkToCard] enabled). Excludes Gold accounts.
  List<Account> get spendableAccounts {
    final linkedBankIds = _linkedBankAccountIds;
    final primary = accounts.where((a) {
      if (a.isGold) return false;
      if (a.type == 'bank') {
        return a.dontLinkToCard || !linkedBankIds.contains(a.id);
      }
      return true;
    }).toList();
    if (primary.isNotEmpty) return primary;
    return accounts.where((a) => !a.isGold).toList();
  }

  /// Accounts eligible for internal transfers (Bank, Cash, Savings — excludes Cards & Gold).
  List<Account> get transferableAccounts =>
      accounts.where((a) => !a.isCard && !a.isGold).toList();

  void reorderCategories(int oldIndex, int newIndex, String type,
      {String? parentId}) {
    if (oldIndex < newIndex) newIndex -= 1;

    final scoped = categories
        .where((c) =>
            !c.isSystem &&
            c.type == type &&
            (parentId == null ? !c.isSubcategory : c.parentId == parentId))
        .toList();
    if (oldIndex < 0 ||
        oldIndex >= scoped.length ||
        newIndex < 0 ||
        newIndex >= scoped.length) {
      return;
    }

    final item = scoped[oldIndex];
    final next = List<AppCategory>.from(categories)..remove(item);

    int insertionIndex = 0;
    int currentScopedIndex = 0;
    for (int i = 0; i < next.length; i++) {
      final c = next[i];
      final inScope = !c.isSystem &&
          c.type == type &&
          (parentId == null ? !c.isSubcategory : c.parentId == parentId);
      if (inScope) {
        if (currentScopedIndex == newIndex) {
          insertionIndex = i;
          break;
        }
        currentScopedIndex++;
      }
      insertionIndex = i + 1;
    }

    next.insert(insertionIndex, item);
    for (int i = 0; i < next.length; i++) {
      next[i] = next[i].copyWith(orderIndex: i);
    }
    categories = next;
    notifyListeners();
    final ids = next.map((c) => c.id).toList();
    _serializeMutation(() async {
      await DBHelper.updateCategoryOrder(ids);
    });
  }

  Future<VoidCallback> deleteCategoryWithUndo(String id) async {
    final cat = categories.firstWhere((c) => c.id == id);
    final idx = categories.indexOf(cat);
    final childSnapshots = categories
        .where((c) => c.parentId == id)
        .map((c) => c)
        .toList();
    categories = categories
        .where((c) => c.id != id)
        .map((c) => c.parentId == id ? c.copyWith(clearParentId: true) : c)
        .toList();
    await DBHelper.deleteCategory(id);
    notifyListeners();
    return () {
      final next = List<AppCategory>.from(categories);
      final restoreIdx = idx.clamp(0, next.length);
      next.insert(restoreIdx, cat);
      for (int i = 0; i < next.length; i++) {
        if (childSnapshots.any((cs) => cs.id == next[i].id)) {
          next[i] = next[i].copyWith(parentId: id);
        }
      }
      categories = next;
      notifyListeners();
      _serializeMutation(() async {
        await DBHelper.insertCategory(cat);
        for (final child in childSnapshots) {
          await DBHelper.updateCategory(child);
        }
      });
    };
  }

  void reorderAccounts(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    final next = List<Account>.from(accounts);
    final item = next.removeAt(oldIndex);
    next.insert(newIndex, item);
    accounts = next;
    notifyListeners();
    final ids = next.map((a) => a.id).toList();
    _serializeMutation(() async {
      await DBHelper.updateAccountOrder(ids);
    });
  }

  double getBankTotalBalance(String id) {
    final acc = accountById(id);
    if (acc == null) return 0;
    return acc.balance; // Simplified. You could sum transactions if needed.
  }

  Future<VoidCallback> deleteTransactionWithUndo(String id) async {
    final tx = transactions.firstWhere((t) => t.id == id);
    if (tx.transferGroupId != null && tx.transferGroupId!.isNotEmpty) {
      final groupMembers = transactions
          .where((t) => t.transferGroupId == tx.transferGroupId)
          .toList();
      final groupSplits = <String, List<TransactionSplit>>{
        for (final m in groupMembers)
          m.id: List<TransactionSplit>.from(getSplits(m.id)),
      };
      await deleteTransaction(id);
      return () async {
        await _serializeMutation(() async {
          for (final member in groupMembers) {
            final delta = _txDelta(member);
            final balAccId = balanceAccountIdFor(member.accountId);
            await DBHelper.applyTransactionWithBalance(member, delta);
            _patchAccountBalance(balAccId, delta);
            _insertTransactionInMemory(member);
            final mSplits = groupSplits[member.id] ?? const [];
            if (mSplits.isNotEmpty) {
              await DBHelper.saveTransactionSplits(member.id, mSplits);
            }
          }
          splits = await DBHelper.getAllSplits();
          _rebuildSplitsCache();
          notifyListeners();
          updateHomeWidgets();
          recordNetWorthSnapshot();
        });
      };
    }

    final txSplits = List<TransactionSplit>.from(getSplits(id));
    await deleteTransaction(id);
    return () async {
      await addTransaction(tx, splits: txSplits.isNotEmpty ? txSplits : null);
    };
  }

  Future<VoidCallback> deleteLendedPersonWithUndo(String id) async {
    final person = lendedPeople.firstWhere((p) => p.id == id);
    final personLended = lended.where((l) => l.personId == id).toList();
    
    await deleteLendedPerson(id);
    return () async {
      await addLendedPerson(person);
      for (final l in personLended) {
        await addLended(l);
      }
    };
  }

  Future<VoidCallback> deleteRecurringWithUndo(String id) async {
    final rec = recurring.firstWhere((r) => r.id == id);
    final history = await DBHelper.getRecurringHistory(id);
    await deleteRecurring(id);
    return () async {
      await addRecurring(rec);
      for (final h in history) {
        await DBHelper.insertRecurringHistory(h);
      }
      _historyCache.remove(id);
      recurringHistoryCount = await DBHelper.getRecurringHistoryCount();
      notifyListeners();
    };
  }

  Future<VoidCallback> deleteWishlistWithUndo(String id) async {
    final item = wishlist.firstWhere((w) => w.id == id);
    await deleteWishlist(id);
    return () async {
      await addWishlist(item);
    };
  }

  List<AppTransaction> getAccountTransactions(String id) {
    return transactions
        .where((t) => t.accountId == id || t.paidViaAccountId == id)
        .toList();
  }

  double getAccountIncome(String id) {
    return getAccountTransactions(id)
        .where((t) => t.type == 'income' && !FinancialAggregations.isExcludedFromTotals(t))
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double getAccountExpense(String id) {
    return getAccountTransactions(id)
        .where((t) => t.type == 'expense' && !FinancialAggregations.isExcludedFromTotals(t))
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  List<AppTransaction> findPossibleDuplicates(AppTransaction tx, {String? excludeId}) {
    if (tx.isTransfer || tx.isInvestment) return const [];
    return transactions.where((t) =>
      t.id != excludeId &&
      !t.isTransfer &&
      !t.isInvestment &&
      t.accountId == tx.accountId &&
      t.amount == tx.amount &&
      t.type == tx.type &&
      t.date.difference(tx.date).inDays.abs() <= 2
    ).toList();
  }
}
