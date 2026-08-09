// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Caro';

  @override
  String get settings_title => 'Impostazioni';

  @override
  String get settings_appearance => 'Aspetto';

  @override
  String get settings_theme => 'Tema';

  @override
  String get settings_system => 'Sistema';

  @override
  String get settings_light => 'Chiaro';

  @override
  String get settings_dark => 'Scuro';

  @override
  String get settings_amoledTitle => 'Nero puro (AMOLED)';

  @override
  String get settings_amoledSubtitle =>
      'Forza gli sfondi neri in modalità oscura';

  @override
  String get settings_systemDefault => 'Predefinito di Sistema';

  @override
  String get settings_dynamicColor => 'Colore dinamico';

  @override
  String get settings_dynamicColorSubtitle =>
      'Usa i colori dello sfondo del sistema';

  @override
  String get settings_accentColor => 'Colore in risalto';

  @override
  String get settings_accentColorSubtitle => 'Scegli un colore seed per l\'app';

  @override
  String get settings_appFont => 'Carattere dell\'app';

  @override
  String get settings_currency => 'Valuta';

  @override
  String get settings_defaultCurrency => 'Valuta predefinita';

  @override
  String get settings_preferences => 'Preferenze';

  @override
  String get settings_weekStartsOn => 'La settimana inizia il';

  @override
  String get settings_monday => 'Lunedì';

  @override
  String get settings_sunday => 'Domenica';

  @override
  String get settings_hideBalance => 'Nascondi saldo';

  @override
  String get settings_hideBalanceSubtitle =>
      'Mostra ••••• invece degli importi';

  @override
  String get settings_language => 'Lingua';

  @override
  String get settings_profile => 'Profilo';

  @override
  String get settings_displayName => 'Nome visualizzato';

  @override
  String get settings_notSet => 'Non impostato';

  @override
  String get settings_about => 'Informazioni';

  @override
  String get settings_version => 'Versione';

  @override
  String get settings_privacy => 'Privacy';

  @override
  String get settings_privacySubtitle =>
      'Tutti i dati archiviati localmente: 100% offline';

  @override
  String get settings_github => 'GitHub';

  @override
  String get settings_githubSubtitle => 'Visualizza il codice sorgente';

  @override
  String get settings_developer => 'Sviluppatore';

  @override
  String get settings_developerSubtitle =>
      'Scopri altri progetti di Mina Android';

  @override
  String get settings_githubProfile => 'Profilo GitHub';

  @override
  String get settings_developerWebsite => 'Sito web dello sviluppatore';

  @override
  String get settings_close => 'Chiudi';

  @override
  String get settings_yourName => 'Il tuo nome';

  @override
  String get settings_cancel => 'Annulla';

  @override
  String get settings_save => 'Salva';

  @override
  String recurring_expenses(Object count) {
    return 'Spese ($count)';
  }

  @override
  String recurring_incomeList(Object count) {
    return 'Reddito ($count)';
  }

  @override
  String get recurring_monthly => 'Mensile';

  @override
  String get recurring_weekly => 'Settimanale';

  @override
  String get recurring_noRecurringExpenses => 'Nessuna spesa ricorrente';

  @override
  String get recurring_noRecurringIncome => 'Nessun reddito ricorrente';

  @override
  String get recurring_addExpense => 'Aggiungi spesa';

  @override
  String get recurring_addIncome => 'Aggiungi reddito';

  @override
  String get recurring_tapPlusToAddOne => 'Tocca + per aggiungerne uno';

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
  String get recurring_overdue => 'In ritardo!';

  @override
  String get recurring_dueToday => 'Scadenza oggi';

  @override
  String recurring_dueInDays(Object days) {
    return 'Due in ${days}d';
  }

  @override
  String get recurring_edit => 'Modifica';

  @override
  String get recurring_skipBtn => 'Salta';

  @override
  String recurring_nextDate(Object date) {
    return 'Next: $date';
  }

  @override
  String get recurring_pay => 'Paga';

  @override
  String get recurring_del => 'Del';

  @override
  String recurring_historyCount(Object count) {
    return 'Cronologia ($count)';
  }

  @override
  String get recurring_paymentHistory => 'Cronologia dei pagamenti';

  @override
  String get recurring_notificationPermissionDenied =>
      'Autorizzazione di notifica negata. Abilitalo in Impostazioni → App → Costose → Notifiche.';

  @override
  String get recurring_remindMeAt => 'Ricordamelo a';

  @override
  String get recurring_editRecurring => 'Modifica Ricorrente';

  @override
  String get recurring_addRecurring => 'Aggiungi un pagamento ricorrente';

  @override
  String get recurring_name => 'Nome';

  @override
  String get recurring_amountPerPayment => 'Importo per pagamento';

  @override
  String recurring_firstDate(Object date) {
    return 'First: $date';
  }

  @override
  String recurring_lastDate(Object date) {
    return 'Last: $date';
  }

  @override
  String get recurring_noLastPaymentOngoing =>
      'Nessun ultimo pagamento (in corso)';

  @override
  String get accounts_refreshExchangeRates => 'Aggiorna tassi di cambio';

  @override
  String get accounts_noAccounts => 'Nessun account';

  @override
  String get accounts_tapPlusToAddYourFirst =>
      'Tocca + per aggiungere il tuo primo account';

  @override
  String get accounts_fetchingExchangeRates => 'Recupero tassi di cambio…';

  @override
  String get accounts_exchangeRatesUnavailable =>
      'Tassi di cambio non disponibili (offline). Saldi indicati nella valuta nativa.';

  @override
  String get accounts_unknown => 'Sconosciuto';

  @override
  String accounts_ratesUpdated(Object timeStr) {
    return 'Tariffe aggiornate $timeStr · Tocca ↺ per aggiornare';
  }

  @override
  String get accounts_goldCaps => 'ORO';

  @override
  String get accounts_balance => 'Saldo';

  @override
  String get accounts_income => 'Reddito';

  @override
  String get accounts_expense => 'Spesa';

  @override
  String get accounts_txs => 'Tx';

  @override
  String get accounts_value => 'Valore';

  @override
  String get accounts_karat => 'Carato';

  @override
  String accounts_pure(Object percentage) {
    return '$percentage% pure';
  }

  @override
  String get accounts_weightLabel => 'Peso';

  @override
  String get accounts_perGram => 'Al grammo';

  @override
  String get accounts_bank => 'Banca';

  @override
  String get accounts_cash => 'Contanti';

  @override
  String get accounts_savings => 'Risparmio';

  @override
  String get accounts_creditCard => 'Carta di credito';

  @override
  String get accounts_eWallet => 'Portafoglio elettronico';

  @override
  String get accounts_gold => 'Oro';

  @override
  String get accounts_editAccount => 'Modifica account';

  @override
  String get accounts_addAccount => 'Aggiungi nuovo account';

  @override
  String get accounts_accountName => 'Nome account';

  @override
  String get accounts_weightInGrams => 'Peso in grammi';

  @override
  String get accounts_initialBalance => 'Saldo iniziale';

  @override
  String get accounts_wontCountTowardYourHome =>
      'Non verrà conteggiato nel totale della schermata iniziale';

  @override
  String get accounts_saveChanges => 'Salva modifiche';

  @override
  String get accounts_addAccountBtn => 'Aggiungi account';

  @override
  String get accounts_fetchingGoldPrice => 'Recupero del prezzo dell\'oro…';

  @override
  String get accounts_goldPriceUnavailable =>
      'Prezzo dell\'oro non disponibile: controlla la connessione';

  @override
  String lended_person_owesYou(Object name) {
    return '$name owes you';
  }

  @override
  String lended_person_youOwe(Object name) {
    return 'You owe $name';
  }

  @override
  String get lended_person_allSettledUp => 'Tutto sistemato';

  @override
  String get lended_person_noRecordsYet => 'Ancora nessun record';

  @override
  String get lended_person_tapPlusToLog =>
      'Tocca + per registrare il denaro prestato o preso in prestito';

  @override
  String get lended_person_name => 'Nome';

  @override
  String get lended_person_notesOptional => 'Note (facoltativo)';

  @override
  String get lended_person_lent => 'Quaresima';

  @override
  String get lended_person_borrowed => 'In prestito';

  @override
  String get lended_person_overdue => 'In ritardo!';

  @override
  String lended_person_due(Object date) {
    return 'Due $date';
  }

  @override
  String lended_person_reminderAt(Object time) {
    return 'Promemoria alle $time';
  }

  @override
  String get lended_person_notificationPermissionDenied =>
      'Autorizzazione di notifica negata. Abilitalo in Impostazioni → App → Costose → Notifiche.';

  @override
  String get lended_person_remindMeAtPrompt => 'Ricordamelo a';

  @override
  String get lended_person_editRecord => 'Modifica record';

  @override
  String get lended_person_addRecord => 'Aggiungi record';

  @override
  String get lended_person_amount => 'Quantità';

  @override
  String lended_person_dueColon(Object date) {
    return 'Due: $date';
  }

  @override
  String get lended_person_noDueDate => 'Nessuna data di scadenza';

  @override
  String get lended_person_setDueFirst => 'Imposta prima una data di scadenza';

  @override
  String get lended_person_notifiedOnDue =>
      'Riceverai una notifica alla data di scadenza';

  @override
  String get lended_person_getNotifiedWhenDue =>
      'Ricevi una notifica quando è dovuto';

  @override
  String get lended_person_thatTimePassed =>
      'Oggi quel momento è già passato: riceverai invece una notifica a breve.';

  @override
  String lended_person_notificationFiresOn(Object date, Object time) {
    return 'La notifica viene attivata il $date alle $time.';
  }

  @override
  String get lended_person_saveChangesBtn => 'Salva modifiche';

  @override
  String get lended_person_addRecordBtn => 'Aggiungi record';

  @override
  String get transactions_searchTransactions => 'Cerca transazioni...';

  @override
  String get transactions_all => 'Tutti';

  @override
  String get transactions_income => 'Reddito';

  @override
  String get transactions_expenses => 'Spese';

  @override
  String get transactions_lent => 'Quaresima';

  @override
  String get transactions_borrowed => 'In prestito';

  @override
  String get transactions_noTransactions => 'Nessuna transazione';

  @override
  String get transactions_tapPlusToAddOne => 'Tocca + per aggiungerne uno';

  @override
  String get transactions_today => 'Oggi';

  @override
  String get transactions_yesterday => 'Ieri';

  @override
  String transactions_lentTo(Object name) {
    return 'Lent to $name';
  }

  @override
  String transactions_borrowedFrom(Object name) {
    return 'Borrowed from $name';
  }

  @override
  String get transactions_unknown => 'Sconosciuto';

  @override
  String transactions_due(Object date) {
    return 'Due $date';
  }

  @override
  String get transactions_unsettled => 'Instabile';

  @override
  String get onboarding_restoreFailed =>
      'Ripristino non riuscito: il file potrebbe essere danneggiato o non essere un backup Expensy.';

  @override
  String get onboarding_continue => 'Continua';

  @override
  String get onboarding_getStarted => 'Inizia';

  @override
  String get onboarding_yourPersonalTracker =>
      'Il tuo tracker finanziario personale, offline al 100%.\nHai già un backup da un altro dispositivo o da un\'installazione precedente?';

  @override
  String get onboarding_restoring => 'Ripristino...';

  @override
  String get onboarding_chooseBackupFile => 'Scegli File di backup';

  @override
  String get onboarding_letsGetYouSetUp => 'Iniziamo la configurazione';

  @override
  String get onboarding_yourName => 'Il tuo nome';

  @override
  String get onboarding_accountName => 'Nome account';

  @override
  String get onboarding_bank => 'Banca';

  @override
  String get onboarding_cash => 'Contanti';

  @override
  String get onboarding_savings => 'Risparmio';

  @override
  String get onboarding_credit => 'Credito';

  @override
  String get onboarding_wallet => 'Portafoglio';

  @override
  String get onboarding_startingBalance => 'Saldo iniziale';

  @override
  String get backup_replaceDataWarning =>
      'Questo sostituirà TUTTI i tuoi dati attuali con il backup.\nQuesta operazione non può essere annullata.';

  @override
  String get backup_whatsIncluded => 'Cosa è incluso';

  @override
  String get backup_backupDescription =>
      'Ogni backup include tutti i tuoi dati: account, transazioni, pagamenti ricorrenti e la relativa cronologia di pagamenti/salti, budget, elementi della lista dei desideri, persone e record prestati e presi in prestito, risorse, categorie e impostazioni dell\'app.';

  @override
  String get backup_saving => 'Salvataggio in corso...';

  @override
  String get backup_saveBackup => 'Salva backup';

  @override
  String get backup_restoring => 'Ripristino...';

  @override
  String get backup_restoreBackupBtn => 'Ripristina backup';

  @override
  String get backup_restoreWarningText =>
      'Compatibile con i backup di qualsiasi versione dell\'app. I campi mancanti sono riempiti con valori predefiniti sicuri.';

  @override
  String get backup_included => 'incluso';

  @override
  String get backup_accounts => 'Conti';

  @override
  String get backup_transactions => 'Transazioni';

  @override
  String get backup_recurringPayments => 'Pagamenti ricorrenti';

  @override
  String get backup_recurringHistory => 'Storia ricorrente';

  @override
  String get backup_budgets => 'Budget';

  @override
  String get backup_wishlist => 'Lista dei desideri';

  @override
  String get backup_lentPeople => 'Prestato/Preso in prestito — Persone';

  @override
  String get backup_lentRecords => 'Prestato/Preso in prestito — Documenti';

  @override
  String get backup_assets => 'Patrimonio';

  @override
  String get backup_categories => 'Categorie';

  @override
  String get backup_settings => 'Impostazioni';

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
    return '(aggiornato da v$originalVersion → v$schemaVersion)';
  }

  @override
  String backup_dataRestoredSuccessfully(Object vLabel) {
    return 'Dati ripristinati con successo!$vLabel';
  }

  @override
  String backup_restoreFailed(Object error) {
    return 'Restore failed: $error';
  }

  @override
  String get backup_restoreFailedCorrupted =>
      'Ripristino non riuscito: il file potrebbe essere danneggiato o non essere un backup Expensy.';

  @override
  String get budget_noBudgetsYet => 'Nessun budget ancora';

  @override
  String get budget_tapToAddBudget =>
      'Tocca + per impostare un limite di spesa per categoria';

  @override
  String get budget_budgeted => 'Budget';

  @override
  String get budget_leftToSpend => 'Left to Spend';

  @override
  String get budget_spent => 'Speso';

  @override
  String get budget_overLimit => 'Oltre il limite';

  @override
  String get budget_unknown => 'Sconosciuto';

  @override
  String get budget_weeklyLabel => 'Settimanale';

  @override
  String get budget_monthlyLabel => 'Mensile';

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
    return '$percent% utilizzato';
  }

  @override
  String get budget_editBudget => 'Modifica budget';

  @override
  String get budget_setBudget => 'Aggiungi nuovo budget';

  @override
  String get budget_budgetAmount => 'Importo del bilancio';

  @override
  String budget_previewFor(Object catName) {
    return 'Anteprima per \\\"$catName\\\"';
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
  String get budget_saveChanges => 'Salva modifiche';

  @override
  String get budget_budget => 'Bilancio';

  @override
  String get insights_other => 'Altro';

  @override
  String get insights_noDataYet => 'Nessun dato ancora';

  @override
  String get insights_addSomeTransactions =>
      'Aggiungi alcune transazioni per visualizzare gli approfondimenti';

  @override
  String get insights_thisMonthVsLastMonth =>
      'Questo mese contro il mese scorso';

  @override
  String get insights_dailyAverage => 'Media giornaliera';

  @override
  String insights_perDayBasedOn(Object days) {
    return 'al giorno · in base a $days giorni di questo mese';
  }

  @override
  String get insights_incomeVsExpenses => 'Entrate vs uscite';

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
    return '$percent% risparmiato questo mese';
  }

  @override
  String get insights_topSpendingCategories => 'Principali categorie di spesa';

  @override
  String insights_percentOfTotal(Object percent) {
    return '$percent% del totale';
  }

  @override
  String get insights_biggestExpenseThisMonth =>
      'La spesa più grande di questo mese';

  @override
  String get insights_categoryTrends =>
      'Tendenze delle categorie (rispetto al mese scorso)';

  @override
  String get insights_12MonthTrend => 'Tendenza su 12 mesi';

  @override
  String get insights_incomeLabel => 'Reddito';

  @override
  String get insights_expensesLabel => 'Spese';

  @override
  String get categories_expenseLabel => 'Spesa';

  @override
  String get categories_incomeLabel => 'Reddito';

  @override
  String get categories_editCategory => 'Modifica categoria';

  @override
  String get categories_addCategory => 'Aggiungi categoria';

  @override
  String get categories_categoryName => 'Nome della categoria';

  @override
  String get categories_saveChanges => 'Salva modifiche';

  @override
  String get statistics_other => 'Altro';

  @override
  String get statistics_allAccounts => 'Tutti gli account';

  @override
  String get statistics_income => 'Reddito';

  @override
  String get statistics_expenses => 'Spese';

  @override
  String get statistics_expense => 'Spesa';

  @override
  String get statistics_net => 'Netto';

  @override
  String statistics_6MonthOverviewAccount(Object accountName) {
    return 'Panoramica di 6 mesi · $accountName';
  }

  @override
  String get statistics_6MonthOverview => 'Panoramica di 6 mesi';

  @override
  String statistics_percentOfBudget(Object percent) {
    return '$percent% del budget';
  }

  @override
  String get add_transaction_editTransaction => 'Modifica transazione';

  @override
  String get add_transaction_addTransaction => 'Inserisci la transazione';

  @override
  String get add_transaction_amount => 'Importo';

  @override
  String add_transaction_conversionPreview(Object accountName, Object amount) {
    return '≈ $amount will be deducted from $accountName';
  }

  @override
  String get add_transaction_accountFallback => 'conto';

  @override
  String get add_transaction_descriptionOptional => 'Descrizione (facoltativa)';

  @override
  String get add_transaction_noteOptional => 'Nota (facoltativa)';

  @override
  String get add_transaction_saveChanges => 'Salva modifiche';

  @override
  String get more_statistics => 'Statistiche';

  @override
  String get more_statisticsSub => 'Grafici e riepilogo mensile';

  @override
  String get more_insights => 'Approfondimenti';

  @override
  String get more_insightsSub => 'Tendenze, medie e analisi di categoria';

  @override
  String get more_currencyConverter => 'Convertitore di valuta';

  @override
  String get more_currencyConverterSub => 'Converti istantaneamente tra valute';

  @override
  String get more_wishlist => 'Lista dei desideri';

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
  String get more_lentMoney => 'Soldi prestati';

  @override
  String more_lentMoneySub(Object count) {
    return '$count in sospeso';
  }

  @override
  String get more_assets => 'Patrimonio';

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
  String get more_categories => 'Categorie';

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
  String get more_exportTransactions => 'Transazioni di esportazione';

  @override
  String get more_exportTransactionsSub => 'Salva come Excel (.xlsx)';

  @override
  String get more_backupRestore => 'Backup e ripristino';

  @override
  String get more_backupRestoreSub => 'Salva o carica i tuoi dati';

  @override
  String get more_settings => 'Impostazioni';

  @override
  String get more_settingsSub => 'Tema, valuta e preferenze';

  @override
  String home_greeting(Object name) {
    return 'Hi, $name 👋';
  }

  @override
  String get home_there => 'lì';

  @override
  String get home_income => 'Reddito';

  @override
  String get home_expenses => 'Spese';

  @override
  String get home_net => 'Netto';

  @override
  String get wishlist_noItems => 'Nessun articolo nella lista dei desideri';

  @override
  String get wishlist_noItemsSub =>
      'Tocca + per aggiungere gli elementi che stai salvando per';

  @override
  String get wishlist_editItem => 'Modifica elemento';

  @override
  String get wishlist_addWishlistItem =>
      'Aggiungi articolo alla lista dei desideri';

  @override
  String get wishlist_itemName => 'Nome elemento';

  @override
  String get wishlist_targetPrice => 'Prezzo indicativo';

  @override
  String get wishlist_priorityLow => 'Basso';

  @override
  String get wishlist_priorityMedium => 'Medio';

  @override
  String get wishlist_priorityHigh => 'Alto';

  @override
  String get wishlist_notesOptional => 'Note (facoltativo)';

  @override
  String get wishlist_saveChanges => 'Salva modifiche';

  @override
  String get wishlist_addItem => 'Aggiungi elemento';

  @override
  String get lended_theyOweMe => 'Sono in debito con me';

  @override
  String get lended_iOweThem => 'Glielo devo';

  @override
  String get lended_net => 'Netto';

  @override
  String get lended_noOneYet => 'Ancora nessuno';

  @override
  String get lended_noOneYetSub =>
      'Tocca + per aggiungere una persona a cui fai o da cui prendi in prestito';

  @override
  String get lended_owesYou => 'Ti devo';

  @override
  String get lended_youOwe => 'Sei in debito con';

  @override
  String get lended_settledUp => 'Sistemato';

  @override
  String get lended_noActiveRecords => 'Nessun record attivo';

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
  String get lended_editPerson => 'Modifica persona';

  @override
  String get lended_addPerson => 'Aggiungi persona';

  @override
  String get lended_name => 'Nome';

  @override
  String get lended_notesOptional => 'Note (facoltativo)';

  @override
  String get lended_saveChanges => 'Salva modifiche';

  @override
  String get assets_totalAssets => 'Totale attivo';

  @override
  String get assets_items => 'Elementi';

  @override
  String get assets_noAssetsYet => 'Ancora nessuna risorsa';

  @override
  String get assets_noAssetsYetSub =>
      'Tocca + per aggiungere un prodotto o una risorsa';

  @override
  String get assets_editAsset => 'Modifica risorsa';

  @override
  String get assets_addAsset => 'Aggiungi risorsa';

  @override
  String get assets_productAssetName => 'Nome prodotto/risorsa';

  @override
  String get assets_value => 'Valore';

  @override
  String get assets_notesOptional => 'Note (facoltativo)';

  @override
  String get assets_saveChanges => 'Salva modifiche';

  @override
  String get currency_converter_loadingRates => 'Caricamento tassi di cambio…';

  @override
  String get currency_converter_ratesUnavailable =>
      'Tassi di cambio non disponibili. Connettiti a Internet e sincronizza.';

  @override
  String get currency_converter_rateAgeJustNow => 'Proprio adesso';

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
    return 'Conversioni comuni da $fromCurrency';
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
      'Tassi di cambio non caricati: l\'importo verrà trasferito così com\'è';

  @override
  String get transfer_amount => 'Importo';

  @override
  String get transfer_noteOptional => 'Nota (facoltativa)';

  @override
  String get export_from => 'Da';

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
    return 'Saved: $path';
  }

  @override
  String get export_complete => 'Esportazione completata';

  @override
  String get export_exporting => 'Esportazione...';

  @override
  String get export_exportAsExcel => 'Esporta come Excel';

  @override
  String shared_widgets_deleteConfirm(Object name) {
    return 'Delete \"$name\"? This cannot be undone.';
  }

  @override
  String get shared_widgets_searchByCode => 'Cerca per codice o nome...';

  @override
  String get accounts_accounts => 'Conti';

  @override
  String get accounts_totalBalance => 'Saldo Totale';

  @override
  String get accounts_excluded => 'Escluso';

  @override
  String get accounts_goldPriceNotYetLoade =>
      'Prezzo dell\'oro non ancora caricato. Attendi un momento e riprova.';

  @override
  String get accounts_accountType => 'Tipo di Conto';

  @override
  String get accounts_currency => 'Valuta';

  @override
  String get accounts_goldPurityKarat => 'Purezza Oro (Carati)';

  @override
  String get accounts_weight => 'Peso';

  @override
  String get accounts_excludeFromTotalBala => 'Escludi dal Saldo Totale';

  @override
  String get accounts_color => 'Colore';

  @override
  String get accounts_liveGoldValue => 'Valore dell\'Oro in Tempo Reale';

  @override
  String get accounts_enterWeightAboveToSe =>
      'Inserisci il peso sopra per vedere il valore';

  @override
  String get add_transaction_expense => 'Spesa';

  @override
  String get add_transaction_income => 'Entrata';

  @override
  String get add_transaction_account => 'Conto';

  @override
  String get add_transaction_category => 'Categoria';

  @override
  String get assets_assets => 'Asset';

  @override
  String get backup_restoreBackup => 'Ripristinare il backup?';

  @override
  String get backup_cancel => 'Annulla';

  @override
  String get backup_replaceData => 'Sostituisci Dati';

  @override
  String get backup_backupRestore => 'Backup e Ripristino';

  @override
  String get backup_everythingAlways => 'Tutto, sempre';

  @override
  String get backup_createBackup => 'Crea Backup';

  @override
  String get backup_saveAsJson => 'Salva come JSON';

  @override
  String get backup_exportsAllAppDataToA =>
      'Esporta TUTTI i dati dell\'app in un file portatile';

  @override
  String get backup_restoreBackup_ => 'Ripristina Backup';

  @override
  String get backup_loadFromJson => 'Carica da JSON';

  @override
  String get backup_picksABackupFileAndR =>
      'Sceglie un file di backup e lo ripristina';

  @override
  String get backup_thisOverwritesAllCur =>
      'Questo sovrascriverà TUTTI i dati attuali.';

  @override
  String get budget_budgets => 'Budget';

  @override
  String get budget_empty => '·';

  @override
  String get budget_overBudget => 'Fuori budget';

  @override
  String get budget_thisCategoryAlreadyH =>
      'Questa categoria ha già un budget. Tocca per modificare.';

  @override
  String get budget_period => 'Periodo';

  @override
  String get budget_monthly => 'Mensile';

  @override
  String get budget_weekly => 'Settimanale';

  @override
  String get budget_category => 'Categoria';

  @override
  String get categories_categories => 'Categorie';

  @override
  String get categories_expense => 'Spesa';

  @override
  String get categories_income => 'Entrata';

  @override
  String get categories_color => 'Colore';

  @override
  String get categories_icon => 'Icona';

  @override
  String get categories_autoBasedOnName => 'Auto (basato sul nome)';

  @override
  String get categories_expenseCategories => 'Categorie Spese';

  @override
  String get categories_incomeCategories => 'Categorie Entrate';

  @override
  String get currency_converter_currencyConverter => 'Convertitore di Valute';

  @override
  String get currency_converter_amount => 'Importo';

  @override
  String get currency_converter_convertedTo => 'Convertito in';

  @override
  String get export_exportTransactions => 'Esporta Transazioni';

  @override
  String get export_dateRange => 'Intervallo di Date';

  @override
  String get export_formatExcelXlsx => 'Formato: Excel (.xlsx)';

  @override
  String get home_totalBalance => 'Saldo Totale';

  @override
  String get home_accounts => 'Conti';

  @override
  String get home_recentTransactions => 'Transazioni Recenti';

  @override
  String get home_noTransactionsYet => 'Ancora nessuna transazione';

  @override
  String get home_add => 'Aggiungi';

  @override
  String get insights_insights => 'Statistiche Dettagliate';

  @override
  String get lended_person_deletePerson => 'Elimina persona';

  @override
  String get lended_person_editPerson => 'Modifica Persona';

  @override
  String get lended_person_color => 'Colore';

  @override
  String get lended_person_saveChanges => 'Salva Modifiche';

  @override
  String get lended_person_settled => 'SALDATO';

  @override
  String get lended_person_settle => 'Salda';

  @override
  String get lended_person_setADueDateFirstToEn =>
      'Imposta prima una data di scadenza per attivare i promemoria.';

  @override
  String get lended_person_iLent => 'Ho Prestato';

  @override
  String get lended_person_iBorrowed => 'Ho Preso in Prestito';

  @override
  String get lended_person_accountOptional => 'Conto (opzionale)';

  @override
  String get lended_person_dueDateReminder => 'Promemoria Scadenza';

  @override
  String get lended_person_remindMeAt => 'Ricordamelo alle';

  @override
  String get lended_person_active => 'Attivo';

  @override
  String get lended_person_settled_ => 'Saldato';

  @override
  String get lended_lentMoney => 'Denaro Prestato';

  @override
  String get lended_overdue => 'IN RITARDO';

  @override
  String get lended_color => 'Colore';

  @override
  String get more_more => 'Altro';

  @override
  String get onboarding_back => 'Indietro';

  @override
  String get onboarding_welcomeToExpensy => 'Benvenuto in Expensy!';

  @override
  String get onboarding_restoreABackup => 'Ripristina un Backup';

  @override
  String get onboarding_loadAPreviouslySaved =>
      'Carica un file JSON Expensy salvato in precedenza';

  @override
  String get onboarding_or => 'oppure';

  @override
  String get onboarding_startFresh => 'Inizia da Zero';

  @override
  String get onboarding_firstWhatShouldWeCal =>
      'Per prima cosa, come dovremmo chiamarti?';

  @override
  String get onboarding_defaultCurrency => 'Valuta Predefinita';

  @override
  String get onboarding_thisWillBeUsedAcross =>
      'Verrà utilizzata in tutta l\'app.\nPuoi cambiarla in seguito nelle Impostazioni.';

  @override
  String get onboarding_searchAllCurrencies => 'Cerca tutte le valute';

  @override
  String get onboarding_yourFirstAccount => 'Il Tuo Primo Conto';

  @override
  String get onboarding_setUpYourMainAccount =>
      'Imposta il tuo conto principale per iniziare a monitorare.';

  @override
  String get onboarding_accountType => 'Tipo di Conto';

  @override
  String get onboarding_currency => 'Valuta';

  @override
  String get onboarding_color => 'Colore';

  @override
  String get recurring_recurring => 'Ricorrente';

  @override
  String get recurring_income => 'ENTRATA';

  @override
  String get recurring_2D => '−2g';

  @override
  String get recurring_skipNextPayment => 'Saltare il prossimo pagamento?';

  @override
  String get recurring_cancel => 'Annulla';

  @override
  String get recurring_skip => 'Salta';

  @override
  String get recurring_noHistoryYet => 'Ancora nessuna cronologia';

  @override
  String get recurring_expense => 'Spesa';

  @override
  String get recurring_income_ => 'Entrata';

  @override
  String get recurring_every => 'Ogni ';

  @override
  String get recurring_days => 'Giorni';

  @override
  String get recurring_weeks => 'Settimane';

  @override
  String get recurring_months => 'Mesi';

  @override
  String get recurring_years => 'Anni';

  @override
  String get recurring_payments => 'Pagamenti';

  @override
  String get recurring_totalCost => 'Costo Totale';

  @override
  String get recurring_account => 'Conto';

  @override
  String get recurring_category => 'Categoria';

  @override
  String get recurring_paymentReminder => 'Promemoria di Pagamento';

  @override
  String get recurring_notificationWillFire =>
      'La notifica scatterà alla prossima data di scadenza a quest\'ora.';

  @override
  String get recurring_remind2DaysBefore => 'Ricorda 2 giorni prima';

  @override
  String get statistics_statistics => 'Statistiche';

  @override
  String get statistics_expensesByCategory => 'Spese per Categoria';

  @override
  String get transactions_transactions => 'Transazioni';

  @override
  String get transactions_settled => 'Saldato';

  @override
  String get transfer_transfer => 'Trasferimento';

  @override
  String get transfer_from => 'DA';

  @override
  String get transfer_to => 'A';

  @override
  String get transfer_enterAnAmountToSeeTh =>
      'Inserisci un importo per vedere la conversione';

  @override
  String get wishlist_wishlist => 'Lista dei Desideri';

  @override
  String get wishlist_priority => 'Priorità';

  @override
  String get shared_widgets_delete => 'Eliminare?';

  @override
  String get shared_widgets_cancel => 'Annulla';

  @override
  String get shared_widgets_delete_ => 'Elimina';

  @override
  String get shared_widgets_none => 'Nessuno';

  @override
  String get shared_widgets_selectCurrency => 'Seleziona Valuta';

  @override
  String get main_home => 'Inizio';

  @override
  String get main_transactions => 'Transazioni';

  @override
  String get main_recurring => 'Ricorrente';

  @override
  String get main_accounts => 'Conti';

  @override
  String get main_budgets => 'Budget';

  @override
  String get main_more => 'Altro';

  @override
  String get onboarding_chooseLanguage => 'Scegli la lingua';

  @override
  String get error_required => 'Questo campo è obbligatorio';

  @override
  String recurring_subscriptions(Object count) {
    return 'Abbonamenti ($count)';
  }

  @override
  String recurring_installments(Object count) {
    return 'Rate ($count)';
  }

  @override
  String get recurring_recurringType => 'Tipo ricorrente';

  @override
  String get recurring_subscription => 'Sottoscrizione';

  @override
  String get recurring_installment => 'Rata';

  @override
  String get recurring_installmentsRequireEndDate =>
      'Le rate devono avere una data di pagamento finale.';

  @override
  String get backup_importFromOtherApps => 'Importa da altre app';

  @override
  String get backup_importDescription => 'Importa dati dalle app supportate';

  @override
  String get backup_importFromGreenStash => 'Importa da GreenStash (.json)';

  @override
  String get backup_automaticBackup => 'Backup automatico';

  @override
  String get backup_dailyAutoBackup => 'Backup automatico giornaliero';

  @override
  String backup_runsDailyAt(String time) {
    return 'Viene eseguito ogni giorno alle $time';
  }

  @override
  String backup_lastBackup(String time) {
    return 'Ultimo backup: $time';
  }

  @override
  String backup_savingTo(String path) {
    return 'Saving to: $path';
  }

  @override
  String get backup_changeTime => 'Cambia orario';

  @override
  String get backup_changeFolder => 'Cambia cartella';

  @override
  String get budget_budgetsAndGoals => 'Budget e obiettivi';

  @override
  String get onboarding_restoreGreenStash => 'Ripristina da GreenStash (.json)';

  @override
  String get savings_goalNotFound => 'Obiettivo non trovato';

  @override
  String get savings_savedSoFar => 'Salvato finora';

  @override
  String get savings_target => 'Obiettivo';

  @override
  String savings_targetDate(String date) {
    return 'Target Date: $date';
  }

  @override
  String get savings_contribute => 'Contribuisci';

  @override
  String get savings_withdraw => 'Ritiro';

  @override
  String get savings_noAccounts =>
      'Nessun account disponibile. Aggiungi prima un account.';

  @override
  String get settings_budgetAlerts => 'Avvisi sul budget';

  @override
  String get settings_budgetAlertsSub =>
      'Avvisa quando viene raggiunto un budget o un obiettivo';

  @override
  String get settings_dailyReminder => 'Promemoria quotidiano';

  @override
  String get settings_dailyReminderSub =>
      'Ricorda di registrare le transazioni ogni giorno';

  @override
  String get settings_reminderTime => 'Orario del promemoria';

  @override
  String get settings_hapticFeedback => 'Feedback tattile';

  @override
  String get settings_hapticFeedbackSub => 'Vibra nelle interazioni';

  @override
  String get savings_saveGoal => 'Salva obiettivo';
}
