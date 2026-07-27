// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Expensy';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_appearance => 'Appearance';

  @override
  String get settings_theme => 'Theme';

  @override
  String get settings_system => 'System';

  @override
  String get settings_light => 'Light';

  @override
  String get settings_dark => 'Dark';

  @override
  String get settings_amoledTitle => 'Pure Black (AMOLED)';

  @override
  String get settings_amoledSubtitle => 'Forces black backgrounds in dark mode';

  @override
  String get settings_accentColor => 'Accent Colour';

  @override
  String get settings_appFont => 'App Font';

  @override
  String get settings_systemDefault => 'System Default';

  @override
  String get settings_currency => 'Currency';

  @override
  String get settings_defaultCurrency => 'Default Currency';

  @override
  String get settings_preferences => 'Preferences';

  @override
  String get settings_weekStartsOn => 'Week Starts On';

  @override
  String get settings_monday => 'Monday';

  @override
  String get settings_sunday => 'Sunday';

  @override
  String get settings_hideBalance => 'Hide Balance';

  @override
  String get settings_hideBalanceSubtitle => 'Show ••••• instead of amounts';

  @override
  String get settings_language => 'Language';

  @override
  String get settings_profile => 'Profile';

  @override
  String get settings_displayName => 'Display Name';

  @override
  String get settings_notSet => 'Not set';

  @override
  String get settings_about => 'About';

  @override
  String get settings_version => 'Version';

  @override
  String get settings_privacy => 'Privacy';

  @override
  String get settings_privacySubtitle =>
      'All data stored locally — 100% offline';

  @override
  String get settings_github => 'GitHub';

  @override
  String get settings_githubSubtitle => 'View source code';

  @override
  String get settings_developer => 'Developer';

  @override
  String get settings_developerSubtitle =>
      'Discover more projects by Mina Android';

  @override
  String get settings_githubProfile => 'GitHub Profile';

  @override
  String get settings_developerWebsite => 'Developer Website';

  @override
  String get settings_close => 'Close';

  @override
  String get settings_yourName => 'Your name';

  @override
  String get settings_cancel => 'Cancel';

  @override
  String get settings_save => 'Save';

  @override
  String recurring_expenses(Object count) {
    return 'Expenses ($count)';
  }

  @override
  String recurring_incomeList(Object count) {
    return 'Income ($count)';
  }

  @override
  String get recurring_monthly => 'Monthly';

  @override
  String get recurring_weekly => 'Weekly';

  @override
  String get recurring_noRecurringExpenses => 'No recurring expenses';

  @override
  String get recurring_noRecurringIncome => 'No recurring income';

  @override
  String get recurring_addExpense => 'Add Expense';

  @override
  String get recurring_addIncome => 'Add Income';

  @override
  String get recurring_tapPlusToAddOne => 'Tap + to add one';

  @override
  String recurring_fromOngoing(Object date) {
    return 'From $date · Ongoing';
  }

  @override
  String recurring_paidPayments(Object paid, Object total) {
    return '$paid/$total paid';
  }

  @override
  String recurring_totalAmount(Object amount) {
    return 'Total: $amount';
  }

  @override
  String get recurring_overdue => 'Overdue!';

  @override
  String get recurring_dueToday => 'Due Today';

  @override
  String recurring_dueInDays(Object days) {
    return 'Due in ${days}d';
  }

  @override
  String get recurring_edit => 'Edit';

  @override
  String get recurring_skipBtn => 'Skip';

  @override
  String recurring_nextDate(Object date) {
    return 'Next: $date';
  }

  @override
  String get recurring_pay => 'Pay';

  @override
  String get recurring_del => 'Del';

  @override
  String recurring_historyCount(Object count) {
    return 'History ($count)';
  }

  @override
  String get recurring_paymentHistory => 'Payment history';

  @override
  String get recurring_notificationPermissionDenied =>
      'Notification permission denied. Enable it in Settings → Apps → Expensy → Notifications.';

  @override
  String get recurring_remindMeAt => 'Remind me at';

  @override
  String get recurring_editRecurring => 'Edit Recurring';

  @override
  String get recurring_addRecurring => 'Add a Recurring Payment';

  @override
  String get recurring_name => 'Name';

  @override
  String get recurring_amountPerPayment => 'Amount per payment';

  @override
  String recurring_firstDate(Object date) {
    return 'First: $date';
  }

  @override
  String recurring_lastDate(Object date) {
    return 'Last: $date';
  }

  @override
  String get recurring_noLastPaymentOngoing => 'No last payment (ongoing)';

  @override
  String get accounts_refreshExchangeRates => 'Refresh exchange rates';

  @override
  String get accounts_noAccounts => 'No accounts';

  @override
  String get accounts_tapPlusToAddYourFirst =>
      'Tap + to add your first account';

  @override
  String get accounts_fetchingExchangeRates => 'Fetching exchange rates…';

  @override
  String get accounts_exchangeRatesUnavailable =>
      'Exchange rates unavailable (offline). Balances shown in native currency.';

  @override
  String get accounts_unknown => 'Unknown';

  @override
  String accounts_ratesUpdated(Object timeStr) {
    return 'Rates updated $timeStr · Tap ↺ to refresh';
  }

  @override
  String get accounts_goldCaps => 'GOLD';

  @override
  String get accounts_balance => 'Balance';

  @override
  String get accounts_income => 'Income';

  @override
  String get accounts_expense => 'Expense';

  @override
  String get accounts_txs => 'Txs';

  @override
  String get accounts_value => 'Value';

  @override
  String get accounts_karat => 'Karat';

  @override
  String accounts_pure(Object percentage) {
    return '$percentage% pure';
  }

  @override
  String get accounts_weightLabel => 'Weight';

  @override
  String get accounts_perGram => 'Per gram';

  @override
  String get accounts_bank => 'Bank';

  @override
  String get accounts_cash => 'Cash';

  @override
  String get accounts_savings => 'Savings';

  @override
  String get accounts_creditCard => 'Credit Card';

  @override
  String get accounts_eWallet => 'E-Wallet';

  @override
  String get accounts_gold => 'Gold';

  @override
  String get accounts_editAccount => 'Edit Account';

  @override
  String get accounts_addAccount => 'Add New Account';

  @override
  String get accounts_accountName => 'Account Name';

  @override
  String get accounts_weightInGrams => 'Weight in grams';

  @override
  String get accounts_initialBalance => 'Initial Balance';

  @override
  String get accounts_wontCountTowardYourHome =>
      'Won\'t count toward your home screen total';

  @override
  String get accounts_saveChanges => 'Save Changes';

  @override
  String get accounts_addAccountBtn => 'Add Account';

  @override
  String get accounts_fetchingGoldPrice => 'Fetching gold price…';

  @override
  String get accounts_goldPriceUnavailable =>
      'Gold price unavailable — check your connection';

  @override
  String lended_person_owesYou(Object name) {
    return '$name owes you';
  }

  @override
  String lended_person_youOwe(Object name) {
    return 'You owe $name';
  }

  @override
  String get lended_person_allSettledUp => 'All settled up';

  @override
  String get lended_person_noRecordsYet => 'No records yet';

  @override
  String get lended_person_tapPlusToLog =>
      'Tap + to log money lent or borrowed';

  @override
  String get lended_person_name => 'Name';

  @override
  String get lended_person_notesOptional => 'Notes (optional)';

  @override
  String get lended_person_lent => 'Lent';

  @override
  String get lended_person_borrowed => 'Borrowed';

  @override
  String get lended_person_overdue => 'Overdue!';

  @override
  String lended_person_due(Object date) {
    return 'Due $date';
  }

  @override
  String lended_person_reminderAt(Object time) {
    return 'Reminder at $time';
  }

  @override
  String get lended_person_notificationPermissionDenied =>
      'Notification permission denied. Enable it in Settings → Apps → Expensy → Notifications.';

  @override
  String get lended_person_remindMeAtPrompt => 'Remind me at';

  @override
  String get lended_person_editRecord => 'Edit Record';

  @override
  String get lended_person_addRecord => 'Add Record';

  @override
  String get lended_person_amount => 'Amount';

  @override
  String lended_person_dueColon(Object date) {
    return 'Due: $date';
  }

  @override
  String get lended_person_noDueDate => 'No due date';

  @override
  String get lended_person_setDueFirst => 'Set a due date first';

  @override
  String get lended_person_notifiedOnDue =>
      'You\'ll be notified on the due date';

  @override
  String get lended_person_getNotifiedWhenDue =>
      'Get notified when this is due';

  @override
  String get lended_person_thatTimePassed =>
      'That time today has already passed — you\'ll be notified shortly instead.';

  @override
  String lended_person_notificationFiresOn(Object date, Object time) {
    return 'Notification fires on $date at $time.';
  }

  @override
  String get lended_person_saveChangesBtn => 'Save Changes';

  @override
  String get lended_person_addRecordBtn => 'Add Record';

  @override
  String get transactions_searchTransactions => 'Search transactions...';

  @override
  String get transactions_all => 'All';

  @override
  String get transactions_income => 'Income';

  @override
  String get transactions_expenses => 'Expenses';

  @override
  String get transactions_lent => 'Lent';

  @override
  String get transactions_borrowed => 'Borrowed';

  @override
  String get transactions_noTransactions => 'No transactions';

  @override
  String get transactions_tapPlusToAddOne => 'Tap + to add one';

  @override
  String get transactions_today => 'Today';

  @override
  String get transactions_yesterday => 'Yesterday';

  @override
  String transactions_lentTo(Object name) {
    return 'Lent to $name';
  }

  @override
  String transactions_borrowedFrom(Object name) {
    return 'Borrowed from $name';
  }

  @override
  String get transactions_unknown => 'Unknown';

  @override
  String transactions_due(Object date) {
    return 'Due $date';
  }

  @override
  String get transactions_unsettled => 'Unsettled';

  @override
  String get onboarding_restoreFailed =>
      'Restore failed: the file may be corrupted or not an Expensy backup.';

  @override
  String get onboarding_continue => 'Continue';

  @override
  String get onboarding_getStarted => 'Get Started';

  @override
  String get onboarding_yourPersonalTracker =>
      'Your personal, 100% offline finance tracker.\nAlready have a backup from another device or a previous install?';

  @override
  String get onboarding_restoring => 'Restoring...';

  @override
  String get onboarding_chooseBackupFile => 'Choose Backup File';

  @override
  String get onboarding_letsGetYouSetUp => 'Let\'s get you set up';

  @override
  String get onboarding_yourName => 'Your name';

  @override
  String get onboarding_accountName => 'Account Name';

  @override
  String get onboarding_bank => 'Bank';

  @override
  String get onboarding_cash => 'Cash';

  @override
  String get onboarding_savings => 'Savings';

  @override
  String get onboarding_credit => 'Credit';

  @override
  String get onboarding_wallet => 'Wallet';

  @override
  String get onboarding_startingBalance => 'Starting Balance';

  @override
  String get backup_replaceDataWarning =>
      'This will replace ALL your current data with the backup.\nThis cannot be undone.';

  @override
  String get backup_whatsIncluded => 'What\'s included';

  @override
  String get backup_backupDescription =>
      'Every backup includes all of your data — accounts, transactions, recurring payments and their pay/skip history, budgets, wishlist items, lent & borrowed people and records, assets, categories, and app settings.';

  @override
  String get backup_saving => 'Saving...';

  @override
  String get backup_saveBackup => 'Save Backup';

  @override
  String get backup_restoring => 'Restoring...';

  @override
  String get backup_restoreBackupBtn => 'Restore Backup';

  @override
  String get backup_restoreWarningText =>
      'Compatible with backups from any app version. Missing fields are filled with safe defaults.';

  @override
  String get backup_included => 'included';

  @override
  String get backup_accounts => 'Accounts';

  @override
  String get backup_transactions => 'Transactions';

  @override
  String get backup_recurringPayments => 'Recurring Payments';

  @override
  String get backup_recurringHistory => 'Recurring History';

  @override
  String get backup_budgets => 'Budgets';

  @override
  String get backup_wishlist => 'Wishlist';

  @override
  String get backup_lentPeople => 'Lent/Borrowed — People';

  @override
  String get backup_lentRecords => 'Lent/Borrowed — Records';

  @override
  String get backup_assets => 'Assets';

  @override
  String get backup_categories => 'Categories';

  @override
  String get backup_settings => 'Settings';

  @override
  String backup_backupSavedSuccessfully(Object savedPath) {
    return 'Backup saved successfully:\n$savedPath';
  }

  @override
  String backup_backupFailed(Object error) {
    return 'Backup failed: $error';
  }

  @override
  String backup_upgradedFrom(Object originalVersion, Object schemaVersion) {
    return ' (upgraded from v$originalVersion → v$schemaVersion)';
  }

  @override
  String backup_dataRestoredSuccessfully(Object vLabel) {
    return 'Data restored successfully!$vLabel';
  }

  @override
  String backup_restoreFailed(Object error) {
    return 'Restore failed: $error';
  }

  @override
  String get backup_restoreFailedCorrupted =>
      'Restore failed: the file may be corrupted or not an Expensy backup.';

  @override
  String get budget_noBudgetsYet => 'No budgets yet';

  @override
  String get budget_tapToAddBudget =>
      'Tap + to set a spending limit per category';

  @override
  String get budget_budgeted => 'Budgeted';

  @override
  String get budget_spent => 'Spent';

  @override
  String get budget_overLimit => 'Over limit';

  @override
  String get budget_unknown => 'Unknown';

  @override
  String get budget_weeklyLabel => 'Weekly';

  @override
  String get budget_monthlyLabel => 'Monthly';

  @override
  String budget_overAmount(Object amount) {
    return '$amount over';
  }

  @override
  String budget_leftAmount(Object amount) {
    return '$amount left';
  }

  @override
  String budget_percentUsed(Object percent) {
    return '$percent% used';
  }

  @override
  String get budget_editBudget => 'Edit Budget';

  @override
  String get budget_setBudget => 'Add New Budget';

  @override
  String get budget_budgetAmount => 'Budget amount';

  @override
  String budget_previewFor(Object catName) {
    return 'Preview for \"$catName\"';
  }

  @override
  String budget_spentAmount(Object amount) {
    return 'Spent: $amount';
  }

  @override
  String budget_ofAmount(Object amount) {
    return 'of $amount';
  }

  @override
  String get budget_saveChanges => 'Save Changes';

  @override
  String get budget_budget => 'Budget';

  @override
  String get insights_other => 'Other';

  @override
  String get insights_noDataYet => 'No data yet';

  @override
  String get insights_addSomeTransactions =>
      'Add some transactions to see insights';

  @override
  String get insights_thisMonthVsLastMonth => 'This Month vs Last Month';

  @override
  String get insights_dailyAverage => 'Daily Average';

  @override
  String insights_perDayBasedOn(Object days) {
    return 'per day · based on $days days this month';
  }

  @override
  String get insights_incomeVsExpenses => 'Income vs Expenses';

  @override
  String insights_incomeAmount(Object amount) {
    return 'Income $amount';
  }

  @override
  String insights_expensesAmount(Object amount) {
    return 'Expenses $amount';
  }

  @override
  String insights_percentSaved(Object percent) {
    return '$percent% saved this month';
  }

  @override
  String get insights_topSpendingCategories => 'Top Spending Categories';

  @override
  String insights_percentOfTotal(Object percent) {
    return '$percent% of total';
  }

  @override
  String get insights_biggestExpenseThisMonth => 'Biggest Expense This Month';

  @override
  String get insights_categoryTrends => 'Category Trends (vs Last Month)';

  @override
  String get insights_12MonthTrend => '12-Month Trend';

  @override
  String get insights_incomeLabel => 'Income';

  @override
  String get insights_expensesLabel => 'Expenses';

  @override
  String get categories_expenseLabel => 'Expense';

  @override
  String get categories_incomeLabel => 'Income';

  @override
  String get categories_editCategory => 'Edit Category';

  @override
  String get categories_addCategory => 'Add Category';

  @override
  String get categories_categoryName => 'Category Name';

  @override
  String get categories_saveChanges => 'Save Changes';

  @override
  String get statistics_other => 'Other';

  @override
  String get statistics_allAccounts => 'All accounts';

  @override
  String get statistics_income => 'Income';

  @override
  String get statistics_expenses => 'Expenses';

  @override
  String get statistics_expense => 'Expense';

  @override
  String get statistics_net => 'Net';

  @override
  String statistics_6MonthOverviewAccount(Object accountName) {
    return '6-Month Overview · $accountName';
  }

  @override
  String get statistics_6MonthOverview => '6-Month Overview';

  @override
  String statistics_percentOfBudget(Object percent) {
    return '$percent% of budget';
  }

  @override
  String get add_transaction_editTransaction => 'Edit Transaction';

  @override
  String get add_transaction_addTransaction => 'Enter Transaction';

  @override
  String get add_transaction_amount => 'Amount';

  @override
  String add_transaction_conversionPreview(Object accountName, Object amount) {
    return '≈ $amount will be deducted from $accountName';
  }

  @override
  String get add_transaction_accountFallback => 'account';

  @override
  String get add_transaction_descriptionOptional => 'Description (optional)';

  @override
  String get add_transaction_noteOptional => 'Note (optional)';

  @override
  String get add_transaction_saveChanges => 'Save Changes';

  @override
  String get more_statistics => 'Statistics';

  @override
  String get more_statisticsSub => 'Charts & monthly summary';

  @override
  String get more_insights => 'Insights';

  @override
  String get more_insightsSub => 'Trends, averages & category analysis';

  @override
  String get more_currencyConverter => 'Currency Converter';

  @override
  String get more_currencyConverterSub =>
      'Convert between currencies instantly';

  @override
  String get more_wishlist => 'Wishlist';

  @override
  String more_wishlistSub(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String get more_lentMoney => 'Lent Money';

  @override
  String more_lentMoneySub(Object count) {
    return '$count outstanding';
  }

  @override
  String get more_assets => 'Assets';

  @override
  String more_assetsSub(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String get more_categories => 'Categories';

  @override
  String more_categoriesSub(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count categories',
      one: '1 category',
    );
    return '$_temp0';
  }

  @override
  String get more_exportTransactions => 'Export Transactions';

  @override
  String get more_exportTransactionsSub => 'Save as Excel (.xlsx)';

  @override
  String get more_backupRestore => 'Backup & Restore';

  @override
  String get more_backupRestoreSub => 'Save or load your data';

  @override
  String get more_settings => 'Settings';

  @override
  String get more_settingsSub => 'Theme, currency & preferences';

  @override
  String home_greeting(Object name) {
    return 'Hi, $name 👋';
  }

  @override
  String get home_there => 'there';

  @override
  String get home_income => 'Income';

  @override
  String get home_expenses => 'Expenses';

  @override
  String get home_net => 'Net';

  @override
  String get wishlist_noItems => 'No wishlist items';

  @override
  String get wishlist_noItemsSub => 'Tap + to add items you\'re saving for';

  @override
  String get wishlist_editItem => 'Edit Item';

  @override
  String get wishlist_addWishlistItem => 'Add Wishlist Item';

  @override
  String get wishlist_itemName => 'Item Name';

  @override
  String get wishlist_targetPrice => 'Target Price';

  @override
  String get wishlist_priorityLow => 'Low';

  @override
  String get wishlist_priorityMedium => 'Medium';

  @override
  String get wishlist_priorityHigh => 'High';

  @override
  String get wishlist_notesOptional => 'Notes (optional)';

  @override
  String get wishlist_saveChanges => 'Save Changes';

  @override
  String get wishlist_addItem => 'Add Item';

  @override
  String get lended_theyOweMe => 'They Owe Me';

  @override
  String get lended_iOweThem => 'I Owe Them';

  @override
  String get lended_net => 'Net';

  @override
  String get lended_noOneYet => 'No one yet';

  @override
  String get lended_noOneYetSub =>
      'Tap + to add a person you lend to or borrow from';

  @override
  String get lended_owesYou => 'Owes you';

  @override
  String get lended_youOwe => 'You owe';

  @override
  String get lended_settledUp => 'Settled up';

  @override
  String get lended_noActiveRecords => 'No active records';

  @override
  String lended_activeRecords(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count active records',
      one: '1 active record',
    );
    return '$_temp0';
  }

  @override
  String get lended_editPerson => 'Edit Person';

  @override
  String get lended_addPerson => 'Add Person';

  @override
  String get lended_name => 'Name';

  @override
  String get lended_notesOptional => 'Notes (optional)';

  @override
  String get lended_saveChanges => 'Save Changes';

  @override
  String get assets_totalAssets => 'Total Assets';

  @override
  String get assets_items => 'Items';

  @override
  String get assets_noAssetsYet => 'No assets yet';

  @override
  String get assets_noAssetsYetSub => 'Tap + to add a product or asset';

  @override
  String get assets_editAsset => 'Edit Asset';

  @override
  String get assets_addAsset => 'Add Asset';

  @override
  String get assets_productAssetName => 'Product / Asset Name';

  @override
  String get assets_value => 'Value';

  @override
  String get assets_notesOptional => 'Notes (optional)';

  @override
  String get assets_saveChanges => 'Save Changes';

  @override
  String get currency_converter_loadingRates => 'Loading exchange rates…';

  @override
  String get currency_converter_ratesUnavailable =>
      'Exchange rates unavailable. Connect to the internet and sync.';

  @override
  String get currency_converter_rateAgeJustNow => 'Just now';

  @override
  String currency_converter_rateAgeMins(Object minutes) {
    return '${minutes}m ago';
  }

  @override
  String currency_converter_rateAgeHours(Object hours) {
    return '${hours}h ago';
  }

  @override
  String currency_converter_rateAgeDays(Object days) {
    return '${days}d ago';
  }

  @override
  String currency_converter_commonConversions(Object fromCurrency) {
    return 'Common Conversions from $fromCurrency';
  }

  @override
  String transfer_fromAcc(Object currency) {
    return 'From ($currency)';
  }

  @override
  String transfer_toAcc(Object currency) {
    return 'To ($currency)';
  }

  @override
  String get transfer_exchangeRatesNotLoaded =>
      'Exchange rates not loaded — amount will be transferred as-is';

  @override
  String get transfer_amount => 'Amount';

  @override
  String get transfer_noteOptional => 'Note (optional)';

  @override
  String get export_from => 'From';

  @override
  String get export_to => 'To';

  @override
  String export_txCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transactions in range',
      one: '1 transaction in range',
    );
    return '$_temp0';
  }

  @override
  String export_saved(Object path) {
    return 'Saved: $path';
  }

  @override
  String get export_complete => 'Export complete';

  @override
  String get export_exporting => 'Exporting...';

  @override
  String get export_exportAsExcel => 'Export as Excel';

  @override
  String shared_widgets_deleteConfirm(Object name) {
    return 'Delete \"$name\"? This cannot be undone.';
  }

  @override
  String get shared_widgets_searchByCode => 'Search by code or name...';

  @override
  String get accounts_accounts => 'Accounts';

  @override
  String get accounts_totalBalance => 'Total Balance';

  @override
  String get accounts_excluded => 'Excluded';

  @override
  String get accounts_goldPriceNotYetLoade =>
      'Gold price not yet loaded. Wait a moment and try again.';

  @override
  String get accounts_accountType => 'Account Type';

  @override
  String get accounts_currency => 'Currency';

  @override
  String get accounts_goldPurityKarat => 'Gold Purity (Karat)';

  @override
  String get accounts_weight => 'Weight';

  @override
  String get accounts_excludeFromTotalBala => 'Exclude from Total Balance';

  @override
  String get accounts_colour => 'Colour';

  @override
  String get accounts_liveGoldValue => 'Live Gold Value';

  @override
  String get accounts_enterWeightAboveToSe => 'Enter weight above to see value';

  @override
  String get add_transaction_expense => 'Expense';

  @override
  String get add_transaction_income => 'Income';

  @override
  String get add_transaction_account => 'Account';

  @override
  String get add_transaction_category => 'Category';

  @override
  String get assets_assets => 'Assets';

  @override
  String get backup_restoreBackup => 'Restore Backup?';

  @override
  String get backup_cancel => 'Cancel';

  @override
  String get backup_replaceData => 'Replace Data';

  @override
  String get backup_backupRestore => 'Backup & Restore';

  @override
  String get backup_everythingAlways => 'Everything, always';

  @override
  String get backup_createBackup => 'Create Backup';

  @override
  String get backup_saveAsJson => 'Save as JSON';

  @override
  String get backup_exportsAllAppDataToA =>
      'Exports ALL app data to a portable file';

  @override
  String get backup_restoreBackup_ => 'Restore Backup';

  @override
  String get backup_loadFromJson => 'Load from JSON';

  @override
  String get backup_picksABackupFileAndR =>
      'Picks a backup file and restores it';

  @override
  String get backup_thisOverwritesAllCur => 'This overwrites ALL current data.';

  @override
  String get budget_budgets => 'Budgets';

  @override
  String get budget_empty => ' · ';

  @override
  String get budget_overBudget => 'Over budget';

  @override
  String get budget_thisCategoryAlreadyH =>
      'This category already has a budget. Tap it to edit.';

  @override
  String get budget_period => 'Period';

  @override
  String get budget_monthly => 'Monthly';

  @override
  String get budget_weekly => 'Weekly';

  @override
  String get budget_category => 'Category';

  @override
  String get categories_categories => 'Categories';

  @override
  String get categories_expense => 'Expense';

  @override
  String get categories_income => 'Income';

  @override
  String get categories_colour => 'Colour';

  @override
  String get categories_icon => 'Icon';

  @override
  String get categories_autoBasedOnName => 'Auto (based on name)';

  @override
  String get categories_expenseCategories => 'Expense Categories';

  @override
  String get categories_incomeCategories => 'Income Categories';

  @override
  String get currency_converter_currencyConverter => 'Currency Converter';

  @override
  String get currency_converter_amount => 'Amount';

  @override
  String get currency_converter_convertedTo => 'Converted to';

  @override
  String get export_exportTransactions => 'Export Transactions';

  @override
  String get export_dateRange => 'Date Range';

  @override
  String get export_formatExcelXlsx => 'Format: Excel (.xlsx)';

  @override
  String get home_totalBalance => 'Total Balance';

  @override
  String get home_accounts => 'Accounts';

  @override
  String get home_recentTransactions => 'Recent Transactions';

  @override
  String get home_noTransactionsYet => 'No transactions yet';

  @override
  String get home_add => 'Add';

  @override
  String get insights_insights => 'Insights';

  @override
  String get lended_person_deletePerson => 'Delete person';

  @override
  String get lended_person_editPerson => 'Edit Person';

  @override
  String get lended_person_colour => 'Colour';

  @override
  String get lended_person_saveChanges => 'Save Changes';

  @override
  String get lended_person_settled => 'SETTLED';

  @override
  String get lended_person_settle => 'Settle';

  @override
  String get lended_person_setADueDateFirstToEn =>
      'Set a due date first to enable reminders.';

  @override
  String get lended_person_iLent => 'I Lent';

  @override
  String get lended_person_iBorrowed => 'I Borrowed';

  @override
  String get lended_person_accountOptional => 'Account (optional)';

  @override
  String get lended_person_dueDateReminder => 'Due Date Reminder';

  @override
  String get lended_person_remindMeAt => 'Remind me at';

  @override
  String get lended_person_active => 'Active';

  @override
  String get lended_person_settled_ => 'Settled';

  @override
  String get lended_lentMoney => 'Lent Money';

  @override
  String get lended_overdue => 'OVERDUE';

  @override
  String get lended_colour => 'Colour';

  @override
  String get more_more => 'More';

  @override
  String get onboarding_back => 'Back';

  @override
  String get onboarding_welcomeToExpensy => 'Welcome to Expensy!';

  @override
  String get onboarding_restoreABackup => 'Restore a Backup';

  @override
  String get onboarding_loadAPreviouslySaved =>
      'Load a previously saved Expensy JSON file';

  @override
  String get onboarding_or => 'or';

  @override
  String get onboarding_startFresh => 'Start Fresh';

  @override
  String get onboarding_firstWhatShouldWeCal =>
      'First, what should we call you?';

  @override
  String get onboarding_defaultCurrency => 'Default Currency';

  @override
  String get onboarding_thisWillBeUsedAcross =>
      'This will be used across the app.\\nYou can change it later in Settings.';

  @override
  String get onboarding_searchAllCurrencies => 'Search all currencies';

  @override
  String get onboarding_yourFirstAccount => 'Your First Account';

  @override
  String get onboarding_setUpYourMainAccount =>
      'Set up your main account to start tracking.';

  @override
  String get onboarding_accountType => 'Account Type';

  @override
  String get onboarding_currency => 'Currency';

  @override
  String get onboarding_colour => 'Colour';

  @override
  String get recurring_recurring => 'Recurring';

  @override
  String get recurring_income => 'INCOME';

  @override
  String get recurring_2D => '−2d';

  @override
  String get recurring_skipNextPayment => 'Skip Next Payment?';

  @override
  String get recurring_cancel => 'Cancel';

  @override
  String get recurring_skip => 'Skip';

  @override
  String get recurring_noHistoryYet => 'No history yet';

  @override
  String get recurring_expense => 'Expense';

  @override
  String get recurring_income_ => 'Income';

  @override
  String get recurring_every => 'Every ';

  @override
  String get recurring_days => 'Days';

  @override
  String get recurring_weeks => 'Weeks';

  @override
  String get recurring_months => 'Months';

  @override
  String get recurring_years => 'Years';

  @override
  String get recurring_payments => 'Payments';

  @override
  String get recurring_totalCost => 'Total Cost';

  @override
  String get recurring_account => 'Account';

  @override
  String get recurring_category => 'Category';

  @override
  String get recurring_paymentReminder => 'Payment Reminder';

  @override
  String get recurring_notificationWillFire =>
      'Notification will fire on the next due date at this time.';

  @override
  String get recurring_remind2DaysBefore => 'Remind 2 days before';

  @override
  String get statistics_statistics => 'Statistics';

  @override
  String get statistics_expensesByCategory => 'Expenses by Category';

  @override
  String get transactions_transactions => 'Transactions';

  @override
  String get transactions_settled => 'Settled';

  @override
  String get transfer_transfer => 'Transfer';

  @override
  String get transfer_from => 'FROM';

  @override
  String get transfer_to => 'TO';

  @override
  String get transfer_enterAnAmountToSeeTh =>
      'Enter an amount to see the conversion';

  @override
  String get wishlist_wishlist => 'Wishlist';

  @override
  String get wishlist_priority => 'Priority';

  @override
  String get shared_widgets_delete => 'Delete?';

  @override
  String get shared_widgets_cancel => 'Cancel';

  @override
  String get shared_widgets_delete_ => 'Delete';

  @override
  String get shared_widgets_none => 'None';

  @override
  String get shared_widgets_selectCurrency => 'Select Currency';

  @override
  String get main_home => 'Home';

  @override
  String get main_transactions => 'Transactions';

  @override
  String get main_recurring => 'Recurring';

  @override
  String get main_accounts => 'Accounts';

  @override
  String get main_budgets => 'Budgets';

  @override
  String get main_more => 'More';

  @override
  String get onboarding_chooseLanguage => 'Choose Language';

  @override
  String get error_required => 'This field is required';

  @override
  String recurring_subscriptions(Object count) {
    return 'Subscriptions ($count)';
  }

  @override
  String recurring_installments(Object count) {
    return 'Installments ($count)';
  }

  @override
  String get recurring_recurringType => 'Recurring Type';

  @override
  String get recurring_subscription => 'Subscription';

  @override
  String get recurring_installment => 'Installment';

  @override
  String get recurring_installmentsRequireEndDate =>
      'Installments must have a final payment date.';

  @override
  String get backup_importFromOtherApps => 'Import from Other Apps';

  @override
  String get backup_importDescription => 'Import data from supported apps';

  @override
  String get backup_importFromGreenStash => 'Import from GreenStash (.json)';
}
