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
  String get budget_leftToSpend => 'खर्च के लिए शेष';

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
  String get budget_rollover => 'रोलओवर (लिफाफा)';

  @override
  String get budget_rolloverDesc =>
      'अप्रयुक्त अधिशेष या घाटे को अगली अवधि में ले जाएं';

  @override
  String get budget_rolloverBadge => 'रोलओवर';

  @override
  String budget_base(Object amount) {
    return 'आधार: $amount';
  }

  @override
  String budget_rolloverFrom(Object period, Object amount) {
    return 'रोलओवर ($period): $amount';
  }

  @override
  String budget_totalAvailable(Object amount) {
    return 'कुल उपलब्ध: $amount';
  }

  @override
  String get budget_lastWeek => 'पिछला सप्ताह';

  @override
  String get pacing_dailyBudget => 'सुरक्षित दैनिक खर्च';

  @override
  String pacing_safeToSpend(Object amount, Object days) {
    return 'सुरक्षित खर्च: $amount/दिन ($days दिन शेष)';
  }

  @override
  String pacing_caution(Object amount) {
    return 'खर्च की गति तेज — $amount/दिन तक सीमित रखें';
  }

  @override
  String get pacing_overPaced =>
      'गति चेतावनी — बजट में रहने के लिए खर्च धीमा करें';

  @override
  String get pacing_budgetExhausted => 'बजट समाप्त — कोई दैनिक भत्ता शेष नहीं';

  @override
  String get pacing_onTrack => 'नियंत्रण में';

  @override
  String get pacing_fast => 'तेज गति';

  @override
  String get pacing_alert => 'गति चेतावनी';

  @override
  String pacing_daysLeft(Object days) {
    return '$days दिन शेष';
  }

  @override
  String get pacing_setBudgetPrompt =>
      'बजट सीमा निर्धारित करने के लिए टैप करें →';

  @override
  String get pacing_dailyAvgPace => 'दैनिक गति';

  @override
  String pacing_perDay(Object amount) {
    return '$amount / दिन';
  }

  @override
  String get calendar_title => 'वित्तीय कैलेंडर';

  @override
  String get calendar_subtitle => 'दैनिक खर्च हीटमैप और देय तिथियां';

  @override
  String calendar_zeroSpendDays(Object count) {
    return '$count शून्य-खर्च दिन';
  }

  @override
  String get calendar_zeroSpendDayTitle => 'शून्य-खर्च दिवस! 🎉';

  @override
  String get calendar_zeroSpendDayDesc =>
      'शानदार वित्तीय अनुशासन! आज कोई खर्च नहीं हुआ।';

  @override
  String get calendar_billsDue => 'देय बिल और सदस्यताएँ';

  @override
  String get calendar_loansDue => 'देय ऋण किश्तें';

  @override
  String get calendar_lendedDue => 'अपेक्षित पुनर्भुगतान';

  @override
  String calendar_dayTransactions(Object count) {
    return 'लेन-देन ($count)';
  }

  @override
  String get calendar_noActivity => 'इस तिथि पर कोई लेन-देन या देयता नहीं है';

  @override
  String get calendar_today => 'आज';

  @override
  String calendar_averageDaily(Object amount) {
    return 'दैनिक औसत: $amount';
  }

  @override
  String get wrapped_title => 'Expensy Wrapped';

  @override
  String wrapped_bannerTitle(Object month) {
    return 'आपका $month का रैप तैयार है!';
  }

  @override
  String get wrapped_bannerSub =>
      'अपनी मासिक वित्तीय कहानी देखने के लिए टैप करें';

  @override
  String get wrapped_theBigPicture => 'पूरी तस्वीर';

  @override
  String wrapped_howMoneyMoved(Object month) {
    return '$month में आपके पैसे का प्रवाह इस प्रकार रहा';
  }

  @override
  String get wrapped_totalInflow => 'कुल आय';

  @override
  String get wrapped_totalOutflow => 'कुल व्यय';

  @override
  String get wrapped_netSavings => 'शुद्ध बचत';

  @override
  String wrapped_savingsRate(Object rate) {
    return 'बचत दर: $rate%';
  }

  @override
  String get wrapped_topCategoryTitle => 'पैसा कहाँ खर्च हुआ?';

  @override
  String wrapped_topCategorySub(Object category) {
    return 'आपकी शीर्ष खर्च श्रेणी $category थी';
  }

  @override
  String wrapped_topCategoryShare(Object percent) {
    return 'आपके कुल खर्च का $percent%';
  }

  @override
  String get wrapped_biggestSplurgeTitle => 'सबसे बड़ा खर्च';

  @override
  String get wrapped_biggestSplurgeSub => 'महीने का आपका सबसे बड़ा खर्च';

  @override
  String get wrapped_noSplurge =>
      'कोई बड़ा खर्च नहीं! इस महीने आपका कोई खर्च नहीं था।';

  @override
  String get wrapped_heroHabitTitle => 'हीरो आदत';

  @override
  String wrapped_zeroSpendAchieved(Object count) {
    return '$count शून्य खर्च वाले दिन';
  }

  @override
  String wrapped_heroHabitDesc(Object count) {
    return 'आपने शून्य खर्च के साथ $count दिन हासिल किए। उत्कृष्ट वित्तीय अनुशासन!';
  }

  @override
  String get wrapped_receiptTitle => 'मासिक विवरण';

  @override
  String get wrapped_obscureToggle => 'साझा करने के लिए राशि छुपाएं';

  @override
  String get wrapped_showToggle => 'राशि दिखाएं';

  @override
  String get wrapped_replay => 'कहानी फिर से चलाएं';

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
  String get more_sectionTools => 'वित्तीय उपकरण';

  @override
  String get more_sectionAnalytics => 'विश्लेषण और अंतर्दृष्टि';

  @override
  String get more_sectionPreferences => 'प्राथमिकताएं और डेटा';

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
  String get wishlist_fundThisItem => 'फंड करें';

  @override
  String wishlist_funded(int percent, String saved, String target) {
    return '$percent% फंड हुआ ($saved / $target)';
  }

  @override
  String get wishlist_goalAchieved => 'लक्ष्य पूरा हुआ — खरीदने के लिए तैयार!';

  @override
  String get wishlist_buyNow => 'अभी खरीदें';

  @override
  String get wishlist_purchaseTitle => 'इच्छा सूची आइटम खरीदें';

  @override
  String get wishlist_purchasePrompt =>
      'क्या आप इस खरीदारी को खाते से घटाने के लिए व्यय लेनदेन दर्ज करना चाहते हैं?';

  @override
  String get wishlist_recordAndDeduct => 'दर्ज करें और काटें';

  @override
  String get wishlist_markPurchasedOnly => 'केवल खरीदा हुआ चिह्नित करें';

  @override
  String wishlist_itemPurchased(String name) {
    return '\"$name\" को खरीदा हुआ चिह्नित किया गया!';
  }

  @override
  String get wishlist_viewGoal => 'बचत लक्ष्य देखें';

  @override
  String savings_linkedWishlist(String item) {
    return 'इच्छा सूची से जुड़ा: $item';
  }

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
  String get accounts_dontLinkToCard => 'कार्ड से लिंक न करें';

  @override
  String get accounts_dontLinkToCardDesc =>
      'इस खाते की शेष राशि मैन्युअल रूप से प्रबंधित करें और कार्ड को लिंक होने से रोकें';

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
  String get export_exportAsPdf => 'PDF रिपोर्ट के रूप में निर्यात करें';

  @override
  String get export_formatPdf => 'प्रारूप: PDF वित्तीय रिपोर्ट (.pdf)';

  @override
  String get export_pdfGenerating => 'PDF तैयार किया जा रहा है...';

  @override
  String get export_pdfTitle => 'वित्तीय रिपोर्ट';

  @override
  String get export_pdfSummary => 'कार्यकारी सारांश';

  @override
  String get export_pdfInflow => 'कुल आय';

  @override
  String get export_pdfOutflow => 'कुल व्यय';

  @override
  String get export_pdfNet => 'शुद्ध बचत';

  @override
  String get export_pdfSavingsRate => 'बचत दर';

  @override
  String get export_pdfCategoryBreakdown => 'श्रेणीवार विवरण';

  @override
  String get export_pdfTransactions => 'विस्तृत लेनदेन';

  @override
  String get export_pdfNetWorthBreakdown => 'परिसंपत्तियां और देनदारियां';

  @override
  String get export_pdfShare => 'रिपोर्ट साझा करें';

  @override
  String get export_pdfPrint => 'प्रिंट / पूर्वावलोकन';

  @override
  String get export_pdfGeneratedBy =>
      'Expensy द्वारा निर्मित • निजी और ऑफ़लाइन';

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
  String get home_goodMorning => 'शुभ प्रभात';

  @override
  String get home_goodAfternoon => 'शुभ दोपहर';

  @override
  String get home_goodEvening => 'शुभ संध्या';

  @override
  String get home_transferAction => 'स्थानांतरण';

  @override
  String get home_insightsAction => 'इनसाइट्स';

  @override
  String get home_calendarAction => 'कैलेंडर';

  @override
  String get home_forecastAction => 'पूर्वानुमान';

  @override
  String get home_manage => 'प्रबंधित करें';

  @override
  String get home_seeAll => 'सभी देखें';

  @override
  String get home_addAccount => 'खाता जोड़ें';

  @override
  String get home_monthlyOverview => 'मासिक अवलोकन';

  @override
  String get home_savingsRate => 'बचत दर';

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
  String get more_loans => 'ऋण';

  @override
  String more_loansSub(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count सक्रिय ऋण',
      one: '1 सक्रिय ऋण',
    );
    return '$_temp0';
  }

  @override
  String get loans_title => 'ऋण';

  @override
  String get loans_addLoan => 'ऋण जोड़ें';

  @override
  String get loans_editLoan => 'ऋण संपादित करें';

  @override
  String get loans_loanName => 'ऋण का नाम';

  @override
  String get loans_amount => 'राशि';

  @override
  String get loans_startDate => 'प्रारंभ तिथि';

  @override
  String get loans_endDate => 'समाप्ति तिथि';

  @override
  String get loans_interestRateOptional => 'ब्याज दर (वैकल्पिक)';

  @override
  String get loans_account => 'लिंक किया गया खाता';

  @override
  String get loans_monthlyPayment => 'मासिक किस्त';

  @override
  String get loans_totalPayable => 'कुल देय राशि';

  @override
  String get loans_remaining => 'शेष';

  @override
  String get loans_paid => 'भुगतान किया गया';

  @override
  String get loans_logPayment => 'भुगतान दर्ज करें';

  @override
  String get loans_paymentReminder => 'भुगतान अनुस्मारक';

  @override
  String get loans_reminderDay => 'अनुस्मारक दिन';

  @override
  String get loans_notes => 'नोट्स';

  @override
  String get loans_saveLoan => 'ऋण सहेजें';

  @override
  String get loans_deleteLoan => 'ऋण हटाएं';

  @override
  String get loans_settled => 'चुकता';

  @override
  String loans_durationMonths(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count महीने',
      one: '1 महीना',
    );
    return '$_temp0';
  }

  @override
  String get loans_paymentHistory => 'भुगतान इतिहास';

  @override
  String get loans_noPayments => 'अभी तक कोई भुगतान दर्ज नहीं किया गया';

  @override
  String get loans_outstandingDebt => 'बकाया ऋण';

  @override
  String get loans_monthlyObligation => 'मासिक दायित्व';

  @override
  String get insights_loans => 'ऋण';

  @override
  String get backup_loans => 'ऋण';

  @override
  String get backup_loanPayments => 'ऋण भुगतान';

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
  String get add_transaction_possibleDuplicate => 'संभावित डुप्लिकेट';

  @override
  String get add_transaction_goBack => 'वापस जाएं';

  @override
  String get add_transaction_saveAnyway => 'फिर भी सहेजें';

  @override
  String get loans_confirmDeleteLoan =>
      'क्या आप वाकई इस ऋण और इसके सभी भुगतानों को हटाना चाहते हैं?';

  @override
  String get loans_deletePayment => 'भुगतान हटाएं';

  @override
  String get loans_confirmDeletePayment =>
      'क्या आप वाकई इस भुगतान रिकॉर्ड को हटाना चाहते हैं?';

  @override
  String get split_transactions_title => 'श्रेणियां विभाजित करें';

  @override
  String get split_transactions_badge => 'विभाजित';

  @override
  String get split_transactions_addSplit => 'विभाजन जोड़ें';

  @override
  String get split_transactions_removeSplit => 'विभाजन हटाएं';

  @override
  String get split_transactions_allocated => 'आवंटित';

  @override
  String get split_transactions_remaining => 'शेष';

  @override
  String get split_transactions_fillRemaining => 'शेष भरें';

  @override
  String get split_transactions_breakdown => 'विभाजन विवरण';

  @override
  String get split_transactions_mismatchError =>
      'विभाजन राशि कुल राशि के बराबर होनी चाहिए।';

  @override
  String get netWorth_title => 'कुल संपत्ति';

  @override
  String get netWorth_subtitle =>
      'समय के साथ कुल संपत्ति, देनदारियों और संपत्ति को ट्रैक करें';

  @override
  String get netWorth_current => 'वर्तमान कुल संपत्ति';

  @override
  String get netWorth_trend => 'कुल संपत्ति का रुझान';

  @override
  String get netWorth_totalAssets => 'कुल संपत्ति';

  @override
  String get netWorth_totalLiabilities => 'कुल देनदारियां';

  @override
  String get netWorth_liquidCash => 'नकद और बैंक खाते';

  @override
  String get netWorth_goldValuation => 'भौतिक सोना';

  @override
  String get netWorth_fixedAssets => 'संपत्ति और निवेश';

  @override
  String get netWorth_moneyLent => 'उधार दिया गया धन (प्राप्य)';

  @override
  String get netWorth_creditDebt => 'क्रेडिट कार्ड और ओवरड्राफ्ट';

  @override
  String get netWorth_loanDebt => 'देय ऋण';

  @override
  String get netWorth_moneyBorrowed => 'उधार लिया गया धन (देय)';

  @override
  String get netWorth_assetBreakdown => 'संपत्ति का विवरण';

  @override
  String get netWorth_liabilityBreakdown => 'देनदारियों का विवरण';

  @override
  String get netWorth_noHistory =>
      'दैनिक स्नैपशॉट रिकॉर्ड होने पर कुल संपत्ति का इतिहास स्वतः बन जाएगा।';

  @override
  String get netWorth_debtRatio => 'ऋण अनुपात';

  @override
  String get netWorth_quickActions => 'त्वरित कार्रवाई';

  @override
  String get netWorth_history => 'स्नैपशॉट इतिहास';

  @override
  String get creditCard_utilization => 'क्रेडिट उपयोग';

  @override
  String get creditCard_availableCredit => 'उपलब्ध';

  @override
  String get creditCard_limit => 'सीमा';

  @override
  String get creditCard_statementBalance => 'स्टेटमेंट शेष';

  @override
  String get creditCard_unbilledBalance => 'गैर-बिलित शेष';

  @override
  String get creditCard_payBill => 'कार्ड बिल का भुगतान करें';

  @override
  String get creditCard_allCaughtUp => 'सब चुकता है! कोई देय राशि नहीं';

  @override
  String get creditCard_payBillTitle => 'क्रेडिट कार्ड बिल भरें';

  @override
  String get creditCard_payFromAccount => 'खाते से भुगतान करें';

  @override
  String get creditCard_paymentAmount => 'भुगतान राशि';

  @override
  String get creditCard_fullStatement => 'स्टेटमेंट शेष';

  @override
  String get creditCard_fullBalance => 'कुल शेष';

  @override
  String get creditCard_minPayment => 'न्यूनतम भुगतान';

  @override
  String get creditCard_customAmount => 'कस्टम राशि';

  @override
  String creditCard_paymentSuccess(String amount, String cardName) {
    return '$cardName को $amount का भुगतान किया गया';
  }

  @override
  String get creditCard_insufficientFunds => 'राशि उपलब्ध शेष से अधिक है';

  @override
  String get creditCard_invalidAmount => 'कृपया एक मान्य भुगतान राशि दर्ज करें';

  @override
  String get onboarding_skipForNow => 'अभी के लिए छोड़ें';

  @override
  String get onboarding_addCard => 'कार्ड जोड़ें';

  @override
  String get onboarding_skipCardDesc =>
      'यदि आप अभी कार्ड नहीं जोड़ना चाहते हैं तो इसे छोड़ सकते हैं।';

  @override
  String get onboarding_cardNameLabel => 'कार्ड का नाम (उदा. वीजा प्लेटिनम)';

  @override
  String get onboarding_debitCard => 'डेबिट कार्ड';

  @override
  String get onboarding_creditLimit => 'क्रेडिट सीमा';

  @override
  String get onboarding_amountUsed => 'उपयोग की गई राशि';

  @override
  String get accounts_cardHolderOptional => 'कार्डधारक का नाम (वैकल्पिक)';

  @override
  String get accounts_last4Digits => 'अंतिम 4 अंक';

  @override
  String get accounts_expiryDate => 'समाप्ति तिथि (MM/YY)';

  @override
  String get accounts_creditLimitOptional => 'क्रेडिट सीमा (वैकल्पिक)';

  @override
  String get accounts_minPaymentOptional => 'न्यूनतम भुगतान (वैकल्पिक)';

  @override
  String get accounts_statementDayOptional => 'स्टेटमेंट दिन (वैकल्पिक)';

  @override
  String get accounts_statementDayExample => 'उदा. 20';

  @override
  String get accounts_dueDayOptional => 'नियत दिन (वैकल्पिक)';

  @override
  String get accounts_dueDayExample => 'उदा. 10';

  @override
  String get accounts_linkedAccountOptional =>
      'लिंक किया गया बैंक खाता (वैकल्पिक)';

  @override
  String get accounts_excludeCardBalance =>
      'खाता शेष से कार्ड शेष को बाहर रखें';

  @override
  String get accounts_excludeCardBalanceDesc =>
      'इस कार्ड का शेष लिंक किए गए बैंक खाते में नहीं जोड़ा जाएगा।';

  @override
  String get accounts_cardHolderHeader => 'कार्ड धारक';

  @override
  String get accounts_expHeader => 'समाप्ति';

  @override
  String get accounts_notifyOnDueDate => 'आपको नियत तिथि पर सूचित किया जाएगा';

  @override
  String get accounts_notifyWhenDue => 'भुगतान देय होने पर सूचना प्राप्त करें';

  @override
  String get accounts_remind2DaysBeforeDesc =>
      'नियत तिथि से 2 दिन पहले अग्रिम सूचना प्राप्त करें';

  @override
  String get accounts_targetSaved => 'लक्ष्य / सहेजा गया';

  @override
  String transactions_selectedCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count चयनित',
      one: '1 चयनित',
    );
    return '$_temp0';
  }

  @override
  String get transactions_changeCategory => 'श्रेणी बदलें';

  @override
  String get transactions_deleteSelected => 'चयनित हटाएं';

  @override
  String get transactions_advancedFilters => 'उन्नत फ़िल्टर';

  @override
  String get transactions_clearAll => 'सभी साफ़ करें';

  @override
  String get transactions_amountRange => 'राशि सीमा';

  @override
  String get transactions_minAmount => 'न्यूनतम राशि';

  @override
  String get transactions_maxAmount => 'अधिकतम राशि';

  @override
  String get transactions_applyFilters => 'फ़िल्टर लागू करें';

  @override
  String get presets_new => 'नया';

  @override
  String get presets_presetName => 'प्रीसेट नाम (उदा. सुबह की कॉफी)';

  @override
  String get presets_defaultAmount => 'डिफ़ॉल्ट राशि';

  @override
  String get savings_goalName => 'लक्ष्य का नाम';

  @override
  String get savings_goalNameHint => 'उदा. नई कार, छुट्टियां';

  @override
  String get savings_targetAmount => 'लक्ष्य राशि';

  @override
  String get savings_targetDateOptional => 'लक्ष्य तिथि (वैकल्पिक)';

  @override
  String get savings_selectDate => 'तिथि चुनें';

  @override
  String get savings_amountRequired => 'राशि आवश्यक है';

  @override
  String get savings_noteOptional => 'नोट (वैकल्पिक)';

  @override
  String get loans_skipInstallment => 'अगली ऋण किस्त छोड़ें?';

  @override
  String get recurring_confirmDelete =>
      'क्या आप वाकई इस आवर्ती भुगतान को हटाना चाहते हैं?';

  @override
  String get export_formatExcelOption => 'Excel (.xlsx)';

  @override
  String get export_formatPdfOption => 'PDF रिपोर्ट';

  @override
  String get export_pdfNoTransactions =>
      'इस तिथि सीमा के भीतर कोई लेनदेन दर्ज नहीं किया गया।';

  @override
  String get savings_saved => 'बचत की गई';

  @override
  String get export_pdfDate => 'दिनांक';

  @override
  String get export_pdfDescription => 'विवरण';

  @override
  String get accounts_noCardsYet => 'कोई कार्ड नहीं';

  @override
  String get accounts_tapToAddCard =>
      'अपना पहला कार्ड जोड़ने के लिए + पर टैप करें';

  @override
  String get savings_noGoalsYet => 'कोई बचत लक्ष्य नहीं';

  @override
  String get savings_tapToAddGoal =>
      'नया लक्ष्य निर्धारित करने के लिए + पर टैप करें';

  @override
  String get netWorth_recordSnapshot => 'स्नैपशॉट रिकॉर्ड करें';

  @override
  String get netWorth_snapshotRecorded => 'स्नैपशॉट रिकॉर्ड किया गया';

  @override
  String get savings_noContributionsYet => 'अभी तक कोई योगदान नहीं';

  @override
  String get creditCard_closesStatementBillingCycle =>
      'वर्तमान विवरण बिलिंग चक्र बंद करता है';

  @override
  String get creditCard_clearsTotalDebt => 'कार्ड का कुल ऋण पूरी तरह चुकाता है';

  @override
  String get creditCard_requiredMinPayment => 'न्यूनतम आवश्यक भुगतान';

  @override
  String get creditCard_specifyCustomAmount =>
      'कस्टम भुगतान राशि निर्दिष्ट करें';

  @override
  String common_itemDeleted(String name) {
    return '\"$name\" हटा दिया गया';
  }

  @override
  String get common_accountDeleted => 'खाता हटा दिया गया';

  @override
  String get common_cardDeleted => 'कार्ड हटा दिया गया';

  @override
  String get common_transactionDeleted => 'लेन-देन हटा दिया गया';

  @override
  String get common_recordDeleted => 'रिकॉर्ड हटा दिया गया';

  @override
  String get common_paymentDeleted => 'भुगतान हटा दिया गया';

  @override
  String get loans_skippedInstallment => 'ऋण किस्त छोड़ दी गई';

  @override
  String loans_loggedPayment(String amount) {
    return '$amount का भुगतान दर्ज किया गया';
  }

  @override
  String get loans_notificationsPermissionRequired => 'सूचना अनुमति आवश्यक है';

  @override
  String get creditCard_selectFundingAccount => 'कृपया एक फंडिंग खाता चुनें';

  @override
  String get presets_presetUpdated => 'प्रीसेट अपडेट किया गया';

  @override
  String get presets_presetAdded => 'प्रीसेट जोड़ा गया';

  @override
  String get presets_presetDeleted => 'प्रीसेट हटा दिया गया';

  @override
  String transactions_deletedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count आइटम हटाए गए',
      one: '1 आइटम हटाया गया',
    );
    return '$_temp0';
  }

  @override
  String get split_atLeastTwoCategories =>
      'विभाजन के लिए कम से कम 2 श्रेणियां आवश्यक हैं।';

  @override
  String get split_categoryAndAmountRequired =>
      'प्रत्येक विभाजित मद में एक श्रेणी और राशि > 0 होनी चाहिए।';

  @override
  String get presets_addQuickPresets => '1-टैप त्वरित प्रीसेट जोड़ें';

  @override
  String get presets_quickPresetsDesc =>
      'एक टैप से लगातार कॉफी, यात्रा या भोजन व्यय दर्ज करें';

  @override
  String presets_loggedPreset(String title, String amount) {
    return '$title ($amount) दर्ज किया गया';
  }

  @override
  String get presets_createPreset => 'प्रीसेट बनाएं';

  @override
  String get presets_editQuickPreset => 'त्वरित प्रीसेट संपादित करें';

  @override
  String get presets_newQuickPreset => 'नया त्वरित प्रीसेट';

  @override
  String get savings_addContribution => 'योगदान जोड़ें';

  @override
  String get savings_withdrawFromGoal => 'लक्ष्य से निकालें';

  @override
  String get savings_contribution => 'योगदान';

  @override
  String get savings_withdrawal => 'निकासी';

  @override
  String get savings_unknownAccount => 'अज्ञात खाता';

  @override
  String get savings_fromAccount => 'खाते से';

  @override
  String get savings_toAccount => 'खाते में';

  @override
  String get presets_quickLog => 'त्वरित लॉग';

  @override
  String accounts_dueOnDay(int day) {
    return '$day को देय';
  }
}
