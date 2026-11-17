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
  String get recurring_del => 'Elim.';

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
  String get budget_leftToSpend => 'Restante por gastar';

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
  String get budget_rollover => 'Transferencia (Sobres)';

  @override
  String get budget_rolloverDesc =>
      'Transferir excedentes no utilizados o déficits al siguiente período';

  @override
  String get budget_rolloverBadge => 'Acumulado';

  @override
  String budget_base(Object amount) {
    return 'Base: $amount';
  }

  @override
  String budget_rolloverFrom(Object period, Object amount) {
    return 'Acumulado ($period): $amount';
  }

  @override
  String budget_totalAvailable(Object amount) {
    return 'Total disponible: $amount';
  }

  @override
  String get budget_lastWeek => 'Semana pasada';

  @override
  String get pacing_dailyBudget => 'Gasto seguro';

  @override
  String pacing_safeToSpend(Object amount, Object days) {
    return 'Gasto seguro: $amount/día ($days días restantes)';
  }

  @override
  String pacing_caution(Object amount) {
    return 'Ritmo acelerado — limita a $amount/día';
  }

  @override
  String get pacing_overPaced =>
      'Alerta de ritmo — reduce gastos para no exceder';

  @override
  String get pacing_budgetExhausted =>
      'Presupuesto agotado — sin margen diario';

  @override
  String get pacing_onTrack => 'En buen ritmo';

  @override
  String get pacing_fast => 'Ritmo rápido';

  @override
  String get pacing_alert => 'Alerta de ritmo';

  @override
  String pacing_daysLeft(Object days) {
    return '$days días restantes';
  }

  @override
  String get pacing_setBudgetPrompt =>
      'Toca para fijar límites de presupuesto →';

  @override
  String get pacing_dailyAvgPace => 'Ritmo diario';

  @override
  String pacing_perDay(Object amount) {
    return '$amount / día';
  }

  @override
  String get calendar_title => 'Calendario financiero';

  @override
  String get calendar_subtitle => 'Mapa de calor de gastos y vencimientos';

  @override
  String calendar_zeroSpendDays(Object count) {
    return '$count días sin gastos';
  }

  @override
  String get calendar_zeroSpendDayTitle => '¡Día de cero gastos! 🎉';

  @override
  String get calendar_zeroSpendDayDesc =>
      'Excelente disciplina financiera sin gastos hoy.';

  @override
  String get calendar_billsDue => 'Facturas y suscripciones pendientes';

  @override
  String get calendar_loansDue => 'Cuotas de préstamos pendientes';

  @override
  String get calendar_lendedDue => 'Reembolsos esperados';

  @override
  String calendar_dayTransactions(Object count) {
    return 'Transacciones ($count)';
  }

  @override
  String get calendar_noActivity =>
      'Sin transacciones ni compromisos en esta fecha';

  @override
  String get calendar_today => 'Hoy';

  @override
  String calendar_averageDaily(Object amount) {
    return 'Promedio diario: $amount';
  }

  @override
  String get wrapped_title => 'Resumen Expensy';

  @override
  String wrapped_bannerTitle(Object month) {
    return '¡Tu resumen de $month está listo!';
  }

  @override
  String get wrapped_bannerSub =>
      'Toca para ver tu historia financiera mensual';

  @override
  String get wrapped_theBigPicture => 'El panorama general';

  @override
  String wrapped_howMoneyMoved(Object month) {
    return 'Así se movió tu dinero en $month';
  }

  @override
  String get wrapped_totalInflow => 'Ingresos totales';

  @override
  String get wrapped_totalOutflow => 'Gastos totales';

  @override
  String get wrapped_netSavings => 'Ahorro neto';

  @override
  String wrapped_savingsRate(Object rate) {
    return 'Tasa de ahorro: $rate%';
  }

  @override
  String get wrapped_topCategoryTitle => '¿A dónde se fue?';

  @override
  String wrapped_topCategorySub(Object category) {
    return 'Tu categoría con más gastos fue $category';
  }

  @override
  String wrapped_topCategoryShare(Object percent) {
    return '$percent% de tus gastos totales';
  }

  @override
  String get wrapped_biggestSplurgeTitle => 'Mayor gasto';

  @override
  String get wrapped_biggestSplurgeSub => 'Tu mayor gasto individual del mes';

  @override
  String get wrapped_noSplurge => '¡Sin lujos! No tuviste gastos este mes.';

  @override
  String get wrapped_heroHabitTitle => 'Hábito heroico';

  @override
  String wrapped_zeroSpendAchieved(Object count) {
    return '$count días sin gastos';
  }

  @override
  String wrapped_heroHabitDesc(Object count) {
    return 'Lograste $count días con cero gastos. ¡Excelente disciplina financiera!';
  }

  @override
  String get wrapped_receiptTitle => 'Estado mensual';

  @override
  String get wrapped_obscureToggle => 'Ocultar montos para compartir';

  @override
  String get wrapped_showToggle => 'Mostrar montos';

  @override
  String get wrapped_replay => 'Repetir historia';

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
      other: '$count artículos',
      one: '1 artículo',
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
      other: '$count activos',
      one: '1 activo',
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
      other: '$count categorías',
      one: '1 categoría',
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
  String get more_sectionTools => 'Herramientas financieras';

  @override
  String get more_sectionAnalytics => 'Análisis y estadísticas';

  @override
  String get more_sectionPreferences => 'Preferencias y datos';

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
  String get wishlist_fundThisItem => 'Financiar artículo';

  @override
  String wishlist_funded(int percent, String saved, String target) {
    return '$percent% financiado ($saved / $target)';
  }

  @override
  String get wishlist_goalAchieved => '¡Meta alcanzada — listo para comprar!';

  @override
  String get wishlist_buyNow => 'Comprar ahora';

  @override
  String get wishlist_purchaseTitle => 'Comprar artículo de la lista';

  @override
  String get wishlist_purchasePrompt =>
      '¿Desea registrar una transacción de gasto y deducir el importe de una cuenta?';

  @override
  String get wishlist_recordAndDeduct => 'Registrar y deducir';

  @override
  String get wishlist_markPurchasedOnly => 'Solo marcar como comprado';

  @override
  String wishlist_itemPurchased(String name) {
    return '¡\"$name\" marcado como comprado!';
  }

  @override
  String get wishlist_viewGoal => 'Ver meta de ahorro';

  @override
  String savings_linkedWishlist(String item) {
    return 'Vinculado a lista de deseos: $item';
  }

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
      other: '$count registros activos',
      one: '1 registro activo',
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
      other: '$count transacciones en el rango',
      one: '1 transacción en el rango',
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
  String get accounts_dontLinkToCard => 'No vincular a tarjeta';

  @override
  String get accounts_dontLinkToCardDesc =>
      'Administrar el saldo manualmente y evitar que las tarjetas se vinculen';

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
  String get export_exportAsPdf => 'Exportar como informe PDF';

  @override
  String get export_formatPdf => 'Formato: Informe financiero PDF (.pdf)';

  @override
  String get export_pdfGenerating => 'Generando PDF...';

  @override
  String get export_pdfTitle => 'Informe Financiero';

  @override
  String get export_pdfSummary => 'Resumen Ejecutivo';

  @override
  String get export_pdfInflow => 'Ingresos totales';

  @override
  String get export_pdfOutflow => 'Gastos totales';

  @override
  String get export_pdfNet => 'Ahorro neto';

  @override
  String get export_pdfSavingsRate => 'Tasa de ahorro';

  @override
  String get export_pdfCategoryBreakdown => 'Desglose por categorías';

  @override
  String get export_pdfTransactions => 'Transacciones detalladas';

  @override
  String get export_pdfNetWorthBreakdown => 'Activos y Pasivos';

  @override
  String get export_pdfShare => 'Compartir informe';

  @override
  String get export_pdfPrint => 'Imprimir / Vista previa';

  @override
  String get export_pdfGeneratedBy =>
      'Generado por Expensy • Privado y sin conexión';

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
  String get home_goodMorning => 'Buenos días';

  @override
  String get home_goodAfternoon => 'Buenas tardes';

  @override
  String get home_goodEvening => 'Buenas noches';

  @override
  String get home_transferAction => 'Transferir';

  @override
  String get home_insightsAction => 'Estadísticas';

  @override
  String get home_calendarAction => 'Calendario';

  @override
  String get home_forecastAction => 'Pronóstico';

  @override
  String get home_manage => 'Gestionar';

  @override
  String get home_seeAll => 'Ver todo';

  @override
  String get home_addAccount => 'Añadir cuenta';

  @override
  String get home_cards => 'Tarjetas';

  @override
  String get home_addCard => 'Añadir tarjeta';

  @override
  String get home_monthlyOverview => 'Resumen mensual';

  @override
  String get home_savingsRate => 'Tasa de ahorro';

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
  String get recurring_2D => '-2d';

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
    return 'Diario a las $time';
  }

  @override
  String backup_lastBackup(String time) {
    return 'Última copia: $time';
  }

  @override
  String backup_savingTo(String path) {
    return 'Guardando en: $path';
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
    return 'Fecha objetivo: $date';
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

  @override
  String get more_loans => 'Préstamos';

  @override
  String more_loansSub(num count) {
    return 'Préstamos activos';
  }

  @override
  String get loans_title => 'Préstamos';

  @override
  String get loans_addLoan => 'Añadir préstamo';

  @override
  String get loans_editLoan => 'Editar préstamo';

  @override
  String get loans_loanName => 'Nombre del préstamo';

  @override
  String get loans_amount => 'Monto';

  @override
  String get loans_startDate => 'Fecha de inicio';

  @override
  String get loans_endDate => 'Fecha de finalización';

  @override
  String get loans_interestRateOptional => 'Tasa de interés (Opcional)';

  @override
  String get loans_account => 'Cuenta vinculada';

  @override
  String get loans_monthlyPayment => 'Pago mensual';

  @override
  String get loans_totalPayable => 'Total a pagar';

  @override
  String get loans_remaining => 'Restante';

  @override
  String get loans_paid => 'Pagado';

  @override
  String get loans_logPayment => 'Registrar pago';

  @override
  String get loans_paymentReminder => 'Recordatorio de pago';

  @override
  String get loans_reminderDay => 'Día de recordatorio';

  @override
  String get loans_notes => 'Notas';

  @override
  String get loans_saveLoan => 'Guardar préstamo';

  @override
  String get loans_deleteLoan => 'Eliminar préstamo';

  @override
  String get loans_settled => 'Saldado';

  @override
  String loans_durationMonths(num count) {
    return 'Meses';
  }

  @override
  String get loans_paymentHistory => 'Historial de pagos';

  @override
  String get loans_noPayments => 'Aún no hay pagos registrados';

  @override
  String get loans_outstandingDebt => 'Deuda pendiente';

  @override
  String get loans_monthlyObligation => 'Obligación mensual';

  @override
  String get insights_loans => 'Préstamos';

  @override
  String get backup_loans => 'Préstamos';

  @override
  String get backup_loanPayments => 'Pagos de préstamos';

  @override
  String get more_yearlyAnalysis => 'Análisis anual';

  @override
  String get more_yearlyAnalysisSub => 'Pronóstico de flujo de caja mes a mes';

  @override
  String get yearly_title => 'Análisis anual';

  @override
  String get yearly_recurringExp => 'Gastos recurrentes';

  @override
  String get yearly_recurringInc => 'Ingresos recurrentes';

  @override
  String get yearly_loans => 'Pagos de préstamos';

  @override
  String get yearly_borrowed => 'Deuda prestada';

  @override
  String get yearly_lentDue => 'Préstamos a cobrar';

  @override
  String get yearly_inflow => 'Entradas';

  @override
  String get yearly_outflow => 'Salidas';

  @override
  String get yearly_netFlow => 'Flujo neto';

  @override
  String get yearly_totalInflow => 'Entrada total';

  @override
  String get yearly_totalOutflow => 'Salida total';

  @override
  String get yearly_netCashFlow => 'Flujo de caja neto';

  @override
  String get yearly_noData => 'Sin actividad proyectada';

  @override
  String get yearly_noDataSub =>
      'Añada pagos recurrentes o préstamos para ver un pronóstico';

  @override
  String get budget_addBudget => 'Añadir presupuesto';

  @override
  String get budget_addGoal => 'Añadir meta de ahorro';

  @override
  String get add_transaction_possibleDuplicate => 'Posible duplicado';

  @override
  String get add_transaction_goBack => 'Volver';

  @override
  String get add_transaction_saveAnyway => 'Guardar de todos modos';

  @override
  String get loans_confirmDeleteLoan =>
      '¿Seguro que deseas eliminar este préstamo y todos sus pagos?';

  @override
  String get loans_deletePayment => 'Eliminar pago';

  @override
  String get loans_confirmDeletePayment =>
      '¿Seguro que deseas eliminar este registro de pago?';

  @override
  String get split_transactions_title => 'Dividir categorías';

  @override
  String get split_transactions_badge => 'Dividida';

  @override
  String get split_transactions_addSplit => 'Añadir división';

  @override
  String get split_transactions_removeSplit => 'Eliminar división';

  @override
  String get split_transactions_allocated => 'Asignado';

  @override
  String get split_transactions_remaining => 'Restante';

  @override
  String get split_transactions_fillRemaining => 'Llenar restante';

  @override
  String get split_transactions_breakdown => 'Desglose de división';

  @override
  String get split_transactions_mismatchError =>
      'Los importes divididos deben coincidir exactamente con el total.';

  @override
  String get netWorth_title => 'Patrimonio neto';

  @override
  String get netWorth_subtitle =>
      'Rastrea activos, pasivos y riqueza a lo largo del tiempo';

  @override
  String get netWorth_current => 'Patrimonio neto actual';

  @override
  String get netWorth_trend => 'Tendencia del patrimonio neto';

  @override
  String get netWorth_totalAssets => 'Total de activos';

  @override
  String get netWorth_totalLiabilities => 'Total de pasivos';

  @override
  String get netWorth_liquidCash => 'Efectivo y cuentas bancarias';

  @override
  String get netWorth_goldValuation => 'Oro físico';

  @override
  String get netWorth_fixedAssets => 'Propiedades e inversiones';

  @override
  String get netWorth_moneyLent => 'Dinero prestado (Por cobrar)';

  @override
  String get netWorth_creditDebt => 'Tarjetas de crédito y sobregiros';

  @override
  String get netWorth_loanDebt => 'Préstamos por pagar';

  @override
  String get netWorth_moneyBorrowed => 'Dinero pedido prestado (Por pagar)';

  @override
  String get netWorth_assetBreakdown => 'Desglose de activos';

  @override
  String get netWorth_liabilityBreakdown => 'Desglose de pasivos';

  @override
  String get netWorth_noHistory =>
      'El historial de patrimonio neto se acumulará automáticamente con los registros diarios.';

  @override
  String get netWorth_debtRatio => 'Ratio de endeudamiento';

  @override
  String get netWorth_quickActions => 'Acciones rápidas';

  @override
  String get netWorth_history => 'Historial de instantáneas';

  @override
  String get creditCard_utilization => 'Uso del crédito';

  @override
  String get creditCard_availableCredit => 'Disponible';

  @override
  String get creditCard_limit => 'Límite';

  @override
  String get creditCard_statementBalance => 'Saldo del estado de cuenta';

  @override
  String get creditCard_unbilledBalance => 'No facturado';

  @override
  String get creditCard_payBill => 'Pagar tarjeta';

  @override
  String get creditCard_allCaughtUp => '¡Todo al día! Sin saldo pendiente';

  @override
  String get creditCard_payBillTitle => 'Pagar estado de cuenta';

  @override
  String get creditCard_payFromAccount => 'Pagar desde cuenta';

  @override
  String get creditCard_paymentAmount => 'Monto a pagar';

  @override
  String get creditCard_fullStatement => 'Saldo del estado de cuenta';

  @override
  String get creditCard_fullBalance => 'Saldo total';

  @override
  String get creditCard_minPayment => 'Pago mínimo';

  @override
  String get creditCard_customAmount => 'Monto personalizado';

  @override
  String creditCard_paymentSuccess(String amount, String cardName) {
    return 'Se pagaron $amount a $cardName';
  }

  @override
  String get creditCard_insufficientFunds =>
      'El monto supera el saldo disponible';

  @override
  String get creditCard_invalidAmount => 'Por favor ingresa un monto válido';

  @override
  String get onboarding_skipForNow => 'Omitir por ahora';

  @override
  String get onboarding_addCard => 'Añadir tarjeta';

  @override
  String get onboarding_skipCardDesc =>
      'Puedes omitir esto si no deseas añadir una tarjeta ahora mismo.';

  @override
  String get onboarding_cardNameLabel =>
      'Nombre de la tarjeta (ej. Visa Platinum)';

  @override
  String get onboarding_debitCard => 'Tarjeta de débito';

  @override
  String get onboarding_creditLimit => 'Límite de crédito';

  @override
  String get onboarding_amountUsed => 'Monto utilizado';

  @override
  String get accounts_cardHolderOptional => 'Titular de la tarjeta (Opcional)';

  @override
  String get accounts_last4Digits => 'Últimos 4 dígitos';

  @override
  String get accounts_expiryDate => 'Fecha de vencimiento (MM/AA)';

  @override
  String get accounts_creditLimitOptional => 'Límite de crédito (Opcional)';

  @override
  String get accounts_minPaymentOptional => 'Pago mínimo (Opcional)';

  @override
  String get accounts_statementDayOptional => 'Día de corte (Opcional)';

  @override
  String get accounts_statementDayExample => 'ej. 20';

  @override
  String get accounts_dueDayOptional => 'Día de pago (Opcional)';

  @override
  String get accounts_dueDayExample => 'ej. 10';

  @override
  String get accounts_linkedAccountOptional =>
      'Cuenta bancaria vinculada (Opcional)';

  @override
  String get accounts_excludeCardBalance =>
      'Excluir saldo de la tarjeta del total de la cuenta';

  @override
  String get accounts_excludeCardBalanceDesc =>
      'El saldo de esta tarjeta no se sumará a la cuenta bancaria vinculada.';

  @override
  String get accounts_cardHolderHeader => 'TITULAR';

  @override
  String get accounts_expHeader => 'VENCE';

  @override
  String get accounts_notifyOnDueDate =>
      'Se te notificará en la fecha de vencimiento';

  @override
  String get accounts_notifyWhenDue =>
      'Recibir recordatorio cuando venza el pago';

  @override
  String get accounts_remind2DaysBeforeDesc =>
      'Recibir aviso 2 días antes de la fecha de vencimiento';

  @override
  String get accounts_targetSaved => 'Meta / Ahorrado';

  @override
  String transactions_selectedCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seleccionados',
      one: '1 seleccionado',
    );
    return '$_temp0';
  }

  @override
  String get transactions_changeCategory => 'Cambiar categoría';

  @override
  String get transactions_deleteSelected => 'Eliminar seleccionados';

  @override
  String get transactions_advancedFilters => 'Filtros avanzados';

  @override
  String get transactions_clearAll => 'Limpiar todo';

  @override
  String get transactions_amountRange => 'Rango de monto';

  @override
  String get transactions_minAmount => 'Monto mínimo';

  @override
  String get transactions_maxAmount => 'Monto máximo';

  @override
  String get transactions_applyFilters => 'Aplicar filtros';

  @override
  String get presets_new => 'Nuevo';

  @override
  String get presets_presetName => 'Nombre de plantilla (ej. Café matutino)';

  @override
  String get presets_defaultAmount => 'Monto predeterminado';

  @override
  String get savings_goalName => 'Nombre de la meta';

  @override
  String get savings_goalNameHint => 'ej. Auto nuevo, Vacaciones';

  @override
  String get savings_targetAmount => 'Monto objetivo';

  @override
  String get savings_targetDateOptional => 'Fecha objetivo (Opcional)';

  @override
  String get savings_selectDate => 'Seleccionar fecha';

  @override
  String get savings_amountRequired => 'El monto es obligatorio';

  @override
  String get savings_noteOptional => 'Nota (Opcional)';

  @override
  String get loans_skipInstallment => '¿Omitir la próxima cuota del préstamo?';

  @override
  String get recurring_confirmDelete =>
      '¿Estás seguro de que deseas eliminar este pago recurrente?';

  @override
  String get export_formatExcelOption => 'Excel (.xlsx)';

  @override
  String get export_formatPdfOption => 'Informe PDF';

  @override
  String get export_pdfNoTransactions =>
      'No hay transacciones registradas en este rango de fechas.';

  @override
  String get savings_saved => 'Ahorrado';

  @override
  String get export_pdfDate => 'Fecha';

  @override
  String get export_pdfDescription => 'Descripción';

  @override
  String get accounts_noCardsYet => 'Sin tarjetas';

  @override
  String get accounts_tapToAddCard => 'Toca + para agregar tu primera tarjeta';

  @override
  String get savings_noGoalsYet => 'Sin objetivos de ahorro';

  @override
  String get savings_tapToAddGoal => 'Toca + para establecer una nueva meta';

  @override
  String get netWorth_recordSnapshot => 'Registrar instantánea';

  @override
  String get netWorth_snapshotRecorded => 'Instantánea registrada';

  @override
  String get savings_noContributionsYet => 'Aún no hay contribuciones';

  @override
  String get creditCard_closesStatementBillingCycle =>
      'Cierra el ciclo de facturación del estado actual';

  @override
  String get creditCard_clearsTotalDebt =>
      'Liquida la deuda total de la tarjeta por completo';

  @override
  String get creditCard_requiredMinPayment => 'Pago mínimo requerido';

  @override
  String get creditCard_specifyCustomAmount =>
      'Especificar monto de pago personalizado';

  @override
  String common_itemDeleted(String name) {
    return '\"$name\" eliminado';
  }

  @override
  String get common_accountDeleted => 'Cuenta eliminada';

  @override
  String get common_cardDeleted => 'Tarjeta eliminada';

  @override
  String get common_transactionDeleted => 'Transacción eliminada';

  @override
  String get common_recordDeleted => 'Registro eliminado';

  @override
  String get common_paymentDeleted => 'Pago eliminado';

  @override
  String get loans_skippedInstallment => 'Cuota del préstamo omitida';

  @override
  String loans_loggedPayment(String amount) {
    return 'Pago registrado de $amount';
  }

  @override
  String get loans_notificationsPermissionRequired =>
      'Se requiere permiso de notificaciones';

  @override
  String get creditCard_selectFundingAccount =>
      'Por favor, seleccione una cuenta de origen';

  @override
  String get presets_presetUpdated => 'Plantilla actualizada';

  @override
  String get presets_presetAdded => 'Plantilla agregada';

  @override
  String get presets_presetDeleted => 'Plantilla eliminada';

  @override
  String transactions_deletedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementos eliminados',
      one: '1 elemento eliminado',
    );
    return '$_temp0';
  }

  @override
  String get split_atLeastTwoCategories =>
      'Se requieren al menos 2 categorías para dividir.';

  @override
  String get split_categoryAndAmountRequired =>
      'Cada elemento dividido debe tener una categoría y un monto > 0.';

  @override
  String get presets_addQuickPresets => 'Agregar preajustes rápidos de 1 toque';

  @override
  String get presets_quickPresetsDesc =>
      'Registra café frecuente, transporte o comidas con un solo toque';

  @override
  String presets_loggedPreset(String title, String amount) {
    return 'Registrado $title ($amount)';
  }

  @override
  String get presets_createPreset => 'Crear plantilla';

  @override
  String get presets_editQuickPreset => 'Editar preajuste rápido';

  @override
  String get presets_newQuickPreset => 'Nuevo preajuste rápido';

  @override
  String get savings_addContribution => 'Agregar contribución';

  @override
  String get savings_withdrawFromGoal => 'Retirar del objetivo';

  @override
  String get savings_contribution => 'Contribución';

  @override
  String get savings_withdrawal => 'Retiro';

  @override
  String get savings_unknownAccount => 'Cuenta desconocida';

  @override
  String get savings_fromAccount => 'Desde cuenta';

  @override
  String get savings_toAccount => 'A cuenta';

  @override
  String get presets_quickLog => 'Registro rápido';

  @override
  String accounts_dueOnDay(int day) {
    return 'Vence el $day';
  }

  @override
  String get accounts_cannotDeleteAccount => 'No se puede eliminar la cuenta';

  @override
  String get common_ok => 'Aceptar';

  @override
  String get certificates_title => 'Depósitos a Plazo y Certificados';

  @override
  String get certificates_addCertificate => 'Añadir certificado';

  @override
  String get certificates_editCertificate => 'Editar certificado';

  @override
  String get certificates_noCertificates => 'Aún no hay certificados';

  @override
  String get certificates_noCertificatesDesc =>
      'Realiza un seguimiento de tus depósitos a plazo, rendimientos y pagos de intereses.';

  @override
  String get certificates_active => 'Activo';

  @override
  String get certificates_matured => 'Vencido';

  @override
  String get certificates_amount => 'Monto principal';

  @override
  String get certificates_collectionType => 'Cobro de intereses';

  @override
  String get certificates_collectedSoFar => 'Cobrado hasta ahora';

  @override
  String get certificates_expectedTotal => 'Retorno total esperado';

  @override
  String get certificates_startDate => 'Fecha de inicio';

  @override
  String get certificates_endDate => 'Fecha de vencimiento';

  @override
  String get certificates_redeem => 'Canjear certificado';

  @override
  String certificates_redeemConfirm(String name, String amount) {
    return '¿Estás seguro de que deseas canjear \"$name\"? El principal de $amount se devolverá a tu cuenta bancaria.';
  }

  @override
  String get certificates_redeemedSuccess =>
      'Certificado canjeado y monto principal devuelto con éxito.';

  @override
  String get certificates_name => 'Nombre del certificado';

  @override
  String get certificates_interestRate => 'Tasa de interés anual (%)';

  @override
  String get certificates_linkedBankAccount => 'Cuenta bancaria vinculada';

  @override
  String get certificates_periodicYield => 'Rendimiento periódico de intereses';

  @override
  String get certificates_paymentReminder =>
      'Recordatorio de cobro de intereses';

  @override
  String get certificates_reminderTime => 'Hora del recordatorio';

  @override
  String get certificates_reminder2DaysBefore => 'Recordatorio 2 días antes';

  @override
  String get certificates_deleteCertificate => 'Eliminar certificado';

  @override
  String get certificates_confirmDeleteCertificate =>
      '¿Estás seguro de que deseas eliminar este certificado? Se eliminarán todas las transacciones asociadas y el dinero se devolverá a tu cuenta.';

  @override
  String get certificates_deleted => 'Certificado eliminado';

  @override
  String get onboarding_stayOnTopOfFinances =>
      'Mantén el control de tus finanzas';

  @override
  String get onboarding_stayOnTopOfFinancesDesc =>
      'Activa recordatorios oportunos para no perder pagos, facturas vencidas o límites de presupuesto.';

  @override
  String get onboarding_featureBillTitle =>
      'Recordatorios de facturas y fechas de vencimiento';

  @override
  String get onboarding_featureBillDesc =>
      'Recibe alertas antes de las fechas de corte de tarjetas de crédito y cuotas de préstamos.';

  @override
  String get onboarding_featureBudgetTitle => 'Alertas de presupuesto';

  @override
  String get onboarding_featureBudgetDesc =>
      'Recibe alertas cuando alcances el 80% o el 100% de tu límite de gasto por categoría.';

  @override
  String get onboarding_featureRecurringTitle => 'Suscripciones recurrentes';

  @override
  String get onboarding_featureRecurringDesc =>
      'Mantente informado antes de que se renueven automáticamente tus facturas y membresías.';

  @override
  String get onboarding_allowNotifications => 'Permitir notificaciones';

  @override
  String get onboarding_maybeLater => 'Quizás más tarde';

  @override
  String get categories_subcategories => 'Subcategorías';

  @override
  String get categories_addSubcategory => 'Añadir subcategoría';

  @override
  String get categories_parentCategory => 'Categoría principal';

  @override
  String get categories_noneRoot => 'Ninguna (Categoría principal)';

  @override
  String get categories_loadDefaults => 'Cargar subcategorías predeterminadas';

  @override
  String categories_defaultsLoaded(int count) {
    return 'Se cargaron $count subcategorías predeterminadas';
  }

  @override
  String get categories_defaultsAlreadyLoaded =>
      'Las subcategorías predeterminadas ya están cargadas';

  @override
  String get statistics_byCategory => 'Por categoría';

  @override
  String get statistics_bySubcategory => 'Por subcategoría';

  @override
  String get backup_importFromTrackWallet =>
      'Importar desde TrackWallet (.csv)';

  @override
  String backup_importedTransactions(int count) {
    return '¡$count transacciones importadas con éxito!';
  }

  @override
  String get onboarding_restoreTrackWallet =>
      'Importar desde TrackWallet (.csv)';

  @override
  String get transfer_categoryLocked =>
      'Transferencia (Categoría predeterminada y única)';

  @override
  String get loans_noLoans => 'Aún no hay préstamos registrados';

  @override
  String get loans_noLoansSub =>
      'Toca + para registrar hipotecas, préstamos o cuotas';

  @override
  String get certificates_noCertificatesSub =>
      'Toca + para seguir certificados y depósitos a plazo';

  @override
  String get common_undo => 'Deshacer';

  @override
  String get common_close => 'Cerrar';

  @override
  String get common_required => 'Requerido';

  @override
  String get common_invalid => 'Inválido';

  @override
  String get common_none => 'Ninguno';

  @override
  String common_enabledAt(String time) {
    return 'Activado ($time)';
  }

  @override
  String get common_disabled => 'Desactivado';

  @override
  String get freq_daily => 'Diario';

  @override
  String get freq_yearly => 'Anual';

  @override
  String recurring_transfers(Object count) {
    return 'Transferencias ($count)';
  }

  @override
  String get recurring_transfer => 'Transferencia';

  @override
  String get recurring_transferCaps => 'TRANSFERENCIA';

  @override
  String get recurring_noRecurringTransfers => 'Sin transferencias recurrentes';

  @override
  String recurring_subtitleCount(int count) {
    return '$count suscripciones y recurrentes';
  }

  @override
  String recurring_perWeek(String amount) {
    return '$amount / semana';
  }

  @override
  String get recurring_perMonth => '/ mes';

  @override
  String get recurring_fromAccount => 'Desde cuenta';

  @override
  String get recurring_toAccount => 'Hacia cuenta';

  @override
  String recurring_targetAmount(String currency) {
    return 'Monto destino ($currency)';
  }

  @override
  String get recurring_autoPayAt => 'Pago automático a las';

  @override
  String get recurring_autoPayOnDueDate => 'Pago automático al vencimiento';

  @override
  String get recurring_autoPayEnabledSub =>
      'Se registra automáticamente al vencer';

  @override
  String get recurring_autoPayDisabledSub =>
      'Registrar este pago automáticamente al vencer';

  @override
  String get recurring_autoPayTime => 'Hora de pago automático';

  @override
  String get recurring_reminderEnabledSub =>
      'Recibirás una notificación en la fecha límite';

  @override
  String get recurring_reminderDisabledSub =>
      'Recibir aviso cuando venza un pago';

  @override
  String get recurring_earlyReminderEnabledSub =>
      'Aviso adicional 2 días antes a la misma hora';

  @override
  String get recurring_earlyReminderDisabledSub =>
      'También avisar 2 días antes del vencimiento';

  @override
  String get recurring_addRecurringBtn => 'Añadir recurrente';

  @override
  String get recurring_paymentDetails => 'Detalles del pago';

  @override
  String get recurring_linkedAccount => 'Cuenta vinculada';

  @override
  String get recurring_deletedAccount => 'Cuenta eliminada';

  @override
  String get recurring_frequency => 'Frecuencia';

  @override
  String get recurring_type => 'Tipo';

  @override
  String get recurring_startDate => 'Fecha de inicio';

  @override
  String get recurring_nextDueDate => 'Próximo vencimiento';

  @override
  String get recurring_autoPay => 'Pago automático';

  @override
  String get recurring_reminder => 'Recordatorio';

  @override
  String get recurring_endDate => 'Fecha de fin';

  @override
  String get recurring_totalValue => 'Valor total';

  @override
  String get recurring_notes => 'Notas';

  @override
  String get recurring_upcomingPayments => 'Próximos pagos';

  @override
  String recurring_remainingCount(int count) {
    return '$count restantes';
  }

  @override
  String get recurring_allInstallmentsCompleted =>
      'Todas las cuotas completadas';

  @override
  String recurring_installmentOf(int num, int total) {
    return '#$num de $total';
  }

  @override
  String get recurring_paymentPaid => 'Pago realizado';

  @override
  String get recurring_paymentSkipped => 'Pago omitido';

  @override
  String get presets_transfer => 'Transferencia';

  @override
  String get presets_selectDifferentAccounts =>
      'Selecciona cuentas de origen y destino diferentes.';

  @override
  String presets_targetAmountOptional(String currency) {
    return 'Monto destino en $currency (Opcional)';
  }

  @override
  String get transactions_transfers => 'Transferencias';

  @override
  String transactions_selectedItemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementos seleccionados',
      one: '1 elemento seleccionado',
    );
    return '$_temp0';
  }

  @override
  String transactions_entriesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count registros',
      one: '1 registro',
    );
    return '$_temp0';
  }

  @override
  String get transactions_clearSelection => 'Limpiar selección';

  @override
  String get transactions_transferTitle => 'Transferencia';

  @override
  String get transactions_transferBody =>
      'Esta transacción es parte de una transferencia entre cuentas. No se puede editar un lado individualmente. ¿Deseas eliminar esta transferencia?';

  @override
  String get transactions_deleteTransfer => 'Eliminar transferencia';

  @override
  String get transactions_transferDeleted => 'Transferencia eliminada';

  @override
  String get transactions_certTitle => 'Transacción de certificado';

  @override
  String get transactions_certBody =>
      'Esta transacción está vinculada a un depósito a plazo / certificado. Adminístrala desde la pantalla de Certificados.';

  @override
  String get transactions_viewCertificate => 'Ver certificado';

  @override
  String get transactions_openCertificates => 'Abrir certificados';

  @override
  String get transactions_loanFallback => 'Préstamo';

  @override
  String get transactions_loanPayment => 'Cuota de préstamo';

  @override
  String get transactions_goalContribution => 'Aporte a meta';

  @override
  String get transactions_goalWithdrawal => 'Retiro de meta';

  @override
  String get calendar_repayment => 'Reembolso';

  @override
  String get calendar_transfersDue => 'Transferencias recurrentes';

  @override
  String accounts_subtitleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cuentas',
      one: '1 cuenta',
    );
    return '$_temp0';
  }

  @override
  String get accounts_tabAccounts => 'Cuentas';

  @override
  String get accounts_tabCards => 'Tarjetas';

  @override
  String get accounts_addCardBtn => 'Añadir tarjeta';

  @override
  String get accounts_addNewCardBtn => 'Añadir nueva tarjeta';

  @override
  String get accounts_editCard => 'Editar tarjeta';

  @override
  String get accounts_cardNameHint => 'Nombre de tarjeta (ej. Visa Platinum)';

  @override
  String get accounts_debitCard => 'Tarjeta de débito';

  @override
  String get accounts_prepaidCard => 'Tarjeta prepago';

  @override
  String get accounts_pinToWidget => 'Fijar en el widget';

  @override
  String get accounts_unpinFromWidget => 'Desfijar del widget';

  @override
  String get accounts_maxPinnedWarning => 'No puedes fijar más de 3 cuentas';

  @override
  String get accounts_selectLinkedBank =>
      'Selecciona una cuenta bancaria vinculada para esta tarjeta.';

  @override
  String get accounts_debitSharesBalance =>
      'Las tarjetas de débito comparten el saldo con su cuenta bancaria.';

  @override
  String get accounts_linkedBankRequired =>
      'Cuenta bancaria vinculada (Obligatorio)';

  @override
  String get accounts_amountCurrentlyOwed => 'Monto adeudado actual';

  @override
  String get accounts_initialAmountOwed => 'Monto adeudado inicial';

  @override
  String get accounts_cardDebtHint =>
      'Ingresa el saldo adeudado actual en esta tarjeta';

  @override
  String accounts_nextCycleCloses(int day) {
    return 'El próximo cierre es alrededor del día $day';
  }

  @override
  String accounts_spotPriceLabel(int karat) {
    return 'Precio spot (oro ${karat}k/g)';
  }

  @override
  String get accounts_weightTimesPurity => 'Peso × pureza';

  @override
  String accounts_blockDeleteRecurring(int count) {
    return 'La cuenta tiene $count pagos recurrentes activos. Reasígnalos o elimínalos primero.';
  }

  @override
  String accounts_blockDeleteLoans(int count) {
    return 'La cuenta tiene $count préstamos activos. Reasígnalos o elimínalos primero.';
  }

  @override
  String accounts_blockDeleteCertificates(int count) {
    return 'La cuenta tiene $count certificados activos. Canjéalos o elimínalos primero.';
  }

  @override
  String accounts_blockDeleteLended(int count) {
    return 'La cuenta tiene $count registros pendientes de préstamo. Liquídalos primero.';
  }

  @override
  String accounts_blockDeleteSavings(int count) {
    return 'La cuenta se usa en $count aportes de ahorro. Reasígnalos o elimínalos primero.';
  }

  @override
  String accounts_blockDeletePresets(int count) {
    return 'La cuenta se usa en $count atajos rápidos. Reasígnalos o elimínalos primero.';
  }

  @override
  String accounts_blockDeleteCards(int count) {
    return 'La cuenta está vinculada a $count tarjetas. Desvincúlalas o elimínalas primero.';
  }

  @override
  String get add_transaction_selectAccountOrCard =>
      'Selecciona una cuenta o tarjeta.';

  @override
  String get add_transaction_balanced => 'Cuadrado';

  @override
  String add_transaction_similarExists(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ya existen $count transacciones similares:',
      one: 'Ya existe una transacción similar:',
    );
    return '$_temp0';
  }

  @override
  String budget_goalsCountSubtitle(int budgets, int goals) {
    return '$budgets presupuestos · $goals metas';
  }

  @override
  String get budget_savingsGoalsCaps => 'METAS DE AHORRO';

  @override
  String budget_percentSaved(String percent) {
    return '$percent% ahorrado';
  }

  @override
  String budget_ofTarget(String amount) {
    return 'de $amount objetivo';
  }

  @override
  String get budget_goalsTab => 'Metas';

  @override
  String get budget_completed => 'Completado';

  @override
  String get savings_newGoal => 'Nueva meta de ahorro';

  @override
  String get savings_editGoal => 'Editar meta de ahorro';

  @override
  String get certificates_activePrincipal => 'Capital activo';

  @override
  String get certificates_activeCount => 'Activos';

  @override
  String certificates_linkedBank(String name) {
    return 'Vinculado: $name';
  }

  @override
  String certificates_yieldSummary(String amount, String type) {
    return 'Rendimiento: $amount ($type)';
  }

  @override
  String certificates_maturesOn(String date) {
    return 'Vence el: $date';
  }

  @override
  String get certificates_settledCaps => 'LIQUIDADO';

  @override
  String get certificates_activeCaps => 'ACTIVO';

  @override
  String get certificates_annualRate => 'Tasa anual';

  @override
  String get certificates_periodicYieldLabel => 'Rendimiento periódico';

  @override
  String get certificates_maturedAndSettled => 'Vencido y liquidado';

  @override
  String get certificates_payoutOverride => 'Pago (personalizado)';

  @override
  String get certificates_dayRange => 'Día (1-31)';

  @override
  String get certificates_noBankAccounts =>
      'No hay cuentas bancarias. Crea una cuenta bancaria para recibir rendimientos.';

  @override
  String get certificates_selectLinkedBank =>
      'Selecciona una cuenta bancaria vinculada.';

  @override
  String get creditCard_noFundingAccounts =>
      'No hay cuentas de banco o efectivo disponibles para pagar.';

  @override
  String get creditCard_processing => 'Procesando...';

  @override
  String creditCard_payAmountBtn(String amount) {
    return 'Pagar $amount';
  }

  @override
  String get insights_loanPaymentsThisMonth =>
      'Pagos de deuda/préstamos este mes';

  @override
  String get insights_spendingForecast => 'Pronóstico de gastos';

  @override
  String get insights_forecastPrefix => 'A este ritmo gastarás ';

  @override
  String insights_forecastSuffix(String month, int days) {
    return ' al final de $month — quedan $days días.';
  }

  @override
  String get insights_forecastDisclaimer =>
      'Proyección basada en gastos actuales; no incluye pagos recurrentes futuros.';

  @override
  String insights_forecastAccuracy(int days) {
    return 'Basado en los primeros $days días — la precisión mejora con el mes.';
  }

  @override
  String insights_projAmount(String amount) {
    return 'Proy.: $amount';
  }

  @override
  String insights_projOfBudget(String percent) {
    return ' ($percent% del presupuesto)';
  }

  @override
  String get insights_outstanding => 'Pendiente';

  @override
  String get insights_monthlyObligation => 'Cuota mensual';

  @override
  String get loans_principal => 'Capital';

  @override
  String get loans_interestRate => 'Tasa de interés';

  @override
  String get loans_duration => 'Duración';

  @override
  String get loans_transferTo => 'Transferir monto del préstamo a';

  @override
  String get loans_payFrom => 'Pagar cuotas desde';

  @override
  String loans_dueDayTime(int day, String time) {
    return 'Vence: Día $day a las $time';
  }

  @override
  String more_activeCount(int count) {
    return '$count activos';
  }

  @override
  String more_toolsSubtitle(int count) {
    return '$count herramientas y preferencias';
  }

  @override
  String get more_totalWealthCaps => 'PATRIMONIO TOTAL';

  @override
  String get more_liveNetWorthSub =>
      'Patrimonio neto en vivo de todas tus cuentas';

  @override
  String more_assetsAmount(String amount) {
    return 'Activos: $amount';
  }

  @override
  String more_liabilitiesAmount(String amount) {
    return 'Pasivos: $amount';
  }

  @override
  String get netWorth_debtFree => 'Sin deudas';

  @override
  String get netWorth_showLess => 'Mostrar menos';

  @override
  String netWorth_showAll(int count) {
    return 'Ver todo ($count)';
  }

  @override
  String get netWorth_zeroLiabilities =>
      '¡Cero pasivos registrados! Tu deuda actual es \$0.00.';

  @override
  String get netWorth_lentDebts => 'Préstamos / Deudas';

  @override
  String netWorth_snapBreakdown(String assets, String accounts) {
    return 'Activos: $assets · Cuentas: $accounts';
  }

  @override
  String get onboarding_nameRequired => 'El nombre es obligatorio';

  @override
  String get onboarding_popularCurrencies => 'Monedas populares';

  @override
  String get onboarding_debitCardNextStep =>
      'Puedes añadir una tarjeta de débito para esta cuenta en el siguiente paso';

  @override
  String get onboarding_addDebitCardTitle => 'Añadir tarjeta de débito';

  @override
  String get onboarding_addDebitCardDesc =>
      'Vincula una tarjeta de débito a tu cuenta bancaria para registrar gastos fácilmente.';

  @override
  String get onboarding_cardName => 'Nombre de tarjeta';

  @override
  String get onboarding_cardholderName => 'Titular de la tarjeta';

  @override
  String get onboarding_last4Digits => 'Últimos 4 dígitos';

  @override
  String get onboarding_cardColor => 'Color de tarjeta';

  @override
  String wrapped_zeroSpendOfDays(int total) {
    return 'de $total días sin gastos';
  }

  @override
  String get wrapped_savingsRateLabel => 'Tasa de ahorro';

  @override
  String get wrapped_topCategoryLabel => 'Categoría principal';

  @override
  String get wrapped_zeroSpendDaysLabel => 'Días sin gastos';

  @override
  String get wrapped_footerTag => '★ Finanzas Privadas y Sin Conexión ★';

  @override
  String get yearly_tapToExpand => 'Toca para ampliar';

  @override
  String get yearly_noDataBadge => 'Sin datos';

  @override
  String get export_formatHeader => 'FORMATO DE EXPORTACIÓN';

  @override
  String export_pdfPeriod(String range) {
    return 'Período: $range';
  }

  @override
  String export_pdfCurrency(String currency) {
    return 'Moneda: $currency';
  }

  @override
  String export_pdfGenerated(String date) {
    return 'Generado: $date';
  }

  @override
  String export_pdfPageOf(int page, int total) {
    return 'Página $page de $total';
  }

  @override
  String get export_pdfTotalAssets => 'Activos totales';

  @override
  String get export_pdfTotalLiabilities => 'Pasivos totales';

  @override
  String get export_pdfCurrentNetWorth => 'Patrimonio neto actual';

  @override
  String get export_pdfCategory => 'Categoría';

  @override
  String export_pdfAmountHeader(String currency) {
    return 'Monto ($currency)';
  }

  @override
  String get export_pdfPercentOfExpenses => '% del gasto total';

  @override
  String get backup_encryptedTitle => 'Copia cifrada';

  @override
  String get backup_encryptedPrompt =>
      'Ingresa la contraseña usada para cifrar esta copia:';

  @override
  String get backup_password => 'Contraseña';

  @override
  String get backup_confirmPassword => 'Confirmar contraseña';

  @override
  String get backup_decryptContinue => 'Descifrar y continuar';

  @override
  String get backup_chooseRestoreMode => 'Elegir modo de restauración';

  @override
  String get backup_chooseRestoreModeDesc =>
      'Elige si deseas restaurar toda la copia o solo datos específicos.';

  @override
  String get backup_selectiveRestore => 'Restauración selectiva';

  @override
  String get backup_selectiveRestoreDesc =>
      'Elige elementos específicos sin borrar tus demás datos.';

  @override
  String get backup_fullRestore => 'Restauración completa';

  @override
  String get backup_fullRestoreDesc =>
      'Reemplaza por completo todos los datos y ajustes actuales.';

  @override
  String get backup_selectiveBackup => 'Copia selectiva';

  @override
  String get backup_selectiveBackupBtn => 'Copia selectiva...';

  @override
  String get backup_selectiveBackupDesc =>
      'Elige las entidades de datos que deseas exportar a JSON.';

  @override
  String get backup_selectedRestoredSuccess =>
      '¡Datos seleccionados restaurados con éxito!';

  @override
  String get backup_savingsGoals => 'Metas de ahorro';

  @override
  String get backup_savingsContributions => 'Aportes a metas';

  @override
  String get backup_encryptionDisabled => 'Cifrado de copia desactivado';

  @override
  String get backup_encryptionEnabled => 'Cifrado de copia activado';

  @override
  String backup_encryptionFailed(String error) {
    return 'Error al activar cifrado: $error';
  }

  @override
  String get backup_encryptAutoTitle => 'Cifrar copias automáticas';

  @override
  String get backup_encryptAutoDesc =>
      'Protege tus copias con AES-GCM-256. Si olvidas la contraseña, no podrás restaurarlas.';

  @override
  String get backup_passwordEmpty => 'La contraseña no puede estar vacía';

  @override
  String get backup_passwordsMismatch => 'Las contraseñas no coinciden';

  @override
  String get backup_setPassword => 'Definir contraseña';

  @override
  String backup_autoCreated(String file) {
    return 'Copia automática creada: $file';
  }

  @override
  String backup_autoFailed(String error) {
    return 'Error en copia automática: $error';
  }

  @override
  String get backup_nightlySchedule =>
      'Cada noche ~2:00 AM en la carpeta elegida';

  @override
  String get backup_noFolderSelected => 'Ninguna carpeta seleccionada';

  @override
  String get backup_keepCopies => 'Conservar copias:';

  @override
  String get backup_encryptAes => 'Cifrar copia (AES-GCM)';

  @override
  String backup_failedError(String error) {
    return 'Error: $error';
  }

  @override
  String backup_lastSuccess(String date, String kb) {
    return 'Último: $date ($kb KB)';
  }

  @override
  String get backup_backingUp => 'Creando copia...';

  @override
  String get backup_backUpNow => 'Respaldar ahora';

  @override
  String get backup_androidIdleNote =>
      'Se ejecuta ~2:00 AM. Android puede retrasarlo en reposo.';

  @override
  String get backup_selectAll => 'Seleccionar todo';

  @override
  String get backup_deselectAll => 'Deseleccionar todo';

  @override
  String get backup_selectiveSaved => '¡Copia selectiva guardada!';

  @override
  String backup_exportFailed(String error) {
    return 'Error al exportar: $error';
  }

  @override
  String backup_exportSelected(int count) {
    return 'Exportar ($count) seleccionados';
  }

  @override
  String backup_restoreSelected(int count) {
    return 'Restaurar ($count) seleccionados';
  }

  @override
  String get backup_selectiveRestoreNote =>
      'Solo se restaurarán los elementos marcados. El resto permanecerá intacto.';

  @override
  String backup_countInBackup(int count) {
    return '$count en la copia';
  }

  @override
  String get backup_entityTxSplitsPresets =>
      'Transacciones, divisiones y atajos';

  @override
  String get backup_entityRecurringHistory => 'Pagos recurrentes e historial';

  @override
  String get backup_entityLoansPayments => 'Préstamos y pagos';

  @override
  String get backup_entityLentContacts => 'Dinero prestado y contactos';

  @override
  String get backup_entityAssetsValuables => 'Activos y bienes';

  @override
  String get backup_entityWishlistGoals => 'Lista de deseos y metas';

  @override
  String get common_perDay => '/ día';

  @override
  String common_daysShort(int count) {
    return '$count d';
  }

  @override
  String get common_splitCaps => 'DIVIDIDO';

  @override
  String budget_deletedCategory(String name) {
    return '$name eliminado';
  }

  @override
  String get loans_paymentDeleted => 'Pago eliminado';

  @override
  String certificates_collectionDayLabel(String frequency, int day) {
    return '$frequency (Día $day)';
  }

  @override
  String add_transaction_duplicateItem(
      String amount, String date, String desc) {
    return '• $amount el $date$desc';
  }

  @override
  String creditCard_billPaymentDesc(String name) {
    return 'Pago de tarjeta de crédito — $name';
  }

  @override
  String get onboarding_defaultBankName => 'Banco Principal';

  @override
  String get onboarding_defaultCardholder => 'MIEMBRO EXPENSY';

  @override
  String get onboarding_defaultUser => 'Usuario';

  @override
  String get export_excelSheetName => 'Transacciones';

  @override
  String get export_headerDate => 'Fecha';

  @override
  String get export_headerDescription => 'Descripción';

  @override
  String get export_headerType => 'Tipo';

  @override
  String get export_headerAmount => 'Monto';

  @override
  String get export_headerCurrency => 'Moneda';

  @override
  String get export_headerAccount => 'Cuenta';

  @override
  String get export_headerCategory => 'Categoría';

  @override
  String get export_headerSubcategory => 'Subcategoría';

  @override
  String get export_headerNote => 'Nota';

  @override
  String get cat_food_exp => 'Comida y Restaurantes';

  @override
  String get cat_transport => 'Transporte';

  @override
  String get cat_shopping => 'Compras';

  @override
  String get cat_bills => 'Facturas y Servicios';

  @override
  String get cat_health => 'Salud';

  @override
  String get cat_entertainment => 'Entretenimiento';

  @override
  String get cat_education => 'Educación';

  @override
  String get cat_personal => 'Cuidado Personal';

  @override
  String get cat_salary => 'Salario';

  @override
  String get cat_freelance => 'Freelance';

  @override
  String get cat_investments => 'Inversiones';

  @override
  String get cat_gifts => 'Regalos';

  @override
  String get cat_other_inc => 'Otros Ingresos';

  @override
  String get cat_other_exp => 'Otros Gastos';

  @override
  String get cat_sys_transfer => 'Transferencia';

  @override
  String get cat_sys_investment => 'Inversión';

  @override
  String get sub_groceries => 'Supermercado';

  @override
  String get sub_restaurants => 'Restaurantes';

  @override
  String get sub_delivery => 'Domicilio';

  @override
  String get sub_coffee_tea => 'Café y Té';

  @override
  String get sub_fuel => 'Combustible';

  @override
  String get sub_public_transit => 'Transporte Público';

  @override
  String get sub_taxi_ride => 'Taxi y Viajes';

  @override
  String get sub_maintenance => 'Mantenimiento';

  @override
  String get sub_parking_tolls => 'Estacionamiento y Peajes';

  @override
  String get sub_clothing => 'Ropa';

  @override
  String get sub_electronics => 'Electrónica';

  @override
  String get sub_home_furniture => 'Hogar y Muebles';

  @override
  String get sub_gifts => 'Regalos';

  @override
  String get sub_electricity => 'Electricidad';

  @override
  String get sub_internet => 'Internet';

  @override
  String get sub_water => 'Agua';

  @override
  String get sub_phone => 'Teléfono';

  @override
  String get sub_medicine => 'Medicinas';

  @override
  String get sub_doctor => 'Médico';

  @override
  String get sub_movies => 'Cine';

  @override
  String get sub_games => 'Juegos';

  @override
  String get sub_subscriptions => 'Suscripciones';

  @override
  String get notif_overBudgetTitle => '🚨 Presupuesto excedido';

  @override
  String notif_overBudgetBody(String category, String amount, String period) {
    return '$category — $amount por encima de tu límite $period';
  }

  @override
  String get notif_goalReachedTitle => '🎉 ¡Meta alcanzada!';

  @override
  String notif_goalReachedBody(String amount, String name) {
    return '¡Alcanzaste tu meta de $amount para $name!';
  }

  @override
  String get notif_certPayoutDueTitle =>
      '📈 Rendimiento de certificado vencido';

  @override
  String get notif_certPayoutUpcomingTitle =>
      '📈 Próximo rendimiento de certificado';

  @override
  String notif_certPayoutBody(String name) {
    return 'El rendimiento de $name vence hoy.';
  }

  @override
  String notif_certPayoutSoonBody(String name) {
    return 'El rendimiento de $name vence en 2 días.';
  }

  @override
  String get notif_creditBillDueTodayTitle => '💳 Factura vence hoy';

  @override
  String get notif_creditBillDueSoonTitle => '💳 Factura vence pronto';

  @override
  String get notif_dailyReminderTitle => '📝 Recordatorio diario';

  @override
  String get notif_dailyReminderBody =>
      'No olvides registrar tus gastos de hoy.';

  @override
  String notif_lendedDueTitle(String emoji, String name) {
    return '$emoji Vence: $name';
  }

  @override
  String get notif_loanPaymentDueTitle => '🏦 Cuota de préstamo vencida';

  @override
  String notif_loanPaymentDueBody(String name) {
    return 'La cuota de $name vence hoy.';
  }

  @override
  String get notif_autoBackupFailedTitle => 'Fallo de copia automática';

  @override
  String notif_autoBackupFailedBody(String error) {
    return 'Expensy no pudo crear tu copia programada: $error';
  }

  @override
  String notif_recurringTransferBody(String amount) {
    return 'Transferencia de $amount pendiente';
  }

  @override
  String notif_recurringIncomeBody(String amount) {
    return 'Ingreso de $amount pendiente';
  }

  @override
  String notif_recurringExpenseBody(String amount) {
    return 'Pago de $amount pendiente';
  }

  @override
  String notif_creditBillDueTodayBody(String name) {
    return 'Su factura de $name vence hoy.';
  }

  @override
  String notif_creditBillDueSoonBody(String name) {
    return 'Su factura de $name vence en 2 días.';
  }

  @override
  String notif_lendedLentDueBody(String amount, String name) {
    return '$amount que prestaste a $name vence hoy';
  }

  @override
  String notif_lendedBorrowedDueBody(String amount, String name) {
    return '$amount que pediste prestado a $name vence hoy';
  }

  @override
  String notif_recurringTransferDueSoonBody(String amount) {
    return 'Transferencia de $amount vence en 2 días';
  }

  @override
  String notif_recurringIncomeDueSoonBody(String amount) {
    return '$amount esperado en 2 días';
  }

  @override
  String notif_recurringExpenseDueSoonBody(String amount) {
    return '$amount vence en 2 días';
  }
}
