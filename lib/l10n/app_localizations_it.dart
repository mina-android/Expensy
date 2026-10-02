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
  String get budget_leftToSpend => 'Rimanente da spendere';

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
  String get budget_rollover => 'Riporto (Busta)';

  @override
  String get budget_rolloverDesc =>
      'Riporta le eccedenze o i disavanzi inutilizzati al periodo successivo';

  @override
  String get budget_rolloverBadge => 'Riporto';

  @override
  String budget_base(Object amount) {
    return 'Base: $amount';
  }

  @override
  String budget_rolloverFrom(Object period, Object amount) {
    return 'Riporto ($period): $amount';
  }

  @override
  String budget_totalAvailable(Object amount) {
    return 'Totale disponibile: $amount';
  }

  @override
  String get budget_lastWeek => 'Settimana scorsa';

  @override
  String get pacing_dailyBudget => 'Spesa sicura';

  @override
  String pacing_safeToSpend(Object amount, Object days) {
    return 'Spesa sicura: $amount/giorno ($days giorni rimasti)';
  }

  @override
  String pacing_caution(Object amount) {
    return 'Ritmo elevato — limita a $amount/giorno';
  }

  @override
  String get pacing_overPaced =>
      'Avviso ritmo — rallenta per rispettare il budget';

  @override
  String get pacing_budgetExhausted =>
      'Budget raggiunto — nessun margine giornaliero rimasto';

  @override
  String get pacing_onTrack => 'In linea';

  @override
  String get pacing_fast => 'Ritmo elevato';

  @override
  String get pacing_alert => 'Avviso ritmo';

  @override
  String pacing_daysLeft(Object days) {
    return '$days giorni rimasti';
  }

  @override
  String get pacing_setBudgetPrompt =>
      'Tocca per impostare i limiti di budget →';

  @override
  String get pacing_dailyAvgPace => 'Ritmo giornaliero';

  @override
  String pacing_perDay(Object amount) {
    return '$amount / giorno';
  }

  @override
  String get calendar_title => 'Calendario finanziario';

  @override
  String get calendar_subtitle => 'Mappa termica delle spese e scadenze';

  @override
  String calendar_zeroSpendDays(Object count) {
    return '$count giorni senza spese';
  }

  @override
  String get calendar_zeroSpendDayTitle => 'Giorno a zero spese! 🎉';

  @override
  String get calendar_zeroSpendDayDesc =>
      'Ottima disciplina finanziaria senza spese per oggi.';

  @override
  String get calendar_billsDue => 'Bollette e abbonamenti in scadenza';

  @override
  String get calendar_loansDue => 'Rate del prestito in scadenza';

  @override
  String get calendar_lendedDue => 'Rimborsi attesi';

  @override
  String calendar_dayTransactions(Object count) {
    return 'Transazioni ($count)';
  }

  @override
  String get calendar_noActivity =>
      'Nessuna transazione o impegno per questa data';

  @override
  String get calendar_today => 'Oggi';

  @override
  String calendar_averageDaily(Object amount) {
    return 'Media giornaliera: $amount';
  }

  @override
  String get wrapped_title => 'Expensy Wrapped';

  @override
  String wrapped_bannerTitle(Object month) {
    return 'Il tuo riepilogo di $month è pronto!';
  }

  @override
  String get wrapped_bannerSub =>
      'Tocca per esplorare la tua storia finanziaria mensile';

  @override
  String get wrapped_theBigPicture => 'Il quadro generale';

  @override
  String wrapped_howMoneyMoved(Object month) {
    return 'Ecco come si è mosso il tuo denaro a $month';
  }

  @override
  String get wrapped_totalInflow => 'Entrate totali';

  @override
  String get wrapped_totalOutflow => 'Uscite totali';

  @override
  String get wrapped_netSavings => 'Risparmio netto';

  @override
  String wrapped_savingsRate(Object rate) {
    return 'Tasso di risparmio: $rate%';
  }

  @override
  String get wrapped_topCategoryTitle => 'Dove sono finiti?';

  @override
  String wrapped_topCategorySub(Object category) {
    return 'La tua categoria di spesa principale è stata $category';
  }

  @override
  String wrapped_topCategoryShare(Object percent) {
    return '$percent% della tua spesa totale';
  }

  @override
  String get wrapped_biggestSplurgeTitle => 'Spesa più grande';

  @override
  String get wrapped_biggestSplurgeSub => 'La tua spesa più grande del mese';

  @override
  String get wrapped_noSplurge =>
      'Nessuna spesa! Non hai avuto uscite questo mese.';

  @override
  String get wrapped_heroHabitTitle => 'Abitudine virtuosa';

  @override
  String wrapped_zeroSpendAchieved(Object count) {
    return '$count giorni a spesa zero';
  }

  @override
  String wrapped_heroHabitDesc(Object count) {
    return 'Hai raggiunto $count giorni a spesa zero. Straordinaria disciplina finanziaria!';
  }

  @override
  String get wrapped_receiptTitle => 'Rendiconto mensile';

  @override
  String get wrapped_obscureToggle => 'Nascondi importi per condividere';

  @override
  String get wrapped_showToggle => 'Mostra importi';

  @override
  String get wrapped_replay => 'Rivedi storia';

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
  String get more_sectionTools => 'Strumenti finanziari';

  @override
  String get more_sectionAnalytics => 'Analisi e Statistiche';

  @override
  String get more_sectionPreferences => 'Preferenze e Dati';

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
  String get wishlist_fundThisItem => 'Fanzia articolo';

  @override
  String wishlist_funded(int percent, String saved, String target) {
    return '$percent% finanziato ($saved / $target)';
  }

  @override
  String get wishlist_goalAchieved =>
      'Obiettivo raggiunto — pronto per l\'acquisto!';

  @override
  String get wishlist_buyNow => 'Acquista ora';

  @override
  String get wishlist_purchaseTitle => 'Acquista articolo dei desideri';

  @override
  String get wishlist_purchasePrompt =>
      'Vuoi registrare una spesa e scalare l\'importo da un conto?';

  @override
  String get wishlist_recordAndDeduct => 'Registra e scala';

  @override
  String get wishlist_markPurchasedOnly => 'Segna solo come acquistato';

  @override
  String wishlist_itemPurchased(String name) {
    return '\"$name\" segnato come acquistato!';
  }

  @override
  String get wishlist_viewGoal => 'Visualizza obiettivo di risparmio';

  @override
  String savings_linkedWishlist(String item) {
    return 'Collegato alla lista desideri: $item';
  }

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
  String get accounts_dontLinkToCard => 'Non collegare alla carta';

  @override
  String get accounts_dontLinkToCardDesc =>
      'Gestisci il saldo manualmente e impedisci il collegamento delle carte';

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
  String get export_exportAsPdf => 'Esporta come report PDF';

  @override
  String get export_formatPdf => 'Formato: Report finanziario PDF (.pdf)';

  @override
  String get export_pdfGenerating => 'Generazione PDF in corso...';

  @override
  String get export_pdfTitle => 'Report Finanziario';

  @override
  String get export_pdfSummary => 'Riepilogo esecutivo';

  @override
  String get export_pdfInflow => 'Entrate totali';

  @override
  String get export_pdfOutflow => 'Uscite totali';

  @override
  String get export_pdfNet => 'Risparmio netto';

  @override
  String get export_pdfSavingsRate => 'Tasso di risparmio';

  @override
  String get export_pdfCategoryBreakdown => 'Dettaglio categorie';

  @override
  String get export_pdfTransactions => 'Transazioni dettagliate';

  @override
  String get export_pdfNetWorthBreakdown => 'Attività e passività';

  @override
  String get export_pdfShare => 'Condividi report';

  @override
  String get export_pdfPrint => 'Stampa / Anteprima';

  @override
  String get export_pdfGeneratedBy => 'Generato da Expensy • Privato & Offline';

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
  String get home_goodMorning => 'Buongiorno';

  @override
  String get home_goodAfternoon => 'Buon pomeriggio';

  @override
  String get home_goodEvening => 'Buonasera';

  @override
  String get home_transferAction => 'Trasferisci';

  @override
  String get home_insightsAction => 'Analisi';

  @override
  String get home_calendarAction => 'Calendario';

  @override
  String get home_forecastAction => 'Previsioni';

  @override
  String get home_manage => 'Gestisci';

  @override
  String get home_seeAll => 'Vedi tutti';

  @override
  String get home_addAccount => 'Aggiungi conto';

  @override
  String get home_monthlyOverview => 'Panoramica mensile';

  @override
  String get home_savingsRate => 'Tasso di risparmio';

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

  @override
  String get more_loans => 'Prestiti';

  @override
  String more_loansSub(num count) {
    return 'Prestiti attivi';
  }

  @override
  String get loans_title => 'Prestiti';

  @override
  String get loans_addLoan => 'Aggiungi prestito';

  @override
  String get loans_editLoan => 'Modifica prestito';

  @override
  String get loans_loanName => 'Nome prestito';

  @override
  String get loans_amount => 'Importo';

  @override
  String get loans_startDate => 'Data inizio';

  @override
  String get loans_endDate => 'Data fine';

  @override
  String get loans_interestRateOptional => 'Tasso di interesse (Opzionale)';

  @override
  String get loans_account => 'Conto collegato';

  @override
  String get loans_monthlyPayment => 'Pagamento mensile';

  @override
  String get loans_totalPayable => 'Totale da pagare';

  @override
  String get loans_remaining => 'Rimanente';

  @override
  String get loans_paid => 'Pagato';

  @override
  String get loans_logPayment => 'Registra pagamento';

  @override
  String get loans_paymentReminder => 'Promemoria pagamento';

  @override
  String get loans_reminderDay => 'Giorno promemoria';

  @override
  String get loans_notes => 'Note';

  @override
  String get loans_saveLoan => 'Salva prestito';

  @override
  String get loans_deleteLoan => 'Elimina prestito';

  @override
  String get loans_settled => 'Saldato';

  @override
  String loans_durationMonths(num count) {
    return 'Mesi';
  }

  @override
  String get loans_paymentHistory => 'Cronologia pagamenti';

  @override
  String get loans_noPayments => 'Nessun pagamento ancora registrato';

  @override
  String get loans_outstandingDebt => 'Debito residuo';

  @override
  String get loans_monthlyObligation => 'Impegno mensile';

  @override
  String get insights_loans => 'Prestiti';

  @override
  String get backup_loans => 'Prestiti';

  @override
  String get backup_loanPayments => 'Pagamenti prestiti';

  @override
  String get more_yearlyAnalysis => 'Analisi annuale';

  @override
  String get more_yearlyAnalysisSub =>
      'Previsione flusso di cassa mese per mese';

  @override
  String get yearly_title => 'Analisi annuale';

  @override
  String get yearly_recurringExp => 'Spese ricorrenti';

  @override
  String get yearly_recurringInc => 'Entrate ricorrenti';

  @override
  String get yearly_loans => 'Pagamenti prestiti';

  @override
  String get yearly_borrowed => 'Debiti in scadenza';

  @override
  String get yearly_lentDue => 'Crediti da incassare';

  @override
  String get yearly_inflow => 'Entrate';

  @override
  String get yearly_outflow => 'Uscite';

  @override
  String get yearly_netFlow => 'Flusso netto';

  @override
  String get yearly_totalInflow => 'Entrate totali';

  @override
  String get yearly_totalOutflow => 'Uscite totali';

  @override
  String get yearly_netCashFlow => 'Flusso di cassa netto';

  @override
  String get yearly_noData => 'Nessuna attività prevista';

  @override
  String get yearly_noDataSub =>
      'Aggiungi pagamenti ricorrenti o prestiti per vedere le previsioni';

  @override
  String get budget_addBudget => 'Aggiungi budget';

  @override
  String get budget_addGoal => 'Aggiungi obiettivo di risparmio';

  @override
  String get add_transaction_possibleDuplicate => 'Possibile duplicato';

  @override
  String get add_transaction_goBack => 'Torna indietro';

  @override
  String get add_transaction_saveAnyway => 'Salva comunque';

  @override
  String get loans_confirmDeleteLoan =>
      'Sei sicuro di voler eliminare questo prestito e tutti i relativi pagamenti?';

  @override
  String get loans_deletePayment => 'Elimina pagamento';

  @override
  String get loans_confirmDeletePayment =>
      'Sei sicuro di voler eliminare questo record di pagamento?';

  @override
  String get split_transactions_title => 'Dividi categorie';

  @override
  String get split_transactions_badge => 'Diviso';

  @override
  String get split_transactions_addSplit => 'Aggiungi divisione';

  @override
  String get split_transactions_removeSplit => 'Rimuovi divisione';

  @override
  String get split_transactions_allocated => 'Allocato';

  @override
  String get split_transactions_remaining => 'Rimanente';

  @override
  String get split_transactions_fillRemaining => 'Riempi rimanente';

  @override
  String get split_transactions_breakdown => 'Dettaglio suddivisione';

  @override
  String get split_transactions_mismatchError =>
      'Gli importi suddivisi devono corrispondere all\'importo totale.';

  @override
  String get netWorth_title => 'Patrimonio netto';

  @override
  String get netWorth_subtitle =>
      'Monitora attività, passività e patrimonio nel tempo';

  @override
  String get netWorth_current => 'Patrimonio netto attuale';

  @override
  String get netWorth_trend => 'Andamento del patrimonio netto';

  @override
  String get netWorth_totalAssets => 'Attività totali';

  @override
  String get netWorth_totalLiabilities => 'Passività totali';

  @override
  String get netWorth_liquidCash => 'Contanti e conti bancari';

  @override
  String get netWorth_goldValuation => 'Oro fisico';

  @override
  String get netWorth_fixedAssets => 'Proprietà e investimenti';

  @override
  String get netWorth_moneyLent => 'Denaro prestato (Crediti)';

  @override
  String get netWorth_creditDebt => 'Carte di credito e scoperto';

  @override
  String get netWorth_loanDebt => 'Prestiti da rimborsare';

  @override
  String get netWorth_moneyBorrowed => 'Denaro preso in prestito (Debiti)';

  @override
  String get netWorth_assetBreakdown => 'Dettaglio delle attività';

  @override
  String get netWorth_liabilityBreakdown => 'Dettaglio delle passività';

  @override
  String get netWorth_noHistory =>
      'La cronologia del patrimonio netto si accumulerà automaticamente nel tempo.';

  @override
  String get netWorth_debtRatio => 'Rapporto di indebitamento';

  @override
  String get netWorth_quickActions => 'Azioni rapide';

  @override
  String get netWorth_history => 'Cronologia snapshot';

  @override
  String get creditCard_utilization => 'Utilizzo del credito';

  @override
  String get creditCard_availableCredit => 'Disponibile';

  @override
  String get creditCard_limit => 'Limite';

  @override
  String get creditCard_statementBalance => 'Saldo estratto conto';

  @override
  String get creditCard_unbilledBalance => 'Non fatturato';

  @override
  String get creditCard_payBill => 'Paga conto carta';

  @override
  String get creditCard_allCaughtUp => 'Tutto in regola! Nessun saldo dovuto';

  @override
  String get creditCard_payBillTitle => 'Paga estratto conto carta';

  @override
  String get creditCard_payFromAccount => 'Paga dal conto';

  @override
  String get creditCard_paymentAmount => 'Importo pagamento';

  @override
  String get creditCard_fullStatement => 'Saldo estratto conto';

  @override
  String get creditCard_fullBalance => 'Saldo totale';

  @override
  String get creditCard_minPayment => 'Pagamento minimo';

  @override
  String get creditCard_customAmount => 'Importo personalizzato';

  @override
  String creditCard_paymentSuccess(String amount, String cardName) {
    return 'Pagati $amount per $cardName';
  }

  @override
  String get creditCard_insufficientFunds =>
      'L\'importo supera il saldo disponibile';

  @override
  String get creditCard_invalidAmount =>
      'Inserisci un importo di pagamento valido';

  @override
  String get onboarding_skipForNow => 'Salta per ora';

  @override
  String get onboarding_addCard => 'Aggiungi una carta';

  @override
  String get onboarding_skipCardDesc =>
      'Puoi saltare questo passaggio se non desideri aggiungere una carta adesso.';

  @override
  String get onboarding_cardNameLabel => 'Nome della carta (es. Visa Platinum)';

  @override
  String get onboarding_debitCard => 'Carta di debito';

  @override
  String get onboarding_creditLimit => 'Limite di credito';

  @override
  String get onboarding_amountUsed => 'Importo utilizzato';

  @override
  String get accounts_cardHolderOptional => 'Titolare della carta (Opzionale)';

  @override
  String get accounts_last4Digits => 'Ultime 4 cifre';

  @override
  String get accounts_expiryDate => 'Data di scadenza (MM/AA)';

  @override
  String get accounts_creditLimitOptional => 'Limite di credito (Opzionale)';

  @override
  String get accounts_minPaymentOptional => 'Pagamento minimo (Opzionale)';

  @override
  String get accounts_statementDayOptional =>
      'Giorno estratto conto (Opzionale)';

  @override
  String get accounts_statementDayExample => 'es. 20';

  @override
  String get accounts_dueDayOptional => 'Giorno di scadenza (Opzionale)';

  @override
  String get accounts_dueDayExample => 'es. 10';

  @override
  String get accounts_linkedAccountOptional =>
      'Conto bancario collegato (Opzionale)';

  @override
  String get accounts_excludeCardBalance =>
      'Escludi saldo carta dal saldo del conto';

  @override
  String get accounts_excludeCardBalanceDesc =>
      'Il saldo di questa carta non verrà aggiunto al conto bancario collegato.';

  @override
  String get accounts_cardHolderHeader => 'TITOLARE';

  @override
  String get accounts_expHeader => 'SCAD';

  @override
  String get accounts_notifyOnDueDate =>
      'Riceverai una notifica alla data di scadenza';

  @override
  String get accounts_notifyWhenDue =>
      'Ricevi una notifica alla scadenza del pagamento';

  @override
  String get accounts_remind2DaysBeforeDesc =>
      'Ricevi un promemoria 2 giorni prima della scadenza';

  @override
  String get accounts_targetSaved => 'Obiettivo / Risparmiato';

  @override
  String transactions_selectedCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count selezionati',
      one: '1 selezionato',
    );
    return '$_temp0';
  }

  @override
  String get transactions_changeCategory => 'Cambia categoria';

  @override
  String get transactions_deleteSelected => 'Elimina selezionati';

  @override
  String get transactions_advancedFilters => 'Filtri avanzati';

  @override
  String get transactions_clearAll => 'Cancella tutto';

  @override
  String get transactions_amountRange => 'Intervallo importo';

  @override
  String get transactions_minAmount => 'Importo minimo';

  @override
  String get transactions_maxAmount => 'Importo massimo';

  @override
  String get transactions_applyFilters => 'Applica filtri';

  @override
  String get presets_new => 'Nuovo';

  @override
  String get presets_presetName => 'Nome modello (es. Caffè mattutino)';

  @override
  String get presets_defaultAmount => 'Importo predefinito';

  @override
  String get savings_goalName => 'Nome obiettivo';

  @override
  String get savings_goalNameHint => 'es. Nuova auto, Vacanze';

  @override
  String get savings_targetAmount => 'Importo obiettivo';

  @override
  String get savings_targetDateOptional => 'Data obiettivo (Opzionale)';

  @override
  String get savings_selectDate => 'Seleziona data';

  @override
  String get savings_amountRequired => 'L\'importo è obbligatorio';

  @override
  String get savings_noteOptional => 'Nota (Opzionale)';

  @override
  String get loans_skipInstallment => 'Saltare la prossima rata del prestito?';

  @override
  String get recurring_confirmDelete =>
      'Sei sicuro di voler eliminare questo pagamento ricorrente?';

  @override
  String get export_formatExcelOption => 'Excel (.xlsx)';

  @override
  String get export_formatPdfOption => 'Report PDF';

  @override
  String get export_pdfNoTransactions =>
      'Nessuna transazione registrata in questo intervallo di date.';

  @override
  String get savings_saved => 'Risparmiato';

  @override
  String get export_pdfDate => 'Data';

  @override
  String get export_pdfDescription => 'Descrizione';

  @override
  String get accounts_noCardsYet => 'Nessuna carta';

  @override
  String get accounts_tapToAddCard =>
      'Tocca + per aggiungere la tua prima carta';

  @override
  String get savings_noGoalsYet => 'Nessun obiettivo di risparmio';

  @override
  String get savings_tapToAddGoal => 'Tocca + per impostare un nuovo obiettivo';

  @override
  String get netWorth_recordSnapshot => 'Registra istantanea';

  @override
  String get netWorth_snapshotRecorded => 'Istantanea registrata';

  @override
  String get savings_noContributionsYet => 'Nessun contributo finora';

  @override
  String get creditCard_closesStatementBillingCycle =>
      'Chiude il ciclo di fatturazione dell\'estratto conto attuale';

  @override
  String get creditCard_clearsTotalDebt =>
      'Estingue completamente l\'intero debito della carta';

  @override
  String get creditCard_requiredMinPayment => 'Pagamento minimo richiesto';

  @override
  String get creditCard_specifyCustomAmount =>
      'Specifica importo di pagamento personalizzato';

  @override
  String common_itemDeleted(String name) {
    return '\"$name\" eliminato';
  }

  @override
  String get common_accountDeleted => 'Conto eliminato';

  @override
  String get common_cardDeleted => 'Carta eliminata';

  @override
  String get common_transactionDeleted => 'Transazione eliminata';

  @override
  String get common_recordDeleted => 'Record eliminato';

  @override
  String get common_paymentDeleted => 'Pagamento eliminato';

  @override
  String get loans_skippedInstallment => 'Rata del prestito saltata';

  @override
  String loans_loggedPayment(String amount) {
    return 'Pagamento di $amount registrato';
  }

  @override
  String get loans_notificationsPermissionRequired =>
      'Autorizzazione notifiche richiesta';

  @override
  String get creditCard_selectFundingAccount =>
      'Seleziona un conto di addebito';

  @override
  String get presets_presetUpdated => 'Preimpostazione aggiornata';

  @override
  String get presets_presetAdded => 'Preimpostazione aggiunta';

  @override
  String get presets_presetDeleted => 'Preimpostazione eliminata';

  @override
  String transactions_deletedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementi eliminati',
      one: '1 elemento eliminato',
    );
    return '$_temp0';
  }

  @override
  String get split_atLeastTwoCategories =>
      'Almeno 2 categorie richieste per la suddivisione.';

  @override
  String get split_categoryAndAmountRequired =>
      'Ogni elemento suddiviso deve avere una categoria e un importo > 0.';

  @override
  String get presets_addQuickPresets => 'Aggiungi modelli rapidi a 1 tocco';

  @override
  String get presets_quickPresetsDesc =>
      'Registra caffè frequenti, tragitti o pasti con un solo tocco';

  @override
  String presets_loggedPreset(String title, String amount) {
    return 'Registrato $title ($amount)';
  }

  @override
  String get presets_createPreset => 'Crea preimpostazione';

  @override
  String get presets_editQuickPreset => 'Modifica modello rapido';

  @override
  String get presets_newQuickPreset => 'Nuovo modello rapido';

  @override
  String get savings_addContribution => 'Aggiungi contributo';

  @override
  String get savings_withdrawFromGoal => 'Preleva dall\'obiettivo';

  @override
  String get savings_contribution => 'Contributo';

  @override
  String get savings_withdrawal => 'Prelievo';

  @override
  String get savings_unknownAccount => 'Conto sconosciuto';

  @override
  String get savings_fromAccount => 'Dal conto';

  @override
  String get savings_toAccount => 'Al conto';

  @override
  String get presets_quickLog => 'Registrazione rapida';

  @override
  String accounts_dueOnDay(int day) {
    return 'Scadenza il $day';
  }
}
