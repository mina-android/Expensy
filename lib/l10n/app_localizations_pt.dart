// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Caro';

  @override
  String get settings_title => 'Configurações';

  @override
  String get settings_appearance => 'Aparência';

  @override
  String get settings_theme => 'Tema';

  @override
  String get settings_system => 'Sistema';

  @override
  String get settings_light => 'Claro';

  @override
  String get settings_dark => 'Escuro';

  @override
  String get settings_amoledTitle => 'Preto Puro (AMOLED)';

  @override
  String get settings_amoledSubtitle => 'Força fundos pretos no modo escuro';

  @override
  String get settings_systemDefault => 'Padrão do Sistema';

  @override
  String get settings_dynamicColor => 'Cor Dinâmica';

  @override
  String get settings_dynamicColorSubtitle =>
      'Use cores de papel de parede do sistema';

  @override
  String get settings_accentColor => 'Cor de destaque';

  @override
  String get settings_accentColorSubtitle =>
      'Escolha uma cor de semente para o aplicativo';

  @override
  String get settings_appFont => 'Fonte do aplicativo';

  @override
  String get settings_currency => 'Moeda';

  @override
  String get settings_defaultCurrency => 'Moeda padrão';

  @override
  String get settings_preferences => 'Preferências';

  @override
  String get settings_weekStartsOn => 'A semana começa';

  @override
  String get settings_monday => 'Segunda-feira';

  @override
  String get settings_sunday => 'Domingo';

  @override
  String get settings_hideBalance => 'Ocultar saldo';

  @override
  String get settings_hideBalanceSubtitle => 'Mostrar ••••• em vez de valores';

  @override
  String get settings_language => 'Idioma';

  @override
  String get settings_profile => 'Perfil';

  @override
  String get settings_displayName => 'Nome de exibição';

  @override
  String get settings_notSet => 'Não definido';

  @override
  String get settings_about => 'Sobre';

  @override
  String get settings_version => 'Versão';

  @override
  String get settings_privacy => 'Privacidade';

  @override
  String get settings_privacySubtitle =>
      'Todos os dados armazenados localmente — 100% offline';

  @override
  String get settings_github => 'Github';

  @override
  String get settings_githubSubtitle => 'Ver código-fonte';

  @override
  String get settings_developer => 'Desenvolvedor';

  @override
  String get settings_developerSubtitle =>
      'Conheça mais projetos da Mina Android';

  @override
  String get settings_githubProfile => 'Perfil GitHub';

  @override
  String get settings_developerWebsite => 'Site do desenvolvedor';

  @override
  String get settings_close => 'Fechar';

  @override
  String get settings_yourName => 'Seu nome';

  @override
  String get settings_cancel => 'Cancelar';

  @override
  String get settings_save => 'Salvar';

  @override
  String recurring_expenses(Object count) {
    return 'Expenses ($count)';
  }

  @override
  String recurring_incomeList(Object count) {
    return 'Income ($count)';
  }

  @override
  String get recurring_monthly => 'Mensalmente';

  @override
  String get recurring_weekly => 'Semanal';

  @override
  String get recurring_noRecurringExpenses => 'Sem despesas recorrentes';

  @override
  String get recurring_noRecurringIncome => 'Sem receitas recorrentes';

  @override
  String get recurring_addExpense => 'Adicionar Despesa';

  @override
  String get recurring_addIncome => 'Adicionar Renda';

  @override
  String get recurring_tapPlusToAddOne => 'Toque em + para adicionar um';

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
  String get recurring_overdue => 'Atrasado!';

  @override
  String get recurring_dueToday => 'Vencimento hoje';

  @override
  String recurring_dueInDays(Object days) {
    return 'Vencimento em ${days}d';
  }

  @override
  String get recurring_edit => 'Editar';

  @override
  String get recurring_skipBtn => 'Pular';

  @override
  String recurring_nextDate(Object date) {
    return 'Next: $date';
  }

  @override
  String get recurring_pay => 'Pagar';

  @override
  String get recurring_del => 'Del';

  @override
  String recurring_historyCount(Object count) {
    return 'History ($count)';
  }

  @override
  String get recurring_paymentHistory => 'Histórico de pagamentos';

  @override
  String get recurring_notificationPermissionDenied =>
      'Permissão de notificação negada. Ative-o em Configurações → Aplicativos → Expensy → Notificações.';

  @override
  String get recurring_remindMeAt => 'Lembre-me em';

  @override
  String get recurring_editRecurring => 'Editar recorrente';

  @override
  String get recurring_addRecurring => 'Adicionar um pagamento recorrente';

  @override
  String get recurring_name => 'Nome';

  @override
  String get recurring_amountPerPayment => 'Montante por pagamento';

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
      'Nenhum último pagamento (em andamento)';

  @override
  String get accounts_refreshExchangeRates => 'Atualizar taxas de câmbio';

  @override
  String get accounts_noAccounts => 'Nenhuma conta';

  @override
  String get accounts_tapPlusToAddYourFirst =>
      'Toque em + para adicionar sua primeira conta';

  @override
  String get accounts_fetchingExchangeRates => 'Buscando taxas de câmbio…';

  @override
  String get accounts_exchangeRatesUnavailable =>
      'Taxas de câmbio indisponíveis (offline). Saldos apresentados em moeda nativa.';

  @override
  String get accounts_unknown => 'Desconhecido';

  @override
  String accounts_ratesUpdated(Object timeStr) {
    return 'Tarifas atualizadas $timeStr · Toque em ↺ para atualizar';
  }

  @override
  String get accounts_goldCaps => 'OURO';

  @override
  String get accounts_balance => 'Equilíbrio';

  @override
  String get accounts_income => 'Renda';

  @override
  String get accounts_expense => 'Despesa';

  @override
  String get accounts_txs => 'Tx';

  @override
  String get accounts_value => 'Valor';

  @override
  String get accounts_karat => 'Quilate';

  @override
  String accounts_pure(Object percentage) {
    return '$percentage% pure';
  }

  @override
  String get accounts_weightLabel => 'Peso';

  @override
  String get accounts_perGram => 'Por grama';

  @override
  String get accounts_bank => 'Banco';

  @override
  String get accounts_cash => 'Dinheiro';

  @override
  String get accounts_savings => 'Poupança';

  @override
  String get accounts_creditCard => 'Cartão de Crédito';

  @override
  String get accounts_eWallet => 'Carteira Eletrônica';

  @override
  String get accounts_gold => 'Ouro';

  @override
  String get accounts_editAccount => 'Editar conta';

  @override
  String get accounts_addAccount => 'Adicionar nova conta';

  @override
  String get accounts_accountName => 'Nome da conta';

  @override
  String get accounts_weightInGrams => 'Peso em gramas';

  @override
  String get accounts_initialBalance => 'Saldo Inicial';

  @override
  String get accounts_wontCountTowardYourHome =>
      'Não contará para o total da tela inicial';

  @override
  String get accounts_saveChanges => 'Salvar alterações';

  @override
  String get accounts_addAccountBtn => 'Adicionar conta';

  @override
  String get accounts_fetchingGoldPrice => 'Buscando o preço do ouro…';

  @override
  String get accounts_goldPriceUnavailable =>
      'Preço do ouro indisponível — verifique sua conexão';

  @override
  String lended_person_owesYou(Object name) {
    return '$name owes you';
  }

  @override
  String lended_person_youOwe(Object name) {
    return 'You owe $name';
  }

  @override
  String get lended_person_allSettledUp => 'Tudo resolvido';

  @override
  String get lended_person_noRecordsYet => 'Ainda não há registros';

  @override
  String get lended_person_tapPlusToLog =>
      'Toque em + para registrar dinheiro emprestado ou emprestado';

  @override
  String get lended_person_name => 'Nome';

  @override
  String get lended_person_notesOptional => 'Notas (opcional)';

  @override
  String get lended_person_lent => 'Quaresma';

  @override
  String get lended_person_borrowed => 'Emprestado';

  @override
  String get lended_person_overdue => 'Atrasado!';

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
      'Permissão de notificação negada. Ative-o em Configurações → Aplicativos → Expensy → Notificações.';

  @override
  String get lended_person_remindMeAtPrompt => 'Lembre-me em';

  @override
  String get lended_person_editRecord => 'Editar registro';

  @override
  String get lended_person_addRecord => 'Adicionar registro';

  @override
  String get lended_person_amount => 'Quantia';

  @override
  String lended_person_dueColon(Object date) {
    return 'Due: $date';
  }

  @override
  String get lended_person_noDueDate => 'Sem data de vencimento';

  @override
  String get lended_person_setDueFirst =>
      'Defina uma data de vencimento primeiro';

  @override
  String get lended_person_notifiedOnDue =>
      'Você será notificado na data de vencimento';

  @override
  String get lended_person_getNotifiedWhenDue =>
      'Seja notificado quando isso acontecer';

  @override
  String get lended_person_thatTimePassed =>
      'Esse horário de hoje já passou. Em vez disso, você será notificado em breve.';

  @override
  String lended_person_notificationFiresOn(Object date, Object time) {
    return 'A notificação é disparada em $date às $time.';
  }

  @override
  String get lended_person_saveChangesBtn => 'Salvar alterações';

  @override
  String get lended_person_addRecordBtn => 'Adicionar registro';

  @override
  String get transactions_searchTransactions => 'Pesquisar transações...';

  @override
  String get transactions_all => 'Todos';

  @override
  String get transactions_income => 'Renda';

  @override
  String get transactions_expenses => 'Despesas';

  @override
  String get transactions_lent => 'Quaresma';

  @override
  String get transactions_borrowed => 'Emprestado';

  @override
  String get transactions_noTransactions => 'Nenhuma transação';

  @override
  String get transactions_tapPlusToAddOne => 'Toque em + para adicionar um';

  @override
  String get transactions_today => 'Hoje';

  @override
  String get transactions_yesterday => 'Ontem';

  @override
  String transactions_lentTo(Object name) {
    return 'Lent to $name';
  }

  @override
  String transactions_borrowedFrom(Object name) {
    return 'Borrowed from $name';
  }

  @override
  String get transactions_unknown => 'Desconhecido';

  @override
  String transactions_due(Object date) {
    return 'Due $date';
  }

  @override
  String get transactions_unsettled => 'Inquieto';

  @override
  String get onboarding_restoreFailed =>
      'Falha na restauração: o arquivo pode estar corrompido ou não ser um backup Expensy.';

  @override
  String get onboarding_continue => 'Continuar';

  @override
  String get onboarding_getStarted => 'Comece';

  @override
  String get onboarding_yourPersonalTracker =>
      'Seu rastreador financeiro pessoal 100% offline.\nJá possui um backup de outro dispositivo ou uma instalação anterior?';

  @override
  String get onboarding_restoring => 'Restaurando...';

  @override
  String get onboarding_chooseBackupFile => 'Escolha o arquivo de backup';

  @override
  String get onboarding_letsGetYouSetUp => 'Vamos preparar você';

  @override
  String get onboarding_yourName => 'Seu nome';

  @override
  String get onboarding_accountName => 'Nome da conta';

  @override
  String get onboarding_bank => 'Banco';

  @override
  String get onboarding_cash => 'Dinheiro';

  @override
  String get onboarding_savings => 'Poupança';

  @override
  String get onboarding_credit => 'Crédito';

  @override
  String get onboarding_wallet => 'Carteira';

  @override
  String get onboarding_startingBalance => 'Saldo Inicial';

  @override
  String get backup_replaceDataWarning =>
      'Isso substituirá TODOS os seus dados atuais pelo backup.\nIsto não pode ser desfeito.';

  @override
  String get backup_whatsIncluded => 'O que está incluído';

  @override
  String get backup_backupDescription =>
      'Cada backup inclui todos os seus dados – contas, transações, pagamentos recorrentes e seu histórico de pagamento/pular, orçamentos, itens da lista de desejos, pessoas e registros emprestados e emprestados, ativos, categorias e configurações de aplicativos.';

  @override
  String get backup_saving => 'Salvando...';

  @override
  String get backup_saveBackup => 'Salvar backup';

  @override
  String get backup_restoring => 'Restaurando...';

  @override
  String get backup_restoreBackupBtn => 'Restaurar Backup';

  @override
  String get backup_restoreWarningText =>
      'Compatível com backups de qualquer versão do aplicativo. Os campos ausentes são preenchidos com padrões seguros.';

  @override
  String get backup_included => 'incluído';

  @override
  String get backup_accounts => 'Contas';

  @override
  String get backup_transactions => 'Transações';

  @override
  String get backup_recurringPayments => 'Pagamentos recorrentes';

  @override
  String get backup_recurringHistory => 'Histórico recorrente';

  @override
  String get backup_budgets => 'Orçamentos';

  @override
  String get backup_wishlist => 'Lista de desejos';

  @override
  String get backup_lentPeople => 'Quaresma/Empréstimo — Pessoas';

  @override
  String get backup_lentRecords => 'Emprestado/Empréstimo — Registros';

  @override
  String get backup_assets => 'Ativos';

  @override
  String get backup_categories => 'Categorias';

  @override
  String get backup_settings => 'Configurações';

  @override
  String backup_backupSavedSuccessfully(Object savedPath) {
    return 'Backup salvo com sucesso:\n$savedPath';
  }

  @override
  String backup_backupFailed(Object error) {
    return 'Backup failed: $error';
  }

  @override
  String backup_upgradedFrom(Object originalVersion, Object schemaVersion) {
    return '(atualizado de v$originalVersion → v$schemaVersion)';
  }

  @override
  String backup_dataRestoredSuccessfully(Object vLabel) {
    return 'Dados restaurados com sucesso!$vLabel';
  }

  @override
  String backup_restoreFailed(Object error) {
    return 'Falha na restauração: $error';
  }

  @override
  String get backup_restoreFailedCorrupted =>
      'Falha na restauração: o arquivo pode estar corrompido ou não ser um backup Expensy.';

  @override
  String get budget_noBudgetsYet => 'Ainda sem orçamentos';

  @override
  String get budget_tapToAddBudget =>
      'Toque em + para definir um limite de gastos por categoria';

  @override
  String get budget_budgeted => 'Orçamentado';

  @override
  String get budget_leftToSpend => 'Restante para gastar';

  @override
  String get budget_spent => 'Gasto';

  @override
  String get budget_overLimit => 'Acima do limite';

  @override
  String get budget_unknown => 'Desconhecido';

  @override
  String get budget_weeklyLabel => 'Semanal';

  @override
  String get budget_monthlyLabel => 'Mensalmente';

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
    return '$percent% usado';
  }

  @override
  String get budget_editBudget => 'Editar orçamento';

  @override
  String get budget_setBudget => 'Adicionar novo orçamento';

  @override
  String get budget_budgetAmount => 'Montante do orçamento';

  @override
  String budget_previewFor(Object catName) {
    return 'Visualização de \\\"$catName\\\"';
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
  String get budget_saveChanges => 'Salvar alterações';

  @override
  String get budget_budget => 'Orçamento';

  @override
  String get budget_rollover => 'Rollover (Envelopes)';

  @override
  String get budget_rolloverDesc =>
      'Transferir excedentes não utilizados ou déficits para o próximo período';

  @override
  String get budget_rolloverBadge => 'Rollover';

  @override
  String budget_base(Object amount) {
    return 'Base: $amount';
  }

  @override
  String budget_rolloverFrom(Object period, Object amount) {
    return 'Rollover ($period): $amount';
  }

  @override
  String budget_totalAvailable(Object amount) {
    return 'Total disponível: $amount';
  }

  @override
  String get budget_lastWeek => 'Semana passada';

  @override
  String get pacing_dailyBudget => 'Gasto seguro';

  @override
  String pacing_safeToSpend(Object amount, Object days) {
    return 'Gasto seguro: $amount/dia ($days dias restantes)';
  }

  @override
  String pacing_caution(Object amount) {
    return 'Ritmo acelerado — limite a $amount/dia';
  }

  @override
  String get pacing_overPaced =>
      'Alerta de ritmo — reduza o ritmo para ficar no orçamento';

  @override
  String get pacing_budgetExhausted =>
      'Orçamento esgotado — sem saldo diário restante';

  @override
  String get pacing_onTrack => 'No ritmo certo';

  @override
  String get pacing_fast => 'Ritmo rápido';

  @override
  String get pacing_alert => 'Alerta de ritmo';

  @override
  String pacing_daysLeft(Object days) {
    return '$days dias restantes';
  }

  @override
  String get pacing_setBudgetPrompt =>
      'Toque para definir limites de orçamento →';

  @override
  String get pacing_dailyAvgPace => 'Ritmo diário';

  @override
  String pacing_perDay(Object amount) {
    return '$amount / dia';
  }

  @override
  String get calendar_title => 'Calendário financeiro';

  @override
  String get calendar_subtitle => 'Mapa de calor de gastos e vencimentos';

  @override
  String calendar_zeroSpendDays(Object count) {
    return '$count dias sem gastos';
  }

  @override
  String get calendar_zeroSpendDayTitle => 'Dia sem gastos! 🎉';

  @override
  String get calendar_zeroSpendDayDesc =>
      'Excelente disciplina financeira sem nenhum gasto hoje.';

  @override
  String get calendar_billsDue => 'Contas e assinaturas a vencer';

  @override
  String get calendar_loansDue => 'Parcelas de empréstimo a vencer';

  @override
  String get calendar_lendedDue => 'Reembolsos esperados';

  @override
  String calendar_dayTransactions(Object count) {
    return 'Transações ($count)';
  }

  @override
  String get calendar_noActivity => 'Nenhuma transação ou obrigação nesta data';

  @override
  String get calendar_today => 'Hoje';

  @override
  String calendar_averageDaily(Object amount) {
    return 'Média diária: $amount';
  }

  @override
  String get wrapped_title => 'Expensy Wrapped';

  @override
  String wrapped_bannerTitle(Object month) {
    return 'Sua retrospectiva de $month está pronta!';
  }

  @override
  String get wrapped_bannerSub =>
      'Toque para ver sua história financeira mensal';

  @override
  String get wrapped_theBigPicture => 'Visão geral';

  @override
  String wrapped_howMoneyMoved(Object month) {
    return 'Veja como seu dinheiro se movimentou em $month';
  }

  @override
  String get wrapped_totalInflow => 'Entradas totais';

  @override
  String get wrapped_totalOutflow => 'Saídas totais';

  @override
  String get wrapped_netSavings => 'Economia líquida';

  @override
  String wrapped_savingsRate(Object rate) {
    return 'Taxa de economia: $rate%';
  }

  @override
  String get wrapped_topCategoryTitle => 'Para onde foi?';

  @override
  String wrapped_topCategorySub(Object category) {
    return 'Sua principal categoria de gastos foi $category';
  }

  @override
  String wrapped_topCategoryShare(Object percent) {
    return '$percent% do seu gasto total';
  }

  @override
  String get wrapped_biggestSplurgeTitle => 'Maior gasto';

  @override
  String get wrapped_biggestSplurgeSub => 'Sua maior despesa individual do mês';

  @override
  String get wrapped_noSplurge =>
      'Sem extravagâncias! Você não teve despesas este mês.';

  @override
  String get wrapped_heroHabitTitle => 'Hábito heróico';

  @override
  String wrapped_zeroSpendAchieved(Object count) {
    return '$count dias com zero gastos';
  }

  @override
  String wrapped_heroHabitDesc(Object count) {
    return 'Você conseguiu $count dias sem gastos. Disciplina financeira excepcional!';
  }

  @override
  String get wrapped_receiptTitle => 'Extrato mensal';

  @override
  String get wrapped_obscureToggle => 'Ocultar valores para compartilhar';

  @override
  String get wrapped_showToggle => 'Mostrar valores';

  @override
  String get wrapped_replay => 'Rever história';

  @override
  String get insights_other => 'Outros';

  @override
  String get insights_noDataYet => 'Ainda não há dados';

  @override
  String get insights_addSomeTransactions =>
      'Adicione algumas transações para ver insights';

  @override
  String get insights_thisMonthVsLastMonth => 'Este mês vs mês passado';

  @override
  String get insights_dailyAverage => 'Média Diária';

  @override
  String insights_perDayBasedOn(Object days) {
    return 'por dia · com base em $days dias deste mês';
  }

  @override
  String get insights_incomeVsExpenses => 'Receitas vs Despesas';

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
    return '$percent% economizados este mês';
  }

  @override
  String get insights_topSpendingCategories =>
      'Principais categorias de gastos';

  @override
  String insights_percentOfTotal(Object percent) {
    return '$percent% do total';
  }

  @override
  String get insights_biggestExpenseThisMonth => 'Maior despesa deste mês';

  @override
  String get insights_categoryTrends =>
      'Tendências da categoria (vs mês passado)';

  @override
  String get insights_12MonthTrend => 'Tendência de 12 meses';

  @override
  String get insights_incomeLabel => 'Renda';

  @override
  String get insights_expensesLabel => 'Despesas';

  @override
  String get categories_expenseLabel => 'Despesa';

  @override
  String get categories_incomeLabel => 'Renda';

  @override
  String get categories_editCategory => 'Editar categoria';

  @override
  String get categories_addCategory => 'Adicionar categoria';

  @override
  String get categories_categoryName => 'Nome da categoria';

  @override
  String get categories_saveChanges => 'Salvar alterações';

  @override
  String get statistics_other => 'Outros';

  @override
  String get statistics_allAccounts => 'Todas as contas';

  @override
  String get statistics_income => 'Renda';

  @override
  String get statistics_expenses => 'Despesas';

  @override
  String get statistics_expense => 'Despesa';

  @override
  String get statistics_net => 'Líquido';

  @override
  String statistics_6MonthOverviewAccount(Object accountName) {
    return 'Visão geral de 6 meses · $accountName';
  }

  @override
  String get statistics_6MonthOverview => 'Visão geral de 6 meses';

  @override
  String statistics_percentOfBudget(Object percent) {
    return '$percent% do orçamento';
  }

  @override
  String get add_transaction_editTransaction => 'Editar transação';

  @override
  String get add_transaction_addTransaction => 'Insira a transação';

  @override
  String get add_transaction_amount => 'Montante';

  @override
  String add_transaction_conversionPreview(Object accountName, Object amount) {
    return '≈ $amount será deduzido de $accountName';
  }

  @override
  String get add_transaction_accountFallback => 'conta';

  @override
  String get add_transaction_descriptionOptional => 'Descrição (opcional)';

  @override
  String get add_transaction_noteOptional => 'Nota (opcional)';

  @override
  String get add_transaction_saveChanges => 'Salvar alterações';

  @override
  String get more_statistics => 'Estatísticas';

  @override
  String get more_statisticsSub => 'Gráficos e resumo mensal';

  @override
  String get more_insights => 'Informações';

  @override
  String get more_insightsSub => 'Tendências, médias e análise de categorias';

  @override
  String get more_currencyConverter => 'Conversor de moeda';

  @override
  String get more_currencyConverterSub =>
      'Converta entre moedas instantaneamente';

  @override
  String get more_wishlist => 'Lista de desejos';

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
  String get more_lentMoney => 'Dinheiro Emprestado';

  @override
  String more_lentMoneySub(Object count) {
    return '$count outstanding';
  }

  @override
  String get more_assets => 'Ativos';

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
  String get more_categories => 'Categorias';

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
  String get more_exportTransactions => 'Transações de exportação';

  @override
  String get more_exportTransactionsSub => 'Salvar como Excel (.xlsx)';

  @override
  String get more_backupRestore => 'Backup e restauração';

  @override
  String get more_backupRestoreSub => 'Salve ou carregue seus dados';

  @override
  String get more_settings => 'Configurações';

  @override
  String get more_settingsSub => 'Tema, moeda e preferências';

  @override
  String get more_sectionTools => 'Ferramentas financeiras';

  @override
  String get more_sectionAnalytics => 'Análises e Insights';

  @override
  String get more_sectionPreferences => 'Preferências e Dados';

  @override
  String home_greeting(Object name) {
    return 'Hi, $name 👋';
  }

  @override
  String get home_there => 'aí';

  @override
  String get home_income => 'Renda';

  @override
  String get home_expenses => 'Despesas';

  @override
  String get home_net => 'Líquido';

  @override
  String get wishlist_noItems => 'Nenhum item da lista de desejos';

  @override
  String get wishlist_noItemsSub =>
      'Toque em + para adicionar itens para os quais você está salvando';

  @override
  String get wishlist_editItem => 'Editar item';

  @override
  String get wishlist_addWishlistItem => 'Adicionar item à lista de desejos';

  @override
  String get wishlist_itemName => 'Nome do item';

  @override
  String get wishlist_targetPrice => 'Preço Alvo';

  @override
  String get wishlist_priorityLow => 'Baixo';

  @override
  String get wishlist_priorityMedium => 'Médio';

  @override
  String get wishlist_priorityHigh => 'Alto';

  @override
  String get wishlist_notesOptional => 'Notas (opcional)';

  @override
  String get wishlist_saveChanges => 'Salvar alterações';

  @override
  String get wishlist_addItem => 'Adicionar item';

  @override
  String get wishlist_fundThisItem => 'Financiar item';

  @override
  String wishlist_funded(int percent, String saved, String target) {
    return '$percent% financiado ($saved / $target)';
  }

  @override
  String get wishlist_goalAchieved => 'Meta alcançada — pronto para comprar!';

  @override
  String get wishlist_buyNow => 'Comprar agora';

  @override
  String get wishlist_purchaseTitle => 'Comprar item da lista';

  @override
  String get wishlist_purchasePrompt =>
      'Deseja registrar uma despesa e deduzir o valor de uma conta?';

  @override
  String get wishlist_recordAndDeduct => 'Registrar e deduzir';

  @override
  String get wishlist_markPurchasedOnly => 'Apenas marcar como comprado';

  @override
  String wishlist_itemPurchased(String name) {
    return '\"$name\" marcado como comprado!';
  }

  @override
  String get wishlist_viewGoal => 'Ver meta de economia';

  @override
  String savings_linkedWishlist(String item) {
    return 'Vinculado à lista de desejos: $item';
  }

  @override
  String get lended_theyOweMe => 'Eles me devem';

  @override
  String get lended_iOweThem => 'Eu devo a eles';

  @override
  String get lended_net => 'Líquido';

  @override
  String get lended_noOneYet => 'Ninguém ainda';

  @override
  String get lended_noOneYetSub =>
      'Toque em + para adicionar uma pessoa a quem você empresta ou pede emprestado';

  @override
  String get lended_owesYou => 'Devo a você';

  @override
  String get lended_youOwe => 'Você deve';

  @override
  String get lended_settledUp => 'Resolvido';

  @override
  String get lended_noActiveRecords => 'Nenhum registro ativo';

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
  String get lended_editPerson => 'Editar Pessoa';

  @override
  String get lended_addPerson => 'Adicionar Pessoa';

  @override
  String get lended_name => 'Nome';

  @override
  String get lended_notesOptional => 'Notas (opcional)';

  @override
  String get lended_saveChanges => 'Salvar alterações';

  @override
  String get assets_totalAssets => 'Ativo total';

  @override
  String get assets_items => 'Itens';

  @override
  String get assets_noAssetsYet => 'Ainda não há ativos';

  @override
  String get assets_noAssetsYetSub =>
      'Toque em + para adicionar um produto ou ativo';

  @override
  String get assets_editAsset => 'Editar recurso';

  @override
  String get assets_addAsset => 'Adicionar ativo';

  @override
  String get assets_productAssetName => 'Nome do produto/ativo';

  @override
  String get assets_value => 'Valor';

  @override
  String get assets_notesOptional => 'Notas (opcional)';

  @override
  String get assets_saveChanges => 'Salvar alterações';

  @override
  String get currency_converter_loadingRates => 'Carregando taxas de câmbio…';

  @override
  String get currency_converter_ratesUnavailable =>
      'Taxas de câmbio indisponíveis. Conecte-se à Internet e sincronize.';

  @override
  String get currency_converter_rateAgeJustNow => 'Agora mesmo';

  @override
  String currency_converter_rateAgeMins(Object minutes) {
    return '${minutes}m ago';
  }

  @override
  String currency_converter_rateAgeHours(Object hours) {
    return '${hours}h atrás';
  }

  @override
  String currency_converter_rateAgeDays(Object days) {
    return '${days}d ago';
  }

  @override
  String currency_converter_commonConversions(Object fromCurrency) {
    return 'Conversões comuns de $fromCurrency';
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
      'Taxas de câmbio não carregadas — o montante será transferido no estado em que se encontra';

  @override
  String get transfer_amount => 'Montante';

  @override
  String get transfer_noteOptional => 'Nota (opcional)';

  @override
  String get export_from => 'De';

  @override
  String get export_to => 'Para';

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
  String get export_complete => 'Exportação concluída';

  @override
  String get export_exporting => 'Exportando...';

  @override
  String get export_exportAsExcel => 'Exportar como Excel';

  @override
  String shared_widgets_deleteConfirm(Object name) {
    return 'Delete \"$name\"? This cannot be undone.';
  }

  @override
  String get shared_widgets_searchByCode => 'Pesquise por código ou nome...';

  @override
  String get accounts_accounts => 'Contas';

  @override
  String get accounts_totalBalance => 'Saldo Total';

  @override
  String get accounts_excluded => 'Excluído';

  @override
  String get accounts_goldPriceNotYetLoade =>
      'Preço do ouro ainda não carregado. Aguarde e tente novamente.';

  @override
  String get accounts_accountType => 'Tipo de Conta';

  @override
  String get accounts_currency => 'Moeda';

  @override
  String get accounts_goldPurityKarat => 'Pureza do Ouro (Quilates)';

  @override
  String get accounts_weight => 'Peso';

  @override
  String get accounts_excludeFromTotalBala => 'Excluir do Saldo Total';

  @override
  String get accounts_dontLinkToCard => 'Não vincular ao cartão';

  @override
  String get accounts_dontLinkToCardDesc =>
      'Gerenciar o saldo manualmente e impedir que cartões sejam vinculados';

  @override
  String get accounts_color => 'Cor';

  @override
  String get accounts_liveGoldValue => 'Valor do Ouro em Tempo Real';

  @override
  String get accounts_enterWeightAboveToSe =>
      'Insira o peso acima para ver o valor';

  @override
  String get add_transaction_expense => 'Despesa';

  @override
  String get add_transaction_income => 'Receita';

  @override
  String get add_transaction_account => 'Conta';

  @override
  String get add_transaction_category => 'Categoria';

  @override
  String get assets_assets => 'Ativos';

  @override
  String get backup_restoreBackup => 'Restaurar Backup?';

  @override
  String get backup_cancel => 'Cancelar';

  @override
  String get backup_replaceData => 'Substituir Dados';

  @override
  String get backup_backupRestore => 'Backup e Restauração';

  @override
  String get backup_everythingAlways => 'Tudo, sempre';

  @override
  String get backup_createBackup => 'Criar Backup';

  @override
  String get backup_saveAsJson => 'Salvar como JSON';

  @override
  String get backup_exportsAllAppDataToA =>
      'Exporta TODOS os dados do app para um arquivo';

  @override
  String get backup_restoreBackup_ => 'Restaurar Backup';

  @override
  String get backup_loadFromJson => 'Carregar do JSON';

  @override
  String get backup_picksABackupFileAndR =>
      'Escolhe um arquivo de backup e o restaura';

  @override
  String get backup_thisOverwritesAllCur =>
      'Isso sobrescreve TODOS os dados atuais.';

  @override
  String get budget_budgets => 'Orçamentos';

  @override
  String get budget_empty => '·';

  @override
  String get budget_overBudget => 'Acima do orçamento';

  @override
  String get budget_thisCategoryAlreadyH =>
      'Esta categoria já tem um orçamento. Toque para editar.';

  @override
  String get budget_period => 'Período';

  @override
  String get budget_monthly => 'Mensal';

  @override
  String get budget_weekly => 'Semanal';

  @override
  String get budget_category => 'Categoria';

  @override
  String get categories_categories => 'Categorias';

  @override
  String get categories_expense => 'Despesa';

  @override
  String get categories_income => 'Receita';

  @override
  String get categories_color => 'Cor';

  @override
  String get categories_icon => 'Ícone';

  @override
  String get categories_autoBasedOnName => 'Auto (baseado no nome)';

  @override
  String get categories_expenseCategories => 'Categorias de Despesas';

  @override
  String get categories_incomeCategories => 'Categorias de Receitas';

  @override
  String get currency_converter_currencyConverter => 'Conversor de Moedas';

  @override
  String get currency_converter_amount => 'Valor';

  @override
  String get currency_converter_convertedTo => 'Convertido para';

  @override
  String get export_exportTransactions => 'Exportar Transações';

  @override
  String get export_dateRange => 'Período';

  @override
  String get export_formatExcelXlsx => 'Formato: Excel (.xlsx)';

  @override
  String get export_exportAsPdf => 'Exportar como relatório PDF';

  @override
  String get export_formatPdf => 'Formato: Relatório financeiro em PDF (.pdf)';

  @override
  String get export_pdfGenerating => 'Gerando PDF...';

  @override
  String get export_pdfTitle => 'Relatório Financeiro';

  @override
  String get export_pdfSummary => 'Resumo executivo';

  @override
  String get export_pdfInflow => 'Entradas totais';

  @override
  String get export_pdfOutflow => 'Saídas totais';

  @override
  String get export_pdfNet => 'Economia líquida';

  @override
  String get export_pdfSavingsRate => 'Taxa de economia';

  @override
  String get export_pdfCategoryBreakdown => 'Detalhamento por categorias';

  @override
  String get export_pdfTransactions => 'Transações detalhadas';

  @override
  String get export_pdfNetWorthBreakdown => 'Ativos e Passivos';

  @override
  String get export_pdfShare => 'Compartilhar relatório';

  @override
  String get export_pdfPrint => 'Imprimir / Visualizar';

  @override
  String get export_pdfGeneratedBy => 'Gerado por Expensy • Privado & Offline';

  @override
  String get home_totalBalance => 'Saldo Total';

  @override
  String get home_accounts => 'Contas';

  @override
  String get home_recentTransactions => 'Transações Recentes';

  @override
  String get home_noTransactionsYet => 'Nenhuma transação ainda';

  @override
  String get home_add => 'Adicionar';

  @override
  String get home_goodMorning => 'Bom dia';

  @override
  String get home_goodAfternoon => 'Boa tarde';

  @override
  String get home_goodEvening => 'Boa noite';

  @override
  String get home_transferAction => 'Transferir';

  @override
  String get home_insightsAction => 'Insights';

  @override
  String get home_calendarAction => 'Calendário';

  @override
  String get home_forecastAction => 'Previsão';

  @override
  String get home_manage => 'Gerenciar';

  @override
  String get home_seeAll => 'Ver todos';

  @override
  String get home_addAccount => 'Adicionar conta';

  @override
  String get home_monthlyOverview => 'Visão geral mensal';

  @override
  String get home_savingsRate => 'Taxa de poupança';

  @override
  String get insights_insights => 'Informações';

  @override
  String get lended_person_deletePerson => 'Excluir pessoa';

  @override
  String get lended_person_editPerson => 'Editar Pessoa';

  @override
  String get lended_person_color => 'Cor';

  @override
  String get lended_person_saveChanges => 'Salvar Alterações';

  @override
  String get lended_person_settled => 'QUITADO';

  @override
  String get lended_person_settle => 'Quitar';

  @override
  String get lended_person_setADueDateFirstToEn =>
      'Defina uma data de vencimento primeiro para ativar lembretes.';

  @override
  String get lended_person_iLent => 'Eu Emprestei';

  @override
  String get lended_person_iBorrowed => 'Eu Peguei Emprestado';

  @override
  String get lended_person_accountOptional => 'Conta (opcional)';

  @override
  String get lended_person_dueDateReminder => 'Lembrete de Vencimento';

  @override
  String get lended_person_remindMeAt => 'Lembrar-me às';

  @override
  String get lended_person_active => 'Ativo';

  @override
  String get lended_person_settled_ => 'Quitado';

  @override
  String get lended_lentMoney => 'Dinheiro Emprestado';

  @override
  String get lended_overdue => 'ATRASADO';

  @override
  String get lended_color => 'Cor';

  @override
  String get more_more => 'Mais';

  @override
  String get onboarding_back => 'Voltar';

  @override
  String get onboarding_welcomeToExpensy => 'Bem-vindo ao Expensy!';

  @override
  String get onboarding_restoreABackup => 'Restaurar um Backup';

  @override
  String get onboarding_loadAPreviouslySaved =>
      'Carregar um arquivo JSON do Expensy salvo anteriormente';

  @override
  String get onboarding_or => 'ou';

  @override
  String get onboarding_startFresh => 'Começar do Zero';

  @override
  String get onboarding_firstWhatShouldWeCal =>
      'Primeiro, como devemos chamá-lo?';

  @override
  String get onboarding_defaultCurrency => 'Moeda Padrão';

  @override
  String get onboarding_thisWillBeUsedAcross =>
      'Isso será usado em todo o app.\nVocê pode mudar isso depois nas Configurações.';

  @override
  String get onboarding_searchAllCurrencies => 'Pesquisar todas as moedas';

  @override
  String get onboarding_yourFirstAccount => 'Sua Primeira Conta';

  @override
  String get onboarding_setUpYourMainAccount =>
      'Configure sua conta principal para começar a rastrear.';

  @override
  String get onboarding_accountType => 'Tipo de Conta';

  @override
  String get onboarding_currency => 'Moeda';

  @override
  String get onboarding_color => 'Cor';

  @override
  String get recurring_recurring => 'Recorrente';

  @override
  String get recurring_income => 'RECEITA';

  @override
  String get recurring_2D => '−2d';

  @override
  String get recurring_skipNextPayment => 'Pular Próximo Pagamento?';

  @override
  String get recurring_cancel => 'Cancelar';

  @override
  String get recurring_skip => 'Pular';

  @override
  String get recurring_noHistoryYet => 'Nenhum histórico ainda';

  @override
  String get recurring_expense => 'Despesa';

  @override
  String get recurring_income_ => 'Receita';

  @override
  String get recurring_every => 'A cada ';

  @override
  String get recurring_days => 'Dias';

  @override
  String get recurring_weeks => 'Semanas';

  @override
  String get recurring_months => 'Meses';

  @override
  String get recurring_years => 'Anos';

  @override
  String get recurring_payments => 'Pagamentos';

  @override
  String get recurring_totalCost => 'Custo Total';

  @override
  String get recurring_account => 'Conta';

  @override
  String get recurring_category => 'Categoria';

  @override
  String get recurring_paymentReminder => 'Lembrete de Pagamento';

  @override
  String get recurring_notificationWillFire =>
      'A notificação disparará na próxima data de vencimento neste horário.';

  @override
  String get recurring_remind2DaysBefore => 'Lembrar 2 dias antes';

  @override
  String get statistics_statistics => 'Estatísticas';

  @override
  String get statistics_expensesByCategory => 'Despesas por Categoria';

  @override
  String get transactions_transactions => 'Transações';

  @override
  String get transactions_settled => 'Quitado';

  @override
  String get transfer_transfer => 'Transferência';

  @override
  String get transfer_from => 'DE';

  @override
  String get transfer_to => 'PARA';

  @override
  String get transfer_enterAnAmountToSeeTh =>
      'Insira um valor para ver a conversão';

  @override
  String get wishlist_wishlist => 'Lista de Desejos';

  @override
  String get wishlist_priority => 'Prioridade';

  @override
  String get shared_widgets_delete => 'Excluir?';

  @override
  String get shared_widgets_cancel => 'Cancelar';

  @override
  String get shared_widgets_delete_ => 'Excluir';

  @override
  String get shared_widgets_none => 'Nenhum';

  @override
  String get shared_widgets_selectCurrency => 'Selecionar Moeda';

  @override
  String get main_home => 'Início';

  @override
  String get main_transactions => 'Transações';

  @override
  String get main_recurring => 'Recorrente';

  @override
  String get main_accounts => 'Contas';

  @override
  String get main_budgets => 'Orçamentos';

  @override
  String get main_more => 'Mais';

  @override
  String get onboarding_chooseLanguage => 'Escolha o idioma';

  @override
  String get error_required => 'Este campo é obrigatório';

  @override
  String recurring_subscriptions(Object count) {
    return 'Assinaturas ($count)';
  }

  @override
  String recurring_installments(Object count) {
    return 'Parcelas ($count)';
  }

  @override
  String get recurring_recurringType => 'Tipo recorrente';

  @override
  String get recurring_subscription => 'Assinatura';

  @override
  String get recurring_installment => 'Parcelamento';

  @override
  String get recurring_installmentsRequireEndDate =>
      'As parcelas devem ter uma data final de pagamento.';

  @override
  String get backup_importFromOtherApps => 'Importar de outros aplicativos';

  @override
  String get backup_importDescription =>
      'Importar dados de aplicativos suportados';

  @override
  String get backup_importFromGreenStash => 'Importar do GreenStash (.json)';

  @override
  String get backup_automaticBackup => 'Backup Automático';

  @override
  String get backup_dailyAutoBackup => 'Backup automático diário';

  @override
  String backup_runsDailyAt(String time) {
    return 'Funciona diariamente às $time';
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
  String get backup_changeTime => 'Alterar horário';

  @override
  String get backup_changeFolder => 'Alterar pasta';

  @override
  String get budget_budgetsAndGoals => 'Orçamentos e Metas';

  @override
  String get onboarding_restoreGreenStash => 'Restaurar do GreenStash (.json)';

  @override
  String get savings_goalNotFound => 'Meta não encontrada';

  @override
  String get savings_savedSoFar => 'Salvo até agora';

  @override
  String get savings_target => 'Alvo';

  @override
  String savings_targetDate(String date) {
    return 'Target Date: $date';
  }

  @override
  String get savings_contribute => 'Contribua';

  @override
  String get savings_withdraw => 'Retirar';

  @override
  String get savings_noAccounts =>
      'Nenhuma conta disponível. Adicione uma conta primeiro.';

  @override
  String get settings_budgetAlerts => 'Alertas de orçamento';

  @override
  String get settings_budgetAlertsSub =>
      'Notificar quando um orçamento ou meta for atingido';

  @override
  String get settings_dailyReminder => 'Lembrete Diário';

  @override
  String get settings_dailyReminderSub =>
      'Lembre de registrar transações diariamente';

  @override
  String get settings_reminderTime => 'Hora do lembrete';

  @override
  String get settings_hapticFeedback => 'Feedback tátil';

  @override
  String get settings_hapticFeedbackSub => 'Vibrar nas interações';

  @override
  String get savings_saveGoal => 'Salvar meta';

  @override
  String get more_loans => 'Empréstimos';

  @override
  String more_loansSub(num count) {
    return 'Empréstimos ativos';
  }

  @override
  String get loans_title => 'Empréstimos';

  @override
  String get loans_addLoan => 'Adicionar empréstimo';

  @override
  String get loans_editLoan => 'Editar empréstimo';

  @override
  String get loans_loanName => 'Nome do empréstimo';

  @override
  String get loans_amount => 'Valor';

  @override
  String get loans_startDate => 'Data de início';

  @override
  String get loans_endDate => 'Data de término';

  @override
  String get loans_interestRateOptional => 'Taxa de juros (Opcional)';

  @override
  String get loans_account => 'Conta vinculada';

  @override
  String get loans_monthlyPayment => 'Pagamento mensal';

  @override
  String get loans_totalPayable => 'Total a pagar';

  @override
  String get loans_remaining => 'Restante';

  @override
  String get loans_paid => 'Pago';

  @override
  String get loans_logPayment => 'Registrar pagamento';

  @override
  String get loans_paymentReminder => 'Lembrete de pagamento';

  @override
  String get loans_reminderDay => 'Dia do lembrete';

  @override
  String get loans_notes => 'Notas';

  @override
  String get loans_saveLoan => 'Salvar empréstimo';

  @override
  String get loans_deleteLoan => 'Excluir empréstimo';

  @override
  String get loans_settled => 'Quitado';

  @override
  String loans_durationMonths(num count) {
    return 'Meses';
  }

  @override
  String get loans_paymentHistory => 'Histórico de pagamentos';

  @override
  String get loans_noPayments => 'Nenhum pagamento registrado ainda';

  @override
  String get loans_outstandingDebt => 'Dívida pendente';

  @override
  String get loans_monthlyObligation => 'Obrigação mensal';

  @override
  String get insights_loans => 'Empréstimos';

  @override
  String get backup_loans => 'Empréstimos';

  @override
  String get backup_loanPayments => 'Pagamentos de empréstimos';

  @override
  String get more_yearlyAnalysis => 'Análise anual';

  @override
  String get more_yearlyAnalysisSub => 'Previsão de fluxo de caixa mês a mês';

  @override
  String get yearly_title => 'Análise anual';

  @override
  String get yearly_recurringExp => 'Despesas recorrentes';

  @override
  String get yearly_recurringInc => 'Receitas recorrentes';

  @override
  String get yearly_loans => 'Pagamentos de empréstimos';

  @override
  String get yearly_borrowed => 'Dívidas a pagar';

  @override
  String get yearly_lentDue => 'Valores a receber';

  @override
  String get yearly_inflow => 'Entradas';

  @override
  String get yearly_outflow => 'Saídas';

  @override
  String get yearly_netFlow => 'Fluxo líquido';

  @override
  String get yearly_totalInflow => 'Entrada total';

  @override
  String get yearly_totalOutflow => 'Saída total';

  @override
  String get yearly_netCashFlow => 'Fluxo de caixa líquido';

  @override
  String get yearly_noData => 'Sem atividade projetada';

  @override
  String get yearly_noDataSub =>
      'Adicione pagamentos recorrentes ou empréstimos para ver a previsão';

  @override
  String get budget_addBudget => 'Adicionar orçamento';

  @override
  String get budget_addGoal => 'Adicionar meta de economia';

  @override
  String get add_transaction_possibleDuplicate => 'Possível duplicata';

  @override
  String get add_transaction_goBack => 'Voltar';

  @override
  String get add_transaction_saveAnyway => 'Salvar mesmo assim';

  @override
  String get loans_confirmDeleteLoan =>
      'Tem certeza de que deseja excluir este empréstimo e todos os seus pagamentos?';

  @override
  String get loans_deletePayment => 'Excluir pagamento';

  @override
  String get loans_confirmDeletePayment =>
      'Tem certeza de que deseja excluir este registro de pagamento?';

  @override
  String get split_transactions_title => 'Dividir categorias';

  @override
  String get split_transactions_badge => 'Dividido';

  @override
  String get split_transactions_addSplit => 'Adicionar divisão';

  @override
  String get split_transactions_removeSplit => 'Remover divisão';

  @override
  String get split_transactions_allocated => 'Alocado';

  @override
  String get split_transactions_remaining => 'Restante';

  @override
  String get split_transactions_fillRemaining => 'Preencher restante';

  @override
  String get split_transactions_breakdown => 'Detalhamento da divisão';

  @override
  String get split_transactions_mismatchError =>
      'Os valores divididos devem corresponder exatamente ao valor total.';

  @override
  String get netWorth_title => 'Patrimônio líquido';

  @override
  String get netWorth_subtitle =>
      'Acompanhe ativos, passivos e patrimônio ao longo do tempo';

  @override
  String get netWorth_current => 'Patrimônio líquido atual';

  @override
  String get netWorth_trend => 'Tendência do patrimônio líquido';

  @override
  String get netWorth_totalAssets => 'Total de ativos';

  @override
  String get netWorth_totalLiabilities => 'Total de passivos';

  @override
  String get netWorth_liquidCash => 'Dinheiro e contas bancárias';

  @override
  String get netWorth_goldValuation => 'Ouro físico';

  @override
  String get netWorth_fixedAssets => 'Bens e investimentos';

  @override
  String get netWorth_moneyLent => 'Dinheiro emprestado (A receber)';

  @override
  String get netWorth_creditDebt => 'Cartões de crédito e cheque especial';

  @override
  String get netWorth_loanDebt => 'Empréstimos a pagar';

  @override
  String get netWorth_moneyBorrowed => 'Dinheiro tomado emprestado (A pagar)';

  @override
  String get netWorth_assetBreakdown => 'Detalhamento de ativos';

  @override
  String get netWorth_liabilityBreakdown => 'Detalhamento de passivos';

  @override
  String get netWorth_noHistory =>
      'O histórico do patrimônio líquido será gerado automaticamente com os registros diários.';

  @override
  String get netWorth_debtRatio => 'Taxa de endividamento';

  @override
  String get netWorth_quickActions => 'Ações rápidas';

  @override
  String get netWorth_history => 'Histórico de registros';

  @override
  String get creditCard_utilization => 'Uso do crédito';

  @override
  String get creditCard_availableCredit => 'Disponível';

  @override
  String get creditCard_limit => 'Limite';

  @override
  String get creditCard_statementBalance => 'Saldo da fatura';

  @override
  String get creditCard_unbilledBalance => 'Lançamentos futuros';

  @override
  String get creditCard_payBill => 'Pagar fatura';

  @override
  String get creditCard_allCaughtUp => 'Tudo em dia! Sem fatura pendente';

  @override
  String get creditCard_payBillTitle => 'Pagar fatura do cartão';

  @override
  String get creditCard_payFromAccount => 'Pagar com a conta';

  @override
  String get creditCard_paymentAmount => 'Valor do pagamento';

  @override
  String get creditCard_fullStatement => 'Saldo da fatura';

  @override
  String get creditCard_fullBalance => 'Saldo total';

  @override
  String get creditCard_minPayment => 'Pagamento mínimo';

  @override
  String get creditCard_customAmount => 'Outro valor';

  @override
  String creditCard_paymentSuccess(String amount, String cardName) {
    return 'Pago $amount para $cardName';
  }

  @override
  String get creditCard_insufficientFunds =>
      'O valor ultrapassa o saldo disponível';

  @override
  String get creditCard_invalidAmount => 'Informe um valor de pagamento válido';

  @override
  String get onboarding_skipForNow => 'Pular por enquanto';

  @override
  String get onboarding_addCard => 'Adicionar um cartão';

  @override
  String get onboarding_skipCardDesc =>
      'Você pode pular esta etapa se não quiser adicionar um cartão agora.';

  @override
  String get onboarding_cardNameLabel => 'Nome do cartão (ex.: Visa Platinum)';

  @override
  String get onboarding_debitCard => 'Cartão de débito';

  @override
  String get onboarding_creditLimit => 'Limite de crédito';

  @override
  String get onboarding_amountUsed => 'Valor utilizado';

  @override
  String get accounts_cardHolderOptional => 'Nome do titular (Opcional)';

  @override
  String get accounts_last4Digits => 'Últimos 4 dígitos';

  @override
  String get accounts_expiryDate => 'Data de validade (MM/AA)';

  @override
  String get accounts_creditLimitOptional => 'Limite de crédito (Opcional)';

  @override
  String get accounts_minPaymentOptional => 'Pagamento mínimo (Opcional)';

  @override
  String get accounts_statementDayOptional => 'Dia do fechamento (Opcional)';

  @override
  String get accounts_statementDayExample => 'ex.: 20';

  @override
  String get accounts_dueDayOptional => 'Dia do vencimento (Opcional)';

  @override
  String get accounts_dueDayExample => 'ex.: 10';

  @override
  String get accounts_linkedAccountOptional =>
      'Conta bancária vinculada (Opcional)';

  @override
  String get accounts_excludeCardBalance =>
      'Excluir saldo do cartão do saldo da conta';

  @override
  String get accounts_excludeCardBalanceDesc =>
      'O saldo deste cartão não será adicionado à conta bancária vinculada.';

  @override
  String get accounts_cardHolderHeader => 'TITULAR';

  @override
  String get accounts_expHeader => 'VALIDADE';

  @override
  String get accounts_notifyOnDueDate =>
      'Você será notificado na data de vencimento';

  @override
  String get accounts_notifyWhenDue =>
      'Receber notificação no vencimento do pagamento';

  @override
  String get accounts_remind2DaysBeforeDesc =>
      'Receber aviso com 2 dias de antecedência do vencimento';

  @override
  String get accounts_targetSaved => 'Meta / Economizado';

  @override
  String transactions_selectedCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count selecionados',
      one: '1 selecionado',
    );
    return '$_temp0';
  }

  @override
  String get transactions_changeCategory => 'Alterar categoria';

  @override
  String get transactions_deleteSelected => 'Excluir selecionados';

  @override
  String get transactions_advancedFilters => 'Filtros avançados';

  @override
  String get transactions_clearAll => 'Limpar tudo';

  @override
  String get transactions_amountRange => 'Faixa de valor';

  @override
  String get transactions_minAmount => 'Valor mínimo';

  @override
  String get transactions_maxAmount => 'Valor máximo';

  @override
  String get transactions_applyFilters => 'Aplicar filtros';

  @override
  String get presets_new => 'Novo';

  @override
  String get presets_presetName => 'Nome do modelo (ex.: Café da manhã)';

  @override
  String get presets_defaultAmount => 'Valor padrão';

  @override
  String get savings_goalName => 'Nome da meta';

  @override
  String get savings_goalNameHint => 'ex.: Carro novo, Férias';

  @override
  String get savings_targetAmount => 'Valor da meta';

  @override
  String get savings_targetDateOptional => 'Data da meta (Opcional)';

  @override
  String get savings_selectDate => 'Selecionar data';

  @override
  String get savings_amountRequired => 'O valor é obrigatório';

  @override
  String get savings_noteOptional => 'Nota (Opcional)';

  @override
  String get loans_skipInstallment => 'Pular a próxima parcela do empréstimo?';

  @override
  String get recurring_confirmDelete =>
      'Tem certeza de que deseja excluir este pagamento recorrente?';

  @override
  String get export_formatExcelOption => 'Excel (.xlsx)';

  @override
  String get export_formatPdfOption => 'Relatório em PDF';

  @override
  String get export_pdfNoTransactions =>
      'Nenhuma transação registrada neste período.';

  @override
  String get savings_saved => 'Economizado';

  @override
  String get export_pdfDate => 'Data';

  @override
  String get export_pdfDescription => 'Descrição';

  @override
  String get accounts_noCardsYet => 'Nenhum cartão';

  @override
  String get accounts_tapToAddCard =>
      'Toque em + para adicionar seu primeiro cartão';

  @override
  String get savings_noGoalsYet => 'Nenhuma meta de economia';

  @override
  String get savings_tapToAddGoal => 'Toque em + para definir uma nova meta';

  @override
  String get netWorth_recordSnapshot => 'Gravar instantâneo';

  @override
  String get netWorth_snapshotRecorded => 'Instantâneo gravado';

  @override
  String get savings_noContributionsYet => 'Nenhuma contribuição ainda';

  @override
  String get creditCard_closesStatementBillingCycle =>
      'Encerra o ciclo de faturamento da fatura atual';

  @override
  String get creditCard_clearsTotalDebt =>
      'Quita a dívida total do cartão integralmente';

  @override
  String get creditCard_requiredMinPayment => 'Pagamento mínimo obrigatório';

  @override
  String get creditCard_specifyCustomAmount =>
      'Especificar valor de pagamento personalizado';

  @override
  String common_itemDeleted(String name) {
    return '\"$name\" excluído';
  }

  @override
  String get common_accountDeleted => 'Conta excluída';

  @override
  String get common_cardDeleted => 'Cartão excluído';

  @override
  String get common_transactionDeleted => 'Transação excluída';

  @override
  String get common_recordDeleted => 'Registro excluído';

  @override
  String get common_paymentDeleted => 'Pagamento excluído';

  @override
  String get loans_skippedInstallment => 'Parcela do empréstimo ignorada';

  @override
  String loans_loggedPayment(String amount) {
    return 'Pagamento de $amount registrado';
  }

  @override
  String get loans_notificationsPermissionRequired =>
      'Permissão de notificações necessária';

  @override
  String get creditCard_selectFundingAccount => 'Selecione uma conta de origem';

  @override
  String get presets_presetUpdated => 'Modelo atualizado';

  @override
  String get presets_presetAdded => 'Modelo adicionado';

  @override
  String get presets_presetDeleted => 'Modelo excluído';

  @override
  String transactions_deletedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count itens excluídos',
      one: '1 item excluído',
    );
    return '$_temp0';
  }

  @override
  String get split_atLeastTwoCategories =>
      'Pelo menos 2 categorias são necessárias para dividir.';

  @override
  String get split_categoryAndAmountRequired =>
      'Cada item dividido deve ter uma categoria e valor > 0.';

  @override
  String get presets_addQuickPresets => 'Adicionar modelos rápidos com 1 toque';

  @override
  String get presets_quickPresetsDesc =>
      'Registre café, transporte ou refeições frequentes com um toque';

  @override
  String presets_loggedPreset(String title, String amount) {
    return 'Registrado $title ($amount)';
  }

  @override
  String get presets_createPreset => 'Criar modelo';

  @override
  String get presets_editQuickPreset => 'Editar modelo rápido';

  @override
  String get presets_newQuickPreset => 'Novo modelo rápido';

  @override
  String get savings_addContribution => 'Adicionar contribuição';

  @override
  String get savings_withdrawFromGoal => 'Retirar da meta';

  @override
  String get savings_contribution => 'Contribuição';

  @override
  String get savings_withdrawal => 'Retirada';

  @override
  String get savings_unknownAccount => 'Conta desconhecida';

  @override
  String get savings_fromAccount => 'Da conta';

  @override
  String get savings_toAccount => 'Para a conta';

  @override
  String get presets_quickLog => 'Registro rápido';

  @override
  String accounts_dueOnDay(int day) {
    return 'Vence no dia $day';
  }
}
