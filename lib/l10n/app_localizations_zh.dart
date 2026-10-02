// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '昂贵';

  @override
  String get settings_title => '设置';

  @override
  String get settings_appearance => '外观';

  @override
  String get settings_theme => '主题';

  @override
  String get settings_system => '系统';

  @override
  String get settings_light => '浅色';

  @override
  String get settings_dark => '深色';

  @override
  String get settings_amoledTitle => '纯黑 (AMOLED)';

  @override
  String get settings_amoledSubtitle => '在黑暗模式下强制使用黑色背景';

  @override
  String get settings_systemDefault => '系统默认';

  @override
  String get settings_dynamicColor => '动态色彩';

  @override
  String get settings_dynamicColorSubtitle => '使用系统壁纸颜色';

  @override
  String get settings_accentColor => '强调色';

  @override
  String get settings_accentColorSubtitle => '为应用程序选择种子颜色';

  @override
  String get settings_appFont => '应用程序字体';

  @override
  String get settings_currency => '货币';

  @override
  String get settings_defaultCurrency => '默认货币';

  @override
  String get settings_preferences => '偏好';

  @override
  String get settings_weekStartsOn => '一周开始于';

  @override
  String get settings_monday => '星期一';

  @override
  String get settings_sunday => '周日';

  @override
  String get settings_hideBalance => '隐藏余额';

  @override
  String get settings_hideBalanceSubtitle => '显示••••• 而不是金额';

  @override
  String get settings_language => '语言';

  @override
  String get settings_profile => '简介';

  @override
  String get settings_displayName => '显示名称';

  @override
  String get settings_notSet => '未设置';

  @override
  String get settings_about => '关于';

  @override
  String get settings_version => '版本';

  @override
  String get settings_privacy => '隐私';

  @override
  String get settings_privacySubtitle => '所有数据存储在本地 — 100% 离线';

  @override
  String get settings_github => 'GitHub';

  @override
  String get settings_githubSubtitle => '查看源代码';

  @override
  String get settings_developer => '开发商';

  @override
  String get settings_developerSubtitle => '发现 Mina Android 的更多项目';

  @override
  String get settings_githubProfile => 'GitHub 简介';

  @override
  String get settings_developerWebsite => '开发者网站';

  @override
  String get settings_close => '关闭';

  @override
  String get settings_yourName => '你的名字';

  @override
  String get settings_cancel => '取消';

  @override
  String get settings_save => '保存';

  @override
  String recurring_expenses(Object count) {
    return '费用 ($count)';
  }

  @override
  String recurring_incomeList(Object count) {
    return '收入 ($count)';
  }

  @override
  String get recurring_monthly => '每月';

  @override
  String get recurring_weekly => '每周';

  @override
  String get recurring_noRecurringExpenses => '无经常性费用';

  @override
  String get recurring_noRecurringIncome => '没有经常性收入';

  @override
  String get recurring_addExpense => '添加费用';

  @override
  String get recurring_addIncome => '增加收入';

  @override
  String get recurring_tapPlusToAddOne => '点击 + 添加一个';

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
  String get recurring_overdue => '逾期了！';

  @override
  String get recurring_dueToday => '今天到期';

  @override
  String recurring_dueInDays(Object days) {
    return '${days}d 后到期';
  }

  @override
  String get recurring_edit => '编辑';

  @override
  String get recurring_skipBtn => '跳过';

  @override
  String recurring_nextDate(Object date) {
    return 'Next: $date';
  }

  @override
  String get recurring_pay => '支付';

  @override
  String get recurring_del => '德尔';

  @override
  String recurring_historyCount(Object count) {
    return '历史 ($count)';
  }

  @override
  String get recurring_paymentHistory => '付款历史';

  @override
  String get recurring_notificationPermissionDenied =>
      '通知权限被拒绝。在“设置”→“应用程序”→“费用”→“通知”中启用它。';

  @override
  String get recurring_remindMeAt => '提醒我';

  @override
  String get recurring_editRecurring => '编辑重复';

  @override
  String get recurring_addRecurring => '添加定期付款';

  @override
  String get recurring_name => '姓名';

  @override
  String get recurring_amountPerPayment => '每次付款金额';

  @override
  String recurring_firstDate(Object date) {
    return 'First: $date';
  }

  @override
  String recurring_lastDate(Object date) {
    return 'Last: $date';
  }

  @override
  String get recurring_noLastPaymentOngoing => '没有最后付款（正在进行中）';

  @override
  String get accounts_refreshExchangeRates => '刷新汇率';

  @override
  String get accounts_noAccounts => '没有账户';

  @override
  String get accounts_tapPlusToAddYourFirst => '点击 + 添加您的第一个帐户';

  @override
  String get accounts_fetchingExchangeRates => '正在获取汇率...';

  @override
  String get accounts_exchangeRatesUnavailable => '汇率不可用（离线）。余额以本国货币显示。';

  @override
  String get accounts_unknown => '未知';

  @override
  String accounts_ratesUpdated(Object timeStr) {
    return '费率已更新 $timeStr · 点击 ↺ 刷新';
  }

  @override
  String get accounts_goldCaps => '黄金';

  @override
  String get accounts_balance => '平衡';

  @override
  String get accounts_income => '收入';

  @override
  String get accounts_expense => '费用';

  @override
  String get accounts_txs => '发送';

  @override
  String get accounts_value => '价值';

  @override
  String get accounts_karat => '克拉';

  @override
  String accounts_pure(Object percentage) {
    return '$percentage% pure';
  }

  @override
  String get accounts_weightLabel => '重量';

  @override
  String get accounts_perGram => '每克';

  @override
  String get accounts_bank => '银行';

  @override
  String get accounts_cash => '现金';

  @override
  String get accounts_savings => '储蓄';

  @override
  String get accounts_creditCard => '信用卡';

  @override
  String get accounts_eWallet => '电子钱包';

  @override
  String get accounts_gold => '黄金';

  @override
  String get accounts_editAccount => '编辑帐户';

  @override
  String get accounts_addAccount => '添加新帐户';

  @override
  String get accounts_accountName => '帐户名称';

  @override
  String get accounts_weightInGrams => '重量（克）';

  @override
  String get accounts_initialBalance => '初始余额';

  @override
  String get accounts_wontCountTowardYourHome => '不会计入您的主屏幕总数';

  @override
  String get accounts_saveChanges => '保存更改';

  @override
  String get accounts_addAccountBtn => '添加帐户';

  @override
  String get accounts_fetchingGoldPrice => '获取黄金价格...';

  @override
  String get accounts_goldPriceUnavailable => '黄金价格不可用 — 检查您的连接';

  @override
  String lended_person_owesYou(Object name) {
    return '$name欠你';
  }

  @override
  String lended_person_youOwe(Object name) {
    return '你欠$name';
  }

  @override
  String get lended_person_allSettledUp => '一切都安排好了';

  @override
  String get lended_person_noRecordsYet => '还没有记录';

  @override
  String get lended_person_tapPlusToLog => '点击 + 记录借出或借入的资金';

  @override
  String get lended_person_name => '姓名';

  @override
  String get lended_person_notesOptional => '注释（可选）';

  @override
  String get lended_person_lent => '四旬期';

  @override
  String get lended_person_borrowed => '借用';

  @override
  String get lended_person_overdue => '逾期了！';

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
      '通知权限被拒绝。在“设置”→“应用程序”→“费用”→“通知”中启用它。';

  @override
  String get lended_person_remindMeAtPrompt => '提醒我';

  @override
  String get lended_person_editRecord => '编辑记录';

  @override
  String get lended_person_addRecord => '添加记录';

  @override
  String get lended_person_amount => '数量';

  @override
  String lended_person_dueColon(Object date) {
    return 'Due: $date';
  }

  @override
  String get lended_person_noDueDate => '没有截止日期';

  @override
  String get lended_person_setDueFirst => '首先设定截止日期';

  @override
  String get lended_person_notifiedOnDue => '您将在截止日期收到通知';

  @override
  String get lended_person_getNotifiedWhenDue => '到期时收到通知';

  @override
  String get lended_person_thatTimePassed => '今天的时间已经过去了——您很快就会收到通知。';

  @override
  String lended_person_notificationFiresOn(Object date, Object time) {
    return '通知于 $date $time 触发。';
  }

  @override
  String get lended_person_saveChangesBtn => '保存更改';

  @override
  String get lended_person_addRecordBtn => '添加记录';

  @override
  String get transactions_searchTransactions => '搜索交易...';

  @override
  String get transactions_all => '全部';

  @override
  String get transactions_income => '收入';

  @override
  String get transactions_expenses => '费用';

  @override
  String get transactions_lent => '四旬期';

  @override
  String get transactions_borrowed => '借用';

  @override
  String get transactions_noTransactions => '没有交易';

  @override
  String get transactions_tapPlusToAddOne => '点击 + 添加一个';

  @override
  String get transactions_today => '今天';

  @override
  String get transactions_yesterday => '昨天';

  @override
  String transactions_lentTo(Object name) {
    return '借给$name';
  }

  @override
  String transactions_borrowedFrom(Object name) {
    return '借自$name';
  }

  @override
  String get transactions_unknown => '未知';

  @override
  String transactions_due(Object date) {
    return 'Due $date';
  }

  @override
  String get transactions_unsettled => '未定';

  @override
  String get onboarding_restoreFailed => '恢复失败：文件可能已损坏或不是昂贵的备份。';

  @override
  String get onboarding_continue => '继续';

  @override
  String get onboarding_getStarted => '开始使用';

  @override
  String get onboarding_yourPersonalTracker =>
      '您的个人 100% 离线财务追踪器。\n已经有其他设备的备份或之前的安装？';

  @override
  String get onboarding_restoring => '正在恢复...';

  @override
  String get onboarding_chooseBackupFile => '选择备份文件';

  @override
  String get onboarding_letsGetYouSetUp => '让我们帮您设置';

  @override
  String get onboarding_yourName => '你的名字';

  @override
  String get onboarding_accountName => '帐户名称';

  @override
  String get onboarding_bank => '银行';

  @override
  String get onboarding_cash => '现金';

  @override
  String get onboarding_savings => '节省';

  @override
  String get onboarding_credit => '信用';

  @override
  String get onboarding_wallet => '钱包';

  @override
  String get onboarding_startingBalance => '起始余额';

  @override
  String get backup_replaceDataWarning => '这将用备份替换您当前的所有数据。\n此操作无法撤消。';

  @override
  String get backup_whatsIncluded => '包含什么';

  @override
  String get backup_backupDescription =>
      '每个备份都包含您的所有数据 - 帐户、交易、定期付款及其付款/跳过历史记录、预算、愿望清单项目、借出和借入人员和记录、资产、类别和应用程序设置。';

  @override
  String get backup_saving => '正在保存...';

  @override
  String get backup_saveBackup => '保存备份';

  @override
  String get backup_restoring => '正在恢复...';

  @override
  String get backup_restoreBackupBtn => '恢复备份';

  @override
  String get backup_restoreWarningText => '与任何应用程序版本的备份兼容。缺失的字段将使用安全默认值进行填充。';

  @override
  String get backup_included => '包括';

  @override
  String get backup_accounts => '账户';

  @override
  String get backup_transactions => '交易';

  @override
  String get backup_recurringPayments => '定期付款';

  @override
  String get backup_recurringHistory => '重复出现的历史';

  @override
  String get backup_budgets => '预算';

  @override
  String get backup_wishlist => '愿望清单';

  @override
  String get backup_lentPeople => '借出/借用 — 人';

  @override
  String get backup_lentRecords => '借出/借用 — 记录';

  @override
  String get backup_assets => '资产';

  @override
  String get backup_categories => '类别';

  @override
  String get backup_settings => '设置';

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
    return '（从 v$originalVersion → v$schemaVersion 升级）';
  }

  @override
  String backup_dataRestoredSuccessfully(Object vLabel) {
    return '数据恢复成功！$vLabel';
  }

  @override
  String backup_restoreFailed(Object error) {
    return 'Restore failed: $error';
  }

  @override
  String get backup_restoreFailedCorrupted => '恢复失败：文件可能已损坏或不是昂贵的备份。';

  @override
  String get budget_noBudgetsYet => '还没有预算';

  @override
  String get budget_tapToAddBudget => '点击 + 设置每个类别的支出限额';

  @override
  String get budget_budgeted => '预算';

  @override
  String get budget_leftToSpend => '剩余可用额度';

  @override
  String get budget_spent => '已用';

  @override
  String get budget_overLimit => '超过限制';

  @override
  String get budget_unknown => '未知';

  @override
  String get budget_weeklyLabel => '每周';

  @override
  String get budget_monthlyLabel => '每月';

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
    return '使用了 $percent%';
  }

  @override
  String get budget_editBudget => '编辑预算';

  @override
  String get budget_setBudget => '添加新预算';

  @override
  String get budget_budgetAmount => '预算金额';

  @override
  String budget_previewFor(Object catName) {
    return '“$catName”的预览';
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
  String get budget_saveChanges => '保存更改';

  @override
  String get budget_budget => '预算';

  @override
  String get budget_rollover => '滚存 (信封预算)';

  @override
  String get budget_rolloverDesc => '将未使用的结余或超支顺延至下一周期';

  @override
  String get budget_rolloverBadge => '滚存';

  @override
  String budget_base(Object amount) {
    return '基础: $amount';
  }

  @override
  String budget_rolloverFrom(Object period, Object amount) {
    return '滚存 ($period): $amount';
  }

  @override
  String budget_totalAvailable(Object amount) {
    return '总可用: $amount';
  }

  @override
  String get budget_lastWeek => '上周';

  @override
  String get pacing_dailyBudget => '每日安全消费';

  @override
  String pacing_safeToSpend(Object amount, Object days) {
    return '安全消费额度：每天 $amount（剩余 $days 天）';
  }

  @override
  String pacing_caution(Object amount) {
    return '消费节奏偏快 — 建议控制在每天 $amount';
  }

  @override
  String get pacing_overPaced => '节奏预警 — 请放缓开支以保持在预算内';

  @override
  String get pacing_budgetExhausted => '预算已达上限 — 无剩余每日额度';

  @override
  String get pacing_onTrack => '节奏良好';

  @override
  String get pacing_fast => '节奏偏快';

  @override
  String get pacing_alert => '节奏预警';

  @override
  String pacing_daysLeft(Object days) {
    return '剩余 $days 天';
  }

  @override
  String get pacing_setBudgetPrompt => '点击设置预算限额 →';

  @override
  String get pacing_dailyAvgPace => '每日节奏';

  @override
  String pacing_perDay(Object amount) {
    return '$amount / 天';
  }

  @override
  String get calendar_title => '财务日历';

  @override
  String get calendar_subtitle => '每日支出热力图与到期提醒';

  @override
  String calendar_zeroSpendDays(Object count) {
    return '$count 个零支出日';
  }

  @override
  String get calendar_zeroSpendDayTitle => '零支出日达成！ 🎉';

  @override
  String get calendar_zeroSpendDayDesc => '非常棒的自律表现，今天没有任何支出。';

  @override
  String get calendar_billsDue => '到期账单与订阅';

  @override
  String get calendar_loansDue => '到期贷款还款';

  @override
  String get calendar_lendedDue => '预计收到的还款';

  @override
  String calendar_dayTransactions(Object count) {
    return '交易明细 ($count)';
  }

  @override
  String get calendar_noActivity => '该日期无交易或待办事项';

  @override
  String get calendar_today => '今天';

  @override
  String calendar_averageDaily(Object amount) {
    return '日均消费：$amount';
  }

  @override
  String get wrapped_title => 'Expensy Wrapped';

  @override
  String wrapped_bannerTitle(Object month) {
    return '您的 $month 月度账单已生成！';
  }

  @override
  String get wrapped_bannerSub => '点击查看您的月度财务回顾';

  @override
  String get wrapped_theBigPicture => '总体概况';

  @override
  String wrapped_howMoneyMoved(Object month) {
    return '以下是您在 $month 的资金流动';
  }

  @override
  String get wrapped_totalInflow => '总收入';

  @override
  String get wrapped_totalOutflow => '总支出';

  @override
  String get wrapped_netSavings => '净结余';

  @override
  String wrapped_savingsRate(Object rate) {
    return '储蓄率: $rate%';
  }

  @override
  String get wrapped_topCategoryTitle => '钱花在哪了？';

  @override
  String wrapped_topCategorySub(Object category) {
    return '您的最高支出类别是 $category';
  }

  @override
  String wrapped_topCategoryShare(Object percent) {
    return '占总支出的 $percent%';
  }

  @override
  String get wrapped_biggestSplurgeTitle => '最大单笔支出';

  @override
  String get wrapped_biggestSplurgeSub => '本月单笔最高支出';

  @override
  String get wrapped_noSplurge => '无大额支出！本月没有支出记录。';

  @override
  String get wrapped_heroHabitTitle => '优秀习惯';

  @override
  String wrapped_zeroSpendAchieved(Object count) {
    return '$count 天零支出';
  }

  @override
  String wrapped_heroHabitDesc(Object count) {
    return '您达成了 $count 天零支出记录。财务自律非常出色！';
  }

  @override
  String get wrapped_receiptTitle => '月度账单';

  @override
  String get wrapped_obscureToggle => '隐藏金额以便分享';

  @override
  String get wrapped_showToggle => '显示金额';

  @override
  String get wrapped_replay => '重播回顾';

  @override
  String get insights_other => '其他';

  @override
  String get insights_noDataYet => '还没有数据';

  @override
  String get insights_addSomeTransactions => '添加一些交易以查看见解';

  @override
  String get insights_thisMonthVsLastMonth => '本月与上个月';

  @override
  String get insights_dailyAverage => '每日平均';

  @override
  String insights_perDayBasedOn(Object days) {
    return '每天 · 基于本月 $days 天';
  }

  @override
  String get insights_incomeVsExpenses => '收入与支出';

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
    return '本月节省了 $percent%';
  }

  @override
  String get insights_topSpendingCategories => '最高支出类别';

  @override
  String insights_percentOfTotal(Object percent) {
    return '占总数的 $percent%';
  }

  @override
  String get insights_biggestExpenseThisMonth => '本月最大开支';

  @override
  String get insights_categoryTrends => '类别趋势（与上个月相比）';

  @override
  String get insights_12MonthTrend => '12 个月趋势';

  @override
  String get insights_incomeLabel => '收入';

  @override
  String get insights_expensesLabel => '费用';

  @override
  String get categories_expenseLabel => '费用';

  @override
  String get categories_incomeLabel => '收入';

  @override
  String get categories_editCategory => '编辑类别';

  @override
  String get categories_addCategory => '添加类别';

  @override
  String get categories_categoryName => '类别名称';

  @override
  String get categories_saveChanges => '保存更改';

  @override
  String get statistics_other => '其他';

  @override
  String get statistics_allAccounts => '所有帐户';

  @override
  String get statistics_income => '收入';

  @override
  String get statistics_expenses => '费用';

  @override
  String get statistics_expense => '费用';

  @override
  String get statistics_net => '净';

  @override
  String statistics_6MonthOverviewAccount(Object accountName) {
    return '6 个月概览 · $accountName';
  }

  @override
  String get statistics_6MonthOverview => '6 个月概述';

  @override
  String statistics_percentOfBudget(Object percent) {
    return '预算的 $percent%';
  }

  @override
  String get add_transaction_editTransaction => '编辑交易';

  @override
  String get add_transaction_addTransaction => '输入交易';

  @override
  String get add_transaction_amount => '金额';

  @override
  String add_transaction_conversionPreview(Object accountName, Object amount) {
    return '≈ $amount 将从 $accountName 中扣除';
  }

  @override
  String get add_transaction_accountFallback => '帐户';

  @override
  String get add_transaction_descriptionOptional => '描述（可选）';

  @override
  String get add_transaction_noteOptional => '注意（可选）';

  @override
  String get add_transaction_saveChanges => '保存更改';

  @override
  String get more_statistics => '统计';

  @override
  String get more_statisticsSub => '图表和每月摘要';

  @override
  String get more_insights => '见解';

  @override
  String get more_insightsSub => '趋势、平均值和类别分析';

  @override
  String get more_currencyConverter => '货币转换器';

  @override
  String get more_currencyConverterSub => '货币之间即时转换';

  @override
  String get more_wishlist => '愿望清单';

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
  String get more_lentMoney => '借钱';

  @override
  String more_lentMoneySub(Object count) {
    return '$count 未完成';
  }

  @override
  String get more_assets => '资产';

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
  String get more_categories => '类别';

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
  String get more_exportTransactions => '出口交易';

  @override
  String get more_exportTransactionsSub => '另存为 Excel (.xlsx)';

  @override
  String get more_backupRestore => '备份与恢复';

  @override
  String get more_backupRestoreSub => '保存或加载您的数据';

  @override
  String get more_settings => '设置';

  @override
  String get more_settingsSub => '主题、货币和偏好';

  @override
  String get more_sectionTools => '金融工具';

  @override
  String get more_sectionAnalytics => '分析与洞察';

  @override
  String get more_sectionPreferences => '偏好与数据';

  @override
  String home_greeting(Object name) {
    return '嗨，$name 👋';
  }

  @override
  String get home_there => '那里';

  @override
  String get home_income => '收入';

  @override
  String get home_expenses => '费用';

  @override
  String get home_net => '净';

  @override
  String get wishlist_noItems => '没有愿望清单项目';

  @override
  String get wishlist_noItemsSub => '点击 + 添加您要保存的项目';

  @override
  String get wishlist_editItem => '编辑项目';

  @override
  String get wishlist_addWishlistItem => '添加愿望清单项目';

  @override
  String get wishlist_itemName => '商品名称';

  @override
  String get wishlist_targetPrice => '目标价格';

  @override
  String get wishlist_priorityLow => '低';

  @override
  String get wishlist_priorityMedium => '中等';

  @override
  String get wishlist_priorityHigh => '高';

  @override
  String get wishlist_notesOptional => '注释（可选）';

  @override
  String get wishlist_saveChanges => '保存更改';

  @override
  String get wishlist_addItem => '添加项目';

  @override
  String get wishlist_fundThisItem => '为心愿存钱';

  @override
  String wishlist_funded(int percent, String saved, String target) {
    return '已完成 $percent% ($saved / $target)';
  }

  @override
  String get wishlist_goalAchieved => '目标已达成 — 可以购买啦！';

  @override
  String get wishlist_buyNow => '立即购买';

  @override
  String get wishlist_purchaseTitle => '购买心愿单物品';

  @override
  String get wishlist_purchasePrompt => '是否要记录一笔支出交易并从账户扣除该金额？';

  @override
  String get wishlist_recordAndDeduct => '记账并扣款';

  @override
  String get wishlist_markPurchasedOnly => '仅标记为已购买';

  @override
  String wishlist_itemPurchased(String name) {
    return '已将「$name」标记为已购买！';
  }

  @override
  String get wishlist_viewGoal => '查看储蓄目标';

  @override
  String savings_linkedWishlist(String item) {
    return '已关联心愿单物品: $item';
  }

  @override
  String get lended_theyOweMe => '他们欠我';

  @override
  String get lended_iOweThem => '我欠他们';

  @override
  String get lended_net => '净';

  @override
  String get lended_noOneYet => '还没有人';

  @override
  String get lended_noOneYetSub => '点击 + 添加您借出或借出的人';

  @override
  String get lended_owesYou => '欠你的';

  @override
  String get lended_youOwe => '你欠';

  @override
  String get lended_settledUp => '已安顿';

  @override
  String get lended_noActiveRecords => '没有活动记录';

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
  String get lended_editPerson => '编辑人物';

  @override
  String get lended_addPerson => '添加人员';

  @override
  String get lended_name => '姓名';

  @override
  String get lended_notesOptional => '注释（可选）';

  @override
  String get lended_saveChanges => '保存更改';

  @override
  String get assets_totalAssets => '总资产';

  @override
  String get assets_items => '项目';

  @override
  String get assets_noAssetsYet => '还没有资产';

  @override
  String get assets_noAssetsYetSub => '点击 + 添加产品或资产';

  @override
  String get assets_editAsset => '编辑资产';

  @override
  String get assets_addAsset => '添加资产';

  @override
  String get assets_productAssetName => '产品/资产名称';

  @override
  String get assets_value => '价值';

  @override
  String get assets_notesOptional => '注释（可选）';

  @override
  String get assets_saveChanges => '保存更改';

  @override
  String get currency_converter_loadingRates => '正在加载汇率...';

  @override
  String get currency_converter_ratesUnavailable => '汇率不可用。连接到互联网并同步。';

  @override
  String get currency_converter_rateAgeJustNow => '刚才';

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
    return '$fromCurrency';
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
  String get transfer_exchangeRatesNotLoaded => '汇率未加载 — 金额将按原样转移';

  @override
  String get transfer_amount => '金额';

  @override
  String get transfer_noteOptional => '注意（可选）';

  @override
  String get export_from => '来自';

  @override
  String get export_to => '到';

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
  String get export_complete => '导出完成';

  @override
  String get export_exporting => '正在导出...';

  @override
  String get export_exportAsExcel => '导出为 Excel';

  @override
  String shared_widgets_deleteConfirm(Object name) {
    return '删除“$name”？此操作无法撤消。';
  }

  @override
  String get shared_widgets_searchByCode => '按代码或名称搜索...';

  @override
  String get accounts_accounts => '账户';

  @override
  String get accounts_totalBalance => '总余额';

  @override
  String get accounts_excluded => '已排除';

  @override
  String get accounts_goldPriceNotYetLoade => '黄金价格尚未加载。请稍等片刻再试。';

  @override
  String get accounts_accountType => '账户类型';

  @override
  String get accounts_currency => '货币';

  @override
  String get accounts_goldPurityKarat => '黄金纯度 (Karat)';

  @override
  String get accounts_weight => '重量';

  @override
  String get accounts_excludeFromTotalBala => '从总余额中排除';

  @override
  String get accounts_dontLinkToCard => '不与卡关联';

  @override
  String get accounts_dontLinkToCardDesc => '手动管理此账户余额并阻止卡与此账户关联';

  @override
  String get accounts_color => '颜色';

  @override
  String get accounts_liveGoldValue => '实时黄金价值';

  @override
  String get accounts_enterWeightAboveToSe => '在上方输入重量以查看价值';

  @override
  String get add_transaction_expense => '支出';

  @override
  String get add_transaction_income => '收入';

  @override
  String get add_transaction_account => '账户';

  @override
  String get add_transaction_category => '类别';

  @override
  String get assets_assets => '资产';

  @override
  String get backup_restoreBackup => '恢复备份？';

  @override
  String get backup_cancel => '取消';

  @override
  String get backup_replaceData => '替换数据';

  @override
  String get backup_backupRestore => '备份与恢复';

  @override
  String get backup_everythingAlways => '一切，永远';

  @override
  String get backup_createBackup => '创建备份';

  @override
  String get backup_saveAsJson => '另存为 JSON';

  @override
  String get backup_exportsAllAppDataToA => '将所有应用数据导出到便携文件';

  @override
  String get backup_restoreBackup_ => '恢复备份';

  @override
  String get backup_loadFromJson => '从 JSON 加载';

  @override
  String get backup_picksABackupFileAndR => '选择备份文件并恢复';

  @override
  String get backup_thisOverwritesAllCur => '这将覆盖所有当前数据。';

  @override
  String get budget_budgets => '预算';

  @override
  String get budget_empty => '·';

  @override
  String get budget_overBudget => '超出预算';

  @override
  String get budget_thisCategoryAlreadyH => '该类别已有预算。点击编辑。';

  @override
  String get budget_period => '周期';

  @override
  String get budget_monthly => '每月';

  @override
  String get budget_weekly => '每周';

  @override
  String get budget_category => '类别';

  @override
  String get categories_categories => '类别';

  @override
  String get categories_expense => '支出';

  @override
  String get categories_income => '收入';

  @override
  String get categories_color => '颜色';

  @override
  String get categories_icon => '图标';

  @override
  String get categories_autoBasedOnName => '自动 (基于名称)';

  @override
  String get categories_expenseCategories => '支出类别';

  @override
  String get categories_incomeCategories => '收入类别';

  @override
  String get currency_converter_currencyConverter => '货币转换器';

  @override
  String get currency_converter_amount => '金额';

  @override
  String get currency_converter_convertedTo => '转换为';

  @override
  String get export_exportTransactions => '导出交易';

  @override
  String get export_dateRange => '日期范围';

  @override
  String get export_formatExcelXlsx => '格式：Excel (.xlsx)';

  @override
  String get export_exportAsPdf => '导出为 PDF 报告';

  @override
  String get export_formatPdf => '格式: PDF 财务报告 (.pdf)';

  @override
  String get export_pdfGenerating => '正在生成 PDF...';

  @override
  String get export_pdfTitle => '财务报告';

  @override
  String get export_pdfSummary => '财务摘要';

  @override
  String get export_pdfInflow => '总收入';

  @override
  String get export_pdfOutflow => '总支出';

  @override
  String get export_pdfNet => '净结余';

  @override
  String get export_pdfSavingsRate => '储蓄率';

  @override
  String get export_pdfCategoryBreakdown => '分类支出明细';

  @override
  String get export_pdfTransactions => '交易流水明细';

  @override
  String get export_pdfNetWorthBreakdown => '资产与负债概览';

  @override
  String get export_pdfShare => '分享报告';

  @override
  String get export_pdfPrint => '打印 / 预览';

  @override
  String get export_pdfGeneratedBy => '由 Expensy 生成 • 私密且离线';

  @override
  String get home_totalBalance => '总余额';

  @override
  String get home_accounts => '账户';

  @override
  String get home_recentTransactions => '近期交易';

  @override
  String get home_noTransactionsYet => '暂无交易';

  @override
  String get home_add => '添加';

  @override
  String get home_goodMorning => '早上好';

  @override
  String get home_goodAfternoon => '下午好';

  @override
  String get home_goodEvening => '晚上好';

  @override
  String get home_transferAction => '转账';

  @override
  String get home_insightsAction => '洞察';

  @override
  String get home_calendarAction => '日历';

  @override
  String get home_forecastAction => '预测';

  @override
  String get home_manage => '管理';

  @override
  String get home_seeAll => '查看全部';

  @override
  String get home_addAccount => '添加账户';

  @override
  String get home_monthlyOverview => '月度概览';

  @override
  String get home_savingsRate => '储蓄率';

  @override
  String get insights_insights => '洞察';

  @override
  String get lended_person_deletePerson => '删除人员';

  @override
  String get lended_person_editPerson => '编辑人员';

  @override
  String get lended_person_color => '颜色';

  @override
  String get lended_person_saveChanges => '保存更改';

  @override
  String get lended_person_settled => '已结清';

  @override
  String get lended_person_settle => '结清';

  @override
  String get lended_person_setADueDateFirstToEn => '请先设置到期日期以启用提醒。';

  @override
  String get lended_person_iLent => '我借出';

  @override
  String get lended_person_iBorrowed => '我借入';

  @override
  String get lended_person_accountOptional => '账户 (可选)';

  @override
  String get lended_person_dueDateReminder => '到期提醒';

  @override
  String get lended_person_remindMeAt => '提醒我于';

  @override
  String get lended_person_active => '活跃';

  @override
  String get lended_person_settled_ => '已结清';

  @override
  String get lended_lentMoney => '借出的钱';

  @override
  String get lended_overdue => '逾期';

  @override
  String get lended_color => '颜色';

  @override
  String get more_more => '更多';

  @override
  String get onboarding_back => '返回';

  @override
  String get onboarding_welcomeToExpensy => '欢迎使用 Expensy！';

  @override
  String get onboarding_restoreABackup => '恢复备份';

  @override
  String get onboarding_loadAPreviouslySaved => '加载之前保存的 Expensy JSON 文件';

  @override
  String get onboarding_or => '或';

  @override
  String get onboarding_startFresh => '重新开始';

  @override
  String get onboarding_firstWhatShouldWeCal => '首先，我们怎么称呼您？';

  @override
  String get onboarding_defaultCurrency => '默认货币';

  @override
  String get onboarding_thisWillBeUsedAcross => '这将在整个应用中使用。\n您以后可以在设置中更改。';

  @override
  String get onboarding_searchAllCurrencies => '搜索所有货币';

  @override
  String get onboarding_yourFirstAccount => '您的第一个账户';

  @override
  String get onboarding_setUpYourMainAccount => '设置您的主账户以开始跟踪。';

  @override
  String get onboarding_accountType => '账户类型';

  @override
  String get onboarding_currency => '货币';

  @override
  String get onboarding_color => '颜色';

  @override
  String get recurring_recurring => '定期';

  @override
  String get recurring_income => '收入';

  @override
  String get recurring_2D => '−2天';

  @override
  String get recurring_skipNextPayment => '跳过下一次付款？';

  @override
  String get recurring_cancel => '取消';

  @override
  String get recurring_skip => '跳过';

  @override
  String get recurring_noHistoryYet => '暂无历史记录';

  @override
  String get recurring_expense => '支出';

  @override
  String get recurring_income_ => '收入';

  @override
  String get recurring_every => '每 ';

  @override
  String get recurring_days => '天';

  @override
  String get recurring_weeks => '周';

  @override
  String get recurring_months => '月';

  @override
  String get recurring_years => '年';

  @override
  String get recurring_payments => '付款';

  @override
  String get recurring_totalCost => '总费用';

  @override
  String get recurring_account => '账户';

  @override
  String get recurring_category => '类别';

  @override
  String get recurring_paymentReminder => '付款提醒';

  @override
  String get recurring_notificationWillFire => '通知将于下一次到期日在这个时间触发。';

  @override
  String get recurring_remind2DaysBefore => '提前 2 天提醒';

  @override
  String get statistics_statistics => '统计';

  @override
  String get statistics_expensesByCategory => '按类别支出';

  @override
  String get transactions_transactions => '交易';

  @override
  String get transactions_settled => '已结清';

  @override
  String get transfer_transfer => '转账';

  @override
  String get transfer_from => '从';

  @override
  String get transfer_to => '到';

  @override
  String get transfer_enterAnAmountToSeeTh => '输入金额以查看转换';

  @override
  String get wishlist_wishlist => '愿望清单';

  @override
  String get wishlist_priority => '优先级';

  @override
  String get shared_widgets_delete => '删除？';

  @override
  String get shared_widgets_cancel => '取消';

  @override
  String get shared_widgets_delete_ => '删除';

  @override
  String get shared_widgets_none => '无';

  @override
  String get shared_widgets_selectCurrency => '选择货币';

  @override
  String get main_home => '首页';

  @override
  String get main_transactions => '交易';

  @override
  String get main_recurring => '重复';

  @override
  String get main_accounts => '账户';

  @override
  String get main_budgets => '预算';

  @override
  String get main_more => '更多';

  @override
  String get onboarding_chooseLanguage => '选择语言';

  @override
  String get error_required => '此字段为必填项';

  @override
  String recurring_subscriptions(Object count) {
    return '订阅 ($count)';
  }

  @override
  String recurring_installments(Object count) {
    return '分期付款 ($count)';
  }

  @override
  String get recurring_recurringType => '重复类型';

  @override
  String get recurring_subscription => '订阅';

  @override
  String get recurring_installment => '分期付款';

  @override
  String get recurring_installmentsRequireEndDate => '分期付款必须有最终付款日期。';

  @override
  String get backup_importFromOtherApps => '从其他应用程序导入';

  @override
  String get backup_importDescription => '从支持的应用程序导入数据';

  @override
  String get backup_importFromGreenStash => '从 GreenStash (.json) 导入';

  @override
  String get backup_automaticBackup => '自动备份';

  @override
  String get backup_dailyAutoBackup => '每日自动备份';

  @override
  String backup_runsDailyAt(String time) {
    return '每天在 $time';
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
  String get backup_changeTime => '更改时间';

  @override
  String get backup_changeFolder => '更改文件夹';

  @override
  String get budget_budgetsAndGoals => '预算和目标';

  @override
  String get onboarding_restoreGreenStash => '从 GreenStash (.json) 恢复';

  @override
  String get savings_goalNotFound => '未找到目标';

  @override
  String get savings_savedSoFar => '到目前为止已保存';

  @override
  String get savings_target => '目标';

  @override
  String savings_targetDate(String date) {
    return 'Target Date: $date';
  }

  @override
  String get savings_contribute => '贡献';

  @override
  String get savings_withdraw => '提取';

  @override
  String get savings_noAccounts => '没有可用的帐户。请先添加一个帐户。';

  @override
  String get settings_budgetAlerts => '预算提醒';

  @override
  String get settings_budgetAlertsSub => '达到预算或目标时通知';

  @override
  String get settings_dailyReminder => '每日提醒';

  @override
  String get settings_dailyReminderSub => '每天提醒记录交易';

  @override
  String get settings_reminderTime => '提醒时间';

  @override
  String get settings_hapticFeedback => '触觉反馈';

  @override
  String get settings_hapticFeedbackSub => '互动时振动';

  @override
  String get savings_saveGoal => '保存目标';

  @override
  String get more_loans => '贷款';

  @override
  String more_loansSub(num count) {
    return '活跃贷款';
  }

  @override
  String get loans_title => '贷款';

  @override
  String get loans_addLoan => '添加贷款';

  @override
  String get loans_editLoan => '编辑贷款';

  @override
  String get loans_loanName => '贷款名称';

  @override
  String get loans_amount => '金额';

  @override
  String get loans_startDate => '开始日期';

  @override
  String get loans_endDate => '结束日期';

  @override
  String get loans_interestRateOptional => '利率（可选）';

  @override
  String get loans_account => '关联账户';

  @override
  String get loans_monthlyPayment => '每月还款';

  @override
  String get loans_totalPayable => '应还总额';

  @override
  String get loans_remaining => '剩余';

  @override
  String get loans_paid => '已还';

  @override
  String get loans_logPayment => '记录还款';

  @override
  String get loans_paymentReminder => '还款提醒';

  @override
  String get loans_reminderDay => '提醒日期';

  @override
  String get loans_notes => '备注';

  @override
  String get loans_saveLoan => '保存贷款';

  @override
  String get loans_deleteLoan => '删除贷款';

  @override
  String get loans_settled => '已结清';

  @override
  String loans_durationMonths(num count) {
    return '个月';
  }

  @override
  String get loans_paymentHistory => '还款记录';

  @override
  String get loans_noPayments => '暂无还款记录';

  @override
  String get loans_outstandingDebt => '未还债务';

  @override
  String get loans_monthlyObligation => '每月应还';

  @override
  String get insights_loans => '贷款';

  @override
  String get backup_loans => '贷款';

  @override
  String get backup_loanPayments => '贷款还款';

  @override
  String get more_yearlyAnalysis => '年度分析';

  @override
  String get more_yearlyAnalysisSub => '逐月现金流预测';

  @override
  String get yearly_title => '年度分析';

  @override
  String get yearly_recurringExp => '定期支出';

  @override
  String get yearly_recurringInc => '定期收入';

  @override
  String get yearly_loans => '贷款还款';

  @override
  String get yearly_borrowed => '借入到期';

  @override
  String get yearly_lentDue => '借出到期';

  @override
  String get yearly_inflow => '流入';

  @override
  String get yearly_outflow => '流出';

  @override
  String get yearly_netFlow => '净流量';

  @override
  String get yearly_totalInflow => '总流入';

  @override
  String get yearly_totalOutflow => '总流出';

  @override
  String get yearly_netCashFlow => '净现金流';

  @override
  String get yearly_noData => '暂无预测活动';

  @override
  String get yearly_noDataSub => '添加定期付款或贷款以查看预测';

  @override
  String get budget_addBudget => '添加预算';

  @override
  String get budget_addGoal => '添加储蓄目标';

  @override
  String get add_transaction_possibleDuplicate => '可能是重复交易';

  @override
  String get add_transaction_goBack => '返回';

  @override
  String get add_transaction_saveAnyway => '仍然保存';

  @override
  String get loans_confirmDeleteLoan => '确定要删除此贷款及其所有还款记录吗？';

  @override
  String get loans_deletePayment => '删除还款';

  @override
  String get loans_confirmDeletePayment => '确定要删除此还款记录吗？';

  @override
  String get split_transactions_title => '拆分分类';

  @override
  String get split_transactions_badge => '拆分';

  @override
  String get split_transactions_addSplit => '添加拆分';

  @override
  String get split_transactions_removeSplit => '删除拆分';

  @override
  String get split_transactions_allocated => '已分配';

  @override
  String get split_transactions_remaining => '剩余';

  @override
  String get split_transactions_fillRemaining => '填满剩余';

  @override
  String get split_transactions_breakdown => '拆分明细';

  @override
  String get split_transactions_mismatchError => '拆分金额必须等于总金额。';

  @override
  String get netWorth_title => '净资产';

  @override
  String get netWorth_subtitle => '跟踪总资产、负债和财富随时间的变化';

  @override
  String get netWorth_current => '当前净资产';

  @override
  String get netWorth_trend => '净资产走势';

  @override
  String get netWorth_totalAssets => '总资产';

  @override
  String get netWorth_totalLiabilities => '总负债';

  @override
  String get netWorth_liquidCash => '现金与银行账户';

  @override
  String get netWorth_goldValuation => '实物黄金';

  @override
  String get netWorth_fixedAssets => '房产与投资';

  @override
  String get netWorth_moneyLent => '借出款项（应收款）';

  @override
  String get netWorth_creditDebt => '信用卡与透支';

  @override
  String get netWorth_loanDebt => '应付贷款';

  @override
  String get netWorth_moneyBorrowed => '借入款项（应付款）';

  @override
  String get netWorth_assetBreakdown => '资产分布';

  @override
  String get netWorth_liabilityBreakdown => '负债分布';

  @override
  String get netWorth_noHistory => '随着记录每日快照，净资产历史将随时间自动建立。';

  @override
  String get netWorth_debtRatio => '负债率';

  @override
  String get netWorth_quickActions => '快捷操作';

  @override
  String get netWorth_history => '快照历史';

  @override
  String get creditCard_utilization => '额度使用率';

  @override
  String get creditCard_availableCredit => '可用额度';

  @override
  String get creditCard_limit => '信用额度';

  @override
  String get creditCard_statementBalance => '账单金额';

  @override
  String get creditCard_unbilledBalance => '未出账单';

  @override
  String get creditCard_payBill => '偿还信用卡';

  @override
  String get creditCard_allCaughtUp => '已全额还清！暂无待还账单';

  @override
  String get creditCard_payBillTitle => '还款信用卡账单';

  @override
  String get creditCard_payFromAccount => '扣款账户';

  @override
  String get creditCard_paymentAmount => '还款金额';

  @override
  String get creditCard_fullStatement => '账单金额';

  @override
  String get creditCard_fullBalance => '总欠款';

  @override
  String get creditCard_minPayment => '最低还款额';

  @override
  String get creditCard_customAmount => '自定义金额';

  @override
  String creditCard_paymentSuccess(String amount, String cardName) {
    return '已向 $cardName 还款 $amount';
  }

  @override
  String get creditCard_insufficientFunds => '还款金额超过可用余额';

  @override
  String get creditCard_invalidAmount => '请输入有效的还款金额';

  @override
  String get onboarding_skipForNow => '暂时跳过';

  @override
  String get onboarding_addCard => '添加卡片';

  @override
  String get onboarding_skipCardDesc => '如果您现在不想添加卡片，可以跳过此步骤。';

  @override
  String get onboarding_cardNameLabel => '卡片名称（例如：Visa 白金卡）';

  @override
  String get onboarding_debitCard => '借记卡';

  @override
  String get onboarding_creditLimit => '信用额度';

  @override
  String get onboarding_amountUsed => '已用金额';

  @override
  String get accounts_cardHolderOptional => '持卡人姓名（可选）';

  @override
  String get accounts_last4Digits => '卡号后4位';

  @override
  String get accounts_expiryDate => '到期日 (MM/YY)';

  @override
  String get accounts_creditLimitOptional => '信用额度（可选）';

  @override
  String get accounts_minPaymentOptional => '最低还款额（可选）';

  @override
  String get accounts_statementDayOptional => '账单日（可选）';

  @override
  String get accounts_statementDayExample => '例如：20';

  @override
  String get accounts_dueDayOptional => '还款日（可选）';

  @override
  String get accounts_dueDayExample => '例如：10';

  @override
  String get accounts_linkedAccountOptional => '关联银行账户（可选）';

  @override
  String get accounts_excludeCardBalance => '从账户总余额中排除卡片余额';

  @override
  String get accounts_excludeCardBalanceDesc => '此卡片的余额不会计入关联的银行账户总额。';

  @override
  String get accounts_cardHolderHeader => '持卡人';

  @override
  String get accounts_expHeader => '到期';

  @override
  String get accounts_notifyOnDueDate => '将在还款日向您发送提醒';

  @override
  String get accounts_notifyWhenDue => '在还款到期时接收提醒';

  @override
  String get accounts_remind2DaysBeforeDesc => '在还款到期前 2 天接收提前提醒';

  @override
  String get accounts_targetSaved => '目标 / 已存';

  @override
  String transactions_selectedCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已选择 $count 项',
    );
    return '$_temp0';
  }

  @override
  String get transactions_changeCategory => '更改分类';

  @override
  String get transactions_deleteSelected => '删除选中项';

  @override
  String get transactions_advancedFilters => '高级筛选';

  @override
  String get transactions_clearAll => '清空全部';

  @override
  String get transactions_amountRange => '金额范围';

  @override
  String get transactions_minAmount => '最小金额';

  @override
  String get transactions_maxAmount => '最大金额';

  @override
  String get transactions_applyFilters => '应用筛选';

  @override
  String get presets_new => '新建';

  @override
  String get presets_presetName => '预设名称（例如：早晨咖啡）';

  @override
  String get presets_defaultAmount => '默认金额';

  @override
  String get savings_goalName => '目标名称';

  @override
  String get savings_goalNameHint => '例如：新车、度假';

  @override
  String get savings_targetAmount => '目标金额';

  @override
  String get savings_targetDateOptional => '目标日期（可选）';

  @override
  String get savings_selectDate => '选择日期';

  @override
  String get savings_amountRequired => '金额不能为空';

  @override
  String get savings_noteOptional => '备注（可选）';

  @override
  String get loans_skipInstallment => '跳过下一次贷款还款？';

  @override
  String get recurring_confirmDelete => '确定要删除此周期性付款吗？';

  @override
  String get export_formatExcelOption => 'Excel (.xlsx)';

  @override
  String get export_formatPdfOption => 'PDF 财务报告';

  @override
  String get export_pdfNoTransactions => '在所选日期范围内未记录任何交易。';

  @override
  String get savings_saved => '已存';

  @override
  String get export_pdfDate => '日期';

  @override
  String get export_pdfDescription => '描述';

  @override
  String get accounts_noCardsYet => '无卡片';

  @override
  String get accounts_tapToAddCard => '点击 + 添加第一张卡片';

  @override
  String get savings_noGoalsYet => '暂无储蓄目标';

  @override
  String get savings_tapToAddGoal => '点击 + 设定新目标';

  @override
  String get netWorth_recordSnapshot => '记录快照';

  @override
  String get netWorth_snapshotRecorded => '快照已记录';

  @override
  String get savings_noContributionsYet => '暂无存入记录';

  @override
  String get creditCard_closesStatementBillingCycle => '结清当期对账单计费周期';

  @override
  String get creditCard_clearsTotalDebt => '全额还清卡片所有欠款';

  @override
  String get creditCard_requiredMinPayment => '最低还款额';

  @override
  String get creditCard_specifyCustomAmount => '指定自定义还款金额';

  @override
  String common_itemDeleted(String name) {
    return '已删除 \"$name\"';
  }

  @override
  String get common_accountDeleted => '账户已删除';

  @override
  String get common_cardDeleted => '卡片已删除';

  @override
  String get common_transactionDeleted => '交易已删除';

  @override
  String get common_recordDeleted => '记录已删除';

  @override
  String get common_paymentDeleted => '付款已删除';

  @override
  String get loans_skippedInstallment => '已跳过本期贷款分期';

  @override
  String loans_loggedPayment(String amount) {
    return '已记录 $amount 的还款';
  }

  @override
  String get loans_notificationsPermissionRequired => '需要通知权限';

  @override
  String get creditCard_selectFundingAccount => '请选择扣款账户';

  @override
  String get presets_presetUpdated => '预设已更新';

  @override
  String get presets_presetAdded => '预设已添加';

  @override
  String get presets_presetDeleted => '预设已删除';

  @override
  String transactions_deletedCount(int count) {
    return '已删除 $count 个项目';
  }

  @override
  String get split_atLeastTwoCategories => '拆分至少需要 2 个类别。';

  @override
  String get split_categoryAndAmountRequired => '每个拆分项必须有类别且金额大于 0。';

  @override
  String get presets_addQuickPresets => '添加一键快捷预设';

  @override
  String get presets_quickPresetsDesc => '一键记录日常咖啡、通勤或用餐';

  @override
  String presets_loggedPreset(String title, String amount) {
    return '已记录 $title ($amount)';
  }

  @override
  String get presets_createPreset => '创建预设';

  @override
  String get presets_editQuickPreset => '编辑快捷预设';

  @override
  String get presets_newQuickPreset => '新建快捷预设';

  @override
  String get savings_addContribution => '存入资金';

  @override
  String get savings_withdrawFromGoal => '从目标取出';

  @override
  String get savings_contribution => '存入';

  @override
  String get savings_withdrawal => '取款';

  @override
  String get savings_unknownAccount => '未知账户';

  @override
  String get savings_fromAccount => '转出账户';

  @override
  String get savings_toAccount => '转入账户';

  @override
  String get presets_quickLog => '快捷记录';

  @override
  String accounts_dueOnDay(int day) {
    return '到期日：$day号';
  }
}
