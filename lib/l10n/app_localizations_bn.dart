// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'Expensy';

  @override
  String get settings_title => 'সেটিংস';

  @override
  String get settings_appearance => 'চেহারা ও থিম';

  @override
  String get settings_theme => 'থিম';

  @override
  String get settings_system => 'সিস্টেম';

  @override
  String get settings_light => 'হালকা';

  @override
  String get settings_dark => 'অন্ধকার';

  @override
  String get settings_amoledTitle => 'বিশুদ্ধ কালো (AMOLED)';

  @override
  String get settings_amoledSubtitle =>
      'ডার্ক মোডে সম্পূর্ণ কালো পটভূমি ব্যবহার করে';

  @override
  String get settings_systemDefault => 'সিস্টেম ডিফল্ট';

  @override
  String get settings_dynamicColor => 'ডাইনামিক কালার';

  @override
  String get settings_dynamicColorSubtitle =>
      'সিস্টেম ওয়ালপেপারের রঙ ব্যবহার করুন';

  @override
  String get settings_accentColor => 'অ্যাকসেন্ট রঙ';

  @override
  String get settings_accentColorSubtitle =>
      'অ্যাপের জন্য একটি মূল রঙ বেছে নিন';

  @override
  String get settings_appFont => 'অ্যাপ ফন্ট';

  @override
  String get settings_currency => 'মুদ্রা';

  @override
  String get settings_defaultCurrency => 'ডিফল্ট মুদ্রা';

  @override
  String get settings_preferences => 'পছন্দসমূহ';

  @override
  String get settings_weekStartsOn => 'সপ্তাহ শুরু হয়';

  @override
  String get settings_monday => 'সোমবার';

  @override
  String get settings_sunday => 'রবিবার';

  @override
  String get settings_hideBalance => 'ব্যালেন্স লুকান';

  @override
  String get settings_hideBalanceSubtitle => 'টাকার বদলে ••••• দেখান';

  @override
  String get settings_language => 'ভাষা';

  @override
  String get settings_profile => 'প্রোফাইল';

  @override
  String get settings_displayName => 'প্রদর্শিত নাম';

  @override
  String get settings_notSet => 'নির্ধারিত নয়';

  @override
  String get settings_about => 'অ্যাপ সম্পর্কে';

  @override
  String get settings_version => 'সংস্করণ';

  @override
  String get settings_privacy => 'গোপনীয়তা';

  @override
  String get settings_privacySubtitle =>
      'সব তথ্য লোকাল স্টোরেজে সংরক্ষিত — ১০০% অফলাইন';

  @override
  String get settings_github => 'GitHub';

  @override
  String get settings_githubSubtitle => 'সোর্স কোড দেখুন';

  @override
  String get settings_developer => 'ডেভেলপার';

  @override
  String get settings_developerSubtitle => 'Mina Android-এর আরও প্রজেক্ট দেখুন';

  @override
  String get settings_githubProfile => 'GitHub প্রোফাইল';

  @override
  String get settings_developerWebsite => 'ডেভেলপার ওয়েবসাইট';

  @override
  String get settings_close => 'বন্ধ করুন';

  @override
  String get settings_yourName => 'আপনার নাম';

  @override
  String get settings_cancel => 'বাতিল';

  @override
  String get settings_save => 'সংরক্ষণ';

  @override
  String recurring_expenses(Object count) {
    return 'ব্যয় ($count)';
  }

  @override
  String recurring_incomeList(Object count) {
    return 'আয় ($count)';
  }

  @override
  String get recurring_monthly => 'মাসিক';

  @override
  String get recurring_weekly => 'সাপ্তাহিক';

  @override
  String get recurring_noRecurringExpenses => 'কোনো নিয়মিত ব্যয় নেই';

  @override
  String get recurring_noRecurringIncome => 'কোনো নিয়মিত আয় নেই';

  @override
  String get recurring_addExpense => 'ব্যয় যোগ করুন';

  @override
  String get recurring_addIncome => 'আয় যোগ করুন';

  @override
  String get recurring_tapPlusToAddOne => 'যোগ করতে + চাপুন';

  @override
  String recurring_fromOngoing(Object date) {
    return '$date থেকে · চলমান';
  }

  @override
  String recurring_paidPayments(Object paid, Object total) {
    return '$paid/$total পরিশোধিত';
  }

  @override
  String recurring_totalAmount(Object amount) {
    return 'মোট: $amount';
  }

  @override
  String get recurring_overdue => 'মেয়াদ উত্তীর্ণ!';

  @override
  String get recurring_dueToday => 'আজ পরিশোধযোগ্য';

  @override
  String recurring_dueInDays(Object days) {
    return '$days দিনে বাকি';
  }

  @override
  String get recurring_edit => 'সম্পাদনা';

  @override
  String get recurring_skipBtn => 'বাদ দিন';

  @override
  String recurring_nextDate(Object date) {
    return 'পরবর্তী: $date';
  }

  @override
  String get recurring_pay => 'পরিশোধ';

  @override
  String get recurring_del => 'মুছুন';

  @override
  String recurring_historyCount(Object count) {
    return 'ইতিহাস ($count)';
  }

  @override
  String get recurring_paymentHistory => 'পেমেন্ট ইতিহাস';

  @override
  String get recurring_notificationPermissionDenied =>
      'বিজ্ঞপ্তির অনুমতি প্রত্যাখ্যান করা হয়েছে। সেটিংস → অ্যাপস → Expensy → বিজ্ঞপ্তি থেকে চালু করুন।';

  @override
  String get recurring_remindMeAt => 'আমাকে মনে করিয়ে দিন';

  @override
  String get recurring_editRecurring => 'নিয়মিত লেনদেন সম্পাদনা';

  @override
  String get recurring_addRecurring => 'নিয়মিত পেমেন্ট যোগ করুন';

  @override
  String get recurring_name => 'নাম';

  @override
  String get recurring_amountPerPayment => 'প্রতি কিস্তির পরিমাণ';

  @override
  String recurring_firstDate(Object date) {
    return 'প্রথম: $date';
  }

  @override
  String recurring_lastDate(Object date) {
    return 'শেষ: $date';
  }

  @override
  String get recurring_noLastPaymentOngoing => 'শেষ তারিখ নেই (চলমান)';

  @override
  String get accounts_refreshExchangeRates => 'বিনিময় হার রিফ্রেশ করুন';

  @override
  String get accounts_noAccounts => 'কোনো অ্যাকাউন্ট নেই';

  @override
  String get accounts_tapPlusToAddYourFirst =>
      'আপনার প্রথম অ্যাকাউন্ট যোগ করতে + চাপুন';

  @override
  String get accounts_fetchingExchangeRates => 'বিনিময় হার আনা হচ্ছে…';

  @override
  String get accounts_exchangeRatesUnavailable =>
      'বিনিময় হার পাওয়া যাচ্ছে না (অফলাইন)। মূল মুদ্রায় ব্যালেন্স দেখানো হচ্ছে।';

  @override
  String get accounts_unknown => 'অজানা';

  @override
  String accounts_ratesUpdated(Object timeStr) {
    return 'হার হালনাগাদ: $timeStr · রিফ্রেশ করতে ↺ চাপুন';
  }

  @override
  String get accounts_goldCaps => 'স্বর্ণ';

  @override
  String get accounts_balance => 'ব্যালেন্স';

  @override
  String get accounts_income => 'আয়';

  @override
  String get accounts_expense => 'ব্যয়';

  @override
  String get accounts_txs => 'লেনদেন';

  @override
  String get accounts_value => 'মূল্য';

  @override
  String get accounts_karat => 'ক্যারেট';

  @override
  String accounts_pure(Object percentage) {
    return '$percentage% বিশুদ্ধ';
  }

  @override
  String get accounts_weightLabel => 'ওজন';

  @override
  String get accounts_perGram => 'প্রতি গ্রাম';

  @override
  String get accounts_bank => 'ব্যাংক';

  @override
  String get accounts_cash => 'নগদ';

  @override
  String get accounts_savings => 'সঞ্চয়';

  @override
  String get accounts_creditCard => 'ক্রেডিট কার্ড';

  @override
  String get accounts_eWallet => 'ই-ওয়ালেট';

  @override
  String get accounts_gold => 'স্বর্ণ';

  @override
  String get accounts_editAccount => 'অ্যাকাউন্ট সম্পাদনা';

  @override
  String get accounts_addAccount => 'নতুন অ্যাকাউন্ট যোগ করুন';

  @override
  String get accounts_accountName => 'অ্যাকাউন্টের নাম';

  @override
  String get accounts_weightInGrams => 'গ্রামে ওজন';

  @override
  String get accounts_initialBalance => 'প্রাথমিক ব্যালেন্স';

  @override
  String get accounts_wontCountTowardYourHome =>
      'হোম স্ক্রিনের মোট ব্যালেন্সে গণনা হবে না';

  @override
  String get accounts_saveChanges => 'পরিবর্তন সংরক্ষণ';

  @override
  String get accounts_addAccountBtn => 'অ্যাকাউন্ট যোগ করুন';

  @override
  String get accounts_fetchingGoldPrice => 'স্বর্ণের দাম আনা হচ্ছে…';

  @override
  String get accounts_goldPriceUnavailable =>
      'স্বর্ণের দাম পাওয়া যায়নি — সংযোগ পরীক্ষা করুন';

  @override
  String lended_person_owesYou(Object name) {
    return '$name আপনাকে দেবেন';
  }

  @override
  String lended_person_youOwe(Object name) {
    return 'আপনি $name-কে দেবেন';
  }

  @override
  String get lended_person_allSettledUp => 'সব হিসাব পরিশোধিত';

  @override
  String get lended_person_noRecordsYet => 'এখনো কোনো রেকর্ড নেই';

  @override
  String get lended_person_tapPlusToLog =>
      'ধার দেওয়া বা নেওয়ার তথ্য লিখতে + চাপুন';

  @override
  String get lended_person_name => 'নাম';

  @override
  String get lended_person_notesOptional => 'নোট (ঐচ্ছিক)';

  @override
  String get lended_person_lent => 'ধার দেওয়া';

  @override
  String get lended_person_borrowed => 'ধার নেওয়া';

  @override
  String get lended_person_overdue => 'মেয়াদোত্তীর্ণ!';

  @override
  String lended_person_due(Object date) {
    return 'মেয়াদ $date';
  }

  @override
  String lended_person_reminderAt(Object time) {
    return '$time-এ রিমাইন্ডার';
  }

  @override
  String get lended_person_notificationPermissionDenied =>
      'বিজ্ঞপ্তির অনুমতি নেই। সেটিংস → অ্যাপস → Expensy → বিজ্ঞপ্তি থেকে অনুমতি দিন।';

  @override
  String get lended_person_remindMeAtPrompt => 'মনে করিয়ে দেওয়ার সময়';

  @override
  String get lended_person_editRecord => 'রেকর্ড সম্পাদনা';

  @override
  String get lended_person_addRecord => 'রেকর্ড যোগ করুন';

  @override
  String get lended_person_amount => 'পরিমাণ';

  @override
  String lended_person_dueColon(Object date) {
    return 'মেয়াদ: $date';
  }

  @override
  String get lended_person_noDueDate => 'নির্দিষ্ট তারিখ নেই';

  @override
  String get lended_person_setDueFirst => 'প্রথমে পরিশোধের তারিখ ঠিক করুন';

  @override
  String get lended_person_notifiedOnDue =>
      'নির্ধারিত তারিখে আপনাকে জানানো হবে';

  @override
  String get lended_person_getNotifiedWhenDue =>
      'মেয়াদ পূর্ণ হলে বিজ্ঞপ্তি পান';

  @override
  String get lended_person_thatTimePassed =>
      'আজকের সেই সময় পেরিয়ে গেছে — শীঘ্রই বিজ্ঞপ্তি পাঠানো হবে।';

  @override
  String lended_person_notificationFiresOn(Object date, Object time) {
    return '$date তারিখে $time-এ বিজ্ঞপ্তি যাবে।';
  }

  @override
  String get lended_person_saveChangesBtn => 'পরিবর্তন সংরক্ষণ';

  @override
  String get lended_person_addRecordBtn => 'রেকর্ড যোগ করুন';

  @override
  String get transactions_searchTransactions => 'লেনদেন খুঁজুন...';

  @override
  String get transactions_all => 'সব';

  @override
  String get transactions_income => 'আয়';

  @override
  String get transactions_expenses => 'ব্যয়';

  @override
  String get transactions_lent => 'ধার';

  @override
  String get transactions_borrowed => 'ধার নেওয়া';

  @override
  String get transactions_noTransactions => 'কোনো লেনদেন নেই';

  @override
  String get transactions_tapPlusToAddOne => 'যোগ করতে + চাপুন';

  @override
  String get transactions_today => 'আজ';

  @override
  String get transactions_yesterday => 'গতকাল';

  @override
  String transactions_lentTo(Object name) {
    return '$name-কে ধার দেওয়া';
  }

  @override
  String transactions_borrowedFrom(Object name) {
    return '$name থেকে ধার নেওয়া';
  }

  @override
  String get transactions_unknown => 'অজানা';

  @override
  String transactions_due(Object date) {
    return 'মেয়াদ $date';
  }

  @override
  String get transactions_unsettled => 'অমীমাংসিত';

  @override
  String get onboarding_restoreFailed =>
      'পুনরুদ্ধার ব্যর্থ: ফাইলটি নষ্ট হতে পারে বা Expensy ব্যাকআপ নয়।';

  @override
  String get onboarding_continue => 'চালিয়ে যান';

  @override
  String get onboarding_getStarted => 'শুরু করুন';

  @override
  String get onboarding_yourPersonalTracker =>
      'আপনার ব্যক্তিগত, ১০০% অফলাইন অর্থ-হিসাব রক্ষক।\nঅন্য ডিভাইস বা আগের ইনস্টলের ব্যাকআপ কি আপনার কাছে আছে?';

  @override
  String get onboarding_restoring => 'পুনরুদ্ধার হচ্ছে...';

  @override
  String get onboarding_chooseBackupFile => 'ব্যাকআপ ফাইল নির্বাচন করুন';

  @override
  String get onboarding_letsGetYouSetUp => 'চলুন সেট আপ শুরু করি';

  @override
  String get onboarding_yourName => 'আপনার নাম';

  @override
  String get onboarding_accountName => 'অ্যাকাউন্টের নাম';

  @override
  String get onboarding_bank => 'ব্যাংক';

  @override
  String get onboarding_cash => 'নগদ';

  @override
  String get onboarding_savings => 'সঞ্চয়';

  @override
  String get onboarding_credit => 'ক্রেডিট';

  @override
  String get onboarding_wallet => 'ওয়ালেট';

  @override
  String get onboarding_startingBalance => 'প্রাথমিক ব্যালেন্স';

  @override
  String get backup_replaceDataWarning =>
      'এটি আপনার বর্তমান সব তথ্য ব্যাকআপ দিয়ে প্রতিস্থাপন করবে।\nএটি পূর্বাবস্থায় ফেরানো যাবে না।';

  @override
  String get backup_whatsIncluded => 'যা যা অন্তর্ভুক্ত';

  @override
  String get backup_backupDescription =>
      'প্রতিটি ব্যাকআপে আপনার সব তথ্য থাকে — অ্যাকাউন্ট, লেনদেন, নিয়মিত পেমেন্ট ও ইতিহাস, বাজেট, উইশলিস্ট, ধার দেওয়া/নেওয়া ব্যক্তি ও রেকর্ড, সম্পদ, বিভাগ এবং সেটিংস।';

  @override
  String get backup_saving => 'সংরক্ষণ হচ্ছে...';

  @override
  String get backup_saveBackup => 'ব্যাকআপ সংরক্ষণ';

  @override
  String get backup_restoring => 'পুনরুদ্ধার হচ্ছে...';

  @override
  String get backup_restoreBackupBtn => 'ব্যাকআপ পুনরুদ্ধার';

  @override
  String get backup_restoreWarningText =>
      'যেকোনো অ্যাপ সংস্করণের ব্যাকআপের সাথে সামঞ্জস্যপূর্ণ। অনুপস্থিত তথ্য নিরাপদ ডিফল্ট দিয়ে পূরণ হয়।';

  @override
  String get backup_included => 'অন্তর্ভুক্ত';

  @override
  String get backup_accounts => 'অ্যাকাউন্ট';

  @override
  String get backup_transactions => 'লেনদেন';

  @override
  String get backup_recurringPayments => 'নিয়মিত পেমেন্ট';

  @override
  String get backup_recurringHistory => 'নিয়মিত ইতিহাস';

  @override
  String get backup_budgets => 'বাজেট';

  @override
  String get backup_wishlist => 'উইশলিস্ট';

  @override
  String get backup_lentPeople => 'ধার/দেনা — ব্যক্তি';

  @override
  String get backup_lentRecords => 'ধার/দেনা — রেকর্ড';

  @override
  String get backup_assets => 'সম্পদ';

  @override
  String get backup_categories => 'বিভাগসমূহ';

  @override
  String get backup_settings => 'সেটিংস';

  @override
  String backup_backupSavedSuccessfully(Object savedPath) {
    return 'ব্যাকআপ সফলভাবে সংরক্ষিত হয়েছে:\n$savedPath';
  }

  @override
  String backup_backupFailed(Object error) {
    return 'ব্যাকআপ ব্যর্থ হয়েছে: $error';
  }

  @override
  String backup_upgradedFrom(Object originalVersion, Object schemaVersion) {
    return ' (v$originalVersion → v$schemaVersion-এ উন্নীত)';
  }

  @override
  String backup_dataRestoredSuccessfully(Object vLabel) {
    return 'তথ্য সফলভাবে পুনরুদ্ধার হয়েছে!$vLabel';
  }

  @override
  String backup_restoreFailed(Object error) {
    return 'পুনরুদ্ধার ব্যর্থ হয়েছে: $error';
  }

  @override
  String get backup_restoreFailedCorrupted =>
      'পুনরুদ্ধার ব্যর্থ: ফাইলটি নষ্ট হতে পারে বা Expensy ব্যাকআপ নয়।';

  @override
  String get budget_noBudgetsYet => 'এখনো কোনো বাজেট নেই';

  @override
  String get budget_tapToAddBudget =>
      'প্রতি বিভাগে খরচের সীমা ঠিক করতে + চাপুন';

  @override
  String get budget_budgeted => 'বাজেটকৃত';

  @override
  String get budget_leftToSpend => 'খরচ করার বাকি';

  @override
  String get budget_spent => 'খরচ হয়েছে';

  @override
  String get budget_overLimit => 'সীমা অতিক্রম';

  @override
  String get budget_unknown => 'অজানা';

  @override
  String get budget_weeklyLabel => 'সাপ্তাহিক';

  @override
  String get budget_monthlyLabel => 'মাসিক';

  @override
  String budget_overAmount(Object amount) {
    return '$amount অতিরিক্ত';
  }

  @override
  String budget_leftAmount(Object amount) {
    return '$amount বাকি';
  }

  @override
  String budget_percentUsed(Object percent) {
    return '$percent% ব্যবহৃত';
  }

  @override
  String get budget_editBudget => 'বাজেট সম্পাদনা';

  @override
  String get budget_setBudget => 'নতুন বাজেট যোগ করুন';

  @override
  String get budget_budgetAmount => 'বাজেটের পরিমাণ';

  @override
  String budget_previewFor(Object catName) {
    return '\"$catName\"-এর প্রাকদর্শন';
  }

  @override
  String budget_spentAmount(Object amount) {
    return 'খরচ হয়েছে: $amount';
  }

  @override
  String budget_ofAmount(Object amount) {
    return 'মোট $amount-এর মধ্যে';
  }

  @override
  String get budget_saveChanges => 'পরিবর্তন সংরক্ষণ';

  @override
  String get budget_budget => 'বাজেট';

  @override
  String get budget_rollover => 'রোলওভার (জের স্থানান্তর)';

  @override
  String get budget_rolloverDesc =>
      'অব্যবহৃত উদ্বৃত্ত বা ঘাটতি পরবর্তী সময়ে নিয়ে যান';

  @override
  String get budget_rolloverBadge => 'রোলওভার';

  @override
  String budget_base(Object amount) {
    return 'মূল: $amount';
  }

  @override
  String budget_rolloverFrom(Object period, Object amount) {
    return 'রোলওভার ($period): $amount';
  }

  @override
  String budget_totalAvailable(Object amount) {
    return 'মোট উপলব্ধ: $amount';
  }

  @override
  String get budget_lastWeek => 'গত সপ্তাহ';

  @override
  String get pacing_dailyBudget => 'নিরাপদ দৈনিক সীমা';

  @override
  String pacing_safeToSpend(Object amount, Object days) {
    return 'নিরাপদ খরচ: $amount/দিন ($days দিন বাকি)';
  }

  @override
  String pacing_caution(Object amount) {
    return 'দ্রুত খরচ হচ্ছে — $amount/দিন-এ সীমিত রাখুন';
  }

  @override
  String get pacing_overPaced => 'গতি সতর্কতা — বাজেটে থাকতে খরচ কমান';

  @override
  String get pacing_budgetExhausted => 'বাজেট শেষ — আজ আর কোনো বরাদ্দ নেই';

  @override
  String get pacing_onTrack => 'সঠিক পথে';

  @override
  String get pacing_fast => 'দ্রুত খরচ হচ্ছে';

  @override
  String get pacing_alert => 'গতি সতর্কতা';

  @override
  String pacing_daysLeft(Object days) {
    return '$days দিন বাকি';
  }

  @override
  String get pacing_setBudgetPrompt => 'বাজেট সীমা ঠিক করতে ট্যাপ করুন →';

  @override
  String get pacing_dailyAvgPace => 'দৈনিক গড় খরচ';

  @override
  String pacing_perDay(Object amount) {
    return '$amount / দিন';
  }

  @override
  String get calendar_title => 'আর্থিক ক্যালেন্ডার';

  @override
  String get calendar_subtitle => 'দৈনিক খরচের মানচিত্র ও নির্ধারিত তারিখ';

  @override
  String calendar_zeroSpendDays(Object count) {
    return '$countটি শূন্য-ব্যয়ের দিন';
  }

  @override
  String get calendar_zeroSpendDayTitle => 'খরচবিহীন দিন! 🎉';

  @override
  String get calendar_zeroSpendDayDesc =>
      'আজ কোনো খরচ না করে চমৎকার আর্থিক শৃঙ্খলা দেখিয়েছেন।';

  @override
  String get calendar_billsDue => 'নির্ধারিত বিল ও সাবস্ক্রিপশন';

  @override
  String get calendar_loansDue => 'ঋণের কিস্তির তারিখ';

  @override
  String get calendar_lendedDue => 'প্রত্যাশিত পরিশোধ';

  @override
  String calendar_dayTransactions(Object count) {
    return 'লেনদেন ($count)';
  }

  @override
  String get calendar_noActivity => 'এই তারিখে কোনো লেনদেন বা দায়বদ্ধতা নেই';

  @override
  String get calendar_today => 'আজ';

  @override
  String calendar_averageDaily(Object amount) {
    return 'দৈনিক গড়: $amount';
  }

  @override
  String get wrapped_title => 'Expensy Wrapped';

  @override
  String wrapped_bannerTitle(Object month) {
    return 'আপনার $month-এর সারাংশ প্রস্তুত!';
  }

  @override
  String get wrapped_bannerSub => 'মাসিক আর্থিক গল্প দেখতে ট্যাপ করুন';

  @override
  String get wrapped_theBigPicture => 'সামগ্রিক চিত্র';

  @override
  String wrapped_howMoneyMoved(Object month) {
    return '$month-এ আপনার অর্থের প্রবাহ';
  }

  @override
  String get wrapped_totalInflow => 'মোট আয়';

  @override
  String get wrapped_totalOutflow => 'মোট ব্যয়';

  @override
  String get wrapped_netSavings => 'নিট সঞ্চয়';

  @override
  String wrapped_savingsRate(Object rate) {
    return 'সঞ্চয়ের হার: $rate%';
  }

  @override
  String get wrapped_topCategoryTitle => 'সবচেয়ে বেশি খরচ কোথায়?';

  @override
  String wrapped_topCategorySub(Object category) {
    return 'আপনার সর্বোচ্চ খরচের বিভাগ ছিল $category';
  }

  @override
  String wrapped_topCategoryShare(Object percent) {
    return 'মোট খরচের $percent%';
  }

  @override
  String get wrapped_biggestSplurgeTitle => 'সবচেয়ে বড় একক খরচ';

  @override
  String get wrapped_biggestSplurgeSub => 'মাসে আপনার একক সর্বোচ্চ ব্যয়';

  @override
  String get wrapped_noSplurge => 'কোনো বড় খরচ নেই! এই মাসে কোনো ব্যয় হয়নি।';

  @override
  String get wrapped_heroHabitTitle => 'সেরা অভ্যাস';

  @override
  String wrapped_zeroSpendAchieved(Object count) {
    return '$countটি শূন্য-ব্যয়ের দিন';
  }

  @override
  String wrapped_heroHabitDesc(Object count) {
    return 'আপনি $count দিন কোনো খরচ করেননি। অসাধারণ আর্থিক শৃঙ্খলা!';
  }

  @override
  String get wrapped_receiptTitle => 'মাসিক বিবরণী';

  @override
  String get wrapped_obscureToggle => 'শেয়ার করার জন্য টাকার অঙ্ক লুকান';

  @override
  String get wrapped_showToggle => 'টাকার অঙ্ক দেখান';

  @override
  String get wrapped_replay => 'পুনরায় দেখুন';

  @override
  String get insights_other => 'অন্যান্য';

  @override
  String get insights_noDataYet => 'এখনো কোনো তথ্য নেই';

  @override
  String get insights_addSomeTransactions =>
      'বিশ্লেষণ দেখতে কিছু লেনদেন যোগ করুন';

  @override
  String get insights_thisMonthVsLastMonth => 'এই মাস বনাম গত মাস';

  @override
  String get insights_dailyAverage => 'দৈনিক গড়';

  @override
  String insights_perDayBasedOn(Object days) {
    return 'প্রতি দিন · এই মাসের $days দিনের ভিত্তিতে';
  }

  @override
  String get insights_incomeVsExpenses => 'আয় বনাম ব্যয়';

  @override
  String insights_incomeAmount(Object amount) {
    return 'আয় $amount';
  }

  @override
  String insights_expensesAmount(Object amount) {
    return 'ব্যয় $amount';
  }

  @override
  String insights_percentSaved(Object percent) {
    return 'এই মাসে $percent% সঞ্চয়';
  }

  @override
  String get insights_topSpendingCategories => 'সর্বোচ্চ ব্যয়ের বিভাগসমূহ';

  @override
  String insights_percentOfTotal(Object percent) {
    return 'মোটের $percent%';
  }

  @override
  String get insights_biggestExpenseThisMonth => 'এই মাসের সবচেয়ে বড় ব্যয়';

  @override
  String get insights_categoryTrends => 'বিভাগের প্রবণতা';

  @override
  String get insights_12MonthTrend => '১২ মাসের প্রবণতা';

  @override
  String get insights_incomeLabel => 'আয়';

  @override
  String get insights_expensesLabel => 'ব্যয়';

  @override
  String get categories_expenseLabel => 'ব্যয়';

  @override
  String get categories_incomeLabel => 'আয়';

  @override
  String get categories_editCategory => 'বিভাগ সম্পাদনা করুন';

  @override
  String get categories_addCategory => 'বিভাগ যোগ করুন';

  @override
  String get categories_categoryName => 'বিভাগের নাম';

  @override
  String get categories_saveChanges => 'পরিবর্তন সংরক্ষণ করুন';

  @override
  String get statistics_other => 'অন্যান্য';

  @override
  String get statistics_allAccounts => 'সব অ্যাকাউন্ট';

  @override
  String get statistics_income => 'আয়';

  @override
  String get statistics_expenses => 'ব্যয়';

  @override
  String get statistics_expense => 'ব্যয়';

  @override
  String get statistics_net => 'নিট';

  @override
  String statistics_6MonthOverviewAccount(Object accountName) {
    return '৬ মাসের চিত্র · $accountName';
  }

  @override
  String get statistics_6MonthOverview => '৬ মাসের সামগ্রিক চিত্র';

  @override
  String statistics_percentOfBudget(Object percent) {
    return 'বাজেটের $percent%';
  }

  @override
  String get add_transaction_editTransaction => 'লেনদেন সম্পাদনা';

  @override
  String get add_transaction_addTransaction => 'লেনদেন লিখুন';

  @override
  String get add_transaction_amount => 'পরিমাণ';

  @override
  String add_transaction_conversionPreview(Object accountName, Object amount) {
    return '≈ $amount $accountName থেকে কাটা হবে';
  }

  @override
  String get add_transaction_accountFallback => 'অ্যাকাউন্ট';

  @override
  String get add_transaction_descriptionOptional => 'বিবরণ (ঐচ্ছিক)';

  @override
  String get add_transaction_noteOptional => 'নোট (ঐচ্ছিক)';

  @override
  String get add_transaction_saveChanges => 'পরিবর্তন সংরক্ষণ';

  @override
  String get more_statistics => 'পরিসংখ্যান';

  @override
  String get more_statisticsSub => 'চার্ট ও মাসিক সারাংশ';

  @override
  String get more_insights => 'বিশ্লেষণ';

  @override
  String get more_insightsSub => 'প্রবণতা, গড় ও বিভাগ বিশ্লেষণ';

  @override
  String get more_currencyConverter => 'মুদ্রা রূপান্তরকারী';

  @override
  String get more_currencyConverterSub => 'তাৎক্ষণিক মুদ্রা পরিবর্তন করুন';

  @override
  String get more_wishlist => 'উইশলিস্ট';

  @override
  String more_wishlistSub(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি আইটেম',
      one: '১টি আইটেম',
    );
    return '$_temp0';
  }

  @override
  String get more_lentMoney => 'ধার দেওয়া টাকা';

  @override
  String more_lentMoneySub(Object count) {
    return '$countটি বকেয়া';
  }

  @override
  String get more_assets => 'সম্পদ';

  @override
  String more_assetsSub(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি আইটেম',
      one: '১টি আইটেম',
    );
    return '$_temp0';
  }

  @override
  String get more_categories => 'বিভাগসমূহ';

  @override
  String more_categoriesSub(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি বিভাগ',
      one: '১টি বিভাগ',
    );
    return '$_temp0';
  }

  @override
  String get more_exportTransactions => 'লেনদেন রপ্তানি';

  @override
  String get more_exportTransactionsSub => 'Excel (.xlsx) হিসেবে সংরক্ষণ করুন';

  @override
  String get more_backupRestore => 'ব্যাকআপ ও পুনরুদ্ধার';

  @override
  String get more_backupRestoreSub => 'আপনার তথ্য সংরক্ষণ বা লোড করুন';

  @override
  String get more_settings => 'সেটিংস';

  @override
  String get more_settingsSub => 'থিম, মুদ্রা ও পছন্দসমূহ';

  @override
  String get more_sectionTools => 'আর্থিক টুলস';

  @override
  String get more_sectionAnalytics => 'বিশ্লেষণ ও পরিসংখ্যান';

  @override
  String get more_sectionPreferences => 'পছন্দসমূহ ও তথ্য';

  @override
  String home_greeting(Object name) {
    return 'হ্যালো, $name 👋';
  }

  @override
  String get home_there => 'বন্ধু';

  @override
  String get home_income => 'আয়';

  @override
  String get home_expenses => 'ব্যয়';

  @override
  String get home_net => 'নিট';

  @override
  String get wishlist_noItems => 'উইশলিস্টে কিছু নেই';

  @override
  String get wishlist_noItemsSub => 'সঞ্চয়ের লক্ষ্য যোগ করতে + চাপুন';

  @override
  String get wishlist_editItem => 'আইটেম সম্পাদনা';

  @override
  String get wishlist_addWishlistItem => 'উইশলিস্ট আইটেম যোগ করুন';

  @override
  String get wishlist_itemName => 'আইটেমের নাম';

  @override
  String get wishlist_targetPrice => 'লক্ষ্য মূল্য';

  @override
  String get wishlist_priorityLow => 'কম';

  @override
  String get wishlist_priorityMedium => 'মাঝারি';

  @override
  String get wishlist_priorityHigh => 'বেশি';

  @override
  String get wishlist_notesOptional => 'নোট (ঐচ্ছিক)';

  @override
  String get wishlist_saveChanges => 'পরিবর্তন সংরক্ষণ';

  @override
  String get wishlist_addItem => 'আইটেম যোগ করুন';

  @override
  String get wishlist_fundThisItem => 'তহবিল যোগ করুন';

  @override
  String wishlist_funded(int percent, String saved, String target) {
    return '$percent% সংগৃহীত ($saved / $target)';
  }

  @override
  String get wishlist_goalAchieved => 'লক্ষ্য অর্জিত — কেনার জন্য প্রস্তুত!';

  @override
  String get wishlist_buyNow => 'এখনই কিনুন';

  @override
  String get wishlist_purchaseTitle => 'উইশলিস্ট আইটেম কিনুন';

  @override
  String get wishlist_purchasePrompt =>
      'এই ক্রয়টি অ্যাকাউন্ট থেকে কাটতে একটি ব্যয় লেনদেন হিসেবে যুক্ত করতে চান?';

  @override
  String get wishlist_recordAndDeduct => 'লিখুন ও ব্যালেন্স কাটুন';

  @override
  String get wishlist_markPurchasedOnly => 'শুধু কেনা হয়েছে চিহ্নিত করুন';

  @override
  String wishlist_itemPurchased(String name) {
    return '\"$name\" কেনা হয়েছে হিসেবে চিহ্নিত!';
  }

  @override
  String get wishlist_viewGoal => 'সঞ্চয় লক্ষ্য দেখুন';

  @override
  String savings_linkedWishlist(String item) {
    return 'উইশলিস্টের সাথে যুক্ত: $item';
  }

  @override
  String get lended_theyOweMe => 'আমার পাওনা';

  @override
  String get lended_iOweThem => 'আমার দেনা';

  @override
  String get lended_net => 'নিট';

  @override
  String get lended_noOneYet => 'এখনো কেউ নেই';

  @override
  String get lended_noOneYetSub =>
      'যাকে ধার দিয়েছেন বা যার থেকে নিয়েছেন তাকে যোগ করতে + চাপুন';

  @override
  String get lended_owesYou => 'পাওনা';

  @override
  String get lended_youOwe => 'দেনা';

  @override
  String get lended_settledUp => 'পরিশোধিত';

  @override
  String get lended_noActiveRecords => 'সক্রিয় রেকর্ড নেই';

  @override
  String lended_activeRecords(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি সক্রিয় রেকর্ড',
      one: '১টি সক্রিয় রেকর্ড',
    );
    return '$_temp0';
  }

  @override
  String get lended_editPerson => 'ব্যক্তি সম্পাদনা';

  @override
  String get lended_addPerson => 'ব্যক্তি যোগ করুন';

  @override
  String get lended_name => 'নাম';

  @override
  String get lended_notesOptional => 'নোট (ঐচ্ছিক)';

  @override
  String get lended_saveChanges => 'পরিবর্তন সংরক্ষণ';

  @override
  String get assets_totalAssets => 'মোট সম্পদ';

  @override
  String get assets_items => 'আইটেম';

  @override
  String get assets_noAssetsYet => 'এখনো কোনো সম্পদ নেই';

  @override
  String get assets_noAssetsYetSub =>
      'সম্পদ বা মূল্যবান বস্তু যোগ করতে + চাপুন';

  @override
  String get assets_editAsset => 'সম্পদ সম্পাদনা';

  @override
  String get assets_addAsset => 'সম্পদ যোগ করুন';

  @override
  String get assets_productAssetName => 'পণ্য / সম্পদের নাম';

  @override
  String get assets_value => 'মূল্য';

  @override
  String get assets_notesOptional => 'নোট (ঐচ্ছিক)';

  @override
  String get assets_saveChanges => 'পরিবর্তন সংরক্ষণ';

  @override
  String get currency_converter_loadingRates => 'বিনিময় হার লোড হচ্ছে…';

  @override
  String get currency_converter_ratesUnavailable =>
      'বিনিময় হার পাওয়া যায়নি। ইন্টারনেটে সংযুক্ত হয়ে সিঙ্ক করুন।';

  @override
  String get currency_converter_rateAgeJustNow => 'এইমাত্র';

  @override
  String currency_converter_rateAgeMins(Object minutes) {
    return '$minutes মি আগে';
  }

  @override
  String currency_converter_rateAgeHours(Object hours) {
    return '$hours ঘ আগে';
  }

  @override
  String currency_converter_rateAgeDays(Object days) {
    return '$days দিন আগে';
  }

  @override
  String currency_converter_commonConversions(Object fromCurrency) {
    return '$fromCurrency থেকে সাধারণ রূপান্তর';
  }

  @override
  String transfer_fromAcc(Object currency) {
    return 'হতে ($currency)';
  }

  @override
  String transfer_toAcc(Object currency) {
    return 'তে ($currency)';
  }

  @override
  String get transfer_exchangeRatesNotLoaded =>
      'বিনিময় হার লোড হয়নি — পরিমাণটি সরাসরি স্থানান্তর করা হবে';

  @override
  String get transfer_amount => 'পরিমাণ';

  @override
  String get transfer_noteOptional => 'নোট (ঐচ্ছিক)';

  @override
  String get export_from => 'শুরু';

  @override
  String get export_to => 'শেষ';

  @override
  String export_txCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'এই সীমায় $countটি লেনদেন',
      one: 'এই সীমায় ১টি লেনদেন',
    );
    return '$_temp0';
  }

  @override
  String export_saved(Object path) {
    return 'সংরক্ষিত: $path';
  }

  @override
  String get export_complete => 'রপ্তানি সম্পন্ন';

  @override
  String get export_exporting => 'রপ্তানি হচ্ছে...';

  @override
  String get export_exportAsExcel => 'Excel হিসেবে রপ্তানি';

  @override
  String shared_widgets_deleteConfirm(Object name) {
    return '\"$name\" মুছে ফেলবেন? এটি পূর্বাবস্থায় ফেরানো যাবে না।';
  }

  @override
  String get shared_widgets_searchByCode => 'কোড বা নাম দিয়ে খুঁজুন...';

  @override
  String get accounts_accounts => 'অ্যাকাউন্টসমূহ';

  @override
  String get accounts_totalBalance => 'মোট ব্যালেন্স';

  @override
  String get accounts_excluded => 'বাদ দেওয়া';

  @override
  String get accounts_goldPriceNotYetLoade =>
      'স্বর্ণের দাম এখনো লোড হয়নি। একটু পর আবার চেষ্টা করুন।';

  @override
  String get accounts_accountType => 'অ্যাকাউন্টের ধরন';

  @override
  String get accounts_currency => 'মুদ্রা';

  @override
  String get accounts_goldPurityKarat => 'স্বর্ণের বিশুদ্ধতা (ক্যারেট)';

  @override
  String get accounts_weight => 'ওজন';

  @override
  String get accounts_excludeFromTotalBala => 'মোট ব্যালেন্স থেকে বাদ দিন';

  @override
  String get accounts_dontLinkToCard => 'কার্ডের সাথে যুক্ত করবেন না';

  @override
  String get accounts_dontLinkToCardDesc =>
      'অ্যাকাউন্টের ব্যালেন্স ম্যানুয়ালি পরিচালনা করুন এবং কার্ড লিংক করা বন্ধ রাখুন';

  @override
  String get accounts_color => 'রঙ';

  @override
  String get accounts_liveGoldValue => 'বর্তমান স্বর্ণের মূল্য';

  @override
  String get accounts_enterWeightAboveToSe => 'মূল্য দেখতে ওজন লিখুন';

  @override
  String get add_transaction_expense => 'ব্যয়';

  @override
  String get add_transaction_income => 'আয়';

  @override
  String get add_transaction_account => 'অ্যাকাউন্ট';

  @override
  String get add_transaction_category => 'বিভাগ';

  @override
  String get assets_assets => 'সম্পদসমূহ';

  @override
  String get backup_restoreBackup => 'ব্যাকআপ পুনরুদ্ধার করবেন?';

  @override
  String get backup_cancel => 'বাতিল';

  @override
  String get backup_replaceData => 'তথ্য প্রতিস্থাপন';

  @override
  String get backup_backupRestore => 'ব্যাকআপ ও পুনরুদ্ধার';

  @override
  String get backup_everythingAlways => 'সবকিছু, সবসময়';

  @override
  String get backup_createBackup => 'ব্যাকআপ তৈরি করুন';

  @override
  String get backup_saveAsJson => 'JSON হিসেবে সংরক্ষণ';

  @override
  String get backup_exportsAllAppDataToA =>
      'অ্যাপের সব তথ্য একটি পোর্টেবল ফাইলে রপ্তানি করে';

  @override
  String get backup_restoreBackup_ => 'ব্যাকআপ পুনরুদ্ধার';

  @override
  String get backup_loadFromJson => 'JSON থেকে লোড করুন';

  @override
  String get backup_picksABackupFileAndR =>
      'ব্যাকআপ ফাইল বেছে নিয়ে পুনরুদ্ধার করুন';

  @override
  String get backup_thisOverwritesAllCur =>
      'এটি বর্তমানের সব তথ্য মুছে প্রতিস্থাপন করবে।';

  @override
  String get budget_budgets => 'বাজেট';

  @override
  String get budget_empty => ' · ';

  @override
  String get budget_overBudget => 'বাজেট অতিক্রান্ত';

  @override
  String get budget_thisCategoryAlreadyH =>
      'এই বিভাগে ইতিমধ্যেই বাজেট আছে। সম্পাদনা করতে ট্যাপ করুন।';

  @override
  String get budget_period => 'সময়কাল';

  @override
  String get budget_monthly => 'মাসিক';

  @override
  String get budget_weekly => 'সাপ্তাহিক';

  @override
  String get budget_category => 'বিভাগ';

  @override
  String get categories_categories => 'বিভাগসমূহ';

  @override
  String get categories_expense => 'ব্যয়';

  @override
  String get categories_income => 'আয়';

  @override
  String get categories_color => 'রঙ';

  @override
  String get categories_icon => 'আইকন';

  @override
  String get categories_autoBasedOnName => 'স্বয়ংক্রিয় (নামের ভিত্তিতে)';

  @override
  String get categories_expenseCategories => 'ব্যয়ের বিভাগ';

  @override
  String get categories_incomeCategories => 'আয়ের বিভাগ';

  @override
  String get currency_converter_currencyConverter => 'মুদ্রা রূপান্তরকারী';

  @override
  String get currency_converter_amount => 'পরিমাণ';

  @override
  String get currency_converter_convertedTo => 'রূপান্তরিত';

  @override
  String get export_exportTransactions => 'লেনদেন রপ্তানি';

  @override
  String get export_dateRange => 'তারিখের সীমা';

  @override
  String get export_formatExcelXlsx => 'ফরম্যাট: Excel (.xlsx)';

  @override
  String get export_exportAsPdf => 'PDF রিপোর্ট হিসেবে রপ্তানি';

  @override
  String get export_formatPdf => 'ফরম্যাট: PDF আর্থিক প্রতিবেদন (.pdf)';

  @override
  String get export_pdfGenerating => 'PDF তৈরি হচ্ছে...';

  @override
  String get export_pdfTitle => 'আর্থিক প্রতিবেদন';

  @override
  String get export_pdfSummary => 'নির্বাহী সারাংশ';

  @override
  String get export_pdfInflow => 'মোট আয়';

  @override
  String get export_pdfOutflow => 'মোট ব্যয়';

  @override
  String get export_pdfNet => 'নিট সঞ্চয়';

  @override
  String get export_pdfSavingsRate => 'সঞ্চয়ের হার';

  @override
  String get export_pdfCategoryBreakdown => 'বিভাগভিত্তিক বিভাজন';

  @override
  String get export_pdfTransactions => 'বিস্তারিত লেনদেন';

  @override
  String get export_pdfNetWorthBreakdown => 'সম্পদ ও দায়বদ্ধতা';

  @override
  String get export_pdfShare => 'প্রতিবেদন শেয়ার করুন';

  @override
  String get export_pdfPrint => 'প্রিন্ট / প্রিভিউ';

  @override
  String get export_pdfGeneratedBy =>
      'Expensy দ্বারা প্রস্তুত • ব্যক্তিগত ও অফলাইন';

  @override
  String get home_totalBalance => 'মোট ব্যালেন্স';

  @override
  String get home_accounts => 'অ্যাকাউন্টসমূহ';

  @override
  String get home_recentTransactions => 'সাম্প্রতিক লেনদেন';

  @override
  String get home_noTransactionsYet => 'এখনো কোনো লেনদেন নেই';

  @override
  String get home_add => 'যোগ করুন';

  @override
  String get home_goodMorning => 'শুভ সকাল';

  @override
  String get home_goodAfternoon => 'শুভ অপরাহ্ণ';

  @override
  String get home_goodEvening => 'শুভ সন্ধ্যা';

  @override
  String get home_transferAction => 'স্থানান্তর';

  @override
  String get home_converterAction => 'কনভার্টার';

  @override
  String get home_insightsAction => 'বিশ্লেষণ';

  @override
  String get home_calendarAction => 'ক্যালেন্ডার';

  @override
  String get home_forecastAction => 'পূর্বাভাস';

  @override
  String get home_manage => 'পরিচালনা';

  @override
  String get home_seeAll => 'সব দেখুন';

  @override
  String get home_addAccount => 'অ্যাকাউন্ট যোগ করুন';

  @override
  String get home_cards => 'কার্ডসমূহ';

  @override
  String get home_addCard => 'কার্ড যোগ করুন';

  @override
  String get home_monthlyOverview => 'মাসিক সামগ্রিক চিত্র';

  @override
  String get home_savingsRate => 'সঞ্চয়ের হার';

  @override
  String get insights_insights => 'বিশ্লেষণ';

  @override
  String get lended_person_deletePerson => 'ব্যক্তি মুছুন';

  @override
  String get lended_person_editPerson => 'ব্যক্তি সম্পাদনা';

  @override
  String get lended_person_color => 'রঙ';

  @override
  String get lended_person_saveChanges => 'পরিবর্তন সংরক্ষণ';

  @override
  String get lended_person_settled => 'পরিশোধিত';

  @override
  String get lended_person_settle => 'নিষ্পত্তি';

  @override
  String get lended_person_setADueDateFirstToEn =>
      'রিমাইন্ডার চালু করতে প্রথমে নির্ধারিত তারিখ দিন।';

  @override
  String get lended_person_iLent => 'আমি ধার দিয়েছি';

  @override
  String get lended_person_iBorrowed => 'আমি ধার নিয়েছি';

  @override
  String get lended_person_accountOptional => 'অ্যাকাউন্ট (ঐচ্ছিক)';

  @override
  String get lended_person_dueDateReminder => 'নির্ধারিত তারিখের রিমাইন্ডার';

  @override
  String get lended_person_remindMeAt => 'আমাকে মনে করিয়ে দিন';

  @override
  String get lended_person_active => 'সক্রিয়';

  @override
  String get lended_person_settled_ => 'পরিশোধিত';

  @override
  String get lended_lentMoney => 'ধার দেওয়া টাকা';

  @override
  String get lended_overdue => 'মেয়াদোত্তীর্ণ';

  @override
  String get lended_color => 'রঙ';

  @override
  String get more_more => 'আরও';

  @override
  String get onboarding_back => 'পিছনে';

  @override
  String get onboarding_welcomeToExpensy => 'Expensy-তে স্বাগতম';

  @override
  String get onboarding_restoreABackup => 'ব্যাকআপ পুনরুদ্ধার করুন';

  @override
  String get onboarding_loadAPreviouslySaved =>
      'আগে সংরক্ষিত Expensy JSON ফাইল লোড করুন';

  @override
  String get onboarding_or => 'অথবা';

  @override
  String get onboarding_startFresh => 'নতুন করে শুরু করুন';

  @override
  String get onboarding_firstWhatShouldWeCal =>
      'প্রথমে, আমরা আপনাকে কী নামে ডাকব?';

  @override
  String get onboarding_defaultCurrency => 'ডিফল্ট মুদ্রা';

  @override
  String get onboarding_thisWillBeUsedAcross =>
      'এটি পুরো অ্যাপ জুড়ে ব্যবহৃত হবে।\nআপনি পরে সেটিংসে পরিবর্তন করতে পারবেন।';

  @override
  String get onboarding_searchAllCurrencies => 'সব মুদ্রা খুঁজুন';

  @override
  String get onboarding_yourFirstAccount => 'আপনার প্রথম অ্যাকাউন্ট';

  @override
  String get onboarding_setUpYourMainAccount =>
      'হিসাব শুরু করতে আপনার মূল অ্যাকাউন্ট সেট করুন।';

  @override
  String get onboarding_accountType => 'অ্যাকাউন্টের ধরন';

  @override
  String get onboarding_currency => 'মুদ্রা';

  @override
  String get onboarding_color => 'রঙ';

  @override
  String get recurring_recurring => 'নিয়মিত';

  @override
  String get recurring_income => 'আয়';

  @override
  String get recurring_2D => '−২ দিন';

  @override
  String get recurring_skipNextPayment => 'পরবর্তী পেমেন্ট বাদ দেবেন?';

  @override
  String get recurring_cancel => 'বাতিল';

  @override
  String get recurring_skip => 'বাদ দিন';

  @override
  String get recurring_noHistoryYet => 'এখনো কোনো ইতিহাস নেই';

  @override
  String get recurring_expense => 'ব্যয়';

  @override
  String get recurring_income_ => 'আয়';

  @override
  String get recurring_every => 'প্রতি ';

  @override
  String get recurring_days => 'দিন';

  @override
  String get recurring_weeks => 'সপ্তাহ';

  @override
  String get recurring_months => 'মাস';

  @override
  String get recurring_years => 'বছর';

  @override
  String get recurring_payments => 'পেমেন্টসমূহ';

  @override
  String get recurring_totalCost => 'মোট খরচ';

  @override
  String get recurring_account => 'অ্যাকাউন্ট';

  @override
  String get recurring_category => 'বিভাগ';

  @override
  String get recurring_paymentReminder => 'পেমেন্ট রিমাইন্ডার';

  @override
  String get recurring_notificationWillFire =>
      'পরবর্তী নির্ধারিত তারিখে এই সময়ে বিজ্ঞপ্তি পাঠানো হবে।';

  @override
  String get recurring_remind2DaysBefore => '২ দিন আগে মনে করিয়ে দিন';

  @override
  String get statistics_statistics => 'পরিসংখ্যান';

  @override
  String get statistics_expensesByCategory => 'বিভাগ অনুযায়ী ব্যয়';

  @override
  String get transactions_transactions => 'লেনদেন';

  @override
  String get transactions_settled => 'পরিশোধিত';

  @override
  String get transfer_transfer => 'স্থানান্তর';

  @override
  String get transfer_from => 'হতে';

  @override
  String get transfer_to => 'তে';

  @override
  String get transfer_enterAnAmountToSeeTh => 'রূপান্তর দেখতে পরিমাণ লিখুন';

  @override
  String get wishlist_wishlist => 'উইশলিস্ট';

  @override
  String get wishlist_priority => 'অগ্রাধিকার';

  @override
  String get shared_widgets_delete => 'মুছুন';

  @override
  String get shared_widgets_cancel => 'বাতিল';

  @override
  String get shared_widgets_delete_ => 'মুছুন';

  @override
  String get shared_widgets_none => 'কোনোটিই নয়';

  @override
  String get shared_widgets_selectCurrency => 'মুদ্রা নির্বাচন করুন';

  @override
  String get main_home => 'হোম';

  @override
  String get main_transactions => 'লেনদেন';

  @override
  String get main_recurring => 'নিয়মিত';

  @override
  String get main_accounts => 'অ্যাকাউন্ট';

  @override
  String get main_budgets => 'বাজেট';

  @override
  String get main_more => 'আরও';

  @override
  String get onboarding_chooseLanguage => 'ভাষা নির্বাচন করুন';

  @override
  String get error_required => 'প্রয়োজনীয়';

  @override
  String recurring_subscriptions(Object count) {
    return 'সাবস্ক্রিপশন ($count)';
  }

  @override
  String recurring_installments(Object count) {
    return 'কিস্তি ($count)';
  }

  @override
  String get recurring_recurringType => 'নিয়মিত ধরন';

  @override
  String get recurring_subscription => 'সাবস্ক্রিপশন';

  @override
  String get recurring_installment => 'কিস্তি';

  @override
  String get recurring_installmentsRequireEndDate =>
      'কিস্তির জন্য অবশ্যই শেষ পরিশোধের তারিখ থাকতে হবে।';

  @override
  String get backup_importFromOtherApps => 'অন্যান্য অ্যাপ থেকে আমদানি';

  @override
  String get backup_importDescription => 'সমর্থিত অ্যাপ থেকে তথ্য আমদানি করুন';

  @override
  String get backup_importFromGreenStash => 'GreenStash (.json) থেকে আমদানি';

  @override
  String get backup_automaticBackup => 'স্বয়ংক্রিয় ব্যাকআপ';

  @override
  String get backup_dailyAutoBackup => 'দৈনিক অটো ব্যাকআপ';

  @override
  String backup_runsDailyAt(String time) {
    return 'প্রতিদিন $time-এ চলে';
  }

  @override
  String backup_lastBackup(String time) {
    return 'সর্বশেষ ব্যাকআপ: $time';
  }

  @override
  String backup_savingTo(String path) {
    return 'সংরক্ষণ স্থান: $path';
  }

  @override
  String get backup_changeTime => 'সময় পরিবর্তন';

  @override
  String get backup_changeFolder => 'ফোল্ডার পরিবর্তন';

  @override
  String get budget_budgetsAndGoals => 'বাজেট ও লক্ষ্য';

  @override
  String get onboarding_restoreGreenStash =>
      'GreenStash (.json) থেকে পুনরুদ্ধার করুন';

  @override
  String get savings_goalNotFound => 'লক্ষ্য পাওয়া যায়নি';

  @override
  String get savings_savedSoFar => 'এখন পর্যন্ত সঞ্চিত';

  @override
  String get savings_target => 'লক্ষ্য';

  @override
  String savings_targetDate(String date) {
    return 'লক্ষ্য তারিখ: $date';
  }

  @override
  String get savings_contribute => 'জমা করুন';

  @override
  String get savings_withdraw => 'উত্তোলন';

  @override
  String get savings_noAccounts =>
      'কোনো অ্যাকাউন্ট নেই। অনুগ্রহ করে আগে একটি অ্যাকাউন্ট যোগ করুন।';

  @override
  String get settings_budgetAlerts => 'বাজেট সতর্কতা';

  @override
  String get settings_budgetAlertsSub =>
      'বাজেট অতিক্রম করলে বা লক্ষ্য পূরণ হলে জানান';

  @override
  String get settings_dailyReminder => 'দৈনিক রিমাইন্ডার';

  @override
  String get settings_dailyReminderSub => 'প্রতিদিন লেনদেন লিখতে মনে করিয়ে দিন';

  @override
  String get settings_reminderTime => 'রিমাইন্ডার সময়';

  @override
  String get settings_hapticFeedback => 'হ্যাপটিক ফিডব্যাক';

  @override
  String get settings_hapticFeedbackSub => 'স্পর্শে ভাইব্রেশন দিন';

  @override
  String get savings_saveGoal => 'লক্ষ্য সংরক্ষণ';

  @override
  String get more_loans => 'ঋণসমূহ';

  @override
  String more_loansSub(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি সক্রিয় ঋণ',
      one: '১টি সক্রিয় ঋণ',
    );
    return '$_temp0';
  }

  @override
  String get loans_title => 'ঋণসমূহ';

  @override
  String get loans_addLoan => 'ঋণ যোগ করুন';

  @override
  String get loans_editLoan => 'ঋণ সম্পাদনা';

  @override
  String get loans_loanName => 'ঋণের নাম';

  @override
  String get loans_amount => 'পরিমাণ';

  @override
  String get loans_startDate => 'শুরুর তারিখ';

  @override
  String get loans_endDate => 'শেষ তারিখ';

  @override
  String get loans_interestRateOptional => 'সুদের হার (ঐচ্ছিক)';

  @override
  String get loans_account => 'যুক্ত অ্যাকাউন্ট';

  @override
  String get loans_monthlyPayment => 'মাসিক কিস্তি';

  @override
  String get loans_totalPayable => 'মোট পরিশোধযোগ্য';

  @override
  String get loans_remaining => 'বাকি';

  @override
  String get loans_paid => 'পরিশোধিত';

  @override
  String get loans_logPayment => 'পেমেন্ট লিখুন';

  @override
  String get loans_paymentReminder => 'পেমেন্ট রিমাইন্ডার';

  @override
  String get loans_reminderDay => 'রিমাইন্ডারের দিন';

  @override
  String get loans_notes => 'নোট';

  @override
  String get loans_saveLoan => 'ঋণ সংরক্ষণ';

  @override
  String get loans_deleteLoan => 'ঋণ মুছুন';

  @override
  String get loans_settled => 'পরিশোধিত';

  @override
  String loans_durationMonths(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count মাস',
      one: '১ মাস',
    );
    return '$_temp0';
  }

  @override
  String get loans_paymentHistory => 'পেমেন্ট ইতিহাস';

  @override
  String get loans_noPayments => 'এখনো কোনো পেমেন্ট লেখা হয়নি';

  @override
  String get loans_outstandingDebt => 'অপরিশোধিত ঋণ';

  @override
  String get loans_monthlyObligation => 'মাসিক দায়বদ্ধতা';

  @override
  String get insights_loans => 'ঋণ';

  @override
  String get backup_loans => 'ঋণসমূহ';

  @override
  String get backup_loanPayments => 'ঋণের পেমেন্ট';

  @override
  String get more_yearlyAnalysis => 'বার্ষিক বিশ্লেষণ';

  @override
  String get more_yearlyAnalysisSub => 'মাসভিত্তিক নগদ প্রবাহের পূর্বাভাস';

  @override
  String get yearly_title => 'বার্ষিক বিশ্লেষণ';

  @override
  String get yearly_recurringExp => 'নিয়মিত ব্যয়';

  @override
  String get yearly_recurringInc => 'নিয়মিত আয়';

  @override
  String get yearly_loans => 'ঋণের কিস্তি';

  @override
  String get yearly_borrowed => 'ধার পরিশোধের তারিখ';

  @override
  String get yearly_lentDue => 'ধার ফেরতের তারিখ';

  @override
  String get yearly_inflow => 'আয় প্রবাহ';

  @override
  String get yearly_outflow => 'ব্যয় প্রবাহ';

  @override
  String get yearly_netFlow => 'নিট প্রবাহ';

  @override
  String get yearly_totalInflow => 'মোট আয়';

  @override
  String get yearly_totalOutflow => 'মোট ব্যয়';

  @override
  String get yearly_netCashFlow => 'নিট নগদ প্রবাহ';

  @override
  String get yearly_noData => 'এখনো কোনো সম্ভাব্য কার্যক্রম নেই';

  @override
  String get yearly_noDataSub =>
      'পূর্বাভাস দেখতে নির্ধারিত তারিখসহ নিয়মিত পেমেন্ট, ঋণ বা ধারের তথ্য যোগ করুন';

  @override
  String get budget_addBudget => 'বাজেট যোগ করুন';

  @override
  String get budget_addGoal => 'সঞ্চয় লক্ষ্য যোগ করুন';

  @override
  String get add_transaction_possibleDuplicate => 'সম্ভাব্য অনুলিপি';

  @override
  String get add_transaction_goBack => 'ফিরে যান';

  @override
  String get add_transaction_saveAnyway => 'তবুও সংরক্ষণ করুন';

  @override
  String get loans_confirmDeleteLoan =>
      'আপনি কি নিশ্চিত যে এই ঋণ এবং এর সব পেমেন্ট মুছে ফেলতে চান?';

  @override
  String get loans_deletePayment => 'পেমেন্ট মুছুন';

  @override
  String get loans_confirmDeletePayment =>
      'আপনি কি নিশ্চিত যে এই পেমেন্ট রেকর্ডটি মুছতে চান?';

  @override
  String get split_transactions_title => 'বিভাগ বিভাজন';

  @override
  String get split_transactions_badge => 'বিভক্ত';

  @override
  String get split_transactions_addSplit => 'বিভাজন যোগ করুন';

  @override
  String get split_transactions_removeSplit => 'বিভাজন সরান';

  @override
  String get split_transactions_allocated => 'বরাদ্দকৃত';

  @override
  String get split_transactions_remaining => 'বাকি';

  @override
  String get split_transactions_fillRemaining => 'বাকি অংশ পূরণ করুন';

  @override
  String get split_transactions_breakdown => 'বিভাজন বিবরণী';

  @override
  String get split_transactions_mismatchError =>
      'বিভাজিত অঙ্কগুলোর যোগফল অবশ্যই মোট টাকার সমান হতে হবে।';

  @override
  String get netWorth_title => 'নিট সম্পদ';

  @override
  String get netWorth_subtitle =>
      'সময়ের সাথে মোট সম্পদ, দায় ও প্রকৃত মূল্যের হিসাব রাখুন';

  @override
  String get netWorth_current => 'বর্তমান নিট সম্পদ';

  @override
  String get netWorth_trend => 'নিট সম্পদের প্রবণতা';

  @override
  String get netWorth_totalAssets => 'মোট সম্পদ';

  @override
  String get netWorth_totalLiabilities => 'মোট দায়';

  @override
  String get netWorth_liquidCash => 'নগদ ও ব্যাংক অ্যাকাউন্ট';

  @override
  String get netWorth_goldValuation => 'ভৌত স্বর্ণ';

  @override
  String get netWorth_fixedAssets => 'সম্পত্তি ও বিনিয়োগ';

  @override
  String get netWorth_moneyLent => 'ধার দেওয়া অর্থ (পাওনা)';

  @override
  String get netWorth_creditDebt => 'ক্রেডিট কার্ড ও ওভারড্রাফ্ট';

  @override
  String get netWorth_loanDebt => 'পরিশোধযোগ্য ঋণ';

  @override
  String get netWorth_moneyBorrowed => 'ধার নেওয়া অর্থ (দেনা)';

  @override
  String get netWorth_assetBreakdown => 'সম্পদের বিভাজন';

  @override
  String get netWorth_liabilityBreakdown => 'দায়ের বিভাজন';

  @override
  String get netWorth_noHistory =>
      'দৈনিক স্ন্যাপশট সংরক্ষিত হওয়ার সাথে সাথে নিট সম্পদের ইতিহাস তৈরি হবে।';

  @override
  String get netWorth_debtRatio => 'ঋণের অনুপাত';

  @override
  String get netWorth_quickActions => 'দ্রুত কাজ';

  @override
  String get netWorth_history => 'স্ন্যাপশট ইতিহাস';

  @override
  String get creditCard_utilization => 'ক্রেডিট ব্যবহারের হার';

  @override
  String get creditCard_availableCredit => 'ব্যবহারযোগ্য';

  @override
  String get creditCard_limit => 'সীমা';

  @override
  String get creditCard_statementBalance => 'বিল স্টেটমেন্ট ব্যালেন্স';

  @override
  String get creditCard_unbilledBalance => 'অবিলকৃত';

  @override
  String get creditCard_payBill => 'কার্ড বিল পরিশোধ';

  @override
  String get creditCard_allCaughtUp => 'সব পরিশোধিত! কোনো বকেয়া বিল নেই';

  @override
  String get creditCard_payBillTitle => 'ক্রেডিট কার্ড বিল পরিশোধ';

  @override
  String get creditCard_payFromAccount => 'যে অ্যাকাউন্ট থেকে পরিশোধ হবে';

  @override
  String get creditCard_paymentAmount => 'পরিশোধের পরিমাণ';

  @override
  String get creditCard_fullStatement => 'স্টেটমেন্ট ব্যালেন্স';

  @override
  String get creditCard_fullBalance => 'মোট ব্যালেন্স';

  @override
  String get creditCard_minPayment => 'ন্যূনতম পরিশোধ';

  @override
  String get creditCard_customAmount => 'কাস্টম পরিমাণ';

  @override
  String creditCard_paymentSuccess(String amount, String cardName) {
    return '$cardName-এ $amount পরিশোধ হয়েছে';
  }

  @override
  String get creditCard_insufficientFunds =>
      'পরিমাণটি উপলব্ধ ব্যালেন্সের চেয়ে বেশি';

  @override
  String get creditCard_invalidAmount => 'অনুগ্রহ করে একটি সঠিক পরিমাণ লিখুন';

  @override
  String get onboarding_skipForNow => 'আপাতত এড়িয়ে যান';

  @override
  String get onboarding_addCard => 'কার্ড যোগ করুন';

  @override
  String get onboarding_skipCardDesc =>
      'এখন কার্ড যোগ করতে না চাইলে এটি এড়িয়ে যেতে পারেন।';

  @override
  String get onboarding_cardNameLabel => 'কার্ডের নাম (যেমন Visa Platinum)';

  @override
  String get onboarding_debitCard => 'ডেবিট কার্ড';

  @override
  String get onboarding_creditLimit => 'ক্রেডিট সীমা';

  @override
  String get onboarding_amountUsed => 'ব্যবহৃত পরিমাণ';

  @override
  String get accounts_cardHolderOptional => 'কার্ডধারীর নাম (ঐচ্ছিক)';

  @override
  String get accounts_last4Digits => 'শেষ ৪টি অঙ্ক';

  @override
  String get accounts_expiryDate => 'মেয়াদ শেষের তারিখ (MM/YY)';

  @override
  String get accounts_creditLimitOptional => 'ক্রেডিট সীমা (ঐচ্ছিক)';

  @override
  String get accounts_minPaymentOptional => 'ন্যূনতম পেমেন্ট (ঐচ্ছিক)';

  @override
  String get accounts_statementDayOptional => 'স্টেটমেন্টের দিন (ঐচ্ছিক)';

  @override
  String get accounts_statementDayExample => 'যেমন ২০';

  @override
  String get accounts_dueDayOptional => 'পরিশোধের দিন (ঐচ্ছিক)';

  @override
  String get accounts_dueDayExample => 'যেমন ১০';

  @override
  String get accounts_linkedAccountOptional =>
      'যুক্ত ব্যাংক অ্যাকাউন্ট (ঐচ্ছিক)';

  @override
  String get accounts_excludeCardBalance =>
      'অ্যাকাউন্টের ব্যালেন্স থেকে কার্ড ব্যালেন্স বাদ দিন';

  @override
  String get accounts_excludeCardBalanceDesc =>
      'এই কার্ডের ব্যালেন্স তার যুক্ত ব্যাংক অ্যাকাউন্টে যোগ হবে না।';

  @override
  String get accounts_cardHolderHeader => 'কার্ডধারী';

  @override
  String get accounts_expHeader => 'মেয়াদ';

  @override
  String get accounts_notifyOnDueDate => 'নির্ধারিত তারিখে আপনাকে জানানো হবে';

  @override
  String get accounts_notifyWhenDue => 'পেমেন্ট দেয় হলে বিজ্ঞপ্তি পান';

  @override
  String get accounts_remind2DaysBeforeDesc =>
      'পরিশোধের তারিখের ২ দিন আগে সতর্কতা পান';

  @override
  String get accounts_targetSaved => 'লক্ষ্য / সঞ্চিত';

  @override
  String transactions_selectedCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি নির্বাচিত',
      one: '১টি নির্বাচিত',
    );
    return '$_temp0';
  }

  @override
  String get transactions_changeCategory => 'বিভাগ পরিবর্তন করুন';

  @override
  String get transactions_deleteSelected => 'নির্বাচিতগুলো মুছুন';

  @override
  String get transactions_advancedFilters => 'উন্নত ফিল্টার';

  @override
  String get transactions_clearAll => 'সব মুছুন';

  @override
  String get transactions_amountRange => 'টাকার সীমা';

  @override
  String get transactions_minAmount => 'সর্বনিম্ন পরিমাণ';

  @override
  String get transactions_maxAmount => 'সর্বোচ্চ পরিমাণ';

  @override
  String get transactions_applyFilters => 'ফিল্টার প্রয়োগ করুন';

  @override
  String get presets_new => 'নতুন';

  @override
  String get presets_presetName => 'প্রিসেটের নাম (যেমন সকালের কফি)';

  @override
  String get presets_defaultAmount => 'ডিফল্ট পরিমাণ';

  @override
  String get savings_goalName => 'লক্ষ্যের নাম';

  @override
  String get savings_goalNameHint => 'যেমন নতুন গাড়ি, ভ্রমণ';

  @override
  String get savings_targetAmount => 'লক্ষ্য পরিমাণ';

  @override
  String get savings_targetDateOptional => 'লক্ষ্য তারিখ (ঐচ্ছিক)';

  @override
  String get savings_selectDate => 'তারিখ নির্বাচন';

  @override
  String get savings_amountRequired => 'পরিমাণ আবশ্যক';

  @override
  String get savings_noteOptional => 'নোট (ঐচ্ছিক)';

  @override
  String get loans_skipInstallment => 'পরবর্তী ঋণের কিস্তি বাদ দেবেন?';

  @override
  String get recurring_confirmDelete =>
      'আপনি কি নিশ্চিত যে এই নিয়মিত পেমেন্টটি মুছতে চান?';

  @override
  String get export_formatExcelOption => 'Excel (.xlsx)';

  @override
  String get export_formatPdfOption => 'PDF প্রতিবেদন';

  @override
  String get export_pdfNoTransactions =>
      'এই তারিখের সীমার মধ্যে কোনো লেনদেন পাওয়া যায়নি।';

  @override
  String get savings_saved => 'সঞ্চিত';

  @override
  String get export_pdfDate => 'তারিখ';

  @override
  String get export_pdfDescription => 'বিবরণ';

  @override
  String get accounts_noCardsYet => 'কোনো কার্ড নেই';

  @override
  String get accounts_tapToAddCard => 'প্রথম কার্ড যোগ করতে + চাপুন';

  @override
  String get savings_noGoalsYet => 'কোনো সঞ্চয় লক্ষ্য নেই';

  @override
  String get savings_tapToAddGoal => 'নতুন লক্ষ্য নির্ধারণ করতে + চাপুন';

  @override
  String get netWorth_recordSnapshot => 'স্ন্যাপশট সংরক্ষণ';

  @override
  String get netWorth_snapshotRecorded => 'স্ন্যাপশট সংরক্ষিত হয়েছে';

  @override
  String get savings_noContributionsYet => 'এখনো কোনো জমা নেই';

  @override
  String get creditCard_closesStatementBillingCycle =>
      'বর্তমান বিলিং চক্র বন্ধ করে';

  @override
  String get creditCard_clearsTotalDebt => 'কার্ডের সম্পূর্ণ বকেয়া পরিশোধ করে';

  @override
  String get creditCard_requiredMinPayment => 'প্রয়োজনীয় ন্যূনতম পরিশোধ';

  @override
  String get creditCard_specifyCustomAmount => 'নির্দিষ্ট পরিমাণ লিখুন';

  @override
  String common_itemDeleted(String name) {
    return '\"$name\" মুছে ফেলা হয়েছে';
  }

  @override
  String get common_accountDeleted => 'অ্যাকাউন্ট মুছে ফেলা হয়েছে';

  @override
  String get common_cardDeleted => 'কার্ড মুছে ফেলা হয়েছে';

  @override
  String get common_transactionDeleted => 'লেনদেন মুছে ফেলা হয়েছে';

  @override
  String get common_recordDeleted => 'রেকর্ড মুছে ফেলা হয়েছে';

  @override
  String get common_paymentDeleted => 'পেমেন্ট মুছে ফেলা হয়েছে';

  @override
  String get loans_skippedInstallment => 'ঋণের কিস্তি বাদ দেওয়া হয়েছে';

  @override
  String loans_loggedPayment(String amount) {
    return '$amount পেমেন্ট লেখা হয়েছে';
  }

  @override
  String get loans_notificationsPermissionRequired =>
      'বিজ্ঞপ্তির অনুমতি প্রয়োজন';

  @override
  String get creditCard_selectFundingAccount =>
      'অনুগ্রহ করে একটি অর্থদাতা অ্যাকাউন্ট নির্বাচন করুন';

  @override
  String get presets_presetUpdated => 'প্রিসেট হালনাগাদ হয়েছে';

  @override
  String get presets_presetAdded => 'প্রিসেট যোগ হয়েছে';

  @override
  String get presets_presetDeleted => 'প্রিসেট মুছে ফেলা হয়েছে';

  @override
  String transactions_deletedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি আইটেম মুছে ফেলা হয়েছে',
      one: '১টি আইটেম মুছে ফেলা হয়েছে',
    );
    return '$_temp0';
  }

  @override
  String get split_atLeastTwoCategories =>
      'বিভাজনের জন্য অন্তত ২টি বিভাগ প্রয়োজন।';

  @override
  String get split_categoryAndAmountRequired =>
      'প্রতিটি অংশে বিভাগ এবং ০-এর বেশি পরিমাণ থাকা আবশ্যক।';

  @override
  String get presets_addQuickPresets => '১-ট্যাপ দ্রুত প্রিসেট যোগ করুন';

  @override
  String get presets_quickPresetsDesc =>
      'এক ট্যাপেই প্রতিদিনের কফি, যাতায়াত বা খাবারের হিসাব লিখুন';

  @override
  String presets_loggedPreset(String title, String amount) {
    return '$title ($amount) লেখা হয়েছে';
  }

  @override
  String get presets_createPreset => 'প্রিসেট তৈরি করুন';

  @override
  String get presets_editQuickPreset => 'দ্রুত প্রিসেট সম্পাদনা';

  @override
  String get presets_newQuickPreset => 'নতুন দ্রুত প্রিসেট';

  @override
  String get savings_addContribution => 'জমা যোগ করুন';

  @override
  String get savings_withdrawFromGoal => 'লক্ষ্য থেকে উত্তোলন';

  @override
  String get savings_contribution => 'জমা';

  @override
  String get savings_withdrawal => 'উত্তোলন';

  @override
  String get savings_unknownAccount => 'অজানা অ্যাকাউন্ট';

  @override
  String get savings_fromAccount => 'প্রেরক অ্যাকাউন্ট';

  @override
  String get savings_toAccount => 'গ্রাহক অ্যাকাউন্ট';

  @override
  String get presets_quickLog => 'দ্রুত লগ';

  @override
  String accounts_dueOnDay(int day) {
    return '$day তারিখে নির্ধারিত';
  }

  @override
  String get accounts_cannotDeleteAccount => 'অ্যাকাউন্ট মুছে ফেলা যাবে না';

  @override
  String get common_ok => 'ঠিক আছে';

  @override
  String get certificates_title => 'মেয়াদি আমানত ও সার্টিফিকেট';

  @override
  String get certificates_addCertificate => 'সার্টিফিকেট যোগ করুন';

  @override
  String get certificates_editCertificate => 'সার্টিফিকেট সম্পাদনা';

  @override
  String get certificates_noCertificates => 'এখনো কোনো সার্টিফিকেট নেই';

  @override
  String get certificates_noCertificatesDesc =>
      'আপনার উচ্চ-মুনাফার সার্টিফিকেট, আমানত ও স্বয়ংক্রিয় সুদের আয় ট্র্যাক করুন।';

  @override
  String get certificates_active => 'সক্রিয়';

  @override
  String get certificates_matured => 'মেয়াদপূর্ণ';

  @override
  String get certificates_amount => 'মূলধন পরিমাণ';

  @override
  String get certificates_collectionType => 'সুদ সংগ্রহের ধরন';

  @override
  String get certificates_collectedSoFar => 'এখন পর্যন্ত সংগৃহীত';

  @override
  String get certificates_expectedTotal => 'মোট প্রত্যাশিত মুনাফা';

  @override
  String get certificates_startDate => 'শুরুর তারিখ';

  @override
  String get certificates_endDate => 'মেয়াদ শেষের তারিখ';

  @override
  String get certificates_redeem => 'সার্টিফিকেট ভাঙান';

  @override
  String certificates_redeemConfirm(String name, String amount) {
    return 'আপনি কি \"$name\" ভাঙাতে চান? $amount মূলধন আপনার ব্যাংক অ্যাকাউন্টে ফেরত পাঠানো হবে।';
  }

  @override
  String get certificates_redeemedSuccess =>
      'সার্টিফিকেট ভাঙানো হয়েছে এবং মূলধন সফলভাবে ফেরত এসেছে।';

  @override
  String get certificates_name => 'সার্টিফিকেটের নাম';

  @override
  String get certificates_interestRate => 'বার্ষিক সুদের হার (%)';

  @override
  String get certificates_linkedBankAccount => 'যুক্ত ব্যাংক অ্যাকাউন্ট';

  @override
  String get certificates_periodicYield => 'নিয়মিত সুদের মুনাফা';

  @override
  String get certificates_paymentReminder => 'মুনাফা রিমাইন্ডার বিজ্ঞপ্তি';

  @override
  String get certificates_reminderTime => 'রিমাইন্ডারের সময়';

  @override
  String get certificates_reminder2DaysBefore => '২ দিন আগে রিমাইন্ডার';

  @override
  String get certificates_deleteCertificate => 'সার্টিফিকেট মুছুন';

  @override
  String get certificates_confirmDeleteCertificate =>
      'আপনি কি এই সার্টিফিকেট মুছতে চান? সংশ্লিষ্ট সব আমানত ও সুদের লেনদেন মুছে যাবে এবং টাকা আপনার অ্যাকাউন্টে ফেরত আসবে।';

  @override
  String get certificates_deleted => 'সার্টিফিকেট মুছে ফেলা হয়েছে';

  @override
  String get onboarding_stayOnTopOfFinances =>
      'আপনার অর্থের পূর্ণ নিয়ন্ত্রণ রাখুন';

  @override
  String get onboarding_stayOnTopOfFinancesDesc =>
      'সময়মতো রিমাইন্ডার চালু করুন যাতে কোনো পেমেন্ট, বিল বা বাজেট সীমা মিস না হয়।';

  @override
  String get onboarding_featureBillTitle =>
      'বিল ও নির্ধারিত তারিখের রিমাইন্ডার';

  @override
  String get onboarding_featureBillDesc =>
      'ক্রেডিট কার্ডের বিল ও ঋণের কিস্তি পরিশোধের আগে সতর্কতা পান।';

  @override
  String get onboarding_featureBudgetTitle => 'বাজেট ট্র্যাকিং সতর্কতা';

  @override
  String get onboarding_featureBudgetDesc =>
      'খরচের সীমার ৮০% বা ১০০% পূর্ণ হলে বিজ্ঞপ্তি পান।';

  @override
  String get onboarding_featureRecurringTitle => 'নিয়মিত সাবস্ক্রিপশন';

  @override
  String get onboarding_featureRecurringDesc =>
      'নিয়মিত বিল ও মেম্বারশিপ নবায়নের আগে অবগত থাকুন।';

  @override
  String get onboarding_allowNotifications => 'বিজ্ঞপ্তির অনুমতি দিন';

  @override
  String get onboarding_maybeLater => 'পরে করব';

  @override
  String get categories_subcategories => 'উপ-বিভাগসমূহ';

  @override
  String get categories_addSubcategory => 'উপ-বিভাগ যোগ করুন';

  @override
  String get categories_parentCategory => 'মূল বিভাগ';

  @override
  String get categories_noneRoot => 'কোনটিই নয় (মূল বিভাগ)';

  @override
  String get categories_loadDefaults => 'ডিফল্ট উপ-বিভাগ লোড করুন';

  @override
  String categories_defaultsLoaded(int count) {
    return '$countটি ডিফল্ট উপ-বিভাগ লোড হয়েছে';
  }

  @override
  String get categories_defaultsAlreadyLoaded =>
      'ডিফল্ট উপ-বিভাগ ইতিমধ্যেই লোড করা আছে';

  @override
  String get statistics_byCategory => 'বিভাগ অনুযায়ী';

  @override
  String get statistics_bySubcategory => 'উপ-বিভাগ অনুযায়ী';

  @override
  String get backup_importFromTrackWallet =>
      'TrackWallet (.csv) থেকে আমদানি করুন';

  @override
  String backup_importedTransactions(int count) {
    return '$countটি লেনদেন সফলভাবে আমদানি হয়েছে!';
  }

  @override
  String get onboarding_restoreTrackWallet =>
      'TrackWallet (.csv) থেকে আমদানি করুন';

  @override
  String get transfer_categoryLocked => 'স্থানান্তর (ডিফল্ট ও একমাত্র বিভাগ)';

  @override
  String get loans_noLoans => 'এখনো কোনো ঋণ যোগ করা হয়নি';

  @override
  String get loans_noLoansSub => 'ঋণ বা কিস্তি ট্র্যাক করতে + ট্যাপ করুন';

  @override
  String get certificates_noCertificatesSub =>
      'সঞ্চয়পত্র ও স্থায়ী আমানত ট্র্যাক করতে + ট্যাপ করুন';

  @override
  String get common_undo => 'পূর্বাবস্থায়';

  @override
  String get common_close => 'বন্ধ';

  @override
  String get common_required => 'আবশ্যক';

  @override
  String get common_invalid => 'অবৈধ';

  @override
  String get common_none => 'কোনোটিই নয়';

  @override
  String common_enabledAt(String time) {
    return 'চালু ($time)';
  }

  @override
  String get common_disabled => 'বন্ধ';

  @override
  String get freq_daily => 'দৈনিক';

  @override
  String get freq_yearly => 'বার্ষিক';

  @override
  String recurring_transfers(Object count) {
    return 'স্থানান্তর ($count)';
  }

  @override
  String get recurring_transfer => 'স্থানান্তর';

  @override
  String get recurring_transferCaps => 'স্থানান্তর';

  @override
  String get recurring_noRecurringTransfers => 'কোনো নিয়মিত স্থানান্তর নেই';

  @override
  String recurring_subtitleCount(int count) {
    return '$countটি সাবস্ক্রিপশন ও নিয়মিত';
  }

  @override
  String recurring_perWeek(String amount) {
    return '$amount / সপ্তাহ';
  }

  @override
  String get recurring_perMonth => '/ মাস';

  @override
  String get recurring_fromAccount => 'প্রেরক অ্যাকাউন্ট';

  @override
  String get recurring_toAccount => 'গ্রাহক অ্যাকাউন্ট';

  @override
  String recurring_targetAmount(String currency) {
    return 'লক্ষ্য পরিমাণ ($currency)';
  }

  @override
  String get recurring_autoPayAt => 'স্বয়ংক্রিয় পেমেন্ট সময়';

  @override
  String get recurring_autoPayOnDueDate =>
      'নির্ধারিত তারিখে স্বয়ংক্রিয় পেমেন্ট';

  @override
  String get recurring_autoPayEnabledSub =>
      'নির্ধারিত তারিখে স্বয়ংক্রিয়ভাবে যুক্ত হবে';

  @override
  String get recurring_autoPayDisabledSub =>
      'সময় হলে এই পেমেন্টটি স্বয়ংক্রিয়ভাবে লিখুন';

  @override
  String get recurring_autoPayTime => 'অটো পে সময়';

  @override
  String get recurring_reminderEnabledSub =>
      'নির্ধারিত তারিখে আপনাকে জানানো হবে';

  @override
  String get recurring_reminderDisabledSub => 'পেমেন্টের সময় হলে বিজ্ঞপ্তি পান';

  @override
  String get recurring_earlyReminderEnabledSub =>
      '২ দিন আগে একই সময়ে অতিরিক্ত সতর্কতা';

  @override
  String get recurring_earlyReminderDisabledSub =>
      'নির্ধারিত তারিখের ২ দিন আগেও বিজ্ঞপ্তি পান';

  @override
  String get recurring_addRecurringBtn => 'নিয়মিত যোগ করুন';

  @override
  String get recurring_paymentDetails => 'পেমেন্ট বিবরণ';

  @override
  String get recurring_linkedAccount => 'যুক্ত অ্যাকাউন্ট';

  @override
  String get recurring_deletedAccount => 'মুছে ফেলা অ্যাকাউন্ট';

  @override
  String get recurring_frequency => 'পুনরাবৃত্তি';

  @override
  String get recurring_type => 'ধরন';

  @override
  String get recurring_startDate => 'শুরুর তারিখ';

  @override
  String get recurring_nextDueDate => 'পরবর্তী নির্ধারিত তারিখ';

  @override
  String get recurring_autoPay => 'স্বয়ংক্রিয় পেমেন্ট';

  @override
  String get recurring_reminder => 'রিমাইন্ডার';

  @override
  String get recurring_endDate => 'শেষ তারিখ';

  @override
  String get recurring_totalValue => 'মোট মূল্য';

  @override
  String get recurring_notes => 'নোট';

  @override
  String get recurring_upcomingPayments => 'আসন্ন পেমেন্টসমূহ';

  @override
  String recurring_remainingCount(int count) {
    return '$countটি বাকি';
  }

  @override
  String get recurring_allInstallmentsCompleted => 'সব কিস্তি সম্পন্ন হয়েছে';

  @override
  String recurring_installmentOf(int num, int total) {
    return '#$num / $total';
  }

  @override
  String get recurring_paymentPaid => 'পেমেন্ট পরিশোধিত';

  @override
  String get recurring_paymentSkipped => 'পেমেন্ট বাদ দেওয়া হয়েছে';

  @override
  String get presets_transfer => 'স্থানান্তর';

  @override
  String get presets_selectDifferentAccounts =>
      'অনুগ্রহ করে ভিন্ন উৎস এবং গন্তব্য অ্যাকাউন্ট নির্বাচন করুন।';

  @override
  String presets_targetAmountOptional(String currency) {
    return '$currency-এ লক্ষ্য পরিমাণ (ঐচ্ছিক)';
  }

  @override
  String get transactions_transfers => 'স্থানান্তর';

  @override
  String transactions_selectedItemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি আইটেম নির্বাচিত',
      one: '১টি আইটেম নির্বাচিত',
    );
    return '$_temp0';
  }

  @override
  String transactions_entriesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি এন্ট্রি',
      one: '১টি এন্ট্রি',
    );
    return '$_temp0';
  }

  @override
  String get transactions_clearSelection => 'নির্বাচন বাতিল';

  @override
  String get transactions_transferTitle => 'স্থানান্তর লেনদেন';

  @override
  String get transactions_transferBody =>
      'এই লেনদেনটি একটি অ্যাকাউন্ট স্থানান্তরের অংশ। ব্যালেন্সের সঠিকতা রক্ষার্থে একপাশ আলাদাভাবে পরিবর্তন করা যাবে না। আপনি কি এই স্থানান্তরটি মুছতে চান?';

  @override
  String get transactions_deleteTransfer => 'স্থানান্তর মুছুন';

  @override
  String get transactions_transferDeleted => 'স্থানান্তর মুছে ফেলা হয়েছে';

  @override
  String get transactions_certTitle => 'সার্টিফিকেট লেনদেন';

  @override
  String get transactions_certBody =>
      'এই লেনদেনটি একটি মেয়াদি আমানত বা সার্টিফিকেটের সাথে যুক্ত। মূলধন ও মুনাফার হিসাব ঠিক রাখতে সার্টিফিকেট স্ক্রিন থেকে এটি পরিচালনা করুন।';

  @override
  String get transactions_viewCertificate => 'সার্টিফিকেট দেখুন';

  @override
  String get transactions_openCertificates => 'সার্টিফিকেট খুলুন';

  @override
  String get transactions_loanFallback => 'ঋণ';

  @override
  String get transactions_loanPayment => 'ঋণের কিস্তি';

  @override
  String get transactions_goalContribution => 'লক্ষ্যে জমা';

  @override
  String get transactions_goalWithdrawal => 'লক্ষ্য থেকে উত্তোলন';

  @override
  String get calendar_repayment => 'পরিশোধ';

  @override
  String get calendar_transfersDue => 'নির্ধারিত নিয়মিত স্থানান্তর';

  @override
  String accounts_subtitleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি অ্যাকাউন্ট',
      one: '১টি অ্যাকাউন্ট',
    );
    return '$_temp0';
  }

  @override
  String get accounts_tabAccounts => 'অ্যাকাউন্ট';

  @override
  String get accounts_tabCards => 'কার্ড';

  @override
  String get accounts_addCardBtn => 'কার্ড যোগ করুন';

  @override
  String get accounts_addNewCardBtn => 'নতুন কার্ড যোগ করুন';

  @override
  String get accounts_editCard => 'কার্ড সম্পাদনা';

  @override
  String get accounts_cardNameHint => 'কার্ডের নাম (যেমন Visa Platinum)';

  @override
  String get accounts_debitCard => 'ডেবিট কার্ড';

  @override
  String get accounts_prepaidCard => 'প্রিপেইড কার্ড';

  @override
  String get accounts_pinToWidget => 'উইজেটে পিন করুন';

  @override
  String get accounts_unpinFromWidget => 'উইজেট থেকে সরান';

  @override
  String get accounts_maxPinnedWarning =>
      'আপনি ৩টির বেশি অ্যাকাউন্ট পিন করতে পারবেন না';

  @override
  String get accounts_selectLinkedBank =>
      'অনুগ্রহ করে এই ডেবিট কার্ডের জন্য একটি যুক্ত ব্যাংক অ্যাকাউন্ট নির্বাচন করুন।';

  @override
  String get accounts_debitSharesBalance =>
      'ডেবিট কার্ড তার যুক্ত ব্যাংক অ্যাকাউন্টের সাথে ব্যালেন্স শেয়ার করে।';

  @override
  String get accounts_linkedBankRequired => 'যুক্ত ব্যাংক অ্যাকাউন্ট (আবশ্যক)';

  @override
  String get accounts_amountCurrentlyOwed => 'বর্তমান বকেয়া পরিমাণ';

  @override
  String get accounts_initialAmountOwed => 'প্রাথমিক বকেয়া পরিমাণ';

  @override
  String get accounts_cardDebtHint =>
      'এই কার্ডে বর্তমানে বকেয়া থাকা পরিমাণ লিখুন (ঋণ হিসেবে সংরক্ষিত হবে)';

  @override
  String accounts_nextCycleCloses(int day) {
    return 'পরবর্তী বিলিং চক্র প্রায় $day তারিখে শেষ হবে';
  }

  @override
  String accounts_spotPriceLabel(int karat) {
    return 'বর্তমান দর (${karat}k স্বর্ণ/গ্রাম)';
  }

  @override
  String get accounts_weightTimesPurity => 'ওজন × বিশুদ্ধতা';

  @override
  String accounts_blockDeleteRecurring(int count) {
    return 'এই অ্যাকাউন্টে $countটি সক্রিয় নিয়মিত পেমেন্ট রয়েছে। অনুগ্রহ করে আগে সেগুলো সরান বা মুছুন।';
  }

  @override
  String accounts_blockDeleteLoans(int count) {
    return 'এই অ্যাকাউন্টে $countটি সক্রিয় ঋণ রয়েছে। অনুগ্রহ করে আগে সেগুলো সরান বা মুছুন।';
  }

  @override
  String accounts_blockDeleteCertificates(int count) {
    return 'এই অ্যাকাউন্টে $countটি সক্রিয় সার্টিফিকেট রয়েছে। অনুগ্রহ করে আগে সেগুলো ভাঙান বা মুছুন।';
  }

  @override
  String accounts_blockDeleteLended(int count) {
    return 'এই অ্যাকাউন্টে $countটি অমীমাংসিত ধার/দেনার রেকর্ড রয়েছে। আগে সেগুলো নিষ্পত্তি করুন।';
  }

  @override
  String accounts_blockDeleteSavings(int count) {
    return 'এই অ্যাকাউন্টটি $countটি সঞ্চয় জমার সাথে যুক্ত। আগে সেগুলো সরান বা মুছুন।';
  }

  @override
  String accounts_blockDeletePresets(int count) {
    return 'এই অ্যাকাউন্টটি $countটি লেনদেন প্রিসেটে ব্যবহৃত হচ্ছে। আগে সেগুলো সরান বা মুছুন।';
  }

  @override
  String accounts_blockDeleteCards(int count) {
    return 'এই অ্যাকাউন্টের সাথে $countটি কার্ড যুক্ত। আগে সংযোগ বিচ্ছিন্ন করুন বা মুছুন।';
  }

  @override
  String get add_transaction_selectAccountOrCard =>
      'অনুগ্রহ করে একটি অ্যাকাউন্ট বা কার্ড নির্বাচন করুন।';

  @override
  String get add_transaction_balanced => 'ভারসাম্যপূর্ণ';

  @override
  String add_transaction_similarExists(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'একই ধরনের $countটি লেনদেন আগে থেকেই রয়েছে:',
      one: 'একই ধরনের একটি লেনদেন আগে থেকেই রয়েছে:',
    );
    return '$_temp0';
  }

  @override
  String budget_goalsCountSubtitle(int budgets, int goals) {
    return '$budgetsটি বাজেট · $goalsটি লক্ষ্য';
  }

  @override
  String get budget_savingsGoalsCaps => 'সঞ্চয় লক্ষ্যসমূহ';

  @override
  String budget_percentSaved(String percent) {
    return '$percent% সঞ্চিত';
  }

  @override
  String budget_ofTarget(String amount) {
    return '$amount লক্ষ্যের মধ্যে';
  }

  @override
  String get budget_goalsTab => 'লক্ষ্যসমূহ';

  @override
  String get budget_completed => 'সম্পন্ন';

  @override
  String get savings_newGoal => 'নতুন সঞ্চয় লক্ষ্য';

  @override
  String get savings_editGoal => 'সঞ্চয় লক্ষ্য সম্পাদনা';

  @override
  String get certificates_activePrincipal => 'সক্রিয় মূলধন';

  @override
  String get certificates_activeCount => 'সক্রিয় সংখ্যা';

  @override
  String certificates_linkedBank(String name) {
    return 'যুক্ত: $name';
  }

  @override
  String certificates_yieldSummary(String amount, String type) {
    return 'মুনাফা: $amount ($type)';
  }

  @override
  String certificates_maturesOn(String date) {
    return 'মেয়াদপূর্তি: $date';
  }

  @override
  String get certificates_settledCaps => 'নিষ্পত্তিকৃত';

  @override
  String get certificates_activeCaps => 'সক্রিয়';

  @override
  String get certificates_annualRate => 'বার্ষিক হার';

  @override
  String get certificates_periodicYieldLabel => 'নিয়মিত মুনাফা';

  @override
  String get certificates_maturedAndSettled =>
      'সার্টিফিকেট মেয়াদপূর্ণ ও নিষ্পত্তিকৃত';

  @override
  String get certificates_payoutOverride => 'মুনাফা (কাস্টম)';

  @override
  String get certificates_dayRange => 'দিন (১-৩১)';

  @override
  String get certificates_noBankAccounts =>
      'কোনো ব্যাংক অ্যাকাউন্ট নেই। মুনাফা পেতে অনুগ্রহ করে একটি ব্যাংক অ্যাকাউন্ট তৈরি করুন।';

  @override
  String get certificates_selectLinkedBank =>
      'অনুগ্রহ করে একটি যুক্ত ব্যাংক অ্যাকাউন্ট নির্বাচন করুন।';

  @override
  String get creditCard_noFundingAccounts =>
      'পেমেন্ট করার জন্য কোনো ব্যাংক বা নগদ অ্যাকাউন্ট নেই।';

  @override
  String get creditCard_processing => 'প্রক্রিয়াধীন...';

  @override
  String creditCard_payAmountBtn(String amount) {
    return '$amount পরিশোধ করুন';
  }

  @override
  String get insights_loanPaymentsThisMonth => 'এই মাসের ঋণ / কিস্তি পরিশোধ';

  @override
  String get insights_spendingForecast => 'ব্যয়ের পূর্বাভাস';

  @override
  String get insights_forecastPrefix => 'এই হারে চললে আপনার খরচ হবে ';

  @override
  String insights_forecastSuffix(String month, int days) {
    return ' $month শেষ হওয়ার আগেই — $days দিন বাকি।';
  }

  @override
  String get insights_forecastDisclaimer =>
      'এখন পর্যন্ত ব্যয়ের ভিত্তিতে অনুমান, এতে আসন্ন নিয়মিত বিল অন্তর্ভুক্ত নয়।';

  @override
  String insights_forecastAccuracy(int days) {
    return 'প্রথম $days দিনের তথ্যের ভিত্তিতে — মাস এগোনোর সাথে সাথে সঠিকতা বাড়বে।';
  }

  @override
  String insights_projAmount(String amount) {
    return 'সম্ভাব্য: $amount';
  }

  @override
  String insights_projOfBudget(String percent) {
    return ' (বাজেটের $percent%)';
  }

  @override
  String get insights_outstanding => 'বকেয়া';

  @override
  String get insights_monthlyObligation => 'মাসিক দায়বদ্ধতা';

  @override
  String get loans_principal => 'মূলধন';

  @override
  String get loans_interestRate => 'সুদের হার';

  @override
  String get loans_duration => 'মেয়াদ';

  @override
  String get loans_transferTo => 'ঋণের টাকা স্থানান্তর করুন';

  @override
  String get loans_payFrom => 'কিস্তি পরিশোধের অ্যাকাউন্ট';

  @override
  String loans_dueDayTime(int day, String time) {
    return 'নির্ধারিত: $day তারিখ @ $time';
  }

  @override
  String more_activeCount(int count) {
    return '$countটি সক্রিয়';
  }

  @override
  String more_toolsSubtitle(int count) {
    return '$countটি আর্থিক টুল ও পছন্দসমূহ';
  }

  @override
  String get more_totalWealthCaps => 'মোট সম্পদ';

  @override
  String get more_liveNetWorthSub => 'সব সম্পদের সমন্বিত সরাসরি নিট মূল্য';

  @override
  String more_assetsAmount(String amount) {
    return 'সম্পদ: $amount';
  }

  @override
  String more_liabilitiesAmount(String amount) {
    return 'দায়: $amount';
  }

  @override
  String get netWorth_debtFree => 'ঋণমুক্ত';

  @override
  String get netWorth_showLess => 'কম দেখুন';

  @override
  String netWorth_showAll(int count) {
    return 'সব দেখুন ($count)';
  }

  @override
  String get netWorth_zeroLiabilities =>
      'কোনো দায় নেই! বকেয়া ঋণের পরিমাণ শূন্য।';

  @override
  String get netWorth_lentDebts => 'ধার/দেনা';

  @override
  String netWorth_snapBreakdown(String assets, String accounts) {
    return 'সম্পদ: $assets · অ্যাকাউন্ট: $accounts';
  }

  @override
  String get onboarding_nameRequired => 'নাম আবশ্যক';

  @override
  String get onboarding_popularCurrencies => 'জনপ্রিয় মুদ্রা';

  @override
  String get onboarding_debitCardNextStep =>
      'পরবর্তী ধাপে আপনি এই ব্যাংক অ্যাকাউন্টের জন্য একটি ডেবিট কার্ড যোগ করতে পারবেন';

  @override
  String get onboarding_addDebitCardTitle => 'ডেবিট কার্ড যোগ করুন';

  @override
  String get onboarding_addDebitCardDesc =>
      'সহজে খরচ ট্র্যাক করতে আপনার নতুন ব্যাংক অ্যাকাউন্টের সাথে একটি ডেবিট কার্ড যুক্ত করুন।';

  @override
  String get onboarding_cardName => 'কার্ডের নাম';

  @override
  String get onboarding_cardholderName => 'কার্ডধারীর নাম';

  @override
  String get onboarding_last4Digits => 'শেষ ৪টি অঙ্ক';

  @override
  String get onboarding_cardColor => 'কার্ডের রঙ';

  @override
  String wrapped_zeroSpendOfDays(int total) {
    return '$total দিনের মধ্যে শূন্য-ব্যয়ের দিন';
  }

  @override
  String get wrapped_savingsRateLabel => 'সঞ্চয়ের হার';

  @override
  String get wrapped_topCategoryLabel => 'শীর্ষ বিভাগ';

  @override
  String get wrapped_zeroSpendDaysLabel => 'খরচবিহীন দিন';

  @override
  String get wrapped_footerTag => '★ ব্যক্তিগত ও অফলাইন আর্থিক নিয়ন্ত্রণ ★';

  @override
  String get yearly_tapToExpand => 'বিস্তারিত দেখতে ট্যাপ করুন';

  @override
  String get yearly_noDataBadge => 'তথ্য নেই';

  @override
  String get export_formatHeader => 'রপ্তানি ফরম্যাট';

  @override
  String export_pdfPeriod(String range) {
    return 'সময়কাল: $range';
  }

  @override
  String export_pdfCurrency(String currency) {
    return 'মুদ্রা: $currency';
  }

  @override
  String export_pdfGenerated(String date) {
    return 'তৈরির তারিখ: $date';
  }

  @override
  String export_pdfPageOf(int page, int total) {
    return 'পৃষ্ঠা $page / $total';
  }

  @override
  String get export_pdfTotalAssets => 'মোট সম্পদ';

  @override
  String get export_pdfTotalLiabilities => 'মোট দায়';

  @override
  String get export_pdfCurrentNetWorth => 'বর্তমান নিট সম্পদ';

  @override
  String get export_pdfCategory => 'বিভাগ';

  @override
  String export_pdfAmountHeader(String currency) {
    return 'পরিমাণ ($currency)';
  }

  @override
  String get export_pdfPercentOfExpenses => 'মোট ব্যয়ের %';

  @override
  String get backup_encryptedTitle => 'এনক্রিপ্টেড ব্যাকআপ';

  @override
  String get backup_encryptedPrompt =>
      'এই ব্যাকআপ ফাইলটি এনক্রিপ্ট করতে ব্যবহৃত পাসওয়ার্ডটি লিখুন:';

  @override
  String get backup_password => 'পাসওয়ার্ড';

  @override
  String get backup_confirmPassword => 'পাসওয়ার্ড নিশ্চিত করুন';

  @override
  String get backup_decryptContinue => 'ডিক্রিপ্ট করে এগিয়ে যান';

  @override
  String get backup_chooseRestoreMode => 'পুনরুদ্ধারের ধরন নির্বাচন';

  @override
  String get backup_chooseRestoreModeDesc =>
      'আপনি পুরো ব্যাকআপ নাকি কেবল নির্দিষ্ট তথ্য পুনরুদ্ধার করতে চান তা বেছে নিন।';

  @override
  String get backup_selectiveRestore => 'নির্বাচিত পুনরুদ্ধার';

  @override
  String get backup_selectiveRestoreDesc =>
      'অন্য তথ্য বা সেটিংস না মুছে কেবল নির্দিষ্ট বিভাগ পুনরুদ্ধার করুন।';

  @override
  String get backup_fullRestore => 'সম্পূর্ণ পুনরুদ্ধার';

  @override
  String get backup_fullRestoreDesc =>
      'বর্তমানের সব ডেটাবেস ও সেটিংস ব্যাকআপের তথ্য দিয়ে সম্পূর্ণভাবে প্রতিস্থাপন করে।';

  @override
  String get backup_selectiveBackup => 'নির্বাচিত ব্যাকআপ';

  @override
  String get backup_selectiveBackupBtn => 'নির্বাচিত ব্যাকআপ...';

  @override
  String get backup_selectiveBackupDesc =>
      'JSON হিসেবে রপ্তানি করার জন্য আর্থিক তথ্যের বিভাগগুলো বেছে নিন।';

  @override
  String get backup_selectedRestoredSuccess =>
      'নির্বাচিত তথ্য সফলভাবে পুনরুদ্ধার হয়েছে!';

  @override
  String get backup_savingsGoals => 'সঞ্চয় লক্ষ্যসমূহ';

  @override
  String get backup_savingsContributions => 'সঞ্চয় জমার হিসাব';

  @override
  String get backup_encryptionDisabled => 'ব্যাকআপ এনক্রিপশন বন্ধ করা হয়েছে';

  @override
  String get backup_encryptionEnabled => 'ব্যাকআপ এনক্রিপশন চালু করা হয়েছে';

  @override
  String backup_encryptionFailed(String error) {
    return 'এনক্রিপশন চালু করতে ব্যর্থ: $error';
  }

  @override
  String get backup_encryptAutoTitle => 'অটো ব্যাকআপ এনক্রিপ্ট করুন';

  @override
  String get backup_encryptAutoDesc =>
      'AES-GCM-256 এনক্রিপশন দিয়ে অটো-ব্যাকআপ সুরক্ষিত রাখুন। পাসওয়ার্ড ভুলে গেলে ব্যাকআপ আর পুনরুদ্ধার করা যাবে না।';

  @override
  String get backup_passwordEmpty => 'পাসওয়ার্ড খালি রাখা যাবে না';

  @override
  String get backup_passwordsMismatch => 'পাসওয়ার্ড দুটি মেলেনি';

  @override
  String get backup_setPassword => 'পাসওয়ার্ড সেট করুন';

  @override
  String backup_autoCreated(String file) {
    return 'অটো ব্যাকআপ তৈরি হয়েছে: $file';
  }

  @override
  String backup_autoFailed(String error) {
    return 'অটো ব্যাকআপ ব্যর্থ হয়েছে: $error';
  }

  @override
  String get backup_nightlySchedule =>
      'প্রতি রাতে প্রায় ২:০০ টায় নির্বাচিত ফোল্ডারে';

  @override
  String get backup_noFolderSelected => 'কোনো ফোল্ডার নির্বাচিত নয়';

  @override
  String get backup_keepCopies => 'কতটি কপি রাখবেন:';

  @override
  String get backup_encryptAes => 'ব্যাকআপ এনক্রিপ্ট করুন (AES-GCM)';

  @override
  String backup_failedError(String error) {
    return 'ব্যর্থ: $error';
  }

  @override
  String backup_lastSuccess(String date, String kb) {
    return 'সর্বশেষ: $date ($kb KB)';
  }

  @override
  String get backup_backingUp => 'ব্যাকআপ নেওয়া হচ্ছে...';

  @override
  String get backup_backUpNow => 'এখনই ব্যাকআপ নিন';

  @override
  String get backup_androidIdleNote =>
      'রাত প্রায় ২:০০ টায় চলে। ফোন নিষ্ক্রিয় থাকলে Android দেরি করতে পারে।';

  @override
  String get backup_selectAll => 'সব নির্বাচন করুন';

  @override
  String get backup_deselectAll => 'সব নির্বাচন বাতিল';

  @override
  String get backup_selectiveSaved =>
      'নির্বাচিত ব্যাকআপ সফলভাবে সংরক্ষিত হয়েছে!';

  @override
  String backup_exportFailed(String error) {
    return 'রপ্তানি ব্যর্থ: $error';
  }

  @override
  String backup_exportSelected(int count) {
    return 'নির্বাচিত ($count) বিভাগ রপ্তানি করুন';
  }

  @override
  String backup_restoreSelected(int count) {
    return 'নির্বাচিত ($count) বিভাগ পুনরুদ্ধার করুন';
  }

  @override
  String get backup_selectiveRestoreNote =>
      'কেবল নির্বাচিত আইটেমগুলোই পুনরুদ্ধার হবে। আপনার বাকি অ্যাকাউন্ট, লেনদেন ও সেটিংস অক্ষত থাকবে।';

  @override
  String backup_countInBackup(int count) {
    return 'ব্যাকআপে $countটি';
  }

  @override
  String get backup_entityTxSplitsPresets => 'লেনদেন, বিভাজন ও প্রিসেট';

  @override
  String get backup_entityRecurringHistory => 'নিয়মিত পেমেন্ট ও ইতিহাস';

  @override
  String get backup_entityLoansPayments => 'ঋণ ও পরিশোধ';

  @override
  String get backup_entityLentContacts => 'ধার দেওয়া অর্থ ও পরিচিতি';

  @override
  String get backup_entityAssetsValuables => 'সম্পদ ও মূল্যবান বস্তু';

  @override
  String get backup_entityWishlistGoals => 'উইশলিস্ট ও সঞ্চয় লক্ষ্যসমূহ';

  @override
  String get common_perDay => '/ দিন';

  @override
  String common_daysShort(int count) {
    return '$count দিন';
  }

  @override
  String get common_splitCaps => 'বিভক্ত';

  @override
  String budget_deletedCategory(String name) {
    return '$name মুছে ফেলা হয়েছে';
  }

  @override
  String get loans_paymentDeleted => 'পেমেন্ট মুছে ফেলা হয়েছে';

  @override
  String certificates_collectionDayLabel(String frequency, int day) {
    return '$frequency (দিন $day)';
  }

  @override
  String add_transaction_duplicateItem(
      String amount, String date, String desc) {
    return '• $date-এ $amount$desc';
  }

  @override
  String creditCard_billPaymentDesc(String name) {
    return 'ক্রেডিট কার্ড বিল পরিশোধ — $name';
  }

  @override
  String get onboarding_defaultBankName => 'প্রধান ব্যাংক';

  @override
  String get onboarding_defaultCardholder => 'EXPENSY সদস্য';

  @override
  String get onboarding_defaultUser => 'ব্যবহারকারী';

  @override
  String get export_excelSheetName => 'লেনদেন';

  @override
  String get export_headerDate => 'তারিখ';

  @override
  String get export_headerDescription => 'বিবরণ';

  @override
  String get export_headerType => 'ধরন';

  @override
  String get export_headerAmount => 'পরিমাণ';

  @override
  String get export_headerCurrency => 'মুদ্রা';

  @override
  String get export_headerAccount => 'অ্যাকাউন্ট';

  @override
  String get export_headerCategory => 'বিভাগ';

  @override
  String get export_headerSubcategory => 'উপ-বিভাগ';

  @override
  String get export_headerNote => 'নোট';

  @override
  String get cat_food_exp => 'খাবার ও ডাইনিং';

  @override
  String get cat_transport => 'যাতায়াত';

  @override
  String get cat_shopping => 'কেনাকাটা';

  @override
  String get cat_bills => 'বিল ও পরিষেবা';

  @override
  String get cat_health => 'স্বাস্থ্য';

  @override
  String get cat_entertainment => 'বিনোদন';

  @override
  String get cat_education => 'শিক্ষা';

  @override
  String get cat_personal => 'ব্যক্তিগত যত্ন';

  @override
  String get cat_salary => 'বেতন';

  @override
  String get cat_freelance => 'ফ্রিল্যান্স';

  @override
  String get cat_investments => 'বিনিয়োগ';

  @override
  String get cat_gifts => 'উপহার';

  @override
  String get cat_other_inc => 'অন্যান্য আয়';

  @override
  String get cat_other_exp => 'অন্যান্য খরচ';

  @override
  String get cat_sys_transfer => 'স্থানান্তর';

  @override
  String get cat_sys_investment => 'বিনিয়োগ';

  @override
  String get sub_groceries => 'মুদিখানা';

  @override
  String get sub_restaurants => 'রেস্তোরাঁ';

  @override
  String get sub_delivery => 'ডেলিভারি';

  @override
  String get sub_coffee_tea => 'কফি ও চা';

  @override
  String get sub_fuel => 'জ্বালানি';

  @override
  String get sub_public_transit => 'গণপরিবহন';

  @override
  String get sub_taxi_ride => 'ট্যাক্সি ও রাইড';

  @override
  String get sub_maintenance => 'রক্ষণাবেক্ষণ';

  @override
  String get sub_parking_tolls => 'পার্কিং ও টোল';

  @override
  String get sub_clothing => 'পোশাক';

  @override
  String get sub_electronics => 'ইলেকট্রনিক্স';

  @override
  String get sub_home_furniture => 'বাড়ি ও আসবাবপত্র';

  @override
  String get sub_gifts => 'উপহার';

  @override
  String get sub_electricity => 'বিদ্যুৎ';

  @override
  String get sub_internet => 'ইন্টারনেট';

  @override
  String get sub_water => 'পানি';

  @override
  String get sub_phone => 'ফোন';

  @override
  String get sub_medicine => 'ওষুধ';

  @override
  String get sub_doctor => 'ডাক্তার';

  @override
  String get sub_movies => 'সিনেমা';

  @override
  String get sub_games => 'গেমস';

  @override
  String get sub_subscriptions => 'সাবস্ক্রিপশন';

  @override
  String get notif_overBudgetTitle => '🚨 বাজেট অতিক্রম';

  @override
  String notif_overBudgetBody(String category, String amount, String period) {
    return '$category — আপনার $period সীমার চেয়ে $amount বেশি';
  }

  @override
  String get notif_goalReachedTitle => '🎉 লক্ষ্য অর্জিত হয়েছে';

  @override
  String notif_goalReachedBody(String amount, String name) {
    return 'আপনি $name-এর জন্য $amount লক্ষ্যে পৌঁছেছেন!';
  }

  @override
  String get notif_certPayoutDueTitle => '📈 সার্টিফিকেট মুনাফা প্রাপ্য';

  @override
  String get notif_certPayoutUpcomingTitle => '📈 আসন্ন সার্টিফিকেট মুনাফা';

  @override
  String notif_certPayoutBody(String name) {
    return '$name-এর মুনাফা আজ প্রাপ্য।';
  }

  @override
  String notif_certPayoutSoonBody(String name) {
    return '$name-এর মুনাফা ২ দিনের মধ্যে প্রাপ্য।';
  }

  @override
  String get notif_creditBillDueTodayTitle => '💳 বিল আজ পরিশোধযোগ্য';

  @override
  String get notif_creditBillDueSoonTitle => '💳 বিল শীঘ্রই পরিশোধযোগ্য';

  @override
  String get notif_dailyReminderTitle => '📝 দৈনিক রিমাইন্ডার';

  @override
  String get notif_dailyReminderBody => 'আজকের খরচ নথিভুক্ত করতে ভুলবেন না।';

  @override
  String notif_lendedDueTitle(String emoji, String name) {
    return '$emoji বকেয়া: $name';
  }

  @override
  String get notif_loanPaymentDueTitle => '🏦 ঋণের কিস্তি পরিশোধযোগ্য';

  @override
  String notif_loanPaymentDueBody(String name) {
    return '$name-এর কিস্তি আজ পরিশোধযোগ্য।';
  }

  @override
  String get notif_autoBackupFailedTitle => 'স্বয়ংক্রিয় ব্যাকআপ ব্যর্থ';

  @override
  String notif_autoBackupFailedBody(String error) {
    return 'Expensy নির্ধারিত ব্যাকআপ তৈরি করতে পারেনি: $error';
  }

  @override
  String notif_recurringTransferBody(String amount) {
    return '$amount স্থানান্তর বাকি';
  }

  @override
  String notif_recurringIncomeBody(String amount) {
    return '$amount আয় প্রাপ্য';
  }

  @override
  String notif_recurringExpenseBody(String amount) {
    return '$amount পেমেন্ট বাকি';
  }

  @override
  String notif_creditBillDueTodayBody(String name) {
    return 'আপনার $name বিল আজ পরিশোধের তারিখ।';
  }

  @override
  String notif_creditBillDueSoonBody(String name) {
    return 'আপনার $name বিল ২ দিনের মধ্যে পরিশোধযোগ্য।';
  }

  @override
  String notif_lendedLentDueBody(String amount, String name) {
    return '$name-কে ধার দেওয়া $amount আজ পরিশোধের তারিখ';
  }

  @override
  String notif_lendedBorrowedDueBody(String amount, String name) {
    return '$name-এর কাছ থেকে নেওয়া $amount ধার আজ পরিশোধের তারিখ';
  }

  @override
  String notif_recurringTransferDueSoonBody(String amount) {
    return '$amount স্থানান্তর ২ দিনের মধ্যে নির্ধারিত';
  }

  @override
  String notif_recurringIncomeDueSoonBody(String amount) {
    return '২ দিনের মধ্যে $amount আয় প্রত্যাশিত';
  }

  @override
  String notif_recurringExpenseDueSoonBody(String amount) {
    return '$amount ২ দিনের মধ্যে পরিশোধযোগ্য';
  }
}
