// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Teuer';

  @override
  String get settings_title => 'Einstellungen';

  @override
  String get settings_appearance => 'Erscheinungsbild';

  @override
  String get settings_theme => 'Thema';

  @override
  String get settings_system => 'System';

  @override
  String get settings_light => 'Hell';

  @override
  String get settings_dark => 'Dunkel';

  @override
  String get settings_amoledTitle => 'Reines Schwarz (AMOLED)';

  @override
  String get settings_amoledSubtitle =>
      'Erzwingt schwarze Hintergründe im dunklen Modus';

  @override
  String get settings_systemDefault => 'Systemstandard';

  @override
  String get settings_dynamicColor => 'Dynamische Farbe';

  @override
  String get settings_dynamicColorSubtitle =>
      'Verwenden Sie Systemhintergrundfarben';

  @override
  String get settings_accentColor => 'Akzentfarbe';

  @override
  String get settings_accentColorSubtitle =>
      'Wählen Sie eine Ausgangsfarbe für die App';

  @override
  String get settings_appFont => 'App-Schriftart';

  @override
  String get settings_currency => 'Währung';

  @override
  String get settings_defaultCurrency => 'Standardwährung';

  @override
  String get settings_preferences => 'Präferenzen';

  @override
  String get settings_weekStartsOn => 'Woche beginnt am';

  @override
  String get settings_monday => 'Montag';

  @override
  String get settings_sunday => 'Sonntag';

  @override
  String get settings_hideBalance => 'Guthaben ausblenden';

  @override
  String get settings_hideBalanceSubtitle =>
      'Zeige ••••• anstelle von Beträgen';

  @override
  String get settings_language => 'Sprache';

  @override
  String get settings_profile => 'Profil';

  @override
  String get settings_displayName => 'Anzeigename';

  @override
  String get settings_notSet => 'Nicht festgelegt';

  @override
  String get settings_about => 'Über';

  @override
  String get settings_version => 'Version';

  @override
  String get settings_privacy => 'Datenschutz';

  @override
  String get settings_privacySubtitle =>
      'Alle Daten werden lokal gespeichert — 100% offline';

  @override
  String get settings_github => 'GitHub';

  @override
  String get settings_githubSubtitle => 'Quellcode anzeigen';

  @override
  String get settings_developer => 'Entwickler';

  @override
  String get settings_developerSubtitle =>
      'Entdecken Sie weitere Projekte von Mina Android';

  @override
  String get settings_githubProfile => 'GitHub-Profil';

  @override
  String get settings_developerWebsite => 'Entwickler-Website';

  @override
  String get settings_close => 'Schließen';

  @override
  String get settings_yourName => 'Dein Name';

  @override
  String get settings_cancel => 'Abbrechen';

  @override
  String get settings_save => 'Speichern';

  @override
  String recurring_expenses(Object count) {
    return 'Ausgaben ($count)';
  }

  @override
  String recurring_incomeList(Object count) {
    return 'Einnahmen ($count)';
  }

  @override
  String get recurring_monthly => 'Monatlich';

  @override
  String get recurring_weekly => 'Wöchentlich';

  @override
  String get recurring_noRecurringExpenses => 'Keine wiederkehrenden Ausgaben';

  @override
  String get recurring_noRecurringIncome => 'Keine wiederkehrenden Einnahmen';

  @override
  String get recurring_addExpense => 'Ausgabe hinzufügen';

  @override
  String get recurring_addIncome => 'Einnahme hinzufügen';

  @override
  String get recurring_tapPlusToAddOne => 'Tippe auf +, um eine hinzuzufügen';

  @override
  String recurring_fromOngoing(Object date) {
    return 'Ab $date · Laufend';
  }

  @override
  String recurring_paidPayments(Object paid, Object total) {
    return '$paid/$total bezahlt';
  }

  @override
  String recurring_totalAmount(Object amount) {
    return 'Gesamt: $amount';
  }

  @override
  String get recurring_overdue => 'Überfällig!';

  @override
  String get recurring_dueToday => 'Heute fällig';

  @override
  String recurring_dueInDays(Object days) {
    return 'Fällig in $days T';
  }

  @override
  String get recurring_edit => 'Bearbeiten';

  @override
  String get recurring_skipBtn => 'Überspringen';

  @override
  String recurring_nextDate(Object date) {
    return 'Nächste: $date';
  }

  @override
  String get recurring_pay => 'Bezahlen';

  @override
  String get recurring_del => 'Löschen';

  @override
  String recurring_historyCount(Object count) {
    return 'Verlauf ($count)';
  }

  @override
  String get recurring_paymentHistory => 'Zahlungsverlauf';

  @override
  String get recurring_notificationPermissionDenied =>
      'Benachrichtigungsberechtigung verweigert. Aktiviere sie unter Einstellungen → Apps → Expensy → Benachrichtigungen.';

  @override
  String get recurring_remindMeAt => 'Erinnere mich um';

  @override
  String get recurring_editRecurring => 'Wiederkehrende bearbeiten';

  @override
  String get recurring_addRecurring => 'Wiederkehrende Zahlung';

  @override
  String get recurring_name => 'Name';

  @override
  String get recurring_amountPerPayment => 'Betrag pro Zahlung';

  @override
  String recurring_firstDate(Object date) {
    return 'Erste: $date';
  }

  @override
  String recurring_lastDate(Object date) {
    return 'Letzte: $date';
  }

  @override
  String get recurring_noLastPaymentOngoing => 'Keine letzte Zahlung (laufend)';

  @override
  String get accounts_refreshExchangeRates => 'Wechselkurse aktualisieren';

  @override
  String get accounts_noAccounts => 'Keine Konten';

  @override
  String get accounts_tapPlusToAddYourFirst =>
      'Tippe auf +, um dein erstes Konto hinzuzufügen';

  @override
  String get accounts_fetchingExchangeRates => 'Wechselkurse werden abgerufen…';

  @override
  String get accounts_exchangeRatesUnavailable =>
      'Wechselkurse nicht verfügbar (offline). Guthaben in Landeswährung angezeigt.';

  @override
  String get accounts_unknown => 'Unbekannt';

  @override
  String accounts_ratesUpdated(Object timeStr) {
    return 'Kurse aktualisiert $timeStr · Tippe auf ↺ zum Aktualisieren';
  }

  @override
  String get accounts_goldCaps => 'GOLD';

  @override
  String get accounts_balance => 'Guthaben';

  @override
  String get accounts_income => 'Einnahmen';

  @override
  String get accounts_expense => 'Ausgaben';

  @override
  String get accounts_txs => 'Transaktionen';

  @override
  String get accounts_value => 'Wert';

  @override
  String get accounts_karat => 'Karat';

  @override
  String accounts_pure(Object percentage) {
    return '$percentage% rein';
  }

  @override
  String get accounts_weightLabel => 'Gewicht';

  @override
  String get accounts_perGram => 'Pro Gramm';

  @override
  String get accounts_bank => 'Bank';

  @override
  String get accounts_cash => 'Bargeld';

  @override
  String get accounts_savings => 'Ersparnisse';

  @override
  String get accounts_creditCard => 'Kreditkarte';

  @override
  String get accounts_eWallet => 'E-Wallet';

  @override
  String get accounts_gold => 'Gold';

  @override
  String get accounts_editAccount => 'Konto bearbeiten';

  @override
  String get accounts_addAccount => 'Neues Konto hinzufügen';

  @override
  String get accounts_accountName => 'Kontoname';

  @override
  String get accounts_weightInGrams => 'Gewicht in Gramm';

  @override
  String get accounts_initialBalance => 'Anfangssaldo';

  @override
  String get accounts_wontCountTowardYourHome =>
      'Zählt nicht zur Startbildschirm-Gesamtsumme';

  @override
  String get accounts_saveChanges => 'Änderungen speichern';

  @override
  String get accounts_addAccountBtn => 'Konto hinzufügen';

  @override
  String get accounts_fetchingGoldPrice => 'Goldpreis wird abgerufen…';

  @override
  String get accounts_goldPriceUnavailable =>
      'Goldpreis nicht verfügbar — überprüfe deine Verbindung';

  @override
  String lended_person_owesYou(Object name) {
    return '$name schuldet dir';
  }

  @override
  String lended_person_youOwe(Object name) {
    return 'Du schuldest $name';
  }

  @override
  String get lended_person_allSettledUp => 'Alles beglichen';

  @override
  String get lended_person_noRecordsYet => 'Noch keine Einträge';

  @override
  String get lended_person_tapPlusToLog =>
      'Tippe auf +, um verliehenes oder geliehenes Geld zu protokollieren';

  @override
  String get lended_person_name => 'Name';

  @override
  String get lended_person_notesOptional => 'Notizen (optional)';

  @override
  String get lended_person_lent => 'Verliehen';

  @override
  String get lended_person_borrowed => 'Geliehen';

  @override
  String get lended_person_overdue => 'Überfällig!';

  @override
  String lended_person_due(Object date) {
    return 'Fällig am $date';
  }

  @override
  String lended_person_reminderAt(Object time) {
    return 'Erinnerung um $time';
  }

  @override
  String get lended_person_notificationPermissionDenied =>
      'Benachrichtigungsberechtigung verweigert. Aktiviere sie unter Einstellungen → Apps → Expensy → Benachrichtigungen.';

  @override
  String get lended_person_remindMeAtPrompt => 'Erinnere mich um';

  @override
  String get lended_person_editRecord => 'Eintrag bearbeiten';

  @override
  String get lended_person_addRecord => 'Eintrag hinzufügen';

  @override
  String get lended_person_amount => 'Betrag';

  @override
  String lended_person_dueColon(Object date) {
    return 'Fällig: $date';
  }

  @override
  String get lended_person_noDueDate => 'Kein Fälligkeitsdatum';

  @override
  String get lended_person_setDueFirst =>
      'Lege zuerst ein Fälligkeitsdatum fest';

  @override
  String get lended_person_notifiedOnDue =>
      'Du wirst am Fälligkeitsdatum benachrichtigt';

  @override
  String get lended_person_getNotifiedWhenDue =>
      'Werde benachrichtigt, wenn dies fällig ist';

  @override
  String get lended_person_thatTimePassed =>
      'Diese Zeit ist heute bereits vergangen — du wirst stattdessen in Kürze benachrichtigt.';

  @override
  String lended_person_notificationFiresOn(Object date, Object time) {
    return 'Benachrichtigung wird am $date um $time ausgelöst.';
  }

  @override
  String get lended_person_saveChangesBtn => 'Änderungen speichern';

  @override
  String get lended_person_addRecordBtn => 'Eintrag hinzufügen';

  @override
  String get transactions_searchTransactions => 'Transaktionen suchen...';

  @override
  String get transactions_all => 'Alle';

  @override
  String get transactions_income => 'Einnahmen';

  @override
  String get transactions_expenses => 'Ausgaben';

  @override
  String get transactions_lent => 'Verliehen';

  @override
  String get transactions_borrowed => 'Geliehen';

  @override
  String get transactions_noTransactions => 'Keine Transaktionen';

  @override
  String get transactions_tapPlusToAddOne =>
      'Tippe auf +, um eine hinzuzufügen';

  @override
  String get transactions_today => 'Heute';

  @override
  String get transactions_yesterday => 'Gestern';

  @override
  String transactions_lentTo(Object name) {
    return 'Verliehen an $name';
  }

  @override
  String transactions_borrowedFrom(Object name) {
    return 'Geliehen von $name';
  }

  @override
  String get transactions_unknown => 'Unbekannt';

  @override
  String transactions_due(Object date) {
    return 'Fällig am $date';
  }

  @override
  String get transactions_unsettled => 'Offen';

  @override
  String get onboarding_restoreFailed =>
      'Wiederherstellung fehlgeschlagen: Die Datei ist möglicherweise beschädigt oder kein Expensy-Backup.';

  @override
  String get onboarding_continue => 'Weiter';

  @override
  String get onboarding_getStarted => 'Loslegen';

  @override
  String get onboarding_yourPersonalTracker =>
      'Dein persönlicher, 100% Offline-Finanztracker.\nHast du bereits ein Backup von einem anderen Gerät oder einer vorherigen Installation?';

  @override
  String get onboarding_restoring => 'Wird wiederhergestellt...';

  @override
  String get onboarding_chooseBackupFile => 'Backup-Datei auswählen';

  @override
  String get onboarding_letsGetYouSetUp => 'Lass uns dich einrichten';

  @override
  String get onboarding_yourName => 'Dein Name';

  @override
  String get onboarding_accountName => 'Kontoname';

  @override
  String get onboarding_bank => 'Bank';

  @override
  String get onboarding_cash => 'Bargeld';

  @override
  String get onboarding_savings => 'Ersparnisse';

  @override
  String get onboarding_credit => 'Kredit';

  @override
  String get onboarding_wallet => 'Geldbörse';

  @override
  String get onboarding_startingBalance => 'Anfangssaldo';

  @override
  String get backup_replaceDataWarning =>
      'Dies wird ALLE deine aktuellen Daten durch das Backup ersetzen.\nDies kann nicht rückgängig gemacht werden.';

  @override
  String get backup_whatsIncluded => 'Was enthalten ist';

  @override
  String get backup_backupDescription =>
      'Jedes Backup enthält all deine Daten — Konten, Transaktionen, wiederkehrende Zahlungen und deren Zahlungs-/Überspringungsverlauf, Budgets, Wunschlisten-Artikel, verliehene & geliehene Personen und Einträge, Vermögenswerte, Kategorien und App-Einstellungen.';

  @override
  String get backup_saving => 'Wird gespeichert...';

  @override
  String get backup_saveBackup => 'Backup speichern';

  @override
  String get backup_restoring => 'Wird wiederhergestellt...';

  @override
  String get backup_restoreBackupBtn => 'Backup wiederherstellen';

  @override
  String get backup_restoreWarningText =>
      'Kompatibel mit Backups von jeder App-Version. Fehlende Felder werden mit sicheren Standardwerten gefüllt.';

  @override
  String get backup_included => 'enthalten';

  @override
  String get backup_accounts => 'Konten';

  @override
  String get backup_transactions => 'Transaktionen';

  @override
  String get backup_recurringPayments => 'Wiederkehrende Zahlungen';

  @override
  String get backup_recurringHistory => 'Verlauf der wiederkehrenden Zahlungen';

  @override
  String get backup_budgets => 'Budgets';

  @override
  String get backup_wishlist => 'Wunschliste';

  @override
  String get backup_lentPeople => 'Verliehen/Geliehen — Personen';

  @override
  String get backup_lentRecords => 'Verliehen/Geliehen — Einträge';

  @override
  String get backup_assets => 'Vermögenswerte';

  @override
  String get backup_categories => 'Kategorien';

  @override
  String get backup_settings => 'Einstellungen';

  @override
  String backup_backupSavedSuccessfully(Object savedPath) {
    return 'Backup erfolgreich gespeichert:\n$savedPath';
  }

  @override
  String backup_backupFailed(Object error) {
    return 'Backup fehlgeschlagen: $error';
  }

  @override
  String backup_upgradedFrom(Object originalVersion, Object schemaVersion) {
    return ' (aktualisiert von v$originalVersion → v$schemaVersion)';
  }

  @override
  String backup_dataRestoredSuccessfully(Object vLabel) {
    return 'Daten erfolgreich wiederhergestellt!$vLabel';
  }

  @override
  String backup_restoreFailed(Object error) {
    return 'Wiederherstellung fehlgeschlagen: $error';
  }

  @override
  String get backup_restoreFailedCorrupted =>
      'Wiederherstellung fehlgeschlagen: Die Datei ist möglicherweise beschädigt oder kein Expensy-Backup.';

  @override
  String get budget_noBudgetsYet => 'Noch keine Budgets';

  @override
  String get budget_tapToAddBudget =>
      'Tippe auf +, um ein Ausgabenlimit pro Kategorie festzulegen';

  @override
  String get budget_budgeted => 'Budgetiert';

  @override
  String get budget_leftToSpend => 'Left to Spend';

  @override
  String get budget_spent => 'Ausgegeben';

  @override
  String get budget_overLimit => 'Über dem Limit';

  @override
  String get budget_unknown => 'Unbekannt';

  @override
  String get budget_weeklyLabel => 'Wöchentlich';

  @override
  String get budget_monthlyLabel => 'Monatlich';

  @override
  String budget_overAmount(Object amount) {
    return '$amount darüber';
  }

  @override
  String budget_leftAmount(Object amount) {
    return '$amount übrig';
  }

  @override
  String budget_percentUsed(Object percent) {
    return '$percent% verbraucht';
  }

  @override
  String get budget_editBudget => 'Budget bearbeiten';

  @override
  String get budget_setBudget => 'Neues Budget hinzufügen';

  @override
  String get budget_budgetAmount => 'Budgetbetrag';

  @override
  String budget_previewFor(Object catName) {
    return 'Vorschau für \"$catName\"';
  }

  @override
  String budget_spentAmount(Object amount) {
    return 'Ausgegeben: $amount';
  }

  @override
  String budget_ofAmount(Object amount) {
    return 'von $amount';
  }

  @override
  String get budget_saveChanges => 'Änderungen speichern';

  @override
  String get budget_budget => 'Budget';

  @override
  String get insights_other => 'Andere';

  @override
  String get insights_noDataYet => 'Noch keine Daten';

  @override
  String get insights_addSomeTransactions =>
      'Füge einige Transaktionen hinzu, um Einblicke zu sehen';

  @override
  String get insights_thisMonthVsLastMonth => 'Dieser Monat vs. Letzter Monat';

  @override
  String get insights_dailyAverage => 'Tagesdurchschnitt';

  @override
  String insights_perDayBasedOn(Object days) {
    return 'pro Tag · basierend auf $days Tagen diesen Monat';
  }

  @override
  String get insights_incomeVsExpenses => 'Einnahmen vs. Ausgaben';

  @override
  String insights_incomeAmount(Object amount) {
    return 'Einnahmen $amount';
  }

  @override
  String insights_expensesAmount(Object amount) {
    return 'Ausgaben $amount';
  }

  @override
  String insights_percentSaved(Object percent) {
    return '$percent% diesen Monat gespart';
  }

  @override
  String get insights_topSpendingCategories => 'Top Ausgabenkategorien';

  @override
  String insights_percentOfTotal(Object percent) {
    return '$percent% der Gesamtsumme';
  }

  @override
  String get insights_biggestExpenseThisMonth => 'Größte Ausgabe diesen Monat';

  @override
  String get insights_categoryTrends => 'Kategorietrends (vs. Letzter Monat)';

  @override
  String get insights_12MonthTrend => '12-Monats-Trend';

  @override
  String get insights_incomeLabel => 'Einnahmen';

  @override
  String get insights_expensesLabel => 'Ausgaben';

  @override
  String get categories_expenseLabel => 'Ausgabe';

  @override
  String get categories_incomeLabel => 'Einnahme';

  @override
  String get categories_editCategory => 'Kategorie bearbeiten';

  @override
  String get categories_addCategory => 'Kategorie hinzufügen';

  @override
  String get categories_categoryName => 'Kategoriename';

  @override
  String get categories_saveChanges => 'Änderungen speichern';

  @override
  String get statistics_other => 'Andere';

  @override
  String get statistics_allAccounts => 'Alle Konten';

  @override
  String get statistics_income => 'Einnahmen';

  @override
  String get statistics_expenses => 'Ausgaben';

  @override
  String get statistics_expense => 'Ausgabe';

  @override
  String get statistics_net => 'Netto';

  @override
  String statistics_6MonthOverviewAccount(Object accountName) {
    return '6-Monats-Übersicht · $accountName';
  }

  @override
  String get statistics_6MonthOverview => '6-Monats-Übersicht';

  @override
  String statistics_percentOfBudget(Object percent) {
    return '$percent% des Budgets';
  }

  @override
  String get add_transaction_editTransaction => 'Transaktion bearbeiten';

  @override
  String get add_transaction_addTransaction => 'Transaktion eingeben';

  @override
  String get add_transaction_amount => 'Betrag';

  @override
  String add_transaction_conversionPreview(Object accountName, Object amount) {
    return '≈ $amount wird von $accountName abgezogen';
  }

  @override
  String get add_transaction_accountFallback => 'Konto';

  @override
  String get add_transaction_descriptionOptional => 'Beschreibung (optional)';

  @override
  String get add_transaction_noteOptional => 'Notiz (optional)';

  @override
  String get add_transaction_saveChanges => 'Änderungen speichern';

  @override
  String get more_statistics => 'Statistiken';

  @override
  String get more_statisticsSub => 'Diagramme & monatliche Zusammenfassung';

  @override
  String get more_insights => 'Einblicke';

  @override
  String get more_insightsSub => 'Trends, Durchschnitte & Kategorieanalyse';

  @override
  String get more_currencyConverter => 'Währungsrechner';

  @override
  String get more_currencyConverterSub => 'Sofort zwischen Währungen umrechnen';

  @override
  String get more_wishlist => 'Wunschliste';

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
  String get more_lentMoney => 'Verliehenes Geld';

  @override
  String more_lentMoneySub(Object count) {
    return '$count ausstehend';
  }

  @override
  String get more_assets => 'Vermögenswerte';

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
  String get more_categories => 'Kategorien';

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
  String get more_exportTransactions => 'Transaktionen exportieren';

  @override
  String get more_exportTransactionsSub => 'Als Excel speichern (.xlsx)';

  @override
  String get more_backupRestore => 'Backup & Wiederherstellen';

  @override
  String get more_backupRestoreSub => 'Daten speichern oder laden';

  @override
  String get more_settings => 'Einstellungen';

  @override
  String get more_settingsSub => 'Thema, Währung & Präferenzen';

  @override
  String home_greeting(Object name) {
    return 'Hallo, $name 👋';
  }

  @override
  String get home_there => 'da';

  @override
  String get home_income => 'Einnahmen';

  @override
  String get home_expenses => 'Ausgaben';

  @override
  String get home_net => 'Netto';

  @override
  String get wishlist_noItems => 'Keine Wunschlisten-Artikel';

  @override
  String get wishlist_noItemsSub =>
      'Tippe auf +, um Artikel hinzuzufügen, für die du sparst';

  @override
  String get wishlist_editItem => 'Artikel bearbeiten';

  @override
  String get wishlist_addWishlistItem => 'Wunschlisten-Artikel hinzufügen';

  @override
  String get wishlist_itemName => 'Artikelname';

  @override
  String get wishlist_targetPrice => 'Zielpreis';

  @override
  String get wishlist_priorityLow => 'Niedrig';

  @override
  String get wishlist_priorityMedium => 'Mittel';

  @override
  String get wishlist_priorityHigh => 'Hoch';

  @override
  String get wishlist_notesOptional => 'Notizen (optional)';

  @override
  String get wishlist_saveChanges => 'Änderungen speichern';

  @override
  String get wishlist_addItem => 'Artikel hinzufügen';

  @override
  String get lended_theyOweMe => 'Sie schulden mir';

  @override
  String get lended_iOweThem => 'Ich schulde ihnen';

  @override
  String get lended_net => 'Netto';

  @override
  String get lended_noOneYet => 'Noch niemand';

  @override
  String get lended_noOneYetSub =>
      'Tippe auf +, um eine Person hinzuzufügen, der du Geld leihst oder von der du Geld leihst';

  @override
  String get lended_owesYou => 'Schuldet dir';

  @override
  String get lended_youOwe => 'Du schuldest';

  @override
  String get lended_settledUp => 'Beglichen';

  @override
  String get lended_noActiveRecords => 'Keine aktiven Einträge';

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
  String get lended_editPerson => 'Person bearbeiten';

  @override
  String get lended_addPerson => 'Person hinzufügen';

  @override
  String get lended_name => 'Name';

  @override
  String get lended_notesOptional => 'Notizen (optional)';

  @override
  String get lended_saveChanges => 'Änderungen speichern';

  @override
  String get assets_totalAssets => 'Gesamtvermögen';

  @override
  String get assets_items => 'Artikel';

  @override
  String get assets_noAssetsYet => 'Noch keine Vermögenswerte';

  @override
  String get assets_noAssetsYetSub =>
      'Tippe auf +, um ein Produkt oder einen Vermögenswert hinzuzufügen';

  @override
  String get assets_editAsset => 'Vermögenswert bearbeiten';

  @override
  String get assets_addAsset => 'Vermögenswert hinzufügen';

  @override
  String get assets_productAssetName => 'Produkt- / Vermögenswertname';

  @override
  String get assets_value => 'Wert';

  @override
  String get assets_notesOptional => 'Notizen (optional)';

  @override
  String get assets_saveChanges => 'Änderungen speichern';

  @override
  String get currency_converter_loadingRates => 'Wechselkurse werden geladen…';

  @override
  String get currency_converter_ratesUnavailable =>
      'Wechselkurse nicht verfügbar. Stelle eine Internetverbindung her und synchronisiere.';

  @override
  String get currency_converter_rateAgeJustNow => 'Gerade eben';

  @override
  String currency_converter_rateAgeMins(Object minutes) {
    return 'Vor $minutes Min';
  }

  @override
  String currency_converter_rateAgeHours(Object hours) {
    return 'Vor $hours Std';
  }

  @override
  String currency_converter_rateAgeDays(Object days) {
    return 'Vor $days T';
  }

  @override
  String currency_converter_commonConversions(Object fromCurrency) {
    return 'Häufige Umrechnungen von $fromCurrency';
  }

  @override
  String transfer_fromAcc(Object currency) {
    return 'Von ($currency)';
  }

  @override
  String transfer_toAcc(Object currency) {
    return 'Nach ($currency)';
  }

  @override
  String get transfer_exchangeRatesNotLoaded =>
      'Wechselkurse nicht geladen — Betrag wird unverändert überwiesen';

  @override
  String get transfer_amount => 'Betrag';

  @override
  String get transfer_noteOptional => 'Notiz (optional)';

  @override
  String get export_from => 'Von';

  @override
  String get export_to => 'Bis';

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
    return 'Gespeichert: $path';
  }

  @override
  String get export_complete => 'Export abgeschlossen';

  @override
  String get export_exporting => 'Wird exportiert...';

  @override
  String get export_exportAsExcel => 'Als Excel exportieren';

  @override
  String shared_widgets_deleteConfirm(Object name) {
    return '\"$name\" löschen? Dies kann nicht rückgängig gemacht werden.';
  }

  @override
  String get shared_widgets_searchByCode => 'Nach Code oder Name suchen...';

  @override
  String get accounts_accounts => 'Konten';

  @override
  String get accounts_totalBalance => 'Gesamtsaldo';

  @override
  String get accounts_excluded => 'Ausgeschlossen';

  @override
  String get accounts_goldPriceNotYetLoade =>
      'Goldpreis noch nicht geladen. Warten Sie einen Moment und versuchen Sie es erneut.';

  @override
  String get accounts_accountType => 'Kontotyp';

  @override
  String get accounts_currency => 'Währung';

  @override
  String get accounts_goldPurityKarat => 'Goldreinheit (Karat)';

  @override
  String get accounts_weight => 'Gewicht';

  @override
  String get accounts_excludeFromTotalBala => 'Vom Gesamtsaldo ausschließen';

  @override
  String get accounts_color => 'Farbe';

  @override
  String get accounts_liveGoldValue => 'Aktueller Goldwert';

  @override
  String get accounts_enterWeightAboveToSe =>
      'Geben Sie oben das Gewicht ein, um den Wert zu sehen';

  @override
  String get add_transaction_expense => 'Ausgabe';

  @override
  String get add_transaction_income => 'Einnahme';

  @override
  String get add_transaction_account => 'Konto';

  @override
  String get add_transaction_category => 'Kategorie';

  @override
  String get assets_assets => 'Vermögen';

  @override
  String get backup_restoreBackup => 'Backup wiederherstellen?';

  @override
  String get backup_cancel => 'Abbrechen';

  @override
  String get backup_replaceData => 'Daten ersetzen';

  @override
  String get backup_backupRestore => 'Sichern & Wiederherstellen';

  @override
  String get backup_everythingAlways => 'Alles, immer';

  @override
  String get backup_createBackup => 'Backup erstellen';

  @override
  String get backup_saveAsJson => 'Als JSON speichern';

  @override
  String get backup_exportsAllAppDataToA =>
      'Exportiert alle App-Daten in eine tragbare Datei';

  @override
  String get backup_restoreBackup_ => 'Backup wiederherstellen';

  @override
  String get backup_loadFromJson => 'Aus JSON laden';

  @override
  String get backup_picksABackupFileAndR =>
      'Wählt eine Backup-Datei aus und stellt sie wieder her';

  @override
  String get backup_thisOverwritesAllCur =>
      'Dies überschreibt ALLE aktuellen Daten.';

  @override
  String get budget_budgets => 'Budgets';

  @override
  String get budget_empty => '·';

  @override
  String get budget_overBudget => 'Budget überschritten';

  @override
  String get budget_thisCategoryAlreadyH =>
      'Diese Kategorie hat bereits ein Budget. Tippen zum Bearbeiten.';

  @override
  String get budget_period => 'Zeitraum';

  @override
  String get budget_monthly => 'Monatlich';

  @override
  String get budget_weekly => 'Wöchentlich';

  @override
  String get budget_category => 'Kategorie';

  @override
  String get categories_categories => 'Kategorien';

  @override
  String get categories_expense => 'Ausgabe';

  @override
  String get categories_income => 'Einnahme';

  @override
  String get categories_color => 'Farbe';

  @override
  String get categories_icon => 'Symbol';

  @override
  String get categories_autoBasedOnName => 'Auto (basierend auf Namen)';

  @override
  String get categories_expenseCategories => 'Ausgabenkategorien';

  @override
  String get categories_incomeCategories => 'Einnahmenkategorien';

  @override
  String get currency_converter_currencyConverter => 'Währungsrechner';

  @override
  String get currency_converter_amount => 'Betrag';

  @override
  String get currency_converter_convertedTo => 'Umrechnung in';

  @override
  String get export_exportTransactions => 'Transaktionen exportieren';

  @override
  String get export_dateRange => 'Datumsbereich';

  @override
  String get export_formatExcelXlsx => 'Format: Excel (.xlsx)';

  @override
  String get home_totalBalance => 'Gesamtsaldo';

  @override
  String get home_accounts => 'Konten';

  @override
  String get home_recentTransactions => 'Letzte Transaktionen';

  @override
  String get home_noTransactionsYet => 'Noch keine Transaktionen';

  @override
  String get home_add => 'Hinzufügen';

  @override
  String get insights_insights => 'Einblicke';

  @override
  String get lended_person_deletePerson => 'Person löschen';

  @override
  String get lended_person_editPerson => 'Person bearbeiten';

  @override
  String get lended_person_color => 'Farbe';

  @override
  String get lended_person_saveChanges => 'Änderungen speichern';

  @override
  String get lended_person_settled => 'BEGLICHEN';

  @override
  String get lended_person_settle => 'Begleichen';

  @override
  String get lended_person_setADueDateFirstToEn =>
      'Legen Sie zuerst ein Fälligkeitsdatum fest, um Erinnerungen zu aktivieren.';

  @override
  String get lended_person_iLent => 'Ich habe verliehen';

  @override
  String get lended_person_iBorrowed => 'Ich habe geliehen';

  @override
  String get lended_person_accountOptional => 'Konto (optional)';

  @override
  String get lended_person_dueDateReminder => 'Fälligkeitserinnerung';

  @override
  String get lended_person_remindMeAt => 'Erinnere mich um';

  @override
  String get lended_person_active => 'Aktiv';

  @override
  String get lended_person_settled_ => 'Beglichen';

  @override
  String get lended_lentMoney => 'Verliehenes Geld';

  @override
  String get lended_overdue => 'ÜBERFÄLLIG';

  @override
  String get lended_color => 'Farbe';

  @override
  String get more_more => 'Mehr';

  @override
  String get onboarding_back => 'Zurück';

  @override
  String get onboarding_welcomeToExpensy => 'Willkommen bei Expensy!';

  @override
  String get onboarding_restoreABackup => 'Ein Backup wiederherstellen';

  @override
  String get onboarding_loadAPreviouslySaved =>
      'Laden Sie eine zuvor gespeicherte Expensy JSON-Datei';

  @override
  String get onboarding_or => 'oder';

  @override
  String get onboarding_startFresh => 'Neu anfangen';

  @override
  String get onboarding_firstWhatShouldWeCal =>
      'Zuerst, wie sollen wir Sie nennen?';

  @override
  String get onboarding_defaultCurrency => 'Standardwährung';

  @override
  String get onboarding_thisWillBeUsedAcross =>
      'Dies wird in der gesamten App verwendet.\nSie können dies später in den Einstellungen ändern.';

  @override
  String get onboarding_searchAllCurrencies => 'Alle Währungen durchsuchen';

  @override
  String get onboarding_yourFirstAccount => 'Ihr erstes Konto';

  @override
  String get onboarding_setUpYourMainAccount =>
      'Richten Sie Ihr Hauptkonto ein, um mit der Verfolgung zu beginnen.';

  @override
  String get onboarding_accountType => 'Kontotyp';

  @override
  String get onboarding_currency => 'Währung';

  @override
  String get onboarding_color => 'Farbe';

  @override
  String get recurring_recurring => 'Wiederkehrend';

  @override
  String get recurring_income => 'EINNAHME';

  @override
  String get recurring_2D => '−2t';

  @override
  String get recurring_skipNextPayment => 'Nächste Zahlung überspringen?';

  @override
  String get recurring_cancel => 'Abbrechen';

  @override
  String get recurring_skip => 'Überspringen';

  @override
  String get recurring_noHistoryYet => 'Noch kein Verlauf';

  @override
  String get recurring_expense => 'Ausgabe';

  @override
  String get recurring_income_ => 'Einnahme';

  @override
  String get recurring_every => 'Alle ';

  @override
  String get recurring_days => 'Tage';

  @override
  String get recurring_weeks => 'Wochen';

  @override
  String get recurring_months => 'Monate';

  @override
  String get recurring_years => 'Jahre';

  @override
  String get recurring_payments => 'Zahlungen';

  @override
  String get recurring_totalCost => 'Gesamtkosten';

  @override
  String get recurring_account => 'Konto';

  @override
  String get recurring_category => 'Kategorie';

  @override
  String get recurring_paymentReminder => 'Zahlungserinnerung';

  @override
  String get recurring_notificationWillFire =>
      'Die Benachrichtigung wird am nächsten Fälligkeitsdatum zu dieser Zeit ausgelöst.';

  @override
  String get recurring_remind2DaysBefore => '2 Tage vorher erinnern';

  @override
  String get statistics_statistics => 'Statistiken';

  @override
  String get statistics_expensesByCategory => 'Ausgaben nach Kategorie';

  @override
  String get transactions_transactions => 'Transaktionen';

  @override
  String get transactions_settled => 'Beglichen';

  @override
  String get transfer_transfer => 'Überweisung';

  @override
  String get transfer_from => 'VON';

  @override
  String get transfer_to => 'AN';

  @override
  String get transfer_enterAnAmountToSeeTh =>
      'Geben Sie einen Betrag ein, um die Umrechnung zu sehen';

  @override
  String get wishlist_wishlist => 'Wunschzettel';

  @override
  String get wishlist_priority => 'Priorität';

  @override
  String get shared_widgets_delete => 'Löschen?';

  @override
  String get shared_widgets_cancel => 'Abbrechen';

  @override
  String get shared_widgets_delete_ => 'Löschen';

  @override
  String get shared_widgets_none => 'Keine';

  @override
  String get shared_widgets_selectCurrency => 'Währung wählen';

  @override
  String get main_home => 'Start';

  @override
  String get main_transactions => 'Transaktionen';

  @override
  String get main_recurring => 'Wiederkehrend';

  @override
  String get main_accounts => 'Konten';

  @override
  String get main_budgets => 'Budgets';

  @override
  String get main_more => 'Mehr';

  @override
  String get onboarding_chooseLanguage => 'Sprache wählen';

  @override
  String get error_required => 'Dieses Feld ist erforderlich';

  @override
  String recurring_subscriptions(Object count) {
    return 'Abonnements ($count)';
  }

  @override
  String recurring_installments(Object count) {
    return 'Ratenzahlungen ($count)';
  }

  @override
  String get recurring_recurringType => 'Wiederholungsart';

  @override
  String get recurring_subscription => 'Abonnement';

  @override
  String get recurring_installment => 'Ratenzahlung';

  @override
  String get recurring_installmentsRequireEndDate =>
      'Ratenzahlungen müssen ein endgültiges Zahlungsdatum haben.';

  @override
  String get backup_importFromOtherApps => 'Aus anderen Apps importieren';

  @override
  String get backup_importDescription =>
      'Daten aus unterstützten Apps importieren';

  @override
  String get backup_importFromGreenStash =>
      'Aus GreenStash importieren (.json)';

  @override
  String get backup_automaticBackup => 'Automatische Sicherung';

  @override
  String get backup_dailyAutoBackup => 'Tägliche automatische Sicherung';

  @override
  String backup_runsDailyAt(String time) {
    return 'Läuft täglich um $time';
  }

  @override
  String backup_lastBackup(String time) {
    return 'Letzte Sicherung: $time';
  }

  @override
  String backup_savingTo(String path) {
    return 'Speichern unter: $path';
  }

  @override
  String get backup_changeTime => 'Zeit ändern';

  @override
  String get backup_changeFolder => 'Ordner ändern';

  @override
  String get budget_budgetsAndGoals => 'Budgets und Ziele';

  @override
  String get onboarding_restoreGreenStash =>
      'Wiederherstellung von GreenStash (.json)';

  @override
  String get savings_goalNotFound => 'Ziel nicht gefunden';

  @override
  String get savings_savedSoFar => 'Bisher gespeichert';

  @override
  String get savings_target => 'Ziel';

  @override
  String savings_targetDate(String date) {
    return 'Target Date: $date';
  }

  @override
  String get savings_contribute => 'Mitmachen';

  @override
  String get savings_withdraw => 'Zurückziehen';

  @override
  String get savings_noAccounts =>
      'Keine Konten verfügbar. Bitte fügen Sie zuerst ein Konto hinzu.';

  @override
  String get settings_budgetAlerts => 'Budgetwarnungen';

  @override
  String get settings_budgetAlertsSub =>
      'Benachrichtigen, wenn ein Budget oder Ziel erreicht ist';

  @override
  String get settings_dailyReminder => 'Tägliche Erinnerung';

  @override
  String get settings_dailyReminderSub =>
      'Erinnern Sie daran, Transaktionen täglich zu protokollieren';

  @override
  String get settings_reminderTime => 'Erinnerungszeit';

  @override
  String get settings_hapticFeedback => 'Haptisches Feedback';

  @override
  String get settings_hapticFeedbackSub => 'Bei Interaktionen vibrieren';

  @override
  String get savings_saveGoal => 'Ziel speichern';
}
