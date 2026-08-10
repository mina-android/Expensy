// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'खर्चा';

  @override
  String get settings_title => 'सेटिंग्स';

  @override
  String get settings_appearance => 'प्रकटन';

  @override
  String get settings_theme => 'थीम';

  @override
  String get settings_system => 'सिस्टम';

  @override
  String get settings_light => 'हल्का';

  @override
  String get settings_dark => 'गहरा';

  @override
  String get settings_amoledTitle => 'प्योर ब्लैक (AMOLED)';

  @override
  String get settings_amoledSubtitle =>
      'डार्क मोड में काली पृष्ठभूमि को लागू करता है';

  @override
  String get settings_systemDefault => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get settings_dynamicColor => 'गतिशील रंग';

  @override
  String get settings_dynamicColorSubtitle =>
      'सिस्टम वॉलपेपर रंगों का उपयोग करें';

  @override
  String get settings_accentColor => 'एक्सेंट रंग';

  @override
  String get settings_accentColorSubtitle => 'ऐप के लिए बीज का रंग चुनें';

  @override
  String get settings_appFont => 'ऐप फ़ॉन्ट';

  @override
  String get settings_currency => 'मुद्रा';

  @override
  String get settings_defaultCurrency => 'डिफ़ॉल्ट मुद्रा';

  @override
  String get settings_preferences => 'प्राथमिकताएं';

  @override
  String get settings_weekStartsOn => 'सप्ताह शुरू होता है';

  @override
  String get settings_monday => 'सोमवार';

  @override
  String get settings_sunday => 'रविवार';

  @override
  String get settings_hideBalance => 'बैलेंस छुपाएं';

  @override
  String get settings_hideBalanceSubtitle => 'राशियों के बजाय ••••• दिखाएं';

  @override
  String get settings_language => 'भाषा';

  @override
  String get settings_profile => 'प्रोफ़ाइल';

  @override
  String get settings_displayName => 'प्रदर्शित नाम';

  @override
  String get settings_notSet => 'सेट नहीं किया गया';

  @override
  String get settings_about => 'के बारे में';

  @override
  String get settings_version => 'संस्करण';

  @override
  String get settings_privacy => 'गोपनीयता';

  @override
  String get settings_privacySubtitle =>
      'सभी डेटा स्थानीय रूप से संग्रहीत — 100% ऑफ़लाइन';

  @override
  String get settings_github => 'गिटहब';

  @override
  String get settings_githubSubtitle => 'स्रोत कोड देखें';

  @override
  String get settings_developer => 'डेवलपर';

  @override
  String get settings_developerSubtitle =>
      'Mina Android द्वारा और प्रोजेक्ट्स खोजें';

  @override
  String get settings_githubProfile => 'GitHub प्रोफ़ाइल';

  @override
  String get settings_developerWebsite => 'डेवलपर वेबसाइट';

  @override
  String get settings_close => 'बंद करें';

  @override
  String get settings_yourName => 'आपका नाम';

  @override
  String get settings_cancel => 'रद्द करें';

  @override
  String get settings_save => 'सहेजें';

  @override
  String recurring_expenses(Object count) {
    return 'खर्च ($count)';
  }

  @override
  String recurring_incomeList(Object count) {
    return 'आय ($count)';
  }

  @override
  String get recurring_monthly => 'मासिक';

  @override
  String get recurring_weekly => 'साप्ताहिक';

  @override
  String get recurring_noRecurringExpenses => 'कोई आवर्ती खर्च नहीं';

  @override
  String get recurring_noRecurringIncome => 'कोई आवर्ती आय नहीं';

  @override
  String get recurring_addExpense => 'खर्च जोड़ें';

  @override
  String get recurring_addIncome => 'आय जोड़ें';

  @override
  String get recurring_tapPlusToAddOne => 'जोड़ने के लिए + टैप करें';

  @override
  String recurring_fromOngoing(Object date) {
    return '$date से · जारी';
  }

  @override
  String recurring_paidPayments(Object paid, Object total) {
    return '$total में से $paid का भुगतान किया गया';
  }

  @override
  String recurring_totalAmount(Object amount) {
    return 'कुल: $amount';
  }

  @override
  String get recurring_overdue => 'अतिदेय!';

  @override
  String get recurring_dueToday => 'आज देय';

  @override
  String recurring_dueInDays(Object days) {
    return '$days दिन में देय';
  }

  @override
  String get recurring_edit => 'संपादित करें';

  @override
  String get recurring_skipBtn => 'छोड़ें';

  @override
  String recurring_nextDate(Object date) {
    return 'अगला: $date';
  }

  @override
  String get recurring_pay => 'भुगतान करें';

  @override
  String get recurring_del => 'हटाएं';

  @override
  String recurring_historyCount(Object count) {
    return 'इतिहास ($count)';
  }

  @override
  String get recurring_paymentHistory => 'भुगतान इतिहास';

  @override
  String get recurring_notificationPermissionDenied =>
      'सूचना की अनुमति अस्वीकृत। इसे सेटिंग्स → ऐप्स → Expensy → सूचनाएँ में सक्षम करें।';

  @override
  String get recurring_remindMeAt => 'मुझे याद दिलाएं';

  @override
  String get recurring_editRecurring => 'आवर्ती संपादित करें';

  @override
  String get recurring_addRecurring => 'आवर्ती भुगतान जोड़ें';

  @override
  String get recurring_name => 'नाम';

  @override
  String get recurring_amountPerPayment => 'प्रति भुगतान राशि';

  @override
  String recurring_firstDate(Object date) {
    return 'प्रथम: $date';
  }

  @override
  String recurring_lastDate(Object date) {
    return 'अंतिम: $date';
  }

  @override
  String get recurring_noLastPaymentOngoing => 'कोई अंतिम भुगतान नहीं (जारी)';

  @override
  String get accounts_refreshExchangeRates => 'विनिमय दरें रीफ़्रेश करें';

  @override
  String get accounts_noAccounts => 'कोई खाते नहीं';

  @override
  String get accounts_tapPlusToAddYourFirst =>
      'अपना पहला खाता जोड़ने के लिए + टैप करें';

  @override
  String get accounts_fetchingExchangeRates =>
      'विनिमय दरें प्राप्त की जा रही हैं…';

  @override
  String get accounts_exchangeRatesUnavailable =>
      'विनिमय दरें अनुपलब्ध (ऑफ़लाइन)। शेष राशि मूल मुद्रा में दिखाई गई है।';

  @override
  String get accounts_unknown => 'अज्ञात';

  @override
  String accounts_ratesUpdated(Object timeStr) {
    return 'दरें $timeStr अपडेट की गईं · रीफ़्रेश करने के लिए ↺ टैप करें';
  }

  @override
  String get accounts_goldCaps => 'स्वर्ण';

  @override
  String get accounts_balance => 'शेष राशि';

  @override
  String get accounts_income => 'आय';

  @override
  String get accounts_expense => 'खर्च';

  @override
  String get accounts_txs => 'लेन-देन';

  @override
  String get accounts_value => 'मूल्य';

  @override
  String get accounts_karat => 'कैरेट';

  @override
  String accounts_pure(Object percentage) {
    return '$percentage% शुद्ध';
  }

  @override
  String get accounts_weightLabel => 'वजन';

  @override
  String get accounts_perGram => 'प्रति ग्राम';

  @override
  String get accounts_bank => 'बैंक';

  @override
  String get accounts_cash => 'नकद';

  @override
  String get accounts_savings => 'बचत';

  @override
  String get accounts_creditCard => 'क्रेडिट कार्ड';

  @override
  String get accounts_eWallet => 'ई-वॉलेट';

  @override
  String get accounts_gold => 'स्वर्ण';

  @override
  String get accounts_editAccount => 'खाता संपादित करें';

  @override
  String get accounts_addAccount => 'नया खाता जोड़ें';

  @override
  String get accounts_accountName => 'खाता नाम';

  @override
  String get accounts_weightInGrams => 'ग्राम में वजन';

  @override
  String get accounts_initialBalance => 'प्रारंभिक शेष';

  @override
  String get accounts_wontCountTowardYourHome =>
      'आपकी होम स्क्रीन के कुल योग में नहीं गिना जाएगा';

  @override
  String get accounts_saveChanges => 'परिवर्तन सहेजें';

  @override
  String get accounts_addAccountBtn => 'खाता जोड़ें';

  @override
  String get accounts_fetchingGoldPrice => 'सोने की कीमत प्राप्त की जा रही है…';

  @override
  String get accounts_goldPriceUnavailable =>
      'सोने की कीमत अनुपलब्ध — अपना कनेक्शन जांचें';

  @override
  String lended_person_owesYou(Object name) {
    return '$name आप पर बकाया है';
  }

  @override
  String lended_person_youOwe(Object name) {
    return 'आप $name पर बकाया हैं';
  }

  @override
  String get lended_person_allSettledUp => 'सब चुकता हो गया';

  @override
  String get lended_person_noRecordsYet => 'अभी कोई रिकॉर्ड नहीं';

  @override
  String get lended_person_tapPlusToLog =>
      'उधार दिए गए या लिए गए पैसे लॉग करने के लिए + टैप करें';

  @override
  String get lended_person_name => 'नाम';

  @override
  String get lended_person_notesOptional => 'नोट्स (वैकल्पिक)';

  @override
  String get lended_person_lent => 'उधार दिया';

  @override
  String get lended_person_borrowed => 'उधार लिया';

  @override
  String get lended_person_overdue => 'अतिदेय!';

  @override
  String lended_person_due(Object date) {
    return '$date को देय';
  }

  @override
  String lended_person_reminderAt(Object time) {
    return '$time पर अनुस्मारक';
  }

  @override
  String get lended_person_notificationPermissionDenied =>
      'सूचना की अनुमति अस्वीकृत। इसे सेटिंग्स → ऐप्स → Expensy → सूचनाएँ में सक्षम करें।';

  @override
  String get lended_person_remindMeAtPrompt => 'मुझे याद दिलाएं';

  @override
  String get lended_person_editRecord => 'रिकॉर्ड संपादित करें';

  @override
  String get lended_person_addRecord => 'रिकॉर्ड जोड़ें';

  @override
  String get lended_person_amount => 'राशि';

  @override
  String lended_person_dueColon(Object date) {
    return 'देय: $date';
  }

  @override
  String get lended_person_noDueDate => 'कोई देय तिथि नहीं';

  @override
  String get lended_person_setDueFirst => 'पहले देय तिथि सेट करें';

  @override
  String get lended_person_notifiedOnDue => 'आपको देय तिथि पर सूचित किया जाएगा';

  @override
  String get lended_person_getNotifiedWhenDue =>
      'यह देय होने पर सूचना प्राप्त करें';

  @override
  String get lended_person_thatTimePassed =>
      'आज वह समय बीत चुका है — आपको इसके बजाय शीघ्र ही सूचित किया जाएगा।';

  @override
  String lended_person_notificationFiresOn(Object date, Object time) {
    return 'सूचना $date को $time पर आएगी।';
  }

  @override
  String get lended_person_saveChangesBtn => 'परिवर्तन सहेजें';

  @override
  String get lended_person_addRecordBtn => 'रिकॉर्ड जोड़ें';

  @override
  String get transactions_searchTransactions => 'लेन-देन खोजें...';

  @override
  String get transactions_all => 'सभी';

  @override
  String get transactions_income => 'आय';

  @override
  String get transactions_expenses => 'खर्च';

  @override
  String get transactions_lent => 'उधार दिया';

  @override
  String get transactions_borrowed => 'उधार लिया';

  @override
  String get transactions_noTransactions => 'कोई लेन-देन नहीं';

  @override
  String get transactions_tapPlusToAddOne => 'एक जोड़ने के लिए + टैप करें';

  @override
  String get transactions_today => 'आज';

  @override
  String get transactions_yesterday => 'कल';

  @override
  String transactions_lentTo(Object name) {
    return '$name को उधार दिया';
  }

  @override
  String transactions_borrowedFrom(Object name) {
    return '$name से उधार लिया';
  }

  @override
  String get transactions_unknown => 'अज्ञात';

  @override
  String transactions_due(Object date) {
    return '$date को देय';
  }

  @override
  String get transactions_unsettled => 'अनिर्णीत';

  @override
  String get onboarding_restoreFailed =>
      'पुनर्स्थापना विफल: फ़ाइल दूषित हो सकती है या Expensy बैकअप नहीं हो सकती है।';

  @override
  String get onboarding_continue => 'जारी रखें';

  @override
  String get onboarding_getStarted => 'शुरू करें';

  @override
  String get onboarding_yourPersonalTracker =>
      'आपका व्यक्तिगत, 100% ऑफ़लाइन वित्त ट्रैकर।\nक्या आपके पास पहले से किसी अन्य डिवाइस या पिछले इंस्टॉल से बैकअप है?';

  @override
  String get onboarding_restoring => 'पुनर्स्थापित किया जा रहा है...';

  @override
  String get onboarding_chooseBackupFile => 'बैकअप फ़ाइल चुनें';

  @override
  String get onboarding_letsGetYouSetUp => 'आइए आपका सेटअप करें';

  @override
  String get onboarding_yourName => 'आपका नाम';

  @override
  String get onboarding_accountName => 'खाता नाम';

  @override
  String get onboarding_bank => 'बैंक';

  @override
  String get onboarding_cash => 'नकद';

  @override
  String get onboarding_savings => 'बचत';

  @override
  String get onboarding_credit => 'क्रेडिट';

  @override
  String get onboarding_wallet => 'वॉलेट';

  @override
  String get onboarding_startingBalance => 'प्रारंभिक शेष';

  @override
  String get backup_replaceDataWarning =>
      'यह आपके सभी वर्तमान डेटा को बैकअप से बदल देगा।\nइसे पूर्ववत नहीं किया जा सकता है।';

  @override
  String get backup_whatsIncluded => 'क्या शामिल है';

  @override
  String get backup_backupDescription =>
      'हर बैकअप में आपका सारा डेटा शामिल है — खाते, लेन-देन, आवर्ती भुगतान और उनका भुगतान/छोड़ने का इतिहास, बजट, विशलिस्ट आइटम, उधार दिए गए और लिए गए व्यक्ति और रिकॉर्ड, संपत्तियां, श्रेणियां और ऐप सेटिंग्स।';

  @override
  String get backup_saving => 'सहेजा जा रहा है...';

  @override
  String get backup_saveBackup => 'बैकअप सहेजें';

  @override
  String get backup_restoring => 'पुनर्स्थापित किया जा रहा है...';

  @override
  String get backup_restoreBackupBtn => 'बैकअप पुनर्स्थापित करें';

  @override
  String get backup_restoreWarningText =>
      'किसी भी ऐप संस्करण के बैकअप के साथ संगत। गुम फ़ील्ड सुरक्षित डिफ़ॉल्ट से भरे गए हैं।';

  @override
  String get backup_included => 'शामिल';

  @override
  String get backup_accounts => 'खाते';

  @override
  String get backup_transactions => 'लेन-देन';

  @override
  String get backup_recurringPayments => 'आवर्ती भुगतान';

  @override
  String get backup_recurringHistory => 'आवर्ती इतिहास';

  @override
  String get backup_budgets => 'बजट';

  @override
  String get backup_wishlist => 'विशलिस्ट';

  @override
  String get backup_lentPeople => 'उधार दिया/लिया — लोग';

  @override
  String get backup_lentRecords => 'उधार दिया/लिया — रिकॉर्ड';

  @override
  String get backup_assets => 'संपत्तियां';

  @override
  String get backup_categories => 'श्रेणियां';

  @override
  String get backup_settings => 'सेटिंग्स';

  @override
  String backup_backupSavedSuccessfully(Object savedPath) {
    return 'बैकअप सफलतापूर्वक सहेजा गया:\n$savedPath';
  }

  @override
  String backup_backupFailed(Object error) {
    return 'बैकअप विफल: $error';
  }

  @override
  String backup_upgradedFrom(Object originalVersion, Object schemaVersion) {
    return ' (v$originalVersion से v$schemaVersion में अपग्रेड किया गया)';
  }

  @override
  String backup_dataRestoredSuccessfully(Object vLabel) {
    return 'डेटा सफलतापूर्वक पुनर्स्थापित किया गया!$vLabel';
  }

  @override
  String backup_restoreFailed(Object error) {
    return 'पुनर्स्थापना विफल: $error';
  }

  @override
  String get backup_restoreFailedCorrupted =>
      'पुनर्स्थापना विफल: फ़ाइल दूषित हो सकती है या Expensy बैकअप नहीं हो सकती है।';

  @override
  String get budget_noBudgetsYet => 'अभी तक कोई बजट नहीं';

  @override
  String get budget_tapToAddBudget =>
      'प्रति श्रेणी खर्च सीमा निर्धारित करने के लिए + टैप करें';

  @override
  String get budget_budgeted => 'बजट में रखा गया';

  @override
  String get budget_leftToSpend => 'Left to Spend';

  @override
  String get budget_spent => 'खर्च किया गया';

  @override
  String get budget_overLimit => 'सीमा से अधिक';

  @override
  String get budget_unknown => 'अज्ञात';

  @override
  String get budget_weeklyLabel => 'साप्ताहिक';

  @override
  String get budget_monthlyLabel => 'मासिक';

  @override
  String budget_overAmount(Object amount) {
    return '$amount अधिक';
  }

  @override
  String budget_leftAmount(Object amount) {
    return '$amount शेष';
  }

  @override
  String budget_percentUsed(Object percent) {
    return '$percent% उपयोग किया गया';
  }

  @override
  String get budget_editBudget => 'बजट संपादित करें';

  @override
  String get budget_setBudget => 'नया बजट जोड़ें';

  @override
  String get budget_budgetAmount => 'बजट राशि';

  @override
  String budget_previewFor(Object catName) {
    return '\"$catName\" के लिए पूर्वावलोकन';
  }

  @override
  String budget_spentAmount(Object amount) {
    return 'खर्च: $amount';
  }

  @override
  String budget_ofAmount(Object amount) {
    return '$amount में से';
  }

  @override
  String get budget_saveChanges => 'परिवर्तन सहेजें';

  @override
  String get budget_budget => 'बजट';

  @override
  String get insights_other => 'अन्य';

  @override
  String get insights_noDataYet => 'अभी कोई डेटा नहीं';

  @override
  String get insights_addSomeTransactions =>
      'इनसाइट देखने के लिए कुछ लेन-देन जोड़ें';

  @override
  String get insights_thisMonthVsLastMonth => 'इस महीने बनाम पिछले महीने';

  @override
  String get insights_dailyAverage => 'दैनिक औसत';

  @override
  String insights_perDayBasedOn(Object days) {
    return 'प्रति दिन · इस महीने के $days दिनों के आधार पर';
  }

  @override
  String get insights_incomeVsExpenses => 'आय बनाम खर्च';

  @override
  String insights_incomeAmount(Object amount) {
    return 'आय $amount';
  }

  @override
  String insights_expensesAmount(Object amount) {
    return 'खर्च $amount';
  }

  @override
  String insights_percentSaved(Object percent) {
    return 'इस महीने $percent% बचाया गया';
  }

  @override
  String get insights_topSpendingCategories => 'शीर्ष खर्च श्रेणियां';

  @override
  String insights_percentOfTotal(Object percent) {
    return 'कुल का $percent%';
  }

  @override
  String get insights_biggestExpenseThisMonth => 'इस महीने का सबसे बड़ा खर्च';

  @override
  String get insights_categoryTrends =>
      'श्रेणी रुझान (पिछले महीने की तुलना में)';

  @override
  String get insights_12MonthTrend => '12-महीने का रुझान';

  @override
  String get insights_incomeLabel => 'आय';

  @override
  String get insights_expensesLabel => 'खर्च';

  @override
  String get categories_expenseLabel => 'खर्च';

  @override
  String get categories_incomeLabel => 'आय';

  @override
  String get categories_editCategory => 'श्रेणी संपादित करें';

  @override
  String get categories_addCategory => 'श्रेणी जोड़ें';

  @override
  String get categories_categoryName => 'श्रेणी का नाम';

  @override
  String get categories_saveChanges => 'परिवर्तन सहेजें';

  @override
  String get statistics_other => 'अन्य';

  @override
  String get statistics_allAccounts => 'सभी खाते';

  @override
  String get statistics_income => 'आय';

  @override
  String get statistics_expenses => 'खर्च';

  @override
  String get statistics_expense => 'खर्च';

  @override
  String get statistics_net => 'शुद्ध';

  @override
  String statistics_6MonthOverviewAccount(Object accountName) {
    return '6-महीने का अवलोकन · $accountName';
  }

  @override
  String get statistics_6MonthOverview => '6-महीने का अवलोकन';

  @override
  String statistics_percentOfBudget(Object percent) {
    return 'बजट का $percent%';
  }

  @override
  String get add_transaction_editTransaction => 'लेन-देन संपादित करें';

  @override
  String get add_transaction_addTransaction => 'लेन-देन दर्ज करें';

  @override
  String get add_transaction_amount => 'राशि';

  @override
  String add_transaction_conversionPreview(Object accountName, Object amount) {
    return '≈ $amount $accountName से काटे जाएंगे';
  }

  @override
  String get add_transaction_accountFallback => 'खाता';

  @override
  String get add_transaction_descriptionOptional => 'विवरण (वैकल्पिक)';

  @override
  String get add_transaction_noteOptional => 'नोट (वैकल्पिक)';

  @override
  String get add_transaction_saveChanges => 'परिवर्तन सहेजें';

  @override
  String get more_statistics => 'आँकड़े';

  @override
  String get more_statisticsSub => 'चार्ट और मासिक सारांश';

  @override
  String get more_insights => 'इनसाइट';

  @override
  String get more_insightsSub => 'रुझान, औसत और श्रेणी विश्लेषण';

  @override
  String get more_currencyConverter => 'मुद्रा परिवर्तक';

  @override
  String get more_currencyConverterSub => 'तुरंत मुद्राओं के बीच कनवर्ट करें';

  @override
  String get more_wishlist => 'विशलिस्ट';

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
  String get more_lentMoney => 'उधार दिया गया पैसा';

  @override
  String more_lentMoneySub(Object count) {
    return '$count बकाया';
  }

  @override
  String get more_assets => 'संपत्तियां';

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
  String get more_categories => 'श्रेणियां';

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
  String get more_exportTransactions => 'लेन-देन निर्यात करें';

  @override
  String get more_exportTransactionsSub => 'एक्सेल (.xlsx) के रूप में सहेजें';

  @override
  String get more_backupRestore => 'बैकअप और पुनर्स्थापना';

  @override
  String get more_backupRestoreSub => 'अपना डेटा सहेजें या लोड करें';

  @override
  String get more_settings => 'सेटिंग्स';

  @override
  String get more_settingsSub => 'थीम, मुद्रा और प्राथमिकताएं';

  @override
  String home_greeting(Object name) {
    return 'नमस्ते, $name 👋';
  }

  @override
  String get home_there => 'वहाँ';

  @override
  String get home_income => 'आय';

  @override
  String get home_expenses => 'खर्च';

  @override
  String get home_net => 'शुद्ध';

  @override
  String get wishlist_noItems => 'कोई विशलिस्ट आइटम नहीं';

  @override
  String get wishlist_noItemsSub =>
      'आप जिन चीज़ों के लिए बचत कर रहे हैं उन्हें जोड़ने के लिए + टैप करें';

  @override
  String get wishlist_editItem => 'आइटम संपादित करें';

  @override
  String get wishlist_addWishlistItem => 'विशलिस्ट आइटम जोड़ें';

  @override
  String get wishlist_itemName => 'आइटम का नाम';

  @override
  String get wishlist_targetPrice => 'लक्ष्य मूल्य';

  @override
  String get wishlist_priorityLow => 'कम';

  @override
  String get wishlist_priorityMedium => 'मध्यम';

  @override
  String get wishlist_priorityHigh => 'उच्च';

  @override
  String get wishlist_notesOptional => 'नोट्स (वैकल्पिक)';

  @override
  String get wishlist_saveChanges => 'परिवर्तन सहेजें';

  @override
  String get wishlist_addItem => 'आइटम जोड़ें';

  @override
  String get lended_theyOweMe => 'उन पर मेरा बकाया है';

  @override
  String get lended_iOweThem => 'मुझ पर उनका बकाया है';

  @override
  String get lended_net => 'शुद्ध';

  @override
  String get lended_noOneYet => 'अभी कोई नहीं';

  @override
  String get lended_noOneYetSub =>
      'उधार देने या लेने वाले व्यक्ति को जोड़ने के लिए + टैप करें';

  @override
  String get lended_owesYou => 'आप पर बकाया है';

  @override
  String get lended_youOwe => 'आप बकाया हैं';

  @override
  String get lended_settledUp => 'चुकता हो गया';

  @override
  String get lended_noActiveRecords => 'कोई सक्रिय रिकॉर्ड नहीं';

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
  String get lended_editPerson => 'व्यक्ति को संपादित करें';

  @override
  String get lended_addPerson => 'व्यक्ति जोड़ें';

  @override
  String get lended_name => 'नाम';

  @override
  String get lended_notesOptional => 'नोट्स (वैकल्पिक)';

  @override
  String get lended_saveChanges => 'परिवर्तन सहेजें';

  @override
  String get assets_totalAssets => 'कुल संपत्तियां';

  @override
  String get assets_items => 'आइटम';

  @override
  String get assets_noAssetsYet => 'अभी कोई संपत्तियां नहीं';

  @override
  String get assets_noAssetsYetSub =>
      'उत्पाद या संपत्ति जोड़ने के लिए + टैप करें';

  @override
  String get assets_editAsset => 'संपत्ति संपादित करें';

  @override
  String get assets_addAsset => 'संपत्ति जोड़ें';

  @override
  String get assets_productAssetName => 'उत्पाद / संपत्ति का नाम';

  @override
  String get assets_value => 'मूल्य';

  @override
  String get assets_notesOptional => 'नोट्स (वैकल्पिक)';

  @override
  String get assets_saveChanges => 'परिवर्तन सहेजें';

  @override
  String get currency_converter_loadingRates =>
      'विनिमय दरें लोड की जा रही हैं…';

  @override
  String get currency_converter_ratesUnavailable =>
      'विनिमय दरें अनुपलब्ध। इंटरनेट से कनेक्ट करें और सिंक करें।';

  @override
  String get currency_converter_rateAgeJustNow => 'अभी-अभी';

  @override
  String currency_converter_rateAgeMins(Object minutes) {
    return '$minutes मिनट पहले';
  }

  @override
  String currency_converter_rateAgeHours(Object hours) {
    return '$hours घंटे पहले';
  }

  @override
  String currency_converter_rateAgeDays(Object days) {
    return '$days दिन पहले';
  }

  @override
  String currency_converter_commonConversions(Object fromCurrency) {
    return '$fromCurrency से सामान्य रूपांतरण';
  }

  @override
  String transfer_fromAcc(Object currency) {
    return 'से ($currency)';
  }

  @override
  String transfer_toAcc(Object currency) {
    return 'में ($currency)';
  }

  @override
  String get transfer_exchangeRatesNotLoaded =>
      'विनिमय दरें लोड नहीं हुईं — राशि को ज्यों का त्यों स्थानांतरित किया जाएगा';

  @override
  String get transfer_amount => 'राशि';

  @override
  String get transfer_noteOptional => 'नोट (वैकल्पिक)';

  @override
  String get export_from => 'से';

  @override
  String get export_to => 'तक';

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
    return 'सहेजा गया: $path';
  }

  @override
  String get export_complete => 'निर्यात पूरा हुआ';

  @override
  String get export_exporting => 'निर्यात किया जा रहा है...';

  @override
  String get export_exportAsExcel => 'एक्सेल के रूप में निर्यात करें';

  @override
  String shared_widgets_deleteConfirm(Object name) {
    return '\"$name\" को हटाएं? इसे पूर्ववत नहीं किया जा सकता।';
  }

  @override
  String get shared_widgets_searchByCode => 'कोड या नाम से खोजें...';

  @override
  String get accounts_accounts => 'खाते';

  @override
  String get accounts_totalBalance => 'कुल शेष';

  @override
  String get accounts_excluded => 'बाहर रखा गया';

  @override
  String get accounts_goldPriceNotYetLoade =>
      'सोने की कीमत अभी लोड नहीं हुई है। एक पल रुकें और पुनः प्रयास करें।';

  @override
  String get accounts_accountType => 'खाता प्रकार';

  @override
  String get accounts_currency => 'मुद्रा';

  @override
  String get accounts_goldPurityKarat => 'सोने की शुद्धता (कैरेट)';

  @override
  String get accounts_weight => 'वजन';

  @override
  String get accounts_excludeFromTotalBala => 'कुल शेष से बाहर रखें';

  @override
  String get accounts_color => 'रंग';

  @override
  String get accounts_liveGoldValue => 'लाइव सोने का मूल्य';

  @override
  String get accounts_enterWeightAboveToSe =>
      'मूल्य देखने के लिए ऊपर वजन दर्ज करें';

  @override
  String get add_transaction_expense => 'खर्च';

  @override
  String get add_transaction_income => 'आय';

  @override
  String get add_transaction_account => 'खाता';

  @override
  String get add_transaction_category => 'श्रेणी';

  @override
  String get assets_assets => 'संपत्ति';

  @override
  String get backup_restoreBackup => 'बैकअप पुनर्स्थापित करें?';

  @override
  String get backup_cancel => 'रद्द करें';

  @override
  String get backup_replaceData => 'डेटा बदलें';

  @override
  String get backup_backupRestore => 'बैकअप और पुनर्स्थापना';

  @override
  String get backup_everythingAlways => 'सब कुछ, हमेशा';

  @override
  String get backup_createBackup => 'बैकअप बनाएं';

  @override
  String get backup_saveAsJson => 'JSON के रूप में सहेजें';

  @override
  String get backup_exportsAllAppDataToA =>
      'पोर्टेबल फ़ाइल में सभी ऐप डेटा निर्यात करता है';

  @override
  String get backup_restoreBackup_ => 'बैकअप पुनर्स्थापित करें';

  @override
  String get backup_loadFromJson => 'JSON से लोड करें';

  @override
  String get backup_picksABackupFileAndR =>
      'एक बैकअप फ़ाइल चुनता है और उसे पुनर्स्थापित करता है';

  @override
  String get backup_thisOverwritesAllCur =>
      'यह सभी वर्तमान डेटा को अधिलेखित कर देगा।';

  @override
  String get budget_budgets => 'बजट';

  @override
  String get budget_empty => '·';

  @override
  String get budget_overBudget => 'बजट से अधिक';

  @override
  String get budget_thisCategoryAlreadyH =>
      'इस श्रेणी में पहले से ही एक बजट है। संपादित करने के लिए टैप करें।';

  @override
  String get budget_period => 'अवधि';

  @override
  String get budget_monthly => 'मासिक';

  @override
  String get budget_weekly => 'साप्ताहिक';

  @override
  String get budget_category => 'श्रेणी';

  @override
  String get categories_categories => 'श्रेणियां';

  @override
  String get categories_expense => 'खर्च';

  @override
  String get categories_income => 'आय';

  @override
  String get categories_color => 'रंग';

  @override
  String get categories_icon => 'आइकन';

  @override
  String get categories_autoBasedOnName => 'ऑटो (नाम के आधार पर)';

  @override
  String get categories_expenseCategories => 'खर्च श्रेणियां';

  @override
  String get categories_incomeCategories => 'आय श्रेणियां';

  @override
  String get currency_converter_currencyConverter => 'मुद्रा परिवर्तक';

  @override
  String get currency_converter_amount => 'राशि';

  @override
  String get currency_converter_convertedTo => 'में परिवर्तित';

  @override
  String get export_exportTransactions => 'लेनदेन निर्यात करें';

  @override
  String get export_dateRange => 'तिथि सीमा';

  @override
  String get export_formatExcelXlsx => 'प्रारूप: Excel (.xlsx)';

  @override
  String get home_totalBalance => 'कुल शेष';

  @override
  String get home_accounts => 'खाते';

  @override
  String get home_recentTransactions => 'हाल के लेनदेन';

  @override
  String get home_noTransactionsYet => 'अभी तक कोई लेनदेन नहीं';

  @override
  String get home_add => 'जोड़ें';

  @override
  String get insights_insights => 'अंतर्दृष्टि';

  @override
  String get lended_person_deletePerson => 'व्यक्ति को हटाएं';

  @override
  String get lended_person_editPerson => 'व्यक्ति संपादित करें';

  @override
  String get lended_person_color => 'रंग';

  @override
  String get lended_person_saveChanges => 'परिवर्तन सहेजें';

  @override
  String get lended_person_settled => 'निपटाया गया';

  @override
  String get lended_person_settle => 'निपटान करें';

  @override
  String get lended_person_setADueDateFirstToEn =>
      'रिमाइंडर सक्षम करने के लिए पहले एक नियत तिथि निर्धारित करें।';

  @override
  String get lended_person_iLent => 'मैंने उधार दिया';

  @override
  String get lended_person_iBorrowed => 'मैंने उधार लिया';

  @override
  String get lended_person_accountOptional => 'खाता (वैकल्पिक)';

  @override
  String get lended_person_dueDateReminder => 'नियत तिथि रिमाइंडर';

  @override
  String get lended_person_remindMeAt => 'मुझे याद दिलाएं';

  @override
  String get lended_person_active => 'सक्रिय';

  @override
  String get lended_person_settled_ => 'निपटाया गया';

  @override
  String get lended_lentMoney => 'उधार दिया गया पैसा';

  @override
  String get lended_overdue => 'अतिदेय';

  @override
  String get lended_color => 'रंग';

  @override
  String get more_more => 'अधिक';

  @override
  String get onboarding_back => 'पीछे';

  @override
  String get onboarding_welcomeToExpensy => 'Expensy में आपका स्वागत है!';

  @override
  String get onboarding_restoreABackup => 'एक बैकअप पुनर्स्थापित करें';

  @override
  String get onboarding_loadAPreviouslySaved =>
      'पहले सहेजी गई Expensy JSON फ़ाइल लोड करें';

  @override
  String get onboarding_or => 'या';

  @override
  String get onboarding_startFresh => 'नई शुरुआत करें';

  @override
  String get onboarding_firstWhatShouldWeCal =>
      'सबसे पहले, हम आपको क्या बुलाएं?';

  @override
  String get onboarding_defaultCurrency => 'डिफ़ॉल्ट मुद्रा';

  @override
  String get onboarding_thisWillBeUsedAcross =>
      'इसका उपयोग पूरे ऐप में किया जाएगा।\nआप इसे बाद में सेटिंग्स में बदल सकते हैं।';

  @override
  String get onboarding_searchAllCurrencies => 'सभी मुद्राएं खोजें';

  @override
  String get onboarding_yourFirstAccount => 'आपका पहला खाता';

  @override
  String get onboarding_setUpYourMainAccount =>
      'ट्रैकिंग शुरू करने के लिए अपना मुख्य खाता सेट करें।';

  @override
  String get onboarding_accountType => 'खाता प्रकार';

  @override
  String get onboarding_currency => 'मुद्रा';

  @override
  String get onboarding_color => 'रंग';

  @override
  String get recurring_recurring => 'आवर्ती';

  @override
  String get recurring_income => 'आय';

  @override
  String get recurring_2D => '−2द';

  @override
  String get recurring_skipNextPayment => 'अगला भुगतान छोड़ें?';

  @override
  String get recurring_cancel => 'रद्द करें';

  @override
  String get recurring_skip => 'छोड़ें';

  @override
  String get recurring_noHistoryYet => 'अभी तक कोई इतिहास नहीं';

  @override
  String get recurring_expense => 'खर्च';

  @override
  String get recurring_income_ => 'आय';

  @override
  String get recurring_every => 'हर ';

  @override
  String get recurring_days => 'दिन';

  @override
  String get recurring_weeks => 'सप्ताह';

  @override
  String get recurring_months => 'महीने';

  @override
  String get recurring_years => 'साल';

  @override
  String get recurring_payments => 'भुगतान';

  @override
  String get recurring_totalCost => 'कुल लागत';

  @override
  String get recurring_account => 'खाता';

  @override
  String get recurring_category => 'श्रेणी';

  @override
  String get recurring_paymentReminder => 'भुगतान रिमाइंडर';

  @override
  String get recurring_notificationWillFire =>
      'इस समय अगली नियत तिथि पर अधिसूचना फायर होगी।';

  @override
  String get recurring_remind2DaysBefore => '2 दिन पहले याद दिलाएं';

  @override
  String get statistics_statistics => 'आंकड़े';

  @override
  String get statistics_expensesByCategory => 'श्रेणी के अनुसार खर्च';

  @override
  String get transactions_transactions => 'लेनदेन';

  @override
  String get transactions_settled => 'निपटाया गया';

  @override
  String get transfer_transfer => 'स्थानांतरण';

  @override
  String get transfer_from => 'से';

  @override
  String get transfer_to => 'तक';

  @override
  String get transfer_enterAnAmountToSeeTh =>
      'रूपांतरण देखने के लिए राशि दर्ज करें';

  @override
  String get wishlist_wishlist => 'इच्छा सूची';

  @override
  String get wishlist_priority => 'प्राथमिकता';

  @override
  String get shared_widgets_delete => 'हटाएं?';

  @override
  String get shared_widgets_cancel => 'रद्द करें';

  @override
  String get shared_widgets_delete_ => 'हटाएं';

  @override
  String get shared_widgets_none => 'कोई नहीं';

  @override
  String get shared_widgets_selectCurrency => 'मुद्रा चुनें';

  @override
  String get main_home => 'होम';

  @override
  String get main_transactions => 'लेन-देन';

  @override
  String get main_recurring => 'आवर्ती';

  @override
  String get main_accounts => 'खाते';

  @override
  String get main_budgets => 'बजट';

  @override
  String get main_more => 'अधिक';

  @override
  String get onboarding_chooseLanguage => 'भाषा चुनें';

  @override
  String get error_required => 'यह फ़ील्ड आवश्यक है';

  @override
  String recurring_subscriptions(Object count) {
    return 'सदस्यता ($count)';
  }

  @override
  String recurring_installments(Object count) {
    return 'किस्तें ($count)';
  }

  @override
  String get recurring_recurringType => 'आवर्ती प्रकार';

  @override
  String get recurring_subscription => 'सदस्यता';

  @override
  String get recurring_installment => 'किस्त';

  @override
  String get recurring_installmentsRequireEndDate =>
      'किस्तों की अंतिम भुगतान तिथि होनी चाहिए।';

  @override
  String get backup_importFromOtherApps => 'अन्य ऐप्स से आयात करें';

  @override
  String get backup_importDescription => 'समर्थित ऐप्स से डेटा आयात करें';

  @override
  String get backup_importFromGreenStash => 'GreenStash से आयात करें (.json)';

  @override
  String get backup_automaticBackup => 'स्वचालित बैकअप';

  @override
  String get backup_dailyAutoBackup => 'दैनिक ऑटो बैकअप';

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
  String get backup_changeTime => 'समय बदलें';

  @override
  String get backup_changeFolder => 'फ़ोल्डर बदलें';

  @override
  String get budget_budgetsAndGoals => 'बजट और लक्ष्य';

  @override
  String get onboarding_restoreGreenStash =>
      'ग्रीनस्टैश (.json) से पुनर्स्थापित करें';

  @override
  String get savings_goalNotFound => 'लक्ष्य नहीं मिला';

  @override
  String get savings_savedSoFar => 'अब तक सहेजा गया';

  @override
  String get savings_target => 'लक्ष्य';

  @override
  String savings_targetDate(String date) {
    return 'Target Date: $date';
  }

  @override
  String get savings_contribute => 'योगदान दें';

  @override
  String get savings_withdraw => 'वापस लेना';

  @override
  String get savings_noAccounts =>
      'कोई खाता उपलब्ध नहीं. कृपया पहले एक खाता जोड़ें.';

  @override
  String get settings_budgetAlerts => 'बजट अलर्ट';

  @override
  String get settings_budgetAlertsSub =>
      'बजट या लक्ष्य पूरा होने पर सूचित करें';

  @override
  String get settings_dailyReminder => 'दैनिक अनुस्मारक';

  @override
  String get settings_dailyReminderSub =>
      'प्रतिदिन लेन-देन लॉग करने की याद दिलाएँ';

  @override
  String get settings_reminderTime => 'अनुस्मारक समय';

  @override
  String get settings_hapticFeedback => 'हैप्टिक राय';

  @override
  String get settings_hapticFeedbackSub => 'बातचीत पर कंपन';

  @override
  String get savings_saveGoal => 'लक्ष्य सहेजें';

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
  String get more_yearlyAnalysis => 'वार्षिक विश्लेषण';

  @override
  String get more_yearlyAnalysisSub => 'माह-दर-माह कैश फ्लो पूर्वानुमान';

  @override
  String get yearly_title => 'वार्षिक विश्लेषण';

  @override
  String get yearly_recurringExp => 'आवर्ती खर्च';

  @override
  String get yearly_recurringInc => 'आवर्ती आय';

  @override
  String get yearly_loans => 'ऋण भुगतान';

  @override
  String get yearly_borrowed => 'देय ऋण';

  @override
  String get yearly_lentDue => 'प्राप्य धन';

  @override
  String get yearly_inflow => 'आवक';

  @override
  String get yearly_outflow => 'जावक';

  @override
  String get yearly_netFlow => 'शुद्ध प्रवाह';

  @override
  String get yearly_totalInflow => 'कुल आवक';

  @override
  String get yearly_totalOutflow => 'कुल जावक';

  @override
  String get yearly_netCashFlow => 'शुद्ध कैश फ्लो';

  @override
  String get yearly_noData => 'अभी तक कोई अनुमानित गतिविधि नहीं';

  @override
  String get yearly_noDataSub =>
      'पूर्वानुमान देखने के लिए आवर्ती भुगतान, ऋण या नियत तिथि वाले उधार जोड़ें';

  @override
  String get budget_addBudget => 'बजट जोड़ें';

  @override
  String get budget_addGoal => 'बचत लक्ष्य जोड़ें';

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
}
