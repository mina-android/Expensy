// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'نفقة';

  @override
  String get settings_title => 'الإعدادات';

  @override
  String get settings_appearance => 'المظهر';

  @override
  String get settings_theme => 'السمة';

  @override
  String get settings_system => 'النظام';

  @override
  String get settings_light => 'فاتح';

  @override
  String get settings_dark => 'داكن';

  @override
  String get settings_amoledTitle => 'أسود نقي (AMOLED)';

  @override
  String get settings_amoledSubtitle => 'فرض خلفيات سوداء في الوضع الداكن';

  @override
  String get settings_systemDefault => 'الافتراضي للنظام';

  @override
  String get settings_dynamicColor => 'اللون الديناميكي';

  @override
  String get settings_dynamicColorSubtitle => 'استخدام ألوان خلفية النظام';

  @override
  String get settings_accentColor => 'لون التمييز';

  @override
  String get settings_accentColorSubtitle => 'اختر اللون الأساسي للتطبيق';

  @override
  String get settings_appFont => 'خط التطبيق';

  @override
  String get settings_currency => 'العملة';

  @override
  String get settings_defaultCurrency => 'العملة الافتراضية';

  @override
  String get settings_preferences => 'التفضيلات';

  @override
  String get settings_weekStartsOn => 'يبدأ الأسبوع في';

  @override
  String get settings_monday => 'الاثنين';

  @override
  String get settings_sunday => 'الأحد';

  @override
  String get settings_hideBalance => 'إخفاء الرصيد';

  @override
  String get settings_hideBalanceSubtitle => 'إظهار ••••• بدلاً من المبالغ';

  @override
  String get settings_language => 'اللغة';

  @override
  String get settings_profile => 'الملف الشخصي';

  @override
  String get settings_displayName => 'اسم العرض';

  @override
  String get settings_notSet => 'لم يتم التعيين';

  @override
  String get settings_about => 'حول';

  @override
  String get settings_version => 'الإصدار';

  @override
  String get settings_privacy => 'الخصوصية';

  @override
  String get settings_privacySubtitle =>
      'يتم تخزين جميع البيانات محليًا — 100% بدون إنترنت';

  @override
  String get settings_github => 'جيثب';

  @override
  String get settings_githubSubtitle => 'عرض الكود المصدري';

  @override
  String get settings_developer => 'المطور';

  @override
  String get settings_developerSubtitle =>
      'اكتشف المزيد من المشاريع بواسطة Mina Android';

  @override
  String get settings_githubProfile => 'ملف GitHub';

  @override
  String get settings_developerWebsite => 'موقع المطور';

  @override
  String get settings_close => 'إغلاق';

  @override
  String get settings_yourName => 'اسمك';

  @override
  String get settings_cancel => 'إلغاء';

  @override
  String get settings_save => 'حفظ';

  @override
  String recurring_expenses(Object count) {
    return 'المصروفات ($count)';
  }

  @override
  String recurring_incomeList(Object count) {
    return 'الدخل ($count)';
  }

  @override
  String get recurring_monthly => 'شهرياً';

  @override
  String get recurring_weekly => 'أسبوعياً';

  @override
  String get recurring_noRecurringExpenses => 'لا توجد مصروفات متكررة';

  @override
  String get recurring_noRecurringIncome => 'لا يوجد دخل متكرر';

  @override
  String get recurring_addExpense => 'إضافة مصروف';

  @override
  String get recurring_addIncome => 'إضافة دخل';

  @override
  String get recurring_tapPlusToAddOne => 'انقر على + لإضافة واحد';

  @override
  String recurring_fromOngoing(Object date) {
    return 'من $date · مستمر';
  }

  @override
  String recurring_paidPayments(Object paid, Object total) {
    return 'تَمَّ سداد $paid/$total';
  }

  @override
  String recurring_totalAmount(Object amount) {
    return 'الإجمالي: $amount';
  }

  @override
  String get recurring_overdue => 'متأخر!';

  @override
  String get recurring_dueToday => 'مستحق اليوم';

  @override
  String recurring_dueInDays(Object days) {
    return 'مستحق خلال $days أيام';
  }

  @override
  String get recurring_edit => 'تعديل';

  @override
  String get recurring_skipBtn => 'تخطي';

  @override
  String recurring_nextDate(Object date) {
    return 'التالي: $date';
  }

  @override
  String get recurring_pay => 'دفع';

  @override
  String get recurring_del => 'حذف';

  @override
  String recurring_historyCount(Object count) {
    return 'السجل ($count)';
  }

  @override
  String get recurring_paymentHistory => 'سجل الدفعات';

  @override
  String get recurring_notificationPermissionDenied =>
      'تم رفض إذن الإشعارات. قم بتمكينه في الإعدادات → التطبيقات → Expensy → الإشعارات.';

  @override
  String get recurring_remindMeAt => 'ذكرني في';

  @override
  String get recurring_editRecurring => 'تعديل المتكرر';

  @override
  String get recurring_addRecurring => 'إضافة دفعة متكررة';

  @override
  String get recurring_name => 'الاسم';

  @override
  String get recurring_amountPerPayment => 'المبلغ لكل دفعة';

  @override
  String recurring_firstDate(Object date) {
    return 'الأول: $date';
  }

  @override
  String recurring_lastDate(Object date) {
    return 'الأخير: $date';
  }

  @override
  String get recurring_noLastPaymentOngoing => 'لا توجد دفعة أخيرة (مستمر)';

  @override
  String get accounts_refreshExchangeRates => 'تحديث أسعار الصرف';

  @override
  String get accounts_noAccounts => 'لا توجد حسابات';

  @override
  String get accounts_tapPlusToAddYourFirst => 'انقر على + لإضافة حسابك الأول';

  @override
  String get accounts_fetchingExchangeRates => 'جاري جلب أسعار الصرف...';

  @override
  String get accounts_exchangeRatesUnavailable =>
      'أسعار الصرف غير متوفرة (غير متصل). تُعرض الأرصدة بالعملة المحلية.';

  @override
  String get accounts_unknown => 'غير معروف';

  @override
  String accounts_ratesUpdated(Object timeStr) {
    return 'تم تحديث الأسعار $timeStr · انقر ↺ للتحديث';
  }

  @override
  String get accounts_goldCaps => 'ذهب';

  @override
  String get accounts_balance => 'الرصيد';

  @override
  String get accounts_income => 'الدخل';

  @override
  String get accounts_expense => 'المصروفات';

  @override
  String get accounts_txs => 'المعاملات';

  @override
  String get accounts_value => 'القيمة';

  @override
  String get accounts_karat => 'عيار';

  @override
  String accounts_pure(Object percentage) {
    return 'نقي بنسبة $percentage%';
  }

  @override
  String get accounts_weightLabel => 'الوزن';

  @override
  String get accounts_perGram => 'لكل جرام';

  @override
  String get accounts_bank => 'بنك';

  @override
  String get accounts_cash => 'نقدي';

  @override
  String get accounts_savings => 'مدخرات';

  @override
  String get accounts_creditCard => 'بطاقة ائتمان';

  @override
  String get accounts_eWallet => 'محفظة إلكترونية';

  @override
  String get accounts_gold => 'ذهب';

  @override
  String get accounts_editAccount => 'تعديل الحساب';

  @override
  String get accounts_addAccount => 'إضافة حساب جديد';

  @override
  String get accounts_accountName => 'اسم الحساب';

  @override
  String get accounts_weightInGrams => 'الوزن بالجرام';

  @override
  String get accounts_initialBalance => 'الرصيد الافتتاحي';

  @override
  String get accounts_wontCountTowardYourHome =>
      'لن يُحسب ضمن إجمالي الشاشة الرئيسية';

  @override
  String get accounts_saveChanges => 'حفظ التغييرات';

  @override
  String get accounts_addAccountBtn => 'إضافة حساب';

  @override
  String get accounts_fetchingGoldPrice => 'جاري جلب سعر الذهب...';

  @override
  String get accounts_goldPriceUnavailable =>
      'سعر الذهب غير متوفر — تحقق من اتصالك';

  @override
  String lended_person_owesYou(Object name) {
    return '$name مدين لك';
  }

  @override
  String lended_person_youOwe(Object name) {
    return 'أنت مدين لـ $name';
  }

  @override
  String get lended_person_allSettledUp => 'سُددت بالكامل';

  @override
  String get lended_person_noRecordsYet => 'لا توجد سجلات بعد';

  @override
  String get lended_person_tapPlusToLog =>
      'انقر على + لتسجيل الأموال التي أقرضتها أو اقترضتها';

  @override
  String get lended_person_name => 'الاسم';

  @override
  String get lended_person_notesOptional => 'ملاحظات (اختياري)';

  @override
  String get lended_person_lent => 'أقرضت';

  @override
  String get lended_person_borrowed => 'اقترضت';

  @override
  String get lended_person_overdue => 'متأخر!';

  @override
  String lended_person_due(Object date) {
    return 'مستحق في $date';
  }

  @override
  String lended_person_reminderAt(Object time) {
    return 'تذكير في $time';
  }

  @override
  String get lended_person_notificationPermissionDenied =>
      'تم رفض إذن الإشعارات. قم بتمكينه في الإعدادات → التطبيقات → Expensy → الإشعارات.';

  @override
  String get lended_person_remindMeAtPrompt => 'ذكرني في';

  @override
  String get lended_person_editRecord => 'تعديل السجل';

  @override
  String get lended_person_addRecord => 'إضافة سجل';

  @override
  String get lended_person_amount => 'المبلغ';

  @override
  String lended_person_dueColon(Object date) {
    return 'الاستحقاق: $date';
  }

  @override
  String get lended_person_noDueDate => 'لا يوجد تاريخ استحقاق';

  @override
  String get lended_person_setDueFirst => 'قم بتعيين تاريخ استحقاق أولاً';

  @override
  String get lended_person_notifiedOnDue => 'سيتم إعلامك في تاريخ الاستحقاق';

  @override
  String get lended_person_getNotifiedWhenDue => 'احصل على إشعار عند الاستحقاق';

  @override
  String get lended_person_thatTimePassed =>
      'لقد مر هذا الوقت اليوم — سيتم إعلامك قريبًا بدلاً من ذلك.';

  @override
  String lended_person_notificationFiresOn(Object date, Object time) {
    return 'يتم إطلاق الإشعار في $date الساعة $time.';
  }

  @override
  String get lended_person_saveChangesBtn => 'حفظ التغييرات';

  @override
  String get lended_person_addRecordBtn => 'إضافة سجل';

  @override
  String get transactions_searchTransactions => 'البحث في المعاملات...';

  @override
  String get transactions_all => 'الكل';

  @override
  String get transactions_income => 'الدخل';

  @override
  String get transactions_expenses => 'المصروفات';

  @override
  String get transactions_lent => 'أقرضت';

  @override
  String get transactions_borrowed => 'اقترضت';

  @override
  String get transactions_noTransactions => 'لا توجد معاملات';

  @override
  String get transactions_tapPlusToAddOne => 'انقر على + لإضافة واحدة';

  @override
  String get transactions_today => 'اليوم';

  @override
  String get transactions_yesterday => 'أمس';

  @override
  String transactions_lentTo(Object name) {
    return 'أقرضت إلى $name';
  }

  @override
  String transactions_borrowedFrom(Object name) {
    return 'اقترضت من $name';
  }

  @override
  String get transactions_unknown => 'غير معروف';

  @override
  String transactions_due(Object date) {
    return 'مستحق في $date';
  }

  @override
  String get transactions_unsettled => 'غير مُسَوّى';

  @override
  String get onboarding_restoreFailed =>
      'فشلت الاستعادة: قد يكون الملف تالفًا أو ليس نسخة احتياطية من Expensy.';

  @override
  String get onboarding_continue => 'متابعة';

  @override
  String get onboarding_getStarted => 'البدء';

  @override
  String get onboarding_yourPersonalTracker =>
      'متتبع أموالك الشخصي وبدون إنترنت بنسبة 100%.\nهل لديك بالفعل نسخة احتياطية من جهاز آخر أو تثبيت سابق؟';

  @override
  String get onboarding_restoring => 'جاري الاستعادة...';

  @override
  String get onboarding_chooseBackupFile => 'اختيار ملف النسخ الاحتياطي';

  @override
  String get onboarding_letsGetYouSetUp => 'لنقم بإعداد حسابك';

  @override
  String get onboarding_yourName => 'اسمك';

  @override
  String get onboarding_accountName => 'اسم الحساب';

  @override
  String get onboarding_bank => 'بنك';

  @override
  String get onboarding_cash => 'نقدي';

  @override
  String get onboarding_savings => 'مدخرات';

  @override
  String get onboarding_credit => 'ائتمان';

  @override
  String get onboarding_wallet => 'محفظة';

  @override
  String get onboarding_startingBalance => 'الرصيد الافتتاحي';

  @override
  String get backup_replaceDataWarning =>
      'سيؤدي هذا إلى استبدال كافة بياناتك الحالية بالنسخة الاحتياطية.\nلا يمكن التراجع عن هذا الإجراء.';

  @override
  String get backup_whatsIncluded => 'ما الذي يتضمنه';

  @override
  String get backup_backupDescription =>
      'تتضمن كل نسخة احتياطية جميع بياناتك — الحسابات، المعاملات، الدفعات المتكررة وسجل الدفع/التخطي الخاص بها، الميزانيات، عناصر قائمة الرغبات، الأشخاص والسجلات الخاصة بالإقراض والاقتراض، الأصول، الفئات، وإعدادات التطبيق.';

  @override
  String get backup_saving => 'جاري الحفظ...';

  @override
  String get backup_saveBackup => 'حفظ نسخة احتياطية';

  @override
  String get backup_restoring => 'جاري الاستعادة...';

  @override
  String get backup_restoreBackupBtn => 'استعادة نسخة احتياطية';

  @override
  String get backup_restoreWarningText =>
      'متوافق مع النسخ الاحتياطية من أي إصدار للتطبيق. يتم ملء الحقول المفقودة بالقيم الافتراضية الآمنة.';

  @override
  String get backup_included => 'مشمول';

  @override
  String get backup_accounts => 'الحسابات';

  @override
  String get backup_transactions => 'المعاملات';

  @override
  String get backup_recurringPayments => 'الدفعات المتكررة';

  @override
  String get backup_recurringHistory => 'سجل التكرار';

  @override
  String get backup_budgets => 'الميزانيات';

  @override
  String get backup_wishlist => 'قائمة الرغبات';

  @override
  String get backup_lentPeople => 'الأشخاص — الإقراض/الاقتراض';

  @override
  String get backup_lentRecords => 'السجلات — الإقراض/الاقتراض';

  @override
  String get backup_assets => 'الأصول';

  @override
  String get backup_categories => 'الفئات';

  @override
  String get backup_settings => 'الإعدادات';

  @override
  String backup_backupSavedSuccessfully(Object savedPath) {
    return 'تم حفظ النسخة الاحتياطية بنجاح:\n$savedPath';
  }

  @override
  String backup_backupFailed(Object error) {
    return 'فشل النسخ الاحتياطي: $error';
  }

  @override
  String backup_upgradedFrom(Object originalVersion, Object schemaVersion) {
    return ' (تم الترقية من v$originalVersion → v$schemaVersion)';
  }

  @override
  String backup_dataRestoredSuccessfully(Object vLabel) {
    return 'تمت استعادة البيانات بنجاح!$vLabel';
  }

  @override
  String backup_restoreFailed(Object error) {
    return 'فشلت الاستعادة: $error';
  }

  @override
  String get backup_restoreFailedCorrupted =>
      'فشلت الاستعادة: قد يكون الملف تالفًا أو ليس نسخة احتياطية من Expensy.';

  @override
  String get budget_noBudgetsYet => 'لا توجد ميزانيات بعد';

  @override
  String get budget_tapToAddBudget => 'انقر على + لتعيين حد للإنفاق لكل فئة';

  @override
  String get budget_budgeted => 'الميزانية المحددة';

  @override
  String get budget_leftToSpend => 'متبقي للإنفاق';

  @override
  String get budget_spent => 'ما تم إنفاقه';

  @override
  String get budget_overLimit => 'تجاوز الحد';

  @override
  String get budget_unknown => 'غير معروف';

  @override
  String get budget_weeklyLabel => 'أسبوعياً';

  @override
  String get budget_monthlyLabel => 'شهرياً';

  @override
  String budget_overAmount(Object amount) {
    return 'تجاوز بـ $amount';
  }

  @override
  String budget_leftAmount(Object amount) {
    return 'متبقي $amount';
  }

  @override
  String budget_percentUsed(Object percent) {
    return 'تم استخدام $percent%';
  }

  @override
  String get budget_editBudget => 'تعديل الميزانية';

  @override
  String get budget_setBudget => 'إضافة ميزانية جديدة';

  @override
  String get budget_budgetAmount => 'مبلغ الميزانية';

  @override
  String budget_previewFor(Object catName) {
    return 'معاينة لـ \"$catName\"';
  }

  @override
  String budget_spentAmount(Object amount) {
    return 'المنفق: $amount';
  }

  @override
  String budget_ofAmount(Object amount) {
    return 'من $amount';
  }

  @override
  String get budget_saveChanges => 'حفظ التغييرات';

  @override
  String get budget_budget => 'الميزانية';

  @override
  String get budget_rollover => 'ترحيل الفائض (المظاريف)';

  @override
  String get budget_rolloverDesc =>
      'ترحيل الفائض أو العجز غير المستخدم إلى الفترة التالية';

  @override
  String get budget_rolloverBadge => 'ترحيل';

  @override
  String budget_base(Object amount) {
    return 'الأساس: $amount';
  }

  @override
  String budget_rolloverFrom(Object period, Object amount) {
    return 'ترحيل ($period): $amount';
  }

  @override
  String budget_totalAvailable(Object amount) {
    return 'الإجمالي المتاح: $amount';
  }

  @override
  String get budget_lastWeek => 'الأسبوع الماضي';

  @override
  String get pacing_dailyBudget => 'معدل الصرف الآمن';

  @override
  String pacing_safeToSpend(Object amount, Object days) {
    return 'الصرف الآمن: $amount/يوم (متبقي $days أيام)';
  }

  @override
  String pacing_caution(Object amount) {
    return 'صرف متسارع — اضبط الصرف إلى $amount/يوم';
  }

  @override
  String get pacing_overPaced =>
      'تنبيه سرعة الصرف — خفف الصرف للبقاء ضمن الميزانية';

  @override
  String get pacing_budgetExhausted =>
      'استُنفدت الميزانية — لا يوجد مخصص يومي متبقٍ';

  @override
  String get pacing_onTrack => 'ضمن المعدل';

  @override
  String get pacing_fast => 'صرف متسارع';

  @override
  String get pacing_alert => 'تنبيه الصرف';

  @override
  String pacing_daysLeft(Object days) {
    return 'متبقي $days أيام';
  }

  @override
  String get pacing_setBudgetPrompt => 'انقر لتعيين حدود الميزانية ←';

  @override
  String get pacing_dailyAvgPace => 'المعدل اليومي';

  @override
  String pacing_perDay(Object amount) {
    return '$amount / يوم';
  }

  @override
  String get calendar_title => 'التقويم المالي';

  @override
  String get calendar_subtitle => 'خريطة المصروفات اليومية ومواعيد الاستحقاق';

  @override
  String calendar_zeroSpendDays(Object count) {
    return '$count أيام بدون إنفاق';
  }

  @override
  String get calendar_zeroSpendDayTitle => 'يوم بلا إنفاق! 🎉';

  @override
  String get calendar_zeroSpendDayDesc =>
      'أحسنت! انضباط مالي رائع بدون أي مصروفات اليوم.';

  @override
  String get calendar_billsDue => 'الفواتير والاشتراكات المستحقة';

  @override
  String get calendar_loansDue => 'أقساط القروض المستحقة';

  @override
  String get calendar_lendedDue => 'المستحقات المتوقع استردادها';

  @override
  String calendar_dayTransactions(Object count) {
    return 'المعاملات ($count)';
  }

  @override
  String get calendar_noActivity =>
      'لا توجد معاملات أو التزامات في هذا التاريخ';

  @override
  String get calendar_today => 'اليوم';

  @override
  String calendar_averageDaily(Object amount) {
    return 'المتوسط اليومي: $amount';
  }

  @override
  String get wrapped_title => 'ملخص إكسبنسي';

  @override
  String wrapped_bannerTitle(Object month) {
    return 'ملخصك لشهر $month جاهز!';
  }

  @override
  String get wrapped_bannerSub => 'انقر لاستكشاف قصتك المالية الشهرية';

  @override
  String get wrapped_theBigPicture => 'الصورة الكبرى';

  @override
  String wrapped_howMoneyMoved(Object month) {
    return 'إليك حركة أموالك في $month';
  }

  @override
  String get wrapped_totalInflow => 'إجمالي الدخل';

  @override
  String get wrapped_totalOutflow => 'إجمالي المصروفات';

  @override
  String get wrapped_netSavings => 'صافي المدخرات';

  @override
  String wrapped_savingsRate(Object rate) {
    return 'معدل الادخار: $rate%';
  }

  @override
  String get wrapped_topCategoryTitle => 'أين ذهبت أموالك؟';

  @override
  String wrapped_topCategorySub(Object category) {
    return 'أكبر فئة إنفاق كانت $category';
  }

  @override
  String wrapped_topCategoryShare(Object percent) {
    return '$percent% من إجمالي إنفاقك';
  }

  @override
  String get wrapped_biggestSplurgeTitle => 'أكبر عملية شراء';

  @override
  String get wrapped_biggestSplurgeSub => 'أكبر مصروف فردي قمت به هذا الشهر';

  @override
  String get wrapped_noSplurge =>
      'لا يوجد إنفاق! لم تسجل أي مصروفات هذا الشهر.';

  @override
  String get wrapped_heroHabitTitle => 'عادتك البطولية';

  @override
  String wrapped_zeroSpendAchieved(Object count) {
    return '$count أيام بدون إنفاق';
  }

  @override
  String wrapped_heroHabitDesc(Object count) {
    return 'حققت $count يوماً بدون أي مصروفات. انضباط مالي استثنائي!';
  }

  @override
  String get wrapped_receiptTitle => 'البيان الشهري';

  @override
  String get wrapped_obscureToggle => 'إخفاء المبالغ للمشاركة';

  @override
  String get wrapped_showToggle => 'إظهار المبالغ';

  @override
  String get wrapped_replay => 'إعادة عرض القصة';

  @override
  String get insights_other => 'أخرى';

  @override
  String get insights_noDataYet => 'لا توجد بيانات بعد';

  @override
  String get insights_addSomeTransactions => 'أضف بعض المعاملات لرؤية الرؤى';

  @override
  String get insights_thisMonthVsLastMonth => 'هذا الشهر مقابل الشهر الماضي';

  @override
  String get insights_dailyAverage => 'المتوسط اليومي';

  @override
  String insights_perDayBasedOn(Object days) {
    return 'يوميًا · استنادًا إلى $days يومًا هذا الشهر';
  }

  @override
  String get insights_incomeVsExpenses => 'الدخل مقابل المصروفات';

  @override
  String insights_incomeAmount(Object amount) {
    return 'الدخل $amount';
  }

  @override
  String insights_expensesAmount(Object amount) {
    return 'المصروفات $amount';
  }

  @override
  String insights_percentSaved(Object percent) {
    return 'تم توفير $percent% هذا الشهر';
  }

  @override
  String get insights_topSpendingCategories => 'أعلى فئات الإنفاق';

  @override
  String insights_percentOfTotal(Object percent) {
    return '$percent% من الإجمالي';
  }

  @override
  String get insights_biggestExpenseThisMonth => 'أكبر مصروف هذا الشهر';

  @override
  String get insights_categoryTrends => 'اتجاهات الفئات (مقابل الشهر الماضي)';

  @override
  String get insights_12MonthTrend => 'اتجاه الـ 12 شهرًا';

  @override
  String get insights_incomeLabel => 'الدخل';

  @override
  String get insights_expensesLabel => 'المصروفات';

  @override
  String get categories_expenseLabel => 'المصروفات';

  @override
  String get categories_incomeLabel => 'الدخل';

  @override
  String get categories_editCategory => 'تعديل الفئة';

  @override
  String get categories_addCategory => 'إضافة فئة';

  @override
  String get categories_categoryName => 'اسم الفئة';

  @override
  String get categories_saveChanges => 'حفظ التغييرات';

  @override
  String get statistics_other => 'أخرى';

  @override
  String get statistics_allAccounts => 'جميع الحسابات';

  @override
  String get statistics_income => 'الدخل';

  @override
  String get statistics_expenses => 'المصروفات';

  @override
  String get statistics_expense => 'المصروفات';

  @override
  String get statistics_net => 'الصافي';

  @override
  String statistics_6MonthOverviewAccount(Object accountName) {
    return 'نظرة عامة على 6 أشهر · $accountName';
  }

  @override
  String get statistics_6MonthOverview => 'نظرة عامة على 6 أشهر';

  @override
  String statistics_percentOfBudget(Object percent) {
    return '$percent% من الميزانية';
  }

  @override
  String get add_transaction_editTransaction => 'تعديل المعاملة';

  @override
  String get add_transaction_addTransaction => 'إدخال معاملة';

  @override
  String get add_transaction_amount => 'المبلغ';

  @override
  String add_transaction_conversionPreview(Object accountName, Object amount) {
    return '≈ سيتم خصم $amount من $accountName';
  }

  @override
  String get add_transaction_accountFallback => 'الحساب';

  @override
  String get add_transaction_descriptionOptional => 'الوصف (اختياري)';

  @override
  String get add_transaction_noteOptional => 'ملاحظة (اختياري)';

  @override
  String get add_transaction_saveChanges => 'حفظ التغييرات';

  @override
  String get more_statistics => 'الإحصائيات';

  @override
  String get more_statisticsSub => 'المخططات والملخص الشهري';

  @override
  String get more_insights => 'الرؤى';

  @override
  String get more_insightsSub => 'الاتجاهات والمتوسطات وتحليل الفئات';

  @override
  String get more_currencyConverter => 'محول العملات';

  @override
  String get more_currencyConverterSub => 'التحويل بين العملات على الفور';

  @override
  String get more_wishlist => 'قائمة الرغبات';

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
  String get more_lentMoney => 'الأموال المقرضة';

  @override
  String more_lentMoneySub(Object count) {
    return '$count معلقة';
  }

  @override
  String get more_assets => 'الأصول';

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
  String get more_categories => 'الفئات';

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
  String get more_exportTransactions => 'تصدير المعاملات';

  @override
  String get more_exportTransactionsSub => 'حفظ كـ Excel (.xlsx)';

  @override
  String get more_backupRestore => 'النسخ الاحتياطي والاستعادة';

  @override
  String get more_backupRestoreSub => 'حفظ أو تحميل بياناتك';

  @override
  String get more_settings => 'الإعدادات';

  @override
  String get more_settingsSub => 'السمة والعملة والتفضيلات';

  @override
  String get more_sectionTools => 'الأدوات المالية';

  @override
  String get more_sectionAnalytics => 'التحليلات والرؤى';

  @override
  String get more_sectionPreferences => 'التفضيلات والبيانات';

  @override
  String home_greeting(Object name) {
    return 'مرحباً، $name 👋';
  }

  @override
  String get home_there => 'بك';

  @override
  String get home_income => 'الدخل';

  @override
  String get home_expenses => 'المصروفات';

  @override
  String get home_net => 'الصافي';

  @override
  String get wishlist_noItems => 'لا توجد عناصر في قائمة الرغبات';

  @override
  String get wishlist_noItemsSub => 'انقر على + لإضافة عناصر تدخر من أجلها';

  @override
  String get wishlist_editItem => 'تعديل العنصر';

  @override
  String get wishlist_addWishlistItem => 'إضافة عنصر لقائمة الرغبات';

  @override
  String get wishlist_itemName => 'اسم العنصر';

  @override
  String get wishlist_targetPrice => 'السعر المستهدف';

  @override
  String get wishlist_priorityLow => 'منخفضة';

  @override
  String get wishlist_priorityMedium => 'متوسطة';

  @override
  String get wishlist_priorityHigh => 'عالية';

  @override
  String get wishlist_notesOptional => 'ملاحظات (اختياري)';

  @override
  String get wishlist_saveChanges => 'حفظ التغييرات';

  @override
  String get wishlist_addItem => 'إضافة عنصر';

  @override
  String get wishlist_fundThisItem => 'تمويل العنصر';

  @override
  String wishlist_funded(int percent, String saved, String target) {
    return 'تم تمويل $percent% ($saved / $target)';
  }

  @override
  String get wishlist_goalAchieved => 'تم تحقيق الهدف — جاهز للشراء!';

  @override
  String get wishlist_buyNow => 'شراء الآن';

  @override
  String get wishlist_purchaseTitle => 'شراء عنصر من قائمة الرغبات';

  @override
  String get wishlist_purchasePrompt =>
      'هل تريد تسجيل معاملة مصروف وخصم المبلغ من أحد الحسابات؟';

  @override
  String get wishlist_recordAndDeduct => 'تسجيل وخصم';

  @override
  String get wishlist_markPurchasedOnly => 'تحديد كمشترى فقط';

  @override
  String wishlist_itemPurchased(String name) {
    return 'تم تحديد \"$name\" كمشترى!';
  }

  @override
  String get wishlist_viewGoal => 'عرض هدف الادخار';

  @override
  String savings_linkedWishlist(String item) {
    return 'مرتبط بقائمة الرغبات: $item';
  }

  @override
  String get lended_theyOweMe => 'هم مدينون لي';

  @override
  String get lended_iOweThem => 'أنا مدين لهم';

  @override
  String get lended_net => 'الصافي';

  @override
  String get lended_noOneYet => 'لا أحد بعد';

  @override
  String get lended_noOneYetSub => 'انقر على + لإضافة شخص تقرضه أو تقترض منه';

  @override
  String get lended_owesYou => 'مدين لك';

  @override
  String get lended_youOwe => 'أنت مدين';

  @override
  String get lended_settledUp => 'سُددت';

  @override
  String get lended_noActiveRecords => 'لا توجد سجلات نشطة';

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
  String get lended_editPerson => 'تعديل الشخص';

  @override
  String get lended_addPerson => 'إضافة شخص';

  @override
  String get lended_name => 'الاسم';

  @override
  String get lended_notesOptional => 'ملاحظات (اختياري)';

  @override
  String get lended_saveChanges => 'حفظ التغييرات';

  @override
  String get assets_totalAssets => 'إجمالي الأصول';

  @override
  String get assets_items => 'العناصر';

  @override
  String get assets_noAssetsYet => 'لا توجد أصول بعد';

  @override
  String get assets_noAssetsYetSub => 'انقر على + لإضافة منتج أو أصل';

  @override
  String get assets_editAsset => 'تعديل الأصل';

  @override
  String get assets_addAsset => 'إضافة أصل';

  @override
  String get assets_productAssetName => 'اسم المنتج / الأصل';

  @override
  String get assets_value => 'القيمة';

  @override
  String get assets_notesOptional => 'ملاحظات (اختياري)';

  @override
  String get assets_saveChanges => 'حفظ التغييرات';

  @override
  String get currency_converter_loadingRates => 'جاري تحميل أسعار الصرف...';

  @override
  String get currency_converter_ratesUnavailable =>
      'أسعار الصرف غير متوفرة. اتصل بالإنترنت للمزامنة.';

  @override
  String get currency_converter_rateAgeJustNow => 'الآن';

  @override
  String currency_converter_rateAgeMins(Object minutes) {
    return 'منذ $minutes دقيقة';
  }

  @override
  String currency_converter_rateAgeHours(Object hours) {
    return 'منذ $hours ساعة';
  }

  @override
  String currency_converter_rateAgeDays(Object days) {
    return 'منذ $days يوم';
  }

  @override
  String currency_converter_commonConversions(Object fromCurrency) {
    return 'التحويلات الشائعة من $fromCurrency';
  }

  @override
  String transfer_fromAcc(Object currency) {
    return 'من ($currency)';
  }

  @override
  String transfer_toAcc(Object currency) {
    return 'إلى ($currency)';
  }

  @override
  String get transfer_exchangeRatesNotLoaded =>
      'لم يتم تحميل أسعار الصرف — سيتم تحويل المبلغ كما هو';

  @override
  String get transfer_amount => 'المبلغ';

  @override
  String get transfer_noteOptional => 'ملاحظة (اختياري)';

  @override
  String get export_from => 'من';

  @override
  String get export_to => 'إلى';

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
    return 'تم الحفظ: $path';
  }

  @override
  String get export_complete => 'اكتمل التصدير';

  @override
  String get export_exporting => 'جاري التصدير...';

  @override
  String get export_exportAsExcel => 'تصدير كـ Excel';

  @override
  String shared_widgets_deleteConfirm(Object name) {
    return 'هل تريد حذف \"$name\"؟ لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get shared_widgets_searchByCode => 'البحث بالرمز أو الاسم...';

  @override
  String get accounts_accounts => 'الحسابات';

  @override
  String get accounts_totalBalance => 'إجمالي الرصيد';

  @override
  String get accounts_excluded => 'مستبعد';

  @override
  String get accounts_goldPriceNotYetLoade =>
      'لم يتم تحميل سعر الذهب بعد. انتظر لحظة وحاول مرة أخرى.';

  @override
  String get accounts_accountType => 'نوع الحساب';

  @override
  String get accounts_currency => 'العملة';

  @override
  String get accounts_goldPurityKarat => 'نقاء الذهب (عيار)';

  @override
  String get accounts_weight => 'الوزن';

  @override
  String get accounts_excludeFromTotalBala => 'استبعاد من إجمالي الرصيد';

  @override
  String get accounts_dontLinkToCard => 'عدم الربط ببطاقة';

  @override
  String get accounts_dontLinkToCardDesc =>
      'إدارة رصيد هذا الحساب يدويًا ومنع البطاقات من الارتباط به';

  @override
  String get accounts_color => 'اللون';

  @override
  String get accounts_liveGoldValue => 'قيمة الذهب المباشرة';

  @override
  String get accounts_enterWeightAboveToSe => 'أدخل الوزن أعلاه لمعرفة القيمة';

  @override
  String get add_transaction_expense => 'مصروف';

  @override
  String get add_transaction_income => 'دخل';

  @override
  String get add_transaction_account => 'الحساب';

  @override
  String get add_transaction_category => 'الفئة';

  @override
  String get assets_assets => 'الأصول';

  @override
  String get backup_restoreBackup => 'استعادة النسخة الاحتياطية؟';

  @override
  String get backup_cancel => 'إلغاء';

  @override
  String get backup_replaceData => 'استبدال البيانات';

  @override
  String get backup_backupRestore => 'النسخ الاحتياطي والاستعادة';

  @override
  String get backup_everythingAlways => 'كل شيء، دائمًا';

  @override
  String get backup_createBackup => 'إنشاء نسخة احتياطية';

  @override
  String get backup_saveAsJson => 'حفظ كملف JSON';

  @override
  String get backup_exportsAllAppDataToA =>
      'يصدر كل بيانات التطبيق إلى ملف محمول';

  @override
  String get backup_restoreBackup_ => 'استعادة النسخة الاحتياطية';

  @override
  String get backup_loadFromJson => 'تحميل من JSON';

  @override
  String get backup_picksABackupFileAndR => 'يختار ملف نسخة احتياطية ويستعيده';

  @override
  String get backup_thisOverwritesAllCur =>
      'هذا سيكتب فوق جميع البيانات الحالية.';

  @override
  String get budget_budgets => 'الميزانيات';

  @override
  String get budget_empty => '·';

  @override
  String get budget_overBudget => 'تجاوز الميزانية';

  @override
  String get budget_thisCategoryAlreadyH =>
      'هذه الفئة لديها ميزانية بالفعل. اضغط للتعديل.';

  @override
  String get budget_period => 'الفترة';

  @override
  String get budget_monthly => 'شهريًا';

  @override
  String get budget_weekly => 'أسبوعيًا';

  @override
  String get budget_category => 'الفئة';

  @override
  String get categories_categories => 'الفئات';

  @override
  String get categories_expense => 'مصروف';

  @override
  String get categories_income => 'دخل';

  @override
  String get categories_color => 'اللون';

  @override
  String get categories_icon => 'الأيقونة';

  @override
  String get categories_autoBasedOnName => 'تلقائي (بناءً على الاسم)';

  @override
  String get categories_expenseCategories => 'فئات المصروفات';

  @override
  String get categories_incomeCategories => 'فئات الدخل';

  @override
  String get currency_converter_currencyConverter => 'محول العملات';

  @override
  String get currency_converter_amount => 'المبلغ';

  @override
  String get currency_converter_convertedTo => 'تم التحويل إلى';

  @override
  String get export_exportTransactions => 'تصدير المعاملات';

  @override
  String get export_dateRange => 'نطاق التاريخ';

  @override
  String get export_formatExcelXlsx => 'التنسيق: Excel (.xlsx)';

  @override
  String get export_exportAsPdf => 'تصدير كتقرير PDF';

  @override
  String get export_formatPdf => 'الصيغة: تقرير مالي PDF (.pdf)';

  @override
  String get export_pdfGenerating => 'جارٍ إنشاء ملف PDF...';

  @override
  String get export_pdfTitle => 'التقرير المالي';

  @override
  String get export_pdfSummary => 'الملخص التنفيذي';

  @override
  String get export_pdfInflow => 'إجمالي الدخل';

  @override
  String get export_pdfOutflow => 'إجمالي المصروفات';

  @override
  String get export_pdfNet => 'صافي المدخرات';

  @override
  String get export_pdfSavingsRate => 'معدل الادخار';

  @override
  String get export_pdfCategoryBreakdown => 'تفصيل الفئات';

  @override
  String get export_pdfTransactions => 'المعاملات المفصلة';

  @override
  String get export_pdfNetWorthBreakdown => 'الأصول والالتزامات';

  @override
  String get export_pdfShare => 'مشاركة التقرير';

  @override
  String get export_pdfPrint => 'طباعة / معاينة';

  @override
  String get export_pdfGeneratedBy =>
      'تم الإنشاء بواسطة إكسبنسي • خاص وبدون إنترنت';

  @override
  String get home_totalBalance => 'إجمالي الرصيد';

  @override
  String get home_accounts => 'الحسابات';

  @override
  String get home_recentTransactions => 'أحدث المعاملات';

  @override
  String get home_noTransactionsYet => 'لا توجد معاملات بعد';

  @override
  String get home_add => 'إضافة';

  @override
  String get home_goodMorning => 'صباح الخير';

  @override
  String get home_goodAfternoon => 'مساء الخير';

  @override
  String get home_goodEvening => 'مساء الخير';

  @override
  String get home_transferAction => 'تحويل';

  @override
  String get home_insightsAction => 'تحليلات';

  @override
  String get home_calendarAction => 'التقويم';

  @override
  String get home_forecastAction => 'التوقعات';

  @override
  String get home_manage => 'إدارة';

  @override
  String get home_seeAll => 'عرض الكل';

  @override
  String get home_addAccount => 'إضافة حساب';

  @override
  String get home_monthlyOverview => 'نظرة شهرية عامة';

  @override
  String get home_savingsRate => 'معدل الادخار';

  @override
  String get insights_insights => 'الرؤى';

  @override
  String get lended_person_deletePerson => 'حذف الشخص';

  @override
  String get lended_person_editPerson => 'تعديل الشخص';

  @override
  String get lended_person_color => 'اللون';

  @override
  String get lended_person_saveChanges => 'حفظ التغييرات';

  @override
  String get lended_person_settled => 'تمت التسوية';

  @override
  String get lended_person_settle => 'تسوية';

  @override
  String get lended_person_setADueDateFirstToEn =>
      'حدد تاريخ استحقاق أولاً لتفعيل التذكيرات.';

  @override
  String get lended_person_iLent => 'أنا أقرضت';

  @override
  String get lended_person_iBorrowed => 'أنا اقترضت';

  @override
  String get lended_person_accountOptional => 'الحساب (اختياري)';

  @override
  String get lended_person_dueDateReminder => 'تذكير تاريخ الاستحقاق';

  @override
  String get lended_person_remindMeAt => 'ذكرني في';

  @override
  String get lended_person_active => 'نشط';

  @override
  String get lended_person_settled_ => 'تمت التسوية';

  @override
  String get lended_lentMoney => 'المال المقرض';

  @override
  String get lended_overdue => 'متأخر';

  @override
  String get lended_color => 'اللون';

  @override
  String get more_more => 'المزيد';

  @override
  String get onboarding_back => 'رجوع';

  @override
  String get onboarding_welcomeToExpensy => 'مرحبًا بك في Expensy!';

  @override
  String get onboarding_restoreABackup => 'استعادة نسخة احتياطية';

  @override
  String get onboarding_loadAPreviouslySaved =>
      'تحميل ملف JSON محفوظ مسبقًا لـ Expensy';

  @override
  String get onboarding_or => 'أو';

  @override
  String get onboarding_startFresh => 'ابدأ من جديد';

  @override
  String get onboarding_firstWhatShouldWeCal => 'أولاً، ماذا يجب أن نسميك؟';

  @override
  String get onboarding_defaultCurrency => 'العملة الافتراضية';

  @override
  String get onboarding_thisWillBeUsedAcross =>
      'سيتم استخدام هذا في جميع أنحاء التطبيق.\nيمكنك تغييره لاحقًا في الإعدادات.';

  @override
  String get onboarding_searchAllCurrencies => 'البحث في جميع العملات';

  @override
  String get onboarding_yourFirstAccount => 'حسابك الأول';

  @override
  String get onboarding_setUpYourMainAccount =>
      'قم بإعداد حسابك الرئيسي لبدء التتبع.';

  @override
  String get onboarding_accountType => 'نوع الحساب';

  @override
  String get onboarding_currency => 'العملة';

  @override
  String get onboarding_color => 'اللون';

  @override
  String get recurring_recurring => 'متكرر';

  @override
  String get recurring_income => 'دخل';

  @override
  String get recurring_2D => '−2ي';

  @override
  String get recurring_skipNextPayment => 'تخطي الدفعة القادمة؟';

  @override
  String get recurring_cancel => 'إلغاء';

  @override
  String get recurring_skip => 'تخطي';

  @override
  String get recurring_noHistoryYet => 'لا يوجد سجل بعد';

  @override
  String get recurring_expense => 'مصروف';

  @override
  String get recurring_income_ => 'دخل';

  @override
  String get recurring_every => 'كل ';

  @override
  String get recurring_days => 'أيام';

  @override
  String get recurring_weeks => 'أسابيع';

  @override
  String get recurring_months => 'أشهر';

  @override
  String get recurring_years => 'سنوات';

  @override
  String get recurring_payments => 'دفعات';

  @override
  String get recurring_totalCost => 'التكلفة الإجمالية';

  @override
  String get recurring_account => 'الحساب';

  @override
  String get recurring_category => 'الفئة';

  @override
  String get recurring_paymentReminder => 'تذكير بالدفع';

  @override
  String get recurring_notificationWillFire =>
      'سيتم إطلاق الإشعار في تاريخ الاستحقاق القادم في هذا الوقت.';

  @override
  String get recurring_remind2DaysBefore => 'ذكرني قبل يومين';

  @override
  String get statistics_statistics => 'الإحصائيات';

  @override
  String get statistics_expensesByCategory => 'المصروفات حسب الفئة';

  @override
  String get transactions_transactions => 'المعاملات';

  @override
  String get transactions_settled => 'تمت التسوية';

  @override
  String get transfer_transfer => 'تحويل';

  @override
  String get transfer_from => 'من';

  @override
  String get transfer_to => 'إلى';

  @override
  String get transfer_enterAnAmountToSeeTh => 'أدخل مبلغًا لرؤية التحويل';

  @override
  String get wishlist_wishlist => 'قائمة الرغبات';

  @override
  String get wishlist_priority => 'الأولوية';

  @override
  String get shared_widgets_delete => 'حذف؟';

  @override
  String get shared_widgets_cancel => 'إلغاء';

  @override
  String get shared_widgets_delete_ => 'حذف';

  @override
  String get shared_widgets_none => 'لا شيء';

  @override
  String get shared_widgets_selectCurrency => 'اختر العملة';

  @override
  String get main_home => 'الرئيسية';

  @override
  String get main_transactions => 'المعاملات';

  @override
  String get main_recurring => 'المتكررة';

  @override
  String get main_accounts => 'الحسابات';

  @override
  String get main_budgets => 'الميزانيات';

  @override
  String get main_more => 'المزيد';

  @override
  String get onboarding_chooseLanguage => 'اختر اللغة';

  @override
  String get error_required => 'هذا الحقل مطلوب';

  @override
  String recurring_subscriptions(Object count) {
    return 'الاشتراكات ($count)';
  }

  @override
  String recurring_installments(Object count) {
    return 'الأقساط ($count)';
  }

  @override
  String get recurring_recurringType => 'نوع التكرار';

  @override
  String get recurring_subscription => 'اشتراك';

  @override
  String get recurring_installment => 'قسط';

  @override
  String get recurring_installmentsRequireEndDate =>
      'يجب أن تحتوي الأقساط على تاريخ دفع نهائي.';

  @override
  String get backup_importFromOtherApps => 'استيراد من تطبيقات أخرى';

  @override
  String get backup_importDescription =>
      'استيراد البيانات من التطبيقات المدعومة';

  @override
  String get backup_importFromGreenStash => 'استيراد من GreenStash (.json)';

  @override
  String get backup_automaticBackup => 'النسخ الاحتياطي التلقائي';

  @override
  String get backup_dailyAutoBackup => 'النسخ الاحتياطي التلقائي اليومي';

  @override
  String backup_runsDailyAt(String time) {
    return 'Runs daily at $time';
  }

  @override
  String backup_lastBackup(String time) {
    return 'آخر نسخة احتياطية: $time';
  }

  @override
  String backup_savingTo(String path) {
    return 'Saving to: $path';
  }

  @override
  String get backup_changeTime => 'تغيير الوقت';

  @override
  String get backup_changeFolder => 'تغيير المجلد';

  @override
  String get budget_budgetsAndGoals => 'الميزانيات والأهداف';

  @override
  String get onboarding_restoreGreenStash => 'استعادة من GreenStash (.json)';

  @override
  String get savings_goalNotFound => 'لم يتم العثور على الهدف';

  @override
  String get savings_savedSoFar => 'تم الحفظ حتى الآن';

  @override
  String get savings_target => 'هدف';

  @override
  String savings_targetDate(String date) {
    return 'Target Date: $date';
  }

  @override
  String get savings_contribute => 'ساهم';

  @override
  String get savings_withdraw => 'انسحاب';

  @override
  String get savings_noAccounts =>
      'لا توجد حسابات متاحة. الرجاء إضافة حساب أولا.';

  @override
  String get settings_budgetAlerts => 'تنبيهات الميزانية';

  @override
  String get settings_budgetAlertsSub =>
      'إعلام عند الوصول إلى الميزانية أو الهدف';

  @override
  String get settings_dailyReminder => 'التذكير اليومي';

  @override
  String get settings_dailyReminderSub => 'تذكير بتسجيل المعاملات يوميا';

  @override
  String get settings_reminderTime => 'وقت التذكير';

  @override
  String get settings_hapticFeedback => 'ردود الفعل اللمسية';

  @override
  String get settings_hapticFeedbackSub => 'اهتزاز عند التفاعلات';

  @override
  String get savings_saveGoal => 'حفظ الهدف';

  @override
  String get more_loans => 'القروض';

  @override
  String more_loansSub(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count قروض نشطة',
      one: 'قرض نشط واحد',
    );
    return '$_temp0';
  }

  @override
  String get loans_title => 'القروض';

  @override
  String get loans_addLoan => 'إضافة قرض';

  @override
  String get loans_editLoan => 'تعديل القرض';

  @override
  String get loans_loanName => 'اسم القرض';

  @override
  String get loans_amount => 'المبلغ';

  @override
  String get loans_startDate => 'تاريخ البدء';

  @override
  String get loans_endDate => 'تاريخ الانتهاء';

  @override
  String get loans_interestRateOptional => 'نسبة الفائدة (اختياري)';

  @override
  String get loans_account => 'الحساب المرتبط';

  @override
  String get loans_monthlyPayment => 'القسط الشهري';

  @override
  String get loans_totalPayable => 'إجمالي المستحق';

  @override
  String get loans_remaining => 'المتبقي';

  @override
  String get loans_paid => 'المدفوع';

  @override
  String get loans_logPayment => 'تسجيل دفعة';

  @override
  String get loans_paymentReminder => 'تذكير الدفع';

  @override
  String get loans_reminderDay => 'يوم التذكير';

  @override
  String get loans_notes => 'ملاحظات';

  @override
  String get loans_saveLoan => 'حفظ القرض';

  @override
  String get loans_deleteLoan => 'حذف القرض';

  @override
  String get loans_settled => 'تم تسديده';

  @override
  String loans_durationMonths(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count أشهر',
      one: 'شهر واحد',
    );
    return '$_temp0';
  }

  @override
  String get loans_paymentHistory => 'سجل الدفعات';

  @override
  String get loans_noPayments => 'لم يتم تسجيل أي دفعات بعد';

  @override
  String get loans_outstandingDebt => 'الديون المستحقة';

  @override
  String get loans_monthlyObligation => 'الالتزام الشهري';

  @override
  String get insights_loans => 'القروض';

  @override
  String get backup_loans => 'القروض';

  @override
  String get backup_loanPayments => 'دفعات القروض';

  @override
  String get more_yearlyAnalysis => 'التحليل السنوي';

  @override
  String get more_yearlyAnalysisSub => 'توقعات التدفق النقدي شهرياً';

  @override
  String get yearly_title => 'التحليل السنوي';

  @override
  String get yearly_recurringExp => 'المصروفات المتكررة';

  @override
  String get yearly_recurringInc => 'الدخل المتكرر';

  @override
  String get yearly_loans => 'أقساط القروض';

  @override
  String get yearly_borrowed => 'ديون مستحقة';

  @override
  String get yearly_lentDue => 'أموال مستردة';

  @override
  String get yearly_inflow => 'التدفقات الداخلة';

  @override
  String get yearly_outflow => 'التدفقات الخارجة';

  @override
  String get yearly_netFlow => 'صافي التدفق';

  @override
  String get yearly_totalInflow => 'إجمالي الداخل';

  @override
  String get yearly_totalOutflow => 'إجمالي الخارج';

  @override
  String get yearly_netCashFlow => 'صافي التدفق النقدي';

  @override
  String get yearly_noData => 'لا يوجد نشاط متوقع حتى الآن';

  @override
  String get yearly_noDataSub =>
      'أضف مدفوعات متكررة أو قروض أو أموالاً مسبقة بتاريخ استحقاق لرؤية التوقعات';

  @override
  String get budget_addBudget => 'إضافة ميزانية';

  @override
  String get budget_addGoal => 'إضافة هدف إدّخار';

  @override
  String get add_transaction_possibleDuplicate => 'معاملة مكررة محتملة';

  @override
  String get add_transaction_goBack => 'رجوع';

  @override
  String get add_transaction_saveAnyway => 'حفظ على أي حال';

  @override
  String get loans_confirmDeleteLoan =>
      'هل أنت متأكد من حذف هذا القرض وجميع دفعاته؟';

  @override
  String get loans_deletePayment => 'حذف الدفعة';

  @override
  String get loans_confirmDeletePayment =>
      'هل أنت متأكد من حذف سجل هذه الدفعة؟';

  @override
  String get split_transactions_title => 'تقسيم الفئات';

  @override
  String get split_transactions_badge => 'مقسمة';

  @override
  String get split_transactions_addSplit => 'إضافة تقسيم';

  @override
  String get split_transactions_removeSplit => 'حذف التقسيم';

  @override
  String get split_transactions_allocated => 'المخصص';

  @override
  String get split_transactions_remaining => 'المتبقي';

  @override
  String get split_transactions_fillRemaining => 'تعبئة المتبقي';

  @override
  String get split_transactions_breakdown => 'تفاصيل التقسيم';

  @override
  String get split_transactions_mismatchError =>
      'يجب أن يتطابق مجموع المبالغ المقسمة مع المبلغ الإجمالي.';

  @override
  String get netWorth_title => 'صافي الثروة';

  @override
  String get netWorth_subtitle =>
      'تتبع إجمالي الأصول والالتزامات والثروة عبر الوقت';

  @override
  String get netWorth_current => 'صافي الثروة الحالي';

  @override
  String get netWorth_trend => 'مخطط صافي الثروة';

  @override
  String get netWorth_totalAssets => 'إجمالي الأصول';

  @override
  String get netWorth_totalLiabilities => 'إجمالي الالتزامات';

  @override
  String get netWorth_liquidCash => 'النقد والحسابات البنكية';

  @override
  String get netWorth_goldValuation => 'الذهب الفعلي';

  @override
  String get netWorth_fixedAssets => 'الممتلكات والاستثمارات';

  @override
  String get netWorth_moneyLent => 'أموال مُقرضة (مستحقات)';

  @override
  String get netWorth_creditDebt => 'بطاقات الائتمان والسحب على المكشوف';

  @override
  String get netWorth_loanDebt => 'قروض مستحقة الدفع';

  @override
  String get netWorth_moneyBorrowed => 'أموال مقترضة (ديون)';

  @override
  String get netWorth_assetBreakdown => 'تفصيل الأصول';

  @override
  String get netWorth_liabilityBreakdown => 'تفصيل الالتزامات';

  @override
  String get netWorth_noHistory =>
      'سيتم بناء سجل صافي الثروة تلقائيًا بمرور الوقت مع تسجيل اللقطات اليومية.';

  @override
  String get netWorth_debtRatio => 'نسبة الديون';

  @override
  String get netWorth_quickActions => 'إجراءات سريعة';

  @override
  String get netWorth_history => 'سجل اللقطات';

  @override
  String get creditCard_utilization => 'نسبة استخدام الائتمان';

  @override
  String get creditCard_availableCredit => 'المتاح';

  @override
  String get creditCard_limit => 'الحد الائتماني';

  @override
  String get creditCard_statementBalance => 'رصيد كشف الحساب';

  @override
  String get creditCard_unbilledBalance => 'غير مفوتر';

  @override
  String get creditCard_payBill => 'سداد فاتورة البطاقة';

  @override
  String get creditCard_allCaughtUp =>
      'تم السداد بالكامل! لا توجد مبالغ مستحقة';

  @override
  String get creditCard_payBillTitle => 'سداد فاتورة بطاقة الائتمان';

  @override
  String get creditCard_payFromAccount => 'السداد من حساب';

  @override
  String get creditCard_paymentAmount => 'مبلغ السداد';

  @override
  String get creditCard_fullStatement => 'رصيد كشف الحساب';

  @override
  String get creditCard_fullBalance => 'إجمالي الرصيد';

  @override
  String get creditCard_minPayment => 'الحد الأدنى للدفع';

  @override
  String get creditCard_customAmount => 'مبلغ مخصص';

  @override
  String creditCard_paymentSuccess(String amount, String cardName) {
    return 'تم دفع $amount لـ $cardName';
  }

  @override
  String get creditCard_insufficientFunds => 'المبلغ يتجاوز الرصيد المتاح';

  @override
  String get creditCard_invalidAmount => 'يرجى إدخال مبلغ سداد صحيح';

  @override
  String get onboarding_skipForNow => 'التخطي الآن';

  @override
  String get onboarding_addCard => 'إضافة بطاقة';

  @override
  String get onboarding_skipCardDesc =>
      'يمكنك تخطي هذا إذا كنت لا ترغب في إضافة بطاقة الآن.';

  @override
  String get onboarding_cardNameLabel => 'اسم البطاقة (مثال: فيزا بلاتينيوم)';

  @override
  String get onboarding_debitCard => 'بطاقة خصم';

  @override
  String get onboarding_creditLimit => 'الحد الائتماني';

  @override
  String get onboarding_amountUsed => 'المبلغ المستخدم';

  @override
  String get accounts_cardHolderOptional => 'اسم حامل البطاقة (اختياري)';

  @override
  String get accounts_last4Digits => 'آخر 4 أرقام';

  @override
  String get accounts_expiryDate => 'تاريخ الانتهاء (شهر/سنة)';

  @override
  String get accounts_creditLimitOptional => 'الحد الائتماني (اختياري)';

  @override
  String get accounts_minPaymentOptional => 'الحد الأدنى للدفع (اختياري)';

  @override
  String get accounts_statementDayOptional => 'يوم كشف الحساب (اختياري)';

  @override
  String get accounts_statementDayExample => 'مثال: 20';

  @override
  String get accounts_dueDayOptional => 'يوم الاستحقاق (اختياري)';

  @override
  String get accounts_dueDayExample => 'مثال: 10';

  @override
  String get accounts_linkedAccountOptional =>
      'الحساب البنكي المرتبط (اختياري)';

  @override
  String get accounts_excludeCardBalance =>
      'استبعاد رصيد البطاقة من رصيد الحساب';

  @override
  String get accounts_excludeCardBalanceDesc =>
      'لن تتم إضافة رصيد هذه البطاقة إلى حسابها البنكي المرتبط.';

  @override
  String get accounts_cardHolderHeader => 'حامل البطاقة';

  @override
  String get accounts_expHeader => 'الانتهاء';

  @override
  String get accounts_notifyOnDueDate => 'سيتم إشعارك في تاريخ الاستحقاق';

  @override
  String get accounts_notifyWhenDue => 'تلقي إشعار عند استحقاق الدفع';

  @override
  String get accounts_remind2DaysBeforeDesc =>
      'تلقي تنبيه مسبق قبل يومين من تاريخ الاستحقاق';

  @override
  String get accounts_targetSaved => 'المستهدف / المدخر';

  @override
  String transactions_selectedCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تم تحديد $count',
      one: 'تم تحديد 1',
    );
    return '$_temp0';
  }

  @override
  String get transactions_changeCategory => 'تغيير الفئة';

  @override
  String get transactions_deleteSelected => 'حذف المحدد';

  @override
  String get transactions_advancedFilters => 'تصفية متقدمة';

  @override
  String get transactions_clearAll => 'مسح الكل';

  @override
  String get transactions_amountRange => 'نطاق المبلغ';

  @override
  String get transactions_minAmount => 'الحد الأدنى';

  @override
  String get transactions_maxAmount => 'الحد الأقصى';

  @override
  String get transactions_applyFilters => 'تطبيق التصفية';

  @override
  String get presets_new => 'جديد';

  @override
  String get presets_presetName => 'اسم القالب (مثال: قهوة الصباح)';

  @override
  String get presets_defaultAmount => 'المبلغ الافتراضي';

  @override
  String get savings_goalName => 'اسم الهدف';

  @override
  String get savings_goalNameHint => 'مثال: سيارة جديدة، إجازة';

  @override
  String get savings_targetAmount => 'المبلغ المستهدف';

  @override
  String get savings_targetDateOptional => 'تاريخ الهدف (اختياري)';

  @override
  String get savings_selectDate => 'اختر التاريخ';

  @override
  String get savings_amountRequired => 'المبلغ مطلوب';

  @override
  String get savings_noteOptional => 'ملاحظة (اختياري)';

  @override
  String get loans_skipInstallment => 'تخطي قسط القرض القادم؟';

  @override
  String get recurring_confirmDelete =>
      'هل أنت متأكد من حذف هذه المعاملة المتكررة؟';

  @override
  String get export_formatExcelOption => 'Excel (.xlsx)';

  @override
  String get export_formatPdfOption => 'تقرير PDF';

  @override
  String get export_pdfNoTransactions =>
      'لا توجد معاملات مسجلة ضمن هذا النطاق الزمني.';

  @override
  String get savings_saved => 'المدخر';

  @override
  String get export_pdfDate => 'التاريخ';

  @override
  String get export_pdfDescription => 'الوصف';

  @override
  String get accounts_noCardsYet => 'لا توجد بطاقات';

  @override
  String get accounts_tapToAddCard => 'اضغط على + لإضافة بطاقتك الأولى';

  @override
  String get savings_noGoalsYet => 'لا توجد أهداف ادخار';

  @override
  String get savings_tapToAddGoal => 'اضغط على + لإنشاء هدف جديد';

  @override
  String get netWorth_recordSnapshot => 'تسجيل لقطة';

  @override
  String get netWorth_snapshotRecorded => 'تم تسجيل اللقطة';

  @override
  String get savings_noContributionsYet => 'لا توجد مساهمات حتى الآن';

  @override
  String get creditCard_closesStatementBillingCycle =>
      'إغلاق دورة الفوترة الحالية للكشف';

  @override
  String get creditCard_clearsTotalDebt =>
      'سداد إجمالي مديونية البطاقة بالكامل';

  @override
  String get creditCard_requiredMinPayment => 'الحد الأدنى المطلوب للسداد';

  @override
  String get creditCard_specifyCustomAmount => 'تحديد مبلغ سداد مخصص';

  @override
  String common_itemDeleted(String name) {
    return 'تم حذف \"$name\"';
  }

  @override
  String get common_accountDeleted => 'تم حذف الحساب';

  @override
  String get common_cardDeleted => 'تم حذف البطاقة';

  @override
  String get common_transactionDeleted => 'تم حذف المعاملة';

  @override
  String get common_recordDeleted => 'تم حذف السجل';

  @override
  String get common_paymentDeleted => 'تم حذف الدفعة';

  @override
  String get loans_skippedInstallment => 'تم تخطي قسط القرض';

  @override
  String loans_loggedPayment(String amount) {
    return 'تم تسجيل دفعة بقيمة $amount';
  }

  @override
  String get loans_notificationsPermissionRequired => 'إذن الإشعارات مطلوب';

  @override
  String get creditCard_selectFundingAccount => 'يرجى تحديد حساب التمويل';

  @override
  String get presets_presetUpdated => 'تم تحديث النموذج';

  @override
  String get presets_presetAdded => 'تمت إضافة النموذج';

  @override
  String get presets_presetDeleted => 'تم حذف النموذج';

  @override
  String transactions_deletedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تم حذف $count عنصر',
      many: 'تم حذف $count عنصراً',
      few: 'تم حذف $count عناصر',
      two: 'تم حذف عنصرين',
      one: 'تم حذف عنصر واحد',
      zero: 'لم يتم حذف عناصر',
    );
    return '$_temp0';
  }

  @override
  String get split_atLeastTwoCategories =>
      'يلزم فئتان على الأقل لتقسيم المعاملة.';

  @override
  String get split_categoryAndAmountRequired =>
      'يجب أن يحتوي كل بند مقسم على فئة ومبلغ أكبر من 0.';

  @override
  String get presets_addQuickPresets => 'إضافة نماذج سريعة بضغطة واحدة';

  @override
  String get presets_quickPresetsDesc =>
      'سجّل قهوتك أو مواصلاتك أو وجباتك المتكررة بضغطة واحدة';

  @override
  String presets_loggedPreset(String title, String amount) {
    return 'تم تسجيل $title ($amount)';
  }

  @override
  String get presets_createPreset => 'إنشاء نموذج';

  @override
  String get presets_editQuickPreset => 'تعديل النموذج السريع';

  @override
  String get presets_newQuickPreset => 'نموذج سريع جديد';

  @override
  String get savings_addContribution => 'إضافة مساهمة';

  @override
  String get savings_withdrawFromGoal => 'سحب من الهدف';

  @override
  String get savings_contribution => 'مساهمة';

  @override
  String get savings_withdrawal => 'سحب';

  @override
  String get savings_unknownAccount => 'حساب غير معروف';

  @override
  String get savings_fromAccount => 'من حساب';

  @override
  String get savings_toAccount => 'إلى حساب';

  @override
  String get presets_quickLog => 'تسجيل سريع';

  @override
  String accounts_dueOnDay(int day) {
    return 'الاستحقاق يوم $day';
  }
}
