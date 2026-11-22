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
    return 'Despesas ($count)';
  }

  @override
  String recurring_incomeList(Object count) {
    return 'Receitas ($count)';
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
    return 'A partir de $date · Contínuo';
  }

  @override
  String recurring_paidPayments(Object paid, Object total) {
    return '$paid/$total pagos';
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
    return 'Próxima: $date';
  }

  @override
  String get recurring_pay => 'Pagar';

  @override
  String get recurring_del => 'Excl.';

  @override
  String recurring_historyCount(Object count) {
    return 'Histórico ($count)';
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
    return 'Primeira: $date';
  }

  @override
  String recurring_lastDate(Object date) {
    return 'Última: $date';
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
    return '$percentage% puro';
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
    return '$name deve a você';
  }

  @override
  String lended_person_youOwe(Object name) {
    return 'Você deve a $name';
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
    return 'Vence $date';
  }

  @override
  String lended_person_reminderAt(Object time) {
    return 'Lembrete às $time';
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
    return 'Vence: $date';
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
    return 'Emprestado para $name';
  }

  @override
  String transactions_borrowedFrom(Object name) {
    return 'Emprestado de $name';
  }

  @override
  String get transactions_unknown => 'Desconhecido';

  @override
  String transactions_due(Object date) {
    return 'Vence $date';
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
    return 'Falha no backup: $error';
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
    return '$amount excedido';
  }

  @override
  String budget_leftAmount(Object amount) {
    return '$amount restante';
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
    return 'Gasto: $amount';
  }

  @override
  String budget_ofAmount(Object amount) {
    return 'de $amount';
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
  String get wrapped_title => 'Retrospectiva Expensy';

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
    return 'Receitas $amount';
  }

  @override
  String insights_expensesAmount(Object amount) {
    return 'Despesas $amount';
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
      other: '$count itens',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String get more_lentMoney => 'Dinheiro Emprestado';

  @override
  String more_lentMoneySub(Object count) {
    return '$count em aberto';
  }

  @override
  String get more_assets => 'Ativos';

  @override
  String more_assetsSub(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ativos',
      one: '1 ativo',
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
      other: '$count categorias',
      one: '1 categoria',
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
    return 'Olá, $name 👋';
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
      other: '$count registros ativos',
      one: '1 registro ativo',
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
    return 'há $minutes min';
  }

  @override
  String currency_converter_rateAgeHours(Object hours) {
    return '${hours}h atrás';
  }

  @override
  String currency_converter_rateAgeDays(Object days) {
    return 'há $days d';
  }

  @override
  String currency_converter_commonConversions(Object fromCurrency) {
    return 'Conversões comuns de $fromCurrency';
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
      other: '$count transações no período',
      one: '1 transação no período',
    );
    return '$_temp0';
  }

  @override
  String export_saved(Object path) {
    return 'Salvo: $path';
  }

  @override
  String get export_complete => 'Exportação concluída';

  @override
  String get export_exporting => 'Exportando...';

  @override
  String get export_exportAsExcel => 'Exportar como Excel';

  @override
  String shared_widgets_deleteConfirm(Object name) {
    return 'Excluir \"$name\"? Isso não pode ser desfeito.';
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
  String get home_converterAction => 'Conversor';

  @override
  String get home_insightsAction => 'Análises';

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
  String get home_cards => 'Cartões';

  @override
  String get home_addCard => 'Adicionar cartão';

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
  String get recurring_2D => '-2d';

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
    return 'Último backup: $time';
  }

  @override
  String backup_savingTo(String path) {
    return 'Salvando em: $path';
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
    return 'Data alvo: $date';
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

  @override
  String get accounts_cannotDeleteAccount => 'Não é possível excluir a conta';

  @override
  String get common_ok => 'OK';

  @override
  String get certificates_title => 'Depósitos a Prazo & Certificados';

  @override
  String get certificates_addCertificate => 'Adicionar certificado';

  @override
  String get certificates_editCertificate => 'Editar certificado';

  @override
  String get certificates_noCertificates => 'Nenhum certificado ainda';

  @override
  String get certificates_noCertificatesDesc =>
      'Acompanhe seus investimentos em depósitos a prazo e rendimentos periódicos.';

  @override
  String get certificates_active => 'Ativo';

  @override
  String get certificates_matured => 'Vencido';

  @override
  String get certificates_amount => 'Valor principal';

  @override
  String get certificates_collectionType => 'Recebimento de juros';

  @override
  String get certificates_collectedSoFar => 'Recebido até agora';

  @override
  String get certificates_expectedTotal => 'Retorno total esperado';

  @override
  String get certificates_startDate => 'Data de início';

  @override
  String get certificates_endDate => 'Data de vencimento';

  @override
  String get certificates_redeem => 'Resgatar certificado';

  @override
  String certificates_redeemConfirm(String name, String amount) {
    return 'Tem certeza de que deseja resgatar \"$name\"? O principal de $amount será devolvido à sua conta bancária.';
  }

  @override
  String get certificates_redeemedSuccess =>
      'Certificado resgatado e valor principal devolvido com sucesso.';

  @override
  String get certificates_name => 'Nome do certificado';

  @override
  String get certificates_interestRate => 'Taxa de juros anual (%)';

  @override
  String get certificates_linkedBankAccount => 'Conta bancária vinculada';

  @override
  String get certificates_periodicYield => 'Rendimento periódico de juros';

  @override
  String get certificates_paymentReminder => 'Lembrete de pagamento de juros';

  @override
  String get certificates_reminderTime => 'Hora do lembrete';

  @override
  String get certificates_reminder2DaysBefore => 'Lembrete 2 dias antes';

  @override
  String get certificates_deleteCertificate => 'Excluir certificado';

  @override
  String get certificates_confirmDeleteCertificate =>
      'Tem certeza de que deseja excluir este certificado? Todas as transações associadas serão removidas e o dinheiro devolvido à sua conta.';

  @override
  String get certificates_deleted => 'Certificado excluído';

  @override
  String get onboarding_stayOnTopOfFinances =>
      'Mantenha o controle das suas finanças';

  @override
  String get onboarding_stayOnTopOfFinancesDesc =>
      'Ative lembretes para nunca perder um pagamento, fatura atrasada ou limite de orçamento.';

  @override
  String get onboarding_featureBillTitle =>
      'Lembretes de faturas e vencimentos';

  @override
  String get onboarding_featureBillDesc =>
      'Receba alertas antes das datas de fechamento da fatura e parcelas de empréstimos.';

  @override
  String get onboarding_featureBudgetTitle => 'Alertas de orçamento';

  @override
  String get onboarding_featureBudgetDesc =>
      'Receba notificações ao atingir 80% ou 100% do limite de gastos por categoria.';

  @override
  String get onboarding_featureRecurringTitle => 'Assinaturas recorrentes';

  @override
  String get onboarding_featureRecurringDesc =>
      'Fique informado antes que faturas e assinaturas sejam renovadas automaticamente.';

  @override
  String get onboarding_allowNotifications => 'Permitir notificações';

  @override
  String get onboarding_maybeLater => 'Talvez mais tarde';

  @override
  String get categories_subcategories => 'Subcategorias';

  @override
  String get categories_addSubcategory => 'Adicionar subcategoria';

  @override
  String get categories_parentCategory => 'Categoria principal';

  @override
  String get categories_noneRoot => 'Nenhuma (Categoria principal)';

  @override
  String get categories_loadDefaults => 'Carregar subcategorias padrão';

  @override
  String categories_defaultsLoaded(int count) {
    return '$count subcategorias padrão carregadas';
  }

  @override
  String get categories_defaultsAlreadyLoaded =>
      'As subcategorias padrão já foram carregadas';

  @override
  String get statistics_byCategory => 'Por categoria';

  @override
  String get statistics_bySubcategory => 'Por subcategoria';

  @override
  String get backup_importFromTrackWallet => 'Importar do TrackWallet (.csv)';

  @override
  String backup_importedTransactions(int count) {
    return '$count transações importadas com sucesso!';
  }

  @override
  String get onboarding_restoreTrackWallet => 'Importar do TrackWallet (.csv)';

  @override
  String get transfer_categoryLocked =>
      'Transferência (Categoria padrão e única)';

  @override
  String get loans_noLoans => 'Nenhum empréstimo registrado';

  @override
  String get loans_noLoansSub =>
      'Toque em + para registrar financiamentos ou empréstimos';

  @override
  String get certificates_noCertificatesSub =>
      'Toque em + para acompanhar CDBs e depósitos a prazo';

  @override
  String get common_undo => 'Desfazer';

  @override
  String get common_close => 'Fechar';

  @override
  String get common_required => 'Obrigatório';

  @override
  String get common_invalid => 'Inválido';

  @override
  String get common_none => 'Nenhum';

  @override
  String common_enabledAt(String time) {
    return 'Ativo ($time)';
  }

  @override
  String get common_disabled => 'Desativado';

  @override
  String get freq_daily => 'Diário';

  @override
  String get freq_yearly => 'Anual';

  @override
  String recurring_transfers(Object count) {
    return 'Transferências ($count)';
  }

  @override
  String get recurring_transfer => 'Transferência';

  @override
  String get recurring_transferCaps => 'TRANSFERÊNCIA';

  @override
  String get recurring_noRecurringTransfers =>
      'Nenhuma transferência recorrente';

  @override
  String recurring_subtitleCount(int count) {
    return '$count assinaturas e recorrências';
  }

  @override
  String recurring_perWeek(String amount) {
    return '$amount / semana';
  }

  @override
  String get recurring_perMonth => '/ mês';

  @override
  String get recurring_fromAccount => 'Da conta';

  @override
  String get recurring_toAccount => 'Para a conta';

  @override
  String recurring_targetAmount(String currency) {
    return 'Valor de destino ($currency)';
  }

  @override
  String get recurring_autoPayAt => 'Pagamento automático às';

  @override
  String get recurring_autoPayOnDueDate =>
      'Pagar automaticamente no vencimento';

  @override
  String get recurring_autoPayEnabledSub =>
      'Registrado automaticamente no vencimento';

  @override
  String get recurring_autoPayDisabledSub =>
      'Registrar este pagamento automaticamente no vencimento';

  @override
  String get recurring_autoPayTime => 'Horário do pagamento automático';

  @override
  String get recurring_reminderEnabledSub =>
      'Você será notificado na data de vencimento';

  @override
  String get recurring_reminderDisabledSub =>
      'Receber notificação quando o pagamento vencer';

  @override
  String get recurring_earlyReminderEnabledSub =>
      'Aviso extra 2 dias antes no mesmo horário';

  @override
  String get recurring_earlyReminderDisabledSub =>
      'Também ser notificado 2 dias antes do vencimento';

  @override
  String get recurring_addRecurringBtn => 'Adicionar recorrência';

  @override
  String get recurring_paymentDetails => 'Detalhes do pagamento';

  @override
  String get recurring_linkedAccount => 'Conta vinculada';

  @override
  String get recurring_deletedAccount => 'Conta excluída';

  @override
  String get recurring_frequency => 'Frequência';

  @override
  String get recurring_type => 'Tipo';

  @override
  String get recurring_startDate => 'Data de início';

  @override
  String get recurring_nextDueDate => 'Próximo vencimento';

  @override
  String get recurring_autoPay => 'Pagamento automático';

  @override
  String get recurring_reminder => 'Lembrete';

  @override
  String get recurring_endDate => 'Data de término';

  @override
  String get recurring_totalValue => 'Valor total';

  @override
  String get recurring_notes => 'Notas';

  @override
  String get recurring_upcomingPayments => 'Próximos pagamentos';

  @override
  String recurring_remainingCount(int count) {
    return '$count restantes';
  }

  @override
  String get recurring_allInstallmentsCompleted =>
      'Todas as parcelas concluídas';

  @override
  String recurring_installmentOf(int num, int total) {
    return '#$num de $total';
  }

  @override
  String get recurring_paymentPaid => 'Pagamento efetuado';

  @override
  String get recurring_paymentSkipped => 'Pagamento ignorado';

  @override
  String get presets_transfer => 'Transferência';

  @override
  String get presets_selectDifferentAccounts =>
      'Selecione contas de origem e destino diferentes.';

  @override
  String presets_targetAmountOptional(String currency) {
    return 'Valor em $currency (Opcional)';
  }

  @override
  String get transactions_transfers => 'Transferências';

  @override
  String transactions_selectedItemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count itens selecionados',
      one: '1 item selecionado',
    );
    return '$_temp0';
  }

  @override
  String transactions_entriesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lançamentos',
      one: '1 lançamento',
    );
    return '$_temp0';
  }

  @override
  String get transactions_clearSelection => 'Limpar seleção';

  @override
  String get transactions_transferTitle => 'Transação de transferência';

  @override
  String get transactions_transferBody =>
      'Esta transação faz parte de uma transferência entre contas e não pode ser editada isoladamente. Deseja excluir esta transferência?';

  @override
  String get transactions_deleteTransfer => 'Excluir transferência';

  @override
  String get transactions_transferDeleted => 'Transferência excluída';

  @override
  String get transactions_certTitle => 'Transação de certificado';

  @override
  String get transactions_certBody =>
      'Esta transação está vinculada a um certificado/depósito. Gerencie-a na tela de Certificados para manter os saldos corretos.';

  @override
  String get transactions_viewCertificate => 'Ver certificado';

  @override
  String get transactions_openCertificates => 'Abrir certificados';

  @override
  String get transactions_loanFallback => 'Empréstimo';

  @override
  String get transactions_loanPayment => 'Pagamento de empréstimo';

  @override
  String get transactions_goalContribution => 'Aporte para meta';

  @override
  String get transactions_goalWithdrawal => 'Retirada de meta';

  @override
  String get calendar_repayment => 'Reembolso';

  @override
  String get calendar_transfersDue => 'Transferências recorrentes previstas';

  @override
  String accounts_subtitleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count contas',
      one: '1 conta',
    );
    return '$_temp0';
  }

  @override
  String get accounts_tabAccounts => 'Contas';

  @override
  String get accounts_tabCards => 'Cartões';

  @override
  String get accounts_addCardBtn => 'Adicionar cartão';

  @override
  String get accounts_addNewCardBtn => 'Adicionar novo cartão';

  @override
  String get accounts_editCard => 'Editar cartão';

  @override
  String get accounts_cardNameHint => 'Nome do cartão (ex. Visa Platinum)';

  @override
  String get accounts_debitCard => 'Cartão de débito';

  @override
  String get accounts_prepaidCard => 'Cartão pré-pago';

  @override
  String get accounts_pinToWidget => 'Fixar no widget';

  @override
  String get accounts_unpinFromWidget => 'Desafixar do widget';

  @override
  String get accounts_maxPinnedWarning =>
      'Não é possível fixar mais de 3 contas';

  @override
  String get accounts_selectLinkedBank =>
      'Selecione uma conta bancária vinculada para este cartão.';

  @override
  String get accounts_debitSharesBalance =>
      'Cartões de débito compartilham o saldo da conta bancária vinculada.';

  @override
  String get accounts_linkedBankRequired =>
      'Conta bancária vinculada (Obrigatório)';

  @override
  String get accounts_amountCurrentlyOwed => 'Valor devido atualmente';

  @override
  String get accounts_initialAmountOwed => 'Valor devido inicial';

  @override
  String get accounts_cardDebtHint =>
      'Informe a fatura em aberto deste cartão (salvo como dívida)';

  @override
  String accounts_nextCycleCloses(int day) {
    return 'Próximo fechamento por volta do dia $day';
  }

  @override
  String accounts_spotPriceLabel(int karat) {
    return 'Preço à vista (ouro ${karat}k/g)';
  }

  @override
  String get accounts_weightTimesPurity => 'Peso × pureza';

  @override
  String accounts_blockDeleteRecurring(int count) {
    return 'A conta possui $count pagamentos recorrentes ativos. Reatribua ou exclua-os primeiro.';
  }

  @override
  String accounts_blockDeleteLoans(int count) {
    return 'A conta possui $count empréstimos ativos. Reatribua ou exclua-os primeiro.';
  }

  @override
  String accounts_blockDeleteCertificates(int count) {
    return 'A conta possui $count certificados ativos. Resgate ou exclua-os primeiro.';
  }

  @override
  String accounts_blockDeleteLended(int count) {
    return 'A conta possui $count registros em aberto. Quite-os primeiro.';
  }

  @override
  String accounts_blockDeleteSavings(int count) {
    return 'A conta é usada em $count contribuições de metas. Reatribua ou exclua-as primeiro.';
  }

  @override
  String accounts_blockDeletePresets(int count) {
    return 'A conta é usada por $count predefinições. Reatribua ou exclua-as primeiro.';
  }

  @override
  String accounts_blockDeleteCards(int count) {
    return 'A conta está vinculada a $count cartões. Desvincule ou exclua-os primeiro.';
  }

  @override
  String get add_transaction_selectAccountOrCard =>
      'Selecione uma conta ou cartão.';

  @override
  String get add_transaction_balanced => 'Equilibrado';

  @override
  String add_transaction_similarExists(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Já existem $count transações semelhantes:',
      one: 'Já existe uma transação semelhante:',
    );
    return '$_temp0';
  }

  @override
  String budget_goalsCountSubtitle(int budgets, int goals) {
    return '$budgets orçamentos · $goals metas';
  }

  @override
  String get budget_savingsGoalsCaps => 'METAS DE ECONOMIA';

  @override
  String budget_percentSaved(String percent) {
    return '$percent% economizado';
  }

  @override
  String budget_ofTarget(String amount) {
    return 'de $amount';
  }

  @override
  String get budget_goalsTab => 'Metas';

  @override
  String get budget_completed => 'Concluído';

  @override
  String get savings_newGoal => 'Nova meta de economia';

  @override
  String get savings_editGoal => 'Editar meta de economia';

  @override
  String get certificates_activePrincipal => 'Principal ativo';

  @override
  String get certificates_activeCount => 'Quantidade ativa';

  @override
  String certificates_linkedBank(String name) {
    return 'Vinculado: $name';
  }

  @override
  String certificates_yieldSummary(String amount, String type) {
    return 'Rendimento: $amount ($type)';
  }

  @override
  String certificates_maturesOn(String date) {
    return 'Vencimento: $date';
  }

  @override
  String get certificates_settledCaps => 'RESGATADO';

  @override
  String get certificates_activeCaps => 'ATIVO';

  @override
  String get certificates_annualRate => 'Taxa anual';

  @override
  String get certificates_periodicYieldLabel => 'Rendimento periódico';

  @override
  String get certificates_maturedAndSettled => 'Vencido e resgatado';

  @override
  String get certificates_payoutOverride => 'Rendimento (manual)';

  @override
  String get certificates_dayRange => 'Dia (1-31)';

  @override
  String get certificates_noBankAccounts =>
      'Nenhuma conta bancária disponível. Crie uma conta para receber rendimentos.';

  @override
  String get certificates_selectLinkedBank =>
      'Selecione uma conta bancária vinculada.';

  @override
  String get creditCard_noFundingAccounts =>
      'Nenhuma conta bancária ou em dinheiro disponível.';

  @override
  String get creditCard_processing => 'Processando...';

  @override
  String creditCard_payAmountBtn(String amount) {
    return 'Pagar $amount';
  }

  @override
  String get insights_loanPaymentsThisMonth =>
      'Pagamentos de empréstimos este mês';

  @override
  String get insights_spendingForecast => 'Previsão de gastos';

  @override
  String get insights_forecastPrefix => 'Nesse ritmo, você gastará ';

  @override
  String insights_forecastSuffix(String month, int days) {
    return ' até o fim de $month — faltam $days dias.';
  }

  @override
  String get insights_forecastDisclaimer =>
      'Projeção baseada nos gastos atuais; não inclui contas recorrentes futuras.';

  @override
  String insights_forecastAccuracy(int days) {
    return 'Com base nos primeiros $days dias — a precisão melhora ao longo do mês.';
  }

  @override
  String insights_projAmount(String amount) {
    return 'Prev.: $amount';
  }

  @override
  String insights_projOfBudget(String percent) {
    return ' ($percent% do orçamento)';
  }

  @override
  String get insights_outstanding => 'Saldo devedor';

  @override
  String get insights_monthlyObligation => 'Parcela mensal';

  @override
  String get loans_principal => 'Valor principal';

  @override
  String get loans_interestRate => 'Taxa de juros';

  @override
  String get loans_duration => 'Duração';

  @override
  String get loans_transferTo => 'Transferir valor do empréstimo para';

  @override
  String get loans_payFrom => 'Pagar parcelas de';

  @override
  String loans_dueDayTime(int day, String time) {
    return 'Vencimento: Dia $day às $time';
  }

  @override
  String more_activeCount(int count) {
    return '$count ativos';
  }

  @override
  String more_toolsSubtitle(int count) {
    return '$count ferramentas e preferências';
  }

  @override
  String get more_totalWealthCaps => 'PATRIMÔNIO TOTAL';

  @override
  String get more_liveNetWorthSub =>
      'Patrimônio líquido agregado em tempo real';

  @override
  String more_assetsAmount(String amount) {
    return 'Ativos: $amount';
  }

  @override
  String more_liabilitiesAmount(String amount) {
    return 'Passivos: $amount';
  }

  @override
  String get netWorth_debtFree => 'Livre de dívidas';

  @override
  String get netWorth_showLess => 'Mostrar menos';

  @override
  String netWorth_showAll(int count) {
    return 'Ver tudo ($count)';
  }

  @override
  String get netWorth_zeroLiabilities =>
      'Zero passivos registrados! Suas dívidas estão zeradas.';

  @override
  String get netWorth_lentDebts => 'Emprestado / Dívidas';

  @override
  String netWorth_snapBreakdown(String assets, String accounts) {
    return 'Ativos: $assets · Contas: $accounts';
  }

  @override
  String get onboarding_nameRequired => 'O nome é obrigatório';

  @override
  String get onboarding_popularCurrencies => 'Moedas populares';

  @override
  String get onboarding_debitCardNextStep =>
      'Você pode adicionar um cartão de débito para esta conta no próximo passo';

  @override
  String get onboarding_addDebitCardTitle => 'Adicionar cartão de débito';

  @override
  String get onboarding_addDebitCardDesc =>
      'Vincule um cartão de débito à sua conta para registrar gastos com facilidade.';

  @override
  String get onboarding_cardName => 'Nome do cartão';

  @override
  String get onboarding_cardholderName => 'Titular do cartão';

  @override
  String get onboarding_last4Digits => 'Últimos 4 dígitos';

  @override
  String get onboarding_cardColor => 'Cor do cartão';

  @override
  String wrapped_zeroSpendOfDays(int total) {
    return 'de $total dias sem gastos';
  }

  @override
  String get wrapped_savingsRateLabel => 'Taxa de economia';

  @override
  String get wrapped_topCategoryLabel => 'Maior categoria';

  @override
  String get wrapped_zeroSpendDaysLabel => 'Dias sem gastos';

  @override
  String get wrapped_footerTag => '★ Finanças Privadas e Offline ★';

  @override
  String get yearly_tapToExpand => 'Toque para expandir';

  @override
  String get yearly_noDataBadge => 'Sem dados';

  @override
  String get export_formatHeader => 'FORMATO DE EXPORTAÇÃO';

  @override
  String export_pdfPeriod(String range) {
    return 'Período: $range';
  }

  @override
  String export_pdfCurrency(String currency) {
    return 'Moeda: $currency';
  }

  @override
  String export_pdfGenerated(String date) {
    return 'Gerado: $date';
  }

  @override
  String export_pdfPageOf(int page, int total) {
    return 'Página $page de $total';
  }

  @override
  String get export_pdfTotalAssets => 'Total de ativos';

  @override
  String get export_pdfTotalLiabilities => 'Total de passivos';

  @override
  String get export_pdfCurrentNetWorth => 'Patrimônio líquido atual';

  @override
  String get export_pdfCategory => 'Categoria';

  @override
  String export_pdfAmountHeader(String currency) {
    return 'Valor ($currency)';
  }

  @override
  String get export_pdfPercentOfExpenses => '% das despesas totais';

  @override
  String get backup_encryptedTitle => 'Backup criptografado';

  @override
  String get backup_encryptedPrompt =>
      'Digite a senha usada para criptografar este backup:';

  @override
  String get backup_password => 'Senha';

  @override
  String get backup_confirmPassword => 'Confirmar senha';

  @override
  String get backup_decryptContinue => 'Descriptografar e continuar';

  @override
  String get backup_chooseRestoreMode => 'Escolher modo de restauração';

  @override
  String get backup_chooseRestoreModeDesc =>
      'Escolha se deseja restaurar tudo ou apenas dados específicos.';

  @override
  String get backup_selectiveRestore => 'Restauração seletiva';

  @override
  String get backup_selectiveRestoreDesc =>
      'Escolha itens específicos sem apagar os outros dados.';

  @override
  String get backup_fullRestore => 'Restauração completa';

  @override
  String get backup_fullRestoreDesc =>
      'Substitui completamente todos os dados e configurações atuais.';

  @override
  String get backup_selectiveBackup => 'Backup seletivo';

  @override
  String get backup_selectiveBackupBtn => 'Backup seletivo...';

  @override
  String get backup_selectiveBackupDesc =>
      'Escolha os dados financeiros que deseja exportar em JSON.';

  @override
  String get backup_selectedRestoredSuccess =>
      'Dados selecionados restaurados com sucesso!';

  @override
  String get backup_savingsGoals => 'Metas de economia';

  @override
  String get backup_savingsContributions => 'Aportes em metas';

  @override
  String get backup_encryptionDisabled => 'Criptografia de backup desativada';

  @override
  String get backup_encryptionEnabled => 'Criptografia de backup ativada';

  @override
  String backup_encryptionFailed(String error) {
    return 'Falha ao ativar criptografia: $error';
  }

  @override
  String get backup_encryptAutoTitle => 'Criptografar backups automáticos';

  @override
  String get backup_encryptAutoDesc =>
      'Protege seus backups com AES-GCM-256. Se esquecer a senha, não será possível restaurar.';

  @override
  String get backup_passwordEmpty => 'A senha não pode ficar vazia';

  @override
  String get backup_passwordsMismatch => 'As senhas não coincidem';

  @override
  String get backup_setPassword => 'Definir senha';

  @override
  String backup_autoCreated(String file) {
    return 'Backup automático criado: $file';
  }

  @override
  String backup_autoFailed(String error) {
    return 'Falha no backup automático: $error';
  }

  @override
  String get backup_nightlySchedule =>
      'Todas as noites às ~2:00 na pasta escolhida';

  @override
  String get backup_noFolderSelected => 'Nenhuma pasta selecionada';

  @override
  String get backup_keepCopies => 'Manter cópias:';

  @override
  String get backup_encryptAes => 'Criptografar (AES-GCM)';

  @override
  String backup_failedError(String error) {
    return 'Falha: $error';
  }

  @override
  String backup_lastSuccess(String date, String kb) {
    return 'Último: $date ($kb KB)';
  }

  @override
  String get backup_backingUp => 'Fazendo backup...';

  @override
  String get backup_backUpNow => 'Fazer backup agora';

  @override
  String get backup_androidIdleNote =>
      'Executa às ~2:00. O Android pode atrasar com o celular ocioso.';

  @override
  String get backup_selectAll => 'Selecionar tudo';

  @override
  String get backup_deselectAll => 'Desmarcar tudo';

  @override
  String get backup_selectiveSaved => 'Backup seletivo salvo com sucesso!';

  @override
  String backup_exportFailed(String error) {
    return 'Falha na exportação: $error';
  }

  @override
  String backup_exportSelected(int count) {
    return 'Exportar ($count) selecionados';
  }

  @override
  String backup_restoreSelected(int count) {
    return 'Restaurar ($count) selecionados';
  }

  @override
  String get backup_selectiveRestoreNote =>
      'Apenas os itens marcados serão restaurados. O restante permanece intacto.';

  @override
  String backup_countInBackup(int count) {
    return '$count no backup';
  }

  @override
  String get backup_entityTxSplitsPresets => 'Transações, divisões e atalhos';

  @override
  String get backup_entityRecurringHistory =>
      'Pagamentos recorrentes e histórico';

  @override
  String get backup_entityLoansPayments => 'Empréstimos e pagamentos';

  @override
  String get backup_entityLentContacts => 'Emprestado e contatos';

  @override
  String get backup_entityAssetsValuables => 'Ativos e bens';

  @override
  String get backup_entityWishlistGoals => 'Lista de desejos e metas';

  @override
  String get common_perDay => '/ dia';

  @override
  String common_daysShort(int count) {
    return '$count d';
  }

  @override
  String get common_splitCaps => 'DIVIDIDO';

  @override
  String budget_deletedCategory(String name) {
    return '$name excluído';
  }

  @override
  String get loans_paymentDeleted => 'Pagamento excluído';

  @override
  String certificates_collectionDayLabel(String frequency, int day) {
    return '$frequency (Dia $day)';
  }

  @override
  String add_transaction_duplicateItem(
      String amount, String date, String desc) {
    return '• $amount em $date$desc';
  }

  @override
  String creditCard_billPaymentDesc(String name) {
    return 'Pagamento de fatura — $name';
  }

  @override
  String get onboarding_defaultBankName => 'Banco Principal';

  @override
  String get onboarding_defaultCardholder => 'MEMBRO EXPENSY';

  @override
  String get onboarding_defaultUser => 'Usuário';

  @override
  String get export_excelSheetName => 'Transações';

  @override
  String get export_headerDate => 'Data';

  @override
  String get export_headerDescription => 'Descrição';

  @override
  String get export_headerType => 'Tipo';

  @override
  String get export_headerAmount => 'Valor';

  @override
  String get export_headerCurrency => 'Moeda';

  @override
  String get export_headerAccount => 'Conta';

  @override
  String get export_headerCategory => 'Categoria';

  @override
  String get export_headerSubcategory => 'Subcategoria';

  @override
  String get export_headerNote => 'Nota';

  @override
  String get cat_food_exp => 'Alimentação';

  @override
  String get cat_transport => 'Transporte';

  @override
  String get cat_shopping => 'Compras';

  @override
  String get cat_bills => 'Contas e Serviços';

  @override
  String get cat_health => 'Saúde';

  @override
  String get cat_entertainment => 'Entretenimento';

  @override
  String get cat_education => 'Educação';

  @override
  String get cat_personal => 'Cuidados Pessoais';

  @override
  String get cat_salary => 'Salário';

  @override
  String get cat_freelance => 'Freelance';

  @override
  String get cat_investments => 'Investimentos';

  @override
  String get cat_gifts => 'Presentes';

  @override
  String get cat_other_inc => 'Outras Receitas';

  @override
  String get cat_other_exp => 'Outras Despesas';

  @override
  String get cat_sys_transfer => 'Transferência';

  @override
  String get cat_sys_investment => 'Investimento';

  @override
  String get sub_groceries => 'Supermercado';

  @override
  String get sub_restaurants => 'Restaurantes';

  @override
  String get sub_delivery => 'Entrega';

  @override
  String get sub_coffee_tea => 'Café e Chá';

  @override
  String get sub_fuel => 'Combustível';

  @override
  String get sub_public_transit => 'Transporte Público';

  @override
  String get sub_taxi_ride => 'Táxi e Corridas';

  @override
  String get sub_maintenance => 'Manutenção';

  @override
  String get sub_parking_tolls => 'Estacionamento e Pedágio';

  @override
  String get sub_clothing => 'Roupas';

  @override
  String get sub_electronics => 'Eletrônicos';

  @override
  String get sub_home_furniture => 'Casa e Móveis';

  @override
  String get sub_gifts => 'Presentes';

  @override
  String get sub_electricity => 'Energia';

  @override
  String get sub_internet => 'Internet';

  @override
  String get sub_water => 'Água';

  @override
  String get sub_phone => 'Telefone';

  @override
  String get sub_medicine => 'Medicamentos';

  @override
  String get sub_doctor => 'Médico';

  @override
  String get sub_movies => 'Filmes';

  @override
  String get sub_games => 'Jogos';

  @override
  String get sub_subscriptions => 'Assinaturas';

  @override
  String get notif_overBudgetTitle => '🚨 Orçamento excedido';

  @override
  String notif_overBudgetBody(String category, String amount, String period) {
    return '$category — $amount acima do seu limite ($period)';
  }

  @override
  String get notif_goalReachedTitle => '🎉 Meta atingida';

  @override
  String notif_goalReachedBody(String amount, String name) {
    return 'Você atingiu sua meta de $amount para $name!';
  }

  @override
  String get notif_certPayoutDueTitle => '📈 Rendimento do certificado devido';

  @override
  String get notif_certPayoutUpcomingTitle =>
      '📈 Próximo rendimento do certificado';

  @override
  String notif_certPayoutBody(String name) {
    return 'O rendimento de $name vence hoje.';
  }

  @override
  String notif_certPayoutSoonBody(String name) {
    return 'O rendimento de $name vence em 2 dias.';
  }

  @override
  String get notif_creditBillDueTodayTitle => '💳 Fatura vence hoje';

  @override
  String get notif_creditBillDueSoonTitle => '💳 Fatura vence em breve';

  @override
  String get notif_dailyReminderTitle => '📝 Lembrete diário';

  @override
  String get notif_dailyReminderBody =>
      'Não se esqueça de registrar os gastos de hoje.';

  @override
  String notif_lendedDueTitle(String emoji, String name) {
    return '$emoji Vence: $name';
  }

  @override
  String get notif_loanPaymentDueTitle => '🏦 Parcela do empréstimo devida';

  @override
  String notif_loanPaymentDueBody(String name) {
    return 'A parcela de $name vence hoje.';
  }

  @override
  String get notif_autoBackupFailedTitle => 'Falha no backup automático';

  @override
  String notif_autoBackupFailedBody(String error) {
    return 'Expensy não pôde criar seu backup agendado: $error';
  }

  @override
  String notif_recurringTransferBody(String amount) {
    return 'Transferência de $amount pendente';
  }

  @override
  String notif_recurringIncomeBody(String amount) {
    return 'Receita de $amount prevista';
  }

  @override
  String notif_recurringExpenseBody(String amount) {
    return 'Pagamento de $amount pendente';
  }

  @override
  String notif_creditBillDueTodayBody(String name) {
    return 'Sua fatura de $name vence hoje.';
  }

  @override
  String notif_creditBillDueSoonBody(String name) {
    return 'Sua fatura de $name vence em 2 dias.';
  }

  @override
  String notif_lendedLentDueBody(String amount, String name) {
    return '$amount que você emprestou para $name vence hoje';
  }

  @override
  String notif_lendedBorrowedDueBody(String amount, String name) {
    return '$amount que você pegou emprestado de $name vence hoje';
  }

  @override
  String notif_recurringTransferDueSoonBody(String amount) {
    return 'Transferência de $amount vence em 2 dias';
  }

  @override
  String notif_recurringIncomeDueSoonBody(String amount) {
    return '$amount esperado em 2 dias';
  }

  @override
  String notif_recurringExpenseDueSoonBody(String amount) {
    return '$amount vence em 2 dias';
  }
}
