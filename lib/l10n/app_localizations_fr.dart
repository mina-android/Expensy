// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Dépense';

  @override
  String get settings_title => 'Paramètres';

  @override
  String get settings_appearance => 'Apparence';

  @override
  String get settings_theme => 'Thème';

  @override
  String get settings_system => 'Système';

  @override
  String get settings_light => 'Clair';

  @override
  String get settings_dark => 'Sombre';

  @override
  String get settings_amoledTitle => 'Noir pur (AMOLED)';

  @override
  String get settings_amoledSubtitle =>
      'Force les arrière-plans noirs en mode sombre';

  @override
  String get settings_systemDefault => 'Défaut du système';

  @override
  String get settings_dynamicColor => 'Couleur dynamique';

  @override
  String get settings_dynamicColorSubtitle =>
      'Utiliser les couleurs du papier peint du système';

  @override
  String get settings_accentColor => 'Couleur d\'accentuation';

  @override
  String get settings_accentColorSubtitle =>
      'Choisissez une couleur de graine pour l\'application';

  @override
  String get settings_appFont => 'Police de l\'application';

  @override
  String get settings_currency => 'Devise';

  @override
  String get settings_defaultCurrency => 'Devise par défaut';

  @override
  String get settings_preferences => 'Préférences';

  @override
  String get settings_weekStartsOn => 'La semaine commence le';

  @override
  String get settings_monday => 'Lundi';

  @override
  String get settings_sunday => 'Dimanche';

  @override
  String get settings_hideBalance => 'Masquer le solde';

  @override
  String get settings_hideBalanceSubtitle =>
      'Afficher ••••• au lieu des montants';

  @override
  String get settings_language => 'Langue';

  @override
  String get settings_profile => 'Profil';

  @override
  String get settings_displayName => 'Nom d\'affichage';

  @override
  String get settings_notSet => 'Non défini';

  @override
  String get settings_about => 'À propos';

  @override
  String get settings_version => 'Version';

  @override
  String get settings_privacy => 'Confidentialité';

  @override
  String get settings_privacySubtitle =>
      'Toutes les données stockées localement — 100% hors ligne';

  @override
  String get settings_github => 'GitHub';

  @override
  String get settings_githubSubtitle => 'Voir le code source';

  @override
  String get settings_developer => 'Développeur';

  @override
  String get settings_developerSubtitle =>
      'Découvrez d\'autres projets par Mina Android';

  @override
  String get settings_githubProfile => 'Profil GitHub';

  @override
  String get settings_developerWebsite => 'Site du développeur';

  @override
  String get settings_close => 'Fermer';

  @override
  String get settings_yourName => 'Votre nom';

  @override
  String get settings_cancel => 'Annuler';

  @override
  String get settings_save => 'Enregistrer';

  @override
  String recurring_expenses(Object count) {
    return 'Dépenses ($count)';
  }

  @override
  String recurring_incomeList(Object count) {
    return 'Revenus ($count)';
  }

  @override
  String get recurring_monthly => 'Mensuel';

  @override
  String get recurring_weekly => 'Hebdomadaire';

  @override
  String get recurring_noRecurringExpenses => 'Aucune dépense récurrente';

  @override
  String get recurring_noRecurringIncome => 'Aucun revenu récurrent';

  @override
  String get recurring_addExpense => 'Ajouter une dépense';

  @override
  String get recurring_addIncome => 'Ajouter un revenu';

  @override
  String get recurring_tapPlusToAddOne => 'Appuyez sur + pour en ajouter';

  @override
  String recurring_fromOngoing(Object date) {
    return 'Depuis le $date · En cours';
  }

  @override
  String recurring_paidPayments(Object paid, Object total) {
    return '$paid/$total payés';
  }

  @override
  String recurring_totalAmount(Object amount) {
    return 'Total : $amount';
  }

  @override
  String get recurring_overdue => 'En retard !';

  @override
  String get recurring_dueToday => 'Dû aujourd\'hui';

  @override
  String recurring_dueInDays(Object days) {
    return 'Dû dans $days j';
  }

  @override
  String get recurring_edit => 'Modifier';

  @override
  String get recurring_skipBtn => 'Passer';

  @override
  String recurring_nextDate(Object date) {
    return 'Prochain : $date';
  }

  @override
  String get recurring_pay => 'Payer';

  @override
  String get recurring_del => 'Suppr';

  @override
  String recurring_historyCount(Object count) {
    return 'Historique ($count)';
  }

  @override
  String get recurring_paymentHistory => 'Historique des paiements';

  @override
  String get recurring_notificationPermissionDenied =>
      'Permission de notification refusée. Activez-la dans Paramètres → Applications → Expensy → Notifications.';

  @override
  String get recurring_remindMeAt => 'Me le rappeler à';

  @override
  String get recurring_editRecurring => 'Modifier la récurrence';

  @override
  String get recurring_addRecurring => 'Ajouter un paiement récurrent';

  @override
  String get recurring_name => 'Nom';

  @override
  String get recurring_amountPerPayment => 'Montant par paiement';

  @override
  String recurring_firstDate(Object date) {
    return 'Premier : $date';
  }

  @override
  String recurring_lastDate(Object date) {
    return 'Dernier : $date';
  }

  @override
  String get recurring_noLastPaymentOngoing =>
      'Pas de dernier paiement (en cours)';

  @override
  String get accounts_refreshExchangeRates => 'Actualiser les taux de change';

  @override
  String get accounts_noAccounts => 'Aucun compte';

  @override
  String get accounts_tapPlusToAddYourFirst =>
      'Appuyez sur + pour ajouter votre premier compte';

  @override
  String get accounts_fetchingExchangeRates =>
      'Récupération des taux de change…';

  @override
  String get accounts_exchangeRatesUnavailable =>
      'Taux de change indisponibles (hors ligne). Soldes affichés dans la devise native.';

  @override
  String get accounts_unknown => 'Inconnu';

  @override
  String accounts_ratesUpdated(Object timeStr) {
    return 'Taux mis à jour à $timeStr · Appuyez sur ↺ pour rafraîchir';
  }

  @override
  String get accounts_goldCaps => 'OR';

  @override
  String get accounts_balance => 'Solde';

  @override
  String get accounts_income => 'Revenus';

  @override
  String get accounts_expense => 'Dépenses';

  @override
  String get accounts_txs => 'Émissions';

  @override
  String get accounts_value => 'Valeur';

  @override
  String get accounts_karat => 'Carat';

  @override
  String accounts_pure(Object percentage) {
    return '$percentage% pur';
  }

  @override
  String get accounts_weightLabel => 'Poids';

  @override
  String get accounts_perGram => 'Par gramme';

  @override
  String get accounts_bank => 'Banque';

  @override
  String get accounts_cash => 'Espèces';

  @override
  String get accounts_savings => 'Épargne';

  @override
  String get accounts_creditCard => 'Carte de crédit';

  @override
  String get accounts_eWallet => 'Portefeuille électronique';

  @override
  String get accounts_gold => 'Or';

  @override
  String get accounts_editAccount => 'Modifier le compte';

  @override
  String get accounts_addAccount => 'Ajouter un nouveau compte';

  @override
  String get accounts_accountName => 'Nom du compte';

  @override
  String get accounts_weightInGrams => 'Poids en grammes';

  @override
  String get accounts_initialBalance => 'Solde initial';

  @override
  String get accounts_wontCountTowardYourHome =>
      'Ne comptera pas dans le total de votre écran d\'accueil';

  @override
  String get accounts_saveChanges => 'Enregistrer les modifications';

  @override
  String get accounts_addAccountBtn => 'Ajouter un compte';

  @override
  String get accounts_fetchingGoldPrice => 'Récupération du prix de l\'or…';

  @override
  String get accounts_goldPriceUnavailable =>
      'Prix de l\'or indisponible — vérifiez votre connexion';

  @override
  String lended_person_owesYou(Object name) {
    return '$name vous doit';
  }

  @override
  String lended_person_youOwe(Object name) {
    return 'Vous devez à $name';
  }

  @override
  String get lended_person_allSettledUp => 'Tout est réglé';

  @override
  String get lended_person_noRecordsYet => 'Aucun enregistrement';

  @override
  String get lended_person_tapPlusToLog =>
      'Appuyez sur + pour consigner l\'argent prêté ou emprunté';

  @override
  String get lended_person_name => 'Nom';

  @override
  String get lended_person_notesOptional => 'Notes (facultatif)';

  @override
  String get lended_person_lent => 'Prêté';

  @override
  String get lended_person_borrowed => 'Emprunté';

  @override
  String get lended_person_overdue => 'En retard !';

  @override
  String lended_person_due(Object date) {
    return 'Dû le $date';
  }

  @override
  String lended_person_reminderAt(Object time) {
    return 'Rappel à $time';
  }

  @override
  String get lended_person_notificationPermissionDenied =>
      'Permission de notification refusée. Activez-la dans Paramètres → Applications → Expensy → Notifications.';

  @override
  String get lended_person_remindMeAtPrompt => 'Me le rappeler à';

  @override
  String get lended_person_editRecord => 'Modifier l\'enregistrement';

  @override
  String get lended_person_addRecord => 'Ajouter un enregistrement';

  @override
  String get lended_person_amount => 'Montant';

  @override
  String lended_person_dueColon(Object date) {
    return 'Dû : $date';
  }

  @override
  String get lended_person_noDueDate => 'Pas de date d\'échéance';

  @override
  String get lended_person_setDueFirst =>
      'Définir d\'abord une date d\'échéance';

  @override
  String get lended_person_notifiedOnDue =>
      'Vous serez averti à la date d\'échéance';

  @override
  String get lended_person_getNotifiedWhenDue => 'Être averti à l\'échéance';

  @override
  String get lended_person_thatTimePassed =>
      'Cette heure est déjà passée aujourd\'hui — vous serez bientôt averti à la place.';

  @override
  String lended_person_notificationFiresOn(Object date, Object time) {
    return 'La notification se déclenche le $date à $time.';
  }

  @override
  String get lended_person_saveChangesBtn => 'Enregistrer les modifications';

  @override
  String get lended_person_addRecordBtn => 'Ajouter un enregistrement';

  @override
  String get transactions_searchTransactions =>
      'Rechercher des transactions...';

  @override
  String get transactions_all => 'Tout';

  @override
  String get transactions_income => 'Revenus';

  @override
  String get transactions_expenses => 'Dépenses';

  @override
  String get transactions_lent => 'Prêté';

  @override
  String get transactions_borrowed => 'Emprunté';

  @override
  String get transactions_noTransactions => 'Aucune transaction';

  @override
  String get transactions_tapPlusToAddOne => 'Appuyez sur + pour en ajouter';

  @override
  String get transactions_today => 'Aujourd\'hui';

  @override
  String get transactions_yesterday => 'Hier';

  @override
  String transactions_lentTo(Object name) {
    return 'Prêté à $name';
  }

  @override
  String transactions_borrowedFrom(Object name) {
    return 'Emprunté à $name';
  }

  @override
  String get transactions_unknown => 'Inconnu';

  @override
  String transactions_due(Object date) {
    return 'Dû le $date';
  }

  @override
  String get transactions_unsettled => 'Non réglé';

  @override
  String get onboarding_restoreFailed =>
      'Échec de la restauration : le fichier est peut-être corrompu ou ne correspond pas à une sauvegarde Expensy.';

  @override
  String get onboarding_continue => 'Continuer';

  @override
  String get onboarding_getStarted => 'Commencer';

  @override
  String get onboarding_yourPersonalTracker =>
      'Votre outil de suivi financier personnel 100% hors ligne.\nVous avez déjà une sauvegarde d\'un autre appareil ou d\'une installation précédente ?';

  @override
  String get onboarding_restoring => 'Restauration...';

  @override
  String get onboarding_chooseBackupFile => 'Choisir un fichier de sauvegarde';

  @override
  String get onboarding_letsGetYouSetUp => 'Installons votre profil';

  @override
  String get onboarding_yourName => 'Votre nom';

  @override
  String get onboarding_accountName => 'Nom du compte';

  @override
  String get onboarding_bank => 'Banque';

  @override
  String get onboarding_cash => 'Espèces';

  @override
  String get onboarding_savings => 'Épargne';

  @override
  String get onboarding_credit => 'Crédit';

  @override
  String get onboarding_wallet => 'Portefeuille';

  @override
  String get onboarding_startingBalance => 'Solde initial';

  @override
  String get backup_replaceDataWarning =>
      'Ceci remplacera TOUTES vos données actuelles par la sauvegarde.\nCette action est irréversible.';

  @override
  String get backup_whatsIncluded => 'Ce qui est inclus';

  @override
  String get backup_backupDescription =>
      'Chaque sauvegarde inclut toutes vos données — comptes, transactions, paiements récurrents et leur historique, budgets, liste de souhaits, personnes et enregistrements de prêts, actifs, catégories et paramètres de l\'application.';

  @override
  String get backup_saving => 'Enregistrement...';

  @override
  String get backup_saveBackup => 'Enregistrer la sauvegarde';

  @override
  String get backup_restoring => 'Restauration...';

  @override
  String get backup_restoreBackupBtn => 'Restaurer la sauvegarde';

  @override
  String get backup_restoreWarningText =>
      'Compatible avec les sauvegardes de toute version de l\'application. Les champs manquants sont remplis avec des valeurs par défaut sûres.';

  @override
  String get backup_included => 'inclus';

  @override
  String get backup_accounts => 'Comptes';

  @override
  String get backup_transactions => 'Opérations';

  @override
  String get backup_recurringPayments => 'Paiements récurrents';

  @override
  String get backup_recurringHistory => 'Historique des récurrences';

  @override
  String get backup_budgets => 'Budgets';

  @override
  String get backup_wishlist => 'Liste de souhaits';

  @override
  String get backup_lentPeople => 'Prêts/Emprunts — Personnes';

  @override
  String get backup_lentRecords => 'Prêts/Emprunts — Enregistrements';

  @override
  String get backup_assets => 'Actifs';

  @override
  String get backup_categories => 'Catégories';

  @override
  String get backup_settings => 'Paramètres';

  @override
  String backup_backupSavedSuccessfully(Object savedPath) {
    return 'Sauvegarde réussie :\n$savedPath';
  }

  @override
  String backup_backupFailed(Object error) {
    return 'Échec de la sauvegarde : $error';
  }

  @override
  String backup_upgradedFrom(Object originalVersion, Object schemaVersion) {
    return ' (mis à jour de la v$originalVersion → v$schemaVersion)';
  }

  @override
  String backup_dataRestoredSuccessfully(Object vLabel) {
    return 'Données restaurées avec succès !$vLabel';
  }

  @override
  String backup_restoreFailed(Object error) {
    return 'Échec de la restauration : $error';
  }

  @override
  String get backup_restoreFailedCorrupted =>
      'Échec de la restauration : le fichier est peut-être corrompu ou ne correspond pas à une sauvegarde Expensy.';

  @override
  String get budget_noBudgetsYet => 'Aucun budget';

  @override
  String get budget_tapToAddBudget =>
      'Appuyez sur + pour définir une limite de dépenses par catégorie';

  @override
  String get budget_budgeted => 'Budgété';

  @override
  String get budget_leftToSpend => 'Reste à dépenser';

  @override
  String get budget_spent => 'Dépensé';

  @override
  String get budget_overLimit => 'Dépassement';

  @override
  String get budget_unknown => 'Inconnu';

  @override
  String get budget_weeklyLabel => 'Hebdomadaire';

  @override
  String get budget_monthlyLabel => 'Mensuel';

  @override
  String budget_overAmount(Object amount) {
    return 'Dépassement de $amount';
  }

  @override
  String budget_leftAmount(Object amount) {
    return '$amount restants';
  }

  @override
  String budget_percentUsed(Object percent) {
    return '$percent% utilisé';
  }

  @override
  String get budget_editBudget => 'Modifier le budget';

  @override
  String get budget_setBudget => 'Ajouter un nouveau budget';

  @override
  String get budget_budgetAmount => 'Montant du budget';

  @override
  String budget_previewFor(Object catName) {
    return 'Aperçu pour \"$catName\"';
  }

  @override
  String budget_spentAmount(Object amount) {
    return 'Dépensé : $amount';
  }

  @override
  String budget_ofAmount(Object amount) {
    return 'sur $amount';
  }

  @override
  String get budget_saveChanges => 'Enregistrer les modifications';

  @override
  String get budget_budget => 'Budget';

  @override
  String get budget_rollover => 'Report de budget (Enveloppe)';

  @override
  String get budget_rolloverDesc =>
      'Reporter les surplus inutilisés ou les déficits sur la période suivante';

  @override
  String get budget_rolloverBadge => 'Report';

  @override
  String budget_base(Object amount) {
    return 'Base : $amount';
  }

  @override
  String budget_rolloverFrom(Object period, Object amount) {
    return 'Report ($period) : $amount';
  }

  @override
  String budget_totalAvailable(Object amount) {
    return 'Total disponible : $amount';
  }

  @override
  String get budget_lastWeek => 'Semaine dernière';

  @override
  String get pacing_dailyBudget => 'Dépense sereine';

  @override
  String pacing_safeToSpend(Object amount, Object days) {
    return 'Dépense sereine : $amount/jour ($days jours restants)';
  }

  @override
  String pacing_caution(Object amount) {
    return 'Rythme élevé — limiter à $amount/jour';
  }

  @override
  String get pacing_overPaced =>
      'Alerte de rythme — ralentissez pour respecter le budget';

  @override
  String get pacing_budgetExhausted =>
      'Budget épuisé — plus de marge quotidienne';

  @override
  String get pacing_onTrack => 'Dans les clous';

  @override
  String get pacing_fast => 'Rythme élevé';

  @override
  String get pacing_alert => 'Alerte rythme';

  @override
  String pacing_daysLeft(Object days) {
    return '$days jours restants';
  }

  @override
  String get pacing_setBudgetPrompt => 'Appuyez pour définir des budgets →';

  @override
  String get pacing_dailyAvgPace => 'Rythme quotidien';

  @override
  String pacing_perDay(Object amount) {
    return '$amount / jour';
  }

  @override
  String get calendar_title => 'Calendrier financier';

  @override
  String get calendar_subtitle => 'Carte thermique des dépenses et échéances';

  @override
  String calendar_zeroSpendDays(Object count) {
    return '$count jours sans dépense';
  }

  @override
  String get calendar_zeroSpendDayTitle => 'Journée zéro dépense ! 🎉';

  @override
  String get calendar_zeroSpendDayDesc =>
      'Belle discipline financière sans aucune dépense aujourd\'hui.';

  @override
  String get calendar_billsDue => 'Factures et abonnements dus';

  @override
  String get calendar_loansDue => 'Mensualités de prêt dues';

  @override
  String get calendar_lendedDue => 'Remboursements attendus';

  @override
  String calendar_dayTransactions(Object count) {
    return 'Transactions ($count)';
  }

  @override
  String get calendar_noActivity =>
      'Aucune transaction ni échéance à cette date';

  @override
  String get calendar_today => 'Aujourd\'hui';

  @override
  String calendar_averageDaily(Object amount) {
    return 'Moyenne quotidienne : $amount';
  }

  @override
  String get wrapped_title => 'Rétrospective Expensy';

  @override
  String wrapped_bannerTitle(Object month) {
    return 'Votre bilan de $month est prêt !';
  }

  @override
  String get wrapped_bannerSub =>
      'Appuyez pour voir votre histoire financière mensuelle';

  @override
  String get wrapped_theBigPicture => 'Vue d\'ensemble';

  @override
  String wrapped_howMoneyMoved(Object month) {
    return 'Voici comment votre argent a circulé en $month';
  }

  @override
  String get wrapped_totalInflow => 'Revenus totaux';

  @override
  String get wrapped_totalOutflow => 'Dépenses totales';

  @override
  String get wrapped_netSavings => 'Épargne nette';

  @override
  String wrapped_savingsRate(Object rate) {
    return 'Taux d\'épargne : $rate%';
  }

  @override
  String get wrapped_topCategoryTitle => 'Où est passé votre argent ?';

  @override
  String wrapped_topCategorySub(Object category) {
    return 'Votre principale catégorie de dépense était $category';
  }

  @override
  String wrapped_topCategoryShare(Object percent) {
    return '$percent% de vos dépenses totales';
  }

  @override
  String get wrapped_biggestSplurgeTitle => 'Plus gros achat';

  @override
  String get wrapped_biggestSplurgeSub => 'Votre plus grosse dépense du mois';

  @override
  String get wrapped_noSplurge =>
      'Pas d\'excès ! Vous n\'avez eu aucune dépense ce mois-ci.';

  @override
  String get wrapped_heroHabitTitle => 'Habitude héroïque';

  @override
  String wrapped_zeroSpendAchieved(Object count) {
    return '$count jours sans dépenses';
  }

  @override
  String wrapped_heroHabitDesc(Object count) {
    return 'Vous avez atteint $count jours sans dépenses. Discipline financière exceptionnelle !';
  }

  @override
  String get wrapped_receiptTitle => 'Relevé mensuel';

  @override
  String get wrapped_obscureToggle => 'Masquer les montants pour partager';

  @override
  String get wrapped_showToggle => 'Afficher les montants';

  @override
  String get wrapped_replay => 'Rejouer l\'histoire';

  @override
  String get insights_other => 'Autre';

  @override
  String get insights_noDataYet => 'Aucune donnée pour l\'instant';

  @override
  String get insights_addSomeTransactions =>
      'Ajoutez des transactions pour voir les statistiques';

  @override
  String get insights_thisMonthVsLastMonth => 'Ce mois vs le mois dernier';

  @override
  String get insights_dailyAverage => 'Moyenne quotidienne';

  @override
  String insights_perDayBasedOn(Object days) {
    return 'par jour · basé sur $days jours ce mois-ci';
  }

  @override
  String get insights_incomeVsExpenses => 'Revenus vs Dépenses';

  @override
  String insights_incomeAmount(Object amount) {
    return 'Revenus $amount';
  }

  @override
  String insights_expensesAmount(Object amount) {
    return 'Dépenses $amount';
  }

  @override
  String insights_percentSaved(Object percent) {
    return '$percent% économisés ce mois-ci';
  }

  @override
  String get insights_topSpendingCategories =>
      'Catégories de dépenses principales';

  @override
  String insights_percentOfTotal(Object percent) {
    return '$percent% du total';
  }

  @override
  String get insights_biggestExpenseThisMonth =>
      'Plus grande dépense ce mois-ci';

  @override
  String get insights_categoryTrends =>
      'Tendances des catégories (vs le mois dernier)';

  @override
  String get insights_12MonthTrend => 'Tendance sur 12 mois';

  @override
  String get insights_incomeLabel => 'Revenus';

  @override
  String get insights_expensesLabel => 'Dépenses';

  @override
  String get categories_expenseLabel => 'Dépense';

  @override
  String get categories_incomeLabel => 'Revenu';

  @override
  String get categories_editCategory => 'Modifier la catégorie';

  @override
  String get categories_addCategory => 'Ajouter une catégorie';

  @override
  String get categories_categoryName => 'Nom de la catégorie';

  @override
  String get categories_saveChanges => 'Enregistrer les modifications';

  @override
  String get statistics_other => 'Autre';

  @override
  String get statistics_allAccounts => 'Tous les comptes';

  @override
  String get statistics_income => 'Revenus';

  @override
  String get statistics_expenses => 'Dépenses';

  @override
  String get statistics_expense => 'Dépense';

  @override
  String get statistics_net => 'Net';

  @override
  String statistics_6MonthOverviewAccount(Object accountName) {
    return 'Aperçu sur 6 mois · $accountName';
  }

  @override
  String get statistics_6MonthOverview => 'Aperçu sur 6 mois';

  @override
  String statistics_percentOfBudget(Object percent) {
    return '$percent% du budget';
  }

  @override
  String get add_transaction_editTransaction => 'Modifier la transaction';

  @override
  String get add_transaction_addTransaction => 'Saisir une transaction';

  @override
  String get add_transaction_amount => 'Montant';

  @override
  String add_transaction_conversionPreview(Object accountName, Object amount) {
    return '≈ $amount seront déduits de $accountName';
  }

  @override
  String get add_transaction_accountFallback => 'compte';

  @override
  String get add_transaction_descriptionOptional => 'Description (facultatif)';

  @override
  String get add_transaction_noteOptional => 'Note (facultatif)';

  @override
  String get add_transaction_saveChanges => 'Enregistrer les modifications';

  @override
  String get more_statistics => 'Statistiques';

  @override
  String get more_statisticsSub => 'Graphiques et résumé mensuel';

  @override
  String get more_insights => 'Aperçus';

  @override
  String get more_insightsSub =>
      'Tendances, moyennes et analyse des catégories';

  @override
  String get more_currencyConverter => 'Convertisseur de devises';

  @override
  String get more_currencyConverterSub =>
      'Convertissez entre les devises instantanément';

  @override
  String get more_wishlist => 'Liste de souhaits';

  @override
  String more_wishlistSub(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count articles',
      one: '1 article',
    );
    return '$_temp0';
  }

  @override
  String get more_lentMoney => 'Argent prêté';

  @override
  String more_lentMoneySub(Object count) {
    return '$count en attente';
  }

  @override
  String get more_assets => 'Actifs';

  @override
  String more_assetsSub(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count actifs',
      one: '1 actif',
    );
    return '$_temp0';
  }

  @override
  String get more_categories => 'Catégories';

  @override
  String more_categoriesSub(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count catégories',
      one: '1 catégorie',
    );
    return '$_temp0';
  }

  @override
  String get more_exportTransactions => 'Exporter les transactions';

  @override
  String get more_exportTransactionsSub => 'Enregistrer sous Excel (.xlsx)';

  @override
  String get more_backupRestore => 'Sauvegarder et restaurer';

  @override
  String get more_backupRestoreSub => 'Enregistrez ou chargez vos données';

  @override
  String get more_settings => 'Paramètres';

  @override
  String get more_settingsSub => 'Thème, devise et préférences';

  @override
  String get more_sectionTools => 'Outils financiers';

  @override
  String get more_sectionAnalytics => 'Analyses & Aperçus';

  @override
  String get more_sectionPreferences => 'Préférences & Données';

  @override
  String home_greeting(Object name) {
    return 'Salut, $name 👋';
  }

  @override
  String get home_there => 'toi';

  @override
  String get home_income => 'Revenus';

  @override
  String get home_expenses => 'Dépenses';

  @override
  String get home_net => 'Net';

  @override
  String get wishlist_noItems => 'Aucun élément dans la liste de souhaits';

  @override
  String get wishlist_noItemsSub =>
      'Appuyez sur + pour ajouter des éléments pour lesquels vous économisez';

  @override
  String get wishlist_editItem => 'Modifier l\'élément';

  @override
  String get wishlist_addWishlistItem =>
      'Ajouter un élément à la liste de souhaits';

  @override
  String get wishlist_itemName => 'Nom de l\'élément';

  @override
  String get wishlist_targetPrice => 'Prix cible';

  @override
  String get wishlist_priorityLow => 'Basse';

  @override
  String get wishlist_priorityMedium => 'Moyenne';

  @override
  String get wishlist_priorityHigh => 'Haute';

  @override
  String get wishlist_notesOptional => 'Notes (facultatif)';

  @override
  String get wishlist_saveChanges => 'Enregistrer les modifications';

  @override
  String get wishlist_addItem => 'Ajouter l\'élément';

  @override
  String get wishlist_fundThisItem => 'Financer l\'article';

  @override
  String wishlist_funded(int percent, String saved, String target) {
    return '$percent% financé ($saved / $target)';
  }

  @override
  String get wishlist_goalAchieved => 'Objectif atteint — prêt à acheter !';

  @override
  String get wishlist_buyNow => 'Acheter maintenant';

  @override
  String get wishlist_purchaseTitle => 'Acheter un article d\'envies';

  @override
  String get wishlist_purchasePrompt =>
      'Voulez-vous enregistrer une dépense et déduire le montant d\'un compte ?';

  @override
  String get wishlist_recordAndDeduct => 'Enregistrer et déduire';

  @override
  String get wishlist_markPurchasedOnly => 'Marquer comme acheté uniquement';

  @override
  String wishlist_itemPurchased(String name) {
    return '« $name » marqué comme acheté !';
  }

  @override
  String get wishlist_viewGoal => 'Voir l\'objectif d\'épargne';

  @override
  String savings_linkedWishlist(String item) {
    return 'Lié à la liste d\'envies : $item';
  }

  @override
  String get lended_theyOweMe => 'Ils me doivent';

  @override
  String get lended_iOweThem => 'Je leur dois';

  @override
  String get lended_net => 'Filet';

  @override
  String get lended_noOneYet => 'Personne pour le moment';

  @override
  String get lended_noOneYetSub =>
      'Appuyez sur + pour ajouter une personne à qui vous prêtez ou empruntez';

  @override
  String get lended_owesYou => 'Vous doit';

  @override
  String get lended_youOwe => 'Vous devez';

  @override
  String get lended_settledUp => 'Réglé';

  @override
  String get lended_noActiveRecords => 'Aucun enregistrement actif';

  @override
  String lended_activeRecords(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dossiers actifs',
      one: '1 dossier actif',
    );
    return '$_temp0';
  }

  @override
  String get lended_editPerson => 'Modifier la personne';

  @override
  String get lended_addPerson => 'Ajouter une personne';

  @override
  String get lended_name => 'Nom';

  @override
  String get lended_notesOptional => 'Notes (facultatif)';

  @override
  String get lended_saveChanges => 'Enregistrer les modifications';

  @override
  String get assets_totalAssets => 'Total des actifs';

  @override
  String get assets_items => 'Éléments';

  @override
  String get assets_noAssetsYet => 'Aucun actif';

  @override
  String get assets_noAssetsYetSub =>
      'Appuyez sur + pour ajouter un produit ou un actif';

  @override
  String get assets_editAsset => 'Modifier l\'actif';

  @override
  String get assets_addAsset => 'Ajouter un actif';

  @override
  String get assets_productAssetName => 'Nom du produit / actif';

  @override
  String get assets_value => 'Valeur';

  @override
  String get assets_notesOptional => 'Notes (facultatif)';

  @override
  String get assets_saveChanges => 'Enregistrer les modifications';

  @override
  String get currency_converter_loadingRates =>
      'Chargement des taux de change…';

  @override
  String get currency_converter_ratesUnavailable =>
      'Taux de change indisponibles. Connectez-vous à Internet et synchronisez.';

  @override
  String get currency_converter_rateAgeJustNow => 'À l\'instant';

  @override
  String currency_converter_rateAgeMins(Object minutes) {
    return 'Il y a ${minutes}m';
  }

  @override
  String currency_converter_rateAgeHours(Object hours) {
    return 'Il y a ${hours}h';
  }

  @override
  String currency_converter_rateAgeDays(Object days) {
    return 'Il y a ${days}j';
  }

  @override
  String currency_converter_commonConversions(Object fromCurrency) {
    return 'Conversions courantes depuis $fromCurrency';
  }

  @override
  String transfer_fromAcc(Object currency) {
    return 'De ($currency)';
  }

  @override
  String transfer_toAcc(Object currency) {
    return 'Vers ($currency)';
  }

  @override
  String get transfer_exchangeRatesNotLoaded =>
      'Taux de change non chargés — le montant sera transféré tel quel';

  @override
  String get transfer_amount => 'Montant';

  @override
  String get transfer_noteOptional => 'Note (facultatif)';

  @override
  String get export_from => 'De';

  @override
  String get export_to => 'À';

  @override
  String export_txCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transactions sur la période',
      one: '1 transaction sur la période',
    );
    return '$_temp0';
  }

  @override
  String export_saved(Object path) {
    return 'Enregistré : $path';
  }

  @override
  String get export_complete => 'Exportation terminée';

  @override
  String get export_exporting => 'Exportation...';

  @override
  String get export_exportAsExcel => 'Exporter sous Excel';

  @override
  String shared_widgets_deleteConfirm(Object name) {
    return 'Supprimer \"$name\" ? Cette action est irréversible.';
  }

  @override
  String get shared_widgets_searchByCode => 'Rechercher par code ou nom...';

  @override
  String get accounts_accounts => 'Comptes';

  @override
  String get accounts_totalBalance => 'Solde total';

  @override
  String get accounts_excluded => 'Exclus';

  @override
  String get accounts_goldPriceNotYetLoade =>
      'Le prix de l\'or n\'est pas encore chargé. Attendez un instant et réessayez.';

  @override
  String get accounts_accountType => 'Type de compte';

  @override
  String get accounts_currency => 'Devise';

  @override
  String get accounts_goldPurityKarat => 'Pureté de l\'or (Carat)';

  @override
  String get accounts_weight => 'Poids';

  @override
  String get accounts_excludeFromTotalBala => 'Exclure du solde total';

  @override
  String get accounts_dontLinkToCard => 'Ne pas lier à une carte';

  @override
  String get accounts_dontLinkToCardDesc =>
      'Gérer le solde manuellement et empêcher les cartes de s\'y lier';

  @override
  String get accounts_color => 'Couleur';

  @override
  String get accounts_liveGoldValue => 'Valeur de l\'or en direct';

  @override
  String get accounts_enterWeightAboveToSe =>
      'Entrez le poids ci-dessus pour voir la valeur';

  @override
  String get add_transaction_expense => 'Dépense';

  @override
  String get add_transaction_income => 'Revenu';

  @override
  String get add_transaction_account => 'Compte';

  @override
  String get add_transaction_category => 'Catégorie';

  @override
  String get assets_assets => 'Actifs';

  @override
  String get backup_restoreBackup => 'Restaurer la sauvegarde ?';

  @override
  String get backup_cancel => 'Annuler';

  @override
  String get backup_replaceData => 'Remplacer les données';

  @override
  String get backup_backupRestore => 'Sauvegarde & Restauration';

  @override
  String get backup_everythingAlways => 'Tout, toujours';

  @override
  String get backup_createBackup => 'Créer une sauvegarde';

  @override
  String get backup_saveAsJson => 'Enregistrer au format JSON';

  @override
  String get backup_exportsAllAppDataToA =>
      'Exporte toutes les données de l\'application vers un fichier portable';

  @override
  String get backup_restoreBackup_ => 'Restaurer la sauvegarde';

  @override
  String get backup_loadFromJson => 'Charger depuis JSON';

  @override
  String get backup_picksABackupFileAndR =>
      'Sélectionne un fichier de sauvegarde et le restaure';

  @override
  String get backup_thisOverwritesAllCur =>
      'Ceci écrase TOUTES les données actuelles.';

  @override
  String get budget_budgets => 'Budgets';

  @override
  String get budget_empty => '·';

  @override
  String get budget_overBudget => 'Budget dépassé';

  @override
  String get budget_thisCategoryAlreadyH =>
      'Cette catégorie a déjà un budget. Appuyez pour modifier.';

  @override
  String get budget_period => 'Période';

  @override
  String get budget_monthly => 'Mensuel';

  @override
  String get budget_weekly => 'Hebdomadaire';

  @override
  String get budget_category => 'Catégorie';

  @override
  String get categories_categories => 'Catégories';

  @override
  String get categories_expense => 'Dépense';

  @override
  String get categories_income => 'Revenu';

  @override
  String get categories_color => 'Couleur';

  @override
  String get categories_icon => 'Icône';

  @override
  String get categories_autoBasedOnName => 'Auto (basé sur le nom)';

  @override
  String get categories_expenseCategories => 'Catégories de dépenses';

  @override
  String get categories_incomeCategories => 'Catégories de revenus';

  @override
  String get currency_converter_currencyConverter => 'Convertisseur de devises';

  @override
  String get currency_converter_amount => 'Montant';

  @override
  String get currency_converter_convertedTo => 'Converti en';

  @override
  String get export_exportTransactions => 'Exporter les transactions';

  @override
  String get export_dateRange => 'Plage de dates';

  @override
  String get export_formatExcelXlsx => 'Format : Excel (.xlsx)';

  @override
  String get export_exportAsPdf => 'Exporter en rapport PDF';

  @override
  String get export_formatPdf => 'Format : Rapport financier PDF (.pdf)';

  @override
  String get export_pdfGenerating => 'Génération du PDF...';

  @override
  String get export_pdfTitle => 'Rapport Financier';

  @override
  String get export_pdfSummary => 'Résumé exécutif';

  @override
  String get export_pdfInflow => 'Revenus totaux';

  @override
  String get export_pdfOutflow => 'Dépenses totales';

  @override
  String get export_pdfNet => 'Épargne nette';

  @override
  String get export_pdfSavingsRate => 'Taux d\'épargne';

  @override
  String get export_pdfCategoryBreakdown => 'Répartition par catégories';

  @override
  String get export_pdfTransactions => 'Transactions détaillées';

  @override
  String get export_pdfNetWorthBreakdown => 'Actifs et Passifs';

  @override
  String get export_pdfShare => 'Partager le rapport';

  @override
  String get export_pdfPrint => 'Imprimer / Aperçu';

  @override
  String get export_pdfGeneratedBy => 'Généré par Expensy • Privé & Hors-ligne';

  @override
  String get home_totalBalance => 'Solde total';

  @override
  String get home_accounts => 'Comptes';

  @override
  String get home_recentTransactions => 'Transactions récentes';

  @override
  String get home_noTransactionsYet => 'Aucune transaction pour l\'instant';

  @override
  String get home_add => 'Ajouter';

  @override
  String get home_goodMorning => 'Bonjour';

  @override
  String get home_goodAfternoon => 'Bon après-midi';

  @override
  String get home_goodEvening => 'Bonsoir';

  @override
  String get home_transferAction => 'Transférer';

  @override
  String get home_insightsAction => 'Aperçus';

  @override
  String get home_calendarAction => 'Calendrier';

  @override
  String get home_forecastAction => 'Prévisions';

  @override
  String get home_manage => 'Gérer';

  @override
  String get home_seeAll => 'Voir tout';

  @override
  String get home_addAccount => 'Ajouter un compte';

  @override
  String get home_cards => 'Cartes';

  @override
  String get home_addCard => 'Ajouter une carte';

  @override
  String get home_monthlyOverview => 'Aperçu mensuel';

  @override
  String get home_savingsRate => 'Taux d\'épargne';

  @override
  String get insights_insights => 'Aperçus';

  @override
  String get lended_person_deletePerson => 'Supprimer la personne';

  @override
  String get lended_person_editPerson => 'Modifier la personne';

  @override
  String get lended_person_color => 'Couleur';

  @override
  String get lended_person_saveChanges => 'Enregistrer les modifications';

  @override
  String get lended_person_settled => 'RÉGLÉ';

  @override
  String get lended_person_settle => 'Régler';

  @override
  String get lended_person_setADueDateFirstToEn =>
      'Définissez d\'abord une date d\'échéance pour activer les rappels.';

  @override
  String get lended_person_iLent => 'J\'ai prêté';

  @override
  String get lended_person_iBorrowed => 'J\'ai emprunté';

  @override
  String get lended_person_accountOptional => 'Compte (optionnel)';

  @override
  String get lended_person_dueDateReminder => 'Rappel de date d\'échéance';

  @override
  String get lended_person_remindMeAt => 'Me rappeler à';

  @override
  String get lended_person_active => 'Actif';

  @override
  String get lended_person_settled_ => 'Réglé';

  @override
  String get lended_lentMoney => 'Argent prêté';

  @override
  String get lended_overdue => 'EN RETARD';

  @override
  String get lended_color => 'Couleur';

  @override
  String get more_more => 'Plus';

  @override
  String get onboarding_back => 'Retour';

  @override
  String get onboarding_welcomeToExpensy => 'Bienvenue sur Expensy !';

  @override
  String get onboarding_restoreABackup => 'Restaurer une sauvegarde';

  @override
  String get onboarding_loadAPreviouslySaved =>
      'Charger un fichier JSON Expensy précédemment enregistré';

  @override
  String get onboarding_or => 'ou';

  @override
  String get onboarding_startFresh => 'Commencer à zéro';

  @override
  String get onboarding_firstWhatShouldWeCal =>
      'Tout d\'abord, comment devons-nous vous appeler ?';

  @override
  String get onboarding_defaultCurrency => 'Devise par défaut';

  @override
  String get onboarding_thisWillBeUsedAcross =>
      'Ceci sera utilisé dans toute l\'application.\nVous pourrez le modifier plus tard dans les paramètres.';

  @override
  String get onboarding_searchAllCurrencies => 'Rechercher toutes les devises';

  @override
  String get onboarding_yourFirstAccount => 'Votre premier compte';

  @override
  String get onboarding_setUpYourMainAccount =>
      'Configurez votre compte principal pour commencer le suivi.';

  @override
  String get onboarding_accountType => 'Type de compte';

  @override
  String get onboarding_currency => 'Devise';

  @override
  String get onboarding_color => 'Couleur';

  @override
  String get recurring_recurring => 'Récurrent';

  @override
  String get recurring_income => 'REVENU';

  @override
  String get recurring_2D => '−2j';

  @override
  String get recurring_skipNextPayment => 'Ignorer le prochain paiement ?';

  @override
  String get recurring_cancel => 'Annuler';

  @override
  String get recurring_skip => 'Ignorer';

  @override
  String get recurring_noHistoryYet => 'Aucun historique pour l\'instant';

  @override
  String get recurring_expense => 'Dépense';

  @override
  String get recurring_income_ => 'Revenu';

  @override
  String get recurring_every => 'Tous les ';

  @override
  String get recurring_days => 'Jours';

  @override
  String get recurring_weeks => 'Semaines';

  @override
  String get recurring_months => 'Mois';

  @override
  String get recurring_years => 'Années';

  @override
  String get recurring_payments => 'Paiements';

  @override
  String get recurring_totalCost => 'Coût total';

  @override
  String get recurring_account => 'Compte';

  @override
  String get recurring_category => 'Catégorie';

  @override
  String get recurring_paymentReminder => 'Rappel de paiement';

  @override
  String get recurring_notificationWillFire =>
      'La notification se déclenchera à la prochaine date d\'échéance à cette heure.';

  @override
  String get recurring_remind2DaysBefore => 'Rappeler 2 jours avant';

  @override
  String get statistics_statistics => 'Statistiques';

  @override
  String get statistics_expensesByCategory => 'Dépenses par catégorie';

  @override
  String get transactions_transactions => 'Opérations';

  @override
  String get transactions_settled => 'Réglé';

  @override
  String get transfer_transfer => 'Transfert';

  @override
  String get transfer_from => 'DE';

  @override
  String get transfer_to => 'À';

  @override
  String get transfer_enterAnAmountToSeeTh =>
      'Entrez un montant pour voir la conversion';

  @override
  String get wishlist_wishlist => 'Liste de souhaits';

  @override
  String get wishlist_priority => 'Priorité';

  @override
  String get shared_widgets_delete => 'Supprimer ?';

  @override
  String get shared_widgets_cancel => 'Annuler';

  @override
  String get shared_widgets_delete_ => 'Supprimer';

  @override
  String get shared_widgets_none => 'Aucun';

  @override
  String get shared_widgets_selectCurrency => 'Sélectionner la devise';

  @override
  String get main_home => 'Accueil';

  @override
  String get main_transactions => 'Opérations';

  @override
  String get main_recurring => 'Récurrents';

  @override
  String get main_accounts => 'Comptes';

  @override
  String get main_budgets => 'Budgets';

  @override
  String get main_more => 'Plus';

  @override
  String get onboarding_chooseLanguage => 'Choisir la langue';

  @override
  String get error_required => 'Ce champ est obligatoire';

  @override
  String recurring_subscriptions(Object count) {
    return 'Abonnements ($count)';
  }

  @override
  String recurring_installments(Object count) {
    return 'Mensualités ($count)';
  }

  @override
  String get recurring_recurringType => 'Type de récurrence';

  @override
  String get recurring_subscription => 'Abonnement';

  @override
  String get recurring_installment => 'Mensualité';

  @override
  String get recurring_installmentsRequireEndDate =>
      'Les mensualités doivent avoir une date de paiement finale.';

  @override
  String get backup_importFromOtherApps =>
      'Importer depuis d\'autres applications';

  @override
  String get backup_importDescription =>
      'Importer des données depuis des applications prises en charge';

  @override
  String get backup_importFromGreenStash =>
      'Importer depuis GreenStash (.json)';

  @override
  String get backup_automaticBackup => 'Sauvegarde automatique';

  @override
  String get backup_dailyAutoBackup => 'Sauvegarde automatique quotidienne';

  @override
  String backup_runsDailyAt(String time) {
    return 'S\'exécute quotidiennement à $time';
  }

  @override
  String backup_lastBackup(String time) {
    return 'Dernière sauvegarde : $time';
  }

  @override
  String backup_savingTo(String path) {
    return 'Enregistrement dans : $path';
  }

  @override
  String get backup_changeTime => 'Changer l\'heure';

  @override
  String get backup_changeFolder => 'Changer de dossier';

  @override
  String get budget_budgetsAndGoals => 'Budgets et objectifs';

  @override
  String get onboarding_restoreGreenStash =>
      'Restaurer à partir de GreenStash (.json)';

  @override
  String get savings_goalNotFound => 'Objectif introuvable';

  @override
  String get savings_savedSoFar => 'Enregistré jusqu\'à présent';

  @override
  String get savings_target => 'Cible';

  @override
  String savings_targetDate(String date) {
    return 'Date cible : $date';
  }

  @override
  String get savings_contribute => 'Contribuer';

  @override
  String get savings_withdraw => 'Se retirer';

  @override
  String get savings_noAccounts =>
      'Aucun compte disponible. Veuillez d\'abord ajouter un compte.';

  @override
  String get settings_budgetAlerts => 'Alertes budgétaires';

  @override
  String get settings_budgetAlertsSub =>
      'Notifier lorsqu\'un budget ou un objectif est atteint';

  @override
  String get settings_dailyReminder => 'Rappel quotidien';

  @override
  String get settings_dailyReminderSub =>
      'Rappeler d\'enregistrer les transactions quotidiennement';

  @override
  String get settings_reminderTime => 'Heure de rappel';

  @override
  String get settings_hapticFeedback => 'Retour haptique';

  @override
  String get settings_hapticFeedbackSub => 'Vibrer sur les interactions';

  @override
  String get savings_saveGoal => 'Enregistrer l\'objectif';

  @override
  String get more_loans => 'Prêts';

  @override
  String more_loansSub(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count prêts actifs',
      one: '1 prêt actif',
    );
    return '$_temp0';
  }

  @override
  String get loans_title => 'Prêts';

  @override
  String get loans_addLoan => 'Ajouter un prêt';

  @override
  String get loans_editLoan => 'Modifier le prêt';

  @override
  String get loans_loanName => 'Nom du prêt';

  @override
  String get loans_amount => 'Montant';

  @override
  String get loans_startDate => 'Date de début';

  @override
  String get loans_endDate => 'Date de fin';

  @override
  String get loans_interestRateOptional => 'Taux d\'intérêt (Optionnel)';

  @override
  String get loans_account => 'Compte associé';

  @override
  String get loans_monthlyPayment => 'Mensualité';

  @override
  String get loans_totalPayable => 'Total à rembourser';

  @override
  String get loans_remaining => 'Restant';

  @override
  String get loans_paid => 'Payé';

  @override
  String get loans_logPayment => 'Enregistrer un paiement';

  @override
  String get loans_paymentReminder => 'Rappel de paiement';

  @override
  String get loans_reminderDay => 'Jour de rappel';

  @override
  String get loans_notes => 'Notes';

  @override
  String get loans_saveLoan => 'Enregistrer le prêt';

  @override
  String get loans_deleteLoan => 'Supprimer le prêt';

  @override
  String get loans_settled => 'Soldé';

  @override
  String loans_durationMonths(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mois',
      one: '1 mois',
    );
    return '$_temp0';
  }

  @override
  String get loans_paymentHistory => 'Historique des paiements';

  @override
  String get loans_noPayments => 'Aucun paiement enregistré pour l\'instant';

  @override
  String get loans_outstandingDebt => 'Dette restante';

  @override
  String get loans_monthlyObligation => 'Engagement mensuel';

  @override
  String get insights_loans => 'Prêts';

  @override
  String get backup_loans => 'Prêts';

  @override
  String get backup_loanPayments => 'Paiements de prêt';

  @override
  String get more_yearlyAnalysis => 'Analyse annuelle';

  @override
  String get more_yearlyAnalysisSub => 'Prévisions de trésorerie mois par mois';

  @override
  String get yearly_title => 'Analyse annuelle';

  @override
  String get yearly_recurringExp => 'Dépenses récurrentes';

  @override
  String get yearly_recurringInc => 'Revenus récurrents';

  @override
  String get yearly_loans => 'Remboursements de prêts';

  @override
  String get yearly_borrowed => 'Emprunts à payer';

  @override
  String get yearly_lentDue => 'Prêts à recevoir';

  @override
  String get yearly_inflow => 'Entrées';

  @override
  String get yearly_outflow => 'Sorties';

  @override
  String get yearly_netFlow => 'Flux net';

  @override
  String get yearly_totalInflow => 'Total des entrées';

  @override
  String get yearly_totalOutflow => 'Total des sorties';

  @override
  String get yearly_netCashFlow => 'Flux de trésorerie net';

  @override
  String get yearly_noData => 'Aucune activité projetée';

  @override
  String get yearly_noDataSub =>
      'Ajoutez des paiements récurrents, prêts ou dettes avec une date d\'échéance pour voir les prévisions';

  @override
  String get budget_addBudget => 'Ajouter un budget';

  @override
  String get budget_addGoal => 'Ajouter un objectif d\'épargne';

  @override
  String get add_transaction_possibleDuplicate => 'Doublon possible';

  @override
  String get add_transaction_goBack => 'Retour';

  @override
  String get add_transaction_saveAnyway => 'Enregistrer quand même';

  @override
  String get loans_confirmDeleteLoan =>
      'Voulez-vous vraiment supprimer ce prêt et tous ses paiements ?';

  @override
  String get loans_deletePayment => 'Supprimer le paiement';

  @override
  String get loans_confirmDeletePayment =>
      'Voulez-vous vraiment supprimer cet enregistrement de paiement ?';

  @override
  String get split_transactions_title => 'Diviser les catégories';

  @override
  String get split_transactions_badge => 'Divisé';

  @override
  String get split_transactions_addSplit => 'Ajouter une division';

  @override
  String get split_transactions_removeSplit => 'Supprimer la division';

  @override
  String get split_transactions_allocated => 'Alloué';

  @override
  String get split_transactions_remaining => 'Restant';

  @override
  String get split_transactions_fillRemaining => 'Remplir le reste';

  @override
  String get split_transactions_breakdown => 'Détail de la division';

  @override
  String get split_transactions_mismatchError =>
      'Le total des montants divisés doit correspondre au montant total.';

  @override
  String get netWorth_title => 'Valeur nette';

  @override
  String get netWorth_subtitle =>
      'Suivez le total des actifs, des passifs et de la richesse';

  @override
  String get netWorth_current => 'Valeur nette actuelle';

  @override
  String get netWorth_trend => 'Tendance de la valeur nette';

  @override
  String get netWorth_totalAssets => 'Total des actifs';

  @override
  String get netWorth_totalLiabilities => 'Total des passifs';

  @override
  String get netWorth_liquidCash => 'Espèces et comptes bancaires';

  @override
  String get netWorth_goldValuation => 'Or physique';

  @override
  String get netWorth_fixedAssets => 'Biens et investissements';

  @override
  String get netWorth_moneyLent => 'Argent prêté (Créances)';

  @override
  String get netWorth_creditDebt => 'Cartes de crédit et découverts';

  @override
  String get netWorth_loanDebt => 'Prêts à rembourser';

  @override
  String get netWorth_moneyBorrowed => 'Argent emprunté (Dettes)';

  @override
  String get netWorth_assetBreakdown => 'Ventilation des actifs';

  @override
  String get netWorth_liabilityBreakdown => 'Ventilation des passifs';

  @override
  String get netWorth_noHistory =>
      'L\'historique de la valeur nette s\'établira automatiquement avec les instantanés quotidiens.';

  @override
  String get netWorth_debtRatio => 'Ratio d\'endettement';

  @override
  String get netWorth_quickActions => 'Actions rapides';

  @override
  String get netWorth_history => 'Historique des instantanés';

  @override
  String get creditCard_utilization => 'Utilisation du crédit';

  @override
  String get creditCard_availableCredit => 'Disponible';

  @override
  String get creditCard_limit => 'Plafond';

  @override
  String get creditCard_statementBalance => 'Solde du relevé';

  @override
  String get creditCard_unbilledBalance => 'Non facturé';

  @override
  String get creditCard_payBill => 'Payer le relevé';

  @override
  String get creditCard_allCaughtUp => 'Tout est à jour ! Aucun solde dû';

  @override
  String get creditCard_payBillTitle => 'Régler la facture de carte';

  @override
  String get creditCard_payFromAccount => 'Payer depuis le compte';

  @override
  String get creditCard_paymentAmount => 'Montant du paiement';

  @override
  String get creditCard_fullStatement => 'Solde du relevé';

  @override
  String get creditCard_fullBalance => 'Solde total';

  @override
  String get creditCard_minPayment => 'Paiement minimum';

  @override
  String get creditCard_customAmount => 'Montant personnalisé';

  @override
  String creditCard_paymentSuccess(String amount, String cardName) {
    return '$amount payé(s) pour $cardName';
  }

  @override
  String get creditCard_insufficientFunds =>
      'Le montant dépasse le solde disponible';

  @override
  String get creditCard_invalidAmount => 'Veuillez saisir un montant valide';

  @override
  String get onboarding_skipForNow => 'Ignorer pour le moment';

  @override
  String get onboarding_addCard => 'Ajouter une carte';

  @override
  String get onboarding_skipCardDesc =>
      'Vous pouvez ignorer cette étape si vous ne souhaitez pas ajouter de carte maintenant.';

  @override
  String get onboarding_cardNameLabel => 'Nom de la carte (ex. Visa Platinum)';

  @override
  String get onboarding_debitCard => 'Carte de débit';

  @override
  String get onboarding_creditLimit => 'Plafond de crédit';

  @override
  String get onboarding_amountUsed => 'Montant utilisé';

  @override
  String get accounts_cardHolderOptional => 'Titulaire de la carte (Optionnel)';

  @override
  String get accounts_last4Digits => '4 derniers chiffres';

  @override
  String get accounts_expiryDate => 'Date d\'expiration (MM/AA)';

  @override
  String get accounts_creditLimitOptional => 'Plafond de crédit (Optionnel)';

  @override
  String get accounts_minPaymentOptional => 'Paiement minimum (Optionnel)';

  @override
  String get accounts_statementDayOptional => 'Jour d\'arrêté (Optionnel)';

  @override
  String get accounts_statementDayExample => 'ex. 20';

  @override
  String get accounts_dueDayOptional => 'Jour d\'échéance (Optionnel)';

  @override
  String get accounts_dueDayExample => 'ex. 10';

  @override
  String get accounts_linkedAccountOptional =>
      'Compte bancaire lié (Optionnel)';

  @override
  String get accounts_excludeCardBalance =>
      'Exclure le solde de la carte du solde du compte';

  @override
  String get accounts_excludeCardBalanceDesc =>
      'Le solde de cette carte ne sera pas ajouté à son compte bancaire lié.';

  @override
  String get accounts_cardHolderHeader => 'TITULAIRE';

  @override
  String get accounts_expHeader => 'EXP';

  @override
  String get accounts_notifyOnDueDate =>
      'Vous serez notifié à la date d\'échéance';

  @override
  String get accounts_notifyWhenDue =>
      'Recevoir une notification avant l\'échéance';

  @override
  String get accounts_remind2DaysBeforeDesc =>
      'Recevoir un avertissement 2 jours avant l\'échéance';

  @override
  String get accounts_targetSaved => 'Objectif / Épargné';

  @override
  String transactions_selectedCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sélectionnés',
      one: '1 sélectionné',
    );
    return '$_temp0';
  }

  @override
  String get transactions_changeCategory => 'Changer de catégorie';

  @override
  String get transactions_deleteSelected => 'Supprimer la sélection';

  @override
  String get transactions_advancedFilters => 'Filtres avancés';

  @override
  String get transactions_clearAll => 'Tout effacer';

  @override
  String get transactions_amountRange => 'Fourchette de montant';

  @override
  String get transactions_minAmount => 'Montant min';

  @override
  String get transactions_maxAmount => 'Montant max';

  @override
  String get transactions_applyFilters => 'Appliquer les filtres';

  @override
  String get presets_new => 'Nouveau';

  @override
  String get presets_presetName => 'Nom du modèle (ex. Café du matin)';

  @override
  String get presets_defaultAmount => 'Montant par défaut';

  @override
  String get savings_goalName => 'Nom de l\'objectif';

  @override
  String get savings_goalNameHint => 'ex. Nouvelle voiture, Vacances';

  @override
  String get savings_targetAmount => 'Montant cible';

  @override
  String get savings_targetDateOptional => 'Date cible (Optionnel)';

  @override
  String get savings_selectDate => 'Sélectionner la date';

  @override
  String get savings_amountRequired => 'Le montant est requis';

  @override
  String get savings_noteOptional => 'Note (Optionnel)';

  @override
  String get loans_skipInstallment => 'Ignorer la prochaine échéance du prêt ?';

  @override
  String get recurring_confirmDelete =>
      'Voulez-vous vraiment supprimer ce paiement récurrent ?';

  @override
  String get export_formatExcelOption => 'Excel (.xlsx)';

  @override
  String get export_formatPdfOption => 'Rapport PDF';

  @override
  String get export_pdfNoTransactions =>
      'Aucune transaction enregistrée dans cette période.';

  @override
  String get savings_saved => 'Économisé';

  @override
  String get export_pdfDate => 'Date';

  @override
  String get export_pdfDescription => 'Description';

  @override
  String get accounts_noCardsYet => 'Aucune carte';

  @override
  String get accounts_tapToAddCard =>
      'Appuyez sur + pour ajouter votre première carte';

  @override
  String get savings_noGoalsYet => 'Aucun objectif d\'épargne';

  @override
  String get savings_tapToAddGoal =>
      'Appuyez sur + pour définir un nouvel objectif';

  @override
  String get netWorth_recordSnapshot => 'Enregistrer un instantané';

  @override
  String get netWorth_snapshotRecorded => 'Instantané enregistré';

  @override
  String get savings_noContributionsYet => 'Aucune contribution pour le moment';

  @override
  String get creditCard_closesStatementBillingCycle =>
      'Clôture le cycle de facturation actuel du relevé';

  @override
  String get creditCard_clearsTotalDebt =>
      'Règle intégralement la dette totale de la carte';

  @override
  String get creditCard_requiredMinPayment => 'Paiement minimum requis';

  @override
  String get creditCard_specifyCustomAmount =>
      'Spécifier un montant de paiement personnalisé';

  @override
  String common_itemDeleted(String name) {
    return '\"$name\" supprimé';
  }

  @override
  String get common_accountDeleted => 'Compte supprimé';

  @override
  String get common_cardDeleted => 'Carte supprimée';

  @override
  String get common_transactionDeleted => 'Transaction supprimée';

  @override
  String get common_recordDeleted => 'Enregistrement supprimé';

  @override
  String get common_paymentDeleted => 'Paiement supprimé';

  @override
  String get loans_skippedInstallment => 'Échéance de prêt ignorée';

  @override
  String loans_loggedPayment(String amount) {
    return 'Paiement de $amount enregistré';
  }

  @override
  String get loans_notificationsPermissionRequired =>
      'Autorisation des notifications requise';

  @override
  String get creditCard_selectFundingAccount =>
      'Veuillez sélectionner un compte source';

  @override
  String get presets_presetUpdated => 'Modèle mis à jour';

  @override
  String get presets_presetAdded => 'Modèle ajouté';

  @override
  String get presets_presetDeleted => 'Modèle supprimé';

  @override
  String transactions_deletedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count éléments supprimés',
      one: '1 élément supprimé',
    );
    return '$_temp0';
  }

  @override
  String get split_atLeastTwoCategories =>
      'Au moins 2 catégories requises pour la division.';

  @override
  String get split_categoryAndAmountRequired =>
      'Chaque élément divisé doit avoir une catégorie et un montant > 0.';

  @override
  String get presets_addQuickPresets =>
      'Ajouter des modèles rapides en 1 geste';

  @override
  String get presets_quickPresetsDesc =>
      'Enregistrez vos dépenses fréquentes (café, transport, repas) en un geste';

  @override
  String presets_loggedPreset(String title, String amount) {
    return '$title ($amount) enregistré';
  }

  @override
  String get presets_createPreset => 'Créer un modèle';

  @override
  String get presets_editQuickPreset => 'Modifier le modèle rapide';

  @override
  String get presets_newQuickPreset => 'Nouveau modèle rapide';

  @override
  String get savings_addContribution => 'Ajouter une contribution';

  @override
  String get savings_withdrawFromGoal => 'Retirer de l\'objectif';

  @override
  String get savings_contribution => 'Contribution';

  @override
  String get savings_withdrawal => 'Retrait';

  @override
  String get savings_unknownAccount => 'Compte inconnu';

  @override
  String get savings_fromAccount => 'Depuis le compte';

  @override
  String get savings_toAccount => 'Vers le compte';

  @override
  String get presets_quickLog => 'Saisie rapide';

  @override
  String accounts_dueOnDay(int day) {
    return 'Échéance le $day';
  }

  @override
  String get accounts_cannotDeleteAccount =>
      'Impossible de supprimer le compte';

  @override
  String get common_ok => 'OK';

  @override
  String get certificates_title => 'Dépôts à terme & Certificats';

  @override
  String get certificates_addCertificate => 'Ajouter un certificat';

  @override
  String get certificates_editCertificate => 'Modifier le certificat';

  @override
  String get certificates_noCertificates => 'Aucun certificat pour le moment';

  @override
  String get certificates_noCertificatesDesc =>
      'Suivez vos dépôts à terme, rendements et versements d\'intérêts automatiques.';

  @override
  String get certificates_active => 'Actif';

  @override
  String get certificates_matured => 'Arrivé à échéance';

  @override
  String get certificates_amount => 'Montant principal';

  @override
  String get certificates_collectionType => 'Versement des intérêts';

  @override
  String get certificates_collectedSoFar => 'Déjà perçu';

  @override
  String get certificates_expectedTotal => 'Rendement total attendu';

  @override
  String get certificates_startDate => 'Date de début';

  @override
  String get certificates_endDate => 'Date d\'échéance';

  @override
  String get certificates_redeem => 'Racheter le certificat';

  @override
  String certificates_redeemConfirm(String name, String amount) {
    return 'Êtes-vous sûr de vouloir racheter \"$name\" ? Le capital de $amount sera reversé sur votre compte bancaire.';
  }

  @override
  String get certificates_redeemedSuccess =>
      'Certificat racheté et capital restitué avec succès.';

  @override
  String get certificates_name => 'Nom du certificat';

  @override
  String get certificates_interestRate => 'Taux d\'intérêt annuel (%)';

  @override
  String get certificates_linkedBankAccount => 'Compte bancaire associé';

  @override
  String get certificates_periodicYield => 'Rendement périodique des intérêts';

  @override
  String get certificates_paymentReminder => 'Rappel de versement des intérêts';

  @override
  String get certificates_reminderTime => 'Heure du rappel';

  @override
  String get certificates_reminder2DaysBefore => 'Rappel 2 jours avant';

  @override
  String get certificates_deleteCertificate => 'Supprimer le certificat';

  @override
  String get certificates_confirmDeleteCertificate =>
      'Êtes-vous sûr de vouloir supprimer ce certificat ? Toutes les transactions associées seront supprimées et les fonds reversés sur votre compte.';

  @override
  String get certificates_deleted => 'Certificat supprimé';

  @override
  String get onboarding_stayOnTopOfFinances =>
      'Gardez le contrôle de vos finances';

  @override
  String get onboarding_stayOnTopOfFinancesDesc =>
      'Activez les rappels pour ne manquer aucun paiement, facture en retard ou dépassement de budget.';

  @override
  String get onboarding_featureBillTitle =>
      'Rappels de factures et d\'échéances';

  @override
  String get onboarding_featureBillDesc =>
      'Soyez alerté avant les dates de relevé de carte et les échéances de prêt.';

  @override
  String get onboarding_featureBudgetTitle => 'Alertes de suivi de budget';

  @override
  String get onboarding_featureBudgetDesc =>
      'Recevez des alertes lorsque vous atteignez 80% ou 100% de votre limite de dépenses.';

  @override
  String get onboarding_featureRecurringTitle => 'Abonnements récurrents';

  @override
  String get onboarding_featureRecurringDesc =>
      'Restez informé avant le renouvellement automatique de vos abonnements.';

  @override
  String get onboarding_allowNotifications => 'Autoriser les notifications';

  @override
  String get onboarding_maybeLater => 'Peut-être plus tard';

  @override
  String get categories_subcategories => 'Sous-catégories';

  @override
  String get categories_addSubcategory => 'Ajouter une sous-catégorie';

  @override
  String get categories_parentCategory => 'Catégorie parente';

  @override
  String get categories_noneRoot => 'Aucune (Catégorie principale)';

  @override
  String get categories_loadDefaults =>
      'Charger les sous-catégories par défaut';

  @override
  String categories_defaultsLoaded(int count) {
    return '$count sous-catégories par défaut chargées';
  }

  @override
  String get categories_defaultsAlreadyLoaded =>
      'Les sous-catégories par défaut sont déjà chargées';

  @override
  String get statistics_byCategory => 'Par catégorie';

  @override
  String get statistics_bySubcategory => 'Par sous-catégorie';

  @override
  String get backup_importFromTrackWallet =>
      'Importer depuis TrackWallet (.csv)';

  @override
  String backup_importedTransactions(int count) {
    return '$count transactions importées avec succès !';
  }

  @override
  String get onboarding_restoreTrackWallet =>
      'Importer depuis TrackWallet (.csv)';

  @override
  String get transfer_categoryLocked =>
      'Virement (Catégorie par défaut et unique)';

  @override
  String get loans_noLoans => 'Aucun prêt suivi pour le moment';

  @override
  String get loans_noLoansSub =>
      'Appuyez sur + pour suivre prêts, crédits ou mensualités';

  @override
  String get certificates_noCertificatesSub =>
      'Appuyez sur + pour suivre certificats et dépôts à terme';

  @override
  String get common_undo => 'Annuler';

  @override
  String get common_close => 'Fermer';

  @override
  String get common_required => 'Requis';

  @override
  String get common_invalid => 'Invalide';

  @override
  String get common_none => 'Aucun';

  @override
  String common_enabledAt(String time) {
    return 'Activé ($time)';
  }

  @override
  String get common_disabled => 'Désactivé';

  @override
  String get freq_daily => 'Quotidien';

  @override
  String get freq_yearly => 'Annuel';

  @override
  String recurring_transfers(Object count) {
    return 'Virements ($count)';
  }

  @override
  String get recurring_transfer => 'Virement';

  @override
  String get recurring_transferCaps => 'VIREMENT';

  @override
  String get recurring_noRecurringTransfers => 'Aucun virement récurrent';

  @override
  String recurring_subtitleCount(int count) {
    return '$count abonnements et récurrences';
  }

  @override
  String recurring_perWeek(String amount) {
    return '$amount / semaine';
  }

  @override
  String get recurring_perMonth => '/ mois';

  @override
  String get recurring_fromAccount => 'Compte source';

  @override
  String get recurring_toAccount => 'Compte cible';

  @override
  String recurring_targetAmount(String currency) {
    return 'Montant cible ($currency)';
  }

  @override
  String get recurring_autoPayAt => 'Paiement auto à';

  @override
  String get recurring_autoPayOnDueDate => 'Paiement auto à échéance';

  @override
  String get recurring_autoPayEnabledSub =>
      'Enregistré automatiquement à l\'échéance';

  @override
  String get recurring_autoPayDisabledSub =>
      'Enregistrer automatiquement à l\'échéance';

  @override
  String get recurring_autoPayTime => 'Heure du paiement auto';

  @override
  String get recurring_reminderEnabledSub =>
      'Vous serez averti à la date d\'échéance';

  @override
  String get recurring_reminderDisabledSub =>
      'Être averti lorsqu\'un paiement est dû';

  @override
  String get recurring_earlyReminderEnabledSub =>
      'Rappel supplémentaire 2 jours avant';

  @override
  String get recurring_earlyReminderDisabledSub =>
      'Avertir aussi 2 jours avant';

  @override
  String get recurring_addRecurringBtn => 'Ajouter récurrence';

  @override
  String get recurring_paymentDetails => 'Détails du paiement';

  @override
  String get recurring_linkedAccount => 'Compte lié';

  @override
  String get recurring_deletedAccount => 'Compte supprimé';

  @override
  String get recurring_frequency => 'Fréquence';

  @override
  String get recurring_type => 'Type';

  @override
  String get recurring_startDate => 'Date de début';

  @override
  String get recurring_nextDueDate => 'Prochaine échéance';

  @override
  String get recurring_autoPay => 'Paiement auto';

  @override
  String get recurring_reminder => 'Rappel';

  @override
  String get recurring_endDate => 'Date de fin';

  @override
  String get recurring_totalValue => 'Valeur totale';

  @override
  String get recurring_notes => 'Notes';

  @override
  String get recurring_upcomingPayments => 'Paiements à venir';

  @override
  String recurring_remainingCount(int count) {
    return '$count restants';
  }

  @override
  String get recurring_allInstallmentsCompleted =>
      'Toutes les échéances terminées';

  @override
  String recurring_installmentOf(int num, int total) {
    return '#$num sur $total';
  }

  @override
  String get recurring_paymentPaid => 'Paiement effectué';

  @override
  String get recurring_paymentSkipped => 'Paiement ignoré';

  @override
  String get presets_transfer => 'Virement';

  @override
  String get presets_selectDifferentAccounts =>
      'Veuillez choisir deux comptes différents.';

  @override
  String presets_targetAmountOptional(String currency) {
    return 'Montant cible en $currency (Optionnel)';
  }

  @override
  String get transactions_transfers => 'Virements';

  @override
  String transactions_selectedItemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count éléments sélectionnés',
      one: '1 élément sélectionné',
    );
    return '$_temp0';
  }

  @override
  String transactions_entriesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entrées',
      one: '1 entrée',
    );
    return '$_temp0';
  }

  @override
  String get transactions_clearSelection => 'Effacer la sélection';

  @override
  String get transactions_transferTitle => 'Virement entre comptes';

  @override
  String get transactions_transferBody =>
      'Cette opération fait partie d’un virement. Voulez-vous supprimer ce virement ?';

  @override
  String get transactions_deleteTransfer => 'Supprimer le virement';

  @override
  String get transactions_transferDeleted => 'Virement supprimé';

  @override
  String get transactions_certTitle => 'Opération de certificat';

  @override
  String get transactions_certBody =>
      'Cette opération est liée à un dépôt à terme. Gérez-la depuis l’écran Certificats.';

  @override
  String get transactions_viewCertificate => 'Voir le certificat';

  @override
  String get transactions_openCertificates => 'Ouvrir Certificats';

  @override
  String get transactions_loanFallback => 'Prêt';

  @override
  String get transactions_loanPayment => 'Échéance de prêt';

  @override
  String get transactions_goalContribution => 'Contribution à l\'objectif';

  @override
  String get transactions_goalWithdrawal => 'Retrait de l\'objectif';

  @override
  String get calendar_repayment => 'Remboursement';

  @override
  String get calendar_transfersDue => 'Virements récurrents dus';

  @override
  String accounts_subtitleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count comptes',
      one: '1 compte',
    );
    return '$_temp0';
  }

  @override
  String get accounts_tabAccounts => 'Comptes';

  @override
  String get accounts_tabCards => 'Cartes';

  @override
  String get accounts_addCardBtn => 'Ajouter une carte';

  @override
  String get accounts_addNewCardBtn => 'Ajouter une nouvelle carte';

  @override
  String get accounts_editCard => 'Modifier la carte';

  @override
  String get accounts_cardNameHint => 'Nom de la carte (ex. Visa Platinum)';

  @override
  String get accounts_debitCard => 'Carte de débit';

  @override
  String get accounts_prepaidCard => 'Carte prépayée';

  @override
  String get accounts_pinToWidget => 'Épingler au widget';

  @override
  String get accounts_unpinFromWidget => 'Détacher du widget';

  @override
  String get accounts_maxPinnedWarning =>
      'Impossible d\'épingler plus de 3 comptes';

  @override
  String get accounts_selectLinkedBank =>
      'Veuillez sélectionner un compte bancaire lié pour cette carte.';

  @override
  String get accounts_debitSharesBalance =>
      'Les cartes de débit partagent le solde du compte bancaire lié.';

  @override
  String get accounts_linkedBankRequired => 'Compte bancaire lié (Requis)';

  @override
  String get accounts_amountCurrentlyOwed => 'Montant actuellement dû';

  @override
  String get accounts_initialAmountOwed => 'Montant dû initial';

  @override
  String get accounts_cardDebtHint =>
      'Entrez le montant dû sur cette carte (enregistré comme dette)';

  @override
  String accounts_nextCycleCloses(int day) {
    return 'Clôture du prochain cycle vers le jour $day';
  }

  @override
  String accounts_spotPriceLabel(int karat) {
    return 'Cours spot (or ${karat}k/g)';
  }

  @override
  String get accounts_weightTimesPurity => 'Poids × pureté';

  @override
  String accounts_blockDeleteRecurring(int count) {
    return 'Ce compte a $count paiements récurrents actifs. Réaffectez-les ou supprimez-les d\'abord.';
  }

  @override
  String accounts_blockDeleteLoans(int count) {
    return 'Ce compte a $count prêts actifs. Réaffectez-les ou supprimez-les d\'abord.';
  }

  @override
  String accounts_blockDeleteCertificates(int count) {
    return 'Ce compte a $count certificats actifs. Encaissez-les ou supprimez-les d\'abord.';
  }

  @override
  String accounts_blockDeleteLended(int count) {
    return 'Ce compte a $count dettes/prêts en cours. Réglez-les d\'abord.';
  }

  @override
  String accounts_blockDeleteSavings(int count) {
    return 'Ce compte est lié à $count contributions d\'épargne. Réaffectez-les ou supprimez-les d\'abord.';
  }

  @override
  String accounts_blockDeletePresets(int count) {
    return 'Ce compte est utilisé par $count préréglages. Réaffectez-les ou supprimez-les d\'abord.';
  }

  @override
  String accounts_blockDeleteCards(int count) {
    return 'Ce compte est lié à $count cartes. Déliez-les ou supprimez-les d\'abord.';
  }

  @override
  String get add_transaction_selectAccountOrCard =>
      'Veuillez sélectionner un compte ou une carte.';

  @override
  String get add_transaction_balanced => 'Équilibré';

  @override
  String add_transaction_similarExists(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transactions similaires existent déjà :',
      one: 'Une transaction similaire existe déjà :',
    );
    return '$_temp0';
  }

  @override
  String budget_goalsCountSubtitle(int budgets, int goals) {
    return '$budgets budgets · $goals objectifs';
  }

  @override
  String get budget_savingsGoalsCaps => 'OBJECTIFS D\'ÉPARGNE';

  @override
  String budget_percentSaved(String percent) {
    return '$percent% épargné';
  }

  @override
  String budget_ofTarget(String amount) {
    return 'sur $amount';
  }

  @override
  String get budget_goalsTab => 'Objectifs';

  @override
  String get budget_completed => 'Terminé';

  @override
  String get savings_newGoal => 'Nouvel objectif d\'épargne';

  @override
  String get savings_editGoal => 'Modifier l\'objectif';

  @override
  String get certificates_activePrincipal => 'Capital actif';

  @override
  String get certificates_activeCount => 'Nombre actif';

  @override
  String certificates_linkedBank(String name) {
    return 'Lié : $name';
  }

  @override
  String certificates_yieldSummary(String amount, String type) {
    return 'Rendement : $amount ($type)';
  }

  @override
  String certificates_maturesOn(String date) {
    return 'Échéance : $date';
  }

  @override
  String get certificates_settledCaps => 'CLÔTURÉ';

  @override
  String get certificates_activeCaps => 'ACTIF';

  @override
  String get certificates_annualRate => 'Taux annuel';

  @override
  String get certificates_periodicYieldLabel => 'Rendement périodique';

  @override
  String get certificates_maturedAndSettled => 'Échu et clôturé';

  @override
  String get certificates_payoutOverride => 'Versement (manuel)';

  @override
  String get certificates_dayRange => 'Jour (1-31)';

  @override
  String get certificates_noBankAccounts =>
      'Aucun compte bancaire disponible. Créez-en un pour recevoir les intérêts.';

  @override
  String get certificates_selectLinkedBank =>
      'Veuillez sélectionner un compte bancaire lié.';

  @override
  String get creditCard_noFundingAccounts =>
      'Aucun compte bancaire ou espèces disponible pour le paiement.';

  @override
  String get creditCard_processing => 'Traitement en cours...';

  @override
  String creditCard_payAmountBtn(String amount) {
    return 'Payer $amount';
  }

  @override
  String get insights_loanPaymentsThisMonth =>
      'Remboursements de prêts ce mois';

  @override
  String get insights_spendingForecast => 'Prévision des dépenses';

  @override
  String get insights_forecastPrefix => 'À ce rythme, vous dépenserez ';

  @override
  String insights_forecastSuffix(String month, int days) {
    return ' d\'ici fin $month — $days jours restants.';
  }

  @override
  String get insights_forecastDisclaimer =>
      'Projection basée sur vos dépenses actuelles, hors futurs prélèvements.';

  @override
  String insights_forecastAccuracy(int days) {
    return 'Basé sur les $days premiers jours — la précision augmente avec le mois.';
  }

  @override
  String insights_projAmount(String amount) {
    return 'Prév. : $amount';
  }

  @override
  String insights_projOfBudget(String percent) {
    return ' ($percent% du budget)';
  }

  @override
  String get insights_outstanding => 'Restant dû';

  @override
  String get insights_monthlyObligation => 'Mensualité';

  @override
  String get loans_principal => 'Capital';

  @override
  String get loans_interestRate => 'Taux d\'intérêt';

  @override
  String get loans_duration => 'Durée';

  @override
  String get loans_transferTo => 'Verser le prêt sur';

  @override
  String get loans_payFrom => 'Payer les mensualités depuis';

  @override
  String loans_dueDayTime(int day, String time) {
    return 'Échéance : Jour $day à $time';
  }

  @override
  String more_activeCount(int count) {
    return '$count actifs';
  }

  @override
  String more_toolsSubtitle(int count) {
    return '$count outils et préférences';
  }

  @override
  String get more_totalWealthCaps => 'PATRIMOINE TOTAL';

  @override
  String get more_liveNetWorthSub => 'Patrimoine net agrégé en temps réel';

  @override
  String more_assetsAmount(String amount) {
    return 'Actifs : $amount';
  }

  @override
  String more_liabilitiesAmount(String amount) {
    return 'Passifs : $amount';
  }

  @override
  String get netWorth_debtFree => 'Sans dette';

  @override
  String get netWorth_showLess => 'Afficher moins';

  @override
  String netWorth_showAll(int count) {
    return 'Tout afficher ($count)';
  }

  @override
  String get netWorth_zeroLiabilities =>
      'Aucune dette enregistrée ! Vos dettes s\'élèvent à 0,00.';

  @override
  String get netWorth_lentDebts => 'Prêts / Dettes';

  @override
  String netWorth_snapBreakdown(String assets, String accounts) {
    return 'Actifs : $assets · Comptes : $accounts';
  }

  @override
  String get onboarding_nameRequired => 'Le nom est requis';

  @override
  String get onboarding_popularCurrencies => 'Devises populaires';

  @override
  String get onboarding_debitCardNextStep =>
      'Vous pourrez ajouter une carte de débit à ce compte à l\'étape suivante';

  @override
  String get onboarding_addDebitCardTitle => 'Ajouter une carte de débit';

  @override
  String get onboarding_addDebitCardDesc =>
      'Liez une carte de débit à votre compte pour suivre vos dépenses sans effort.';

  @override
  String get onboarding_cardName => 'Nom de la carte';

  @override
  String get onboarding_cardholderName => 'Titulaire de la carte';

  @override
  String get onboarding_last4Digits => '4 derniers chiffres';

  @override
  String get onboarding_cardColor => 'Couleur de la carte';

  @override
  String wrapped_zeroSpendOfDays(int total) {
    return 'sur $total jours sans dépense';
  }

  @override
  String get wrapped_savingsRateLabel => 'Taux d\'épargne';

  @override
  String get wrapped_topCategoryLabel => 'Catégorie phare';

  @override
  String get wrapped_zeroSpendDaysLabel => 'Jours sans dépense';

  @override
  String get wrapped_footerTag => '★ Maîtrise Financière Privée & Hors Ligne ★';

  @override
  String get yearly_tapToExpand => 'Appuyer pour déplier';

  @override
  String get yearly_noDataBadge => 'Aucune donnée';

  @override
  String get export_formatHeader => 'FORMAT D\'EXPORT';

  @override
  String export_pdfPeriod(String range) {
    return 'Période : $range';
  }

  @override
  String export_pdfCurrency(String currency) {
    return 'Devise : $currency';
  }

  @override
  String export_pdfGenerated(String date) {
    return 'Généré : $date';
  }

  @override
  String export_pdfPageOf(int page, int total) {
    return 'Page $page sur $total';
  }

  @override
  String get export_pdfTotalAssets => 'Total des actifs';

  @override
  String get export_pdfTotalLiabilities => 'Total des passifs';

  @override
  String get export_pdfCurrentNetWorth => 'Patrimoine net actuel';

  @override
  String get export_pdfCategory => 'Catégorie';

  @override
  String export_pdfAmountHeader(String currency) {
    return 'Montant ($currency)';
  }

  @override
  String get export_pdfPercentOfExpenses => '% des dépenses totales';

  @override
  String get backup_encryptedTitle => 'Sauvegarde chiffrée';

  @override
  String get backup_encryptedPrompt =>
      'Entrez le mot de passe utilisé pour chiffrer cette sauvegarde :';

  @override
  String get backup_password => 'Mot de passe';

  @override
  String get backup_confirmPassword => 'Confirmer le mot de passe';

  @override
  String get backup_decryptContinue => 'Déchiffrer et continuer';

  @override
  String get backup_chooseRestoreMode => 'Choisir le mode de restauration';

  @override
  String get backup_chooseRestoreModeDesc =>
      'Choisissez de restaurer l\'intégralité ou seulement certaines données.';

  @override
  String get backup_selectiveRestore => 'Restauration sélective';

  @override
  String get backup_selectiveRestoreDesc =>
      'Choisissez des éléments sans effacer vos autres données.';

  @override
  String get backup_fullRestore => 'Restauration complète';

  @override
  String get backup_fullRestoreDesc =>
      'Remplace entièrement toutes les tables et paramètres actuels.';

  @override
  String get backup_selectiveBackup => 'Sauvegarde sélective';

  @override
  String get backup_selectiveBackupBtn => 'Sauvegarde sélective...';

  @override
  String get backup_selectiveBackupDesc =>
      'Choisissez les données financières à exporter au format JSON.';

  @override
  String get backup_selectedRestoredSuccess =>
      'Données sélectionnées restaurées avec succès !';

  @override
  String get backup_savingsGoals => 'Objectifs d\'épargne';

  @override
  String get backup_savingsContributions => 'Contributions d\'épargne';

  @override
  String get backup_encryptionDisabled =>
      'Chiffrement des sauvegardes désactivé';

  @override
  String get backup_encryptionEnabled => 'Chiffrement des sauvegardes activé';

  @override
  String backup_encryptionFailed(String error) {
    return 'Échec du chiffrement : $error';
  }

  @override
  String get backup_encryptAutoTitle => 'Chiffrer les sauvegardes auto';

  @override
  String get backup_encryptAutoDesc =>
      'Protège vos sauvegardes en AES-GCM-256. Mot de passe oublié = données perdues.';

  @override
  String get backup_passwordEmpty => 'Le mot de passe ne peut pas être vide';

  @override
  String get backup_passwordsMismatch =>
      'Les mots de passe ne correspondent pas';

  @override
  String get backup_setPassword => 'Définir le mot de passe';

  @override
  String backup_autoCreated(String file) {
    return 'Sauvegarde auto créée : $file';
  }

  @override
  String backup_autoFailed(String error) {
    return 'Échec de sauvegarde auto : $error';
  }

  @override
  String get backup_nightlySchedule =>
      'Chaque nuit vers 2h00 dans le dossier choisi';

  @override
  String get backup_noFolderSelected => 'Aucun dossier sélectionné';

  @override
  String get backup_keepCopies => 'Copies conservées :';

  @override
  String get backup_encryptAes => 'Chiffrer (AES-GCM)';

  @override
  String backup_failedError(String error) {
    return 'Échec : $error';
  }

  @override
  String backup_lastSuccess(String date, String kb) {
    return 'Dernier : $date ($kb Ko)';
  }

  @override
  String get backup_backingUp => 'Sauvegarde en cours...';

  @override
  String get backup_backUpNow => 'Sauvegarder maintenant';

  @override
  String get backup_androidIdleNote =>
      'Exécuté vers 2h00. Android peut différer si le téléphone veille.';

  @override
  String get backup_selectAll => 'Tout sélectionner';

  @override
  String get backup_deselectAll => 'Tout désélectionner';

  @override
  String get backup_selectiveSaved => 'Sauvegarde sélective enregistrée !';

  @override
  String backup_exportFailed(String error) {
    return 'Échec de l\'export : $error';
  }

  @override
  String backup_exportSelected(int count) {
    return 'Exporter ($count) éléments';
  }

  @override
  String backup_restoreSelected(int count) {
    return 'Restaurer ($count) éléments';
  }

  @override
  String get backup_selectiveRestoreNote =>
      'Seuls les éléments choisis seront restaurés. Vos autres données restent intactes.';

  @override
  String backup_countInBackup(int count) {
    return '$count dans la sauvegarde';
  }

  @override
  String get backup_entityTxSplitsPresets =>
      'Transactions, répartitions & modèles';

  @override
  String get backup_entityRecurringHistory =>
      'Paiements récurrents & historique';

  @override
  String get backup_entityLoansPayments => 'Prêts & remboursements';

  @override
  String get backup_entityLentContacts => 'Prêts d\'argent & contacts';

  @override
  String get backup_entityAssetsValuables => 'Actifs & objets de valeur';

  @override
  String get backup_entityWishlistGoals =>
      'Liste d\'envies & objectifs d\'épargne';

  @override
  String get common_perDay => '/ jour';

  @override
  String common_daysShort(int count) {
    return '$count j';
  }

  @override
  String get common_splitCaps => 'PARTAGÉ';

  @override
  String budget_deletedCategory(String name) {
    return '$name supprimé';
  }

  @override
  String get loans_paymentDeleted => 'Paiement supprimé';

  @override
  String certificates_collectionDayLabel(String frequency, int day) {
    return '$frequency (Jour $day)';
  }

  @override
  String add_transaction_duplicateItem(
      String amount, String date, String desc) {
    return '• $amount le $date$desc';
  }

  @override
  String creditCard_billPaymentDesc(String name) {
    return 'Paiement carte de crédit — $name';
  }

  @override
  String get onboarding_defaultBankName => 'Banque Principale';

  @override
  String get onboarding_defaultCardholder => 'MEMBRE EXPENSY';

  @override
  String get onboarding_defaultUser => 'Utilisateur';

  @override
  String get export_excelSheetName => 'Transactions';

  @override
  String get export_headerDate => 'Date';

  @override
  String get export_headerDescription => 'Description';

  @override
  String get export_headerType => 'Type';

  @override
  String get export_headerAmount => 'Montant';

  @override
  String get export_headerCurrency => 'Devise';

  @override
  String get export_headerAccount => 'Compte';

  @override
  String get export_headerCategory => 'Catégorie';

  @override
  String get export_headerSubcategory => 'Sous-catégorie';

  @override
  String get export_headerNote => 'Note';

  @override
  String get cat_food_exp => 'Alimentation';

  @override
  String get cat_transport => 'Transport';

  @override
  String get cat_shopping => 'Achats';

  @override
  String get cat_bills => 'Factures et Services';

  @override
  String get cat_health => 'Santé';

  @override
  String get cat_entertainment => 'Divertissement';

  @override
  String get cat_education => 'Éducation';

  @override
  String get cat_personal => 'Soins Personnels';

  @override
  String get cat_salary => 'Salaire';

  @override
  String get cat_freelance => 'Freelance';

  @override
  String get cat_investments => 'Investissements';

  @override
  String get cat_gifts => 'Cadeaux';

  @override
  String get cat_other_inc => 'Autres Revenus';

  @override
  String get cat_other_exp => 'Autres Dépenses';

  @override
  String get cat_sys_transfer => 'Virement';

  @override
  String get cat_sys_investment => 'Placement';

  @override
  String get sub_groceries => 'Courses';

  @override
  String get sub_restaurants => 'Restaurants';

  @override
  String get sub_delivery => 'Livraison';

  @override
  String get sub_coffee_tea => 'Café et Thé';

  @override
  String get sub_fuel => 'Carburant';

  @override
  String get sub_public_transit => 'Transports en commun';

  @override
  String get sub_taxi_ride => 'Taxi et VTC';

  @override
  String get sub_maintenance => 'Entretien';

  @override
  String get sub_parking_tolls => 'Parking et Péages';

  @override
  String get sub_clothing => 'Vêtements';

  @override
  String get sub_electronics => 'Électronique';

  @override
  String get sub_home_furniture => 'Maison et Meubles';

  @override
  String get sub_gifts => 'Cadeaux';

  @override
  String get sub_electricity => 'Électricité';

  @override
  String get sub_internet => 'Internet';

  @override
  String get sub_water => 'Eau';

  @override
  String get sub_phone => 'Téléphone';

  @override
  String get sub_medicine => 'Médicaments';

  @override
  String get sub_doctor => 'Médecin';

  @override
  String get sub_movies => 'Cinéma';

  @override
  String get sub_games => 'Jeux';

  @override
  String get sub_subscriptions => 'Abonnements';

  @override
  String get notif_overBudgetTitle => '🚨 Budget dépassé';

  @override
  String notif_overBudgetBody(String category, String amount, String period) {
    return '$category — $amount au-dessus de votre limite ($period)';
  }

  @override
  String get notif_goalReachedTitle => '🎉 Objectif atteint';

  @override
  String notif_goalReachedBody(String amount, String name) {
    return 'Vous avez atteint votre objectif de $amount pour $name !';
  }

  @override
  String get notif_certPayoutDueTitle => '📈 Rendement de certificat dû';

  @override
  String get notif_certPayoutUpcomingTitle =>
      '📈 Rendement de certificat à venir';

  @override
  String notif_certPayoutBody(String name) {
    return 'Le rendement pour $name est dû aujourd\'hui.';
  }

  @override
  String notif_certPayoutSoonBody(String name) {
    return 'Le rendement pour $name est dû dans 2 jours.';
  }

  @override
  String get notif_creditBillDueTodayTitle => '💳 Facture due aujourd\'hui';

  @override
  String get notif_creditBillDueSoonTitle => '💳 Facture bientôt due';

  @override
  String get notif_dailyReminderTitle => '📝 Rappel quotidien';

  @override
  String get notif_dailyReminderBody =>
      'N\'oubliez pas d\'enregistrer vos dépenses du jour.';

  @override
  String notif_lendedDueTitle(String emoji, String name) {
    return '$emoji Échéance : $name';
  }

  @override
  String get notif_loanPaymentDueTitle => '🏦 Échéance de prêt due';

  @override
  String notif_loanPaymentDueBody(String name) {
    return 'La mensualité de $name est due aujourd\'hui.';
  }

  @override
  String get notif_autoBackupFailedTitle => 'Échec de la sauvegarde auto';

  @override
  String notif_autoBackupFailedBody(String error) {
    return 'Expensy n\'a pas pu créer votre sauvegarde planifiée : $error';
  }

  @override
  String notif_recurringTransferBody(String amount) {
    return 'Virement de $amount dû';
  }

  @override
  String notif_recurringIncomeBody(String amount) {
    return 'Revenu de $amount attendu';
  }

  @override
  String notif_recurringExpenseBody(String amount) {
    return 'Paiement de $amount dû';
  }

  @override
  String notif_creditBillDueTodayBody(String name) {
    return 'Votre facture $name est due aujourd\'hui.';
  }

  @override
  String notif_creditBillDueSoonBody(String name) {
    return 'Votre facture $name est due dans 2 jours.';
  }

  @override
  String notif_lendedLentDueBody(String amount, String name) {
    return '$amount que vous avez prêté à $name est dû aujourd\'hui';
  }

  @override
  String notif_lendedBorrowedDueBody(String amount, String name) {
    return '$amount que vous avez emprunté à $name est dû aujourd\'hui';
  }

  @override
  String notif_recurringTransferDueSoonBody(String amount) {
    return 'Virement de $amount dû dans 2 jours';
  }

  @override
  String notif_recurringIncomeDueSoonBody(String amount) {
    return '$amount attendu dans 2 jours';
  }

  @override
  String notif_recurringExpenseDueSoonBody(String amount) {
    return '$amount dû dans 2 jours';
  }
}
