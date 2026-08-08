// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Дорогой';

  @override
  String get settings_title => 'Настройки';

  @override
  String get settings_appearance => 'Внешний вид';

  @override
  String get settings_theme => 'Тема';

  @override
  String get settings_system => 'Система';

  @override
  String get settings_light => 'Светлая';

  @override
  String get settings_dark => 'Темная';

  @override
  String get settings_amoledTitle => 'Чистый черный (AMOLED)';

  @override
  String get settings_amoledSubtitle => 'Включает черный фон в темном режиме';

  @override
  String get settings_systemDefault => 'Системный по умолчанию';

  @override
  String get settings_dynamicColor => 'Динамический цвет';

  @override
  String get settings_dynamicColorSubtitle =>
      'Использовать системные цвета обоев';

  @override
  String get settings_accentColor => 'Акцентный цвет';

  @override
  String get settings_accentColorSubtitle =>
      'Выберите исходный цвет для приложения';

  @override
  String get settings_appFont => 'Шрифт приложения';

  @override
  String get settings_currency => 'Валюта';

  @override
  String get settings_defaultCurrency => 'Валюта по умолчанию';

  @override
  String get settings_preferences => 'Предпочтения';

  @override
  String get settings_weekStartsOn => 'Неделя начинается';

  @override
  String get settings_monday => 'Понедельник';

  @override
  String get settings_sunday => 'Воскресенье';

  @override
  String get settings_hideBalance => 'Скрыть баланс';

  @override
  String get settings_hideBalanceSubtitle => 'Показывать ••••• вместо сумм';

  @override
  String get settings_language => 'Язык';

  @override
  String get settings_profile => 'Профиль';

  @override
  String get settings_displayName => 'Отображаемое имя';

  @override
  String get settings_notSet => 'Не установлено';

  @override
  String get settings_about => 'О приложении';

  @override
  String get settings_version => 'Версия';

  @override
  String get settings_privacy => 'Конфиденциальность';

  @override
  String get settings_privacySubtitle =>
      'Все данные хранятся локально — 100 % в автономном режиме';

  @override
  String get settings_github => 'Гитхаб';

  @override
  String get settings_githubSubtitle => 'Просмотреть исходный код';

  @override
  String get settings_developer => 'Разработчик';

  @override
  String get settings_developerSubtitle =>
      'Узнайте больше о проектах Mina Android';

  @override
  String get settings_githubProfile => 'Профиль GitHub';

  @override
  String get settings_developerWebsite => 'Веб-сайт разработчика';

  @override
  String get settings_close => 'Закрыть';

  @override
  String get settings_yourName => 'Ваше имя';

  @override
  String get settings_cancel => 'Отменить';

  @override
  String get settings_save => 'Сохранить';

  @override
  String recurring_expenses(Object count) {
    return 'Расходы ($count)';
  }

  @override
  String recurring_incomeList(Object count) {
    return 'Доход ($count)';
  }

  @override
  String get recurring_monthly => 'Ежемесячно';

  @override
  String get recurring_weekly => 'Еженедельно';

  @override
  String get recurring_noRecurringExpenses => 'Никаких периодических расходов';

  @override
  String get recurring_noRecurringIncome => 'Нет постоянного дохода';

  @override
  String get recurring_addExpense => 'Добавить расходы';

  @override
  String get recurring_addIncome => 'Добавить доход';

  @override
  String get recurring_tapPlusToAddOne => 'Нажмите +, чтобы добавить';

  @override
  String recurring_fromOngoing(Object date) {
    return 'С $date · Продолжается';
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
  String get recurring_overdue => 'Просрочено!';

  @override
  String get recurring_dueToday => 'Срок оплаты сегодня';

  @override
  String recurring_dueInDays(Object days) {
    return 'Due in ${days}d';
  }

  @override
  String get recurring_edit => 'Редактировать';

  @override
  String get recurring_skipBtn => 'Пропустить';

  @override
  String recurring_nextDate(Object date) {
    return 'Next: $date';
  }

  @override
  String get recurring_pay => 'Платить';

  @override
  String get recurring_del => 'Дель';

  @override
  String recurring_historyCount(Object count) {
    return 'История ($count)';
  }

  @override
  String get recurring_paymentHistory => 'История платежей';

  @override
  String get recurring_notificationPermissionDenied =>
      'Разрешение на уведомление отклонено. Включите его в «Настройки» → «Приложения» → «Дорогие» → «Уведомления».';

  @override
  String get recurring_remindMeAt => 'Напомните мне';

  @override
  String get recurring_editRecurring => 'Редактировать Повторяющиеся';

  @override
  String get recurring_addRecurring => 'Добавить регулярный платеж';

  @override
  String get recurring_name => 'Имя';

  @override
  String get recurring_amountPerPayment => 'Сумма платежа';

  @override
  String recurring_firstDate(Object date) {
    return 'First: $date';
  }

  @override
  String recurring_lastDate(Object date) {
    return 'Последний: $date';
  }

  @override
  String get recurring_noLastPaymentOngoing =>
      'Без последнего платежа (текущий)';

  @override
  String get accounts_refreshExchangeRates => 'Обновить курсы валют';

  @override
  String get accounts_noAccounts => 'Нет аккаунтов';

  @override
  String get accounts_tapPlusToAddYourFirst =>
      'Нажмите +, чтобы добавить свою первую учетную запись';

  @override
  String get accounts_fetchingExchangeRates => 'Получение курсов валют…';

  @override
  String get accounts_exchangeRatesUnavailable =>
      'Курсы валют недоступны (оффлайн). Балансы показаны в национальной валюте.';

  @override
  String get accounts_unknown => 'Неизвестно';

  @override
  String accounts_ratesUpdated(Object timeStr) {
    return 'Цены обновлены $timeStr · Нажмите ↺, чтобы обновить';
  }

  @override
  String get accounts_goldCaps => 'ЗОЛОТО';

  @override
  String get accounts_balance => 'Баланс';

  @override
  String get accounts_income => 'Доход';

  @override
  String get accounts_expense => 'Расход';

  @override
  String get accounts_txs => 'Передача';

  @override
  String get accounts_value => 'Значение';

  @override
  String get accounts_karat => 'Карат';

  @override
  String accounts_pure(Object percentage) {
    return '$percentage% pure';
  }

  @override
  String get accounts_weightLabel => 'Вес';

  @override
  String get accounts_perGram => 'За грамм';

  @override
  String get accounts_bank => 'Банк';

  @override
  String get accounts_cash => 'Наличные';

  @override
  String get accounts_savings => 'Экономия';

  @override
  String get accounts_creditCard => 'Кредитная карта';

  @override
  String get accounts_eWallet => 'Электронный кошелек';

  @override
  String get accounts_gold => 'Золото';

  @override
  String get accounts_editAccount => 'Редактировать учетную запись';

  @override
  String get accounts_addAccount => 'Добавить новую учетную запись';

  @override
  String get accounts_accountName => 'Имя учетной записи';

  @override
  String get accounts_weightInGrams => 'Вес в граммах';

  @override
  String get accounts_initialBalance => 'Начальный баланс';

  @override
  String get accounts_wontCountTowardYourHome =>
      'Не будет учитываться при подсчете общего количества данных на главном экране';

  @override
  String get accounts_saveChanges => 'Сохранить изменения';

  @override
  String get accounts_addAccountBtn => 'Добавить учетную запись';

  @override
  String get accounts_fetchingGoldPrice => 'Получение цены на золото…';

  @override
  String get accounts_goldPriceUnavailable =>
      'Цена на золото недоступна — проверьте подключение';

  @override
  String lended_person_owesYou(Object name) {
    return '$name должен вам';
  }

  @override
  String lended_person_youOwe(Object name) {
    return 'You owe $name';
  }

  @override
  String get lended_person_allSettledUp => 'Все улажено';

  @override
  String get lended_person_noRecordsYet => 'Пока нет записей';

  @override
  String get lended_person_tapPlusToLog =>
      'Нажмите +, чтобы зарегистрировать деньги, одолженные или взятые в долг';

  @override
  String get lended_person_name => 'Имя';

  @override
  String get lended_person_notesOptional => 'Примечания (необязательно)';

  @override
  String get lended_person_lent => 'Великий пост';

  @override
  String get lended_person_borrowed => 'Заимствованный';

  @override
  String get lended_person_overdue => 'Просрочено!';

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
      'Разрешение на уведомление отклонено. Включите его в «Настройки» → «Приложения» → «Дорогие» → «Уведомления».';

  @override
  String get lended_person_remindMeAtPrompt => 'Напомните мне';

  @override
  String get lended_person_editRecord => 'Редактировать запись';

  @override
  String get lended_person_addRecord => 'Добавить запись';

  @override
  String get lended_person_amount => 'Количество';

  @override
  String lended_person_dueColon(Object date) {
    return 'Due: $date';
  }

  @override
  String get lended_person_noDueDate => 'Нет срока сдачи';

  @override
  String get lended_person_setDueFirst => 'Сначала установите дату сдачи';

  @override
  String get lended_person_notifiedOnDue => 'Вы будете уведомлены о дате сдачи';

  @override
  String get lended_person_getNotifiedWhenDue =>
      'Получите уведомление, когда это наступит';

  @override
  String get lended_person_thatTimePassed =>
      'Сегодняшнее время уже прошло — вскоре вы получите уведомление.';

  @override
  String lended_person_notificationFiresOn(Object date, Object time) {
    return 'Уведомление сработает $date в $time.';
  }

  @override
  String get lended_person_saveChangesBtn => 'Сохранить изменения';

  @override
  String get lended_person_addRecordBtn => 'Добавить запись';

  @override
  String get transactions_searchTransactions => 'Поиск транзакций...';

  @override
  String get transactions_all => 'Все';

  @override
  String get transactions_income => 'Доход';

  @override
  String get transactions_expenses => 'Расходы';

  @override
  String get transactions_lent => 'Великий пост';

  @override
  String get transactions_borrowed => 'Заимствованный';

  @override
  String get transactions_noTransactions => 'Нет транзакций';

  @override
  String get transactions_tapPlusToAddOne => 'Нажмите +, чтобы добавить';

  @override
  String get transactions_today => 'Сегодня';

  @override
  String get transactions_yesterday => 'Вчера';

  @override
  String transactions_lentTo(Object name) {
    return 'Lent to $name';
  }

  @override
  String transactions_borrowedFrom(Object name) {
    return 'Borrowed from $name';
  }

  @override
  String get transactions_unknown => 'Неизвестно';

  @override
  String transactions_due(Object date) {
    return 'Due $date';
  }

  @override
  String get transactions_unsettled => 'Неустроенный';

  @override
  String get onboarding_restoreFailed =>
      'Восстановление не удалось: возможно, файл поврежден или не является дорогой резервной копией.';

  @override
  String get onboarding_continue => 'Продолжить';

  @override
  String get onboarding_getStarted => 'Начать';

  @override
  String get onboarding_yourPersonalTracker =>
      'Ваш личный 100% офлайн-трекер финансов.\nУ вас уже есть резервная копия с другого устройства или предыдущей установки?';

  @override
  String get onboarding_restoring => 'Восстановление...';

  @override
  String get onboarding_chooseBackupFile => 'Выберите файл резервной копии';

  @override
  String get onboarding_letsGetYouSetUp => 'Давайте настроим';

  @override
  String get onboarding_yourName => 'Ваше имя';

  @override
  String get onboarding_accountName => 'Имя учетной записи';

  @override
  String get onboarding_bank => 'Банк';

  @override
  String get onboarding_cash => 'Наличные';

  @override
  String get onboarding_savings => 'Экономия';

  @override
  String get onboarding_credit => 'Кредит';

  @override
  String get onboarding_wallet => 'Кошелек';

  @override
  String get onboarding_startingBalance => 'Стартовый баланс';

  @override
  String get backup_replaceDataWarning =>
      'Это заменит ВСЕ ваши текущие данные резервной копией.\nЭто невозможно отменить.';

  @override
  String get backup_whatsIncluded => 'Что включено';

  @override
  String get backup_backupDescription =>
      'Каждая резервная копия включает в себя все ваши данные — счета, транзакции, повторяющиеся платежи и историю их платежей/пропусков, бюджеты, элементы списка желаний, людей и записи, одолженных и взятых взаймы, активы, категории и настройки приложения.';

  @override
  String get backup_saving => 'Сохранение...';

  @override
  String get backup_saveBackup => 'Сохранить резервную копию';

  @override
  String get backup_restoring => 'Восстановление...';

  @override
  String get backup_restoreBackupBtn => 'Восстановить резервную копию';

  @override
  String get backup_restoreWarningText =>
      'Совместимо с резервными копиями из любой версии приложения. Отсутствующие поля заполняются безопасными значениями по умолчанию.';

  @override
  String get backup_included => 'включено';

  @override
  String get backup_accounts => 'Счета';

  @override
  String get backup_transactions => 'Транзакции';

  @override
  String get backup_recurringPayments => 'Регулярные платежи';

  @override
  String get backup_recurringHistory => 'Повторяющаяся история';

  @override
  String get backup_budgets => 'Бюджеты';

  @override
  String get backup_wishlist => 'Список желаний';

  @override
  String get backup_lentPeople => 'Одолженное/заимствованное — Люди';

  @override
  String get backup_lentRecords => 'Одолженные/заимствованные — записи';

  @override
  String get backup_assets => 'Активы';

  @override
  String get backup_categories => 'Категории';

  @override
  String get backup_settings => 'Настройки';

  @override
  String backup_backupSavedSuccessfully(Object savedPath) {
    return 'Резервная копия успешно сохранена:\n$savedPath';
  }

  @override
  String backup_backupFailed(Object error) {
    return 'Backup failed: $error';
  }

  @override
  String backup_upgradedFrom(Object originalVersion, Object schemaVersion) {
    return '(обновлено с v$originalVersion → v$schemaVersion)';
  }

  @override
  String backup_dataRestoredSuccessfully(Object vLabel) {
    return 'Данные успешно восстановлены!$vLabel';
  }

  @override
  String backup_restoreFailed(Object error) {
    return 'Restore failed: $error';
  }

  @override
  String get backup_restoreFailedCorrupted =>
      'Восстановление не удалось: возможно, файл поврежден или не является дорогой резервной копией.';

  @override
  String get budget_noBudgetsYet => 'Бюджетов пока нет';

  @override
  String get budget_tapToAddBudget =>
      'Нажмите +, чтобы установить лимит расходов для каждой категории';

  @override
  String get budget_budgeted => 'В бюджете';

  @override
  String get budget_spent => 'Потрачено';

  @override
  String get budget_overLimit => 'Превышение лимита';

  @override
  String get budget_unknown => 'Неизвестно';

  @override
  String get budget_weeklyLabel => 'Еженедельно';

  @override
  String get budget_monthlyLabel => 'Ежемесячно';

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
    return '$percent% использовано';
  }

  @override
  String get budget_editBudget => 'Изменить бюджет';

  @override
  String get budget_setBudget => 'Добавить новый бюджет';

  @override
  String get budget_budgetAmount => 'Сумма бюджета';

  @override
  String budget_previewFor(Object catName) {
    return 'Предварительный просмотр \\\"$catName\\\"';
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
  String get budget_saveChanges => 'Сохранить изменения';

  @override
  String get budget_budget => 'Бюджет';

  @override
  String get insights_other => 'Другое';

  @override
  String get insights_noDataYet => 'Данных пока нет';

  @override
  String get insights_addSomeTransactions =>
      'Добавьте несколько транзакций, чтобы увидеть статистику';

  @override
  String get insights_thisMonthVsLastMonth =>
      'В этом месяце и в прошлом месяце';

  @override
  String get insights_dailyAverage => 'Среднее дневное значение';

  @override
  String insights_perDayBasedOn(Object days) {
    return 'в день · исходя из $days дней в этом месяце';
  }

  @override
  String get insights_incomeVsExpenses => 'Доходы и расходы';

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
    return '$percent% сэкономлено в этом месяце';
  }

  @override
  String get insights_topSpendingCategories =>
      'Категории с наибольшими расходами';

  @override
  String insights_percentOfTotal(Object percent) {
    return '$percent % от общего числа';
  }

  @override
  String get insights_biggestExpenseThisMonth =>
      'Самый большой расход в этом месяце';

  @override
  String get insights_categoryTrends =>
      'Тенденции категорий (по сравнению с прошлым месяцем)';

  @override
  String get insights_12MonthTrend => '12-месячный тренд';

  @override
  String get insights_incomeLabel => 'Доход';

  @override
  String get insights_expensesLabel => 'Расходы';

  @override
  String get categories_expenseLabel => 'Расход';

  @override
  String get categories_incomeLabel => 'Доход';

  @override
  String get categories_editCategory => 'Редактировать категорию';

  @override
  String get categories_addCategory => 'Добавить категорию';

  @override
  String get categories_categoryName => 'Название категории';

  @override
  String get categories_saveChanges => 'Сохранить изменения';

  @override
  String get statistics_other => 'Другое';

  @override
  String get statistics_allAccounts => 'Все аккаунты';

  @override
  String get statistics_income => 'Доход';

  @override
  String get statistics_expenses => 'Расходы';

  @override
  String get statistics_expense => 'Расход';

  @override
  String get statistics_net => 'Чистая';

  @override
  String statistics_6MonthOverviewAccount(Object accountName) {
    return 'Обзор за 6 месяцев · $accountName';
  }

  @override
  String get statistics_6MonthOverview => 'Обзор за 6 месяцев';

  @override
  String statistics_percentOfBudget(Object percent) {
    return '$percent% бюджета';
  }

  @override
  String get add_transaction_editTransaction => 'Редактировать транзакцию';

  @override
  String get add_transaction_addTransaction => 'Введите транзакцию';

  @override
  String get add_transaction_amount => 'Сумма';

  @override
  String add_transaction_conversionPreview(Object accountName, Object amount) {
    return '≈ $amount will be deducted from $accountName';
  }

  @override
  String get add_transaction_accountFallback => 'счет';

  @override
  String get add_transaction_descriptionOptional => 'Описание (необязательно)';

  @override
  String get add_transaction_noteOptional => 'Примечание (необязательно)';

  @override
  String get add_transaction_saveChanges => 'Сохранить изменения';

  @override
  String get more_statistics => 'Статистика';

  @override
  String get more_statisticsSub => 'Графики и ежемесячные сводки';

  @override
  String get more_insights => 'Аналитика';

  @override
  String get more_insightsSub =>
      'Тенденции, средние значения и анализ категорий';

  @override
  String get more_currencyConverter => 'Конвертер валют';

  @override
  String get more_currencyConverterSub =>
      'Конвертируйте между валютами мгновенно';

  @override
  String get more_wishlist => 'Список желаний';

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
  String get more_lentMoney => 'Деньги в долг';

  @override
  String more_lentMoneySub(Object count) {
    return '$count в выдаче';
  }

  @override
  String get more_assets => 'Активы';

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
  String get more_categories => 'Категории';

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
  String get more_exportTransactions => 'Экспортные операции';

  @override
  String get more_exportTransactionsSub => 'Сохранить как Excel (.xlsx)';

  @override
  String get more_backupRestore => 'Резервное копирование и восстановление';

  @override
  String get more_backupRestoreSub => 'Сохраните или загрузите данные';

  @override
  String get more_settings => 'Настройки';

  @override
  String get more_settingsSub => 'Тема, валюта и настройки';

  @override
  String home_greeting(Object name) {
    return 'Hi, $name 👋';
  }

  @override
  String get home_there => 'там';

  @override
  String get home_income => 'Доход';

  @override
  String get home_expenses => 'Расходы';

  @override
  String get home_net => 'Чистая';

  @override
  String get wishlist_noItems => 'Нет элементов в списке желаний';

  @override
  String get wishlist_noItemsSub =>
      'Нажмите +, чтобы добавить элементы, которые вы сохраняете';

  @override
  String get wishlist_editItem => 'Редактировать элемент';

  @override
  String get wishlist_addWishlistItem => 'Добавить элемент в список желаний';

  @override
  String get wishlist_itemName => 'Название предмета';

  @override
  String get wishlist_targetPrice => 'Целевая цена';

  @override
  String get wishlist_priorityLow => 'Низкий';

  @override
  String get wishlist_priorityMedium => 'Средний';

  @override
  String get wishlist_priorityHigh => 'Высокий';

  @override
  String get wishlist_notesOptional => 'Примечания (необязательно)';

  @override
  String get wishlist_saveChanges => 'Сохранить изменения';

  @override
  String get wishlist_addItem => 'Добавить элемент';

  @override
  String get lended_theyOweMe => 'Они мне должны';

  @override
  String get lended_iOweThem => 'Я им должен';

  @override
  String get lended_net => 'Чистая';

  @override
  String get lended_noOneYet => 'Еще никто';

  @override
  String get lended_noOneYetSub =>
      'Нажмите +, чтобы добавить человека, которому вы даете кредит или берете у него';

  @override
  String get lended_owesYou => 'Должен тебе';

  @override
  String get lended_youOwe => 'Вы обязаны';

  @override
  String get lended_settledUp => 'Урегулировано';

  @override
  String get lended_noActiveRecords => 'Нет активных записей';

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
  String get lended_editPerson => 'Редактировать человека';

  @override
  String get lended_addPerson => 'Добавить человека';

  @override
  String get lended_name => 'Имя';

  @override
  String get lended_notesOptional => 'Примечания (необязательно)';

  @override
  String get lended_saveChanges => 'Сохранить изменения';

  @override
  String get assets_totalAssets => 'Итого активы';

  @override
  String get assets_items => 'Предметы';

  @override
  String get assets_noAssetsYet => 'Активов пока нет';

  @override
  String get assets_noAssetsYetSub =>
      'Нажмите +, чтобы добавить продукт или актив.';

  @override
  String get assets_editAsset => 'Редактировать актив';

  @override
  String get assets_addAsset => 'Добавить актив';

  @override
  String get assets_productAssetName => 'Название продукта/актива';

  @override
  String get assets_value => 'Значение';

  @override
  String get assets_notesOptional => 'Примечания (необязательно)';

  @override
  String get assets_saveChanges => 'Сохранить изменения';

  @override
  String get currency_converter_loadingRates => 'Загрузка курсов валют…';

  @override
  String get currency_converter_ratesUnavailable =>
      'Курсы валют недоступны. Подключитесь к Интернету и синхронизируйте.';

  @override
  String get currency_converter_rateAgeJustNow => 'Только что';

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
    return '$daysд назад';
  }

  @override
  String currency_converter_commonConversions(Object fromCurrency) {
    return 'Распространенные конверсии из $fromCurrency';
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
      'Курсы валют не загружены — сумма будет переведена как есть';

  @override
  String get transfer_amount => 'Сумма';

  @override
  String get transfer_noteOptional => 'Примечание (необязательно)';

  @override
  String get export_from => 'Из';

  @override
  String get export_to => 'К';

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
  String get export_complete => 'Экспорт завершен';

  @override
  String get export_exporting => 'Экспорт...';

  @override
  String get export_exportAsExcel => 'Экспортировать в Excel';

  @override
  String shared_widgets_deleteConfirm(Object name) {
    return 'Удалить \\\"$name\\\"? Это невозможно отменить.';
  }

  @override
  String get shared_widgets_searchByCode => 'Поиск по коду или названию...';

  @override
  String get accounts_accounts => 'Счета';

  @override
  String get accounts_totalBalance => 'Общий баланс';

  @override
  String get accounts_excluded => 'Исключено';

  @override
  String get accounts_goldPriceNotYetLoade =>
      'Цена на золото еще не загружена. Подождите и попробуйте снова.';

  @override
  String get accounts_accountType => 'Тип счета';

  @override
  String get accounts_currency => 'Валюта';

  @override
  String get accounts_goldPurityKarat => 'Проба золота (Карат)';

  @override
  String get accounts_weight => 'Вес';

  @override
  String get accounts_excludeFromTotalBala => 'Исключить из общего баланса';

  @override
  String get accounts_color => 'Цвет';

  @override
  String get accounts_liveGoldValue => 'Текущая стоимость золота';

  @override
  String get accounts_enterWeightAboveToSe =>
      'Введите вес выше, чтобы увидеть стоимость';

  @override
  String get add_transaction_expense => 'Расход';

  @override
  String get add_transaction_income => 'Доход';

  @override
  String get add_transaction_account => 'Счет';

  @override
  String get add_transaction_category => 'Категория';

  @override
  String get assets_assets => 'Активы';

  @override
  String get backup_restoreBackup => 'Восстановить резервную копию?';

  @override
  String get backup_cancel => 'Отмена';

  @override
  String get backup_replaceData => 'Заменить данные';

  @override
  String get backup_backupRestore => 'Резервное копирование и восстановление';

  @override
  String get backup_everythingAlways => 'Всё, всегда';

  @override
  String get backup_createBackup => 'Создать резервную копию';

  @override
  String get backup_saveAsJson => 'Сохранить как JSON';

  @override
  String get backup_exportsAllAppDataToA =>
      'Экспортирует все данные приложения в переносимый файл';

  @override
  String get backup_restoreBackup_ => 'Восстановить резервную копию';

  @override
  String get backup_loadFromJson => 'Загрузить из JSON';

  @override
  String get backup_picksABackupFileAndR =>
      'Выбирает файл резервной копии и восстанавливает его';

  @override
  String get backup_thisOverwritesAllCur =>
      'Это перезапишет ВСЕ текущие данные.';

  @override
  String get budget_budgets => 'Бюджеты';

  @override
  String get budget_empty => '·';

  @override
  String get budget_overBudget => 'Превышен бюджет';

  @override
  String get budget_thisCategoryAlreadyH =>
      'В этой категории уже есть бюджет. Нажмите для редактирования.';

  @override
  String get budget_period => 'Период';

  @override
  String get budget_monthly => 'Ежемесячно';

  @override
  String get budget_weekly => 'Еженедельно';

  @override
  String get budget_category => 'Категория';

  @override
  String get categories_categories => 'Категории';

  @override
  String get categories_expense => 'Расход';

  @override
  String get categories_income => 'Доход';

  @override
  String get categories_color => 'Цвет';

  @override
  String get categories_icon => 'Иконка';

  @override
  String get categories_autoBasedOnName => 'Авто (на основе названия)';

  @override
  String get categories_expenseCategories => 'Категории расходов';

  @override
  String get categories_incomeCategories => 'Категории доходов';

  @override
  String get currency_converter_currencyConverter => 'Конвертер валют';

  @override
  String get currency_converter_amount => 'Сумма';

  @override
  String get currency_converter_convertedTo => 'Конвертировано в';

  @override
  String get export_exportTransactions => 'Экспорт транзакций';

  @override
  String get export_dateRange => 'Диапазон дат';

  @override
  String get export_formatExcelXlsx => 'Формат: Excel (.xlsx)';

  @override
  String get home_totalBalance => 'Общий баланс';

  @override
  String get home_accounts => 'Счета';

  @override
  String get home_recentTransactions => 'Последние транзакции';

  @override
  String get home_noTransactionsYet => 'Транзакций пока нет';

  @override
  String get home_add => 'Добавить';

  @override
  String get insights_insights => 'Аналитика';

  @override
  String get lended_person_deletePerson => 'Удалить человека';

  @override
  String get lended_person_editPerson => 'Редактировать человека';

  @override
  String get lended_person_color => 'Цвет';

  @override
  String get lended_person_saveChanges => 'Сохранить изменения';

  @override
  String get lended_person_settled => 'УРЕГУЛИРОВАНО';

  @override
  String get lended_person_settle => 'Урегулировать';

  @override
  String get lended_person_setADueDateFirstToEn =>
      'Сначала установите дату погашения для включения напоминаний.';

  @override
  String get lended_person_iLent => 'Я одолжил';

  @override
  String get lended_person_iBorrowed => 'Я занял';

  @override
  String get lended_person_accountOptional => 'Счет (необязательно)';

  @override
  String get lended_person_dueDateReminder => 'Напоминание о сроке';

  @override
  String get lended_person_remindMeAt => 'Напомнить в';

  @override
  String get lended_person_active => 'Активен';

  @override
  String get lended_person_settled_ => 'Урегулировано';

  @override
  String get lended_lentMoney => 'Одолженные деньги';

  @override
  String get lended_overdue => 'ПРОСРОЧЕНО';

  @override
  String get lended_color => 'Цвет';

  @override
  String get more_more => 'Ещё';

  @override
  String get onboarding_back => 'Назад';

  @override
  String get onboarding_welcomeToExpensy => 'Добро пожаловать в Expensy!';

  @override
  String get onboarding_restoreABackup => 'Восстановить резервную копию';

  @override
  String get onboarding_loadAPreviouslySaved =>
      'Загрузить ранее сохраненный JSON файл Expensy';

  @override
  String get onboarding_or => 'или';

  @override
  String get onboarding_startFresh => 'Начать заново';

  @override
  String get onboarding_firstWhatShouldWeCal =>
      'Сначала скажите, как к вам обращаться?';

  @override
  String get onboarding_defaultCurrency => 'Валюта по умолчанию';

  @override
  String get onboarding_thisWillBeUsedAcross =>
      'Это будет использоваться во всем приложении.\nВы сможете изменить это позже в настройках.';

  @override
  String get onboarding_searchAllCurrencies => 'Поиск всех валют';

  @override
  String get onboarding_yourFirstAccount => 'Ваш первый счет';

  @override
  String get onboarding_setUpYourMainAccount =>
      'Настройте ваш основной счет для начала отслеживания.';

  @override
  String get onboarding_accountType => 'Тип счета';

  @override
  String get onboarding_currency => 'Валюта';

  @override
  String get onboarding_color => 'Цвет';

  @override
  String get recurring_recurring => 'Регулярно';

  @override
  String get recurring_income => 'ДОХОД';

  @override
  String get recurring_2D => '−2д';

  @override
  String get recurring_skipNextPayment => 'Пропустить следующий платеж?';

  @override
  String get recurring_cancel => 'Отмена';

  @override
  String get recurring_skip => 'Пропустить';

  @override
  String get recurring_noHistoryYet => 'Истории пока нет';

  @override
  String get recurring_expense => 'Расход';

  @override
  String get recurring_income_ => 'Доход';

  @override
  String get recurring_every => 'Каждые ';

  @override
  String get recurring_days => 'Дни';

  @override
  String get recurring_weeks => 'Недели';

  @override
  String get recurring_months => 'Месяцы';

  @override
  String get recurring_years => 'Годы';

  @override
  String get recurring_payments => 'Платежи';

  @override
  String get recurring_totalCost => 'Общая стоимость';

  @override
  String get recurring_account => 'Счет';

  @override
  String get recurring_category => 'Категория';

  @override
  String get recurring_paymentReminder => 'Напоминание о платеже';

  @override
  String get recurring_notificationWillFire =>
      'Уведомление сработает в следующую дату погашения в это время.';

  @override
  String get recurring_remind2DaysBefore => 'Напомнить за 2 дня';

  @override
  String get statistics_statistics => 'Статистика';

  @override
  String get statistics_expensesByCategory => 'Расходы по категориям';

  @override
  String get transactions_transactions => 'Транзакции';

  @override
  String get transactions_settled => 'Урегулировано';

  @override
  String get transfer_transfer => 'Перевод';

  @override
  String get transfer_from => 'ОТКУДА';

  @override
  String get transfer_to => 'КУДА';

  @override
  String get transfer_enterAnAmountToSeeTh =>
      'Введите сумму, чтобы увидеть конвертацию';

  @override
  String get wishlist_wishlist => 'Список желаний';

  @override
  String get wishlist_priority => 'Приоритет';

  @override
  String get shared_widgets_delete => 'Удалить?';

  @override
  String get shared_widgets_cancel => 'Отмена';

  @override
  String get shared_widgets_delete_ => 'Удалить';

  @override
  String get shared_widgets_none => 'Нет';

  @override
  String get shared_widgets_selectCurrency => 'Выбрать валюту';

  @override
  String get main_home => 'Главная';

  @override
  String get main_transactions => 'Транзакции';

  @override
  String get main_recurring => 'Повторяющийся';

  @override
  String get main_accounts => 'Счета';

  @override
  String get main_budgets => 'Бюджеты';

  @override
  String get main_more => 'Подробнее';

  @override
  String get onboarding_chooseLanguage => 'Выберите язык';

  @override
  String get error_required => 'Это поле обязательно для заполнения';

  @override
  String recurring_subscriptions(Object count) {
    return 'Подписки ($count)';
  }

  @override
  String recurring_installments(Object count) {
    return 'Рассрочка ($count)';
  }

  @override
  String get recurring_recurringType => 'Повторяющийся тип';

  @override
  String get recurring_subscription => 'Подписка';

  @override
  String get recurring_installment => 'Рассрочка';

  @override
  String get recurring_installmentsRequireEndDate =>
      'Рассрочка должна иметь окончательную дату платежа.';

  @override
  String get backup_importFromOtherApps => 'Импорт из других приложений';

  @override
  String get backup_importDescription =>
      'Импортируйте данные из поддерживаемых приложений';

  @override
  String get backup_importFromGreenStash => 'Импорт из GreenStash (.json)';

  @override
  String get backup_automaticBackup => 'Автоматическое резервное копирование';

  @override
  String get backup_dailyAutoBackup =>
      'Ежедневное автоматическое резервное копирование';

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
  String get backup_changeTime => 'Изменить время';

  @override
  String get backup_changeFolder => 'Изменить папку';

  @override
  String get budget_budgetsAndGoals => 'Бюджеты и цели';

  @override
  String get onboarding_restoreGreenStash =>
      'Восстановление из GreenStash (.json)';

  @override
  String get savings_goalNotFound => 'Цель не найдена';

  @override
  String get savings_savedSoFar => 'Пока сохранено';

  @override
  String get savings_target => 'Цель';

  @override
  String savings_targetDate(String date) {
    return 'Target Date: $date';
  }

  @override
  String get savings_contribute => 'Внести свой вклад';

  @override
  String get savings_withdraw => 'Вывести';

  @override
  String get savings_noAccounts =>
      'Нет доступных аккаунтов. Пожалуйста, сначала добавьте учетную запись.';

  @override
  String get settings_budgetAlerts => 'Оповещения о бюджете';

  @override
  String get settings_budgetAlertsSub =>
      'Уведомлять о достижении бюджета или цели';

  @override
  String get settings_dailyReminder => 'Ежедневное напоминание';

  @override
  String get settings_dailyReminderSub =>
      'Напоминайте о ежедневной регистрации транзакций';

  @override
  String get settings_reminderTime => 'Время напоминания';

  @override
  String get settings_hapticFeedback => 'Тактильная обратная связь';

  @override
  String get settings_hapticFeedbackSub => 'Вибрация при взаимодействии';

  @override
  String get savings_saveGoal => 'Сохранить цель';
}
