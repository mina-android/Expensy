// lib/database/tables.dart
import 'package:drift/drift.dart';

@DataClassName('AccountEntry')
class Accounts extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get name => text().named('name')();
  TextColumn get type => text().named('type')();
  RealColumn get balance => real().named('balance')();
  TextColumn get currency => text().named('currency').withDefault(const Constant('EGP'))();
  IntColumn get colorValue => integer().named('color_value')();
  IntColumn get excludeFromTotal => integer().named('exclude_from_total').withDefault(const Constant(0))();
  TextColumn get createdAt => text().named('created_at')();
  IntColumn get goldKarat => integer().named('gold_karat').nullable()();
  RealColumn get goldGrams => real().named('gold_grams').nullable()();
  TextColumn get cardHolderName => text().named('card_holder_name').nullable()();
  TextColumn get cardNumberLast4 => text().named('card_number_last4').nullable()();
  TextColumn get cardExpiry => text().named('card_expiry').nullable()();
  IntColumn get statementDay => integer().named('statement_day').nullable()();
  IntColumn get dueDay => integer().named('due_day').nullable()();
  RealColumn get creditLimit => real().named('credit_limit').nullable()();
  RealColumn get minPaymentAmount => real().named('min_payment_amount').nullable()();
  RealColumn get minPaymentPercent => real().named('min_payment_percent').nullable()();
  IntColumn get creditReminderEnabled => integer().named('credit_reminder_enabled').withDefault(const Constant(0))();
  TextColumn get creditReminderTime => text().named('credit_reminder_time').nullable().withDefault(const Constant('09:00'))();
  IntColumn get creditEarlyReminderEnabled => integer().named('credit_early_reminder_enabled').nullable().withDefault(const Constant(0))();
  TextColumn get linkedAccountId => text().named('linked_account_id').nullable()();
  IntColumn get orderIndex => integer().named('order_index').nullable().withDefault(const Constant(0))();
  IntColumn get excludeFromBankTotal => integer().named('exclude_from_bank_total').withDefault(const Constant(0))();
  IntColumn get dontLinkToCard => integer().named('dont_link_to_card').withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CategoryEntry')
class Categories extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get name => text().named('name')();
  TextColumn get type => text().named('type')();
  IntColumn get colorValue => integer().named('color_value')();
  IntColumn get iconCodePoint => integer().named('icon_code_point').withDefault(const Constant(0))();
  IntColumn get orderIndex => integer().named('order_index').withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('TransactionEntry')
class Transactions extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get type => text().named('type')();
  RealColumn get amount => real().named('amount')();
  TextColumn get description => text().named('description')();
  TextColumn get accountId => text().named('account_id')();
  TextColumn get categoryId => text().named('category_id')();
  TextColumn get date => text().named('date')();
  TextColumn get note => text().named('note').withDefault(const Constant(''))();
  TextColumn get currency => text().named('currency').withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('RecurringPaymentEntry')
