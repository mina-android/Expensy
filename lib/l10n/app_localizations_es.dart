// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Caro';

  @override
  String get settings_title => 'Ajustes';

  @override
  String get settings_appearance => 'Apariencia';

  @override
  String get settings_theme => 'Tema';

  @override
  String get settings_system => 'Sistema';

  @override
  String get settings_light => 'Luz';

  @override
  String get settings_dark => 'Oscuro';

  @override
  String get settings_amoledTitle => 'Negro puro (AMOLED)';

  @override
  String get settings_amoledSubtitle => 'Fuerza fondos negros en modo oscuro';

  @override
  String get settings_systemDefault => 'Valor predeterminado del sistema';

  @override
  String get settings_dynamicColor => 'Color dinámico';

  @override
  String get settings_dynamicColorSubtitle =>
      'Usar colores de fondo de pantalla del sistema';

  @override
  String get settings_accentColor => 'Color de acento';

  @override
  String get settings_accentColorSubtitle =>
      'Elige un color de semilla para la aplicación';

  @override
  String get settings_appFont => 'Fuente de la aplicación';

  @override
  String get settings_currency => 'Divisa';

  @override
  String get settings_defaultCurrency => 'Moneda predeterminada';

  @override
  String get settings_preferences => 'Preferencias';

  @override
  String get settings_weekStartsOn => 'La semana comienza';

  @override
  String get settings_monday => 'Lunes';

  @override
  String get settings_sunday => 'Domingo';

  @override
  String get settings_hideBalance => 'Ocultar saldo';

  @override
  String get settings_hideBalanceSubtitle =>
      'Mostrar ••••• en lugar de cantidades';

  @override
  String get settings_language => 'Idioma';

  @override
  String get settings_profile => 'Perfil';

  @override
  String get settings_displayName => 'Nombre para mostrar';

  @override
  String get settings_notSet => 'No establecido';

  @override
  String get settings_about => 'Acerca de';

  @override
  String get settings_version => 'Versión';

  @override
  String get settings_privacy => 'Privacidad';

  @override
  String get settings_privacySubtitle =>
      'Todos los datos almacenados localmente: 100% sin conexión';

  @override
  String get settings_github => 'GitHub';

  @override
  String get settings_githubSubtitle => 'Ver código fuente';

  @override
  String get settings_developer => 'Revelador';

  @override
  String get settings_developerSubtitle =>
      'Descubre más proyectos de Mina Android';

  @override
  String get settings_githubProfile => 'Perfil de GitHub';

  @override
  String get settings_developerWebsite => 'Sitio web del desarrollador';

  @override
  String get settings_close => 'Cerca';

  @override
  String get settings_yourName => 'Su nombre';

  @override
  String get settings_cancel => 'Cancelar';

  @override
  String get settings_save => 'Ahorrar';

  @override
  String recurring_expenses(Object count) {
    return 'Gastos ($count)';
  }

  @override
  String recurring_incomeList(Object count) {
    return 'Ingresos ($count)';
  }

  @override
  String get recurring_monthly => 'Mensual';

  @override
  String get recurring_weekly => 'Semanalmente';

  @override
  String get recurring_noRecurringExpenses => 'Sin gastos recurrentes';

  @override
  String get recurring_noRecurringIncome => 'Sin ingresos recurrentes';

  @override
  String get recurring_addExpense => 'Agregar gastos';

  @override
  String get recurring_addIncome => 'Agregar ingresos';

  @override
  String get recurring_tapPlusToAddOne => 'Toca + para agregar uno';

  @override
  String recurring_fromOngoing(Object date) {
    return 'Desde$date· En curso';
  }

  @override
  String recurring_paidPayments(Object paid, Object total) {
    return '$paid/${total}pagado';
  }

  @override
  String recurring_totalAmount(Object amount) {
    return 'Total:$amount';
  }

  @override
  String get recurring_overdue => '¡Atrasado!';

  @override
  String get recurring_dueToday => 'Vencimiento hoy';

  @override
  String recurring_dueInDays(Object days) {
    return 'Vencimiento en${days}d';
  }

  @override
  String get recurring_edit => 'Editar';

  @override
  String get recurring_skipBtn => 'Saltar';

  @override
  String recurring_nextDate(Object date) {
    return 'Siguiente:$date';
  }

  @override
  String get recurring_pay => 'Pagar';

  @override
  String get recurring_del => 'Del';

  @override
  String recurring_historyCount(Object count) {
    return 'Historial ($count)';
  }

  @override
  String get recurring_paymentHistory => 'Historial de pagos';

  @override
  String get recurring_notificationPermissionDenied =>
      'Permiso de notificación denegado. Habilítelo en Configuración → Aplicaciones → Expensy → Notificaciones.';

  @override
  String get recurring_remindMeAt => 'Recuérdamelo a';

  @override
  String get recurring_editRecurring => 'Editar recurrente';

  @override
  String get recurring_addRecurring => 'Agregar un pago recurrente';

  @override
  String get recurring_name => 'Nombre';

  @override
  String get recurring_amountPerPayment => 'Monto por pago';

  @override
  String recurring_firstDate(Object date) {
    return 'Primero:$date';
  }

  @override
  String recurring_lastDate(Object date) {
    return 'Último:$date';
  }

  @override
  String get recurring_noLastPaymentOngoing => 'Sin último pago (en curso)';

  @override
  String get accounts_refreshExchangeRates => 'Actualizar tipos de cambio';

  @override
  String get accounts_noAccounts => 'Sin cuentas';

  @override
  String get accounts_tapPlusToAddYourFirst =>
      'Toca + para agregar tu primera cuenta';

  @override
  String get accounts_fetchingExchangeRates => 'Obteniendo tipos de cambio...';

  @override
  String get accounts_exchangeRatesUnavailable =>
      'Tipos de cambio no disponibles (fuera de línea). Saldos mostrados en moneda nativa.';

  @override
  String get accounts_unknown => 'Desconocido';

  @override
  String accounts_ratesUpdated(Object timeStr) {
    return 'Tarifas actualizadas$timeStr· Toque ↺ para actualizar';
  }

  @override
  String get accounts_goldCaps => 'ORO';

  @override
  String get accounts_balance => 'Saldo';

  @override
  String get accounts_income => 'Ingreso';

  @override
  String get accounts_expense => 'Gastos';

  @override
  String get accounts_txs => 'txs';

  @override
  String get accounts_value => 'Valor';

  @override
  String get accounts_karat => 'Quilate';

  @override
  String accounts_pure(Object percentage) {
    return '$percentage% puro';
  }

  @override
  String get accounts_weightLabel => 'Peso';

  @override
  String get accounts_perGram => 'Por gramo';

  @override
  String get accounts_bank => 'Banco';

  @override
  String get accounts_cash => 'Dinero';

  @override
  String get accounts_savings => 'Ahorros';

  @override
  String get accounts_creditCard => 'Tarjeta de crédito';

  @override
  String get accounts_eWallet => 'Monedero electrónico';

  @override
  String get accounts_gold => 'Oro';

  @override
  String get accounts_editAccount => 'Editar cuenta';

  @override
  String get accounts_addAccount => 'Agregar nueva cuenta';

  @override
  String get accounts_accountName => 'Nombre de cuenta';

  @override
  String get accounts_weightInGrams => 'Peso en gramos';

  @override
  String get accounts_initialBalance => 'Saldo inicial';

  @override
  String get accounts_wontCountTowardYourHome =>
      'No contará para el total de tu pantalla de inicio';

  @override
  String get accounts_saveChanges => 'Guardar cambios';

  @override
  String get accounts_addAccountBtn => 'Agregar cuenta';

  @override
  String get accounts_fetchingGoldPrice => 'Obteniendo el precio del oro...';

  @override
  String get accounts_goldPriceUnavailable =>
      'Precio del oro no disponible: comprueba tu conexión';

  @override
  String lended_person_owesYou(Object name) {
    return '${name}te debe';
  }

  @override
  String lended_person_youOwe(Object name) {
    return 'Le debes$name';
  }

  @override
  String get lended_person_allSettledUp => 'Todo arreglado';

  @override
  String get lended_person_noRecordsYet => 'Aún no hay registros';

  @override
  String get lended_person_tapPlusToLog =>
      'Toca + para registrar dinero prestado o prestado';

  @override
  String get lended_person_name => 'Nombre';

  @override
  String get lended_person_notesOptional => 'Notas (opcional)';

  @override
  String get lended_person_lent => 'Cuaresma';

  @override
  String get lended_person_borrowed => 'Prestado';

  @override
  String get lended_person_overdue => '¡Atrasado!';

  @override
  String lended_person_due(Object date) {
    return 'Vencimiento$date';
  }

  @override
  String lended_person_reminderAt(Object time) {
    return 'Recordatorio en$time';
  }

  @override
  String get lended_person_notificationPermissionDenied =>
      'Permiso de notificación denegado. Habilítelo en Configuración → Aplicaciones → Expensy → Notificaciones.';

  @override
  String get lended_person_remindMeAtPrompt => 'Recuérdamelo a';

  @override
  String get lended_person_editRecord => 'Editar registro';

  @override
  String get lended_person_addRecord => 'Agregar registro';

  @override
  String get lended_person_amount => 'Cantidad';

  @override
  String lended_person_dueColon(Object date) {
    return 'Vencimiento:$date';
  }

  @override
  String get lended_person_noDueDate => 'Sin fecha de vencimiento';

  @override
  String get lended_person_setDueFirst =>
      'Primero establezca una fecha de vencimiento';

  @override
  String get lended_person_notifiedOnDue =>
      'Se le notificará la fecha de vencimiento';

  @override
  String get lended_person_getNotifiedWhenDue =>
      'Recibir una notificación cuando esto venza';

  @override
  String get lended_person_thatTimePassed =>
      'Esa hora de hoy ya pasó; en su lugar, se te notificará en breve.';

  @override
  String lended_person_notificationFiresOn(Object date, Object time) {
    return 'La notificación se activa en${date}a las$time.';
  }

  @override
  String get lended_person_saveChangesBtn => 'Guardar cambios';

  @override
  String get lended_person_addRecordBtn => 'Agregar registro';

  @override
  String get transactions_searchTransactions => 'Buscar transacciones...';

  @override
  String get transactions_all => 'Todo';

  @override
  String get transactions_income => 'Ingreso';

  @override
  String get transactions_expenses => 'Gastos';

  @override
  String get transactions_lent => 'Cuaresma';

  @override
  String get transactions_borrowed => 'Prestado';

  @override
  String get transactions_noTransactions => 'Sin transacciones';

  @override
  String get transactions_tapPlusToAddOne => 'Toca + para agregar uno';

  @override
  String get transactions_today => 'Hoy';

  @override
  String get transactions_yesterday => 'Ayer';

  @override
  String transactions_lentTo(Object name) {
    return 'Prestado a$name';
  }

  @override
  String transactions_borrowedFrom(Object name) {
    return 'Tomado prestado de$name';
  }

  @override
  String get transactions_unknown => 'Desconocido';

  @override
  String transactions_due(Object date) {
    return 'Vencimiento$date';
  }

  @override
  String get transactions_unsettled => 'Inestable';

  @override
  String get onboarding_restoreFailed =>
      'Error de restauración: el archivo puede estar dañado o no ser una copia de seguridad de Expensy.';

  @override
  String get onboarding_continue => 'Continuar';

  @override
  String get onboarding_getStarted => 'Empezar';

  @override
  String get onboarding_yourPersonalTracker =>
      'Su rastreador de finanzas personal, 100% fuera de línea.\n¿Ya tienes una copia de seguridad de otro dispositivo o una instalación anterior?';

  @override
  String get onboarding_restoring => 'Restaurando...';

  @override
  String get onboarding_chooseBackupFile =>
      'Elija el archivo de copia de seguridad';

  @override
  String get onboarding_letsGetYouSetUp => 'Vamos a configurarlo';

  @override
  String get onboarding_yourName => 'Su nombre';

  @override
  String get onboarding_accountName => 'Nombre de cuenta';

  @override
  String get onboarding_bank => 'Banco';

  @override
  String get onboarding_cash => 'Dinero';

  @override
  String get onboarding_savings => 'Ahorros';

  @override
  String get onboarding_credit => 'Crédito';

  @override
  String get onboarding_wallet => 'Billetera';

  @override
  String get onboarding_startingBalance => 'Saldo inicial';

  @override
  String get backup_replaceDataWarning =>
      'Esto reemplazará TODOS sus datos actuales con la copia de seguridad.\nEsto no se puede deshacer.';

  @override
  String get backup_whatsIncluded => '¿Qué está incluido?';

  @override
  String get backup_backupDescription =>
      'Cada copia de seguridad incluye todos sus datos: cuentas, transacciones, pagos recurrentes y su historial de pagos/saltos, presupuestos, elementos de la lista de deseos, personas y registros prestados y prestados, activos, categorías y configuraciones de aplicaciones.';

  @override
  String get backup_saving => 'Ahorro...';

  @override
  String get backup_saveBackup => 'Guardar copia de seguridad';

  @override
  String get backup_restoring => 'Restaurando...';

  @override
  String get backup_restoreBackupBtn => 'Restaurar copia de seguridad';

  @override
  String get backup_restoreWarningText =>
      'Compatible con copias de seguridad desde cualquier versión de la aplicación. Los campos que faltan se completan con valores predeterminados seguros.';

  @override
  String get backup_included => 'incluido';

  @override
  String get backup_accounts => 'Cuentas';

  @override
  String get backup_transactions => 'Actas';

  @override
  String get backup_recurringPayments => 'Pagos recurrentes';

  @override
  String get backup_recurringHistory => 'Historia recurrente';

  @override
  String get backup_budgets => 'Presupuestos';

  @override
  String get backup_wishlist => 'Lista de deseos';

  @override
  String get backup_lentPeople => 'Cuaresma/Préstamo — Personas';

  @override
  String get backup_lentRecords => 'Prestado/prestado - Registros';

  @override
  String get backup_assets => 'Activos';

  @override
  String get backup_categories => 'Categorías';

  @override
  String get backup_settings => 'Ajustes';

  @override
  String backup_backupSavedSuccessfully(Object savedPath) {
    return 'Copia de seguridad guardada exitosamente:\n$savedPath';
  }

  @override
  String backup_backupFailed(Object error) {
    return 'Error de copia de seguridad:$error';
  }

  @override
  String backup_upgradedFrom(Object originalVersion, Object schemaVersion) {
    return '(actualizado desde v$originalVersion→ v$schemaVersion)';
  }

  @override
  String backup_dataRestoredSuccessfully(Object vLabel) {
    return '¡Datos restaurados exitosamente!$vLabel';
  }

  @override
  String backup_restoreFailed(Object error) {
    return 'Error de restauración:$error';
  }

  @override
  String get backup_restoreFailedCorrupted =>
      'Error de restauración: el archivo puede estar dañado o no ser una copia de seguridad de Expensy.';

  @override
  String get budget_noBudgetsYet => 'Aún no hay presupuestos';

  @override
  String get budget_tapToAddBudget =>
      'Toque + para establecer un límite de gasto por categoría';

  @override
  String get budget_budgeted => 'Presupuestado';

  @override
  String get budget_leftToSpend => 'Left to Spend';

  @override
  String get budget_spent => 'Gastado';

  @override
  String get budget_overLimit => 'por encima del límite';

  @override
  String get budget_unknown => 'Desconocido';

  @override
  String get budget_weeklyLabel => 'Semanalmente';

  @override
  String get budget_monthlyLabel => 'Mensual';

  @override
  String budget_overAmount(Object amount) {
    return '${amount}terminado';
  }

  @override
  String budget_leftAmount(Object amount) {
    return '${amount}izquierda';
  }

  @override
  String budget_percentUsed(Object percent) {
    return '$percent% utilizado';
  }

  @override
  String get budget_editBudget => 'Editar presupuesto';

  @override
  String get budget_setBudget => 'Agregar nuevo presupuesto';

  @override
  String get budget_budgetAmount => 'Monto del presupuesto';

  @override
  String budget_previewFor(Object catName) {
    return 'Vista previa de \"$catName\"';
  }

  @override
  String budget_spentAmount(Object amount) {
    return 'Gastado:$amount';
  }

  @override
  String budget_ofAmount(Object amount) {
    return 'de$amount';
  }

  @override
  String get budget_saveChanges => 'Guardar cambios';

  @override
  String get budget_budget => 'Presupuesto';

  @override
  String get insights_other => 'Otro';

  @override
  String get insights_noDataYet => 'Aún no hay datos';

  @override
  String get insights_addSomeTransactions =>
      'Agregue algunas transacciones para ver información valiosa';

  @override
  String get insights_thisMonthVsLastMonth => 'Este mes versus el mes pasado';

  @override
  String get insights_dailyAverage => 'Promedio diario';

  @override
  String insights_perDayBasedOn(Object days) {
    return 'por día · basado en${days}días este mes';
  }

  @override
  String get insights_incomeVsExpenses => 'Ingresos vs Gastos';

  @override
  String insights_incomeAmount(Object amount) {
    return 'Ingresos$amount';
  }

  @override
  String insights_expensesAmount(Object amount) {
    return 'Gastos$amount';
  }

  @override
  String insights_percentSaved(Object percent) {
    return '$percent% ahorrado este mes';
  }

  @override
  String get insights_topSpendingCategories =>
      'Principales categorías de gasto';

  @override
  String insights_percentOfTotal(Object percent) {
    return '$percent% del total';
  }

  @override
  String get insights_biggestExpenseThisMonth => 'Mayor gasto este mes';

  @override
  String get insights_categoryTrends =>
      'Tendencias de categorías (frente al mes pasado)';

  @override
  String get insights_12MonthTrend => 'Tendencia de 12 meses';

  @override
  String get insights_incomeLabel => 'Ingreso';

  @override
  String get insights_expensesLabel => 'Gastos';

  @override
  String get categories_expenseLabel => 'Gastos';

  @override
  String get categories_incomeLabel => 'Ingreso';

  @override
  String get categories_editCategory => 'Editar categoría';

  @override
  String get categories_addCategory => 'Agregar categoría';

  @override
  String get categories_categoryName => 'Nombre de categoría';

  @override
  String get categories_saveChanges => 'Guardar cambios';

  @override
  String get statistics_other => 'Otro';

  @override
  String get statistics_allAccounts => 'Todas las cuentas';

  @override
  String get statistics_income => 'Ingreso';

  @override
  String get statistics_expenses => 'Gastos';

  @override
  String get statistics_expense => 'Gastos';

  @override
  String get statistics_net => 'Neto';

  @override
  String statistics_6MonthOverviewAccount(Object accountName) {
    return 'Resumen de 6 meses ·$accountName';
  }

  @override
  String get statistics_6MonthOverview => 'Resumen de 6 meses';

  @override
  String statistics_percentOfBudget(Object percent) {
    return '$percent% del presupuesto';
  }

  @override
  String get add_transaction_editTransaction => 'Editar transacción';

  @override
  String get add_transaction_addTransaction => 'Ingresar transacción';

  @override
  String get add_transaction_amount => 'Cantidad';

  @override
  String add_transaction_conversionPreview(Object accountName, Object amount) {
    return '≈${amount}se deducirá de$accountName';
  }

  @override
  String get add_transaction_accountFallback => 'cuenta';

  @override
  String get add_transaction_descriptionOptional => 'Descripción (opcional)';

  @override
  String get add_transaction_noteOptional => 'Nota (opcional)';

  @override
  String get add_transaction_saveChanges => 'Guardar cambios';

  @override
  String get more_statistics => 'Estadística';

  @override
  String get more_statisticsSub => 'Gráficos y resumen mensual';

  @override
  String get more_insights => 'Perspectivas';

  @override
  String get more_insightsSub =>
      'Tendencias, promedios y análisis de categorías';

  @override
  String get more_currencyConverter => 'Convertidor de moneda';

  @override
  String get more_currencyConverterSub => 'Convierta entre monedas al instante';

  @override
  String get more_wishlist => 'Lista de deseos';

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
  String get more_lentMoney => 'Dinero prestado';

  @override
  String more_lentMoneySub(Object count) {
    return '${count}pendiente';
  }

  @override
  String get more_assets => 'Activos';

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
  String get more_categories => 'Categorías';

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
  String get more_exportTransactions => 'Transacciones de exportación';

  @override
  String get more_exportTransactionsSub => 'Guardar como Excel (.xlsx)';

  @override
  String get more_backupRestore => 'Copia de seguridad y restauración';

  @override
  String get more_backupRestoreSub => 'Guarda o carga tus datos';

  @override
  String get more_settings => 'Ajustes';

  @override
  String get more_settingsSub => 'Tema, moneda y preferencias';

  @override
  String home_greeting(Object name) {
    return 'Hola,$name👋';
  }

  @override
  String get home_there => 'allá';

  @override
  String get home_income => 'Ingreso';

  @override
  String get home_expenses => 'Gastos';

  @override
  String get home_net => 'Neto';

  @override
  String get wishlist_noItems => 'No hay artículos en la lista de deseos';

  @override
  String get wishlist_noItemsSub =>
      'Toca + para agregar elementos para los que estás guardando';

  @override
  String get wishlist_editItem => 'Editar artículo';

  @override
  String get wishlist_addWishlistItem =>
      'Agregar artículo a la lista de deseos';

  @override
  String get wishlist_itemName => 'Nombre del artículo';

  @override
  String get wishlist_targetPrice => 'Precio objetivo';

  @override
  String get wishlist_priorityLow => 'Bajo';

  @override
  String get wishlist_priorityMedium => 'Medio';

  @override
  String get wishlist_priorityHigh => 'Alto';

  @override
  String get wishlist_notesOptional => 'Notas (opcional)';

  @override
  String get wishlist_saveChanges => 'Guardar cambios';

  @override
  String get wishlist_addItem => 'Agregar artículo';

  @override
  String get lended_theyOweMe => 'Me deben';

  @override
  String get lended_iOweThem => 'les debo';

  @override
  String get lended_net => 'Neto';

  @override
  String get lended_noOneYet => 'nadie todavía';

  @override
  String get lended_noOneYetSub =>
      'Toca + para agregar a una persona a la que le prestas o a la que le prestas dinero';

  @override
  String get lended_owesYou => 'te debe';

  @override
  String get lended_youOwe => 'tu debes';

  @override
  String get lended_settledUp => 'resuelto';

  @override
  String get lended_noActiveRecords => 'No hay registros activos';

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
  String get lended_editPerson => 'Editar persona';

  @override
  String get lended_addPerson => 'Agregar persona';

  @override
  String get lended_name => 'Nombre';

  @override
  String get lended_notesOptional => 'Notas (opcional)';

  @override
  String get lended_saveChanges => 'Guardar cambios';

  @override
  String get assets_totalAssets => 'Activos totales';

  @override
  String get assets_items => 'Elementos';

  @override
  String get assets_noAssetsYet => 'Aún no hay activos';

  @override
  String get assets_noAssetsYetSub =>
      'Toca + para agregar un producto o activo';

  @override
  String get assets_editAsset => 'Editar activo';

  @override
  String get assets_addAsset => 'Agregar activo';

  @override
  String get assets_productAssetName => 'Nombre del producto/activo';

  @override
  String get assets_value => 'Valor';

  @override
  String get assets_notesOptional => 'Notas (opcional)';

  @override
  String get assets_saveChanges => 'Guardar cambios';

  @override
  String get currency_converter_loadingRates => 'Cargando tipos de cambio…';

  @override
  String get currency_converter_ratesUnavailable =>
      'Tipos de cambio no disponibles. Conéctese a Internet y sincronice.';

  @override
  String get currency_converter_rateAgeJustNow => 'En este momento';

  @override
  String currency_converter_rateAgeMins(Object minutes) {
    return 'Hace${minutes}m';
  }

  @override
  String currency_converter_rateAgeHours(Object hours) {
    return 'Hace${hours}h';
  }

  @override
  String currency_converter_rateAgeDays(Object days) {
    return 'Hace${days}d';
  }

  @override
  String currency_converter_commonConversions(Object fromCurrency) {
    return 'Conversiones comunes de$fromCurrency';
  }

  @override
  String transfer_fromAcc(Object currency) {
    return 'De ($currency)';
  }

  @override
  String transfer_toAcc(Object currency) {
    return 'Para ($currency)';
  }

  @override
  String get transfer_exchangeRatesNotLoaded =>
      'Tipos de cambio no cargados: el monto se transferirá tal como está';

  @override
  String get transfer_amount => 'Cantidad';

  @override
  String get transfer_noteOptional => 'Nota (opcional)';

  @override
  String get export_from => 'De';

  @override
  String get export_to => 'A';

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
    return 'Guardado:$path';
  }

  @override
  String get export_complete => 'Exportación completa';

  @override
  String get export_exporting => 'Exportador...';

  @override
  String get export_exportAsExcel => 'Exportar como Excel';

  @override
  String shared_widgets_deleteConfirm(Object name) {
    return '¿Eliminar \"$name\"? Esto no se puede deshacer.';
  }

  @override
  String get shared_widgets_searchByCode => 'Buscar por código o nombre...';

  @override
  String get accounts_accounts => 'Cuentas';

  @override
  String get accounts_totalBalance => 'Saldo total';

  @override
  String get accounts_excluded => 'excluido';

  @override
  String get accounts_goldPriceNotYetLoade =>
      'El precio del oro aún no se ha cargado. Espere un momento y vuelva a intentarlo.';

  @override
  String get accounts_accountType => 'Tipo de cuenta';

  @override
  String get accounts_currency => 'Divisa';

  @override
  String get accounts_goldPurityKarat => 'Pureza del oro (quilates)';

  @override
  String get accounts_weight => 'Peso';

  @override
  String get accounts_excludeFromTotalBala => 'Excluir del saldo total';

  @override
  String get accounts_color => 'Color';

  @override
  String get accounts_liveGoldValue => 'Valor del oro vivo';

  @override
  String get accounts_enterWeightAboveToSe =>
      'Ingrese el peso arriba para ver el valor';

  @override
  String get add_transaction_expense => 'Gastos';

  @override
  String get add_transaction_income => 'Ingreso';

  @override
  String get add_transaction_account => 'Cuenta';

  @override
  String get add_transaction_category => 'Categoría';

  @override
  String get assets_assets => 'Activos';

  @override
  String get backup_restoreBackup => '¿Restaurar copia de seguridad?';

  @override
  String get backup_cancel => 'Cancelar';

  @override
  String get backup_replaceData => 'Reemplazar datos';

  @override
  String get backup_backupRestore => 'Copia de seguridad y restauración';

  @override
  String get backup_everythingAlways => 'todo, siempre';

  @override
  String get backup_createBackup => 'Crear copia de seguridad';

  @override
  String get backup_saveAsJson => 'Guardar como JSON';

  @override
  String get backup_exportsAllAppDataToA =>
      'Exporta TODOS los datos de la aplicación a un archivo portátil';

  @override
  String get backup_restoreBackup_ => 'Restaurar copia de seguridad';

  @override
  String get backup_loadFromJson => 'Cargar desde JSON';

  @override
  String get backup_picksABackupFileAndR =>
      'Elige un archivo de respaldo y lo restaura';

  @override
  String get backup_thisOverwritesAllCur =>
      'Esto sobrescribe TODOS los datos actuales.';

  @override
  String get budget_budgets => 'Presupuestos';

  @override
  String get budget_empty => '·';

  @override
  String get budget_overBudget => 'Por encima del presupuesto';

  @override
  String get budget_thisCategoryAlreadyH =>
      'Esta categoría ya tiene presupuesto. Tócalo para editar.';

  @override
  String get budget_period => 'Período';

  @override
  String get budget_monthly => 'Mensual';

  @override
  String get budget_weekly => 'Semanalmente';

  @override
  String get budget_category => 'Categoría';

  @override
  String get categories_categories => 'Categorías';

  @override
  String get categories_expense => 'Gastos';

  @override
  String get categories_income => 'Ingreso';

  @override
  String get categories_color => 'Color';

  @override
  String get categories_icon => 'Icono';

  @override
  String get categories_autoBasedOnName => 'Auto (basado en el nombre)';

  @override
  String get categories_expenseCategories => 'Categorías de gastos';

  @override
  String get categories_incomeCategories => 'Categorías de ingresos';

  @override
  String get currency_converter_currencyConverter => 'Convertidor de moneda';

  @override
  String get currency_converter_amount => 'Cantidad';

  @override
  String get currency_converter_convertedTo => 'Convertido a';

  @override
  String get export_exportTransactions => 'Transacciones de exportación';

  @override
  String get export_dateRange => 'Rango de fechas';

  @override
  String get export_formatExcelXlsx => 'Formato: Excel (.xlsx)';

  @override
  String get home_totalBalance => 'Saldo total';

  @override
  String get home_accounts => 'Cuentas';

  @override
  String get home_recentTransactions => 'Transacciones recientes';

  @override
  String get home_noTransactionsYet => 'Aún no hay transacciones';

  @override
  String get home_add => 'Agregar';

  @override
  String get insights_insights => 'Perspectivas';

  @override
  String get lended_person_deletePerson => 'Eliminar persona';

  @override
  String get lended_person_editPerson => 'Editar persona';

  @override
  String get lended_person_color => 'Color';

  @override
  String get lended_person_saveChanges => 'Guardar cambios';

  @override
  String get lended_person_settled => 'ESTABLECIDO';

  @override
  String get lended_person_settle => 'Asentarse';

  @override
  String get lended_person_setADueDateFirstToEn =>
      'Primero establezca una fecha de vencimiento para habilitar los recordatorios.';

  @override
  String get lended_person_iLent => 'yo presté';

  @override
  String get lended_person_iBorrowed => 'tomé prestado';

  @override
  String get lended_person_accountOptional => 'Cuenta (opcional)';

  @override
  String get lended_person_dueDateReminder =>
      'Recordatorio de fecha de vencimiento';

  @override
  String get lended_person_remindMeAt => 'Recuérdamelo a';

  @override
  String get lended_person_active => 'Activo';

  @override
  String get lended_person_settled_ => 'Establecido';

  @override
  String get lended_lentMoney => 'Dinero prestado';

  @override
  String get lended_overdue => 'ATRASADO';

  @override
  String get lended_color => 'Color';

  @override
  String get more_more => 'Más';

  @override
  String get onboarding_back => 'Atrás';

  @override
  String get onboarding_welcomeToExpensy => '¡Bienvenido a Caro!';

  @override
  String get onboarding_restoreABackup => 'Restaurar una copia de seguridad';

  @override
  String get onboarding_loadAPreviouslySaved =>
      'Cargue un archivo JSON Expensy previamente guardado';

  @override
  String get onboarding_or => 'o';

  @override
  String get onboarding_startFresh => 'Empezar de nuevo';

  @override
  String get onboarding_firstWhatShouldWeCal =>
      'Primero, ¿cómo deberíamos llamarte?';

  @override
  String get onboarding_defaultCurrency => 'Moneda predeterminada';

  @override
  String get onboarding_thisWillBeUsedAcross =>
      'Esto se usará en toda la aplicación.\\nPuedes cambiarlo más tarde en Configuración.';

  @override
  String get onboarding_searchAllCurrencies => 'Buscar todas las monedas';

  @override
  String get onboarding_yourFirstAccount => 'Tu primera cuenta';

  @override
  String get onboarding_setUpYourMainAccount =>
      'Configure su cuenta principal para comenzar a rastrear.';

  @override
  String get onboarding_accountType => 'Tipo de cuenta';

  @override
  String get onboarding_currency => 'Divisa';

  @override
  String get onboarding_color => 'Color';

  @override
  String get recurring_recurring => 'Periódico';

  @override
  String get recurring_income => 'INGRESO';

  @override
  String get recurring_2D => '−2d';

  @override
  String get recurring_skipNextPayment => '¿Omitir el siguiente pago?';

  @override
  String get recurring_cancel => 'Cancelar';

  @override
  String get recurring_skip => 'Saltar';

  @override
  String get recurring_noHistoryYet => 'Aún no hay historial';

  @override
  String get recurring_expense => 'Gastos';

  @override
  String get recurring_income_ => 'Ingreso';

  @override
  String get recurring_every => 'Cada';

  @override
  String get recurring_days => 'Días';

  @override
  String get recurring_weeks => 'Semanas';

  @override
  String get recurring_months => 'Meses';

  @override
  String get recurring_years => 'Años';

  @override
  String get recurring_payments => 'Pagos';

  @override
  String get recurring_totalCost => 'Costo total';

  @override
  String get recurring_account => 'Cuenta';

  @override
  String get recurring_category => 'Categoría';

  @override
  String get recurring_paymentReminder => 'Recordatorio de pago';

  @override
  String get recurring_notificationWillFire =>
      'La notificación se activará en la próxima fecha de vencimiento a esta hora.';

  @override
  String get recurring_remind2DaysBefore => 'Recordar 2 días antes';

  @override
  String get statistics_statistics => 'Estadística';

  @override
  String get statistics_expensesByCategory => 'Gastos por categoría';

  @override
  String get transactions_transactions => 'Actas';

  @override
  String get transactions_settled => 'Establecido';

  @override
  String get transfer_transfer => 'Transferir';

  @override
  String get transfer_from => 'DE';

  @override
  String get transfer_to => 'A';

  @override
  String get transfer_enterAnAmountToSeeTh =>
      'Ingrese una cantidad para ver la conversión';

  @override
  String get wishlist_wishlist => 'Lista de deseos';

  @override
  String get wishlist_priority => 'Prioridad';

  @override
  String get shared_widgets_delete => '¿Borrar?';

  @override
  String get shared_widgets_cancel => 'Cancelar';

  @override
  String get shared_widgets_delete_ => 'Borrar';

  @override
  String get shared_widgets_none => 'Ninguno';

  @override
  String get shared_widgets_selectCurrency => 'Seleccionar moneda';

  @override
  String get main_home => 'Hogar';

  @override
  String get main_transactions => 'Actas';

  @override
  String get main_recurring => 'Periódico';

  @override
  String get main_accounts => 'Cuentas';

  @override
  String get main_budgets => 'Presupuestos';

  @override
  String get main_more => 'Más';

  @override
  String get onboarding_chooseLanguage => 'Elija idioma';

  @override
  String get error_required => 'Este campo es obligatorio';

  @override
  String recurring_subscriptions(Object count) {
    return 'Suscripciones ($count)';
  }

  @override
  String recurring_installments(Object count) {
    return 'Cuotas ($count)';
  }

  @override
  String get recurring_recurringType => 'Tipo recurrente';

  @override
  String get recurring_subscription => 'Suscripción';

  @override
  String get recurring_installment => 'Entrega';

  @override
  String get recurring_installmentsRequireEndDate =>
      'Las cuotas deben tener una fecha de pago final.';

  @override
  String get backup_importFromOtherApps => 'Importar desde otras aplicaciones';

  @override
  String get backup_importDescription =>
      'Importar datos de aplicaciones compatibles';

  @override
  String get backup_importFromGreenStash => 'Importar desde GreenStash (.json)';

  @override
  String get backup_automaticBackup => 'Copia de seguridad automática';

  @override
  String get backup_dailyAutoBackup => 'Copia de seguridad automática diaria';

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
  String get backup_changeTime => 'Cambiar hora';

  @override
  String get backup_changeFolder => 'Cambiar carpeta';

  @override
  String get budget_budgetsAndGoals => 'Presupuestos y objetivos';

  @override
  String get onboarding_restoreGreenStash =>
      'Restaurar desde GreenStash (.json)';

  @override
  String get savings_goalNotFound => 'Objetivo no encontrado';

  @override
  String get savings_savedSoFar => 'Guardado hasta ahora';

  @override
  String get savings_target => 'Objetivo';

  @override
  String savings_targetDate(String date) {
    return 'Target Date: $date';
  }

  @override
  String get savings_contribute => 'Contribuir';

  @override
  String get savings_withdraw => 'Retirar';

  @override
  String get savings_noAccounts =>
      'No hay cuentas disponibles. Primero agregue una cuenta.';

  @override
  String get settings_budgetAlerts => 'Alertas de presupuesto';

  @override
  String get settings_budgetAlertsSub =>
      'Notificar cuando se alcanza un presupuesto u objetivo';

  @override
  String get settings_dailyReminder => 'Recordatorio diario';

  @override
  String get settings_dailyReminderSub =>
      'Recuerde registrar transacciones diariamente';

  @override
  String get settings_reminderTime => 'Hora del recordatorio';

  @override
  String get settings_hapticFeedback => 'Retroalimentación háptica';

  @override
  String get settings_hapticFeedbackSub => 'Vibrar en las interacciones';

  @override
  String get savings_saveGoal => 'Guardar objetivo';
}
