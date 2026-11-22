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
    return 'Dal $date · Continuo';
  }

  @override
  String recurring_paidPayments(Object paid, Object total) {
    return '$paid/$total pagati';
  }

  @override
  String recurring_totalAmount(Object amount) {
    return 'Totale: $amount';
  }

  @override
  String get recurring_overdue => 'In ritardo!';

  @override
  String get recurring_dueToday => 'Scadenza oggi';

  @override
  String recurring_dueInDays(Object days) {
    return 'Tra $days g';
  }

  @override
  String get recurring_edit => 'Modifica';

  @override
  String get recurring_skipBtn => 'Salta';

  @override
  String recurring_nextDate(Object date) {
    return 'Prossima: $date';
  }

  @override
  String get recurring_pay => 'Paga';

  @override
  String get recurring_del => 'Elim.';

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
    return 'Prima: $date';
  }

  @override
  String recurring_lastDate(Object date) {
    return 'Ultima: $date';
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
    return '$percentage% puro';
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
    return '$name ti deve';
  }

  @override
  String lended_person_youOwe(Object name) {
    return 'Devi a $name';
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
    return 'Scadenza $date';
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
    return 'Scadenza: $date';
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
    return 'Prestato a $name';
  }

  @override
  String transactions_borrowedFrom(Object name) {
    return 'Preso in prestito da $name';
  }

  @override
  String get transactions_unknown => 'Sconosciuto';

  @override
  String transactions_due(Object date) {
    return 'Scade $date';
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
    return 'Backup salvato:\n$savedPath';
  }

  @override
  String backup_backupFailed(Object error) {
    return 'Backup fallito: $error';
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
    return 'Ripristino fallito: $error';
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
    return '$amount oltre il limite';
  }

  @override
  String budget_leftAmount(Object amount) {
    return '$amount rimanenti';
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
    return 'Speso: $amount';
  }

  @override
  String budget_ofAmount(Object amount) {
    return 'su $amount';
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
  String get wrapped_title => 'Riepilogo Expensy';

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
    return 'Entrate $amount';
  }

  @override
  String insights_expensesAmount(Object amount) {
    return 'Spese $amount';
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
    return '≈ $amount saranno addebitati su $accountName';
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
      other: '$count elementi',
      one: '1 elemento',
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
      other: '$count beni',
      one: '1 bene',
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
      other: '$count categorie',
      one: '1 categoria',
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
    return 'Ciao, $name 👋';
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
      other: '$count voci attive',
      one: '1 voce attiva',
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
    return '$minutes min fa';
  }

  @override
  String currency_converter_rateAgeHours(Object hours) {
    return '$hours ore fa';
  }

  @override
  String currency_converter_rateAgeDays(Object days) {
    return '$days giorni fa';
  }

  @override
  String currency_converter_commonConversions(Object fromCurrency) {
    return 'Conversioni comuni da $fromCurrency';
  }

  @override
  String transfer_fromAcc(Object currency) {
    return 'Da ($currency)';
  }

  @override
  String transfer_toAcc(Object currency) {
    return 'A ($currency)';
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
      other: '$count transazioni nell\'intervallo',
      one: '1 transazione nell\'intervallo',
    );
    return '$_temp0';
  }

  @override
  String export_saved(Object path) {
    return 'Salvato: $path';
  }

  @override
  String get export_complete => 'Esportazione completata';

  @override
  String get export_exporting => 'Esportazione...';

  @override
  String get export_exportAsExcel => 'Esporta come Excel';

  @override
  String shared_widgets_deleteConfirm(Object name) {
    return 'Eliminare \"$name\"? Azione irreversibile.';
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
  String get home_converterAction => 'Convertitore';

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
  String get home_cards => 'Carte';

  @override
  String get home_addCard => 'Aggiungi carta';

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
    return 'Salvataggio in: $path';
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
    return 'Data obiettivo: $date';
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

  @override
  String get accounts_cannotDeleteAccount => 'Impossibile eliminare l\'account';

  @override
  String get common_ok => 'OK';

  @override
  String get certificates_title => 'Depositi a Termine e Certificati';

  @override
  String get certificates_addCertificate => 'Aggiungi certificato';

  @override
  String get certificates_editCertificate => 'Modifica certificato';

  @override
  String get certificates_noCertificates => 'Nessun certificato';

  @override
  String get certificates_noCertificatesDesc =>
      'Monitora i tuoi depositi ad alto rendimento, interessi maturati e scadenze.';

  @override
  String get certificates_active => 'Attivo';

  @override
  String get certificates_matured => 'Scaduto';

  @override
  String get certificates_amount => 'Importo capitale';

  @override
  String get certificates_collectionType => 'Incasso interessi';

  @override
  String get certificates_collectedSoFar => 'Incassato finora';

  @override
  String get certificates_expectedTotal => 'Rendimento totale previsto';

  @override
  String get certificates_startDate => 'Data di inizio';

  @override
  String get certificates_endDate => 'Data di scadenza';

  @override
  String get certificates_redeem => 'Riscatta certificato';

  @override
  String certificates_redeemConfirm(String name, String amount) {
    return 'Sei sicuro di voler riscattare \"$name\"? Il capitale di $amount verrà riaccreditato sul tuo conto bancario.';
  }

  @override
  String get certificates_redeemedSuccess =>
      'Certificato riscattato e capitale riaccreditato con successo.';

  @override
  String get certificates_name => 'Nome certificato';

  @override
  String get certificates_interestRate => 'Tasso di interesse annuo (%)';

  @override
  String get certificates_linkedBankAccount => 'Conto bancario collegato';

  @override
  String get certificates_periodicYield =>
      'Rendimento periodico degli interessi';

  @override
  String get certificates_paymentReminder => 'Notifica promemoria liquidazione';

  @override
  String get certificates_reminderTime => 'Ora del promemoria';

  @override
  String get certificates_reminder2DaysBefore => 'Promemoria 2 giorni prima';

  @override
  String get certificates_deleteCertificate => 'Elimina certificato';

  @override
  String get certificates_confirmDeleteCertificate =>
      'Sei sicuro di voler eliminare questo certificato? Tutte le transazioni associate verranno rimosse e i fondi riaccreditati sul tuo conto.';

  @override
  String get certificates_deleted => 'Certificato eliminato';

  @override
  String get onboarding_stayOnTopOfFinances =>
      'Tieni sotto controllo le tue finanze';

  @override
  String get onboarding_stayOnTopOfFinancesDesc =>
      'Attiva promemoria tempestivi per non perdere mai un pagamento, una scadenza o una soglia di budget.';

  @override
  String get onboarding_featureBillTitle => 'Promemoria bollette e scadenze';

  @override
  String get onboarding_featureBillDesc =>
      'Ricevi avvisi prima delle date dell\'estratto conto e delle rate dei prestiti.';

  @override
  String get onboarding_featureBudgetTitle => 'Avvisi di monitoraggio budget';

  @override
  String get onboarding_featureBudgetDesc =>
      'Ricevi notifiche quando raggiungi l\'80% o il 100% del limite di spesa.';

  @override
  String get onboarding_featureRecurringTitle => 'Abbonamenti ricorrenti';

  @override
  String get onboarding_featureRecurringDesc =>
      'Rimani informato prima del rinnovo automatico di abbonamenti e fatture.';

  @override
  String get onboarding_allowNotifications => 'Consenti notifiche';

  @override
  String get onboarding_maybeLater => 'Forse più tardi';

  @override
  String get categories_subcategories => 'Sottocategorie';

  @override
  String get categories_addSubcategory => 'Aggiungi sottocategoria';

  @override
  String get categories_parentCategory => 'Categoria principale';

  @override
  String get categories_noneRoot => 'Nessuna (Categoria principale)';

  @override
  String get categories_loadDefaults => 'Carica sottocategorie predefinite';

  @override
  String categories_defaultsLoaded(int count) {
    return 'Caricate $count sottocategorie predefinite';
  }

  @override
  String get categories_defaultsAlreadyLoaded =>
      'Le sottocategorie predefinite sono già caricate';

  @override
  String get statistics_byCategory => 'Per categoria';

  @override
  String get statistics_bySubcategory => 'Per sottocategoria';

  @override
  String get backup_importFromTrackWallet => 'Importa da TrackWallet (.csv)';

  @override
  String backup_importedTransactions(int count) {
    return '$count transazioni importate con successo!';
  }

  @override
  String get onboarding_restoreTrackWallet => 'Importa da TrackWallet (.csv)';

  @override
  String get transfer_categoryLocked =>
      'Trasferimento (Categoria predefinita e unica)';

  @override
  String get loans_noLoans => 'Nessun prestito monitorato';

  @override
  String get loans_noLoansSub =>
      'Tocca + per monitorare mutui, prestiti o rate';

  @override
  String get certificates_noCertificatesSub =>
      'Tocca + per monitorare certificati e depositi vincolati';

  @override
  String get common_undo => 'Annulla';

  @override
  String get common_close => 'Chiudi';

  @override
  String get common_required => 'Obbligatorio';

  @override
  String get common_invalid => 'Non valido';

  @override
  String get common_none => 'Nessuno';

  @override
  String common_enabledAt(String time) {
    return 'Attivo ($time)';
  }

  @override
  String get common_disabled => 'Disattivato';

  @override
  String get freq_daily => 'Giornaliero';

  @override
  String get freq_yearly => 'Annuale';

  @override
  String recurring_transfers(Object count) {
    return 'Trasferimenti ($count)';
  }

  @override
  String get recurring_transfer => 'Trasferimento';

  @override
  String get recurring_transferCaps => 'TRASFERIMENTO';

  @override
  String get recurring_noRecurringTransfers =>
      'Nessun trasferimento ricorrente';

  @override
  String recurring_subtitleCount(int count) {
    return '$count abbonamenti e ricorrenze';
  }

  @override
  String recurring_perWeek(String amount) {
    return '$amount / settimana';
  }

  @override
  String get recurring_perMonth => '/ mese';

  @override
  String get recurring_fromAccount => 'Dal conto';

  @override
  String get recurring_toAccount => 'Al conto';

  @override
  String recurring_targetAmount(String currency) {
    return 'Importo di destinazione ($currency)';
  }

  @override
  String get recurring_autoPayAt => 'Pagamento auto alle';

  @override
  String get recurring_autoPayOnDueDate => 'Paga automaticamente alla scadenza';

  @override
  String get recurring_autoPayEnabledSub =>
      'Registrato automaticamente alla scadenza';

  @override
  String get recurring_autoPayDisabledSub =>
      'Registra automaticamente questo pagamento alla scadenza';

  @override
  String get recurring_autoPayTime => 'Orario pagamento auto';

  @override
  String get recurring_reminderEnabledSub =>
      'Riceverai una notifica il giorno di scadenza';

  @override
  String get recurring_reminderDisabledSub =>
      'Ricevi una notifica alla scadenza del pagamento';

  @override
  String get recurring_earlyReminderEnabledSub =>
      'Avviso extra 2 giorni prima alla stessa ora';

  @override
  String get recurring_earlyReminderDisabledSub =>
      'Ricevi un avviso anche 2 giorni prima';

  @override
  String get recurring_addRecurringBtn => 'Aggiungi ricorrenza';

  @override
  String get recurring_paymentDetails => 'Dettagli pagamento';

  @override
  String get recurring_linkedAccount => 'Conto collegato';

  @override
  String get recurring_deletedAccount => 'Conto eliminato';

  @override
  String get recurring_frequency => 'Frequenza';

  @override
  String get recurring_type => 'Tipo';

  @override
  String get recurring_startDate => 'Data di inizio';

  @override
  String get recurring_nextDueDate => 'Prossima scadenza';

  @override
  String get recurring_autoPay => 'Pagamento automatico';

  @override
  String get recurring_reminder => 'Promemoria';

  @override
  String get recurring_endDate => 'Data di fine';

  @override
  String get recurring_totalValue => 'Valore totale';

  @override
  String get recurring_notes => 'Note';

  @override
  String get recurring_upcomingPayments => 'Pagamenti in arrivo';

  @override
  String recurring_remainingCount(int count) {
    return '$count rimanenti';
  }

  @override
  String get recurring_allInstallmentsCompleted => 'Tutte le rate completate';

  @override
  String recurring_installmentOf(int num, int total) {
    return 'N. $num di $total';
  }

  @override
  String get recurring_paymentPaid => 'Pagamento effettuato';

  @override
  String get recurring_paymentSkipped => 'Pagamento saltato';

  @override
  String get presets_transfer => 'Trasferimento';

  @override
  String get presets_selectDifferentAccounts =>
      'Seleziona conti di origine e destinazione diversi.';

  @override
  String presets_targetAmountOptional(String currency) {
    return 'Importo in $currency (Opzionale)';
  }

  @override
  String get transactions_transfers => 'Trasferimenti';

  @override
  String transactions_selectedItemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementi selezionati',
      one: '1 elemento selezionato',
    );
    return '$_temp0';
  }

  @override
  String transactions_entriesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count voci',
      one: '1 voce',
    );
    return '$_temp0';
  }

  @override
  String get transactions_clearSelection => 'Deseleziona tutto';

  @override
  String get transactions_transferTitle => 'Transazione di trasferimento';

  @override
  String get transactions_transferBody =>
      'Questa transazione fa parte di un trasferimento tra conti e non può essere modificata singolarmente. Vuoi eliminare il trasferimento?';

  @override
  String get transactions_deleteTransfer => 'Elimina trasferimento';

  @override
  String get transactions_transferDeleted => 'Trasferimento eliminato';

  @override
  String get transactions_certTitle => 'Transazione certificato';

  @override
  String get transactions_certBody =>
      'Questa transazione è collegata a un certificato di deposito. Gestiscila dalla schermata Certificati per mantenere i saldi sincronizzati.';

  @override
  String get transactions_viewCertificate => 'Vedi certificato';

  @override
  String get transactions_openCertificates => 'Apri certificati';

  @override
  String get transactions_loanFallback => 'Prestito';

  @override
  String get transactions_loanPayment => 'Rata prestito';

  @override
  String get transactions_goalContribution => 'Versamento obiettivo';

  @override
  String get transactions_goalWithdrawal => 'Prelievo obiettivo';

  @override
  String get calendar_repayment => 'Rimborso';

  @override
  String get calendar_transfersDue => 'Trasferimenti ricorrenti dovuti';

  @override
  String accounts_subtitleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count conti',
      one: '1 conto',
    );
    return '$_temp0';
  }

  @override
  String get accounts_tabAccounts => 'Conti';

  @override
  String get accounts_tabCards => 'Carte';

  @override
  String get accounts_addCardBtn => 'Aggiungi carta';

  @override
  String get accounts_addNewCardBtn => 'Aggiungi nuova carta';

  @override
  String get accounts_editCard => 'Modifica carta';

  @override
  String get accounts_cardNameHint => 'Nome carta (es. Visa Platinum)';

  @override
  String get accounts_debitCard => 'Carta di debito';

  @override
  String get accounts_prepaidCard => 'Carta prepagata';

  @override
  String get accounts_pinToWidget => 'Fissa nel widget';

  @override
  String get accounts_unpinFromWidget => 'Rimuovi dal widget';

  @override
  String get accounts_maxPinnedWarning => 'Non puoi fissare più di 3 conti';

  @override
  String get accounts_selectLinkedBank =>
      'Seleziona un conto bancario collegato per questa carta di debito.';

  @override
  String get accounts_debitSharesBalance =>
      'Le carte di debito condividono il saldo con il conto bancario collegato.';

  @override
  String get accounts_linkedBankRequired =>
      'Conto bancario collegato (Obbligatorio)';

  @override
  String get accounts_amountCurrentlyOwed => 'Importo attualmente dovuto';

  @override
  String get accounts_initialAmountOwed => 'Importo dovuto iniziale';

  @override
  String get accounts_cardDebtHint =>
      'Inserisci il debito attuale su questa carta (salvato come debito)';

  @override
  String accounts_nextCycleCloses(int day) {
    return 'Il prossimo ciclo chiude intorno al giorno $day';
  }

  @override
  String accounts_spotPriceLabel(int karat) {
    return 'Prezzo spot (oro ${karat}k/g)';
  }

  @override
  String get accounts_weightTimesPurity => 'Peso × purezza';

  @override
  String accounts_blockDeleteRecurring(int count) {
    return 'Il conto ha $count pagamenti ricorrenti attivi. Riassegnali o eliminali prima.';
  }

  @override
  String accounts_blockDeleteLoans(int count) {
    return 'Il conto ha $count prestiti attivi. Riassegnali o eliminali prima.';
  }

  @override
  String accounts_blockDeleteCertificates(int count) {
    return 'Il conto ha $count certificati attivi. Riscattali o eliminali prima.';
  }

  @override
  String accounts_blockDeleteLended(int count) {
    return 'Il conto ha $count prestiti non saldati. Saldali prima.';
  }

  @override
  String accounts_blockDeleteSavings(int count) {
    return 'Il conto è usato da $count contributi di risparmio. Riassegnali o eliminali prima.';
  }

  @override
  String accounts_blockDeletePresets(int count) {
    return 'Il conto è usato in $count modelli rapidi. Riassegnali o eliminali prima.';
  }

  @override
  String accounts_blockDeleteCards(int count) {
    return 'Il conto è collegato a $count carte. Scollegale o eliminale prima.';
  }

  @override
  String get add_transaction_selectAccountOrCard =>
      'Seleziona un conto o una carta.';

  @override
  String get add_transaction_balanced => 'Bilanciato';

  @override
  String add_transaction_similarExists(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Esistono già $count transazioni simili:',
      one: 'Esiste già una transazione simile:',
    );
    return '$_temp0';
  }

  @override
  String budget_goalsCountSubtitle(int budgets, int goals) {
    return '$budgets budget · $goals obiettivi';
  }

  @override
  String get budget_savingsGoalsCaps => 'OBIETTIVI DI RISPARMIO';

  @override
  String budget_percentSaved(String percent) {
    return '$percent% risparmiato';
  }

  @override
  String budget_ofTarget(String amount) {
    return 'su $amount';
  }

  @override
  String get budget_goalsTab => 'Obiettivi';

  @override
  String get budget_completed => 'Completato';

  @override
  String get savings_newGoal => 'Nuovo obiettivo di risparmio';

  @override
  String get savings_editGoal => 'Modifica obiettivo di risparmio';

  @override
  String get certificates_activePrincipal => 'Capitale attivo';

  @override
  String get certificates_activeCount => 'Attivi';

  @override
  String certificates_linkedBank(String name) {
    return 'Collegato: $name';
  }

  @override
  String certificates_yieldSummary(String amount, String type) {
    return 'Rendimento: $amount ($type)';
  }

  @override
  String certificates_maturesOn(String date) {
    return 'Scadenza: $date';
  }

  @override
  String get certificates_settledCaps => 'ESTINTO';

  @override
  String get certificates_activeCaps => 'ATTIVO';

  @override
  String get certificates_annualRate => 'Tasso annuo';

  @override
  String get certificates_periodicYieldLabel => 'Rendimento periodico';

  @override
  String get certificates_maturedAndSettled => 'Scaduto ed estinto';

  @override
  String get certificates_payoutOverride => 'Cedola (manuale)';

  @override
  String get certificates_dayRange => 'Giorno (1-31)';

  @override
  String get certificates_noBankAccounts =>
      'Nessun conto bancario disponibile. Crea un conto per ricevere gli interessi.';

  @override
  String get certificates_selectLinkedBank =>
      'Seleziona un conto bancario collegato.';

  @override
  String get creditCard_noFundingAccounts =>
      'Nessun conto bancario o contanti disponibile per il pagamento.';

  @override
  String get creditCard_processing => 'Elaborazione...';

  @override
  String creditCard_payAmountBtn(String amount) {
    return 'Paga $amount';
  }

  @override
  String get insights_loanPaymentsThisMonth =>
      'Rate debiti / prestiti questo mese';

  @override
  String get insights_spendingForecast => 'Previsione di spesa';

  @override
  String get insights_forecastPrefix => 'A questo ritmo spenderai ';

  @override
  String insights_forecastSuffix(String month, int days) {
    return ' entro fine $month — $days giorni rimasti.';
  }

  @override
  String get insights_forecastDisclaimer =>
      'Proiezione basata sulle spese attuali, escluse le bollette ricorrenti future.';

  @override
  String insights_forecastAccuracy(int days) {
    return 'Basato sui primi $days giorni — la precisione migliora durante il mese.';
  }

  @override
  String insights_projAmount(String amount) {
    return 'Stima: $amount';
  }

  @override
  String insights_projOfBudget(String percent) {
    return ' ($percent% del budget)';
  }

  @override
  String get insights_outstanding => 'Residuo';

  @override
  String get insights_monthlyObligation => 'Rata mensile';

  @override
  String get loans_principal => 'Capitale';

  @override
  String get loans_interestRate => 'Tasso d\'interesse';

  @override
  String get loans_duration => 'Durata';

  @override
  String get loans_transferTo => 'Accredita importo del prestito su';

  @override
  String get loans_payFrom => 'Paga rate da';

  @override
  String loans_dueDayTime(int day, String time) {
    return 'Scadenza: Giorno $day alle $time';
  }

  @override
  String more_activeCount(int count) {
    return '$count attivi';
  }

  @override
  String more_toolsSubtitle(int count) {
    return '$count strumenti e preferenze';
  }

  @override
  String get more_totalWealthCaps => 'PATRIMONIO TOTALE';

  @override
  String get more_liveNetWorthSub =>
      'Patrimonio netto aggregato in tempo reale';

  @override
  String more_assetsAmount(String amount) {
    return 'Attività: $amount';
  }

  @override
  String more_liabilitiesAmount(String amount) {
    return 'Passività: $amount';
  }

  @override
  String get netWorth_debtFree => 'Senza debiti';

  @override
  String get netWorth_showLess => 'Mostra meno';

  @override
  String netWorth_showAll(int count) {
    return 'Mostra tutto ($count)';
  }

  @override
  String get netWorth_zeroLiabilities =>
      'Nessuna passività registrata! I debiti attuali sono \$0.00.';

  @override
  String get netWorth_lentDebts => 'Prestiti / Debiti';

  @override
  String netWorth_snapBreakdown(String assets, String accounts) {
    return 'Beni: $assets · Conti: $accounts';
  }

  @override
  String get onboarding_nameRequired => 'Il nome è obbligatorio';

  @override
  String get onboarding_popularCurrencies => 'Valute popolari';

  @override
  String get onboarding_debitCardNextStep =>
      'Puoi aggiungere una carta di debito per questo conto nel prossimo passaggio';

  @override
  String get onboarding_addDebitCardTitle => 'Aggiungi carta di debito';

  @override
  String get onboarding_addDebitCardDesc =>
      'Collega una carta di debito al tuo conto per tracciare le spese senza sforzo.';

  @override
  String get onboarding_cardName => 'Nome carta';

  @override
  String get onboarding_cardholderName => 'Titolare della carta';

  @override
  String get onboarding_last4Digits => 'Ultime 4 cifre';

  @override
  String get onboarding_cardColor => 'Colore carta';

  @override
  String wrapped_zeroSpendOfDays(int total) {
    return 'su $total giorni senza spese';
  }

  @override
  String get wrapped_savingsRateLabel => 'Tasso di risparmio';

  @override
  String get wrapped_topCategoryLabel => 'Categoria principale';

  @override
  String get wrapped_zeroSpendDaysLabel => 'Giorni senza spese';

  @override
  String get wrapped_footerTag => '★ Gestione Finanziaria Privata & Offline ★';

  @override
  String get yearly_tapToExpand => 'Tocca per espandere';

  @override
  String get yearly_noDataBadge => 'Nessun dato';

  @override
  String get export_formatHeader => 'FORMATO ESPORTAZIONE';

  @override
  String export_pdfPeriod(String range) {
    return 'Periodo: $range';
  }

  @override
  String export_pdfCurrency(String currency) {
    return 'Valuta: $currency';
  }

  @override
  String export_pdfGenerated(String date) {
    return 'Generato: $date';
  }

  @override
  String export_pdfPageOf(int page, int total) {
    return 'Pagina $page di $total';
  }

  @override
  String get export_pdfTotalAssets => 'Totale attività';

  @override
  String get export_pdfTotalLiabilities => 'Totale passività';

  @override
  String get export_pdfCurrentNetWorth => 'Patrimonio netto attuale';

  @override
  String get export_pdfCategory => 'Categoria';

  @override
  String export_pdfAmountHeader(String currency) {
    return 'Importo ($currency)';
  }

  @override
  String get export_pdfPercentOfExpenses => '% delle spese totali';

  @override
  String get backup_encryptedTitle => 'Backup crittografato';

  @override
  String get backup_encryptedPrompt =>
      'Inserisci la password usata per cifrare questo backup:';

  @override
  String get backup_password => 'Password';

  @override
  String get backup_confirmPassword => 'Conferma password';

  @override
  String get backup_decryptContinue => 'Decifra e continua';

  @override
  String get backup_chooseRestoreMode => 'Scegli modalità ripristino';

  @override
  String get backup_chooseRestoreModeDesc =>
      'Scegli se ripristinare l\'intero backup o solo dati specifici.';

  @override
  String get backup_selectiveRestore => 'Ripristino selettivo';

  @override
  String get backup_selectiveRestoreDesc =>
      'Scegli dati specifici senza cancellare gli altri dati o impostazioni.';

  @override
  String get backup_fullRestore => 'Ripristino completo';

  @override
  String get backup_fullRestoreDesc =>
      'Sostituisce completamente tutte le tabelle e impostazioni correnti.';

  @override
  String get backup_selectiveBackup => 'Backup selettivo';

  @override
  String get backup_selectiveBackupBtn => 'Backup selettivo...';

  @override
  String get backup_selectiveBackupDesc =>
      'Scegli i dati finanziari da esportare in JSON.';

  @override
  String get backup_selectedRestoredSuccess =>
      'Dati selezionati ripristinati con successo!';

  @override
  String get backup_savingsGoals => 'Obiettivi di risparmio';

  @override
  String get backup_savingsContributions => 'Contributi ai risparmi';

  @override
  String get backup_encryptionDisabled => 'Crittografia backup disattivata';

  @override
  String get backup_encryptionEnabled => 'Crittografia backup attivata';

  @override
  String backup_encryptionFailed(String error) {
    return 'Attivazione crittografia fallita: $error';
  }

  @override
  String get backup_encryptAutoTitle => 'Cifra backup automatici';

  @override
  String get backup_encryptAutoDesc =>
      'Proteggi i backup con AES-GCM-256. Se dimentichi la password i dati sono persi.';

  @override
  String get backup_passwordEmpty => 'La password non può essere vuota';

  @override
  String get backup_passwordsMismatch => 'Le password non corrispondono';

  @override
  String get backup_setPassword => 'Imposta password';

  @override
  String backup_autoCreated(String file) {
    return 'Backup automatico creato: $file';
  }

  @override
  String backup_autoFailed(String error) {
    return 'Backup automatico fallito: $error';
  }

  @override
  String get backup_nightlySchedule =>
      'Ogni notte alle ~2:00 nella cartella scelta';

  @override
  String get backup_noFolderSelected => 'Nessuna cartella selezionata';

  @override
  String get backup_keepCopies => 'Mantieni copie:';

  @override
  String get backup_encryptAes => 'Cifra backup (AES-GCM)';

  @override
  String backup_failedError(String error) {
    return 'Errore: $error';
  }

  @override
  String backup_lastSuccess(String date, String kb) {
    return 'Ultimo: $date ($kb KB)';
  }

  @override
  String get backup_backingUp => 'Salvataggio in corso...';

  @override
  String get backup_backUpNow => 'Esegui backup ora';

  @override
  String get backup_androidIdleNote =>
      'Eseguito alle ~2:00. Android può ritardarlo a schermo spento.';

  @override
  String get backup_selectAll => 'Seleziona tutto';

  @override
  String get backup_deselectAll => 'Deseleziona tutto';

  @override
  String get backup_selectiveSaved => 'Backup selettivo salvato!';

  @override
  String backup_exportFailed(String error) {
    return 'Esportazione fallita: $error';
  }

  @override
  String backup_exportSelected(int count) {
    return 'Esporta ($count) elementi';
  }

  @override
  String backup_restoreSelected(int count) {
    return 'Ripristina ($count) elementi';
  }

  @override
  String get backup_selectiveRestoreNote =>
      'Verranno ripristinati solo gli elementi scelti. Gli altri dati rimarranno intatti.';

  @override
  String backup_countInBackup(int count) {
    return '$count nel backup';
  }

  @override
  String get backup_entityTxSplitsPresets =>
      'Transazioni, suddivisioni e modelli';

  @override
  String get backup_entityRecurringHistory =>
      'Pagamenti ricorrenti e cronologia';

  @override
  String get backup_entityLoansPayments => 'Prestiti e pagamenti';

  @override
  String get backup_entityLentContacts => 'Prestiti personali e contatti';

  @override
  String get backup_entityAssetsValuables => 'Beni e proprietà';

  @override
  String get backup_entityWishlistGoals => 'Lista desideri e obiettivi';

  @override
  String get common_perDay => '/ giorno';

  @override
  String common_daysShort(int count) {
    return '$count g';
  }

  @override
  String get common_splitCaps => 'DIVISO';

  @override
  String budget_deletedCategory(String name) {
    return '$name eliminato';
  }

  @override
  String get loans_paymentDeleted => 'Pagamento eliminato';

  @override
  String certificates_collectionDayLabel(String frequency, int day) {
    return '$frequency (Giorno $day)';
  }

  @override
  String add_transaction_duplicateItem(
      String amount, String date, String desc) {
    return '• $amount il $date$desc';
  }

  @override
  String creditCard_billPaymentDesc(String name) {
    return 'Pagamento carta di credito — $name';
  }

  @override
  String get onboarding_defaultBankName => 'Banca Principale';

  @override
  String get onboarding_defaultCardholder => 'MEMBRO EXPENSY';

  @override
  String get onboarding_defaultUser => 'Utente';

  @override
  String get export_excelSheetName => 'Transazioni';

  @override
  String get export_headerDate => 'Data';

  @override
  String get export_headerDescription => 'Descrizione';

  @override
  String get export_headerType => 'Tipo';

  @override
  String get export_headerAmount => 'Importo';

  @override
  String get export_headerCurrency => 'Valuta';

  @override
  String get export_headerAccount => 'Conto';

  @override
  String get export_headerCategory => 'Categoria';

  @override
  String get export_headerSubcategory => 'Sottocategoria';

  @override
  String get export_headerNote => 'Nota';

  @override
  String get cat_food_exp => 'Cibo e Ristoranti';

  @override
  String get cat_transport => 'Trasporti';

  @override
  String get cat_shopping => 'Acquisti';

  @override
  String get cat_bills => 'Bollette e Utenze';

  @override
  String get cat_health => 'Salute';

  @override
  String get cat_entertainment => 'Intrattenimento';

  @override
  String get cat_education => 'Istruzione';

  @override
  String get cat_personal => 'Cura Personale';

  @override
  String get cat_salary => 'Stipendio';

  @override
  String get cat_freelance => 'Freelance';

  @override
  String get cat_investments => 'Investimenti';

  @override
  String get cat_gifts => 'Regali';

  @override
  String get cat_other_inc => 'Altre Entrate';

  @override
  String get cat_other_exp => 'Altre Spese';

  @override
  String get cat_sys_transfer => 'Trasferimento';

  @override
  String get cat_sys_investment => 'Investimento';

  @override
  String get sub_groceries => 'Spesa';

  @override
  String get sub_restaurants => 'Ristoranti';

  @override
  String get sub_delivery => 'Consegna';

  @override
  String get sub_coffee_tea => 'Caffè e Tè';

  @override
  String get sub_fuel => 'Carburante';

  @override
  String get sub_public_transit => 'Trasporto Pubblico';

  @override
  String get sub_taxi_ride => 'Taxi e Corse';

  @override
  String get sub_maintenance => 'Manutenzione';

  @override
  String get sub_parking_tolls => 'Parcheggio e Pedaggi';

  @override
  String get sub_clothing => 'Abbigliamento';

  @override
  String get sub_electronics => 'Elettronica';

  @override
  String get sub_home_furniture => 'Casa e Arredo';

  @override
  String get sub_gifts => 'Regali';

  @override
  String get sub_electricity => 'Elettricità';

  @override
  String get sub_internet => 'Internet';

  @override
  String get sub_water => 'Acqua';

  @override
  String get sub_phone => 'Telefono';

  @override
  String get sub_medicine => 'Farmaci';

  @override
  String get sub_doctor => 'Medico';

  @override
  String get sub_movies => 'Cinema';

  @override
  String get sub_games => 'Giochi';

  @override
  String get sub_subscriptions => 'Abbonamenti';

  @override
  String get notif_overBudgetTitle => '🚨 Budget superato';

  @override
  String notif_overBudgetBody(String category, String amount, String period) {
    return '$category — $amount oltre il tuo limite ($period)';
  }

  @override
  String get notif_goalReachedTitle => '🎉 Obiettivo raggiunto';

  @override
  String notif_goalReachedBody(String amount, String name) {
    return 'Hai raggiunto il tuo obiettivo di $amount per $name!';
  }

  @override
  String get notif_certPayoutDueTitle => '📈 Cedola certificato in scadenza';

  @override
  String get notif_certPayoutUpcomingTitle => '📈 Prossima cedola certificato';

  @override
  String notif_certPayoutBody(String name) {
    return 'Il rendimento per $name scade oggi.';
  }

  @override
  String notif_certPayoutSoonBody(String name) {
    return 'Il rendimento per $name scade tra 2 giorni.';
  }

  @override
  String get notif_creditBillDueTodayTitle =>
      '💳 Estratto conto in scadenza oggi';

  @override
  String get notif_creditBillDueSoonTitle => '💳 Estratto conto in scadenza';

  @override
  String get notif_dailyReminderTitle => '📝 Promemoria giornaliero';

  @override
  String get notif_dailyReminderBody =>
      'Non dimenticare di registrare le spese di oggi.';

  @override
  String notif_lendedDueTitle(String emoji, String name) {
    return '$emoji Scadenza: $name';
  }

  @override
  String get notif_loanPaymentDueTitle => '🏦 Rata prestito in scadenza';

  @override
  String notif_loanPaymentDueBody(String name) {
    return 'La rata di $name scade oggi.';
  }

  @override
  String get notif_autoBackupFailedTitle => 'Backup automatico non riuscito';

  @override
  String notif_autoBackupFailedBody(String error) {
    return 'Expensy non è riuscito a creare il backup programmato: $error';
  }

  @override
  String notif_recurringTransferBody(String amount) {
    return 'Trasferimento di $amount in scadenza';
  }

  @override
  String notif_recurringIncomeBody(String amount) {
    return 'Entrata di $amount in scadenza';
  }

  @override
  String notif_recurringExpenseBody(String amount) {
    return 'Pagamento di $amount in scadenza';
  }

  @override
  String notif_creditBillDueTodayBody(String name) {
    return 'La tua fattura $name scade oggi.';
  }

  @override
  String notif_creditBillDueSoonBody(String name) {
    return 'La tua fattura $name scade tra 2 giorni.';
  }

  @override
  String notif_lendedLentDueBody(String amount, String name) {
    return '$amount che hai prestato a $name scade oggi';
  }

  @override
  String notif_lendedBorrowedDueBody(String amount, String name) {
    return '$amount che hai preso in prestito da $name scade oggi';
  }

  @override
  String notif_recurringTransferDueSoonBody(String amount) {
    return 'Trasferimento di $amount in scadenza tra 2 giorni';
  }

  @override
  String notif_recurringIncomeDueSoonBody(String amount) {
    return '$amount atteso tra 2 giorni';
  }

  @override
  String notif_recurringExpenseDueSoonBody(String amount) {
    return '$amount in scadenza tra 2 giorni';
  }
}