class RecurringPayments extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get name => text().named('name')();
  TextColumn get accountId => text().named('account_id')();
  TextColumn get categoryId => text().named('category_id')();
  RealColumn get amount => real().named('amount')();
  TextColumn get paymentType => text().named('payment_type').withDefault(const Constant('expense'))();
  IntColumn get freqVal => integer().named('freq_val').withDefault(const Constant(1))();
  TextColumn get freqUnit => text().named('freq_unit').withDefault(const Constant('months'))();
  TextColumn get startDate => text().named('start_date')();
  TextColumn get nextDate => text().named('next_date')();
  TextColumn get endDate => text().named('end_date').nullable()();
  IntColumn get paidPayments => integer().named('paid_payments').withDefault(const Constant(0))();
  IntColumn get reminderEnabled => integer().named('reminder_enabled').withDefault(const Constant(0))();
  TextColumn get reminderTime => text().named('reminder_time').withDefault(const Constant('09:00'))();
  IntColumn get earlyReminderEnabled => integer().named('early_reminder_enabled').withDefault(const Constant(0))();
  TextColumn get notes => text().named('notes').withDefault(const Constant(''))();
  TextColumn get recurringType => text().named('recurring_type').withDefault(const Constant('subscription'))();
  IntColumn get autoPayEnabled => integer().named('auto_pay_enabled').withDefault(const Constant(0))();
  TextColumn get autoPayTime => text().named('auto_pay_time').withDefault(const Constant('09:00'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WishlistEntry')
class Wishlist extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get name => text().named('name')();
  RealColumn get targetPrice => real().named('target_price')();
  TextColumn get priority => text().named('priority')();
  IntColumn get isPurchased => integer().named('is_purchased').withDefault(const Constant(0))();
  TextColumn get notes => text().named('notes').withDefault(const Constant(''))();
  TextColumn get createdAt => text().named('created_at')();
  TextColumn get goalId => text().named('goal_id').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Legacy orphaned table from pre-v5 schema, retained for schema fidelity.
@DataClassName('AssetItemEntry')
class AssetItems extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get name => text().named('name')();
  RealColumn get value => real().named('value')();
  IntColumn get colorValue => integer().named('color_value')();
  TextColumn get notes => text().named('notes').nullable()();
  TextColumn get createdAt => text().named('created_at')();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('NetWorthSnapshotEntry')
class NetWorthSnapshots extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get date => text().named('date')();
  RealColumn get totalAccounts => real().named('total_accounts')();
  RealColumn get totalAssets => real().named('total_assets')();
  RealColumn get netWorth => real().named('net_worth')();
  TextColumn get currency => text().named('currency')();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('LendedPersonEntry')
class LendedPeople extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get name => text().named('name')();
  IntColumn get colorValue => integer().named('color_value')();
  TextColumn get notes => text().named('notes').withDefault(const Constant(''))();
  TextColumn get createdAt => text().named('created_at')();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('LendedMoneyEntry')
class LendedMoneyTable extends Table {
  @override
  String get tableName => 'lended_money';

  TextColumn get id => text().named('id')();
  TextColumn get personId => text().named('person_id')();
  RealColumn get amount => real().named('amount')();
  TextColumn get type => text().named('type')();
  TextColumn get accountId => text().named('account_id').nullable()();
  IntColumn get isSettled => integer().named('is_settled').withDefault(const Constant(0))();
  TextColumn get date => text().named('date')();
  TextColumn get dueDate => text().named('due_date').nullable()();
  TextColumn get notes => text().named('notes').withDefault(const Constant(''))();
  IntColumn get reminderEnabled => integer().named('reminder_enabled').withDefault(const Constant(0))();
  TextColumn get reminderTime => text().named('reminder_time').withDefault(const Constant('09:00'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('AssetEntry')
class Assets extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get name => text().named('name')();
  RealColumn get value => real().named('value')();
  TextColumn get currency => text().named('currency').withDefault(const Constant('EGP'))();
  TextColumn get notes => text().named('notes').withDefault(const Constant(''))();
  TextColumn get createdAt => text().named('created_at')();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('BudgetEntry')
class Budgets extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get categoryId => text().named('category_id')();
  RealColumn get amount => real().named('amount')();
  TextColumn get period => text().named('period').withDefault(const Constant('monthly'))();
  TextColumn get createdAt => text().named('created_at')();
  IntColumn get allowRollover => integer().named('allow_rollover').withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('RecurringHistoryRow')
class RecurringHistory extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get recurringId => text().named('recurring_id')();
  TextColumn get action => text().named('action')();
  TextColumn get date => text().named('date')();
  RealColumn get amount => real().named('amount')();
  TextColumn get currency => text().named('currency')();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SavingsGoalEntry')
class SavingsGoals extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get name => text().named('name')();
  RealColumn get targetAmount => real().named('target_amount')();
  RealColumn get currentAmount => real().named('current_amount').withDefault(const Constant(0))();
  TextColumn get currency => text().named('currency')();
  TextColumn get targetDate => text().named('target_date').nullable()();
  IntColumn get colorValue => integer().named('color_value')();
  IntColumn get isCompleted => integer().named('is_completed').withDefault(const Constant(0))();
  TextColumn get createdAt => text().named('created_at')();
  TextColumn get completedAt => text().named('completed_at').nullable()();
  TextColumn get wishlistItemId => text().named('wishlist_item_id').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SavingsContributionEntry')
class SavingsContributions extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get goalId => text().named('goal_id')();
  RealColumn get amount => real().named('amount')();
  TextColumn get accountId => text().named('account_id')();
  TextColumn get type => text().named('type')();
  TextColumn get date => text().named('date')();
  TextColumn get note => text().named('note').withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('LoanEntry')
class Loans extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get name => text().named('name')();
  RealColumn get principal => real().named('principal')();
  TextColumn get currency => text().named('currency').withDefault(const Constant('EGP'))();
  TextColumn get startDate => text().named('start_date')();
  TextColumn get endDate => text().named('end_date')();
  RealColumn get interestRate => real().named('interest_rate').nullable()();
  TextColumn get accountId => text().named('account_id').nullable()();
  TextColumn get transferAccountId => text().named('transfer_account_id').nullable()();
  IntColumn get reminderEnabled => integer().named('reminder_enabled').withDefault(const Constant(0))();
  IntColumn get reminderDay => integer().named('reminder_day').withDefault(const Constant(1))();
  TextColumn get reminderTime => text().named('reminder_time').withDefault(const Constant('09:00'))();
  IntColumn get isSettled => integer().named('is_settled').withDefault(const Constant(0))();
  TextColumn get notes => text().named('notes').withDefault(const Constant(''))();
  TextColumn get createdAt => text().named('created_at')();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('LoanPaymentEntry')
class LoanPayments extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get loanId => text().named('loan_id')();
  TextColumn get date => text().named('date')();
  RealColumn get amount => real().named('amount')();
  TextColumn get currency => text().named('currency')();
  TextColumn get accountId => text().named('account_id').nullable()();
  TextColumn get notes => text().named('notes').withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('TransactionPresetEntry')
class TransactionPresets extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get title => text().named('title')();
  TextColumn get type => text().named('type')(); // expense | income
  RealColumn get amount => real().named('amount')();
  TextColumn get accountId => text().named('account_id')();
  TextColumn get categoryId => text().named('category_id')();
  TextColumn get currency => text().named('currency').withDefault(const Constant(''))();
  TextColumn get note => text().named('note').withDefault(const Constant(''))();
  IntColumn get colorValue => integer().named('color_value')();
  IntColumn get iconCodePoint => integer().named('icon_code_point').withDefault(const Constant(0))();
  IntColumn get orderIndex => integer().named('order_index').withDefault(const Constant(0))();
  TextColumn get createdAt => text().named('created_at')();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'transaction_presets';
}

@DataClassName('TransactionSplitEntry')
class TransactionSplits extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get transactionId => text().named('transaction_id')();
  TextColumn get categoryId => text().named('category_id')();
  RealColumn get amount => real().named('amount')();
  TextColumn get note => text().named('note').withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'transaction_splits';
}
