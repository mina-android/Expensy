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
  String get settings_systemDefault => 'System Default';

  @override
  String get settings_dynamicColor => 'Dynamic Color';

  @override
  String get settings_dynamicColorSubtitle => 'Use system wallpaper colors';

  @override
  String get settings_accentColor => 'Accent Color';

  @override
  String get settings_accentColorSubtitle => 'Choose a seed color for the app';

  @override
  String get settings_appFont => 'App Font';

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
  String get budget_leftToSpend => 'Left to Spend';

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
  String get budget_rollover => 'Rollover (Envelope)';

  @override
  String get budget_rolloverDesc =>
      'Carry forward unused surplus or deficits to the next period';

  @override
  String get budget_rolloverBadge => 'Rollover';

  @override
  String budget_base(Object amount) {
    return 'Base: $amount';
  }

  @override
  String budget_rolloverFrom(Object period, Object amount) {
    return 'Rollover ($period): $amount';
  }

  @override
  String budget_totalAvailable(Object amount) {
    return 'Total Available: $amount';
  }

  @override
  String get budget_lastWeek => 'Last Week';

  @override
  String get pacing_dailyBudget => 'Safe-to-Spend';

  @override
  String pacing_safeToSpend(Object amount, Object days) {
    return 'Safe to spend: $amount/day ($days left)';
  }

  @override
  String pacing_caution(Object amount) {
    return 'Pacing fast — limit to $amount/day';
  }

  @override
  String get pacing_overPaced => 'Pace Alert — slow down to stay in budget';

  @override
  String get pacing_budgetExhausted =>
      'Budget reached — no daily allowance left';

  @override
  String get pacing_onTrack => 'On track';

  @override
  String get pacing_fast => 'Pacing fast';

  @override
  String get pacing_alert => 'Pace alert';

  @override
  String pacing_daysLeft(Object days) {
    return '$days days left';
  }

  @override
  String get pacing_setBudgetPrompt => 'Tap to set budget limits →';

  @override
  String get pacing_dailyAvgPace => 'Daily Pace';

  @override
  String pacing_perDay(Object amount) {
    return '$amount / day';
  }

  @override
  String get calendar_title => 'Financial Calendar';

  @override
  String get calendar_subtitle => 'Daily spending heatmap & due dates';

  @override
  String calendar_zeroSpendDays(Object count) {
    return '$count Zero-Spend Days';
  }

  @override
  String get calendar_zeroSpendDayTitle => 'Zero-Spend Day! 🎉';

  @override
  String get calendar_zeroSpendDayDesc =>
      'Great job maintaining financial discipline with no expenses today.';

  @override
  String get calendar_billsDue => 'Bills & Subscriptions Due';

  @override
  String get calendar_loansDue => 'Loan Payments Due';

  @override
  String get calendar_lendedDue => 'Expected Repayments';

  @override
  String calendar_dayTransactions(Object count) {
    return 'Transactions ($count)';
  }

  @override
  String get calendar_noActivity =>
      'No transactions or obligations on this date';

  @override
  String get calendar_today => 'Today';

  @override
  String calendar_averageDaily(Object amount) {
    return 'Daily avg: $amount';
  }

  @override
  String get wrapped_title => 'Expensy Wrapped';

  @override
  String wrapped_bannerTitle(Object month) {
    return 'Your $month Wrapped is ready!';
  }

  @override
  String get wrapped_bannerSub => 'Tap to explore your monthly financial story';

  @override
  String get wrapped_theBigPicture => 'The Big Picture';

  @override
  String wrapped_howMoneyMoved(Object month) {
    return 'Here is how your money moved in $month';
  }

  @override
  String get wrapped_totalInflow => 'Total Inflow';

  @override
  String get wrapped_totalOutflow => 'Total Outflow';

  @override
  String get wrapped_netSavings => 'Net Saved';

  @override
  String wrapped_savingsRate(Object rate) {
    return 'Savings Rate: $rate%';
  }

  @override
  String get wrapped_topCategoryTitle => 'Where Did It Go?';

  @override
  String wrapped_topCategorySub(Object category) {
    return 'Your top spending category was $category';
  }

  @override
  String wrapped_topCategoryShare(Object percent) {
    return '$percent% of your total spending';
  }

  @override
  String get wrapped_biggestSplurgeTitle => 'Biggest Splurge';

  @override
  String get wrapped_biggestSplurgeSub =>
      'Your single largest expense of the month';

  @override
  String get wrapped_noSplurge =>
      'No splurges! You had zero expenses this month.';

  @override
  String get wrapped_heroHabitTitle => 'Hero Habit';

  @override
  String wrapped_zeroSpendAchieved(Object count) {
    return '$count Zero-Spend Days';
  }

  @override
  String wrapped_heroHabitDesc(Object count) {
    return 'You achieved $count days with zero expenses. Outstanding financial discipline!';
  }

  @override
  String get wrapped_receiptTitle => 'Monthly Statement';

  @override
  String get wrapped_obscureToggle => 'Hide amounts for sharing';

  @override
  String get wrapped_showToggle => 'Show amounts';

  @override
  String get wrapped_replay => 'Replay Story';

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
  String get more_sectionTools => 'Financial Tools';

  @override
  String get more_sectionAnalytics => 'Analytics & Insights';

  @override
  String get more_sectionPreferences => 'Preferences & Data';

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
  String get wishlist_fundThisItem => 'Fund Item';

  @override
  String wishlist_funded(int percent, String saved, String target) {
    return '$percent% funded ($saved / $target)';
  }

  @override
  String get wishlist_goalAchieved => 'Goal Achieved — Ready to Buy!';

  @override
  String get wishlist_buyNow => 'Buy Now';

  @override
  String get wishlist_purchaseTitle => 'Purchase Wishlist Item';

  @override
  String get wishlist_purchasePrompt =>
      'Do you want to record an expense transaction to deduct this purchase from an account?';

  @override
  String get wishlist_recordAndDeduct => 'Record & Deduct';

  @override
  String get wishlist_markPurchasedOnly => 'Mark Purchased Only';

  @override
  String wishlist_itemPurchased(String name) {
    return '\"$name\" marked as purchased!';
  }

  @override
  String get wishlist_viewGoal => 'View Savings Goal';

  @override
  String savings_linkedWishlist(String item) {
    return 'Linked to Wishlist: $item';
  }

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
  String get accounts_dontLinkToCard => 'Don\'t link to Card';

  @override
  String get accounts_dontLinkToCardDesc =>
      'Manage this account\'s balance manually and prevent cards from linking to it';

  @override
  String get accounts_color => 'Color';

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
  String get categories_color => 'Color';

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
  String get export_exportAsPdf => 'Export as PDF Report';

  @override
  String get export_formatPdf => 'Format: PDF Financial Report (.pdf)';

  @override
  String get export_pdfGenerating => 'Generating PDF...';

  @override
  String get export_pdfTitle => 'Financial Report';

  @override
  String get export_pdfSummary => 'Executive Summary';

  @override
  String get export_pdfInflow => 'Total Inflow';

  @override
  String get export_pdfOutflow => 'Total Outflow';

  @override
  String get export_pdfNet => 'Net Savings';

  @override
  String get export_pdfSavingsRate => 'Savings Rate';

  @override
  String get export_pdfCategoryBreakdown => 'Category Breakdown';

  @override
  String get export_pdfTransactions => 'Itemized Transactions';

  @override
  String get export_pdfNetWorthBreakdown => 'Assets & Liabilities';

  @override
  String get export_pdfShare => 'Share Report';

  @override
  String get export_pdfPrint => 'Print / Preview';

  @override
  String get export_pdfGeneratedBy =>
      'Generated by Expensy • Private & Offline';

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
  String get home_goodMorning => 'Good morning';

  @override
  String get home_goodAfternoon => 'Good afternoon';

  @override
  String get home_goodEvening => 'Good evening';

  @override
  String get home_transferAction => 'Transfer';

  @override
  String get home_converterAction => 'Converter';

  @override
  String get home_insightsAction => 'Insights';

  @override
  String get home_calendarAction => 'Calendar';

  @override
  String get home_forecastAction => 'Forecast';

  @override
  String get home_manage => 'Manage';

  @override
  String get home_seeAll => 'See All';

  @override
  String get home_addAccount => 'Add Account';

  @override
  String get home_cards => 'Cards';

  @override
  String get home_addCard => 'Add Card';

  @override
  String get home_monthlyOverview => 'Monthly Overview';

  @override
  String get home_savingsRate => 'Savings Rate';

  @override
  String get insights_insights => 'Insights';

  @override
  String get lended_person_deletePerson => 'Delete person';

  @override
  String get lended_person_editPerson => 'Edit Person';

  @override
  String get lended_person_color => 'Color';

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
  String get lended_color => 'Color';

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
  String get onboarding_color => 'Color';

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

  @override
  String get backup_automaticBackup => 'Automatic Backup';

  @override
  String get backup_dailyAutoBackup => 'Daily Auto Backup';

  @override
  String backup_runsDailyAt(String time) {
    return 'Runs daily at $time';
  }

  @override
  String backup_lastBackup(String time) {
    return 'Last backup: $time';
  }

  @override
  String backup_savingTo(String path) {
    return 'Saving to: $path';
  }

  @override
  String get backup_changeTime => 'Change Time';

  @override
  String get backup_changeFolder => 'Change Folder';

  @override
  String get budget_budgetsAndGoals => 'Budgets & Goals';

  @override
  String get onboarding_restoreGreenStash => 'Restore from GreenStash (.json)';

  @override
  String get savings_goalNotFound => 'Goal not found';

  @override
  String get savings_savedSoFar => 'Saved so far';

  @override
  String get savings_target => 'Target';

  @override
  String savings_targetDate(String date) {
    return 'Target Date: $date';
  }

  @override
  String get savings_contribute => 'Contribute';

  @override
  String get savings_withdraw => 'Withdraw';

  @override
  String get savings_noAccounts =>
      'No accounts available. Please add an account first.';

  @override
  String get settings_budgetAlerts => 'Budget Alerts';

  @override
  String get settings_budgetAlertsSub =>
      'Notify when a budget or goal is reached';

  @override
  String get settings_dailyReminder => 'Daily Reminder';

  @override
  String get settings_dailyReminderSub => 'Remind to log transactions daily';

  @override
  String get settings_reminderTime => 'Reminder Time';

  @override
  String get settings_hapticFeedback => 'Haptic Feedback';

  @override
  String get settings_hapticFeedbackSub => 'Vibrate on interactions';

  @override
  String get savings_saveGoal => 'Save Goal';

  @override
  String get more_loans => 'Loans';

  @override
  String more_loansSub(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count active loans',
      one: '1 active loan',
    );
    return '$_temp0';
  }

  @override
  String get loans_title => 'Loans';

  @override
  String get loans_addLoan => 'Add Loan';

  @override
  String get loans_editLoan => 'Edit Loan';

  @override
  String get loans_loanName => 'Loan Name';

  @override
  String get loans_amount => 'Amount';

  @override
  String get loans_startDate => 'Start Date';

  @override
  String get loans_endDate => 'End Date';

  @override
  String get loans_interestRateOptional => 'Interest Rate (Optional)';

  @override
  String get loans_account => 'Linked Account';

  @override
  String get loans_monthlyPayment => 'Monthly Payment';

  @override
  String get loans_totalPayable => 'Total Payable';

  @override
  String get loans_remaining => 'Remaining';

  @override
  String get loans_paid => 'Paid';

  @override
  String get loans_logPayment => 'Log Payment';

  @override
  String get loans_paymentReminder => 'Payment Reminder';

  @override
  String get loans_reminderDay => 'Reminder Day';

  @override
  String get loans_notes => 'Notes';

  @override
  String get loans_saveLoan => 'Save Loan';

  @override
  String get loans_deleteLoan => 'Delete Loan';

  @override
  String get loans_settled => 'Settled';

  @override
  String loans_durationMonths(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months',
      one: '1 month',
    );
    return '$_temp0';
  }

  @override
  String get loans_paymentHistory => 'Payment History';

  @override
  String get loans_noPayments => 'No payments logged yet';

  @override
  String get loans_outstandingDebt => 'Outstanding Debt';

  @override
  String get loans_monthlyObligation => 'Monthly Obligation';

  @override
  String get insights_loans => 'Loans';

  @override
  String get backup_loans => 'Loans';

  @override
  String get backup_loanPayments => 'Loan Payments';

  @override
  String get more_yearlyAnalysis => 'Yearly Analysis';

  @override
  String get more_yearlyAnalysisSub => 'Month-by-month cash flow forecast';

  @override
  String get yearly_title => 'Yearly Analysis';

  @override
  String get yearly_recurringExp => 'Recurring Expenses';

  @override
  String get yearly_recurringInc => 'Recurring Income';

  @override
  String get yearly_loans => 'Loan Payments';

  @override
  String get yearly_borrowed => 'Borrowed Due';

  @override
  String get yearly_lentDue => 'Lent Due Back';

  @override
  String get yearly_inflow => 'Inflows';

  @override
  String get yearly_outflow => 'Outflows';

  @override
  String get yearly_netFlow => 'Net Flow';

  @override
  String get yearly_totalInflow => 'Total Inflow';

  @override
  String get yearly_totalOutflow => 'Total Outflow';

  @override
  String get yearly_netCashFlow => 'Net Cash Flow';

  @override
  String get yearly_noData => 'No projected activity yet';

  @override
  String get yearly_noDataSub =>
      'Add recurring payments, loans, or lent money with due dates to see a forecast';

  @override
  String get budget_addBudget => 'Add Budget';

  @override
  String get budget_addGoal => 'Add Savings Goal';

  @override
  String get add_transaction_possibleDuplicate => 'Possible duplicate';

  @override
  String get add_transaction_goBack => 'Go back';

  @override
  String get add_transaction_saveAnyway => 'Save anyway';

  @override
  String get loans_confirmDeleteLoan =>
      'Are you sure you want to delete this loan and all its payments?';

  @override
  String get loans_deletePayment => 'Delete Payment';

  @override
  String get loans_confirmDeletePayment =>
      'Are you sure you want to delete this payment record?';

  @override
  String get split_transactions_title => 'Split Categories';

  @override
  String get split_transactions_badge => 'Split';

  @override
  String get split_transactions_addSplit => 'Add Split';

  @override
  String get split_transactions_removeSplit => 'Remove Split';

  @override
  String get split_transactions_allocated => 'Allocated';

  @override
  String get split_transactions_remaining => 'Remaining';

  @override
  String get split_transactions_fillRemaining => 'Fill Remaining';

  @override
  String get split_transactions_breakdown => 'Split Breakdown';

  @override
  String get split_transactions_mismatchError =>
      'Split amounts must equal the total amount.';

  @override
  String get netWorth_title => 'Net Worth';

  @override
  String get netWorth_subtitle =>
      'Track total assets, liabilities & wealth over time';

  @override
  String get netWorth_current => 'Current Net Worth';

  @override
  String get netWorth_trend => 'Net Worth Trend';

  @override
  String get netWorth_totalAssets => 'Total Assets';

  @override
  String get netWorth_totalLiabilities => 'Total Liabilities';

  @override
  String get netWorth_liquidCash => 'Cash & Bank Accounts';

  @override
  String get netWorth_goldValuation => 'Physical Gold';

  @override
  String get netWorth_fixedAssets => 'Property & Investments';

  @override
  String get netWorth_moneyLent => 'Money Lent (Receivables)';

  @override
  String get netWorth_creditDebt => 'Credit Cards & Overdraft';

  @override
  String get netWorth_loanDebt => 'Loans Payable';

  @override
  String get netWorth_moneyBorrowed => 'Money Borrowed (Payables)';

  @override
  String get netWorth_assetBreakdown => 'Assets Breakdown';

  @override
  String get netWorth_liabilityBreakdown => 'Liabilities Breakdown';

  @override
  String get netWorth_noHistory =>
      'Net worth history will build up automatically over time as daily snapshots are recorded.';

  @override
  String get netWorth_debtRatio => 'Debt Ratio';

  @override
  String get netWorth_quickActions => 'Quick Actions';

  @override
  String get netWorth_history => 'Snapshot History';

  @override
  String get creditCard_utilization => 'Credit Utilization';

  @override
  String get creditCard_availableCredit => 'Available';

  @override
  String get creditCard_limit => 'Limit';

  @override
  String get creditCard_statementBalance => 'Statement Balance';

  @override
  String get creditCard_unbilledBalance => 'Unbilled';

  @override
  String get creditCard_payBill => 'Pay Card Bill';

  @override
  String get creditCard_allCaughtUp => 'All caught up! No balance due';

  @override
  String get creditCard_payBillTitle => 'Pay Credit Card Bill';

  @override
  String get creditCard_payFromAccount => 'Pay From Account';

  @override
  String get creditCard_paymentAmount => 'Payment Amount';

  @override
  String get creditCard_fullStatement => 'Statement Balance';

  @override
  String get creditCard_fullBalance => 'Total Balance';

  @override
  String get creditCard_minPayment => 'Minimum Payment';

  @override
  String get creditCard_customAmount => 'Custom Amount';

  @override
  String creditCard_paymentSuccess(String amount, String cardName) {
    return 'Paid $amount towards $cardName';
  }

  @override
  String get creditCard_insufficientFunds => 'Amount exceeds available balance';

  @override
  String get creditCard_invalidAmount => 'Please enter a valid payment amount';

  @override
  String get onboarding_skipForNow => 'Skip for now';

  @override
  String get onboarding_addCard => 'Add a Card';

  @override
  String get onboarding_skipCardDesc =>
      'You can skip this if you don\'t want to add a card right now.';

  @override
  String get onboarding_cardNameLabel => 'Card Name (e.g. Visa Platinum)';

  @override
  String get onboarding_debitCard => 'Debit Card';

  @override
  String get onboarding_creditLimit => 'Credit Limit';

  @override
  String get onboarding_amountUsed => 'Amount Used';

  @override
  String get accounts_cardHolderOptional => 'Card Holder Name (Optional)';

  @override
  String get accounts_last4Digits => 'Last 4 Digits';

  @override
  String get accounts_expiryDate => 'Expiry Date (MM/YY)';

  @override
  String get accounts_creditLimitOptional => 'Credit Limit (Optional)';

  @override
  String get accounts_minPaymentOptional => 'Min. Payment (Optional)';

  @override
  String get accounts_statementDayOptional => 'Statement Day (Optional)';

  @override
  String get accounts_statementDayExample => 'e.g. 20';

  @override
  String get accounts_dueDayOptional => 'Due Day (Optional)';

  @override
  String get accounts_dueDayExample => 'e.g. 10';

  @override
  String get accounts_linkedAccountOptional => 'Linked Bank Account (Optional)';

  @override
  String get accounts_excludeCardBalance =>
      'Exclude card balance from account balance';

  @override
  String get accounts_excludeCardBalanceDesc =>
      'This card\'s balance will not be added to its linked bank account.';

  @override
  String get accounts_cardHolderHeader => 'CARD HOLDER';

  @override
  String get accounts_expHeader => 'EXP';

  @override
  String get accounts_notifyOnDueDate => 'You\'ll be notified on the due date';

  @override
  String get accounts_notifyWhenDue => 'Get notified when payment is due';

  @override
  String get accounts_remind2DaysBeforeDesc =>
      'Get an advance heads-up 2 days before due date';

  @override
  String get accounts_targetSaved => 'Target / Saved';

  @override
  String transactions_selectedCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count selected',
      one: '1 selected',
    );
    return '$_temp0';
  }

  @override
  String get transactions_changeCategory => 'Change Category';

  @override
  String get transactions_deleteSelected => 'Delete Selected';

  @override
  String get transactions_advancedFilters => 'Advanced Filters';

  @override
  String get transactions_clearAll => 'Clear All';

  @override
  String get transactions_amountRange => 'Amount Range';

  @override
  String get transactions_minAmount => 'Min Amount';

  @override
  String get transactions_maxAmount => 'Max Amount';

  @override
  String get transactions_applyFilters => 'Apply Filters';

  @override
  String get presets_new => 'New';

  @override
  String get presets_presetName => 'Preset Name (e.g. Morning Coffee)';

  @override
  String get presets_defaultAmount => 'Default Amount';

  @override
  String get savings_goalName => 'Goal Name';

  @override
  String get savings_goalNameHint => 'e.g. New Car, Vacation';

  @override
  String get savings_targetAmount => 'Target Amount';

  @override
  String get savings_targetDateOptional => 'Target Date (Optional)';

  @override
  String get savings_selectDate => 'Select date';

  @override
  String get savings_amountRequired => 'Amount is required';

  @override
  String get savings_noteOptional => 'Note (Optional)';

  @override
  String get loans_skipInstallment => 'Skip the next loan installment?';

  @override
  String get recurring_confirmDelete =>
      'Are you sure you want to delete this recurring payment?';

  @override
  String get export_formatExcelOption => 'Excel (.xlsx)';

  @override
  String get export_formatPdfOption => 'PDF Report';

  @override
  String get export_pdfNoTransactions =>
      'No transactions recorded within this date range.';

  @override
  String get savings_saved => 'Saved';

  @override
  String get export_pdfDate => 'Date';

  @override
  String get export_pdfDescription => 'Description';

  @override
  String get accounts_noCardsYet => 'No Cards';

  @override
  String get accounts_tapToAddCard => 'Tap + to add your first card';

  @override
  String get savings_noGoalsYet => 'No Savings Goals';

  @override
  String get savings_tapToAddGoal => 'Tap + to set a new goal';

  @override
  String get netWorth_recordSnapshot => 'Record Snapshot';

  @override
  String get netWorth_snapshotRecorded => 'Snapshot recorded';

  @override
  String get savings_noContributionsYet => 'No contributions yet';

  @override
  String get creditCard_closesStatementBillingCycle =>
      'Closes current statement billing cycle';

  @override
  String get creditCard_clearsTotalDebt => 'Clears total card debt in full';

  @override
  String get creditCard_requiredMinPayment => 'Required minimum payment';

  @override
  String get creditCard_specifyCustomAmount => 'Specify custom payment amount';

  @override
  String common_itemDeleted(String name) {
    return '\"$name\" deleted';
  }

  @override
  String get common_accountDeleted => 'Account deleted';

  @override
  String get common_cardDeleted => 'Card deleted';

  @override
  String get common_transactionDeleted => 'Transaction deleted';

  @override
  String get common_recordDeleted => 'Record deleted';

  @override
  String get common_paymentDeleted => 'Payment deleted';

  @override
  String get loans_skippedInstallment => 'Skipped loan installment';

  @override
  String loans_loggedPayment(String amount) {
    return 'Logged payment of $amount';
  }

  @override
  String get loans_notificationsPermissionRequired =>
      'Notifications permission required';

  @override
  String get creditCard_selectFundingAccount =>
      'Please select a funding account';

  @override
  String get presets_presetUpdated => 'Preset updated';

  @override
  String get presets_presetAdded => 'Preset added';

  @override
  String get presets_presetDeleted => 'Preset deleted';

  @override
  String transactions_deletedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Deleted $count items',
      one: 'Deleted 1 item',
    );
    return '$_temp0';
  }

  @override
  String get split_atLeastTwoCategories =>
      'At least 2 categories required for split.';

  @override
  String get split_categoryAndAmountRequired =>
      'Each split item must have a category and amount > 0.';

  @override
  String get presets_addQuickPresets => 'Add 1-Tap Quick Presets';

  @override
  String get presets_quickPresetsDesc =>
      'Log frequent coffees, commute, or meals with one tap';

  @override
  String presets_loggedPreset(String title, String amount) {
    return 'Logged $title ($amount)';
  }

  @override
  String get presets_createPreset => 'Create Preset';

  @override
  String get presets_editQuickPreset => 'Edit Quick Preset';

  @override
  String get presets_newQuickPreset => 'New Quick Preset';

  @override
  String get savings_addContribution => 'Add Contribution';

  @override
  String get savings_withdrawFromGoal => 'Withdraw from Goal';

  @override
  String get savings_contribution => 'Contribution';

  @override
  String get savings_withdrawal => 'Withdrawal';

  @override
  String get savings_unknownAccount => 'Unknown Account';

  @override
  String get savings_fromAccount => 'From Account';

  @override
  String get savings_toAccount => 'To Account';

  @override
  String get presets_quickLog => 'Quick Log';

  @override
  String accounts_dueOnDay(int day) {
    return 'Due on $day';
  }

  @override
  String get accounts_cannotDeleteAccount => 'Cannot Delete Account';

  @override
  String get common_ok => 'OK';

  @override
  String get certificates_title => 'Time Deposits & Certificates';

  @override
  String get certificates_addCertificate => 'Add Certificate';

  @override
  String get certificates_editCertificate => 'Edit Certificate';

  @override
  String get certificates_noCertificates => 'No Certificates Yet';

  @override
  String get certificates_noCertificatesDesc =>
      'Track your high-yield certificates, deposits, and auto-collected interest returns.';

  @override
  String get certificates_active => 'Active';

  @override
  String get certificates_matured => 'Matured';

  @override
  String get certificates_amount => 'Principal Amount';

  @override
  String get certificates_collectionType => 'Interest Collection';

  @override
  String get certificates_collectedSoFar => 'Collected So Far';

  @override
  String get certificates_expectedTotal => 'Total Expected Return';

  @override
  String get certificates_startDate => 'Start Date';

  @override
  String get certificates_endDate => 'Maturity Date';

  @override
  String get certificates_redeem => 'Redeem Certificate';

  @override
  String certificates_redeemConfirm(String name, String amount) {
    return 'Are you sure you want to redeem \"$name\"? The principal of $amount will be returned to your bank account.';
  }

  @override
  String get certificates_redeemedSuccess =>
      'Certificate redeemed and principal returned successfully.';

  @override
  String get certificates_name => 'Certificate Name';

  @override
  String get certificates_interestRate => 'Annual Interest Rate (%)';

  @override
  String get certificates_linkedBankAccount => 'Linked Bank Account';

  @override
  String get certificates_periodicYield => 'Periodic Interest Return';

  @override
  String get certificates_paymentReminder => 'Payout Reminder Notification';

  @override
  String get certificates_reminderTime => 'Reminder Time';

  @override
  String get certificates_reminder2DaysBefore => 'Reminder 2 days before';

  @override
  String get certificates_deleteCertificate => 'Delete Certificate';

  @override
  String get certificates_confirmDeleteCertificate =>
      'Are you sure you want to delete this certificate? All associated deposit and interest transactions will be removed and money returned to your account.';

  @override
  String get certificates_deleted => 'Certificate deleted';

  @override
  String get onboarding_stayOnTopOfFinances => 'Stay on Top of Your Finances';

  @override
  String get onboarding_stayOnTopOfFinancesDesc =>
      'Enable timely reminders so you never miss a payment, overdue bill, or budget threshold.';

  @override
  String get onboarding_featureBillTitle => 'Bill & Due Date Reminders';

  @override
  String get onboarding_featureBillDesc =>
      'Get alerted before credit card statement dates and loan installments are due.';

  @override
  String get onboarding_featureBudgetTitle => 'Budget Tracking Alerts';

  @override
  String get onboarding_featureBudgetDesc =>
      'Receive alerts when you reach 80% or 100% of your category spending limit.';

  @override
  String get onboarding_featureRecurringTitle => 'Recurring Subscriptions';

  @override
  String get onboarding_featureRecurringDesc =>
      'Stay informed before recurring bills and memberships auto-renew.';

  @override
  String get onboarding_allowNotifications => 'Allow Notifications';

  @override
  String get onboarding_maybeLater => 'Maybe Later';

  @override
  String get categories_subcategories => 'Subcategories';

  @override
  String get categories_addSubcategory => 'Add Subcategory';

  @override
  String get categories_parentCategory => 'Parent Category';

  @override
  String get categories_noneRoot => 'None (Top-Level Category)';

  @override
  String get categories_loadDefaults => 'Load Default Subcategories';

  @override
  String categories_defaultsLoaded(int count) {
    return 'Loaded $count default subcategories';
  }

  @override
  String get categories_defaultsAlreadyLoaded =>
      'Default subcategories are already loaded';

  @override
  String get statistics_byCategory => 'By Category';

  @override
  String get statistics_bySubcategory => 'By Subcategory';

  @override
  String get backup_importFromTrackWallet => 'Import from TrackWallet (.csv)';

  @override
  String backup_importedTransactions(int count) {
    return 'Imported $count transactions successfully!';
  }

  @override
  String get onboarding_restoreTrackWallet => 'Import from TrackWallet (.csv)';

  @override
  String get transfer_categoryLocked => 'Transfer (Default & Only Category)';

  @override
  String get loans_noLoans => 'No loans tracked yet';

  @override
  String get loans_noLoansSub =>
      'Tap + to track mortgages, personal loans, or installments';

  @override
  String get certificates_noCertificatesSub =>
      'Tap + to track bank certificates and fixed deposits';

  @override
  String get common_undo => 'Undo';

  @override
  String get common_close => 'Close';

  @override
  String get common_required => 'Required';

  @override
  String get common_invalid => 'Invalid';

  @override
  String get common_none => 'None';

  @override
  String common_enabledAt(String time) {
    return 'Enabled ($time)';
  }

  @override
  String get common_disabled => 'Disabled';

  @override
  String get freq_daily => 'Daily';

  @override
  String get freq_yearly => 'Yearly';

  @override
  String recurring_transfers(Object count) {
    return 'Transfers ($count)';
  }

  @override
  String get recurring_transfer => 'Transfer';

  @override
  String get recurring_transferCaps => 'TRANSFER';

  @override
  String get recurring_noRecurringTransfers => 'No recurring transfers';

  @override
  String recurring_subtitleCount(int count) {
    return '$count subscriptions & recurring';
  }

  @override
  String recurring_perWeek(String amount) {
    return '$amount / week';
  }

  @override
  String get recurring_perMonth => '/ month';

  @override
  String get recurring_fromAccount => 'From Account';

  @override
  String get recurring_toAccount => 'To Account';

  @override
  String recurring_targetAmount(String currency) {
    return 'Target Amount ($currency)';
  }

  @override
  String get recurring_autoPayAt => 'Auto Pay at';

  @override
  String get recurring_autoPayOnDueDate => 'Auto pay on Due date';

  @override
  String get recurring_autoPayEnabledSub =>
      'Automatically recorded on due date';

  @override
  String get recurring_autoPayDisabledSub =>
      'Automatically record this payment when due';

  @override
  String get recurring_autoPayTime => 'Auto pay time';

  @override
  String get recurring_reminderEnabledSub =>
      'You\'ll be notified on the due date';

  @override
  String get recurring_reminderDisabledSub =>
      'Get notified when a payment is due';

  @override
  String get recurring_earlyReminderEnabledSub =>
      'Extra heads-up 2 days early at the same time';

  @override
  String get recurring_earlyReminderDisabledSub =>
      'Also get notified 2 days before the due date';

  @override
  String get recurring_addRecurringBtn => 'Add Recurring';

  @override
  String get recurring_paymentDetails => 'Payment Details';

  @override
  String get recurring_linkedAccount => 'Linked Account';

  @override
  String get recurring_deletedAccount => 'Deleted Account';

  @override
  String get recurring_frequency => 'Frequency';

  @override
  String get recurring_type => 'Type';

  @override
  String get recurring_startDate => 'Start Date';

  @override
  String get recurring_nextDueDate => 'Next Due Date';

  @override
  String get recurring_autoPay => 'Auto Pay';

  @override
  String get recurring_reminder => 'Reminder';

  @override
  String get recurring_endDate => 'End Date';

  @override
  String get recurring_totalValue => 'Total Value';

  @override
  String get recurring_notes => 'Notes';

  @override
  String get recurring_upcomingPayments => 'Upcoming Payments';

  @override
  String recurring_remainingCount(int count) {
    return '$count remaining';
  }

  @override
  String get recurring_allInstallmentsCompleted => 'All installments completed';

  @override
  String recurring_installmentOf(int num, int total) {
    return '#$num of $total';
  }

  @override
  String get recurring_paymentPaid => 'Payment Paid';

  @override
  String get recurring_paymentSkipped => 'Payment Skipped';

  @override
  String get presets_transfer => 'Transfer';

  @override
  String get presets_selectDifferentAccounts =>
      'Please select different source and destination accounts.';

  @override
  String presets_targetAmountOptional(String currency) {
    return 'Target Amount in $currency (Optional)';
  }

  @override
  String get transactions_transfers => 'Transfers';

  @override
  String transactions_selectedItemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items selected',
      one: '1 item selected',
    );
    return '$_temp0';
  }

  @override
  String transactions_entriesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entries',
      one: '1 entry',
    );
    return '$_temp0';
  }

  @override
  String get transactions_clearSelection => 'Clear selection';

  @override
  String get transactions_transferTitle => 'Transfer Transaction';

  @override
  String get transactions_transferBody =>
      'This transaction is part of an account transfer. Individual legs cannot be modified directly to preserve balance integrity. Would you like to delete this transfer?';

  @override
  String get transactions_deleteTransfer => 'Delete Transfer';

  @override
  String get transactions_transferDeleted => 'Transfer deleted';

  @override
  String get transactions_certTitle => 'Certificate Transaction';

  @override
  String get transactions_certBody =>
      'This transaction is linked to a time deposit / certificate. To keep principal and yield ledgers in sync, manage it from the Certificates screen.';

  @override
  String get transactions_viewCertificate => 'View Certificate';

  @override
  String get transactions_openCertificates => 'Open Certificates';

  @override
  String get transactions_loanFallback => 'Loan';

  @override
  String get transactions_loanPayment => 'Loan Payment';

  @override
  String get transactions_goalContribution => 'Goal Contribution';

  @override
  String get transactions_goalWithdrawal => 'Goal Withdrawal';

  @override
  String get calendar_repayment => 'Repayment';

  @override
  String get calendar_transfersDue => 'Recurring Transfers Due';

  @override
  String accounts_subtitleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count accounts',
      one: '1 account',
    );
    return '$_temp0';
  }

  @override
  String get accounts_tabAccounts => 'Accounts';

  @override
  String get accounts_tabCards => 'Cards';

  @override
  String get accounts_addCardBtn => 'Add Card';

  @override
  String get accounts_addNewCardBtn => 'Add New Card';

  @override
  String get accounts_editCard => 'Edit Card';

  @override
  String get accounts_cardNameHint => 'Card Name (e.g. Visa Platinum)';

  @override
  String get accounts_debitCard => 'Debit Card';

  @override
  String get accounts_prepaidCard => 'Prepaid Card';

  @override
  String get accounts_pinToWidget => 'Pin to Widget';

  @override
  String get accounts_unpinFromWidget => 'Unpin from Widget';

  @override
  String get accounts_maxPinnedWarning => 'You cannot pin more than 3 accounts';

  @override
  String get accounts_selectLinkedBank =>
      'Please select a linked bank account for this debit card.';

  @override
  String get accounts_debitSharesBalance =>
      'Debit cards share balance with their linked bank account.';

  @override
  String get accounts_linkedBankRequired => 'Linked Bank Account (Required)';

  @override
  String get accounts_amountCurrentlyOwed => 'Amount Currently Owed';

  @override
  String get accounts_initialAmountOwed => 'Initial Amount Owed';

  @override
  String get accounts_cardDebtHint =>
      'Enter amount currently owed on this card (saved as debt)';

  @override
  String accounts_nextCycleCloses(int day) {
    return 'Next cycle closes around day $day';
  }

  @override
  String accounts_spotPriceLabel(int karat) {
    return 'Spot price (${karat}k gold/g)';
  }

  @override
  String get accounts_weightTimesPurity => 'Weight × purity';

  @override
  String accounts_blockDeleteRecurring(int count) {
    return 'Account has $count active recurring payments. Please reassign or delete them first.';
  }

  @override
  String accounts_blockDeleteLoans(int count) {
    return 'Account has $count active loans. Please reassign or delete them first.';
  }

  @override
  String accounts_blockDeleteCertificates(int count) {
    return 'Account has $count active certificates. Please redeem or delete them first.';
  }

  @override
  String accounts_blockDeleteLended(int count) {
    return 'Account has $count unsettled lend/borrow records. Please settle them first.';
  }

  @override
  String accounts_blockDeleteSavings(int count) {
    return 'Account is referenced by $count savings contributions. Please reassign or delete them first.';
  }

  @override
  String accounts_blockDeletePresets(int count) {
    return 'Account is used by $count transaction presets. Please reassign or delete them first.';
  }

  @override
  String accounts_blockDeleteCards(int count) {
    return 'Account is linked to $count cards. Please unlink or delete them first.';
  }

  @override
  String get add_transaction_selectAccountOrCard =>
      'Please select an account or card.';

  @override
  String get add_transaction_balanced => 'Balanced';

  @override
  String add_transaction_similarExists(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count similar transactions already exist:',
      one: 'A similar transaction already exists:',
    );
    return '$_temp0';
  }

  @override
  String budget_goalsCountSubtitle(int budgets, int goals) {
    return '$budgets budgets · $goals goals';
  }

  @override
  String get budget_savingsGoalsCaps => 'SAVINGS GOALS';

  @override
  String budget_percentSaved(String percent) {
    return '$percent% saved';
  }

  @override
  String budget_ofTarget(String amount) {
    return 'of $amount target';
  }

  @override
  String get budget_goalsTab => 'Goals';

  @override
  String get budget_completed => 'Completed';

  @override
  String get savings_newGoal => 'New Savings Goal';

  @override
  String get savings_editGoal => 'Edit Savings Goal';

  @override
  String get certificates_activePrincipal => 'Active Principal';

  @override
  String get certificates_activeCount => 'Active Count';

  @override
  String certificates_linkedBank(String name) {
    return 'Linked: $name';
  }

  @override
  String certificates_yieldSummary(String amount, String type) {
    return 'Yield: $amount ($type)';
  }

  @override
  String certificates_maturesOn(String date) {
    return 'Matures: $date';
  }

  @override
  String get certificates_settledCaps => 'SETTLED';

  @override
  String get certificates_activeCaps => 'ACTIVE';

  @override
  String get certificates_annualRate => 'Annual Rate';

  @override
  String get certificates_periodicYieldLabel => 'Periodic Yield';

  @override
  String get certificates_maturedAndSettled => 'Certificate Matured & Settled';

  @override
  String get certificates_payoutOverride => 'Payout (override)';

  @override
  String get certificates_dayRange => 'Day (1-31)';

  @override
  String get certificates_noBankAccounts =>
      'No Bank Accounts available. Please create a bank account to receive payouts.';

  @override
  String get certificates_selectLinkedBank =>
      'Please select a linked Bank Account.';

  @override
  String get creditCard_noFundingAccounts =>
      'No bank or cash accounts available to fund payment.';

  @override
  String get creditCard_processing => 'Processing...';

  @override
  String creditCard_payAmountBtn(String amount) {
    return 'Pay $amount';
  }

  @override
  String get insights_loanPaymentsThisMonth =>
      'Debt / Loan Payments This Month';

  @override
  String get insights_spendingForecast => 'Spending Forecast';

  @override
  String get insights_forecastPrefix => 'At this rate, you\'ll spend ';

  @override
  String insights_forecastSuffix(String month, int days) {
    return ' by the end of $month — $days days left.';
  }

  @override
  String get insights_forecastDisclaimer =>
      'Projection based on spending so far, doesn\'t include upcoming recurring bills.';

  @override
  String insights_forecastAccuracy(int days) {
    return 'Based on the first $days days — accuracy improves as the month goes on.';
  }

  @override
  String insights_projAmount(String amount) {
    return 'Proj: $amount';
  }

  @override
  String insights_projOfBudget(String percent) {
    return ' ($percent% of budget)';
  }

  @override
  String get insights_outstanding => 'Outstanding';

  @override
  String get insights_monthlyObligation => 'Monthly Obligation';

  @override
  String get loans_principal => 'Principal';

  @override
  String get loans_interestRate => 'Interest Rate';

  @override
  String get loans_duration => 'Duration';

  @override
  String get loans_transferTo => 'Transfer Loan Amount To';

  @override
  String get loans_payFrom => 'Pay Installments From';

  @override
  String loans_dueDayTime(int day, String time) {
    return 'Due: Day $day @ $time';
  }

  @override
  String more_activeCount(int count) {
    return '$count active';
  }

  @override
  String more_toolsSubtitle(int count) {
    return '$count financial tools & preferences';
  }

  @override
  String get more_totalWealthCaps => 'TOTAL WEALTH';

  @override
  String get more_liveNetWorthSub =>
      'Live aggregated net worth across all holdings';

  @override
  String more_assetsAmount(String amount) {
    return 'Assets: $amount';
  }

  @override
  String more_liabilitiesAmount(String amount) {
    return 'Liabilities: $amount';
  }

  @override
  String get netWorth_debtFree => 'Debt-free';

  @override
  String get netWorth_showLess => 'Show Less';

  @override
  String netWorth_showAll(int count) {
    return 'Show All ($count)';
  }

  @override
  String get netWorth_zeroLiabilities =>
      'Zero liabilities recorded! Outstanding debt is \$0.00.';

  @override
  String get netWorth_lentDebts => 'Lent/Debts';

  @override
  String netWorth_snapBreakdown(String assets, String accounts) {
    return 'Assets: $assets · Accounts: $accounts';
  }

  @override
  String get onboarding_nameRequired => 'Name is required';

  @override
  String get onboarding_popularCurrencies => 'Popular Currencies';

  @override
  String get onboarding_debitCardNextStep =>
      'You can add a debit card for this bank account in the next step';

  @override
  String get onboarding_addDebitCardTitle => 'Add a Debit Card';

  @override
  String get onboarding_addDebitCardDesc =>
      'Link a debit card to your new bank account for effortless expense tracking.';

  @override
  String get onboarding_cardName => 'Card Name';

  @override
  String get onboarding_cardholderName => 'Cardholder Name';

  @override
  String get onboarding_last4Digits => 'Last 4 Digits';

  @override
  String get onboarding_cardColor => 'Card Color';

  @override
  String wrapped_zeroSpendOfDays(int total) {
    return 'of $total days with zero spend';
  }

  @override
  String get wrapped_savingsRateLabel => 'Savings Rate';

  @override
  String get wrapped_topCategoryLabel => 'Top Category';

  @override
  String get wrapped_zeroSpendDaysLabel => 'Zero-Spend Days';

  @override
  String get wrapped_footerTag => '★ Private & Offline Financial Mastery ★';

  @override
  String get yearly_tapToExpand => 'Tap to expand';

  @override
  String get yearly_noDataBadge => 'No Data';

  @override
  String get export_formatHeader => 'EXPORT FORMAT';

  @override
  String export_pdfPeriod(String range) {
    return 'Period: $range';
  }

  @override
  String export_pdfCurrency(String currency) {
    return 'Currency: $currency';
  }

  @override
  String export_pdfGenerated(String date) {
    return 'Generated: $date';
  }

  @override
  String export_pdfPageOf(int page, int total) {
    return 'Page $page of $total';
  }

  @override
  String get export_pdfTotalAssets => 'Total Assets';

  @override
  String get export_pdfTotalLiabilities => 'Total Liabilities';

  @override
  String get export_pdfCurrentNetWorth => 'Current Net Worth';

  @override
  String get export_pdfCategory => 'Category';

  @override
  String export_pdfAmountHeader(String currency) {
    return 'Amount ($currency)';
  }

  @override
  String get export_pdfPercentOfExpenses => '% of Total Expenses';

  @override
  String get backup_encryptedTitle => 'Encrypted Backup';

  @override
  String get backup_encryptedPrompt =>
      'Enter the password used to encrypt this backup file:';

  @override
  String get backup_password => 'Password';

  @override
  String get backup_confirmPassword => 'Confirm Password';

  @override
  String get backup_decryptContinue => 'Decrypt & Continue';

  @override
  String get backup_chooseRestoreMode => 'Choose Restore Mode';

  @override
  String get backup_chooseRestoreModeDesc =>
      'Select whether you want to restore the entire backup or only specific financial data.';

  @override
  String get backup_selectiveRestore => 'Selective Restore';

  @override
  String get backup_selectiveRestoreDesc =>
      'Choose specific entities without erasing your other data or settings.';

  @override
  String get backup_fullRestore => 'Full Restore';

  @override
  String get backup_fullRestoreDesc =>
      'Completely replaces all current database tables and settings with backup data.';

  @override
  String get backup_selectiveBackup => 'Selective Backup';

  @override
  String get backup_selectiveBackupBtn => 'Selective Backup...';

  @override
  String get backup_selectiveBackupDesc =>
      'Choose the financial data entities you want to export into JSON.';

  @override
  String get backup_selectedRestoredSuccess =>
      'Selected data restored successfully!';

  @override
  String get backup_savingsGoals => 'Savings Goals';

  @override
  String get backup_savingsContributions => 'Savings Contributions';

  @override
  String get backup_encryptionDisabled => 'Backup encryption disabled';

  @override
  String get backup_encryptionEnabled => 'Backup encryption enabled';

  @override
  String backup_encryptionFailed(String error) {
    return 'Failed to enable encryption: $error';
  }

  @override
  String get backup_encryptAutoTitle => 'Encrypt Auto Backups';

  @override
  String get backup_encryptAutoDesc =>
      'Protect your auto-backups with AES-GCM-256 encryption. If you forget this password, your backups cannot be restored.';

  @override
  String get backup_passwordEmpty => 'Password cannot be empty';

  @override
  String get backup_passwordsMismatch => 'Passwords do not match';

  @override
  String get backup_setPassword => 'Set Password';

  @override
  String backup_autoCreated(String file) {
    return 'Auto backup created: $file';
  }

  @override
  String backup_autoFailed(String error) {
    return 'Auto backup failed: $error';
  }

  @override
  String get backup_nightlySchedule => 'Nightly at ~2:00 AM to a chosen folder';

  @override
  String get backup_noFolderSelected => 'No folder selected';

  @override
  String get backup_keepCopies => 'Keep copies:';

  @override
  String get backup_encryptAes => 'Encrypt backup (AES-GCM)';

  @override
  String backup_failedError(String error) {
    return 'Failed: $error';
  }

  @override
  String backup_lastSuccess(String date, String kb) {
    return 'Last: $date ($kb KB)';
  }

  @override
  String get backup_backingUp => 'Backing up...';

  @override
  String get backup_backUpNow => 'Back Up Now';

  @override
  String get backup_androidIdleNote =>
      'Runs at ~2:00 AM. Android may delay it while the phone is idle.';

  @override
  String get backup_selectAll => 'Select All';

  @override
  String get backup_deselectAll => 'Deselect All';

  @override
  String get backup_selectiveSaved => 'Selective backup saved successfully!';

  @override
  String backup_exportFailed(String error) {
    return 'Export failed: $error';
  }

  @override
  String backup_exportSelected(int count) {
    return 'Export Selected ($count) Entities';
  }

  @override
  String backup_restoreSelected(int count) {
    return 'Restore Selected ($count) Entities';
  }

  @override
  String get backup_selectiveRestoreNote =>
      'Only the selected items will be restored. Your other accounts, transactions, and settings remain untouched.';

  @override
  String backup_countInBackup(int count) {
    return '$count in backup';
  }

  @override
  String get backup_entityTxSplitsPresets => 'Transactions, Splits & Presets';

  @override
  String get backup_entityRecurringHistory => 'Recurring Payments & History';

  @override
  String get backup_entityLoansPayments => 'Loans & Payments';

  @override
  String get backup_entityLentContacts => 'Lent Money & Contacts';

  @override
  String get backup_entityAssetsValuables => 'Assets & Valuables';

  @override
  String get backup_entityWishlistGoals => 'Wishlist & Savings Goals';

  @override
  String get common_perDay => '/ day';

  @override
  String common_daysShort(int count) {
    return '$count d';
  }

  @override
  String get common_splitCaps => 'SPLIT';

  @override
  String budget_deletedCategory(String name) {
    return 'Deleted $name';
  }

  @override
  String get loans_paymentDeleted => 'Payment deleted';

  @override
  String certificates_collectionDayLabel(String frequency, int day) {
    return '$frequency (Day $day)';
  }

  @override
  String add_transaction_duplicateItem(
      String amount, String date, String desc) {
    return '• $amount on $date$desc';
  }

  @override
  String creditCard_billPaymentDesc(String name) {
    return 'Credit Card Bill Payment — $name';
  }

  @override
  String get onboarding_defaultBankName => 'Main Bank';

  @override
  String get onboarding_defaultCardholder => 'EXPENSY MEMBER';

  @override
  String get onboarding_defaultUser => 'User';

  @override
  String get export_excelSheetName => 'Transactions';

  @override
  String get export_headerDate => 'Date';

  @override
  String get export_headerDescription => 'Description';

  @override
  String get export_headerType => 'Type';

  @override
  String get export_headerAmount => 'Amount';

  @override
  String get export_headerCurrency => 'Currency';

  @override
  String get export_headerAccount => 'Account';

  @override
  String get export_headerCategory => 'Category';

  @override
  String get export_headerSubcategory => 'Subcategory';

  @override
  String get export_headerNote => 'Note';

  @override
  String get cat_food_exp => 'Food & Dining';

  @override
  String get cat_transport => 'Transport';

  @override
  String get cat_shopping => 'Shopping';

  @override
  String get cat_bills => 'Bills & Utilities';

  @override
  String get cat_health => 'Health';

  @override
  String get cat_entertainment => 'Entertainment';

  @override
  String get cat_education => 'Education';

  @override
  String get cat_personal => 'Personal Care';

  @override
  String get cat_salary => 'Salary';

  @override
  String get cat_freelance => 'Freelance';

  @override
  String get cat_investments => 'Investments';

  @override
  String get cat_gifts => 'Gifts';

  @override
  String get cat_other_inc => 'Other Income';

  @override
  String get cat_other_exp => 'Other Expense';

  @override
  String get cat_sys_transfer => 'Transfer';

  @override
  String get cat_sys_investment => 'Investment';

  @override
  String get sub_groceries => 'Groceries';

  @override
  String get sub_restaurants => 'Restaurants';

  @override
  String get sub_delivery => 'Delivery';

  @override
  String get sub_coffee_tea => 'Coffee & Tea';

  @override
  String get sub_fuel => 'Fuel';

  @override
  String get sub_public_transit => 'Public Transit';

  @override
  String get sub_taxi_ride => 'Taxi & Ride';

  @override
  String get sub_maintenance => 'Maintenance';

  @override
  String get sub_parking_tolls => 'Parking & Tolls';

  @override
  String get sub_clothing => 'Clothing';

  @override
  String get sub_electronics => 'Electronics';

  @override
  String get sub_home_furniture => 'Home & Furniture';

  @override
  String get sub_gifts => 'Gifts';

  @override
  String get sub_electricity => 'Electricity';

  @override
  String get sub_internet => 'Internet';

  @override
  String get sub_water => 'Water';

  @override
  String get sub_phone => 'Phone';

  @override
  String get sub_medicine => 'Medicine';

  @override
  String get sub_doctor => 'Doctor';

  @override
  String get sub_movies => 'Movies';

  @override
  String get sub_games => 'Games';

  @override
  String get sub_subscriptions => 'Subscriptions';

  @override
  String get notif_overBudgetTitle => '🚨 Over Budget';

  @override
  String notif_overBudgetBody(String category, String amount, String period) {
    return '$category — $amount over your $period limit';
  }

  @override
  String get notif_goalReachedTitle => '🎉 Goal Reached';

  @override
  String notif_goalReachedBody(String amount, String name) {
    return 'You reached your goal of $amount for $name!';
  }

  @override
  String get notif_certPayoutDueTitle => '📈 Certificate Payout Due';

  @override
  String get notif_certPayoutUpcomingTitle => '📈 Upcoming Certificate Payout';

  @override
  String notif_certPayoutBody(String name) {
    return '$name interest return is due today.';
  }

  @override
  String notif_certPayoutSoonBody(String name) {
    return '$name interest return is due in 2 days.';
  }

  @override
  String get notif_creditBillDueTodayTitle => '💳 Bill Due Today';

  @override
  String get notif_creditBillDueSoonTitle => '💳 Bill Due Soon';

  @override
  String get notif_dailyReminderTitle => '📝 Daily Reminder';

  @override
  String get notif_dailyReminderBody =>
      'Don\'t forget to log today\'s spending.';

  @override
  String notif_lendedDueTitle(String emoji, String name) {
    return '$emoji Due: $name';
  }

  @override
  String get notif_loanPaymentDueTitle => '🏦 Loan Payment Due';

  @override
  String notif_loanPaymentDueBody(String name) {
    return '$name installment is due today.';
  }

  @override
  String get notif_autoBackupFailedTitle => 'Auto Backup Failed';

  @override
  String notif_autoBackupFailedBody(String error) {
    return 'Expensy was unable to create your scheduled backup: $error';
  }

  @override
  String notif_recurringTransferBody(String amount) {
    return '$amount transfer is due';
  }

  @override
  String notif_recurringIncomeBody(String amount) {
    return '$amount income is due';
  }

  @override
  String notif_recurringExpenseBody(String amount) {
    return '$amount payment is due';
  }

  @override
  String notif_creditBillDueTodayBody(String name) {
    return 'Your $name bill is due today.';
  }

  @override
  String notif_creditBillDueSoonBody(String name) {
    return 'Your $name bill is due in 2 days.';
  }

  @override
  String notif_lendedLentDueBody(String amount, String name) {
    return '$amount you lent to $name is due today';
  }

  @override
  String notif_lendedBorrowedDueBody(String amount, String name) {
    return '$amount you borrowed from $name is due today';
  }

  @override
  String notif_recurringTransferDueSoonBody(String amount) {
    return '$amount transfer due in 2 days';
  }

  @override
  String notif_recurringIncomeDueSoonBody(String amount) {
    return '$amount expected in 2 days';
  }

  @override
  String notif_recurringExpenseDueSoonBody(String amount) {
    return '$amount due in 2 days';
  }
}
