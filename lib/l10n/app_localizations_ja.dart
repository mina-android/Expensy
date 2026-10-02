// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '経費';

  @override
  String get settings_title => '設定';

  @override
  String get settings_appearance => '外観';

  @override
  String get settings_theme => 'テーマ';

  @override
  String get settings_system => 'システム';

  @override
  String get settings_light => 'ライト';

  @override
  String get settings_dark => 'ダーク';

  @override
  String get settings_amoledTitle => 'ピュアブラック (AMOLED)';

  @override
  String get settings_amoledSubtitle => 'ダーク モードで強制的に黒の背景を表示します';

  @override
  String get settings_systemDefault => 'システムデフォルト';

  @override
  String get settings_dynamicColor => 'ダイナミックカラー';

  @override
  String get settings_dynamicColorSubtitle => 'システムの壁紙の色を使用する';

  @override
  String get settings_accentColor => 'アクセントカラー';

  @override
  String get settings_accentColorSubtitle => 'アプリのシード カラーを選択します';

  @override
  String get settings_appFont => 'アプリのフォント';

  @override
  String get settings_currency => '通貨';

  @override
  String get settings_defaultCurrency => 'デフォルトの通貨';

  @override
  String get settings_preferences => '設定';

  @override
  String get settings_weekStartsOn => '週の開始日';

  @override
  String get settings_monday => '月曜日';

  @override
  String get settings_sunday => '日曜日';

  @override
  String get settings_hideBalance => '残高を非表示にする';

  @override
  String get settings_hideBalanceSubtitle => '金額の代わりに ••••• を表示';

  @override
  String get settings_language => '言語';

  @override
  String get settings_profile => 'プロフィール';

  @override
  String get settings_displayName => '表示名';

  @override
  String get settings_notSet => '未設定';

  @override
  String get settings_about => '概要';

  @override
  String get settings_version => 'バージョン';

  @override
  String get settings_privacy => 'プライバシー';

  @override
  String get settings_privacySubtitle => 'すべてのデータはローカルに保存されます - 100% オフライン';

  @override
  String get settings_github => 'GitHub';

  @override
  String get settings_githubSubtitle => 'ソース コードを表示';

  @override
  String get settings_developer => '開発者';

  @override
  String get settings_developerSubtitle => 'mina Android による他のプロジェクトを発見';

  @override
  String get settings_githubProfile => 'GitHub プロファイル';

  @override
  String get settings_developerWebsite => '開発者ウェブサイト';

  @override
  String get settings_close => '閉じる';

  @override
  String get settings_yourName => 'あなたの名前';

  @override
  String get settings_cancel => 'キャンセル';

  @override
  String get settings_save => '保存';

  @override
  String recurring_expenses(Object count) {
    return '経費 ($count)';
  }

  @override
  String recurring_incomeList(Object count) {
    return '収入 ($count)';
  }

  @override
  String get recurring_monthly => '毎月';

  @override
  String get recurring_weekly => '毎週';

  @override
  String get recurring_noRecurringExpenses => '経常経費なし';

  @override
  String get recurring_noRecurringIncome => '経常収入なし';

  @override
  String get recurring_addExpense => '経費を追加';

  @override
  String get recurring_addIncome => '収入を追加';

  @override
  String get recurring_tapPlusToAddOne => '+ をタップして 1 つ追加します';

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
  String get recurring_overdue => '期限を過ぎました！';

  @override
  String get recurring_dueToday => '今日が期限';

  @override
  String recurring_dueInDays(Object days) {
    return 'Due in ${days}d';
  }

  @override
  String get recurring_edit => '編集';

  @override
  String get recurring_skipBtn => 'スキップ';

  @override
  String recurring_nextDate(Object date) {
    return 'Next: $date';
  }

  @override
  String get recurring_pay => '支払う';

  @override
  String get recurring_del => 'デル';

  @override
  String recurring_historyCount(Object count) {
    return '履歴 ($count)';
  }

  @override
  String get recurring_paymentHistory => '支払い履歴';

  @override
  String get recurring_notificationPermissionDenied =>
      '通知の許可が拒否されました。 「設定」→「アプリ」→「経費」→「通知」で有効にします。';

  @override
  String get recurring_remindMeAt => '';

  @override
  String get recurring_editRecurring => 'でリマインドしてください定期的な編集';

  @override
  String get recurring_addRecurring => '定期支払いを追加する';

  @override
  String get recurring_name => '名前';

  @override
  String get recurring_amountPerPayment => '支払いごとの金額';

  @override
  String recurring_firstDate(Object date) {
    return 'First: $date';
  }

  @override
  String recurring_lastDate(Object date) {
    return 'Last: $date';
  }

  @override
  String get recurring_noLastPaymentOngoing => '最終支払いなし (継続中)';

  @override
  String get accounts_refreshExchangeRates => '為替レートを更新します';

  @override
  String get accounts_noAccounts => 'アカウントがありません';

  @override
  String get accounts_tapPlusToAddYourFirst => '[+] をタップして最初のアカウントを追加します';

  @override
  String get accounts_fetchingExchangeRates => '為替レートを取得中…';

  @override
  String get accounts_exchangeRatesUnavailable =>
      '為替レートは利用できません (オフライン)。残高は自国通貨で表示されます。';

  @override
  String get accounts_unknown => '不明';

  @override
  String accounts_ratesUpdated(Object timeStr) {
    return '料金が更新されました $timeStr · ↺ をタップして更新します';
  }

  @override
  String get accounts_goldCaps => 'ゴールド';

  @override
  String get accounts_balance => 'バランス';

  @override
  String get accounts_income => '所得';

  @override
  String get accounts_expense => '経費';

  @override
  String get accounts_txs => '送信';

  @override
  String get accounts_value => '値';

  @override
  String get accounts_karat => 'カラット';

  @override
  String accounts_pure(Object percentage) {
    return '$percentage% pure';
  }

  @override
  String get accounts_weightLabel => '体重';

  @override
  String get accounts_perGram => 'グラムあたり';

  @override
  String get accounts_bank => '銀行';

  @override
  String get accounts_cash => '現金';

  @override
  String get accounts_savings => '貯蓄';

  @override
  String get accounts_creditCard => 'クレジットカード';

  @override
  String get accounts_eWallet => '電子ウォレット';

  @override
  String get accounts_gold => 'ゴールド';

  @override
  String get accounts_editAccount => 'アカウントを編集';

  @override
  String get accounts_addAccount => '新しいアカウントを追加';

  @override
  String get accounts_accountName => 'アカウント名';

  @override
  String get accounts_weightInGrams => '重量 (グラム)';

  @override
  String get accounts_initialBalance => '初期残高';

  @override
  String get accounts_wontCountTowardYourHome => 'ホーム画面の合計にはカウントされません';

  @override
  String get accounts_saveChanges => '変更を保存';

  @override
  String get accounts_addAccountBtn => 'アカウントを追加';

  @override
  String get accounts_fetchingGoldPrice => '金の価格を調べ中…';

  @override
  String get accounts_goldPriceUnavailable => 'ゴールド価格を利用できません — 接続を確認してください';

  @override
  String lended_person_owesYou(Object name) {
    return '$name はあなたに借りがあります';
  }

  @override
  String lended_person_youOwe(Object name) {
    return 'あなたには $name の借りがあります';
  }

  @override
  String get lended_person_allSettledUp => 'すべて解決しました';

  @override
  String get lended_person_noRecordsYet => 'まだ記録がありません';

  @override
  String get lended_person_tapPlusToLog => '+ をタップして、お金の貸し借りを記録します';

  @override
  String get lended_person_name => '名前';

  @override
  String get lended_person_notesOptional => '注記 (オプション)';

  @override
  String get lended_person_lent => '四旬節';

  @override
  String get lended_person_borrowed => '借りました';

  @override
  String get lended_person_overdue => '期限を過ぎました！';

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
      '通知の許可が拒否されました。 「設定」→「アプリ」→「経費」→「通知」で有効にします。';

  @override
  String get lended_person_remindMeAtPrompt => '';

  @override
  String get lended_person_editRecord => 'でリマインドしてくださいレコードの編集';

  @override
  String get lended_person_addRecord => 'レコードを追加';

  @override
  String get lended_person_amount => '額';

  @override
  String lended_person_dueColon(Object date) {
    return 'Due: $date';
  }

  @override
  String get lended_person_noDueDate => '期限なし';

  @override
  String get lended_person_setDueFirst => '最初に期日を設定してください';

  @override
  String get lended_person_notifiedOnDue => '期日には通知されます';

  @override
  String get lended_person_getNotifiedWhenDue => '期限が近づいたら通知を受け取ります';

  @override
  String get lended_person_thatTimePassed =>
      '今日のその時間はすでに過ぎています。代わりに、すぐに通知されます。';

  @override
  String lended_person_notificationFiresOn(Object date, Object time) {
    return '通知は $date の $time に発生します。';
  }

  @override
  String get lended_person_saveChangesBtn => '変更を保存';

  @override
  String get lended_person_addRecordBtn => 'レコードを追加';

  @override
  String get transactions_searchTransactions => 'トランザクションを検索...';

  @override
  String get transactions_all => 'すべて';

  @override
  String get transactions_income => '収入';

  @override
  String get transactions_expenses => '経費';

  @override
  String get transactions_lent => '四旬節';

  @override
  String get transactions_borrowed => '借りました';

  @override
  String get transactions_noTransactions => '取引はありません';

  @override
  String get transactions_tapPlusToAddOne => '+ をタップして 1 つ追加します';

  @override
  String get transactions_today => '今日';

  @override
  String get transactions_yesterday => '昨日';

  @override
  String transactions_lentTo(Object name) {
    return 'Lent to $name';
  }

  @override
  String transactions_borrowedFrom(Object name) {
    return '$name から借用';
  }

  @override
  String get transactions_unknown => '不明';

  @override
  String transactions_due(Object date) {
    return 'Due $date';
  }

  @override
  String get transactions_unsettled => '不安定';

  @override
  String get onboarding_restoreFailed =>
      '復元に失敗しました: ファイルが破損しているか、Expensy のバックアップではない可能性があります。';

  @override
  String get onboarding_continue => '続行';

  @override
  String get onboarding_getStarted => '始めましょう';

  @override
  String get onboarding_yourPersonalTracker =>
      'あなた専用の 100% オフライン財務トラッカー。\n別のデバイスまたは以前のインストールからのバックアップがすでにありますか?';

  @override
  String get onboarding_restoring => '復元中...';

  @override
  String get onboarding_chooseBackupFile => 'バックアップファイルの選択';

  @override
  String get onboarding_letsGetYouSetUp => 'セットアップしましょう';

  @override
  String get onboarding_yourName => 'あなたの名前';

  @override
  String get onboarding_accountName => 'アカウント名';

  @override
  String get onboarding_bank => '銀行';

  @override
  String get onboarding_cash => '現金';

  @override
  String get onboarding_savings => '節約';

  @override
  String get onboarding_credit => 'クレジット';

  @override
  String get onboarding_wallet => '財布';

  @override
  String get onboarding_startingBalance => '開始残高';

  @override
  String get backup_replaceDataWarning =>
      'これにより、現在のデータがすべてバックアップに置き換えられます。\nこれを元に戻すことはできません。';

  @override
  String get backup_whatsIncluded => '含まれるもの';

  @override
  String get backup_backupDescription =>
      'すべてのバックアップには、アカウント、トランザクション、定期的な支払いとその支払い/スキップ履歴、予算、ウィッシュリストの項目、貸し借りした人と記録、資産、カテゴリ、アプリ設定など、すべてのデータが含まれます。';

  @override
  String get backup_saving => '保存しています...';

  @override
  String get backup_saveBackup => 'バックアップを保存';

  @override
  String get backup_restoring => '復元中...';

  @override
  String get backup_restoreBackupBtn => 'バックアップを復元';

  @override
  String get backup_restoreWarningText =>
      'どのバージョンのアプリからのバックアップとも互換性があります。欠落しているフィールドには安全なデフォルト値が入力されます。';

  @override
  String get backup_included => '含まれています';

  @override
  String get backup_accounts => 'アカウント';

  @override
  String get backup_transactions => '取引';

  @override
  String get backup_recurringPayments => '定期的な支払い';

  @override
  String get backup_recurringHistory => '繰り返される履歴';

  @override
  String get backup_budgets => '予算';

  @override
  String get backup_wishlist => 'ウィッシュリスト';

  @override
  String get backup_lentPeople => '貸したり借りたり — 人';

  @override
  String get backup_lentRecords => '貸したり借りたり — 記録';

  @override
  String get backup_assets => '資産';

  @override
  String get backup_categories => 'カテゴリ';

  @override
  String get backup_settings => '設定';

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
    return '(v$originalVersion → v$schemaVersion からアップグレード)';
  }

  @override
  String backup_dataRestoredSuccessfully(Object vLabel) {
    return 'データは正常に復元されました!$vLabel';
  }

  @override
  String backup_restoreFailed(Object error) {
    return 'Restore failed: $error';
  }

  @override
  String get backup_restoreFailedCorrupted =>
      '復元に失敗しました: ファイルが破損しているか、Expensy のバックアップではない可能性があります。';

  @override
  String get budget_noBudgetsYet => 'まだ予算がありません';

  @override
  String get budget_tapToAddBudget => '[+] をタップしてカテゴリごとの支出制限を設定します';

  @override
  String get budget_budgeted => '予算が決まっています';

  @override
  String get budget_leftToSpend => '利用可能残高';

  @override
  String get budget_spent => '費やしました';

  @override
  String get budget_overLimit => 'オーバーリミット';

  @override
  String get budget_unknown => '不明';

  @override
  String get budget_weeklyLabel => '毎週';

  @override
  String get budget_monthlyLabel => '毎月';

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
  String get budget_editBudget => '予算を編集';

  @override
  String get budget_setBudget => '新しい予算を追加';

  @override
  String get budget_budgetAmount => '予算額';

  @override
  String budget_previewFor(Object catName) {
    return '「$catName」のプレビュー';
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
  String get budget_saveChanges => '変更を保存';

  @override
  String get budget_budget => '予算';

  @override
  String get budget_rollover => '繰り越し (封筒予算)';

  @override
  String get budget_rolloverDesc => '未使用の余剰金または不足分を次の期間に繰り越します';

  @override
  String get budget_rolloverBadge => '繰越';

  @override
  String budget_base(Object amount) {
    return '基本: $amount';
  }

  @override
  String budget_rolloverFrom(Object period, Object amount) {
    return '繰越 ($period): $amount';
  }

  @override
  String budget_totalAvailable(Object amount) {
    return '利用可能合計: $amount';
  }

  @override
  String get budget_lastWeek => '先週';

  @override
  String get pacing_dailyBudget => '安全支出額';

  @override
  String pacing_safeToSpend(Object amount, Object days) {
    return '安全支出額: 1日あたり$amount (残り$days日)';
  }

  @override
  String pacing_caution(Object amount) {
    return 'ペースが早めです — 1日あたり$amountに抑制';
  }

  @override
  String get pacing_overPaced => 'ペース警告 — 予算内に収めるため支出を抑えてください';

  @override
  String get pacing_budgetExhausted => '予算上限に到達 — 本日の利用可能額はありません';

  @override
  String get pacing_onTrack => '順調';

  @override
  String get pacing_fast => 'ペース早め';

  @override
  String get pacing_alert => 'ペース警告';

  @override
  String pacing_daysLeft(Object days) {
    return '残り$days日';
  }

  @override
  String get pacing_setBudgetPrompt => 'タップして予算上限を設定 →';

  @override
  String get pacing_dailyAvgPace => '1日のペース';

  @override
  String pacing_perDay(Object amount) {
    return '$amount / 日';
  }

  @override
  String get calendar_title => '支出カレンダー';

  @override
  String get calendar_subtitle => '日別支出ヒートマップと支払期日';

  @override
  String calendar_zeroSpendDays(Object count) {
    return '$count日の無支出日';
  }

  @override
  String get calendar_zeroSpendDayTitle => '支出ゼロ達成日！ 🎉';

  @override
  String get calendar_zeroSpendDayDesc => '本日も支出ゼロで素晴らしい自己管理です。';

  @override
  String get calendar_billsDue => '支払期日の請求・サブスク';

  @override
  String get calendar_loansDue => '期日のローン返済';

  @override
  String get calendar_lendedDue => '予定されている返済受け取り';

  @override
  String calendar_dayTransactions(Object count) {
    return '取引履歴 ($count)';
  }

  @override
  String get calendar_noActivity => 'この日の取引や支払予定はありません';

  @override
  String get calendar_today => '今日';

  @override
  String calendar_averageDaily(Object amount) {
    return '1日平均: $amount';
  }

  @override
  String get wrapped_title => 'Expensy Wrapped';

  @override
  String wrapped_bannerTitle(Object month) {
    return '$month月のまとめができました！';
  }

  @override
  String get wrapped_bannerSub => 'タップして今月の家計ストーリーを見る';

  @override
  String get wrapped_theBigPicture => '全体の概要';

  @override
  String wrapped_howMoneyMoved(Object month) {
    return '$month月のお金の動きはこちらです';
  }

  @override
  String get wrapped_totalInflow => '総収入';

  @override
  String get wrapped_totalOutflow => '総支出';

  @override
  String get wrapped_netSavings => '純貯蓄';

  @override
  String wrapped_savingsRate(Object rate) {
    return '貯蓄率: $rate%';
  }

  @override
  String get wrapped_topCategoryTitle => '支出の内訳は？';

  @override
  String wrapped_topCategorySub(Object category) {
    return '最も多かった支出カテゴリは $category でした';
  }

  @override
  String wrapped_topCategoryShare(Object percent) {
    return '総支出の $percent%';
  }

  @override
  String get wrapped_biggestSplurgeTitle => '最大の支出';

  @override
  String get wrapped_biggestSplurgeSub => '今月最も大きかった支出です';

  @override
  String get wrapped_noSplurge => '大きな支出はありません！今月は支出がゼロでした。';

  @override
  String get wrapped_heroHabitTitle => '素晴らしい習慣';

  @override
  String wrapped_zeroSpendAchieved(Object count) {
    return '$count 日間の支出ゼロ';
  }

  @override
  String wrapped_heroHabitDesc(Object count) {
    return '支出ゼロの日を $count 日達成しました。素晴らしい自己管理です！';
  }

  @override
  String get wrapped_receiptTitle => '月間レポート';

  @override
  String get wrapped_obscureToggle => '共有用に金額を隠す';

  @override
  String get wrapped_showToggle => '金額を表示する';

  @override
  String get wrapped_replay => 'ストーリーをもう一度見る';

  @override
  String get insights_other => 'その他';

  @override
  String get insights_noDataYet => 'まだデータがありません';

  @override
  String get insights_addSomeTransactions => 'いくつかのトランザクションを追加して洞察を確認します';

  @override
  String get insights_thisMonthVsLastMonth => '今月と先月';

  @override
  String get insights_dailyAverage => '1 日の平均';

  @override
  String insights_perDayBasedOn(Object days) {
    return 'per day · based on $days days this month';
  }

  @override
  String get insights_incomeVsExpenses => '収入と支出';

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
    return '今月 $percent% を節約しました';
  }

  @override
  String get insights_topSpendingCategories => '支出上位カテゴリ';

  @override
  String insights_percentOfTotal(Object percent) {
    return '合計の $percent%';
  }

  @override
  String get insights_biggestExpenseThisMonth => '今月最大の出費';

  @override
  String get insights_categoryTrends => 'カテゴリの傾向 (対先月)';

  @override
  String get insights_12MonthTrend => '12 か月の傾向';

  @override
  String get insights_incomeLabel => '所得';

  @override
  String get insights_expensesLabel => '経費';

  @override
  String get categories_expenseLabel => '経費';

  @override
  String get categories_incomeLabel => '収入';

  @override
  String get categories_editCategory => 'カテゴリを編集';

  @override
  String get categories_addCategory => 'カテゴリを追加';

  @override
  String get categories_categoryName => 'カテゴリ名';

  @override
  String get categories_saveChanges => '変更を保存';

  @override
  String get statistics_other => 'その他';

  @override
  String get statistics_allAccounts => 'すべてのアカウント';

  @override
  String get statistics_income => '所得';

  @override
  String get statistics_expenses => '経費';

  @override
  String get statistics_expense => '経費';

  @override
  String get statistics_net => 'ネット';

  @override
  String statistics_6MonthOverviewAccount(Object accountName) {
    return '6-Month Overview · $accountName';
  }

  @override
  String get statistics_6MonthOverview => '6 か月の概要';

  @override
  String statistics_percentOfBudget(Object percent) {
    return '予算の $percent%';
  }

  @override
  String get add_transaction_editTransaction => 'トランザクションの編集';

  @override
  String get add_transaction_addTransaction => 'トランザクションを入力してください';

  @override
  String get add_transaction_amount => '金額';

  @override
  String add_transaction_conversionPreview(Object accountName, Object amount) {
    return '≈ $amount が $accountName から差し引かれます';
  }

  @override
  String get add_transaction_accountFallback => 'アカウント';

  @override
  String get add_transaction_descriptionOptional => '説明 (オプション)';

  @override
  String get add_transaction_noteOptional => '注 (オプション)';

  @override
  String get add_transaction_saveChanges => '変更を保存';

  @override
  String get more_statistics => '統計';

  @override
  String get more_statisticsSub => 'チャートと月次サマリー';

  @override
  String get more_insights => '洞察';

  @override
  String get more_insightsSub => '傾向、平均、カテゴリ分析';

  @override
  String get more_currencyConverter => '通貨換算';

  @override
  String get more_currencyConverterSub => '通貨間の即時変換';

  @override
  String get more_wishlist => 'ウィッシュリスト';

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
  String get more_lentMoney => '貸したお金';

  @override
  String more_lentMoneySub(Object count) {
    return '$count 件の未処理';
  }

  @override
  String get more_assets => '資産';

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
  String get more_categories => 'カテゴリ';

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
  String get more_exportTransactions => '輸出取引';

  @override
  String get more_exportTransactionsSub => 'Excel (.xlsx) として保存';

  @override
  String get more_backupRestore => 'バックアップと復元';

  @override
  String get more_backupRestoreSub => 'データを保存またはロード';

  @override
  String get more_settings => '設定';

  @override
  String get more_settingsSub => 'テーマ、通貨、設定';

  @override
  String get more_sectionTools => '金融ツール';

  @override
  String get more_sectionAnalytics => '分析＆レポート';

  @override
  String get more_sectionPreferences => '設定＆データ';

  @override
  String home_greeting(Object name) {
    return 'Hi, $name 👋';
  }

  @override
  String get home_there => 'そこ';

  @override
  String get home_income => '収入';

  @override
  String get home_expenses => '経費';

  @override
  String get home_net => 'ネット';

  @override
  String get wishlist_noItems => 'ウィッシュリストの項目はありません';

  @override
  String get wishlist_noItemsSub => '+ をタップして保存するアイテムを追加します';

  @override
  String get wishlist_editItem => '項目を編集';

  @override
  String get wishlist_addWishlistItem => 'ウィッシュリスト項目を追加';

  @override
  String get wishlist_itemName => 'アイテム名';

  @override
  String get wishlist_targetPrice => '目標価格';

  @override
  String get wishlist_priorityLow => '低い';

  @override
  String get wishlist_priorityMedium => '中';

  @override
  String get wishlist_priorityHigh => '高い';

  @override
  String get wishlist_notesOptional => '注記 (オプション)';

  @override
  String get wishlist_saveChanges => '変更を保存';

  @override
  String get wishlist_addItem => 'アイテムを追加';

  @override
  String get wishlist_fundThisItem => '積立を始める';

  @override
  String wishlist_funded(int percent, String saved, String target) {
    return '$percent% 達成 ($saved / $target)';
  }

  @override
  String get wishlist_goalAchieved => '目標達成 — 購入の準備が整いました！';

  @override
  String get wishlist_buyNow => '今すぐ購入';

  @override
  String get wishlist_purchaseTitle => 'ほしい物リストのアイテムを購入';

  @override
  String get wishlist_purchasePrompt => '支出トランザクションを記録し、口座から金額を引き落としますか？';

  @override
  String get wishlist_recordAndDeduct => '記録して引き落とす';

  @override
  String get wishlist_markPurchasedOnly => '購入済みにのみ設定';

  @override
  String wishlist_itemPurchased(String name) {
    return '「$name」を購入済みにしました！';
  }

  @override
  String get wishlist_viewGoal => '貯蓄目標を表示';

  @override
  String savings_linkedWishlist(String item) {
    return 'ほしい物リストに連携中: $item';
  }

  @override
  String get lended_theyOweMe => '彼らは私に借りがある';

  @override
  String get lended_iOweThem => '私は彼らに借りがあります';

  @override
  String get lended_net => 'ネット';

  @override
  String get lended_noOneYet => 'まだ誰もいません';

  @override
  String get lended_noOneYetSub => '+ をタップして、貸したり借りたりする人を追加します';

  @override
  String get lended_owesYou => '借りがあります';

  @override
  String get lended_youOwe => 'あなたには借りがあります';

  @override
  String get lended_settledUp => '落ち着いた';

  @override
  String get lended_noActiveRecords => 'アクティブなレコードはありません';

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
  String get lended_editPerson => '人物を編集';

  @override
  String get lended_addPerson => '人を追加';

  @override
  String get lended_name => '名前';

  @override
  String get lended_notesOptional => '注記 (オプション)';

  @override
  String get lended_saveChanges => '変更を保存';

  @override
  String get assets_totalAssets => '総資産';

  @override
  String get assets_items => 'アイテム';

  @override
  String get assets_noAssetsYet => 'まだアセットがありません';

  @override
  String get assets_noAssetsYetSub => '+ をタップして製品またはアセットを追加します';

  @override
  String get assets_editAsset => 'アセットの編集';

  @override
  String get assets_addAsset => 'アセットを追加';

  @override
  String get assets_productAssetName => '製品/資産名';

  @override
  String get assets_value => '値';

  @override
  String get assets_notesOptional => '注記 (オプション)';

  @override
  String get assets_saveChanges => '変更を保存';

  @override
  String get currency_converter_loadingRates => '為替レートを読み込み中…';

  @override
  String get currency_converter_ratesUnavailable =>
      '為替レートは利用できません。インターネットに接続して同期します。';

  @override
  String get currency_converter_rateAgeJustNow => 'たった今';

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
    return '$fromCurrency からの一般的な変換';
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
      '為替レートが読み込まれていません - 金額はそのまま送金されます';

  @override
  String get transfer_amount => '金額';

  @override
  String get transfer_noteOptional => '注 (オプション)';

  @override
  String get export_from => '';

  @override
  String get export_to => 'からに';

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
  String get export_complete => 'エクスポートが完了しました';

  @override
  String get export_exporting => 'エクスポート中...';

  @override
  String get export_exportAsExcel => 'Excel としてエクスポート';

  @override
  String shared_widgets_deleteConfirm(Object name) {
    return 'Delete \"$name\"? This cannot be undone.';
  }

  @override
  String get shared_widgets_searchByCode => 'コードまたは名前で検索します...';

  @override
  String get accounts_accounts => '口座';

  @override
  String get accounts_totalBalance => '合計残高';

  @override
  String get accounts_excluded => '除外済み';

  @override
  String get accounts_goldPriceNotYetLoade =>
      '金価格がまだ読み込まれていません。しばらくしてからもう一度お試しください。';

  @override
  String get accounts_accountType => '口座タイプ';

  @override
  String get accounts_currency => '通貨';

  @override
  String get accounts_goldPurityKarat => '金の純度 (カラット)';

  @override
  String get accounts_weight => '重量';

  @override
  String get accounts_excludeFromTotalBala => '合計残高から除外する';

  @override
  String get accounts_dontLinkToCard => 'カードと紐付けない';

  @override
  String get accounts_dontLinkToCardDesc => 'この口座の残高を手動で管理し、カードとの紐付けを防止します';

  @override
  String get accounts_color => '色';

  @override
  String get accounts_liveGoldValue => 'リアルタイムの金価値';

  @override
  String get accounts_enterWeightAboveToSe => '上の重量を入力して価値を確認してください';

  @override
  String get add_transaction_expense => '支出';

  @override
  String get add_transaction_income => '収入';

  @override
  String get add_transaction_account => '口座';

  @override
  String get add_transaction_category => 'カテゴリ';

  @override
  String get assets_assets => '資産';

  @override
  String get backup_restoreBackup => 'バックアップを復元しますか？';

  @override
  String get backup_cancel => 'キャンセル';

  @override
  String get backup_replaceData => 'データを置き換える';

  @override
  String get backup_backupRestore => 'バックアップと復元';

  @override
  String get backup_everythingAlways => 'すべて、常に';

  @override
  String get backup_createBackup => 'バックアップを作成';

  @override
  String get backup_saveAsJson => 'JSONとして保存';

  @override
  String get backup_exportsAllAppDataToA => 'すべてのアプリデータをポータブルファイルにエクスポートします';

  @override
  String get backup_restoreBackup_ => 'バックアップを復元';

  @override
  String get backup_loadFromJson => 'JSONから読み込む';

  @override
  String get backup_picksABackupFileAndR => 'バックアップファイルを選択して復元します';

  @override
  String get backup_thisOverwritesAllCur => 'これにより、現在のすべてのデータが上書きされます。';

  @override
  String get budget_budgets => '予算';

  @override
  String get budget_empty => '·';

  @override
  String get budget_overBudget => '予算オーバー';

  @override
  String get budget_thisCategoryAlreadyH => 'このカテゴリにはすでに予算があります。タップして編集します。';

  @override
  String get budget_period => '期間';

  @override
  String get budget_monthly => '月間';

  @override
  String get budget_weekly => '週間';

  @override
  String get budget_category => 'カテゴリ';

  @override
  String get categories_categories => 'カテゴリ';

  @override
  String get categories_expense => '支出';

  @override
  String get categories_income => '収入';

  @override
  String get categories_color => '色';

  @override
  String get categories_icon => 'アイコン';

  @override
  String get categories_autoBasedOnName => '自動 (名前に基づく)';

  @override
  String get categories_expenseCategories => '支出カテゴリ';

  @override
  String get categories_incomeCategories => '収入カテゴリ';

  @override
  String get currency_converter_currencyConverter => '通貨コンバーター';

  @override
  String get currency_converter_amount => '金額';

  @override
  String get currency_converter_convertedTo => '変換後';

  @override
  String get export_exportTransactions => '取引をエクスポート';

  @override
  String get export_dateRange => '日付範囲';

  @override
  String get export_formatExcelXlsx => '形式：Excel (.xlsx)';

  @override
  String get export_exportAsPdf => 'PDFレポートとして出力';

  @override
  String get export_formatPdf => '形式: PDF財務レポート (.pdf)';

  @override
  String get export_pdfGenerating => 'PDFを生成中...';

  @override
  String get export_pdfTitle => '財務レポート';

  @override
  String get export_pdfSummary => '概要';

  @override
  String get export_pdfInflow => '総収入';

  @override
  String get export_pdfOutflow => '総支出';

  @override
  String get export_pdfNet => '純貯蓄';

  @override
  String get export_pdfSavingsRate => '貯蓄率';

  @override
  String get export_pdfCategoryBreakdown => 'カテゴリ別内訳';

  @override
  String get export_pdfTransactions => '個別取引明細';

  @override
  String get export_pdfNetWorthBreakdown => '資産と負債';

  @override
  String get export_pdfShare => 'レポートを共有';

  @override
  String get export_pdfPrint => '印刷 / プレビュー';

  @override
  String get export_pdfGeneratedBy => 'Expensy により生成 • プライベート＆オフライン';

  @override
  String get home_totalBalance => '合計残高';

  @override
  String get home_accounts => '口座';

  @override
  String get home_recentTransactions => '最近の取引';

  @override
  String get home_noTransactionsYet => 'まだ取引はありません';

  @override
  String get home_add => '追加';

  @override
  String get home_goodMorning => 'おはようございます';

  @override
  String get home_goodAfternoon => 'こんにちは';

  @override
  String get home_goodEvening => 'こんばんは';

  @override
  String get home_transferAction => '送金';

  @override
  String get home_insightsAction => 'インサイト';

  @override
  String get home_calendarAction => 'カレンダー';

  @override
  String get home_forecastAction => '予測';

  @override
  String get home_manage => '管理';

  @override
  String get home_seeAll => 'すべて見る';

  @override
  String get home_addAccount => '口座を追加';

  @override
  String get home_monthlyOverview => '月間概要';

  @override
  String get home_savingsRate => '貯蓄率';

  @override
  String get insights_insights => 'インサイト';

  @override
  String get lended_person_deletePerson => '人を削除';

  @override
  String get lended_person_editPerson => '人を編集';

  @override
  String get lended_person_color => '色';

  @override
  String get lended_person_saveChanges => '変更を保存';

  @override
  String get lended_person_settled => '清算済み';

  @override
  String get lended_person_settle => '清算';

  @override
  String get lended_person_setADueDateFirstToEn =>
      'リマインダーを有効にするには、まず期日を設定してください。';

  @override
  String get lended_person_iLent => '貸した';

  @override
  String get lended_person_iBorrowed => '借りた';

  @override
  String get lended_person_accountOptional => '口座 (任意)';

  @override
  String get lended_person_dueDateReminder => '期日リマインダー';

  @override
  String get lended_person_remindMeAt => 'リマインド時間';

  @override
  String get lended_person_active => 'アクティブ';

  @override
  String get lended_person_settled_ => '清算済み';

  @override
  String get lended_lentMoney => '貸したお金';

  @override
  String get lended_overdue => '延滞';

  @override
  String get lended_color => '色';

  @override
  String get more_more => 'その他';

  @override
  String get onboarding_back => '戻る';

  @override
  String get onboarding_welcomeToExpensy => 'Expensyへようこそ！';

  @override
  String get onboarding_restoreABackup => 'バックアップを復元';

  @override
  String get onboarding_loadAPreviouslySaved => '以前に保存したExpensyのJSONファイルを読み込む';

  @override
  String get onboarding_or => 'または';

  @override
  String get onboarding_startFresh => '最初から始める';

  @override
  String get onboarding_firstWhatShouldWeCal => 'まず、お名前を教えてください。';

  @override
  String get onboarding_defaultCurrency => 'デフォルト通貨';

  @override
  String get onboarding_thisWillBeUsedAcross =>
      'これはアプリ全体で使用されます。\n後で設定から変更できます。';

  @override
  String get onboarding_searchAllCurrencies => 'すべての通貨を検索';

  @override
  String get onboarding_yourFirstAccount => '最初の口座';

  @override
  String get onboarding_setUpYourMainAccount => 'メインの口座を設定して追跡を開始します。';

  @override
  String get onboarding_accountType => '口座タイプ';

  @override
  String get onboarding_currency => '通貨';

  @override
  String get onboarding_color => '色';

  @override
  String get recurring_recurring => '定期';

  @override
  String get recurring_income => '収入';

  @override
  String get recurring_2D => '−2日';

  @override
  String get recurring_skipNextPayment => '次回の支払いをスキップしますか？';

  @override
  String get recurring_cancel => 'キャンセル';

  @override
  String get recurring_skip => 'スキップ';

  @override
  String get recurring_noHistoryYet => '履歴はまだありません';

  @override
  String get recurring_expense => '支出';

  @override
  String get recurring_income_ => '収入';

  @override
  String get recurring_every => '毎 ';

  @override
  String get recurring_days => '日';

  @override
  String get recurring_weeks => '週';

  @override
  String get recurring_months => '月';

  @override
  String get recurring_years => '年';

  @override
  String get recurring_payments => '支払い';

  @override
  String get recurring_totalCost => '合計費用';

  @override
  String get recurring_account => '口座';

  @override
  String get recurring_category => 'カテゴリ';

  @override
  String get recurring_paymentReminder => '支払いリマインダー';

  @override
  String get recurring_notificationWillFire => '通知は次回の期日のこの時間に送信されます。';

  @override
  String get recurring_remind2DaysBefore => '2日前にリマインド';

  @override
  String get statistics_statistics => '統計';

  @override
  String get statistics_expensesByCategory => 'カテゴリ別支出';

  @override
  String get transactions_transactions => '取引';

  @override
  String get transactions_settled => '清算済み';

  @override
  String get transfer_transfer => '振替';

  @override
  String get transfer_from => '振替元';

  @override
  String get transfer_to => '振替先';

  @override
  String get transfer_enterAnAmountToSeeTh => '変換を表示するには金額を入力してください';

  @override
  String get wishlist_wishlist => 'ほしい物リスト';

  @override
  String get wishlist_priority => '優先度';

  @override
  String get shared_widgets_delete => '削除しますか？';

  @override
  String get shared_widgets_cancel => 'キャンセル';

  @override
  String get shared_widgets_delete_ => '削除';

  @override
  String get shared_widgets_none => 'なし';

  @override
  String get shared_widgets_selectCurrency => '通貨を選択';

  @override
  String get main_home => 'ホーム';

  @override
  String get main_transactions => '取引';

  @override
  String get main_recurring => '繰り返し発生します';

  @override
  String get main_accounts => 'アカウント';

  @override
  String get main_budgets => '予算';

  @override
  String get main_more => '詳細';

  @override
  String get onboarding_chooseLanguage => '言語を選択';

  @override
  String get error_required => 'このフィールドは必須です';

  @override
  String recurring_subscriptions(Object count) {
    return '購読数 ($count)';
  }

  @override
  String recurring_installments(Object count) {
    return '分割払い ($count)';
  }

  @override
  String get recurring_recurringType => '繰り返しタイプ';

  @override
  String get recurring_subscription => 'サブスクリプション';

  @override
  String get recurring_installment => '分割払い';

  @override
  String get recurring_installmentsRequireEndDate => '分割払いには最終支払い日が必要です。';

  @override
  String get backup_importFromOtherApps => '他のアプリからインポート';

  @override
  String get backup_importDescription => 'サポートされているアプリからデータをインポート';

  @override
  String get backup_importFromGreenStash => 'GreenStash (.json) からインポート';

  @override
  String get backup_automaticBackup => '自動バックアップ';

  @override
  String get backup_dailyAutoBackup => '毎日の自動バックアップ';

  @override
  String backup_runsDailyAt(String time) {
    return '毎日 $time に実行';
  }

  @override
  String backup_lastBackup(String time) {
    return '最終バックアップ: $time';
  }

  @override
  String backup_savingTo(String path) {
    return '保存先: $path';
  }

  @override
  String get backup_changeTime => '変更時間';

  @override
  String get backup_changeFolder => 'フォルダーを変更する';

  @override
  String get budget_budgetsAndGoals => '予算と目標';

  @override
  String get onboarding_restoreGreenStash => 'GreenStash (.json) から復元';

  @override
  String get savings_goalNotFound => '目標が見つかりません';

  @override
  String get savings_savedSoFar => 'これまでに保存されました';

  @override
  String get savings_target => 'ターゲット';

  @override
  String savings_targetDate(String date) {
    return '対象日: $date';
  }

  @override
  String get savings_contribute => '貢献する';

  @override
  String get savings_withdraw => '撤退';

  @override
  String get savings_noAccounts => '利用可能なアカウントがありません。まずアカウントを追加してください。';

  @override
  String get settings_budgetAlerts => '予算に関するアラート';

  @override
  String get settings_budgetAlertsSub => '予算または目標に達したら通知する';

  @override
  String get settings_dailyReminder => '毎日のリマインダー';

  @override
  String get settings_dailyReminderSub => '毎日トランザクションを記録するよう通知する';

  @override
  String get settings_reminderTime => 'リマインダー時間';

  @override
  String get settings_hapticFeedback => '触覚フィードバック';

  @override
  String get settings_hapticFeedbackSub => 'インタラクション時に振動する';

  @override
  String get savings_saveGoal => '目標を保存する';

  @override
  String get more_loans => 'ローン';

  @override
  String more_loansSub(num count) {
    return 'アクティブなローン';
  }

  @override
  String get loans_title => 'ローン';

  @override
  String get loans_addLoan => 'ローンを追加';

  @override
  String get loans_editLoan => 'ローンを編集';

  @override
  String get loans_loanName => 'ローン名';

  @override
  String get loans_amount => '金額';

  @override
  String get loans_startDate => '開始日';

  @override
  String get loans_endDate => '終了日';

  @override
  String get loans_interestRateOptional => '金利（任意）';

  @override
  String get loans_account => '連携口座';

  @override
  String get loans_monthlyPayment => '月々の返済額';

  @override
  String get loans_totalPayable => '返済総額';

  @override
  String get loans_remaining => '残高';

  @override
  String get loans_paid => '返済済み';

  @override
  String get loans_logPayment => '返済を記録';

  @override
  String get loans_paymentReminder => '返済リマインダー';

  @override
  String get loans_reminderDay => 'リマインダー日';

  @override
  String get loans_notes => 'メモ';

  @override
  String get loans_saveLoan => 'ローンを保存';

  @override
  String get loans_deleteLoan => 'ローンを削除';

  @override
  String get loans_settled => '完済済み';

  @override
  String loans_durationMonths(num count) {
    return 'ヶ月';
  }

  @override
  String get loans_paymentHistory => '返済履歴';

  @override
  String get loans_noPayments => '返済記録がまだありません';

  @override
  String get loans_outstandingDebt => '未払い債務';

  @override
  String get loans_monthlyObligation => '月々の返済義務';

  @override
  String get insights_loans => 'ローン';

  @override
  String get backup_loans => 'ローン';

  @override
  String get backup_loanPayments => 'ローン返済';

  @override
  String get more_yearlyAnalysis => '年間分析';

  @override
  String get more_yearlyAnalysisSub => '月ごとのキャッシュフロー予測';

  @override
  String get yearly_title => '年間分析';

  @override
  String get yearly_recurringExp => '定期支出';

  @override
  String get yearly_recurringInc => '定期収入';

  @override
  String get yearly_loans => 'ローン返済';

  @override
  String get yearly_borrowed => '借入期日';

  @override
  String get yearly_lentDue => '貸付回収期日';

  @override
  String get yearly_inflow => '流入';

  @override
  String get yearly_outflow => '流出';

  @override
  String get yearly_netFlow => '純フロー';

  @override
  String get yearly_totalInflow => '総流入';

  @override
  String get yearly_totalOutflow => '総流出';

  @override
  String get yearly_netCashFlow => '純キャッシュフロー';

  @override
  String get yearly_noData => '予測アクティビティがありません';

  @override
  String get yearly_noDataSub => '定期的な支払いやローンを追加して予測を表示';

  @override
  String get budget_addBudget => '予算を追加';

  @override
  String get budget_addGoal => '貯蓄目標を追加';

  @override
  String get add_transaction_possibleDuplicate => '重複の可能性';

  @override
  String get add_transaction_goBack => '戻る';

  @override
  String get add_transaction_saveAnyway => 'このまま保存';

  @override
  String get loans_confirmDeleteLoan => 'このローンとすべての支払い履歴を削除してもよろしいですか？';

  @override
  String get loans_deletePayment => '支払いを削除';

  @override
  String get loans_confirmDeletePayment => 'この支払い記録を削除してもよろしいですか？';

  @override
  String get split_transactions_title => 'カテゴリを分割';

  @override
  String get split_transactions_badge => '分割';

  @override
  String get split_transactions_addSplit => '分割を追加';

  @override
  String get split_transactions_removeSplit => '分割を削除';

  @override
  String get split_transactions_allocated => '配分済み';

  @override
  String get split_transactions_remaining => '残り';

  @override
  String get split_transactions_fillRemaining => '残りを入力';

  @override
  String get split_transactions_breakdown => '分割内訳';

  @override
  String get split_transactions_mismatchError => '分割額の合計は総額と一致する必要があります。';

  @override
  String get netWorth_title => '純資産';

  @override
  String get netWorth_subtitle => '資産、負債、および富の推移を追跡';

  @override
  String get netWorth_current => '現在の純資産';

  @override
  String get netWorth_trend => '純資産の推移';

  @override
  String get netWorth_totalAssets => '総資産';

  @override
  String get netWorth_totalLiabilities => '総負債';

  @override
  String get netWorth_liquidCash => '現金および銀行口座';

  @override
  String get netWorth_goldValuation => '現物ゴールド';

  @override
  String get netWorth_fixedAssets => '不動産・投資資産';

  @override
  String get netWorth_moneyLent => '貸付金（未回収）';

  @override
  String get netWorth_creditDebt => 'クレジットカード・当座貸越';

  @override
  String get netWorth_loanDebt => '借入金・ローン';

  @override
  String get netWorth_moneyBorrowed => '借受金（返済義務）';

  @override
  String get netWorth_assetBreakdown => '資産の内訳';

  @override
  String get netWorth_liabilityBreakdown => '負債の内訳';

  @override
  String get netWorth_noHistory => '毎日のスナップショットが記録されるにつれて、純資産の推移が蓄積されます。';

  @override
  String get netWorth_debtRatio => '負債比率';

  @override
  String get netWorth_quickActions => 'クイックアクション';

  @override
  String get netWorth_history => 'スナップショット履歴';

  @override
  String get creditCard_utilization => '利用限度額使用率';

  @override
  String get creditCard_availableCredit => '利用可能額';

  @override
  String get creditCard_limit => '限度額';

  @override
  String get creditCard_statementBalance => '請求確定額';

  @override
  String get creditCard_unbilledBalance => '未確定額';

  @override
  String get creditCard_payBill => 'カード代金を支払う';

  @override
  String get creditCard_allCaughtUp => '完済済み！未払い残高はありません';

  @override
  String get creditCard_payBillTitle => 'カード利用代金の支払い';

  @override
  String get creditCard_payFromAccount => '支払元口座';

  @override
  String get creditCard_paymentAmount => '支払金額';

  @override
  String get creditCard_fullStatement => '請求確定額';

  @override
  String get creditCard_fullBalance => '利用総額';

  @override
  String get creditCard_minPayment => '最低支払額';

  @override
  String get creditCard_customAmount => '金額を指定';

  @override
  String creditCard_paymentSuccess(String amount, String cardName) {
    return '$cardName に $amount を支払いました';
  }

  @override
  String get creditCard_insufficientFunds => '金額が口座残高を超えています';

  @override
  String get creditCard_invalidAmount => '有効な支払金額を入力してください';

  @override
  String get onboarding_skipForNow => '今はスキップ';

  @override
  String get onboarding_addCard => 'カードを追加';

  @override
  String get onboarding_skipCardDesc => '今すぐカードを追加しない場合は、この手順をスキップできます。';

  @override
  String get onboarding_cardNameLabel => 'カード名 (例: Visa Platinum)';

  @override
  String get onboarding_debitCard => 'デビットカード';

  @override
  String get onboarding_creditLimit => '利用限度額';

  @override
  String get onboarding_amountUsed => '利用金額';

  @override
  String get accounts_cardHolderOptional => 'カード名義人 (任意)';

  @override
  String get accounts_last4Digits => '下4桁';

  @override
  String get accounts_expiryDate => '有効期限 (MM/YY)';

  @override
  String get accounts_creditLimitOptional => '利用限度額 (任意)';

  @override
  String get accounts_minPaymentOptional => '最低支払額 (任意)';

  @override
  String get accounts_statementDayOptional => '締め日 (任意)';

  @override
  String get accounts_statementDayExample => '例: 20';

  @override
  String get accounts_dueDayOptional => '支払日 (任意)';

  @override
  String get accounts_dueDayExample => '例: 10';

  @override
  String get accounts_linkedAccountOptional => '紐付け銀行口座 (任意)';

  @override
  String get accounts_excludeCardBalance => '口座残高からカード残高を除外';

  @override
  String get accounts_excludeCardBalanceDesc => 'このカードの残高は紐付けられた銀行口座には加算されません。';

  @override
  String get accounts_cardHolderHeader => 'カード名義人';

  @override
  String get accounts_expHeader => '有効期限';

  @override
  String get accounts_notifyOnDueDate => '支払期日にお知らせします';

  @override
  String get accounts_notifyWhenDue => '支払期日に通知を受け取る';

  @override
  String get accounts_remind2DaysBeforeDesc => '支払期日の2日前に事前通知を受け取ります';

  @override
  String get accounts_targetSaved => '目標 / 貯蓄済';

  @override
  String transactions_selectedCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件選択中',
    );
    return '$_temp0';
  }

  @override
  String get transactions_changeCategory => 'カテゴリ変更';

  @override
  String get transactions_deleteSelected => '選択項目を削除';

  @override
  String get transactions_advancedFilters => '高度なフィルター';

  @override
  String get transactions_clearAll => 'すべてクリア';

  @override
  String get transactions_amountRange => '金額範囲';

  @override
  String get transactions_minAmount => '最小金額';

  @override
  String get transactions_maxAmount => '最大金額';

  @override
  String get transactions_applyFilters => 'フィルターを適用';

  @override
  String get presets_new => '新規';

  @override
  String get presets_presetName => 'プリセット名 (例: 朝のコーヒー)';

  @override
  String get presets_defaultAmount => 'デフォルト金額';

  @override
  String get savings_goalName => '目標名';

  @override
  String get savings_goalNameHint => '例: 新車、旅行';

  @override
  String get savings_targetAmount => '目標金額';

  @override
  String get savings_targetDateOptional => '目標日 (任意)';

  @override
  String get savings_selectDate => '日付を選択';

  @override
  String get savings_amountRequired => '金額を入力してください';

  @override
  String get savings_noteOptional => 'メモ (任意)';

  @override
  String get loans_skipInstallment => 'ローンの次回の返済をスキップしますか？';

  @override
  String get recurring_confirmDelete => 'この定期支払いを削除してもよろしいですか？';

  @override
  String get export_formatExcelOption => 'Excel (.xlsx)';

  @override
  String get export_formatPdfOption => 'PDFレポート';

  @override
  String get export_pdfNoTransactions => 'この期間内に記録された取引はありません。';

  @override
  String get savings_saved => '貯蓄額';

  @override
  String get export_pdfDate => '日付';

  @override
  String get export_pdfDescription => '説明';

  @override
  String get accounts_noCardsYet => 'カードがありません';

  @override
  String get accounts_tapToAddCard => '+ をタップして最初のカードを追加';

  @override
  String get savings_noGoalsYet => '貯蓄目標がありません';

  @override
  String get savings_tapToAddGoal => '+ をタップして新しい目標を設定';

  @override
  String get netWorth_recordSnapshot => 'スナップショットを記録';

  @override
  String get netWorth_snapshotRecorded => 'スナップショットが記録されました';

  @override
  String get savings_noContributionsYet => '拠出金はまだありません';

  @override
  String get creditCard_closesStatementBillingCycle => '現在の請求サイクルの締め日を清算';

  @override
  String get creditCard_clearsTotalDebt => 'カードの残高を全額完済';

  @override
  String get creditCard_requiredMinPayment => '必要な最低支払額';

  @override
  String get creditCard_specifyCustomAmount => '任意の支払額を指定';

  @override
  String common_itemDeleted(String name) {
    return '「$name」を削除しました';
  }

  @override
  String get common_accountDeleted => 'アカウントを削除しました';

  @override
  String get common_cardDeleted => 'カードを削除しました';

  @override
  String get common_transactionDeleted => '取引を削除しました';

  @override
  String get common_recordDeleted => '記録を削除しました';

  @override
  String get common_paymentDeleted => '支払いを削除しました';

  @override
  String get loans_skippedInstallment => 'ローンの分割払いをスキップしました';

  @override
  String loans_loggedPayment(String amount) {
    return '$amount の支払いを記録しました';
  }

  @override
  String get loans_notificationsPermissionRequired => '通知の許可が必要です';

  @override
  String get creditCard_selectFundingAccount => '引き落とし口座を選択してください';

  @override
  String get presets_presetUpdated => 'プリセットを更新しました';

  @override
  String get presets_presetAdded => 'プリセットを追加しました';

  @override
  String get presets_presetDeleted => 'プリセットを削除しました';

  @override
  String transactions_deletedCount(int count) {
    return '$count 件の項目を削除しました';
  }

  @override
  String get split_atLeastTwoCategories => '分割には2つ以上のカテゴリが必要です。';

  @override
  String get split_categoryAndAmountRequired => '各分割項目にはカテゴリと0より大きい金額が必要です。';

  @override
  String get presets_addQuickPresets => 'ワンタップのクイックプリセットを追加';

  @override
  String get presets_quickPresetsDesc => 'コーヒーや交通費、食事などの頻出項目を1タップで記録';

  @override
  String presets_loggedPreset(String title, String amount) {
    return '$title（$amount）を記録しました';
  }

  @override
  String get presets_createPreset => 'プリセットを作成';

  @override
  String get presets_editQuickPreset => 'クイックプリセットを編集';

  @override
  String get presets_newQuickPreset => '新規クイックプリセット';

  @override
  String get savings_addContribution => '拠出金を追加';

  @override
  String get savings_withdrawFromGoal => '目標から引き出す';

  @override
  String get savings_contribution => '拠出金';

  @override
  String get savings_withdrawal => '引き出し';

  @override
  String get savings_unknownAccount => '不明な口座';

  @override
  String get savings_fromAccount => '出金元口座';

  @override
  String get savings_toAccount => '入金先口座';

  @override
  String get presets_quickLog => 'クイック記録';

  @override
  String accounts_dueOnDay(int day) {
    return '$day日に期日';
  }
}
