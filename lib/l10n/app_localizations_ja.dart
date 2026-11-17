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
    return '$date から・継続中';
  }

  @override
  String recurring_paidPayments(Object paid, Object total) {
    return '$paid/$total 回完了';
  }

  @override
  String recurring_totalAmount(Object amount) {
    return '合計: $amount';
  }

  @override
  String get recurring_overdue => '期限を過ぎました！';

  @override
  String get recurring_dueToday => '今日が期限';

  @override
  String recurring_dueInDays(Object days) {
    return 'あと$days日';
  }

  @override
  String get recurring_edit => '編集';

  @override
  String get recurring_skipBtn => 'スキップ';

  @override
  String recurring_nextDate(Object date) {
    return '次回: $date';
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
    return '初回: $date';
  }

  @override
  String recurring_lastDate(Object date) {
    return '最終: $date';
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
    return '純度 $percentage%';
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
    return '期日 $date';
  }

  @override
  String lended_person_reminderAt(Object time) {
    return '$time にリマインド';
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
    return '期日: $date';
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
    return '$nameへ貸付';
  }

  @override
  String transactions_borrowedFrom(Object name) {
    return '$name から借用';
  }

  @override
  String get transactions_unknown => '不明';

  @override
  String transactions_due(Object date) {
    return '期日 $date';
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
    return 'バックアップを保存しました:\n$savedPath';
  }

  @override
  String backup_backupFailed(Object error) {
    return 'バックアップ失敗: $error';
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
    return '復元に失敗しました: $error';
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
    return '$amount 超過';
  }

  @override
  String budget_leftAmount(Object amount) {
    return '残り $amount';
  }

  @override
  String budget_percentUsed(Object percent) {
    return '$percent% 使用';
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
    return '支出: $amount';
  }

  @override
  String budget_ofAmount(Object amount) {
    return '/ $amount';
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
  String get wrapped_title => 'Expensy まとめ';

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
    return '1日あたり · 今月$days日間の平均';
  }

  @override
  String get insights_incomeVsExpenses => '収入と支出';

  @override
  String insights_incomeAmount(Object amount) {
    return '収入 $amount';
  }

  @override
  String insights_expensesAmount(Object amount) {
    return '支出 $amount';
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
    return '6か月推移 · $accountName';
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
      other: '$count件',
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
      other: '$count件',
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
      other: '$count個のカテゴリ',
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
    return 'こんにちは、$name さん 👋';
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
      other: '$count件の有効な記録',
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
    return '$minutes分前';
  }

  @override
  String currency_converter_rateAgeHours(Object hours) {
    return '$hours時間前';
  }

  @override
  String currency_converter_rateAgeDays(Object days) {
    return '$days日前';
  }

  @override
  String currency_converter_commonConversions(Object fromCurrency) {
    return '$fromCurrency からの一般的な変換';
  }

  @override
  String transfer_fromAcc(Object currency) {
    return '振替元 ($currency)';
  }

  @override
  String transfer_toAcc(Object currency) {
    return '振替先 ($currency)';
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
      other: '期間内 $count 件の取引',
    );
    return '$_temp0';
  }

  @override
  String export_saved(Object path) {
    return '保存完了: $path';
  }

  @override
  String get export_complete => 'エクスポートが完了しました';

  @override
  String get export_exporting => 'エクスポート中...';

  @override
  String get export_exportAsExcel => 'Excel としてエクスポート';

  @override
  String shared_widgets_deleteConfirm(Object name) {
    return '「$name」を削除しますか？元に戻すことはできません。';
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
  String get home_cards => 'カード';

  @override
  String get home_addCard => 'カードを追加';

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
  String get error_required => 'この項目は必須です';

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

  @override
  String get accounts_cannotDeleteAccount => '口座を削除できません';

  @override
  String get common_ok => 'OK';

  @override
  String get certificates_title => '定期預金・証書';

  @override
  String get certificates_addCertificate => '証書を追加';

  @override
  String get certificates_editCertificate => '証書を編集';

  @override
  String get certificates_noCertificates => '証書はまだありません';

  @override
  String get certificates_noCertificatesDesc => '高利回りの定期預金や証書、自動受取利息を記録します。';

  @override
  String get certificates_active => '有効';

  @override
  String get certificates_matured => '満期';

  @override
  String get certificates_amount => '元本金額';

  @override
  String get certificates_collectionType => '利息受取頻度';

  @override
  String get certificates_collectedSoFar => 'これまでの受取合計';

  @override
  String get certificates_expectedTotal => '予想受取合計利息';

  @override
  String get certificates_startDate => '開始日';

  @override
  String get certificates_endDate => '満期日';

  @override
  String get certificates_redeem => '証書を解約・償還';

  @override
  String certificates_redeemConfirm(String name, String amount) {
    return '本当に \"$name\" を解約しますか？ 元本 $amount が銀行口座に返金されます。';
  }

  @override
  String get certificates_redeemedSuccess => '証書が解約され、元本が正常に返金されました。';

  @override
  String get certificates_name => '証書名';

  @override
  String get certificates_interestRate => '年利 (%)';

  @override
  String get certificates_linkedBankAccount => '連携銀行口座';

  @override
  String get certificates_periodicYield => '定期利息受取額';

  @override
  String get certificates_paymentReminder => '利息受取リマインダー通知';

  @override
  String get certificates_reminderTime => 'リマインダー時刻';

  @override
  String get certificates_reminder2DaysBefore => '2日前のリマインダー';

  @override
  String get certificates_deleteCertificate => '証書を削除';

  @override
  String get certificates_confirmDeleteCertificate =>
      '本当にこの証書を削除しますか？ 関連するすべての取引が削除され、口座に資金が返金されます。';

  @override
  String get certificates_deleted => '証書を削除しました';

  @override
  String get onboarding_stayOnTopOfFinances => 'お金の流れを常に把握';

  @override
  String get onboarding_stayOnTopOfFinancesDesc =>
      '支払い期限や請求書、予算の上限を見逃さないようリマインダーを設定しましょう。';

  @override
  String get onboarding_featureBillTitle => '請求書とお支払い期限のリマインダー';

  @override
  String get onboarding_featureBillDesc => 'クレジットカードの締め日やローンの支払期日前に通知を受け取ります。';

  @override
  String get onboarding_featureBudgetTitle => '予算アラート';

  @override
  String get onboarding_featureBudgetDesc =>
      '支出限度額の80%または100%に達したときにアラートを受信します。';

  @override
  String get onboarding_featureRecurringTitle => '定期サブスクリプション';

  @override
  String get onboarding_featureRecurringDesc => 'サブスクリプションが自動更新される前にお知らせします。';

  @override
  String get onboarding_allowNotifications => '通知を許可する';

  @override
  String get onboarding_maybeLater => 'あとで設定';

  @override
  String get categories_subcategories => 'サブカテゴリ';

  @override
  String get categories_addSubcategory => 'サブカテゴリを追加';

  @override
  String get categories_parentCategory => '親カテゴリ';

  @override
  String get categories_noneRoot => 'なし (親カテゴリ)';

  @override
  String get categories_loadDefaults => '標準サブカテゴリを読み込む';

  @override
  String categories_defaultsLoaded(int count) {
    return '$count個の標準サブカテゴリを読み込みました';
  }

  @override
  String get categories_defaultsAlreadyLoaded => '標準サブカテゴリは既に読み込まれています';

  @override
  String get statistics_byCategory => 'カテゴリ別';

  @override
  String get statistics_bySubcategory => 'サブカテゴリ別';

  @override
  String get backup_importFromTrackWallet => 'TrackWallet からインポート (.csv)';

  @override
  String backup_importedTransactions(int count) {
    return '$count件の取引をインポートしました！';
  }

  @override
  String get onboarding_restoreTrackWallet => 'TrackWallet からインポート (.csv)';

  @override
  String get transfer_categoryLocked => '振替 (既定かつ唯一のカテゴリ)';

  @override
  String get loans_noLoans => 'ローンはまだ登録されていません';

  @override
  String get loans_noLoansSub => '+ をタップして住宅ローンや分割払いを記録';

  @override
  String get certificates_noCertificatesSub => '+ をタップして定期預金や証書を記録';

  @override
  String get common_undo => '元に戻す';

  @override
  String get common_close => '閉じる';

  @override
  String get common_required => '必須';

  @override
  String get common_invalid => '無効';

  @override
  String get common_none => 'なし';

  @override
  String common_enabledAt(String time) {
    return '有効 ($time)';
  }

  @override
  String get common_disabled => '無効';

  @override
  String get freq_daily => '毎日';

  @override
  String get freq_yearly => '毎年';

  @override
  String recurring_transfers(Object count) {
    return '振替 ($count)';
  }

  @override
  String get recurring_transfer => '振替';

  @override
  String get recurring_transferCaps => '振替';

  @override
  String get recurring_noRecurringTransfers => '定期的な振替はありません';

  @override
  String recurring_subtitleCount(int count) {
    return '$count件のサブスク・定期支払い';
  }

  @override
  String recurring_perWeek(String amount) {
    return '$amount / 週';
  }

  @override
  String get recurring_perMonth => '/ 月';

  @override
  String get recurring_fromAccount => '振替元口座';

  @override
  String get recurring_toAccount => '振替先口座';

  @override
  String recurring_targetAmount(String currency) {
    return '受取額 ($currency)';
  }

  @override
  String get recurring_autoPayAt => '自動支払時刻';

  @override
  String get recurring_autoPayOnDueDate => '期日に自動支払い';

  @override
  String get recurring_autoPayEnabledSub => '期日に自動で記録されます';

  @override
  String get recurring_autoPayDisabledSub => '期日が来たら自動的に記録する';

  @override
  String get recurring_autoPayTime => '自動支払いの時刻';

  @override
  String get recurring_reminderEnabledSub => '期日に通知が届きます';

  @override
  String get recurring_reminderDisabledSub => '支払期日に通知を受け取る';

  @override
  String get recurring_earlyReminderEnabledSub => '2日前の同じ時刻にも事前通知します';

  @override
  String get recurring_earlyReminderDisabledSub => '期日の2日前にも通知を受け取る';

  @override
  String get recurring_addRecurringBtn => '定期支払いを追加';

  @override
  String get recurring_paymentDetails => '支払いの詳細';

  @override
  String get recurring_linkedAccount => '連携口座';

  @override
  String get recurring_deletedAccount => '削除された口座';

  @override
  String get recurring_frequency => '頻度';

  @override
  String get recurring_type => '種類';

  @override
  String get recurring_startDate => '開始日';

  @override
  String get recurring_nextDueDate => '次回期日';

  @override
  String get recurring_autoPay => '自動支払い';

  @override
  String get recurring_reminder => 'リマインダー';

  @override
  String get recurring_endDate => '終了日';

  @override
  String get recurring_totalValue => '合計金額';

  @override
  String get recurring_notes => 'メモ';

  @override
  String get recurring_upcomingPayments => '今後の予定';

  @override
  String recurring_remainingCount(int count) {
    return '残り $count 回';
  }

  @override
  String get recurring_allInstallmentsCompleted => 'すべての分割払いが完了しました';

  @override
  String recurring_installmentOf(int num, int total) {
    return '第$num回 / 全$total回';
  }

  @override
  String get recurring_paymentPaid => '支払い完了';

  @override
  String get recurring_paymentSkipped => 'スキップ済み';

  @override
  String get presets_transfer => '振替';

  @override
  String get presets_selectDifferentAccounts => '異なる振替元・振替先口座を選択してください。';

  @override
  String presets_targetAmountOptional(String currency) {
    return '$currency の受取額 (任意)';
  }

  @override
  String get transactions_transfers => '振替';

  @override
  String transactions_selectedItemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件選択中',
    );
    return '$_temp0';
  }

  @override
  String transactions_entriesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件',
    );
    return '$_temp0';
  }

  @override
  String get transactions_clearSelection => '選択を解除';

  @override
  String get transactions_transferTitle => '振替取引';

  @override
  String get transactions_transferBody =>
      'この取引は口座振替の一部です。残高の整合性を保つため片側のみの編集はできません。この振替を削除しますか？';

  @override
  String get transactions_deleteTransfer => '振替を削除';

  @override
  String get transactions_transferDeleted => '振替を削除しました';

  @override
  String get transactions_certTitle => '定期預金の取引';

  @override
  String get transactions_certBody =>
      'この取引は定期預金・証書に紐づいています。元本と利息の整合性を保つため、定期預金画面から操作してください。';

  @override
  String get transactions_viewCertificate => '定期預金を表示';

  @override
  String get transactions_openCertificates => '定期預金を開く';

  @override
  String get transactions_loanFallback => 'ローン';

  @override
  String get transactions_loanPayment => 'ローン返済';

  @override
  String get transactions_goalContribution => '目標への積立';

  @override
  String get transactions_goalWithdrawal => '目標からの出金';

  @override
  String get calendar_repayment => '返済';

  @override
  String get calendar_transfersDue => '予定された定期振替';

  @override
  String accounts_subtitleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件の口座',
    );
    return '$_temp0';
  }

  @override
  String get accounts_tabAccounts => '口座';

  @override
  String get accounts_tabCards => 'カード';

  @override
  String get accounts_addCardBtn => 'カードを追加';

  @override
  String get accounts_addNewCardBtn => '新しいカードを追加';

  @override
  String get accounts_editCard => 'カードを編集';

  @override
  String get accounts_cardNameHint => 'カード名 (例: Visa Platinum)';

  @override
  String get accounts_debitCard => 'デビットカード';

  @override
  String get accounts_prepaidCard => 'プリペイドカード';

  @override
  String get accounts_pinToWidget => 'ウィジェットに固定';

  @override
  String get accounts_unpinFromWidget => 'ウィジェットから外す';

  @override
  String get accounts_maxPinnedWarning => '固定できる口座は最大3つです';

  @override
  String get accounts_selectLinkedBank => 'このデビットカードに連携する銀行口座を選択してください。';

  @override
  String get accounts_debitSharesBalance => 'デビットカードは連携する銀行口座の残高を共有します。';

  @override
  String get accounts_linkedBankRequired => '連携銀行口座 (必須)';

  @override
  String get accounts_amountCurrentlyOwed => '現在の利用残高';

  @override
  String get accounts_initialAmountOwed => '初期利用残高';

  @override
  String get accounts_cardDebtHint => 'カードの未払い残高を入力（負債として保存）';

  @override
  String accounts_nextCycleCloses(int day) {
    return '次回の締め日は毎月 $day 日頃です';
  }

  @override
  String accounts_spotPriceLabel(int karat) {
    return '相場価格 ($karat金 / g)';
  }

  @override
  String get accounts_weightTimesPurity => '重量 × 純度';

  @override
  String accounts_blockDeleteRecurring(int count) {
    return 'この口座には$count件の定期支払いがあります。先に変更または削除してください。';
  }

  @override
  String accounts_blockDeleteLoans(int count) {
    return 'この口座には$count件のローンがあります。先に変更または削除してください。';
  }

  @override
  String accounts_blockDeleteCertificates(int count) {
    return 'この口座には$count件の定期預金があります。先に解約または削除してください。';
  }

  @override
  String accounts_blockDeleteLended(int count) {
    return 'この口座には$count件の未精算の貸借があります。先に精算してください。';
  }

  @override
  String accounts_blockDeleteSavings(int count) {
    return 'この口座は$count件の貯蓄目標で使用されています。先に変更または削除してください。';
  }

  @override
  String accounts_blockDeletePresets(int count) {
    return 'この口座は$count件のプリセットで使用されています。先に変更または削除してください。';
  }

  @override
  String accounts_blockDeleteCards(int count) {
    return 'この口座は$count枚のカードに連携しています。先に解除または削除してください。';
  }

  @override
  String get add_transaction_selectAccountOrCard => '口座またはカードを選択してください。';

  @override
  String get add_transaction_balanced => '一致';

  @override
  String add_transaction_similarExists(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '類似する取引が $count 件すでに存在します:',
    );
    return '$_temp0';
  }

  @override
  String budget_goalsCountSubtitle(int budgets, int goals) {
    return '$budgets 予算 · $goals 目標';
  }

  @override
  String get budget_savingsGoalsCaps => '貯蓄目標';

  @override
  String budget_percentSaved(String percent) {
    return '$percent% 達成';
  }

  @override
  String budget_ofTarget(String amount) {
    return '目標 $amount 中';
  }

  @override
  String get budget_goalsTab => '目標';

  @override
  String get budget_completed => '完了';

  @override
  String get savings_newGoal => '新しい貯蓄目標';

  @override
  String get savings_editGoal => '貯蓄目標を編集';

  @override
  String get certificates_activePrincipal => '運用中の元本';

  @override
  String get certificates_activeCount => '有効件数';

  @override
  String certificates_linkedBank(String name) {
    return '連携口座: $name';
  }

  @override
  String certificates_yieldSummary(String amount, String type) {
    return '利回り: $amount ($type)';
  }

  @override
  String certificates_maturesOn(String date) {
    return '満期日: $date';
  }

  @override
  String get certificates_settledCaps => '満期済';

  @override
  String get certificates_activeCaps => '運用中';

  @override
  String get certificates_annualRate => '年利';

  @override
  String get certificates_periodicYieldLabel => '定期利息';

  @override
  String get certificates_maturedAndSettled => '満期・精算済み';

  @override
  String get certificates_payoutOverride => '受取額 (手動設定)';

  @override
  String get certificates_dayRange => '日 (1〜31)';

  @override
  String get certificates_noBankAccounts =>
      '銀行口座がありません。利息を受け取るために銀行口座を作成してください。';

  @override
  String get certificates_selectLinkedBank => '連携する銀行口座を選択してください。';

  @override
  String get creditCard_noFundingAccounts => '支払いに使える銀行または現金口座がありません。';

  @override
  String get creditCard_processing => '処理中...';

  @override
  String creditCard_payAmountBtn(String amount) {
    return '$amount を支払う';
  }

  @override
  String get insights_loanPaymentsThisMonth => '今月のローン返済額';

  @override
  String get insights_spendingForecast => '支出予測';

  @override
  String get insights_forecastPrefix => 'このペースでは ';

  @override
  String insights_forecastSuffix(String month, int days) {
    return '（$month末まで・残り$days日）に達する見込みです。';
  }

  @override
  String get insights_forecastDisclaimer => 'これまでの支出に基づく予測であり、今後の定期支払いは含まれません。';

  @override
  String insights_forecastAccuracy(int days) {
    return '最初の$days日間のデータに基づいています — 月が進むほど精度が上がります。';
  }

  @override
  String insights_projAmount(String amount) {
    return '予測: $amount';
  }

  @override
  String insights_projOfBudget(String percent) {
    return ' (予算の$percent%)';
  }

  @override
  String get insights_outstanding => '未払い残高';

  @override
  String get insights_monthlyObligation => '毎月の返済額';

  @override
  String get loans_principal => '元金';

  @override
  String get loans_interestRate => '金利';

  @override
  String get loans_duration => '期間';

  @override
  String get loans_transferTo => '融資金の入金先';

  @override
  String get loans_payFrom => '返済元の口座';

  @override
  String loans_dueDayTime(int day, String time) {
    return '返済日: 毎月$day日 $time';
  }

  @override
  String more_activeCount(int count) {
    return '有効 $count件';
  }

  @override
  String more_toolsSubtitle(int count) {
    return '$count個のツールと設定';
  }

  @override
  String get more_totalWealthCaps => '総資産';

  @override
  String get more_liveNetWorthSub => 'すべての保有資産のリアルタイム純資産';

  @override
  String more_assetsAmount(String amount) {
    return '資産: $amount';
  }

  @override
  String more_liabilitiesAmount(String amount) {
    return '負債: $amount';
  }

  @override
  String get netWorth_debtFree => '無借金';

  @override
  String get netWorth_showLess => '閉じる';

  @override
  String netWorth_showAll(int count) {
    return 'すべて表示 ($count)';
  }

  @override
  String get netWorth_zeroLiabilities => '負債はありません！現在の借入残高はゼロです。';

  @override
  String get netWorth_lentDebts => '貸付 / 借入';

  @override
  String netWorth_snapBreakdown(String assets, String accounts) {
    return '資産: $assets · 口座: $accounts';
  }

  @override
  String get onboarding_nameRequired => '名前は必須です';

  @override
  String get onboarding_popularCurrencies => '主な通貨';

  @override
  String get onboarding_debitCardNextStep => '次のステップでこの銀行口座のデビットカードを追加できます';

  @override
  String get onboarding_addDebitCardTitle => 'デビットカードを追加';

  @override
  String get onboarding_addDebitCardDesc =>
      '新しい銀行口座にデビットカードを連携して、支出を簡単に記録できます。';

  @override
  String get onboarding_cardName => 'カード名';

  @override
  String get onboarding_cardholderName => '名義人';

  @override
  String get onboarding_last4Digits => '下4桁の番号';

  @override
  String get onboarding_cardColor => 'カードのカラー';

  @override
  String wrapped_zeroSpendOfDays(int total) {
    return '$total日中の無支出日数';
  }

  @override
  String get wrapped_savingsRateLabel => '貯蓄率';

  @override
  String get wrapped_topCategoryLabel => '最多カテゴリ';

  @override
  String get wrapped_zeroSpendDaysLabel => '無支出日数';

  @override
  String get wrapped_footerTag => '★ プライベート＆オフライン家計管理 ★';

  @override
  String get yearly_tapToExpand => 'タップして展開';

  @override
  String get yearly_noDataBadge => 'データなし';

  @override
  String get export_formatHeader => '出力形式';

  @override
  String export_pdfPeriod(String range) {
    return '期間: $range';
  }

  @override
  String export_pdfCurrency(String currency) {
    return '通貨: $currency';
  }

  @override
  String export_pdfGenerated(String date) {
    return '作成日: $date';
  }

  @override
  String export_pdfPageOf(int page, int total) {
    return '$page / $total ページ';
  }

  @override
  String get export_pdfTotalAssets => '総資産';

  @override
  String get export_pdfTotalLiabilities => '総負債';

  @override
  String get export_pdfCurrentNetWorth => '現在の純資産';

  @override
  String get export_pdfCategory => 'カテゴリ';

  @override
  String export_pdfAmountHeader(String currency) {
    return '金額 ($currency)';
  }

  @override
  String get export_pdfPercentOfExpenses => '総支出の割合 (%)';

  @override
  String get backup_encryptedTitle => '暗号化されたバックアップ';

  @override
  String get backup_encryptedPrompt => 'このバックアップの暗号化パスワードを入力してください:';

  @override
  String get backup_password => 'パスワード';

  @override
  String get backup_confirmPassword => 'パスワード確認';

  @override
  String get backup_decryptContinue => '復号して続行';

  @override
  String get backup_chooseRestoreMode => '復元モードを選択';

  @override
  String get backup_chooseRestoreModeDesc =>
      'すべてのデータを復元するか、特定のデータのみを復元するか選択します。';

  @override
  String get backup_selectiveRestore => '選択復元';

  @override
  String get backup_selectiveRestoreDesc => '他のデータや設定を消さずに特定の項目のみ復元します。';

  @override
  String get backup_fullRestore => '完全復元';

  @override
  String get backup_fullRestoreDesc => '現在のすべてのデータと設定をバックアップで完全に置き換えます。';

  @override
  String get backup_selectiveBackup => '選択バックアップ';

  @override
  String get backup_selectiveBackupBtn => '選択バックアップ...';

  @override
  String get backup_selectiveBackupDesc => 'JSON形式でエクスポートするデータ項目を選択してください。';

  @override
  String get backup_selectedRestoredSuccess => '選択したデータを復元しました！';

  @override
  String get backup_savingsGoals => '貯蓄目標';

  @override
  String get backup_savingsContributions => '目標への積立';

  @override
  String get backup_encryptionDisabled => 'バックアップ暗号化を無効にしました';

  @override
  String get backup_encryptionEnabled => 'バックアップ暗号化を有効にしました';

  @override
  String backup_encryptionFailed(String error) {
    return '暗号化の有効化に失敗: $error';
  }

  @override
  String get backup_encryptAutoTitle => '自動バックアップを暗号化';

  @override
  String get backup_encryptAutoDesc =>
      'AES-GCM-256で自動バックアップを保護します。パスワードを忘れると復元できません。';

  @override
  String get backup_passwordEmpty => 'パスワードを入力してください';

  @override
  String get backup_passwordsMismatch => 'パスワードが一致しません';

  @override
  String get backup_setPassword => 'パスワードを設定';

  @override
  String backup_autoCreated(String file) {
    return '自動バックアップ作成完了: $file';
  }

  @override
  String backup_autoFailed(String error) {
    return '自動バックアップ失敗: $error';
  }

  @override
  String get backup_nightlySchedule => '毎晩 2:00 頃に指定フォルダへ保存';

  @override
  String get backup_noFolderSelected => 'フォルダ未選択';

  @override
  String get backup_keepCopies => '保存世代数:';

  @override
  String get backup_encryptAes => '暗号化 (AES-GCM)';

  @override
  String backup_failedError(String error) {
    return '失敗: $error';
  }

  @override
  String backup_lastSuccess(String date, String kb) {
    return '前回: $date ($kb KB)';
  }

  @override
  String get backup_backingUp => 'バックアップ中...';

  @override
  String get backup_backUpNow => '今すぐバックアップ';

  @override
  String get backup_androidIdleNote => '深夜2:00頃に実行されます。端末の休止状態により遅延する場合があります。';

  @override
  String get backup_selectAll => 'すべて選択';

  @override
  String get backup_deselectAll => 'すべて解除';

  @override
  String get backup_selectiveSaved => '選択バックアップを保存しました！';

  @override
  String backup_exportFailed(String error) {
    return 'エクスポート失敗: $error';
  }

  @override
  String backup_exportSelected(int count) {
    return '選択した $count 項目をエクスポート';
  }

  @override
  String backup_restoreSelected(int count) {
    return '選択した $count 項目を復元';
  }

  @override
  String get backup_selectiveRestoreNote => '選択した項目のみ復元され、その他の口座や設定は維持されます。';

  @override
  String backup_countInBackup(int count) {
    return 'バックアップ内に $count 件';
  }

  @override
  String get backup_entityTxSplitsPresets => '取引・分割・プリセット';

  @override
  String get backup_entityRecurringHistory => '定期支払いと履歴';

  @override
  String get backup_entityLoansPayments => 'ローンと返済記録';

  @override
  String get backup_entityLentContacts => '貸借記録と連絡先';

  @override
  String get backup_entityAssetsValuables => '資産と貴重品';

  @override
  String get backup_entityWishlistGoals => 'ほしい物リストと貯蓄目標';

  @override
  String get common_perDay => '/ 日';

  @override
  String common_daysShort(int count) {
    return '$count日';
  }

  @override
  String get common_splitCaps => '分割';

  @override
  String budget_deletedCategory(String name) {
    return '$name を削除しました';
  }

  @override
  String get loans_paymentDeleted => '支払いを削除しました';

  @override
  String certificates_collectionDayLabel(String frequency, int day) {
    return '$frequency ($day日)';
  }

  @override
  String add_transaction_duplicateItem(
      String amount, String date, String desc) {
    return '• $date に $amount$desc';
  }

  @override
  String creditCard_billPaymentDesc(String name) {
    return 'クレジットカード請求書払い — $name';
  }

  @override
  String get onboarding_defaultBankName => 'メイン銀行';

  @override
  String get onboarding_defaultCardholder => 'EXPENSY メンバー';

  @override
  String get onboarding_defaultUser => 'ユーザー';

  @override
  String get export_excelSheetName => '取引履歴';

  @override
  String get export_headerDate => '日付';

  @override
  String get export_headerDescription => '説明';

  @override
  String get export_headerType => '種類';

  @override
  String get export_headerAmount => '金額';

  @override
  String get export_headerCurrency => '通貨';

  @override
  String get export_headerAccount => '口座';

  @override
  String get export_headerCategory => 'カテゴリ';

  @override
  String get export_headerSubcategory => 'サブカテゴリ';

  @override
  String get export_headerNote => 'メモ';

  @override
  String get cat_food_exp => '食事・外食';

  @override
  String get cat_transport => '交通';

  @override
  String get cat_shopping => '買い物';

  @override
  String get cat_bills => '光熱費・請求書';

  @override
  String get cat_health => '健康・医療';

  @override
  String get cat_entertainment => '娯楽';

  @override
  String get cat_education => '教育';

  @override
  String get cat_personal => '身だしなみ';

  @override
  String get cat_salary => '給与';

  @override
  String get cat_freelance => 'フリーランス';

  @override
  String get cat_investments => '投資収益';

  @override
  String get cat_gifts => 'ギフト';

  @override
  String get cat_other_inc => 'その他の収入';

  @override
  String get cat_other_exp => 'その他の支出';

  @override
  String get cat_sys_transfer => '振替';

  @override
  String get cat_sys_investment => '投資';

  @override
  String get sub_groceries => '食料品';

  @override
  String get sub_restaurants => 'レストラン';

  @override
  String get sub_delivery => 'デリバリー';

  @override
  String get sub_coffee_tea => 'コーヒー・紅茶';

  @override
  String get sub_fuel => '燃料';

  @override
  String get sub_public_transit => '公共交通';

  @override
  String get sub_taxi_ride => 'タクシー';

  @override
  String get sub_maintenance => '整備・修理';

  @override
  String get sub_parking_tolls => '駐車・通行料';

  @override
  String get sub_clothing => '衣類';

  @override
  String get sub_electronics => '家電・電子機器';

  @override
  String get sub_home_furniture => '家具・日用品';

  @override
  String get sub_gifts => 'プレゼント';

  @override
  String get sub_electricity => '電気代';

  @override
  String get sub_internet => 'インターネット';

  @override
  String get sub_water => '水道代';

  @override
  String get sub_phone => '携帯電話';

  @override
  String get sub_medicine => '薬';

  @override
  String get sub_doctor => '診察';

  @override
  String get sub_movies => '映画';

  @override
  String get sub_games => 'ゲーム';

  @override
  String get sub_subscriptions => 'サブスク';

  @override
  String get notif_overBudgetTitle => '🚨 予算超過';

  @override
  String notif_overBudgetBody(String category, String amount, String period) {
    return '$category — $periodの上限を $amount 超過しました';
  }

  @override
  String get notif_goalReachedTitle => '🎉 目標達成';

  @override
  String notif_goalReachedBody(String amount, String name) {
    return '$name の目標 $amount を達成しました！';
  }

  @override
  String get notif_certPayoutDueTitle => '📈 証書配当期日';

  @override
  String get notif_certPayoutUpcomingTitle => '📈 まもなく証書配当期日';

  @override
  String notif_certPayoutBody(String name) {
    return '$name の利払いが本日予定されています。';
  }

  @override
  String notif_certPayoutSoonBody(String name) {
    return '$name の利払いは2日後です。';
  }

  @override
  String get notif_creditBillDueTodayTitle => '💳 本日が支払日';

  @override
  String get notif_creditBillDueSoonTitle => '💳 支払日が近づいています';

  @override
  String get notif_dailyReminderTitle => '📝 毎日のリマインダー';

  @override
  String get notif_dailyReminderBody => '今日の支出を記録するのを忘れずに。';

  @override
  String notif_lendedDueTitle(String emoji, String name) {
    return '$emoji 期日: $name';
  }

  @override
  String get notif_loanPaymentDueTitle => '🏦 ローン返済期日';

  @override
  String notif_loanPaymentDueBody(String name) {
    return '$name の分割払いが本日期日です。';
  }

  @override
  String get notif_autoBackupFailedTitle => '自動バックアップ失敗';

  @override
  String notif_autoBackupFailedBody(String error) {
    return '予定されていたバックアップを作成できませんでした: $error';
  }

  @override
  String notif_recurringTransferBody(String amount) {
    return '$amount の振替が期日です';
  }

  @override
  String notif_recurringIncomeBody(String amount) {
    return '$amount の収入予定日です';
  }

  @override
  String notif_recurringExpenseBody(String amount) {
    return '$amount の支払い期日です';
  }

  @override
  String notif_creditBillDueTodayBody(String name) {
    return '$nameの請求日が本日です。';
  }

  @override
  String notif_creditBillDueSoonBody(String name) {
    return '$nameの請求日が2日後です。';
  }

  @override
  String notif_lendedLentDueBody(String amount, String name) {
    return '$nameに貸した$amountの返済期日が本日です';
  }

  @override
  String notif_lendedBorrowedDueBody(String amount, String name) {
    return '$nameから借りた$amountの返済期日が本日です';
  }

  @override
  String notif_recurringTransferDueSoonBody(String amount) {
    return '$amountの振替が2日後に予定されています';
  }

  @override
  String notif_recurringIncomeDueSoonBody(String amount) {
    return '$amountの収入が2日後に予定されています';
  }

  @override
  String notif_recurringExpenseDueSoonBody(String amount) {
    return '$amountの支払いが2日後に予定されています';
  }
}
