// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Expensy';

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
  String get settings_accentColor => 'Couleur d\'accentuation';

  @override
  String get settings_appFont => 'Police de l\'application';

  @override
  String get settings_systemDefault => 'Défaut du système';

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
  String get accounts_txs => 'Txs';

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
  String get backup_transactions => 'Transactions';

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
      other: '$count éléments',
      one: '1 élément',
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
      other: '$count éléments',
      one: '1 élément',
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
  String get lended_theyOweMe => 'Ils me doivent';

  @override
  String get lended_iOweThem => 'Je leur dois';

  @override
  String get lended_net => 'Net';

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
      other: '$count enregistrements actifs',
      one: '1 enregistrement actif',
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
      other: '$count transactions dans la période',
      one: '1 transaction dans la période',
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
  String get accounts_accounts => 'Accounts';

  @override
  String get accounts_totalBalance => 'Total Balance';

  @override
  String get accounts_excluded => 'Excluded';

  @override
  String get accounts_goldPriceNotYetLoade =>
      'Gold price not yet loaded. Wait a moment and try again.';

  @override
  String get accounts_accountType => 'Account Type';

  @override
  String get accounts_currency => 'Currency';

  @override
  String get accounts_goldPurityKarat => 'Gold Purity (Karat)';

  @override
  String get accounts_weight => 'Weight';

  @override
  String get accounts_excludeFromTotalBala => 'Exclude from Total Balance';

  @override
  String get accounts_colour => 'Colour';

  @override
  String get accounts_liveGoldValue => 'Live Gold Value';

  @override
  String get accounts_enterWeightAboveToSe => 'Enter weight above to see value';

  @override
  String get add_transaction_expense => 'Expense';

  @override
  String get add_transaction_income => 'Income';

  @override
  String get add_transaction_account => 'Account';

  @override
  String get add_transaction_category => 'Category';

  @override
  String get assets_assets => 'Assets';

  @override
  String get backup_restoreBackup => 'Restore Backup?';

  @override
  String get backup_cancel => 'Cancel';

  @override
  String get backup_replaceData => 'Replace Data';

  @override
  String get backup_backupRestore => 'Backup & Restore';

  @override
  String get backup_everythingAlways => 'Everything, always';

  @override
  String get backup_createBackup => 'Create Backup';

  @override
  String get backup_saveAsJson => 'Save as JSON';

  @override
  String get backup_exportsAllAppDataToA =>
      'Exports ALL app data to a portable file';

  @override
  String get backup_restoreBackup_ => 'Restore Backup';

  @override
  String get backup_loadFromJson => 'Load from JSON';

  @override
  String get backup_picksABackupFileAndR =>
      'Picks a backup file and restores it';

  @override
  String get backup_thisOverwritesAllCur => 'This overwrites ALL current data.';

  @override
  String get budget_budgets => 'Budgets';

  @override
  String get budget_empty => ' · ';

  @override
  String get budget_overBudget => 'Over budget';

  @override
  String get budget_thisCategoryAlreadyH =>
      'This category already has a budget. Tap it to edit.';

  @override
  String get budget_period => 'Period';

  @override
  String get budget_monthly => 'Monthly';

  @override
  String get budget_weekly => 'Weekly';

  @override
  String get budget_category => 'Category';

  @override
  String get categories_categories => 'Categories';

  @override
  String get categories_expense => 'Expense';

  @override
  String get categories_income => 'Income';

  @override
  String get categories_colour => 'Colour';

  @override
  String get categories_icon => 'Icon';

  @override
  String get categories_autoBasedOnName => 'Auto (based on name)';

  @override
  String get categories_expenseCategories => 'Expense Categories';

  @override
  String get categories_incomeCategories => 'Income Categories';

  @override
  String get currency_converter_currencyConverter => 'Currency Converter';

  @override
  String get currency_converter_amount => 'Amount';

  @override
  String get currency_converter_convertedTo => 'Converted to';

  @override
  String get export_exportTransactions => 'Export Transactions';

  @override
  String get export_dateRange => 'Date Range';

  @override
  String get export_formatExcelXlsx => 'Format: Excel (.xlsx)';

  @override
  String get home_totalBalance => 'Total Balance';

  @override
  String get home_accounts => 'Accounts';

  @override
  String get home_recentTransactions => 'Recent Transactions';

  @override
  String get home_noTransactionsYet => 'No transactions yet';

  @override
  String get home_add => 'Add';

  @override
  String get insights_insights => 'Insights';

  @override
  String get lended_person_deletePerson => 'Delete person';

  @override
  String get lended_person_editPerson => 'Edit Person';

  @override
  String get lended_person_colour => 'Colour';

  @override
  String get lended_person_saveChanges => 'Save Changes';

  @override
  String get lended_person_settled => 'SETTLED';

  @override
  String get lended_person_settle => 'Settle';

  @override
  String get lended_person_setADueDateFirstToEn =>
      'Set a due date first to enable reminders.';

  @override
  String get lended_person_iLent => 'I Lent';

  @override
  String get lended_person_iBorrowed => 'I Borrowed';

  @override
  String get lended_person_accountOptional => 'Account (optional)';

  @override
  String get lended_person_dueDateReminder => 'Due Date Reminder';

  @override
  String get lended_person_remindMeAt => 'Remind me at';

  @override
  String get lended_person_active => 'Active';

  @override
  String get lended_person_settled_ => 'Settled';

  @override
  String get lended_lentMoney => 'Lent Money';

  @override
  String get lended_overdue => 'OVERDUE';

  @override
  String get lended_colour => 'Colour';

  @override
  String get more_more => 'More';

  @override
  String get onboarding_back => 'Back';

  @override
  String get onboarding_welcomeToExpensy => 'Welcome to Expensy!';

  @override
  String get onboarding_restoreABackup => 'Restore a Backup';

  @override
  String get onboarding_loadAPreviouslySaved =>
      'Load a previously saved Expensy JSON file';

  @override
  String get onboarding_or => 'or';

  @override
  String get onboarding_startFresh => 'Start Fresh';

  @override
  String get onboarding_firstWhatShouldWeCal =>
      'First, what should we call you?';

  @override
  String get onboarding_defaultCurrency => 'Default Currency';

  @override
  String get onboarding_thisWillBeUsedAcross =>
      'This will be used across the app.\\nYou can change it later in Settings.';

  @override
  String get onboarding_searchAllCurrencies => 'Search all currencies';

  @override
  String get onboarding_yourFirstAccount => 'Your First Account';

  @override
  String get onboarding_setUpYourMainAccount =>
      'Set up your main account to start tracking.';

  @override
  String get onboarding_accountType => 'Account Type';

  @override
  String get onboarding_currency => 'Currency';

  @override
  String get onboarding_colour => 'Colour';

  @override
  String get recurring_recurring => 'Recurring';

  @override
  String get recurring_income => 'INCOME';

  @override
  String get recurring_2D => '−2d';

  @override
  String get recurring_skipNextPayment => 'Skip Next Payment?';

  @override
  String get recurring_cancel => 'Cancel';

  @override
  String get recurring_skip => 'Skip';

  @override
  String get recurring_noHistoryYet => 'No history yet';

  @override
  String get recurring_expense => 'Expense';

  @override
  String get recurring_income_ => 'Income';

  @override
  String get recurring_every => 'Every ';

  @override
  String get recurring_days => 'Days';

  @override
  String get recurring_weeks => 'Weeks';

  @override
  String get recurring_months => 'Months';

  @override
  String get recurring_years => 'Years';

  @override
  String get recurring_payments => 'Payments';

  @override
  String get recurring_totalCost => 'Total Cost';

  @override
  String get recurring_account => 'Account';

  @override
  String get recurring_category => 'Category';

  @override
  String get recurring_paymentReminder => 'Payment Reminder';

  @override
  String get recurring_notificationWillFire =>
      'Notification will fire on the next due date at this time.';

  @override
  String get recurring_remind2DaysBefore => 'Remind 2 days before';

  @override
  String get statistics_statistics => 'Statistics';

  @override
  String get statistics_expensesByCategory => 'Expenses by Category';

  @override
  String get transactions_transactions => 'Transactions';

  @override
  String get transactions_settled => 'Settled';

  @override
  String get transfer_transfer => 'Transfer';

  @override
  String get transfer_from => 'FROM';

  @override
  String get transfer_to => 'TO';

  @override
  String get transfer_enterAnAmountToSeeTh =>
      'Enter an amount to see the conversion';

  @override
  String get wishlist_wishlist => 'Wishlist';

  @override
  String get wishlist_priority => 'Priority';

  @override
  String get shared_widgets_delete => 'Delete?';

  @override
  String get shared_widgets_cancel => 'Cancel';

  @override
  String get shared_widgets_delete_ => 'Delete';

  @override
  String get shared_widgets_none => 'None';

  @override
  String get shared_widgets_selectCurrency => 'Select Currency';

  @override
  String get main_home => 'Accueil';

  @override
  String get main_transactions => 'Transactions';

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
}
