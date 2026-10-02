import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('pt'),
    Locale('ru'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Expensy'**
  String get appTitle;

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @settings_appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settings_appearance;

  /// No description provided for @settings_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settings_theme;

  /// No description provided for @settings_system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settings_system;

  /// No description provided for @settings_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settings_light;

  /// No description provided for @settings_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settings_dark;

  /// No description provided for @settings_amoledTitle.
  ///
  /// In en, this message translates to:
  /// **'Pure Black (AMOLED)'**
  String get settings_amoledTitle;

  /// No description provided for @settings_amoledSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Forces black backgrounds in dark mode'**
  String get settings_amoledSubtitle;

  /// System default option in settings
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get settings_systemDefault;

  /// Dynamic Color toggle title
  ///
  /// In en, this message translates to:
  /// **'Dynamic Color'**
  String get settings_dynamicColor;

  /// Dynamic Color toggle subtitle
  ///
  /// In en, this message translates to:
  /// **'Use system wallpaper colors'**
  String get settings_dynamicColorSubtitle;

  /// Accent Color title
  ///
  /// In en, this message translates to:
  /// **'Accent Color'**
  String get settings_accentColor;

  /// Accent Color subtitle
  ///
  /// In en, this message translates to:
  /// **'Choose a seed color for the app'**
  String get settings_accentColorSubtitle;

  /// No description provided for @settings_appFont.
  ///
  /// In en, this message translates to:
  /// **'App Font'**
  String get settings_appFont;

  /// No description provided for @settings_currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get settings_currency;

  /// No description provided for @settings_defaultCurrency.
  ///
  /// In en, this message translates to:
  /// **'Default Currency'**
  String get settings_defaultCurrency;

  /// No description provided for @settings_preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settings_preferences;

  /// No description provided for @settings_weekStartsOn.
  ///
  /// In en, this message translates to:
  /// **'Week Starts On'**
  String get settings_weekStartsOn;

  /// No description provided for @settings_monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get settings_monday;

  /// No description provided for @settings_sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get settings_sunday;

  /// No description provided for @settings_hideBalance.
  ///
  /// In en, this message translates to:
  /// **'Hide Balance'**
  String get settings_hideBalance;

  /// No description provided for @settings_hideBalanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show ••••• instead of amounts'**
  String get settings_hideBalanceSubtitle;

  /// No description provided for @settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// No description provided for @settings_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get settings_profile;

  /// No description provided for @settings_displayName.
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get settings_displayName;

  /// No description provided for @settings_notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get settings_notSet;

  /// No description provided for @settings_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settings_about;

  /// No description provided for @settings_version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settings_version;

  /// No description provided for @settings_privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settings_privacy;

  /// No description provided for @settings_privacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'All data stored locally — 100% offline'**
  String get settings_privacySubtitle;

  /// No description provided for @settings_github.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get settings_github;

  /// No description provided for @settings_githubSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View source code'**
  String get settings_githubSubtitle;

  /// No description provided for @settings_developer.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get settings_developer;

  /// No description provided for @settings_developerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Discover more projects by Mina Android'**
  String get settings_developerSubtitle;

  /// No description provided for @settings_githubProfile.
  ///
  /// In en, this message translates to:
  /// **'GitHub Profile'**
  String get settings_githubProfile;

  /// No description provided for @settings_developerWebsite.
  ///
  /// In en, this message translates to:
  /// **'Developer Website'**
  String get settings_developerWebsite;

  /// No description provided for @settings_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get settings_close;

  /// No description provided for @settings_yourName.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get settings_yourName;

  /// No description provided for @settings_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get settings_cancel;

  /// No description provided for @settings_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get settings_save;

  /// No description provided for @recurring_expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses ({count})'**
  String recurring_expenses(Object count);

  /// No description provided for @recurring_incomeList.
  ///
  /// In en, this message translates to:
  /// **'Income ({count})'**
  String recurring_incomeList(Object count);

  /// No description provided for @recurring_monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get recurring_monthly;

  /// No description provided for @recurring_weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get recurring_weekly;

  /// No description provided for @recurring_noRecurringExpenses.
  ///
  /// In en, this message translates to:
  /// **'No recurring expenses'**
  String get recurring_noRecurringExpenses;

  /// No description provided for @recurring_noRecurringIncome.
  ///
  /// In en, this message translates to:
  /// **'No recurring income'**
  String get recurring_noRecurringIncome;

  /// No description provided for @recurring_addExpense.
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get recurring_addExpense;

  /// No description provided for @recurring_addIncome.
  ///
  /// In en, this message translates to:
  /// **'Add Income'**
  String get recurring_addIncome;

  /// No description provided for @recurring_tapPlusToAddOne.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add one'**
  String get recurring_tapPlusToAddOne;

  /// No description provided for @recurring_fromOngoing.
  ///
  /// In en, this message translates to:
  /// **'From {date} · Ongoing'**
  String recurring_fromOngoing(Object date);

  /// No description provided for @recurring_paidPayments.
  ///
  /// In en, this message translates to:
  /// **'{paid}/{total} paid'**
  String recurring_paidPayments(Object paid, Object total);

  /// No description provided for @recurring_totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total: {amount}'**
  String recurring_totalAmount(Object amount);

  /// No description provided for @recurring_overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue!'**
  String get recurring_overdue;

  /// No description provided for @recurring_dueToday.
  ///
  /// In en, this message translates to:
  /// **'Due Today'**
  String get recurring_dueToday;

  /// No description provided for @recurring_dueInDays.
  ///
  /// In en, this message translates to:
  /// **'Due in {days}d'**
  String recurring_dueInDays(Object days);

  /// No description provided for @recurring_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get recurring_edit;

  /// No description provided for @recurring_skipBtn.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get recurring_skipBtn;

  /// No description provided for @recurring_nextDate.
  ///
  /// In en, this message translates to:
  /// **'Next: {date}'**
  String recurring_nextDate(Object date);

  /// No description provided for @recurring_pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get recurring_pay;

  /// No description provided for @recurring_del.
  ///
  /// In en, this message translates to:
  /// **'Del'**
  String get recurring_del;

  /// No description provided for @recurring_historyCount.
  ///
  /// In en, this message translates to:
  /// **'History ({count})'**
  String recurring_historyCount(Object count);

  /// No description provided for @recurring_paymentHistory.
  ///
  /// In en, this message translates to:
  /// **'Payment history'**
  String get recurring_paymentHistory;

  /// No description provided for @recurring_notificationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Notification permission denied. Enable it in Settings → Apps → Expensy → Notifications.'**
  String get recurring_notificationPermissionDenied;

  /// No description provided for @recurring_remindMeAt.
  ///
  /// In en, this message translates to:
  /// **'Remind me at'**
  String get recurring_remindMeAt;

  /// No description provided for @recurring_editRecurring.
  ///
  /// In en, this message translates to:
  /// **'Edit Recurring'**
  String get recurring_editRecurring;

  /// No description provided for @recurring_addRecurring.
  ///
  /// In en, this message translates to:
  /// **'Add a Recurring Payment'**
  String get recurring_addRecurring;

  /// No description provided for @recurring_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get recurring_name;

  /// No description provided for @recurring_amountPerPayment.
  ///
  /// In en, this message translates to:
  /// **'Amount per payment'**
  String get recurring_amountPerPayment;

  /// No description provided for @recurring_firstDate.
  ///
  /// In en, this message translates to:
  /// **'First: {date}'**
  String recurring_firstDate(Object date);

  /// No description provided for @recurring_lastDate.
  ///
  /// In en, this message translates to:
  /// **'Last: {date}'**
  String recurring_lastDate(Object date);

  /// No description provided for @recurring_noLastPaymentOngoing.
  ///
  /// In en, this message translates to:
  /// **'No last payment (ongoing)'**
  String get recurring_noLastPaymentOngoing;

  /// No description provided for @accounts_refreshExchangeRates.
  ///
  /// In en, this message translates to:
  /// **'Refresh exchange rates'**
  String get accounts_refreshExchangeRates;

  /// No description provided for @accounts_noAccounts.
  ///
  /// In en, this message translates to:
  /// **'No accounts'**
  String get accounts_noAccounts;

  /// No description provided for @accounts_tapPlusToAddYourFirst.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add your first account'**
  String get accounts_tapPlusToAddYourFirst;

  /// No description provided for @accounts_fetchingExchangeRates.
  ///
  /// In en, this message translates to:
  /// **'Fetching exchange rates…'**
  String get accounts_fetchingExchangeRates;

  /// No description provided for @accounts_exchangeRatesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Exchange rates unavailable (offline). Balances shown in native currency.'**
  String get accounts_exchangeRatesUnavailable;

  /// No description provided for @accounts_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get accounts_unknown;

  /// No description provided for @accounts_ratesUpdated.
  ///
  /// In en, this message translates to:
  /// **'Rates updated {timeStr} · Tap ↺ to refresh'**
  String accounts_ratesUpdated(Object timeStr);

  /// No description provided for @accounts_goldCaps.
  ///
  /// In en, this message translates to:
  /// **'GOLD'**
  String get accounts_goldCaps;

  /// No description provided for @accounts_balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get accounts_balance;

  /// No description provided for @accounts_income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get accounts_income;

  /// No description provided for @accounts_expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get accounts_expense;

  /// No description provided for @accounts_txs.
  ///
  /// In en, this message translates to:
  /// **'Txs'**
  String get accounts_txs;

  /// No description provided for @accounts_value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get accounts_value;

  /// No description provided for @accounts_karat.
  ///
  /// In en, this message translates to:
  /// **'Karat'**
  String get accounts_karat;

  /// No description provided for @accounts_pure.
  ///
  /// In en, this message translates to:
  /// **'{percentage}% pure'**
  String accounts_pure(Object percentage);

  /// No description provided for @accounts_weightLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get accounts_weightLabel;

  /// No description provided for @accounts_perGram.
  ///
  /// In en, this message translates to:
  /// **'Per gram'**
  String get accounts_perGram;

  /// No description provided for @accounts_bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get accounts_bank;

  /// No description provided for @accounts_cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get accounts_cash;

  /// No description provided for @accounts_savings.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get accounts_savings;

  /// No description provided for @accounts_creditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit Card'**
  String get accounts_creditCard;

  /// No description provided for @accounts_eWallet.
  ///
  /// In en, this message translates to:
  /// **'E-Wallet'**
  String get accounts_eWallet;

  /// No description provided for @accounts_gold.
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get accounts_gold;

  /// No description provided for @accounts_editAccount.
  ///
  /// In en, this message translates to:
  /// **'Edit Account'**
  String get accounts_editAccount;

  /// No description provided for @accounts_addAccount.
  ///
  /// In en, this message translates to:
  /// **'Add New Account'**
  String get accounts_addAccount;

  /// No description provided for @accounts_accountName.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get accounts_accountName;

  /// No description provided for @accounts_weightInGrams.
  ///
  /// In en, this message translates to:
  /// **'Weight in grams'**
  String get accounts_weightInGrams;

  /// No description provided for @accounts_initialBalance.
  ///
  /// In en, this message translates to:
  /// **'Initial Balance'**
  String get accounts_initialBalance;

  /// No description provided for @accounts_wontCountTowardYourHome.
  ///
  /// In en, this message translates to:
  /// **'Won\'t count toward your home screen total'**
  String get accounts_wontCountTowardYourHome;

  /// No description provided for @accounts_saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get accounts_saveChanges;

  /// No description provided for @accounts_addAccountBtn.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get accounts_addAccountBtn;

  /// No description provided for @accounts_fetchingGoldPrice.
  ///
  /// In en, this message translates to:
  /// **'Fetching gold price…'**
  String get accounts_fetchingGoldPrice;

  /// No description provided for @accounts_goldPriceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Gold price unavailable — check your connection'**
  String get accounts_goldPriceUnavailable;

  /// No description provided for @lended_person_owesYou.
  ///
  /// In en, this message translates to:
  /// **'{name} owes you'**
  String lended_person_owesYou(Object name);

  /// No description provided for @lended_person_youOwe.
  ///
  /// In en, this message translates to:
  /// **'You owe {name}'**
  String lended_person_youOwe(Object name);

  /// No description provided for @lended_person_allSettledUp.
  ///
  /// In en, this message translates to:
  /// **'All settled up'**
  String get lended_person_allSettledUp;

  /// No description provided for @lended_person_noRecordsYet.
  ///
  /// In en, this message translates to:
  /// **'No records yet'**
  String get lended_person_noRecordsYet;

  /// No description provided for @lended_person_tapPlusToLog.
  ///
  /// In en, this message translates to:
  /// **'Tap + to log money lent or borrowed'**
  String get lended_person_tapPlusToLog;

  /// No description provided for @lended_person_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get lended_person_name;

  /// No description provided for @lended_person_notesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get lended_person_notesOptional;

  /// No description provided for @lended_person_lent.
  ///
  /// In en, this message translates to:
  /// **'Lent'**
  String get lended_person_lent;

  /// No description provided for @lended_person_borrowed.
  ///
  /// In en, this message translates to:
  /// **'Borrowed'**
  String get lended_person_borrowed;

  /// No description provided for @lended_person_overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue!'**
  String get lended_person_overdue;

  /// No description provided for @lended_person_due.
  ///
  /// In en, this message translates to:
  /// **'Due {date}'**
  String lended_person_due(Object date);

  /// No description provided for @lended_person_reminderAt.
  ///
  /// In en, this message translates to:
  /// **'Reminder at {time}'**
  String lended_person_reminderAt(Object time);

  /// No description provided for @lended_person_notificationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Notification permission denied. Enable it in Settings → Apps → Expensy → Notifications.'**
  String get lended_person_notificationPermissionDenied;

  /// No description provided for @lended_person_remindMeAtPrompt.
  ///
  /// In en, this message translates to:
  /// **'Remind me at'**
  String get lended_person_remindMeAtPrompt;

  /// No description provided for @lended_person_editRecord.
  ///
  /// In en, this message translates to:
  /// **'Edit Record'**
  String get lended_person_editRecord;

  /// No description provided for @lended_person_addRecord.
  ///
  /// In en, this message translates to:
  /// **'Add Record'**
  String get lended_person_addRecord;

  /// No description provided for @lended_person_amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get lended_person_amount;

  /// No description provided for @lended_person_dueColon.
  ///
  /// In en, this message translates to:
  /// **'Due: {date}'**
  String lended_person_dueColon(Object date);

  /// No description provided for @lended_person_noDueDate.
  ///
  /// In en, this message translates to:
  /// **'No due date'**
  String get lended_person_noDueDate;

  /// No description provided for @lended_person_setDueFirst.
  ///
  /// In en, this message translates to:
  /// **'Set a due date first'**
  String get lended_person_setDueFirst;

  /// No description provided for @lended_person_notifiedOnDue.
  ///
  /// In en, this message translates to:
  /// **'You\'ll be notified on the due date'**
  String get lended_person_notifiedOnDue;

  /// No description provided for @lended_person_getNotifiedWhenDue.
  ///
  /// In en, this message translates to:
  /// **'Get notified when this is due'**
  String get lended_person_getNotifiedWhenDue;

  /// No description provided for @lended_person_thatTimePassed.
  ///
  /// In en, this message translates to:
  /// **'That time today has already passed — you\'ll be notified shortly instead.'**
  String get lended_person_thatTimePassed;

  /// No description provided for @lended_person_notificationFiresOn.
  ///
  /// In en, this message translates to:
  /// **'Notification fires on {date} at {time}.'**
  String lended_person_notificationFiresOn(Object date, Object time);

  /// No description provided for @lended_person_saveChangesBtn.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get lended_person_saveChangesBtn;

  /// No description provided for @lended_person_addRecordBtn.
  ///
  /// In en, this message translates to:
  /// **'Add Record'**
  String get lended_person_addRecordBtn;

  /// No description provided for @transactions_searchTransactions.
  ///
  /// In en, this message translates to:
  /// **'Search transactions...'**
  String get transactions_searchTransactions;

  /// No description provided for @transactions_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get transactions_all;

  /// No description provided for @transactions_income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get transactions_income;

  /// No description provided for @transactions_expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get transactions_expenses;

  /// No description provided for @transactions_lent.
  ///
  /// In en, this message translates to:
  /// **'Lent'**
  String get transactions_lent;

  /// No description provided for @transactions_borrowed.
  ///
  /// In en, this message translates to:
  /// **'Borrowed'**
  String get transactions_borrowed;

  /// No description provided for @transactions_noTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions'**
  String get transactions_noTransactions;

  /// No description provided for @transactions_tapPlusToAddOne.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add one'**
  String get transactions_tapPlusToAddOne;

  /// No description provided for @transactions_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get transactions_today;

  /// No description provided for @transactions_yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get transactions_yesterday;

  /// No description provided for @transactions_lentTo.
  ///
  /// In en, this message translates to:
  /// **'Lent to {name}'**
  String transactions_lentTo(Object name);

  /// No description provided for @transactions_borrowedFrom.
  ///
  /// In en, this message translates to:
  /// **'Borrowed from {name}'**
  String transactions_borrowedFrom(Object name);

  /// No description provided for @transactions_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get transactions_unknown;

  /// No description provided for @transactions_due.
  ///
  /// In en, this message translates to:
  /// **'Due {date}'**
  String transactions_due(Object date);

  /// No description provided for @transactions_unsettled.
  ///
  /// In en, this message translates to:
  /// **'Unsettled'**
  String get transactions_unsettled;

  /// No description provided for @onboarding_restoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Restore failed: the file may be corrupted or not an Expensy backup.'**
  String get onboarding_restoreFailed;

  /// No description provided for @onboarding_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboarding_continue;

  /// No description provided for @onboarding_getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboarding_getStarted;

  /// No description provided for @onboarding_yourPersonalTracker.
  ///
  /// In en, this message translates to:
  /// **'Your personal, 100% offline finance tracker.\nAlready have a backup from another device or a previous install?'**
  String get onboarding_yourPersonalTracker;

  /// No description provided for @onboarding_restoring.
  ///
  /// In en, this message translates to:
  /// **'Restoring...'**
  String get onboarding_restoring;

  /// No description provided for @onboarding_chooseBackupFile.
  ///
  /// In en, this message translates to:
  /// **'Choose Backup File'**
  String get onboarding_chooseBackupFile;

  /// No description provided for @onboarding_letsGetYouSetUp.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get you set up'**
  String get onboarding_letsGetYouSetUp;

  /// No description provided for @onboarding_yourName.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get onboarding_yourName;

  /// No description provided for @onboarding_accountName.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get onboarding_accountName;

  /// No description provided for @onboarding_bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get onboarding_bank;

  /// No description provided for @onboarding_cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get onboarding_cash;

  /// No description provided for @onboarding_savings.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get onboarding_savings;

  /// No description provided for @onboarding_credit.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get onboarding_credit;

  /// No description provided for @onboarding_wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get onboarding_wallet;

  /// No description provided for @onboarding_startingBalance.
  ///
  /// In en, this message translates to:
  /// **'Starting Balance'**
  String get onboarding_startingBalance;

  /// No description provided for @backup_replaceDataWarning.
  ///
  /// In en, this message translates to:
  /// **'This will replace ALL your current data with the backup.\nThis cannot be undone.'**
  String get backup_replaceDataWarning;

  /// No description provided for @backup_whatsIncluded.
  ///
  /// In en, this message translates to:
  /// **'What\'s included'**
  String get backup_whatsIncluded;

  /// No description provided for @backup_backupDescription.
  ///
  /// In en, this message translates to:
  /// **'Every backup includes all of your data — accounts, transactions, recurring payments and their pay/skip history, budgets, wishlist items, lent & borrowed people and records, assets, categories, and app settings.'**
  String get backup_backupDescription;

  /// No description provided for @backup_saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get backup_saving;

  /// No description provided for @backup_saveBackup.
  ///
  /// In en, this message translates to:
  /// **'Save Backup'**
  String get backup_saveBackup;

  /// No description provided for @backup_restoring.
  ///
  /// In en, this message translates to:
  /// **'Restoring...'**
  String get backup_restoring;

  /// No description provided for @backup_restoreBackupBtn.
  ///
  /// In en, this message translates to:
  /// **'Restore Backup'**
  String get backup_restoreBackupBtn;

  /// No description provided for @backup_restoreWarningText.
  ///
  /// In en, this message translates to:
  /// **'Compatible with backups from any app version. Missing fields are filled with safe defaults.'**
  String get backup_restoreWarningText;

  /// No description provided for @backup_included.
  ///
  /// In en, this message translates to:
  /// **'included'**
  String get backup_included;

  /// No description provided for @backup_accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get backup_accounts;

  /// No description provided for @backup_transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get backup_transactions;

  /// No description provided for @backup_recurringPayments.
  ///
  /// In en, this message translates to:
  /// **'Recurring Payments'**
  String get backup_recurringPayments;

  /// No description provided for @backup_recurringHistory.
  ///
  /// In en, this message translates to:
  /// **'Recurring History'**
  String get backup_recurringHistory;

  /// No description provided for @backup_budgets.
  ///
  /// In en, this message translates to:
  /// **'Budgets'**
  String get backup_budgets;

  /// No description provided for @backup_wishlist.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get backup_wishlist;

  /// No description provided for @backup_lentPeople.
  ///
  /// In en, this message translates to:
  /// **'Lent/Borrowed — People'**
  String get backup_lentPeople;

  /// No description provided for @backup_lentRecords.
  ///
  /// In en, this message translates to:
  /// **'Lent/Borrowed — Records'**
  String get backup_lentRecords;

  /// No description provided for @backup_assets.
  ///
  /// In en, this message translates to:
  /// **'Assets'**
  String get backup_assets;

  /// No description provided for @backup_categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get backup_categories;

  /// No description provided for @backup_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get backup_settings;

  /// No description provided for @backup_backupSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Backup saved successfully:\n{savedPath}'**
  String backup_backupSavedSuccessfully(Object savedPath);

  /// No description provided for @backup_backupFailed.
  ///
  /// In en, this message translates to:
  /// **'Backup failed: {error}'**
  String backup_backupFailed(Object error);

  /// No description provided for @backup_upgradedFrom.
  ///
  /// In en, this message translates to:
  /// **' (upgraded from v{originalVersion} → v{schemaVersion})'**
  String backup_upgradedFrom(Object originalVersion, Object schemaVersion);

  /// No description provided for @backup_dataRestoredSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Data restored successfully!{vLabel}'**
  String backup_dataRestoredSuccessfully(Object vLabel);

  /// No description provided for @backup_restoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Restore failed: {error}'**
  String backup_restoreFailed(Object error);

  /// No description provided for @backup_restoreFailedCorrupted.
  ///
  /// In en, this message translates to:
  /// **'Restore failed: the file may be corrupted or not an Expensy backup.'**
  String get backup_restoreFailedCorrupted;

  /// No description provided for @budget_noBudgetsYet.
  ///
  /// In en, this message translates to:
  /// **'No budgets yet'**
  String get budget_noBudgetsYet;

  /// No description provided for @budget_tapToAddBudget.
  ///
  /// In en, this message translates to:
  /// **'Tap + to set a spending limit per category'**
  String get budget_tapToAddBudget;

  /// No description provided for @budget_budgeted.
  ///
  /// In en, this message translates to:
  /// **'Budgeted'**
  String get budget_budgeted;

  /// No description provided for @budget_leftToSpend.
  ///
  /// In en, this message translates to:
  /// **'Left to Spend'**
  String get budget_leftToSpend;

  /// No description provided for @budget_spent.
  ///
  /// In en, this message translates to:
  /// **'Spent'**
  String get budget_spent;

  /// No description provided for @budget_overLimit.
  ///
  /// In en, this message translates to:
  /// **'Over limit'**
  String get budget_overLimit;

  /// No description provided for @budget_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get budget_unknown;

  /// No description provided for @budget_weeklyLabel.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get budget_weeklyLabel;

  /// No description provided for @budget_monthlyLabel.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get budget_monthlyLabel;

  /// No description provided for @budget_overAmount.
  ///
  /// In en, this message translates to:
  /// **'{amount} over'**
  String budget_overAmount(Object amount);

  /// No description provided for @budget_leftAmount.
  ///
  /// In en, this message translates to:
  /// **'{amount} left'**
  String budget_leftAmount(Object amount);

  /// No description provided for @budget_percentUsed.
  ///
  /// In en, this message translates to:
  /// **'{percent}% used'**
  String budget_percentUsed(Object percent);

  /// No description provided for @budget_editBudget.
  ///
  /// In en, this message translates to:
  /// **'Edit Budget'**
  String get budget_editBudget;

  /// No description provided for @budget_setBudget.
  ///
  /// In en, this message translates to:
  /// **'Add New Budget'**
  String get budget_setBudget;

  /// No description provided for @budget_budgetAmount.
  ///
  /// In en, this message translates to:
  /// **'Budget amount'**
  String get budget_budgetAmount;

  /// No description provided for @budget_previewFor.
  ///
  /// In en, this message translates to:
  /// **'Preview for \"{catName}\"'**
  String budget_previewFor(Object catName);

  /// No description provided for @budget_spentAmount.
  ///
  /// In en, this message translates to:
  /// **'Spent: {amount}'**
  String budget_spentAmount(Object amount);

  /// No description provided for @budget_ofAmount.
  ///
  /// In en, this message translates to:
  /// **'of {amount}'**
  String budget_ofAmount(Object amount);

  /// No description provided for @budget_saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get budget_saveChanges;

  /// No description provided for @budget_budget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get budget_budget;

  /// No description provided for @budget_rollover.
  ///
  /// In en, this message translates to:
  /// **'Rollover (Envelope)'**
  String get budget_rollover;

  /// No description provided for @budget_rolloverDesc.
  ///
  /// In en, this message translates to:
  /// **'Carry forward unused surplus or deficits to the next period'**
  String get budget_rolloverDesc;

  /// No description provided for @budget_rolloverBadge.
  ///
  /// In en, this message translates to:
  /// **'Rollover'**
  String get budget_rolloverBadge;

  /// No description provided for @budget_base.
  ///
  /// In en, this message translates to:
  /// **'Base: {amount}'**
  String budget_base(Object amount);

  /// No description provided for @budget_rolloverFrom.
  ///
  /// In en, this message translates to:
  /// **'Rollover ({period}): {amount}'**
  String budget_rolloverFrom(Object period, Object amount);

  /// No description provided for @budget_totalAvailable.
  ///
  /// In en, this message translates to:
  /// **'Total Available: {amount}'**
  String budget_totalAvailable(Object amount);

  /// No description provided for @budget_lastWeek.
  ///
  /// In en, this message translates to:
  /// **'Last Week'**
  String get budget_lastWeek;

  /// No description provided for @pacing_dailyBudget.
  ///
  /// In en, this message translates to:
  /// **'Safe-to-Spend'**
  String get pacing_dailyBudget;

  /// No description provided for @pacing_safeToSpend.
  ///
  /// In en, this message translates to:
  /// **'Safe to spend: {amount}/day ({days} left)'**
  String pacing_safeToSpend(Object amount, Object days);

  /// No description provided for @pacing_caution.
  ///
  /// In en, this message translates to:
  /// **'Pacing fast — limit to {amount}/day'**
  String pacing_caution(Object amount);

  /// No description provided for @pacing_overPaced.
  ///
  /// In en, this message translates to:
  /// **'Pace Alert — slow down to stay in budget'**
  String get pacing_overPaced;

  /// No description provided for @pacing_budgetExhausted.
  ///
  /// In en, this message translates to:
  /// **'Budget reached — no daily allowance left'**
  String get pacing_budgetExhausted;

  /// No description provided for @pacing_onTrack.
  ///
  /// In en, this message translates to:
  /// **'On track'**
  String get pacing_onTrack;

  /// No description provided for @pacing_fast.
  ///
  /// In en, this message translates to:
  /// **'Pacing fast'**
  String get pacing_fast;

  /// No description provided for @pacing_alert.
  ///
  /// In en, this message translates to:
  /// **'Pace alert'**
  String get pacing_alert;

  /// No description provided for @pacing_daysLeft.
  ///
  /// In en, this message translates to:
  /// **'{days} days left'**
  String pacing_daysLeft(Object days);

  /// No description provided for @pacing_setBudgetPrompt.
  ///
  /// In en, this message translates to:
  /// **'Tap to set budget limits →'**
  String get pacing_setBudgetPrompt;

  /// No description provided for @pacing_dailyAvgPace.
  ///
  /// In en, this message translates to:
  /// **'Daily Pace'**
  String get pacing_dailyAvgPace;

  /// No description provided for @pacing_perDay.
  ///
  /// In en, this message translates to:
  /// **'{amount} / day'**
  String pacing_perDay(Object amount);

  /// No description provided for @calendar_title.
  ///
  /// In en, this message translates to:
  /// **'Financial Calendar'**
  String get calendar_title;

  /// No description provided for @calendar_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Daily spending heatmap & due dates'**
  String get calendar_subtitle;

  /// No description provided for @calendar_zeroSpendDays.
  ///
  /// In en, this message translates to:
  /// **'{count} Zero-Spend Days'**
  String calendar_zeroSpendDays(Object count);

  /// No description provided for @calendar_zeroSpendDayTitle.
  ///
  /// In en, this message translates to:
  /// **'Zero-Spend Day! 🎉'**
  String get calendar_zeroSpendDayTitle;

  /// No description provided for @calendar_zeroSpendDayDesc.
  ///
  /// In en, this message translates to:
  /// **'Great job maintaining financial discipline with no expenses today.'**
  String get calendar_zeroSpendDayDesc;

  /// No description provided for @calendar_billsDue.
  ///
  /// In en, this message translates to:
  /// **'Bills & Subscriptions Due'**
  String get calendar_billsDue;

  /// No description provided for @calendar_loansDue.
  ///
  /// In en, this message translates to:
  /// **'Loan Payments Due'**
  String get calendar_loansDue;

  /// No description provided for @calendar_lendedDue.
  ///
  /// In en, this message translates to:
  /// **'Expected Repayments'**
  String get calendar_lendedDue;

  /// No description provided for @calendar_dayTransactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions ({count})'**
  String calendar_dayTransactions(Object count);

  /// No description provided for @calendar_noActivity.
  ///
  /// In en, this message translates to:
  /// **'No transactions or obligations on this date'**
  String get calendar_noActivity;

  /// No description provided for @calendar_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get calendar_today;

  /// No description provided for @calendar_averageDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily avg: {amount}'**
  String calendar_averageDaily(Object amount);

  /// No description provided for @wrapped_title.
  ///
  /// In en, this message translates to:
  /// **'Expensy Wrapped'**
  String get wrapped_title;

  /// No description provided for @wrapped_bannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Your {month} Wrapped is ready!'**
  String wrapped_bannerTitle(Object month);

  /// No description provided for @wrapped_bannerSub.
  ///
  /// In en, this message translates to:
  /// **'Tap to explore your monthly financial story'**
  String get wrapped_bannerSub;

  /// No description provided for @wrapped_theBigPicture.
  ///
  /// In en, this message translates to:
  /// **'The Big Picture'**
  String get wrapped_theBigPicture;

  /// No description provided for @wrapped_howMoneyMoved.
  ///
  /// In en, this message translates to:
  /// **'Here is how your money moved in {month}'**
  String wrapped_howMoneyMoved(Object month);

  /// No description provided for @wrapped_totalInflow.
  ///
  /// In en, this message translates to:
  /// **'Total Inflow'**
  String get wrapped_totalInflow;

  /// No description provided for @wrapped_totalOutflow.
  ///
  /// In en, this message translates to:
  /// **'Total Outflow'**
  String get wrapped_totalOutflow;

  /// No description provided for @wrapped_netSavings.
  ///
  /// In en, this message translates to:
  /// **'Net Saved'**
  String get wrapped_netSavings;

  /// No description provided for @wrapped_savingsRate.
  ///
  /// In en, this message translates to:
  /// **'Savings Rate: {rate}%'**
  String wrapped_savingsRate(Object rate);

  /// No description provided for @wrapped_topCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Where Did It Go?'**
  String get wrapped_topCategoryTitle;

  /// No description provided for @wrapped_topCategorySub.
  ///
  /// In en, this message translates to:
  /// **'Your top spending category was {category}'**
  String wrapped_topCategorySub(Object category);

  /// No description provided for @wrapped_topCategoryShare.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of your total spending'**
  String wrapped_topCategoryShare(Object percent);

  /// No description provided for @wrapped_biggestSplurgeTitle.
  ///
  /// In en, this message translates to:
  /// **'Biggest Splurge'**
  String get wrapped_biggestSplurgeTitle;

  /// No description provided for @wrapped_biggestSplurgeSub.
  ///
  /// In en, this message translates to:
  /// **'Your single largest expense of the month'**
  String get wrapped_biggestSplurgeSub;

  /// No description provided for @wrapped_noSplurge.
  ///
  /// In en, this message translates to:
  /// **'No splurges! You had zero expenses this month.'**
  String get wrapped_noSplurge;

  /// No description provided for @wrapped_heroHabitTitle.
  ///
  /// In en, this message translates to:
  /// **'Hero Habit'**
  String get wrapped_heroHabitTitle;

  /// No description provided for @wrapped_zeroSpendAchieved.
  ///
  /// In en, this message translates to:
  /// **'{count} Zero-Spend Days'**
  String wrapped_zeroSpendAchieved(Object count);

  /// No description provided for @wrapped_heroHabitDesc.
  ///
  /// In en, this message translates to:
  /// **'You achieved {count} days with zero expenses. Outstanding financial discipline!'**
  String wrapped_heroHabitDesc(Object count);

  /// No description provided for @wrapped_receiptTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly Statement'**
  String get wrapped_receiptTitle;

  /// No description provided for @wrapped_obscureToggle.
  ///
  /// In en, this message translates to:
  /// **'Hide amounts for sharing'**
  String get wrapped_obscureToggle;

  /// No description provided for @wrapped_showToggle.
  ///
  /// In en, this message translates to:
  /// **'Show amounts'**
  String get wrapped_showToggle;

  /// No description provided for @wrapped_replay.
  ///
  /// In en, this message translates to:
  /// **'Replay Story'**
  String get wrapped_replay;

  /// No description provided for @insights_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get insights_other;

  /// No description provided for @insights_noDataYet.
  ///
  /// In en, this message translates to:
  /// **'No data yet'**
  String get insights_noDataYet;

  /// No description provided for @insights_addSomeTransactions.
  ///
  /// In en, this message translates to:
  /// **'Add some transactions to see insights'**
  String get insights_addSomeTransactions;

  /// No description provided for @insights_thisMonthVsLastMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month vs Last Month'**
  String get insights_thisMonthVsLastMonth;

  /// No description provided for @insights_dailyAverage.
  ///
  /// In en, this message translates to:
  /// **'Daily Average'**
  String get insights_dailyAverage;

  /// No description provided for @insights_perDayBasedOn.
  ///
  /// In en, this message translates to:
  /// **'per day · based on {days} days this month'**
  String insights_perDayBasedOn(Object days);

  /// No description provided for @insights_incomeVsExpenses.
  ///
  /// In en, this message translates to:
  /// **'Income vs Expenses'**
  String get insights_incomeVsExpenses;

  /// No description provided for @insights_incomeAmount.
  ///
  /// In en, this message translates to:
  /// **'Income {amount}'**
  String insights_incomeAmount(Object amount);

  /// No description provided for @insights_expensesAmount.
  ///
  /// In en, this message translates to:
  /// **'Expenses {amount}'**
  String insights_expensesAmount(Object amount);

  /// No description provided for @insights_percentSaved.
  ///
  /// In en, this message translates to:
  /// **'{percent}% saved this month'**
  String insights_percentSaved(Object percent);

  /// No description provided for @insights_topSpendingCategories.
  ///
  /// In en, this message translates to:
  /// **'Top Spending Categories'**
  String get insights_topSpendingCategories;

  /// No description provided for @insights_percentOfTotal.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of total'**
  String insights_percentOfTotal(Object percent);

  /// No description provided for @insights_biggestExpenseThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Biggest Expense This Month'**
  String get insights_biggestExpenseThisMonth;

  /// No description provided for @insights_categoryTrends.
  ///
  /// In en, this message translates to:
  /// **'Category Trends (vs Last Month)'**
  String get insights_categoryTrends;

  /// No description provided for @insights_12MonthTrend.
  ///
  /// In en, this message translates to:
  /// **'12-Month Trend'**
  String get insights_12MonthTrend;

  /// No description provided for @insights_incomeLabel.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get insights_incomeLabel;

  /// No description provided for @insights_expensesLabel.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get insights_expensesLabel;

  /// No description provided for @categories_expenseLabel.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get categories_expenseLabel;

  /// No description provided for @categories_incomeLabel.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get categories_incomeLabel;

  /// No description provided for @categories_editCategory.
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get categories_editCategory;

  /// No description provided for @categories_addCategory.
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get categories_addCategory;

  /// No description provided for @categories_categoryName.
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get categories_categoryName;

  /// No description provided for @categories_saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get categories_saveChanges;

  /// No description provided for @statistics_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get statistics_other;

  /// No description provided for @statistics_allAccounts.
  ///
  /// In en, this message translates to:
  /// **'All accounts'**
  String get statistics_allAccounts;

  /// No description provided for @statistics_income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get statistics_income;

  /// No description provided for @statistics_expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get statistics_expenses;

  /// No description provided for @statistics_expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get statistics_expense;

  /// No description provided for @statistics_net.
  ///
  /// In en, this message translates to:
  /// **'Net'**
  String get statistics_net;

  /// No description provided for @statistics_6MonthOverviewAccount.
  ///
  /// In en, this message translates to:
  /// **'6-Month Overview · {accountName}'**
  String statistics_6MonthOverviewAccount(Object accountName);

  /// No description provided for @statistics_6MonthOverview.
  ///
  /// In en, this message translates to:
  /// **'6-Month Overview'**
  String get statistics_6MonthOverview;

  /// No description provided for @statistics_percentOfBudget.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of budget'**
  String statistics_percentOfBudget(Object percent);

  /// No description provided for @add_transaction_editTransaction.
  ///
  /// In en, this message translates to:
  /// **'Edit Transaction'**
  String get add_transaction_editTransaction;

  /// No description provided for @add_transaction_addTransaction.
  ///
  /// In en, this message translates to:
  /// **'Enter Transaction'**
  String get add_transaction_addTransaction;

  /// No description provided for @add_transaction_amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get add_transaction_amount;

  /// No description provided for @add_transaction_conversionPreview.
  ///
  /// In en, this message translates to:
  /// **'≈ {amount} will be deducted from {accountName}'**
  String add_transaction_conversionPreview(Object accountName, Object amount);

  /// No description provided for @add_transaction_accountFallback.
  ///
  /// In en, this message translates to:
  /// **'account'**
  String get add_transaction_accountFallback;

  /// No description provided for @add_transaction_descriptionOptional.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get add_transaction_descriptionOptional;

  /// No description provided for @add_transaction_noteOptional.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get add_transaction_noteOptional;

  /// No description provided for @add_transaction_saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get add_transaction_saveChanges;

  /// No description provided for @more_statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get more_statistics;

  /// No description provided for @more_statisticsSub.
  ///
  /// In en, this message translates to:
  /// **'Charts & monthly summary'**
  String get more_statisticsSub;

  /// No description provided for @more_insights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get more_insights;

  /// No description provided for @more_insightsSub.
  ///
  /// In en, this message translates to:
  /// **'Trends, averages & category analysis'**
  String get more_insightsSub;

  /// No description provided for @more_currencyConverter.
  ///
  /// In en, this message translates to:
  /// **'Currency Converter'**
  String get more_currencyConverter;

  /// No description provided for @more_currencyConverterSub.
  ///
  /// In en, this message translates to:
  /// **'Convert between currencies instantly'**
  String get more_currencyConverterSub;

  /// No description provided for @more_wishlist.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get more_wishlist;

  /// No description provided for @more_wishlistSub.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item} other{{count} items}}'**
  String more_wishlistSub(num count);

  /// No description provided for @more_lentMoney.
  ///
  /// In en, this message translates to:
  /// **'Lent Money'**
  String get more_lentMoney;

  /// No description provided for @more_lentMoneySub.
  ///
  /// In en, this message translates to:
  /// **'{count} outstanding'**
  String more_lentMoneySub(Object count);

  /// No description provided for @more_assets.
  ///
  /// In en, this message translates to:
  /// **'Assets'**
  String get more_assets;

  /// No description provided for @more_assetsSub.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item} other{{count} items}}'**
  String more_assetsSub(num count);

  /// No description provided for @more_categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get more_categories;

  /// No description provided for @more_categoriesSub.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 category} other{{count} categories}}'**
  String more_categoriesSub(num count);

  /// No description provided for @more_exportTransactions.
  ///
  /// In en, this message translates to:
  /// **'Export Transactions'**
  String get more_exportTransactions;

  /// No description provided for @more_exportTransactionsSub.
  ///
  /// In en, this message translates to:
  /// **'Save as Excel (.xlsx)'**
  String get more_exportTransactionsSub;

  /// No description provided for @more_backupRestore.
  ///
  /// In en, this message translates to:
  /// **'Backup & Restore'**
  String get more_backupRestore;

  /// No description provided for @more_backupRestoreSub.
  ///
  /// In en, this message translates to:
  /// **'Save or load your data'**
  String get more_backupRestoreSub;

  /// No description provided for @more_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get more_settings;

  /// No description provided for @more_settingsSub.
  ///
  /// In en, this message translates to:
  /// **'Theme, currency & preferences'**
  String get more_settingsSub;

  /// No description provided for @more_sectionTools.
  ///
  /// In en, this message translates to:
  /// **'Financial Tools'**
  String get more_sectionTools;

  /// No description provided for @more_sectionAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics & Insights'**
  String get more_sectionAnalytics;

  /// No description provided for @more_sectionPreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences & Data'**
  String get more_sectionPreferences;

  /// No description provided for @home_greeting.
  ///
  /// In en, this message translates to:
  /// **'Hi, {name} 👋'**
  String home_greeting(Object name);

  /// No description provided for @home_there.
  ///
  /// In en, this message translates to:
  /// **'there'**
  String get home_there;

  /// No description provided for @home_income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get home_income;

  /// No description provided for @home_expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get home_expenses;

  /// No description provided for @home_net.
  ///
  /// In en, this message translates to:
  /// **'Net'**
  String get home_net;

  /// No description provided for @wishlist_noItems.
  ///
  /// In en, this message translates to:
  /// **'No wishlist items'**
  String get wishlist_noItems;

  /// No description provided for @wishlist_noItemsSub.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add items you\'re saving for'**
  String get wishlist_noItemsSub;

  /// No description provided for @wishlist_editItem.
  ///
  /// In en, this message translates to:
  /// **'Edit Item'**
  String get wishlist_editItem;

  /// No description provided for @wishlist_addWishlistItem.
  ///
  /// In en, this message translates to:
  /// **'Add Wishlist Item'**
  String get wishlist_addWishlistItem;

  /// No description provided for @wishlist_itemName.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get wishlist_itemName;

  /// No description provided for @wishlist_targetPrice.
  ///
  /// In en, this message translates to:
  /// **'Target Price'**
  String get wishlist_targetPrice;

  /// No description provided for @wishlist_priorityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get wishlist_priorityLow;

  /// No description provided for @wishlist_priorityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get wishlist_priorityMedium;

  /// No description provided for @wishlist_priorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get wishlist_priorityHigh;

  /// No description provided for @wishlist_notesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get wishlist_notesOptional;

  /// No description provided for @wishlist_saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get wishlist_saveChanges;

  /// No description provided for @wishlist_addItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get wishlist_addItem;

  /// No description provided for @wishlist_fundThisItem.
  ///
  /// In en, this message translates to:
  /// **'Fund Item'**
  String get wishlist_fundThisItem;

  /// No description provided for @wishlist_funded.
  ///
  /// In en, this message translates to:
  /// **'{percent}% funded ({saved} / {target})'**
  String wishlist_funded(int percent, String saved, String target);

  /// No description provided for @wishlist_goalAchieved.
  ///
  /// In en, this message translates to:
  /// **'Goal Achieved — Ready to Buy!'**
  String get wishlist_goalAchieved;

  /// No description provided for @wishlist_buyNow.
  ///
  /// In en, this message translates to:
  /// **'Buy Now'**
  String get wishlist_buyNow;

  /// No description provided for @wishlist_purchaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Purchase Wishlist Item'**
  String get wishlist_purchaseTitle;

  /// No description provided for @wishlist_purchasePrompt.
  ///
  /// In en, this message translates to:
  /// **'Do you want to record an expense transaction to deduct this purchase from an account?'**
  String get wishlist_purchasePrompt;

  /// No description provided for @wishlist_recordAndDeduct.
  ///
  /// In en, this message translates to:
  /// **'Record & Deduct'**
  String get wishlist_recordAndDeduct;

  /// No description provided for @wishlist_markPurchasedOnly.
  ///
  /// In en, this message translates to:
  /// **'Mark Purchased Only'**
  String get wishlist_markPurchasedOnly;

  /// No description provided for @wishlist_itemPurchased.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" marked as purchased!'**
  String wishlist_itemPurchased(String name);

  /// No description provided for @wishlist_viewGoal.
  ///
  /// In en, this message translates to:
  /// **'View Savings Goal'**
  String get wishlist_viewGoal;

  /// No description provided for @savings_linkedWishlist.
  ///
  /// In en, this message translates to:
  /// **'Linked to Wishlist: {item}'**
  String savings_linkedWishlist(String item);

  /// No description provided for @lended_theyOweMe.
  ///
  /// In en, this message translates to:
  /// **'They Owe Me'**
  String get lended_theyOweMe;

  /// No description provided for @lended_iOweThem.
  ///
  /// In en, this message translates to:
  /// **'I Owe Them'**
  String get lended_iOweThem;

  /// No description provided for @lended_net.
  ///
  /// In en, this message translates to:
  /// **'Net'**
  String get lended_net;

  /// No description provided for @lended_noOneYet.
  ///
  /// In en, this message translates to:
  /// **'No one yet'**
  String get lended_noOneYet;

  /// No description provided for @lended_noOneYetSub.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add a person you lend to or borrow from'**
  String get lended_noOneYetSub;

  /// No description provided for @lended_owesYou.
  ///
  /// In en, this message translates to:
  /// **'Owes you'**
  String get lended_owesYou;

  /// No description provided for @lended_youOwe.
  ///
  /// In en, this message translates to:
  /// **'You owe'**
  String get lended_youOwe;

  /// No description provided for @lended_settledUp.
  ///
  /// In en, this message translates to:
  /// **'Settled up'**
  String get lended_settledUp;

  /// No description provided for @lended_noActiveRecords.
  ///
  /// In en, this message translates to:
  /// **'No active records'**
  String get lended_noActiveRecords;

  /// No description provided for @lended_activeRecords.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 active record} other{{count} active records}}'**
  String lended_activeRecords(num count);

  /// No description provided for @lended_editPerson.
  ///
  /// In en, this message translates to:
  /// **'Edit Person'**
  String get lended_editPerson;

  /// No description provided for @lended_addPerson.
  ///
  /// In en, this message translates to:
  /// **'Add Person'**
  String get lended_addPerson;

  /// No description provided for @lended_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get lended_name;

  /// No description provided for @lended_notesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get lended_notesOptional;

  /// No description provided for @lended_saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get lended_saveChanges;

  /// No description provided for @assets_totalAssets.
  ///
  /// In en, this message translates to:
  /// **'Total Assets'**
  String get assets_totalAssets;

  /// No description provided for @assets_items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get assets_items;

  /// No description provided for @assets_noAssetsYet.
  ///
  /// In en, this message translates to:
  /// **'No assets yet'**
  String get assets_noAssetsYet;

  /// No description provided for @assets_noAssetsYetSub.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add a product or asset'**
  String get assets_noAssetsYetSub;

  /// No description provided for @assets_editAsset.
  ///
  /// In en, this message translates to:
  /// **'Edit Asset'**
  String get assets_editAsset;

  /// No description provided for @assets_addAsset.
  ///
  /// In en, this message translates to:
  /// **'Add Asset'**
  String get assets_addAsset;

  /// No description provided for @assets_productAssetName.
  ///
  /// In en, this message translates to:
  /// **'Product / Asset Name'**
  String get assets_productAssetName;

  /// No description provided for @assets_value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get assets_value;

  /// No description provided for @assets_notesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get assets_notesOptional;

  /// No description provided for @assets_saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get assets_saveChanges;

  /// No description provided for @currency_converter_loadingRates.
  ///
  /// In en, this message translates to:
  /// **'Loading exchange rates…'**
  String get currency_converter_loadingRates;

  /// No description provided for @currency_converter_ratesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Exchange rates unavailable. Connect to the internet and sync.'**
  String get currency_converter_ratesUnavailable;

  /// No description provided for @currency_converter_rateAgeJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get currency_converter_rateAgeJustNow;

  /// No description provided for @currency_converter_rateAgeMins.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String currency_converter_rateAgeMins(Object minutes);

  /// No description provided for @currency_converter_rateAgeHours.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String currency_converter_rateAgeHours(Object hours);

  /// No description provided for @currency_converter_rateAgeDays.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String currency_converter_rateAgeDays(Object days);

  /// No description provided for @currency_converter_commonConversions.
  ///
  /// In en, this message translates to:
  /// **'Common Conversions from {fromCurrency}'**
  String currency_converter_commonConversions(Object fromCurrency);

  /// No description provided for @transfer_fromAcc.
  ///
  /// In en, this message translates to:
  /// **'From ({currency})'**
  String transfer_fromAcc(Object currency);

  /// No description provided for @transfer_toAcc.
  ///
  /// In en, this message translates to:
  /// **'To ({currency})'**
  String transfer_toAcc(Object currency);

  /// No description provided for @transfer_exchangeRatesNotLoaded.
  ///
  /// In en, this message translates to:
  /// **'Exchange rates not loaded — amount will be transferred as-is'**
  String get transfer_exchangeRatesNotLoaded;

  /// No description provided for @transfer_amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get transfer_amount;

  /// No description provided for @transfer_noteOptional.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get transfer_noteOptional;

  /// No description provided for @export_from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get export_from;

  /// No description provided for @export_to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get export_to;

  /// No description provided for @export_txCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 transaction in range} other{{count} transactions in range}}'**
  String export_txCount(num count);

  /// No description provided for @export_saved.
  ///
  /// In en, this message translates to:
  /// **'Saved: {path}'**
  String export_saved(Object path);

  /// No description provided for @export_complete.
  ///
  /// In en, this message translates to:
  /// **'Export complete'**
  String get export_complete;

  /// No description provided for @export_exporting.
  ///
  /// In en, this message translates to:
  /// **'Exporting...'**
  String get export_exporting;

  /// No description provided for @export_exportAsExcel.
  ///
  /// In en, this message translates to:
  /// **'Export as Excel'**
  String get export_exportAsExcel;

  /// No description provided for @shared_widgets_deleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"? This cannot be undone.'**
  String shared_widgets_deleteConfirm(Object name);

  /// No description provided for @shared_widgets_searchByCode.
  ///
  /// In en, this message translates to:
  /// **'Search by code or name...'**
  String get shared_widgets_searchByCode;

  /// No description provided for @accounts_accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accounts_accounts;

  /// No description provided for @accounts_totalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get accounts_totalBalance;

  /// No description provided for @accounts_excluded.
  ///
  /// In en, this message translates to:
  /// **'Excluded'**
  String get accounts_excluded;

  /// No description provided for @accounts_goldPriceNotYetLoade.
  ///
  /// In en, this message translates to:
  /// **'Gold price not yet loaded. Wait a moment and try again.'**
  String get accounts_goldPriceNotYetLoade;

  /// No description provided for @accounts_accountType.
  ///
  /// In en, this message translates to:
  /// **'Account Type'**
  String get accounts_accountType;

  /// No description provided for @accounts_currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get accounts_currency;

  /// No description provided for @accounts_goldPurityKarat.
  ///
  /// In en, this message translates to:
  /// **'Gold Purity (Karat)'**
  String get accounts_goldPurityKarat;

  /// No description provided for @accounts_weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get accounts_weight;

  /// No description provided for @accounts_excludeFromTotalBala.
  ///
  /// In en, this message translates to:
  /// **'Exclude from Total Balance'**
  String get accounts_excludeFromTotalBala;

  /// Toggle to prevent bank account from linking with a card and restore manual balance and exclude toggle
  ///
  /// In en, this message translates to:
  /// **'Don\'t link to Card'**
  String get accounts_dontLinkToCard;

  /// Subtitle describing the Don't link to Card toggle
  ///
  /// In en, this message translates to:
  /// **'Manage this account\'s balance manually and prevent cards from linking to it'**
  String get accounts_dontLinkToCardDesc;

  /// No description provided for @accounts_color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get accounts_color;

  /// No description provided for @accounts_liveGoldValue.
  ///
  /// In en, this message translates to:
  /// **'Live Gold Value'**
  String get accounts_liveGoldValue;

  /// No description provided for @accounts_enterWeightAboveToSe.
  ///
  /// In en, this message translates to:
  /// **'Enter weight above to see value'**
  String get accounts_enterWeightAboveToSe;

  /// No description provided for @add_transaction_expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get add_transaction_expense;

  /// No description provided for @add_transaction_income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get add_transaction_income;

  /// No description provided for @add_transaction_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get add_transaction_account;

  /// No description provided for @add_transaction_category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get add_transaction_category;

  /// No description provided for @assets_assets.
  ///
  /// In en, this message translates to:
  /// **'Assets'**
  String get assets_assets;

  /// No description provided for @backup_restoreBackup.
  ///
  /// In en, this message translates to:
  /// **'Restore Backup?'**
  String get backup_restoreBackup;

  /// No description provided for @backup_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get backup_cancel;

  /// No description provided for @backup_replaceData.
  ///
  /// In en, this message translates to:
  /// **'Replace Data'**
  String get backup_replaceData;

  /// No description provided for @backup_backupRestore.
  ///
  /// In en, this message translates to:
  /// **'Backup & Restore'**
  String get backup_backupRestore;

  /// No description provided for @backup_everythingAlways.
  ///
  /// In en, this message translates to:
  /// **'Everything, always'**
  String get backup_everythingAlways;

  /// No description provided for @backup_createBackup.
  ///
  /// In en, this message translates to:
  /// **'Create Backup'**
  String get backup_createBackup;

  /// No description provided for @backup_saveAsJson.
  ///
  /// In en, this message translates to:
  /// **'Save as JSON'**
  String get backup_saveAsJson;

  /// No description provided for @backup_exportsAllAppDataToA.
  ///
  /// In en, this message translates to:
  /// **'Exports ALL app data to a portable file'**
  String get backup_exportsAllAppDataToA;

  /// No description provided for @backup_restoreBackup_.
  ///
  /// In en, this message translates to:
  /// **'Restore Backup'**
  String get backup_restoreBackup_;

  /// No description provided for @backup_loadFromJson.
  ///
  /// In en, this message translates to:
  /// **'Load from JSON'**
  String get backup_loadFromJson;

  /// No description provided for @backup_picksABackupFileAndR.
  ///
  /// In en, this message translates to:
  /// **'Picks a backup file and restores it'**
  String get backup_picksABackupFileAndR;

  /// No description provided for @backup_thisOverwritesAllCur.
  ///
  /// In en, this message translates to:
  /// **'This overwrites ALL current data.'**
  String get backup_thisOverwritesAllCur;

  /// No description provided for @budget_budgets.
  ///
  /// In en, this message translates to:
  /// **'Budgets'**
  String get budget_budgets;

  /// No description provided for @budget_empty.
  ///
  /// In en, this message translates to:
  /// **' · '**
  String get budget_empty;

  /// No description provided for @budget_overBudget.
  ///
  /// In en, this message translates to:
  /// **'Over budget'**
  String get budget_overBudget;

  /// No description provided for @budget_thisCategoryAlreadyH.
  ///
  /// In en, this message translates to:
  /// **'This category already has a budget. Tap it to edit.'**
  String get budget_thisCategoryAlreadyH;

  /// No description provided for @budget_period.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get budget_period;

  /// No description provided for @budget_monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get budget_monthly;

  /// No description provided for @budget_weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get budget_weekly;

  /// No description provided for @budget_category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get budget_category;

  /// No description provided for @categories_categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories_categories;

  /// No description provided for @categories_expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get categories_expense;

  /// No description provided for @categories_income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get categories_income;

  /// No description provided for @categories_color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get categories_color;

  /// No description provided for @categories_icon.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get categories_icon;

  /// No description provided for @categories_autoBasedOnName.
  ///
  /// In en, this message translates to:
  /// **'Auto (based on name)'**
  String get categories_autoBasedOnName;

  /// No description provided for @categories_expenseCategories.
  ///
  /// In en, this message translates to:
  /// **'Expense Categories'**
  String get categories_expenseCategories;

  /// No description provided for @categories_incomeCategories.
  ///
  /// In en, this message translates to:
  /// **'Income Categories'**
  String get categories_incomeCategories;

  /// No description provided for @currency_converter_currencyConverter.
  ///
  /// In en, this message translates to:
  /// **'Currency Converter'**
  String get currency_converter_currencyConverter;

  /// No description provided for @currency_converter_amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get currency_converter_amount;

  /// No description provided for @currency_converter_convertedTo.
  ///
  /// In en, this message translates to:
  /// **'Converted to'**
  String get currency_converter_convertedTo;

  /// No description provided for @export_exportTransactions.
  ///
  /// In en, this message translates to:
  /// **'Export Transactions'**
  String get export_exportTransactions;

  /// No description provided for @export_dateRange.
  ///
  /// In en, this message translates to:
  /// **'Date Range'**
  String get export_dateRange;

  /// No description provided for @export_formatExcelXlsx.
  ///
  /// In en, this message translates to:
  /// **'Format: Excel (.xlsx)'**
  String get export_formatExcelXlsx;

  /// No description provided for @export_exportAsPdf.
  ///
  /// In en, this message translates to:
  /// **'Export as PDF Report'**
  String get export_exportAsPdf;

  /// No description provided for @export_formatPdf.
  ///
  /// In en, this message translates to:
  /// **'Format: PDF Financial Report (.pdf)'**
  String get export_formatPdf;

  /// No description provided for @export_pdfGenerating.
  ///
  /// In en, this message translates to:
  /// **'Generating PDF...'**
  String get export_pdfGenerating;

  /// No description provided for @export_pdfTitle.
  ///
  /// In en, this message translates to:
  /// **'Financial Report'**
  String get export_pdfTitle;

  /// No description provided for @export_pdfSummary.
  ///
  /// In en, this message translates to:
  /// **'Executive Summary'**
  String get export_pdfSummary;

  /// No description provided for @export_pdfInflow.
  ///
  /// In en, this message translates to:
  /// **'Total Inflow'**
  String get export_pdfInflow;

  /// No description provided for @export_pdfOutflow.
  ///
  /// In en, this message translates to:
  /// **'Total Outflow'**
  String get export_pdfOutflow;

  /// No description provided for @export_pdfNet.
  ///
  /// In en, this message translates to:
  /// **'Net Savings'**
  String get export_pdfNet;

  /// No description provided for @export_pdfSavingsRate.
  ///
  /// In en, this message translates to:
  /// **'Savings Rate'**
  String get export_pdfSavingsRate;

  /// No description provided for @export_pdfCategoryBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Category Breakdown'**
  String get export_pdfCategoryBreakdown;

  /// No description provided for @export_pdfTransactions.
  ///
  /// In en, this message translates to:
  /// **'Itemized Transactions'**
  String get export_pdfTransactions;

  /// No description provided for @export_pdfNetWorthBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Assets & Liabilities'**
  String get export_pdfNetWorthBreakdown;

  /// No description provided for @export_pdfShare.
  ///
  /// In en, this message translates to:
  /// **'Share Report'**
  String get export_pdfShare;

  /// No description provided for @export_pdfPrint.
  ///
  /// In en, this message translates to:
  /// **'Print / Preview'**
  String get export_pdfPrint;

  /// No description provided for @export_pdfGeneratedBy.
  ///
  /// In en, this message translates to:
  /// **'Generated by Expensy • Private & Offline'**
  String get export_pdfGeneratedBy;

  /// No description provided for @home_totalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get home_totalBalance;

  /// No description provided for @home_accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get home_accounts;

  /// No description provided for @home_recentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get home_recentTransactions;

  /// No description provided for @home_noTransactionsYet.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get home_noTransactionsYet;

  /// No description provided for @home_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get home_add;

  /// No description provided for @home_goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get home_goodMorning;

  /// No description provided for @home_goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get home_goodAfternoon;

  /// No description provided for @home_goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get home_goodEvening;

  /// No description provided for @home_transferAction.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get home_transferAction;

  /// No description provided for @home_insightsAction.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get home_insightsAction;

  /// No description provided for @home_calendarAction.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get home_calendarAction;

  /// No description provided for @home_forecastAction.
  ///
  /// In en, this message translates to:
  /// **'Forecast'**
  String get home_forecastAction;

  /// No description provided for @home_manage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get home_manage;

  /// No description provided for @home_seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get home_seeAll;

  /// No description provided for @home_addAccount.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get home_addAccount;

  /// No description provided for @home_monthlyOverview.
  ///
  /// In en, this message translates to:
  /// **'Monthly Overview'**
  String get home_monthlyOverview;

  /// No description provided for @home_savingsRate.
  ///
  /// In en, this message translates to:
  /// **'Savings Rate'**
  String get home_savingsRate;

  /// No description provided for @insights_insights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insights_insights;

  /// No description provided for @lended_person_deletePerson.
  ///
  /// In en, this message translates to:
  /// **'Delete person'**
  String get lended_person_deletePerson;

  /// No description provided for @lended_person_editPerson.
  ///
  /// In en, this message translates to:
  /// **'Edit Person'**
  String get lended_person_editPerson;

  /// No description provided for @lended_person_color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get lended_person_color;

  /// No description provided for @lended_person_saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get lended_person_saveChanges;

  /// No description provided for @lended_person_settled.
  ///
  /// In en, this message translates to:
  /// **'SETTLED'**
  String get lended_person_settled;

  /// No description provided for @lended_person_settle.
  ///
  /// In en, this message translates to:
  /// **'Settle'**
  String get lended_person_settle;

  /// No description provided for @lended_person_setADueDateFirstToEn.
  ///
  /// In en, this message translates to:
  /// **'Set a due date first to enable reminders.'**
  String get lended_person_setADueDateFirstToEn;

  /// No description provided for @lended_person_iLent.
  ///
  /// In en, this message translates to:
  /// **'I Lent'**
  String get lended_person_iLent;

  /// No description provided for @lended_person_iBorrowed.
  ///
  /// In en, this message translates to:
  /// **'I Borrowed'**
  String get lended_person_iBorrowed;

  /// No description provided for @lended_person_accountOptional.
  ///
  /// In en, this message translates to:
  /// **'Account (optional)'**
  String get lended_person_accountOptional;

  /// No description provided for @lended_person_dueDateReminder.
  ///
  /// In en, this message translates to:
  /// **'Due Date Reminder'**
  String get lended_person_dueDateReminder;

  /// No description provided for @lended_person_remindMeAt.
  ///
  /// In en, this message translates to:
  /// **'Remind me at'**
  String get lended_person_remindMeAt;

  /// No description provided for @lended_person_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get lended_person_active;

  /// No description provided for @lended_person_settled_.
  ///
  /// In en, this message translates to:
  /// **'Settled'**
  String get lended_person_settled_;

  /// No description provided for @lended_lentMoney.
  ///
  /// In en, this message translates to:
  /// **'Lent Money'**
  String get lended_lentMoney;

  /// No description provided for @lended_overdue.
  ///
  /// In en, this message translates to:
  /// **'OVERDUE'**
  String get lended_overdue;

  /// No description provided for @lended_color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get lended_color;

  /// No description provided for @more_more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more_more;

  /// No description provided for @onboarding_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get onboarding_back;

  /// No description provided for @onboarding_welcomeToExpensy.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Expensy!'**
  String get onboarding_welcomeToExpensy;

  /// No description provided for @onboarding_restoreABackup.
  ///
  /// In en, this message translates to:
  /// **'Restore a Backup'**
  String get onboarding_restoreABackup;

  /// No description provided for @onboarding_loadAPreviouslySaved.
  ///
  /// In en, this message translates to:
  /// **'Load a previously saved Expensy JSON file'**
  String get onboarding_loadAPreviouslySaved;

  /// No description provided for @onboarding_or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get onboarding_or;

  /// No description provided for @onboarding_startFresh.
  ///
  /// In en, this message translates to:
  /// **'Start Fresh'**
  String get onboarding_startFresh;

  /// No description provided for @onboarding_firstWhatShouldWeCal.
  ///
  /// In en, this message translates to:
  /// **'First, what should we call you?'**
  String get onboarding_firstWhatShouldWeCal;

  /// No description provided for @onboarding_defaultCurrency.
  ///
  /// In en, this message translates to:
  /// **'Default Currency'**
  String get onboarding_defaultCurrency;

  /// No description provided for @onboarding_thisWillBeUsedAcross.
  ///
  /// In en, this message translates to:
  /// **'This will be used across the app.\\nYou can change it later in Settings.'**
  String get onboarding_thisWillBeUsedAcross;

  /// No description provided for @onboarding_searchAllCurrencies.
  ///
  /// In en, this message translates to:
  /// **'Search all currencies'**
  String get onboarding_searchAllCurrencies;

  /// No description provided for @onboarding_yourFirstAccount.
  ///
  /// In en, this message translates to:
  /// **'Your First Account'**
  String get onboarding_yourFirstAccount;

  /// No description provided for @onboarding_setUpYourMainAccount.
  ///
  /// In en, this message translates to:
  /// **'Set up your main account to start tracking.'**
  String get onboarding_setUpYourMainAccount;

  /// No description provided for @onboarding_accountType.
  ///
  /// In en, this message translates to:
  /// **'Account Type'**
  String get onboarding_accountType;

  /// No description provided for @onboarding_currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get onboarding_currency;

  /// No description provided for @onboarding_color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get onboarding_color;

  /// No description provided for @recurring_recurring.
  ///
  /// In en, this message translates to:
  /// **'Recurring'**
  String get recurring_recurring;

  /// No description provided for @recurring_income.
  ///
  /// In en, this message translates to:
  /// **'INCOME'**
  String get recurring_income;

  /// No description provided for @recurring_2D.
  ///
  /// In en, this message translates to:
  /// **'−2d'**
  String get recurring_2D;

  /// No description provided for @recurring_skipNextPayment.
  ///
  /// In en, this message translates to:
  /// **'Skip Next Payment?'**
  String get recurring_skipNextPayment;

  /// No description provided for @recurring_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get recurring_cancel;

  /// No description provided for @recurring_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get recurring_skip;

  /// No description provided for @recurring_noHistoryYet.
  ///
  /// In en, this message translates to:
  /// **'No history yet'**
  String get recurring_noHistoryYet;

  /// No description provided for @recurring_expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get recurring_expense;

  /// No description provided for @recurring_income_.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get recurring_income_;

  /// No description provided for @recurring_every.
  ///
  /// In en, this message translates to:
  /// **'Every '**
  String get recurring_every;

  /// No description provided for @recurring_days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get recurring_days;

  /// No description provided for @recurring_weeks.
  ///
  /// In en, this message translates to:
  /// **'Weeks'**
  String get recurring_weeks;

  /// No description provided for @recurring_months.
  ///
  /// In en, this message translates to:
  /// **'Months'**
  String get recurring_months;

  /// No description provided for @recurring_years.
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get recurring_years;

  /// No description provided for @recurring_payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get recurring_payments;

  /// No description provided for @recurring_totalCost.
  ///
  /// In en, this message translates to:
  /// **'Total Cost'**
  String get recurring_totalCost;

  /// No description provided for @recurring_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get recurring_account;

  /// No description provided for @recurring_category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get recurring_category;

  /// No description provided for @recurring_paymentReminder.
  ///
  /// In en, this message translates to:
  /// **'Payment Reminder'**
  String get recurring_paymentReminder;

  /// No description provided for @recurring_notificationWillFire.
  ///
  /// In en, this message translates to:
  /// **'Notification will fire on the next due date at this time.'**
  String get recurring_notificationWillFire;

  /// No description provided for @recurring_remind2DaysBefore.
  ///
  /// In en, this message translates to:
  /// **'Remind 2 days before'**
  String get recurring_remind2DaysBefore;

  /// No description provided for @statistics_statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics_statistics;

  /// No description provided for @statistics_expensesByCategory.
  ///
  /// In en, this message translates to:
  /// **'Expenses by Category'**
  String get statistics_expensesByCategory;

  /// No description provided for @transactions_transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions_transactions;

  /// No description provided for @transactions_settled.
  ///
  /// In en, this message translates to:
  /// **'Settled'**
  String get transactions_settled;

  /// No description provided for @transfer_transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer_transfer;

  /// No description provided for @transfer_from.
  ///
  /// In en, this message translates to:
  /// **'FROM'**
  String get transfer_from;

  /// No description provided for @transfer_to.
  ///
  /// In en, this message translates to:
  /// **'TO'**
  String get transfer_to;

  /// No description provided for @transfer_enterAnAmountToSeeTh.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount to see the conversion'**
  String get transfer_enterAnAmountToSeeTh;

  /// No description provided for @wishlist_wishlist.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get wishlist_wishlist;

  /// No description provided for @wishlist_priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get wishlist_priority;

  /// No description provided for @shared_widgets_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete?'**
  String get shared_widgets_delete;

  /// No description provided for @shared_widgets_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get shared_widgets_cancel;

  /// No description provided for @shared_widgets_delete_.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get shared_widgets_delete_;

  /// No description provided for @shared_widgets_none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get shared_widgets_none;

  /// No description provided for @shared_widgets_selectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Select Currency'**
  String get shared_widgets_selectCurrency;

  /// No description provided for @main_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get main_home;

  /// No description provided for @main_transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get main_transactions;

  /// No description provided for @main_recurring.
  ///
  /// In en, this message translates to:
  /// **'Recurring'**
  String get main_recurring;

  /// No description provided for @main_accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get main_accounts;

  /// No description provided for @main_budgets.
  ///
  /// In en, this message translates to:
  /// **'Budgets'**
  String get main_budgets;

  /// No description provided for @main_more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get main_more;

  /// No description provided for @onboarding_chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get onboarding_chooseLanguage;

  /// No description provided for @error_required.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get error_required;

  /// No description provided for @recurring_subscriptions.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions ({count})'**
  String recurring_subscriptions(Object count);

  /// No description provided for @recurring_installments.
  ///
  /// In en, this message translates to:
  /// **'Installments ({count})'**
  String recurring_installments(Object count);

  /// No description provided for @recurring_recurringType.
  ///
  /// In en, this message translates to:
  /// **'Recurring Type'**
  String get recurring_recurringType;

  /// No description provided for @recurring_subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get recurring_subscription;

  /// No description provided for @recurring_installment.
  ///
  /// In en, this message translates to:
  /// **'Installment'**
  String get recurring_installment;

  /// No description provided for @recurring_installmentsRequireEndDate.
  ///
  /// In en, this message translates to:
  /// **'Installments must have a final payment date.'**
  String get recurring_installmentsRequireEndDate;

  /// No description provided for @backup_importFromOtherApps.
  ///
  /// In en, this message translates to:
  /// **'Import from Other Apps'**
  String get backup_importFromOtherApps;

  /// No description provided for @backup_importDescription.
  ///
  /// In en, this message translates to:
  /// **'Import data from supported apps'**
  String get backup_importDescription;

  /// No description provided for @backup_importFromGreenStash.
  ///
  /// In en, this message translates to:
  /// **'Import from GreenStash (.json)'**
  String get backup_importFromGreenStash;

  /// No description provided for @backup_automaticBackup.
  ///
  /// In en, this message translates to:
  /// **'Automatic Backup'**
  String get backup_automaticBackup;

  /// No description provided for @backup_dailyAutoBackup.
  ///
  /// In en, this message translates to:
  /// **'Daily Auto Backup'**
  String get backup_dailyAutoBackup;

  /// No description provided for @backup_runsDailyAt.
  ///
  /// In en, this message translates to:
  /// **'Runs daily at {time}'**
  String backup_runsDailyAt(String time);

  /// No description provided for @backup_lastBackup.
  ///
  /// In en, this message translates to:
  /// **'Last backup: {time}'**
  String backup_lastBackup(String time);

  /// No description provided for @backup_savingTo.
  ///
  /// In en, this message translates to:
  /// **'Saving to: {path}'**
  String backup_savingTo(String path);

  /// No description provided for @backup_changeTime.
  ///
  /// In en, this message translates to:
  /// **'Change Time'**
  String get backup_changeTime;

  /// No description provided for @backup_changeFolder.
  ///
  /// In en, this message translates to:
  /// **'Change Folder'**
  String get backup_changeFolder;

  /// No description provided for @budget_budgetsAndGoals.
  ///
  /// In en, this message translates to:
  /// **'Budgets & Goals'**
  String get budget_budgetsAndGoals;

  /// No description provided for @onboarding_restoreGreenStash.
  ///
  /// In en, this message translates to:
  /// **'Restore from GreenStash (.json)'**
  String get onboarding_restoreGreenStash;

  /// No description provided for @savings_goalNotFound.
  ///
  /// In en, this message translates to:
  /// **'Goal not found'**
  String get savings_goalNotFound;

  /// No description provided for @savings_savedSoFar.
  ///
  /// In en, this message translates to:
  /// **'Saved so far'**
  String get savings_savedSoFar;

  /// No description provided for @savings_target.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get savings_target;

  /// No description provided for @savings_targetDate.
  ///
  /// In en, this message translates to:
  /// **'Target Date: {date}'**
  String savings_targetDate(String date);

  /// No description provided for @savings_contribute.
  ///
  /// In en, this message translates to:
  /// **'Contribute'**
  String get savings_contribute;

  /// No description provided for @savings_withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get savings_withdraw;

  /// No description provided for @savings_noAccounts.
  ///
  /// In en, this message translates to:
  /// **'No accounts available. Please add an account first.'**
  String get savings_noAccounts;

  /// No description provided for @settings_budgetAlerts.
  ///
  /// In en, this message translates to:
  /// **'Budget Alerts'**
  String get settings_budgetAlerts;

  /// No description provided for @settings_budgetAlertsSub.
  ///
  /// In en, this message translates to:
  /// **'Notify when a budget or goal is reached'**
  String get settings_budgetAlertsSub;

  /// No description provided for @settings_dailyReminder.
  ///
  /// In en, this message translates to:
  /// **'Daily Reminder'**
  String get settings_dailyReminder;

  /// No description provided for @settings_dailyReminderSub.
  ///
  /// In en, this message translates to:
  /// **'Remind to log transactions daily'**
  String get settings_dailyReminderSub;

  /// No description provided for @settings_reminderTime.
  ///
  /// In en, this message translates to:
  /// **'Reminder Time'**
  String get settings_reminderTime;

  /// No description provided for @settings_hapticFeedback.
  ///
  /// In en, this message translates to:
  /// **'Haptic Feedback'**
  String get settings_hapticFeedback;

  /// No description provided for @settings_hapticFeedbackSub.
  ///
  /// In en, this message translates to:
  /// **'Vibrate on interactions'**
  String get settings_hapticFeedbackSub;

  /// No description provided for @savings_saveGoal.
  ///
  /// In en, this message translates to:
  /// **'Save Goal'**
  String get savings_saveGoal;

  /// No description provided for @more_loans.
  ///
  /// In en, this message translates to:
  /// **'Loans'**
  String get more_loans;

  /// No description provided for @more_loansSub.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 active loan} other{{count} active loans}}'**
  String more_loansSub(num count);

  /// No description provided for @loans_title.
  ///
  /// In en, this message translates to:
  /// **'Loans'**
  String get loans_title;

  /// No description provided for @loans_addLoan.
  ///
  /// In en, this message translates to:
  /// **'Add Loan'**
  String get loans_addLoan;

  /// No description provided for @loans_editLoan.
  ///
  /// In en, this message translates to:
  /// **'Edit Loan'**
  String get loans_editLoan;

  /// No description provided for @loans_loanName.
  ///
  /// In en, this message translates to:
  /// **'Loan Name'**
  String get loans_loanName;

  /// No description provided for @loans_amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get loans_amount;

  /// No description provided for @loans_startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get loans_startDate;

  /// No description provided for @loans_endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get loans_endDate;

  /// No description provided for @loans_interestRateOptional.
  ///
  /// In en, this message translates to:
  /// **'Interest Rate (Optional)'**
  String get loans_interestRateOptional;

  /// No description provided for @loans_account.
  ///
  /// In en, this message translates to:
  /// **'Linked Account'**
  String get loans_account;

  /// No description provided for @loans_monthlyPayment.
  ///
  /// In en, this message translates to:
  /// **'Monthly Payment'**
  String get loans_monthlyPayment;

  /// No description provided for @loans_totalPayable.
  ///
  /// In en, this message translates to:
  /// **'Total Payable'**
  String get loans_totalPayable;

  /// No description provided for @loans_remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get loans_remaining;

  /// No description provided for @loans_paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get loans_paid;

  /// No description provided for @loans_logPayment.
  ///
  /// In en, this message translates to:
  /// **'Log Payment'**
  String get loans_logPayment;

  /// No description provided for @loans_paymentReminder.
  ///
  /// In en, this message translates to:
  /// **'Payment Reminder'**
  String get loans_paymentReminder;

  /// No description provided for @loans_reminderDay.
  ///
  /// In en, this message translates to:
  /// **'Reminder Day'**
  String get loans_reminderDay;

  /// No description provided for @loans_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get loans_notes;

  /// No description provided for @loans_saveLoan.
  ///
  /// In en, this message translates to:
  /// **'Save Loan'**
  String get loans_saveLoan;

  /// No description provided for @loans_deleteLoan.
  ///
  /// In en, this message translates to:
  /// **'Delete Loan'**
  String get loans_deleteLoan;

  /// No description provided for @loans_settled.
  ///
  /// In en, this message translates to:
  /// **'Settled'**
  String get loans_settled;

  /// No description provided for @loans_durationMonths.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 month} other{{count} months}}'**
  String loans_durationMonths(num count);

  /// No description provided for @loans_paymentHistory.
  ///
  /// In en, this message translates to:
  /// **'Payment History'**
  String get loans_paymentHistory;

  /// No description provided for @loans_noPayments.
  ///
  /// In en, this message translates to:
  /// **'No payments logged yet'**
  String get loans_noPayments;

  /// No description provided for @loans_outstandingDebt.
  ///
  /// In en, this message translates to:
  /// **'Outstanding Debt'**
  String get loans_outstandingDebt;

  /// No description provided for @loans_monthlyObligation.
  ///
  /// In en, this message translates to:
  /// **'Monthly Obligation'**
  String get loans_monthlyObligation;

  /// No description provided for @insights_loans.
  ///
  /// In en, this message translates to:
  /// **'Loans'**
  String get insights_loans;

  /// No description provided for @backup_loans.
  ///
  /// In en, this message translates to:
  /// **'Loans'**
  String get backup_loans;

  /// No description provided for @backup_loanPayments.
  ///
  /// In en, this message translates to:
  /// **'Loan Payments'**
  String get backup_loanPayments;

  /// No description provided for @more_yearlyAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Yearly Analysis'**
  String get more_yearlyAnalysis;

  /// No description provided for @more_yearlyAnalysisSub.
  ///
  /// In en, this message translates to:
  /// **'Month-by-month cash flow forecast'**
  String get more_yearlyAnalysisSub;

  /// No description provided for @yearly_title.
  ///
  /// In en, this message translates to:
  /// **'Yearly Analysis'**
  String get yearly_title;

  /// No description provided for @yearly_recurringExp.
  ///
  /// In en, this message translates to:
  /// **'Recurring Expenses'**
  String get yearly_recurringExp;

  /// No description provided for @yearly_recurringInc.
  ///
  /// In en, this message translates to:
  /// **'Recurring Income'**
  String get yearly_recurringInc;

  /// No description provided for @yearly_loans.
  ///
  /// In en, this message translates to:
  /// **'Loan Payments'**
  String get yearly_loans;

  /// No description provided for @yearly_borrowed.
  ///
  /// In en, this message translates to:
  /// **'Borrowed Due'**
  String get yearly_borrowed;

  /// No description provided for @yearly_lentDue.
  ///
  /// In en, this message translates to:
  /// **'Lent Due Back'**
  String get yearly_lentDue;

  /// No description provided for @yearly_inflow.
  ///
  /// In en, this message translates to:
  /// **'Inflows'**
  String get yearly_inflow;

  /// No description provided for @yearly_outflow.
  ///
  /// In en, this message translates to:
  /// **'Outflows'**
  String get yearly_outflow;

  /// No description provided for @yearly_netFlow.
  ///
  /// In en, this message translates to:
  /// **'Net Flow'**
  String get yearly_netFlow;

  /// No description provided for @yearly_totalInflow.
  ///
  /// In en, this message translates to:
  /// **'Total Inflow'**
  String get yearly_totalInflow;

  /// No description provided for @yearly_totalOutflow.
  ///
  /// In en, this message translates to:
  /// **'Total Outflow'**
  String get yearly_totalOutflow;

  /// No description provided for @yearly_netCashFlow.
  ///
  /// In en, this message translates to:
  /// **'Net Cash Flow'**
  String get yearly_netCashFlow;

  /// No description provided for @yearly_noData.
  ///
  /// In en, this message translates to:
  /// **'No projected activity yet'**
  String get yearly_noData;

  /// No description provided for @yearly_noDataSub.
  ///
  /// In en, this message translates to:
  /// **'Add recurring payments, loans, or lent money with due dates to see a forecast'**
  String get yearly_noDataSub;

  /// No description provided for @budget_addBudget.
  ///
  /// In en, this message translates to:
  /// **'Add Budget'**
  String get budget_addBudget;

  /// No description provided for @budget_addGoal.
  ///
  /// In en, this message translates to:
  /// **'Add Savings Goal'**
  String get budget_addGoal;

  /// No description provided for @add_transaction_possibleDuplicate.
  ///
  /// In en, this message translates to:
  /// **'Possible duplicate'**
  String get add_transaction_possibleDuplicate;

  /// No description provided for @add_transaction_goBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get add_transaction_goBack;

  /// No description provided for @add_transaction_saveAnyway.
  ///
  /// In en, this message translates to:
  /// **'Save anyway'**
  String get add_transaction_saveAnyway;

  /// No description provided for @loans_confirmDeleteLoan.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this loan and all its payments?'**
  String get loans_confirmDeleteLoan;

  /// No description provided for @loans_deletePayment.
  ///
  /// In en, this message translates to:
  /// **'Delete Payment'**
  String get loans_deletePayment;

  /// No description provided for @loans_confirmDeletePayment.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this payment record?'**
  String get loans_confirmDeletePayment;

  /// No description provided for @split_transactions_title.
  ///
  /// In en, this message translates to:
  /// **'Split Categories'**
  String get split_transactions_title;

  /// No description provided for @split_transactions_badge.
  ///
  /// In en, this message translates to:
  /// **'Split'**
  String get split_transactions_badge;

  /// No description provided for @split_transactions_addSplit.
  ///
  /// In en, this message translates to:
  /// **'Add Split'**
  String get split_transactions_addSplit;

  /// No description provided for @split_transactions_removeSplit.
  ///
  /// In en, this message translates to:
  /// **'Remove Split'**
  String get split_transactions_removeSplit;

  /// No description provided for @split_transactions_allocated.
  ///
  /// In en, this message translates to:
  /// **'Allocated'**
  String get split_transactions_allocated;

  /// No description provided for @split_transactions_remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get split_transactions_remaining;

  /// No description provided for @split_transactions_fillRemaining.
  ///
  /// In en, this message translates to:
  /// **'Fill Remaining'**
  String get split_transactions_fillRemaining;

  /// No description provided for @split_transactions_breakdown.
  ///
  /// In en, this message translates to:
  /// **'Split Breakdown'**
  String get split_transactions_breakdown;

  /// No description provided for @split_transactions_mismatchError.
  ///
  /// In en, this message translates to:
  /// **'Split amounts must equal the total amount.'**
  String get split_transactions_mismatchError;

  /// No description provided for @netWorth_title.
  ///
  /// In en, this message translates to:
  /// **'Net Worth'**
  String get netWorth_title;

  /// No description provided for @netWorth_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Track total assets, liabilities & wealth over time'**
  String get netWorth_subtitle;

  /// No description provided for @netWorth_current.
  ///
  /// In en, this message translates to:
  /// **'Current Net Worth'**
  String get netWorth_current;

  /// No description provided for @netWorth_trend.
  ///
  /// In en, this message translates to:
  /// **'Net Worth Trend'**
  String get netWorth_trend;

  /// No description provided for @netWorth_totalAssets.
  ///
  /// In en, this message translates to:
  /// **'Total Assets'**
  String get netWorth_totalAssets;

  /// No description provided for @netWorth_totalLiabilities.
  ///
  /// In en, this message translates to:
  /// **'Total Liabilities'**
  String get netWorth_totalLiabilities;

  /// No description provided for @netWorth_liquidCash.
  ///
  /// In en, this message translates to:
  /// **'Cash & Bank Accounts'**
  String get netWorth_liquidCash;

  /// No description provided for @netWorth_goldValuation.
  ///
  /// In en, this message translates to:
  /// **'Physical Gold'**
  String get netWorth_goldValuation;

  /// No description provided for @netWorth_fixedAssets.
  ///
  /// In en, this message translates to:
  /// **'Property & Investments'**
  String get netWorth_fixedAssets;

  /// No description provided for @netWorth_moneyLent.
  ///
  /// In en, this message translates to:
  /// **'Money Lent (Receivables)'**
  String get netWorth_moneyLent;

  /// No description provided for @netWorth_creditDebt.
  ///
  /// In en, this message translates to:
  /// **'Credit Cards & Overdraft'**
  String get netWorth_creditDebt;

  /// No description provided for @netWorth_loanDebt.
  ///
  /// In en, this message translates to:
  /// **'Loans Payable'**
  String get netWorth_loanDebt;

  /// No description provided for @netWorth_moneyBorrowed.
  ///
  /// In en, this message translates to:
  /// **'Money Borrowed (Payables)'**
  String get netWorth_moneyBorrowed;

  /// No description provided for @netWorth_assetBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Assets Breakdown'**
  String get netWorth_assetBreakdown;

  /// No description provided for @netWorth_liabilityBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Liabilities Breakdown'**
  String get netWorth_liabilityBreakdown;

  /// No description provided for @netWorth_noHistory.
  ///
  /// In en, this message translates to:
  /// **'Net worth history will build up automatically over time as daily snapshots are recorded.'**
  String get netWorth_noHistory;

  /// No description provided for @netWorth_debtRatio.
  ///
  /// In en, this message translates to:
  /// **'Debt Ratio'**
  String get netWorth_debtRatio;

  /// No description provided for @netWorth_quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get netWorth_quickActions;

  /// No description provided for @netWorth_history.
  ///
  /// In en, this message translates to:
  /// **'Snapshot History'**
  String get netWorth_history;

  /// No description provided for @creditCard_utilization.
  ///
  /// In en, this message translates to:
  /// **'Credit Utilization'**
  String get creditCard_utilization;

  /// No description provided for @creditCard_availableCredit.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get creditCard_availableCredit;

  /// No description provided for @creditCard_limit.
  ///
  /// In en, this message translates to:
  /// **'Limit'**
  String get creditCard_limit;

  /// No description provided for @creditCard_statementBalance.
  ///
  /// In en, this message translates to:
  /// **'Statement Balance'**
  String get creditCard_statementBalance;

  /// No description provided for @creditCard_unbilledBalance.
  ///
  /// In en, this message translates to:
  /// **'Unbilled'**
  String get creditCard_unbilledBalance;

  /// No description provided for @creditCard_payBill.
  ///
  /// In en, this message translates to:
  /// **'Pay Card Bill'**
  String get creditCard_payBill;

  /// No description provided for @creditCard_allCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'All caught up! No balance due'**
  String get creditCard_allCaughtUp;

  /// No description provided for @creditCard_payBillTitle.
  ///
  /// In en, this message translates to:
  /// **'Pay Credit Card Bill'**
  String get creditCard_payBillTitle;

  /// No description provided for @creditCard_payFromAccount.
  ///
  /// In en, this message translates to:
  /// **'Pay From Account'**
  String get creditCard_payFromAccount;

  /// No description provided for @creditCard_paymentAmount.
  ///
  /// In en, this message translates to:
  /// **'Payment Amount'**
  String get creditCard_paymentAmount;

  /// No description provided for @creditCard_fullStatement.
  ///
  /// In en, this message translates to:
  /// **'Statement Balance'**
  String get creditCard_fullStatement;

  /// No description provided for @creditCard_fullBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get creditCard_fullBalance;

  /// No description provided for @creditCard_minPayment.
  ///
  /// In en, this message translates to:
  /// **'Minimum Payment'**
  String get creditCard_minPayment;

  /// No description provided for @creditCard_customAmount.
  ///
  /// In en, this message translates to:
  /// **'Custom Amount'**
  String get creditCard_customAmount;

  /// No description provided for @creditCard_paymentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Paid {amount} towards {cardName}'**
  String creditCard_paymentSuccess(String amount, String cardName);

  /// No description provided for @creditCard_insufficientFunds.
  ///
  /// In en, this message translates to:
  /// **'Amount exceeds available balance'**
  String get creditCard_insufficientFunds;

  /// No description provided for @creditCard_invalidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid payment amount'**
  String get creditCard_invalidAmount;

  /// No description provided for @onboarding_skipForNow.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get onboarding_skipForNow;

  /// No description provided for @onboarding_addCard.
  ///
  /// In en, this message translates to:
  /// **'Add a Card'**
  String get onboarding_addCard;

  /// No description provided for @onboarding_skipCardDesc.
  ///
  /// In en, this message translates to:
  /// **'You can skip this if you don\'t want to add a card right now.'**
  String get onboarding_skipCardDesc;

  /// No description provided for @onboarding_cardNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Card Name (e.g. Visa Platinum)'**
  String get onboarding_cardNameLabel;

  /// No description provided for @onboarding_debitCard.
  ///
  /// In en, this message translates to:
  /// **'Debit Card'**
  String get onboarding_debitCard;

  /// No description provided for @onboarding_creditLimit.
  ///
  /// In en, this message translates to:
  /// **'Credit Limit'**
  String get onboarding_creditLimit;

  /// No description provided for @onboarding_amountUsed.
  ///
  /// In en, this message translates to:
  /// **'Amount Used'**
  String get onboarding_amountUsed;

  /// No description provided for @accounts_cardHolderOptional.
  ///
  /// In en, this message translates to:
  /// **'Card Holder Name (Optional)'**
  String get accounts_cardHolderOptional;

  /// No description provided for @accounts_last4Digits.
  ///
  /// In en, this message translates to:
  /// **'Last 4 Digits'**
  String get accounts_last4Digits;

  /// No description provided for @accounts_expiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date (MM/YY)'**
  String get accounts_expiryDate;

  /// No description provided for @accounts_creditLimitOptional.
  ///
  /// In en, this message translates to:
  /// **'Credit Limit (Optional)'**
  String get accounts_creditLimitOptional;

  /// No description provided for @accounts_minPaymentOptional.
  ///
  /// In en, this message translates to:
  /// **'Min. Payment (Optional)'**
  String get accounts_minPaymentOptional;

  /// No description provided for @accounts_statementDayOptional.
  ///
  /// In en, this message translates to:
  /// **'Statement Day (Optional)'**
  String get accounts_statementDayOptional;

  /// No description provided for @accounts_statementDayExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. 20'**
  String get accounts_statementDayExample;

  /// No description provided for @accounts_dueDayOptional.
  ///
  /// In en, this message translates to:
  /// **'Due Day (Optional)'**
  String get accounts_dueDayOptional;

  /// No description provided for @accounts_dueDayExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. 10'**
  String get accounts_dueDayExample;

  /// No description provided for @accounts_linkedAccountOptional.
  ///
  /// In en, this message translates to:
  /// **'Linked Bank Account (Optional)'**
  String get accounts_linkedAccountOptional;

  /// No description provided for @accounts_excludeCardBalance.
  ///
  /// In en, this message translates to:
  /// **'Exclude card balance from account balance'**
  String get accounts_excludeCardBalance;

  /// No description provided for @accounts_excludeCardBalanceDesc.
  ///
  /// In en, this message translates to:
  /// **'This card\'s balance will not be added to its linked bank account.'**
  String get accounts_excludeCardBalanceDesc;

  /// No description provided for @accounts_cardHolderHeader.
  ///
  /// In en, this message translates to:
  /// **'CARD HOLDER'**
  String get accounts_cardHolderHeader;

  /// No description provided for @accounts_expHeader.
  ///
  /// In en, this message translates to:
  /// **'EXP'**
  String get accounts_expHeader;

  /// No description provided for @accounts_notifyOnDueDate.
  ///
  /// In en, this message translates to:
  /// **'You\'ll be notified on the due date'**
  String get accounts_notifyOnDueDate;

  /// No description provided for @accounts_notifyWhenDue.
  ///
  /// In en, this message translates to:
  /// **'Get notified when payment is due'**
  String get accounts_notifyWhenDue;

  /// No description provided for @accounts_remind2DaysBeforeDesc.
  ///
  /// In en, this message translates to:
  /// **'Get an advance heads-up 2 days before due date'**
  String get accounts_remind2DaysBeforeDesc;

  /// No description provided for @accounts_targetSaved.
  ///
  /// In en, this message translates to:
  /// **'Target / Saved'**
  String get accounts_targetSaved;

  /// No description provided for @transactions_selectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 selected} other{{count} selected}}'**
  String transactions_selectedCount(num count);

  /// No description provided for @transactions_changeCategory.
  ///
  /// In en, this message translates to:
  /// **'Change Category'**
  String get transactions_changeCategory;

  /// No description provided for @transactions_deleteSelected.
  ///
  /// In en, this message translates to:
  /// **'Delete Selected'**
  String get transactions_deleteSelected;

  /// No description provided for @transactions_advancedFilters.
  ///
  /// In en, this message translates to:
  /// **'Advanced Filters'**
  String get transactions_advancedFilters;

  /// No description provided for @transactions_clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get transactions_clearAll;

  /// No description provided for @transactions_amountRange.
  ///
  /// In en, this message translates to:
  /// **'Amount Range'**
  String get transactions_amountRange;

  /// No description provided for @transactions_minAmount.
  ///
  /// In en, this message translates to:
  /// **'Min Amount'**
  String get transactions_minAmount;

  /// No description provided for @transactions_maxAmount.
  ///
  /// In en, this message translates to:
  /// **'Max Amount'**
  String get transactions_maxAmount;

  /// No description provided for @transactions_applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get transactions_applyFilters;

  /// No description provided for @presets_new.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get presets_new;

  /// No description provided for @presets_presetName.
  ///
  /// In en, this message translates to:
  /// **'Preset Name (e.g. Morning Coffee)'**
  String get presets_presetName;

  /// No description provided for @presets_defaultAmount.
  ///
  /// In en, this message translates to:
  /// **'Default Amount'**
  String get presets_defaultAmount;

  /// No description provided for @savings_goalName.
  ///
  /// In en, this message translates to:
  /// **'Goal Name'**
  String get savings_goalName;

  /// No description provided for @savings_goalNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. New Car, Vacation'**
  String get savings_goalNameHint;

  /// No description provided for @savings_targetAmount.
  ///
  /// In en, this message translates to:
  /// **'Target Amount'**
  String get savings_targetAmount;

  /// No description provided for @savings_targetDateOptional.
  ///
  /// In en, this message translates to:
  /// **'Target Date (Optional)'**
  String get savings_targetDateOptional;

  /// No description provided for @savings_selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get savings_selectDate;

  /// No description provided for @savings_amountRequired.
  ///
  /// In en, this message translates to:
  /// **'Amount is required'**
  String get savings_amountRequired;

  /// No description provided for @savings_noteOptional.
  ///
  /// In en, this message translates to:
  /// **'Note (Optional)'**
  String get savings_noteOptional;

  /// No description provided for @loans_skipInstallment.
  ///
  /// In en, this message translates to:
  /// **'Skip the next loan installment?'**
  String get loans_skipInstallment;

  /// No description provided for @recurring_confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this recurring payment?'**
  String get recurring_confirmDelete;

  /// No description provided for @export_formatExcelOption.
  ///
  /// In en, this message translates to:
  /// **'Excel (.xlsx)'**
  String get export_formatExcelOption;

  /// No description provided for @export_formatPdfOption.
  ///
  /// In en, this message translates to:
  /// **'PDF Report'**
  String get export_formatPdfOption;

  /// No description provided for @export_pdfNoTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions recorded within this date range.'**
  String get export_pdfNoTransactions;

  /// No description provided for @savings_saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get savings_saved;

  /// No description provided for @export_pdfDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get export_pdfDate;

  /// No description provided for @export_pdfDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get export_pdfDescription;

  /// No description provided for @accounts_noCardsYet.
  ///
  /// In en, this message translates to:
  /// **'No Cards'**
  String get accounts_noCardsYet;

  /// No description provided for @accounts_tapToAddCard.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add your first card'**
  String get accounts_tapToAddCard;

  /// No description provided for @savings_noGoalsYet.
  ///
  /// In en, this message translates to:
  /// **'No Savings Goals'**
  String get savings_noGoalsYet;

  /// No description provided for @savings_tapToAddGoal.
  ///
  /// In en, this message translates to:
  /// **'Tap + to set a new goal'**
  String get savings_tapToAddGoal;

  /// No description provided for @netWorth_recordSnapshot.
  ///
  /// In en, this message translates to:
  /// **'Record Snapshot'**
  String get netWorth_recordSnapshot;

  /// No description provided for @netWorth_snapshotRecorded.
  ///
  /// In en, this message translates to:
  /// **'Snapshot recorded'**
  String get netWorth_snapshotRecorded;

  /// No description provided for @savings_noContributionsYet.
  ///
  /// In en, this message translates to:
  /// **'No contributions yet'**
  String get savings_noContributionsYet;

  /// No description provided for @creditCard_closesStatementBillingCycle.
  ///
  /// In en, this message translates to:
  /// **'Closes current statement billing cycle'**
  String get creditCard_closesStatementBillingCycle;

  /// No description provided for @creditCard_clearsTotalDebt.
  ///
  /// In en, this message translates to:
  /// **'Clears total card debt in full'**
  String get creditCard_clearsTotalDebt;

  /// No description provided for @creditCard_requiredMinPayment.
  ///
  /// In en, this message translates to:
  /// **'Required minimum payment'**
  String get creditCard_requiredMinPayment;

  /// No description provided for @creditCard_specifyCustomAmount.
  ///
  /// In en, this message translates to:
  /// **'Specify custom payment amount'**
  String get creditCard_specifyCustomAmount;

  /// No description provided for @common_itemDeleted.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" deleted'**
  String common_itemDeleted(String name);

  /// No description provided for @common_accountDeleted.
  ///
  /// In en, this message translates to:
  /// **'Account deleted'**
  String get common_accountDeleted;

  /// No description provided for @common_cardDeleted.
  ///
  /// In en, this message translates to:
  /// **'Card deleted'**
  String get common_cardDeleted;

  /// No description provided for @common_transactionDeleted.
  ///
  /// In en, this message translates to:
  /// **'Transaction deleted'**
  String get common_transactionDeleted;

  /// No description provided for @common_recordDeleted.
  ///
  /// In en, this message translates to:
  /// **'Record deleted'**
  String get common_recordDeleted;

  /// No description provided for @common_paymentDeleted.
  ///
  /// In en, this message translates to:
  /// **'Payment deleted'**
  String get common_paymentDeleted;

  /// No description provided for @loans_skippedInstallment.
  ///
  /// In en, this message translates to:
  /// **'Skipped loan installment'**
  String get loans_skippedInstallment;

  /// No description provided for @loans_loggedPayment.
  ///
  /// In en, this message translates to:
  /// **'Logged payment of {amount}'**
  String loans_loggedPayment(String amount);

  /// No description provided for @loans_notificationsPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Notifications permission required'**
  String get loans_notificationsPermissionRequired;

  /// No description provided for @creditCard_selectFundingAccount.
  ///
  /// In en, this message translates to:
  /// **'Please select a funding account'**
  String get creditCard_selectFundingAccount;

  /// No description provided for @presets_presetUpdated.
  ///
  /// In en, this message translates to:
  /// **'Preset updated'**
  String get presets_presetUpdated;

  /// No description provided for @presets_presetAdded.
  ///
  /// In en, this message translates to:
  /// **'Preset added'**
  String get presets_presetAdded;

  /// No description provided for @presets_presetDeleted.
  ///
  /// In en, this message translates to:
  /// **'Preset deleted'**
  String get presets_presetDeleted;

  /// No description provided for @transactions_deletedCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Deleted 1 item} other{Deleted {count} items}}'**
  String transactions_deletedCount(int count);

  /// No description provided for @split_atLeastTwoCategories.
  ///
  /// In en, this message translates to:
  /// **'At least 2 categories required for split.'**
  String get split_atLeastTwoCategories;

  /// No description provided for @split_categoryAndAmountRequired.
  ///
  /// In en, this message translates to:
  /// **'Each split item must have a category and amount > 0.'**
  String get split_categoryAndAmountRequired;

  /// No description provided for @presets_addQuickPresets.
  ///
  /// In en, this message translates to:
  /// **'Add 1-Tap Quick Presets'**
  String get presets_addQuickPresets;

  /// No description provided for @presets_quickPresetsDesc.
  ///
  /// In en, this message translates to:
  /// **'Log frequent coffees, commute, or meals with one tap'**
  String get presets_quickPresetsDesc;

  /// No description provided for @presets_loggedPreset.
  ///
  /// In en, this message translates to:
  /// **'Logged {title} ({amount})'**
  String presets_loggedPreset(String title, String amount);

  /// No description provided for @presets_createPreset.
  ///
  /// In en, this message translates to:
  /// **'Create Preset'**
  String get presets_createPreset;

  /// No description provided for @presets_editQuickPreset.
  ///
  /// In en, this message translates to:
  /// **'Edit Quick Preset'**
  String get presets_editQuickPreset;

  /// No description provided for @presets_newQuickPreset.
  ///
  /// In en, this message translates to:
  /// **'New Quick Preset'**
  String get presets_newQuickPreset;

  /// No description provided for @savings_addContribution.
  ///
  /// In en, this message translates to:
  /// **'Add Contribution'**
  String get savings_addContribution;

  /// No description provided for @savings_withdrawFromGoal.
  ///
  /// In en, this message translates to:
  /// **'Withdraw from Goal'**
  String get savings_withdrawFromGoal;

  /// No description provided for @savings_contribution.
  ///
  /// In en, this message translates to:
  /// **'Contribution'**
  String get savings_contribution;

  /// No description provided for @savings_withdrawal.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal'**
  String get savings_withdrawal;

  /// No description provided for @savings_unknownAccount.
  ///
  /// In en, this message translates to:
  /// **'Unknown Account'**
  String get savings_unknownAccount;

  /// No description provided for @savings_fromAccount.
  ///
  /// In en, this message translates to:
  /// **'From Account'**
  String get savings_fromAccount;

  /// No description provided for @savings_toAccount.
  ///
  /// In en, this message translates to:
  /// **'To Account'**
  String get savings_toAccount;

  /// No description provided for @presets_quickLog.
  ///
  /// In en, this message translates to:
  /// **'Quick Log'**
  String get presets_quickLog;

  /// No description provided for @accounts_dueOnDay.
  ///
  /// In en, this message translates to:
  /// **'Due on {day}'**
  String accounts_dueOnDay(int day);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'en',
        'es',
        'fr',
        'hi',
        'it',
        'ja',
        'pt',
        'ru',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
