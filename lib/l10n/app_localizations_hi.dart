// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Expensy';

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
  String get settings_accentColor => 'एक्सेंट रंग';

  @override
  String get settings_appFont => 'ऐप फ़ॉन्ट';

  @override
  String get settings_systemDefault => 'सिस्टम डिफ़ॉल्ट';

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
  String get settings_github => 'GitHub';

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
      other: '$count आइटम',
      one: '1 आइटम',
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
      other: '$count आइटम',
      one: '1 आइटम',
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
      other: '$count श्रेणियां',
      one: '1 श्रेणी',
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
      other: '$count सक्रिय रिकॉर्ड',
      one: '1 सक्रिय रिकॉर्ड',
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
      other: 'रेंज में $count लेन-देन',
      one: 'रेंज में 1 लेन-देन',
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
}
