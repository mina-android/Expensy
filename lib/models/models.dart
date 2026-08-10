// lib/models/models.dart

class Account {
  final String id;
  String name;
  String type; // bank|cash|savings|credit|wallet|gold
  double balance;
  String currency;
  int colorValue;
  bool excludeFromTotal;
  bool excludeFromBankTotal;
  DateTime createdAt;
  // Gold-specific fields (null for non-gold accounts)
  final int? goldKarat; // 24, 22, 21, 18, 14, 10, 9
  final double? goldGrams;
  // Credit card specific fields
  final String? cardHolderName;
  final String? cardNumberLast4;
  final String? cardExpiry;
  final int? statementDay;
  final int? dueDay;
  final double? creditLimit;
  final double? minPaymentAmount;
  final double? minPaymentPercent;
  final bool creditReminderEnabled;
  final String creditReminderTime;
  final bool creditEarlyReminderEnabled;
  final String? linkedAccountId;
  int orderIndex;

  Account({
    required this.id,
    required this.name,
    required this.type,
    required this.balance,
    this.currency = 'EGP',
    required this.colorValue,
    this.excludeFromTotal = false,
    this.excludeFromBankTotal = false,
    DateTime? createdAt,
    this.goldKarat,
    this.goldGrams,
    this.cardHolderName,
    this.cardNumberLast4,
    this.cardExpiry,
    this.statementDay,
    this.dueDay,
    this.creditLimit,
    this.minPaymentAmount,
    this.minPaymentPercent,
    this.creditReminderEnabled = false,
    this.creditReminderTime = '09:00',
    this.creditEarlyReminderEnabled = false,
    this.linkedAccountId,
    this.orderIndex = 0,
  }) : createdAt = createdAt ?? DateTime.now();

  /// True when this account tracks a physical gold holding.
  bool get isGold => type == 'gold';

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'type': type,
        'balance': balance,
        'currency': currency,
        'color_value': colorValue,
        'exclude_from_total': excludeFromTotal ? 1 : 0,
        'exclude_from_bank_total': excludeFromBankTotal ? 1 : 0,
        'created_at': createdAt.toIso8601String(),
        'gold_karat': goldKarat,
        'gold_grams': goldGrams,
        'card_holder_name': cardHolderName,
        'card_number_last4': cardNumberLast4,
        'card_expiry': cardExpiry,
        'statement_day': statementDay,
        'due_day': dueDay,
        'credit_limit': creditLimit,
        'min_payment_amount': minPaymentAmount,
        'min_payment_percent': minPaymentPercent,
        'credit_reminder_enabled': creditReminderEnabled ? 1 : 0,
        'credit_reminder_time': creditReminderTime,
        'credit_early_reminder_enabled': creditEarlyReminderEnabled ? 1 : 0,
        'linked_account_id': linkedAccountId,
        'order_index': orderIndex,
      };

  static Account fromMap(Map<String, dynamic> m) => Account(
        id: (m['id'] as String?) ?? '',
        name: (m['name'] as String?) ?? 'Unknown',
        type: (m['type'] as String?) ?? 'cash',
        balance: (m['balance'] as num?)?.toDouble() ?? 0.0,
        currency: (m['currency'] as String?) ?? 'EGP',
        colorValue: (m['color_value'] as int?) ?? 0xFF6750A4,
        excludeFromTotal: (m['exclude_from_total'] as int? ?? 0) == 1,
        excludeFromBankTotal: (m['exclude_from_bank_total'] as int? ?? 0) == 1,
        createdAt: m['created_at'] != null
            ? DateTime.parse(m['created_at'] as String)
            : DateTime.now(),
        goldKarat: m['gold_karat'] as int?,
        goldGrams: (m['gold_grams'] as num?)?.toDouble(),
        cardHolderName: m['card_holder_name'] as String?,
        cardNumberLast4: m['card_number_last4'] as String?,
        cardExpiry: m['card_expiry'] as String?,
        statementDay: m['statement_day'] as int?,
        dueDay: m['due_day'] as int?,
        creditLimit: (m['credit_limit'] as num?)?.toDouble(),
        minPaymentAmount: (m['min_payment_amount'] as num?)?.toDouble(),
        minPaymentPercent: (m['min_payment_percent'] as num?)?.toDouble(),
        creditReminderEnabled: (m['credit_reminder_enabled'] as int? ?? 0) == 1,
        creditReminderTime: m['credit_reminder_time'] as String? ?? '09:00',
        creditEarlyReminderEnabled:
            (m['credit_early_reminder_enabled'] as int? ?? 0) == 1,
        linkedAccountId: m['linked_account_id'] as String?,
        orderIndex: m['order_index'] as int? ?? 0,
      );

  Account copyWith({
    String? name,
    String? type,
    double? balance,
    String? currency,
    int? colorValue,
    bool? excludeFromTotal,
    bool? excludeFromBankTotal,
    int? goldKarat,
    double? goldGrams,
    String? cardHolderName,
    String? cardNumberLast4,
    String? cardExpiry,
    int? statementDay,
    int? dueDay,
    double? creditLimit,
    double? minPaymentAmount,
    double? minPaymentPercent,
    bool? creditReminderEnabled,
    String? creditReminderTime,
    bool? creditEarlyReminderEnabled,
    String? linkedAccountId,
    int? orderIndex,
    bool clearGold = false,
    bool clearCredit = false,
    bool clearLinkedAccount = false,
  }) =>
      Account(
        id: id,
        name: name ?? this.name,
        type: type ?? this.type,
        balance: balance ?? this.balance,
        currency: currency ?? this.currency,
        colorValue: colorValue ?? this.colorValue,
        excludeFromTotal: excludeFromTotal ?? this.excludeFromTotal,
        excludeFromBankTotal: excludeFromBankTotal ?? this.excludeFromBankTotal,
        createdAt: createdAt,
        goldKarat: clearGold ? null : (goldKarat ?? this.goldKarat),
        goldGrams: clearGold ? null : (goldGrams ?? this.goldGrams),
        cardHolderName:
            clearCredit ? null : (cardHolderName ?? this.cardHolderName),
        cardNumberLast4:
            clearCredit ? null : (cardNumberLast4 ?? this.cardNumberLast4),
        cardExpiry: clearCredit ? null : (cardExpiry ?? this.cardExpiry),
        statementDay: clearCredit ? null : (statementDay ?? this.statementDay),
        dueDay: clearCredit ? null : (dueDay ?? this.dueDay),
        creditLimit: clearCredit ? null : (creditLimit ?? this.creditLimit),
        minPaymentAmount:
            clearCredit ? null : (minPaymentAmount ?? this.minPaymentAmount),
        minPaymentPercent:
            clearCredit ? null : (minPaymentPercent ?? this.minPaymentPercent),
        creditReminderEnabled:
            creditReminderEnabled ?? this.creditReminderEnabled,
        creditReminderTime: creditReminderTime ?? this.creditReminderTime,
        creditEarlyReminderEnabled:
            creditEarlyReminderEnabled ?? this.creditEarlyReminderEnabled,
        linkedAccountId: clearLinkedAccount
            ? null
            : (linkedAccountId ?? this.linkedAccountId),
        orderIndex: orderIndex ?? this.orderIndex,
      );
}

class AppCategory {
  final String id;
  String name;
  String type; // income|expense
  int colorValue;

  /// Code point of the icon (Icons.xxx.codePoint). 0 = use name-based default.
  int iconCodePoint;

  /// The order in which the category should appear in lists.
  int orderIndex;

  AppCategory(
      {required this.id,
      required this.name,
      required this.type,
      required this.colorValue,
      this.iconCodePoint = 0,
      this.orderIndex = 0});

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'type': type,
        'color_value': colorValue,
        'icon_code_point': iconCodePoint,
        'order_index': orderIndex,
      };

  static AppCategory fromMap(Map<String, dynamic> m) => AppCategory(
        id: (m['id'] as String?) ?? '',
        name: (m['name'] as String?) ?? 'Unknown',
        type: (m['type'] as String?) ?? 'expense',
        colorValue: (m['color_value'] as int?) ?? 0xFF6750A4,
        iconCodePoint: m['icon_code_point'] as int? ?? 0,
        orderIndex: m['order_index'] as int? ?? 0,
      );

  AppCategory copyWith(
          {String? name,
          int? colorValue,
          int? iconCodePoint,
          int? orderIndex}) =>
      AppCategory(
          id: id,
          name: name ?? this.name,
          type: type,
          colorValue: colorValue ?? this.colorValue,
          iconCodePoint: iconCodePoint ?? this.iconCodePoint,
          orderIndex: orderIndex ?? this.orderIndex);
}

class AppTransaction {
  final String id;
  String type; // income|expense
  double amount;
  String description;
  String accountId;
  String categoryId;
  DateTime date;
  String note;

  /// Currency the amount was entered in. Empty string = same as account currency.
  String currency;

  AppTransaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.accountId,
    required this.categoryId,
    required this.date,
    this.note = '',
    this.currency = '',
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'amount': amount,
        'description': description,
        'account_id': accountId,
        'category_id': categoryId,
        'date': date.toIso8601String(),
        'note': note,
        'currency': currency,
      };

  static AppTransaction fromMap(Map<String, dynamic> m) => AppTransaction(
        id: (m['id'] as String?) ?? '',
        type: (m['type'] as String?) ?? 'expense',
        amount: (m['amount'] as num?)?.toDouble() ?? 0.0,
        description: (m['description'] as String?) ?? '',
        accountId: (m['account_id'] as String?) ?? '',
        categoryId: (m['category_id'] as String?) ?? '',
        date: m['date'] != null
            ? DateTime.parse(m['date'] as String)
            : DateTime.now(),
        note: (m['note'] as String?) ?? '',
        currency: (m['currency'] as String?) ?? '',
      );

  AppTransaction copyWith({
    String? type,
    double? amount,
    String? description,
    String? accountId,
    String? categoryId,
    DateTime? date,
    String? note,
    String? currency,
  }) =>
      AppTransaction(
        id: id,
        type: type ?? this.type,
        amount: amount ?? this.amount,
        description: description ?? this.description,
        accountId: accountId ?? this.accountId,
        categoryId: categoryId ?? this.categoryId,
        date: date ?? this.date,
        note: note ?? this.note,
        currency: currency ?? this.currency,
      );
}

class RecurringPayment {
  final String id;
  String name;
  String accountId;
  String categoryId;
  double amount;
  String paymentType; // expense|income
  int freqVal;
  String freqUnit; // days|weeks|months|years
  DateTime startDate; // first payment
  DateTime nextDate;
  DateTime? endDate; // last payment (null = ongoing)
  int paidPayments;
  bool reminderEnabled;

  /// Time of day for the reminder in 'HH:mm' format, e.g. '09:00'.
  String reminderTime;

  /// When true, an additional notification fires 2 days before [nextDate]
  /// at the same [reminderTime]. Only meaningful when [reminderEnabled] is true.
  bool earlyReminderEnabled;
  String notes;
  String recurringType; // 'subscription' | 'installment'

  RecurringPayment({
    required this.id,
    required this.name,
    required this.accountId,
    required this.categoryId,
    required this.amount,
    this.paymentType = 'expense',
    required this.freqVal,
    required this.freqUnit,
    required this.startDate,
    required this.nextDate,
    this.endDate,
    this.paidPayments = 0,
    this.reminderEnabled = false,
    this.reminderTime = '09:00',
    this.earlyReminderEnabled = false,
    this.notes = '',
    this.recurringType = 'subscription',
  });

  // Inclusive count: first → last
  int? get totalPayments {
    if (endDate == null) return null;
    return _countPayments(startDate, endDate!);
  }

  int? get remainingPayments {
    if (endDate == null) return null;
    final rem = (totalPayments ?? 0) - paidPayments;
    return rem < 0 ? 0 : rem;
  }

  double get remainingAmount => (remainingPayments ?? 0) * amount;
  double get totalAmount => (totalPayments ?? 0) * amount;

  String get frequencyLabel {
    if (freqVal == 1) {
      switch (freqUnit) {
        case 'days':
          return 'Daily';
        case 'weeks':
          return 'Weekly';
        case 'months':
          return 'Monthly';
        case 'years':
          return 'Yearly';
      }
    }
    return 'Every $freqVal $freqUnit';
  }

  int _countPayments(DateTime first, DateTime last) {
    if (last.isBefore(first)) return 0;
    switch (freqUnit) {
      case 'days':
        return (last.difference(first).inDays ~/ freqVal) + 1;
      case 'weeks':
        return (last.difference(first).inDays ~/ (freqVal * 7)) + 1;
      case 'months':
        final months = (last.year - first.year) * 12 + last.month - first.month;
        return (months ~/ freqVal) + 1;
      case 'years':
        return ((last.year - first.year) ~/ freqVal) + 1;
      default:
        final months = (last.year - first.year) * 12 + last.month - first.month;
        return (months ~/ freqVal) + 1;
    }
  }

  DateTime calcNextDate() {
    switch (freqUnit) {
      case 'days':
        return nextDate.add(Duration(days: freqVal));
      case 'weeks':
        return nextDate.add(Duration(days: freqVal * 7));
      case 'months':
        final m = nextDate.month + freqVal;
        final y = nextDate.year + (m - 1) ~/ 12;
        final mon = ((m - 1) % 12) + 1;
        final day = nextDate.day.clamp(1, DateTime(y, mon + 1, 0).day);
        return DateTime(y, mon, day);
      case 'years':
        return DateTime(nextDate.year + freqVal, nextDate.month, nextDate.day);
      default:
        return nextDate.add(Duration(days: freqVal * 30));
    }
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'account_id': accountId,
        'category_id': categoryId,
        'amount': amount,
        'payment_type': paymentType,
        'freq_val': freqVal,
        'freq_unit': freqUnit,
        'start_date': startDate.toIso8601String(),
        'next_date': nextDate.toIso8601String(),
        'end_date': endDate?.toIso8601String(),
        'paid_payments': paidPayments,
        'reminder_enabled': reminderEnabled ? 1 : 0,
        'reminder_time': reminderTime,
        'early_reminder_enabled': earlyReminderEnabled ? 1 : 0,
        'notes': notes,
        'recurring_type': recurringType,
      };

  static RecurringPayment fromMap(Map<String, dynamic> m) => RecurringPayment(
        id: (m['id'] as String?) ?? '',
        name: (m['name'] as String?) ?? '',
        accountId: (m['account_id'] as String?) ?? '',
        categoryId: (m['category_id'] as String?) ?? '',
        amount: (m['amount'] as num?)?.toDouble() ?? 0.0,
        paymentType: (m['payment_type'] as String?) ?? 'expense',
        freqVal: (m['freq_val'] as int?) ?? 1,
        freqUnit: (m['freq_unit'] as String?) ?? 'months',
        startDate: m['start_date'] != null
            ? DateTime.parse(m['start_date'] as String)
            : DateTime.now(),
        nextDate: m['next_date'] != null
            ? DateTime.parse(m['next_date'] as String)
            : DateTime.now(),
        endDate: m['end_date'] != null
            ? DateTime.parse(m['end_date'] as String)
            : null,
        paidPayments: m['paid_payments'] as int? ?? 0,
        reminderEnabled: (m['reminder_enabled'] as int? ?? 0) == 1,
        reminderTime: (m['reminder_time'] as String?) ?? '09:00',
        earlyReminderEnabled: (m['early_reminder_enabled'] as int? ?? 0) == 1,
        notes: (m['notes'] as String?) ?? '',
        recurringType: (m['recurring_type'] as String?) ?? 'subscription',
      );
}

class WishlistItem {
  final String id;
  String name;
  double targetPrice;
  String priority; // low|medium|high
  bool isPurchased;
  String notes;
  DateTime createdAt;

  WishlistItem({
    required this.id,
    required this.name,
    required this.targetPrice,
    required this.priority,
    this.isPurchased = false,
    this.notes = '',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'target_price': targetPrice,
        'priority': priority,
        'is_purchased': isPurchased ? 1 : 0,
        'notes': notes,
        'created_at': createdAt.toIso8601String(),
      };

  static WishlistItem fromMap(Map<String, dynamic> m) => WishlistItem(
        id: (m['id'] as String?) ?? '',
        name: (m['name'] as String?) ?? '',
        targetPrice: (m['target_price'] as num?)?.toDouble() ?? 0.0,
        priority: (m['priority'] as String?) ?? 'low',
        isPurchased: (m['is_purchased'] as int? ?? 0) == 1,
        notes: (m['notes'] as String?) ?? '',
        createdAt: m['created_at'] != null
            ? DateTime.parse(m['created_at'] as String)
            : DateTime.now(),
      );

  WishlistItem copyWith({
    String? name,
    double? targetPrice,
    String? priority,
    bool? isPurchased,
    String? notes,
  }) =>
      WishlistItem(
        id: id,
        name: name ?? this.name,
        targetPrice: targetPrice ?? this.targetPrice,
        priority: priority ?? this.priority,
        isPurchased: isPurchased ?? this.isPurchased,
        notes: notes ?? this.notes,
        createdAt: createdAt,
      );
}

/// A person with whom the user lends/borrows money. Acts like a lightweight
/// "account" that owns a history of [LendedMoney] entries. Not a real
/// [Account] — excluded from net-worth totals, transfer pickers, etc.
class LendedPerson {
  final String id;
  String name;
  int colorValue;
  String notes;
  DateTime createdAt;

  LendedPerson({
    required this.id,
    required this.name,
    required this.colorValue,
    this.notes = '',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'color_value': colorValue,
        'notes': notes,
        'created_at': createdAt.toIso8601String(),
      };

  static LendedPerson fromMap(Map<String, dynamic> m) => LendedPerson(
        id: (m['id'] as String?) ?? '',
        name: (m['name'] as String?) ?? 'Unknown',
        colorValue: (m['color_value'] as int?) ?? 0xFF6750A4,
        notes: (m['notes'] as String?) ?? '',
        createdAt: m['created_at'] != null
            ? DateTime.parse(m['created_at'] as String)
            : DateTime.now(),
      );

  LendedPerson copyWith({String? name, int? colorValue, String? notes}) =>
      LendedPerson(
        id: id,
        name: name ?? this.name,
        colorValue: colorValue ?? this.colorValue,
        notes: notes ?? this.notes,
        createdAt: createdAt,
      );
}

/// A single lend/borrow entry belonging to a [LendedPerson]. Multiple entries
/// per person form that person's ledger history, the same way [AppTransaction]
/// rows form an [Account]'s history.
class LendedMoney {
  final String id;
  String personId;
  double amount;
  String type; // lent|borrowed
  String? accountId;
  bool isSettled;
  DateTime date;
  DateTime? dueDate;
  String notes;
  bool reminderEnabled;

  /// Time of day for the reminder, 'HH:mm' format.
  String reminderTime;

  LendedMoney({
    required this.id,
    required this.personId,
    required this.amount,
    required this.type,
    this.accountId,
    this.isSettled = false,
    required this.date,
    this.dueDate,
    this.notes = '',
    this.reminderEnabled = false,
    this.reminderTime = '09:00',
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'person_id': personId,
        'amount': amount,
        'type': type,
        'account_id': accountId,
        'is_settled': isSettled ? 1 : 0,
        'date': date.toIso8601String(),
        'due_date': dueDate?.toIso8601String(),
        'notes': notes,
        'reminder_enabled': reminderEnabled ? 1 : 0,
        'reminder_time': reminderTime,
      };

  static LendedMoney fromMap(Map<String, dynamic> m) => LendedMoney(
        id: (m['id'] as String?) ?? '',
        personId: (m['person_id'] as String?) ?? '',
        amount: (m['amount'] as num?)?.toDouble() ?? 0.0,
        type: (m['type'] as String?) ?? 'lent',
        accountId: m['account_id'] as String?,
        isSettled: (m['is_settled'] as int? ?? 0) == 1,
        date: m['date'] != null
            ? DateTime.parse(m['date'] as String)
            : DateTime.now(),
        dueDate: m['due_date'] != null
            ? DateTime.parse(m['due_date'] as String)
            : null,
        notes: (m['notes'] as String?) ?? '',
        reminderEnabled: (m['reminder_enabled'] as int? ?? 0) == 1,
        reminderTime: (m['reminder_time'] as String?) ?? '09:00',
      );

  LendedMoney copyWith({
    String? personId,
    double? amount,
    String? type,
    String? accountId,
    bool? isSettled,
    DateTime? dueDate,
    String? notes,
    bool clearAccount = false,
    bool clearDueDate = false,
    bool? reminderEnabled,
    String? reminderTime,
  }) =>
      LendedMoney(
        id: id,
        personId: personId ?? this.personId,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        accountId: clearAccount ? null : (accountId ?? this.accountId),
        isSettled: isSettled ?? this.isSettled,
        date: date,
        dueDate: clearDueDate ? null : (dueDate ?? this.dueDate),
        notes: notes ?? this.notes,
        reminderEnabled: reminderEnabled ?? this.reminderEnabled,
        reminderTime: reminderTime ?? this.reminderTime,
      );
}

/// A single asset entry (product name + value).
class AssetItem {
  final String id;
  String name;
  double value;
  String currency;
  String notes;
  DateTime createdAt;

  AssetItem({
    required this.id,
    required this.name,
    required this.value,
    required this.currency,
    this.notes = '',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'value': value,
        'currency': currency,
        'notes': notes,
        'created_at': createdAt.toIso8601String(),
      };

  static AssetItem fromMap(Map<String, dynamic> m) => AssetItem(
        id: (m['id'] as String?) ?? '',
        name: (m['name'] as String?) ?? '',
        value: (m['value'] as num?)?.toDouble() ?? 0.0,
        currency: (m['currency'] as String?) ?? 'EGP',
        notes: (m['notes'] as String?) ?? '',
        createdAt: m['created_at'] != null
            ? DateTime.parse(m['created_at'] as String)
            : DateTime.now(),
      );

  AssetItem copyWith({
    String? name,
    double? value,
    String? currency,
    String? notes,
  }) =>
      AssetItem(
        id: id,
        name: name ?? this.name,
        value: value ?? this.value,
        currency: currency ?? this.currency,
        notes: notes ?? this.notes,
        createdAt: createdAt,
      );
}

// ── Budget ────────────────────────────────────────────────────────────────────
class Budget {
  final String id;
  final String categoryId;
  final double amount;
  final String period; // 'monthly' | 'weekly'
  final DateTime createdAt;

  const Budget({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.period,
    required this.createdAt,
  });

  Budget copyWith({String? categoryId, double? amount, String? period}) =>
      Budget(
        id: id,
        categoryId: categoryId ?? this.categoryId,
        amount: amount ?? this.amount,
        period: period ?? this.period,
        createdAt: createdAt,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'category_id': categoryId,
        'amount': amount,
        'period': period,
        'created_at': createdAt.toIso8601String(),
      };

  static Budget fromMap(Map<String, dynamic> m) => Budget(
        id: (m['id'] as String?) ?? '',
        categoryId: (m['category_id'] as String?) ?? '',
        amount: (m['amount'] as num?)?.toDouble() ?? 0.0,
        period: (m['period'] as String?) ?? 'monthly',
        createdAt: m['created_at'] != null
            ? DateTime.parse(m['created_at'] as String)
            : DateTime.now(),
      );
}

class NetWorthSnapshot {
  final String id;
  final String date; // yyyy-MM-dd
  final double totalAccounts;
  final double totalAssets;
  final double netWorth;
  final String currency;

  const NetWorthSnapshot({
    required this.id,
    required this.date,
    required this.totalAccounts,
    required this.totalAssets,
    required this.netWorth,
    required this.currency,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date,
        'total_accounts': totalAccounts,
        'total_assets': totalAssets,
        'net_worth': netWorth,
        'currency': currency,
      };

  static NetWorthSnapshot fromMap(Map<String, dynamic> m) => NetWorthSnapshot(
        id: (m['id'] as String?) ?? '',
        date: (m['date'] as String?) ?? '',
        totalAccounts: (m['total_accounts'] as num?)?.toDouble() ?? 0.0,
        totalAssets: (m['total_assets'] as num?)?.toDouble() ?? 0.0,
        netWorth: (m['net_worth'] as num?)?.toDouble() ?? 0.0,
        currency: (m['currency'] as String?) ?? 'EGP',
      );
}

// ── Recurring History Entry ────────────────────────────────────────────────────
class RecurringHistoryEntry {
  final String id;
  final String recurringId;
  final String action; // 'paid' | 'skipped'
  final DateTime date;
  final double amount;
  final String currency;

  const RecurringHistoryEntry({
    required this.id,
    required this.recurringId,
    required this.action,
    required this.date,
    required this.amount,
    required this.currency,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'recurring_id': recurringId,
        'action': action,
        'date': date.toIso8601String(),
        'amount': amount,
        'currency': currency,
      };

  static RecurringHistoryEntry fromMap(Map<String, dynamic> m) =>
      RecurringHistoryEntry(
        id: (m['id'] as String?) ?? '',
        recurringId: (m['recurring_id'] as String?) ?? '',
        action: (m['action'] as String?) ?? 'paid',
        date: m['date'] != null
            ? DateTime.parse(m['date'] as String)
            : DateTime.now(),
        amount: (m['amount'] as num?)?.toDouble() ?? 0.0,
        currency: (m['currency'] as String?) ?? 'EGP',
      );
}

// ── Savings Goal ──────────────────────────────────────────────────────────────
class SavingsGoal {
  final String id;
  String name;
  double targetAmount;
  double currentAmount;
  String currency;
  DateTime? targetDate;
  int colorValue;
  bool isCompleted;
  DateTime createdAt;
  DateTime? completedAt;

  SavingsGoal({
    required this.id,
    required this.name,
    required this.targetAmount,
    this.currentAmount = 0.0,
    required this.currency,
    this.targetDate,
    required this.colorValue,
    this.isCompleted = false,
    DateTime? createdAt,
    this.completedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'target_amount': targetAmount,
        'current_amount': currentAmount,
        'currency': currency,
        'target_date': targetDate?.toIso8601String(),
        'color_value': colorValue,
        'is_completed': isCompleted ? 1 : 0,
        'created_at': createdAt.toIso8601String(),
        'completed_at': completedAt?.toIso8601String(),
      };

  static SavingsGoal fromMap(Map<String, dynamic> m) => SavingsGoal(
        id: (m['id'] as String?) ?? '',
        name: (m['name'] as String?) ?? '',
        targetAmount: (m['target_amount'] as num?)?.toDouble() ?? 0.0,
        currentAmount: (m['current_amount'] as num?)?.toDouble() ?? 0.0,
        currency: (m['currency'] as String?) ?? 'EGP',
        targetDate: m['target_date'] != null
            ? DateTime.parse(m['target_date'] as String)
            : null,
        colorValue: (m['color_value'] as int?) ?? 0xFF6750A4,
        isCompleted: (m['is_completed'] as int? ?? 0) == 1,
        createdAt: m['created_at'] != null
            ? DateTime.parse(m['created_at'] as String)
            : DateTime.now(),
        completedAt: m['completed_at'] != null
            ? DateTime.parse(m['completed_at'] as String)
            : null,
      );

  SavingsGoal copyWith({
    String? name,
    double? targetAmount,
    double? currentAmount,
    String? currency,
    DateTime? targetDate,
    int? colorValue,
    bool? isCompleted,
    DateTime? completedAt,
    bool clearTargetDate = false,
    bool clearCompletedAt = false,
  }) =>
      SavingsGoal(
        id: id,
        name: name ?? this.name,
        targetAmount: targetAmount ?? this.targetAmount,
        currentAmount: currentAmount ?? this.currentAmount,
        currency: currency ?? this.currency,
        targetDate: clearTargetDate ? null : (targetDate ?? this.targetDate),
        colorValue: colorValue ?? this.colorValue,
        isCompleted: isCompleted ?? this.isCompleted,
        createdAt: createdAt,
        completedAt:
            clearCompletedAt ? null : (completedAt ?? this.completedAt),
      );
}

// ── Savings Contribution ──────────────────────────────────────────────────────
class SavingsContribution {
  final String id;
  String goalId;
  double amount;
  String accountId;
  String type; // 'contribution' | 'withdrawal'
  DateTime date;
  String note;

  SavingsContribution({
    required this.id,
    required this.goalId,
    required this.amount,
    required this.accountId,
    required this.type,
    required this.date,
    this.note = '',
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'goal_id': goalId,
        'amount': amount,
        'account_id': accountId,
        'type': type,
        'date': date.toIso8601String(),
        'note': note,
      };

  static SavingsContribution fromMap(Map<String, dynamic> m) =>
      SavingsContribution(
        id: (m['id'] as String?) ?? '',
        goalId: (m['goal_id'] as String?) ?? '',
        amount: (m['amount'] as num?)?.toDouble() ?? 0.0,
        accountId: (m['account_id'] as String?) ?? '',
        type: (m['type'] as String?) ?? 'contribution',
        date: m['date'] != null
            ? DateTime.parse(m['date'] as String)
            : DateTime.now(),
        note: (m['note'] as String?) ?? '',
      );

  SavingsContribution copyWith({
    String? goalId,
    double? amount,
    String? accountId,
    String? type,
    DateTime? date,
    String? note,
  }) =>
      SavingsContribution(
        id: id,
        goalId: goalId ?? this.goalId,
        amount: amount ?? this.amount,
        accountId: accountId ?? this.accountId,
        type: type ?? this.type,
        date: date ?? this.date,
        note: note ?? this.note,
      );
}

// ── Loans Models ─────────────────────────────────────────────────────────────

class Loan {
  final String id;
  String name;
  double principal;          // original loan amount
  String currency;
  DateTime startDate;
  DateTime endDate;           // duration is derived: endDate - startDate
  double? interestRate;       // annual %, nullable — optional field
  String? accountId;          // account the loan is tied to (nullable — "not linked")
  String? transferAccountId;  // account the loan principal is transferred to (nullable)
  bool reminderEnabled;
  int reminderDay;            // day-of-month (1-31) the payment is due
  String reminderTime;        // 'HH:mm'
  bool isSettled;             // manually markable "paid off" / or auto when totalPaid >= totalOwed
  String notes;
  DateTime createdAt;

  Loan({
    required this.id,
    required this.name,
    required this.principal,
    this.currency = 'EGP',
    required this.startDate,
    required this.endDate,
    this.interestRate,
    this.accountId,
    this.transferAccountId,
    this.reminderEnabled = false,
    this.reminderDay = 1,
    this.reminderTime = '09:00',
    this.isSettled = false,
    this.notes = '',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Whole months between start and end, minimum 1, so a same-month
  /// loan never divides by zero.
  int get durationMonths {
    final months =
        (endDate.year - startDate.year) * 12 + (endDate.month - startDate.month);
    return months < 1 ? 1 : months;
  }

  /// Simple/flat-interest total payable: principal + (principal * annualRate/100 * years).
  /// Only meaningful when interestRate != null.
  double get totalPayable {
    if (interestRate == null || interestRate == 0) return principal;
    final years = durationMonths / 12.0;
    final totalInterest = principal * (interestRate! / 100) * years;
    return principal + totalInterest;
  }

  double get monthlyPayment => totalPayable / durationMonths;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'principal': principal,
        'currency': currency,
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
        'interest_rate': interestRate,
        'account_id': accountId,
        'transfer_account_id': transferAccountId,
        'reminder_enabled': reminderEnabled ? 1 : 0,
        'reminder_day': reminderDay,
        'reminder_time': reminderTime,
        'is_settled': isSettled ? 1 : 0,
        'notes': notes,
        'created_at': createdAt.toIso8601String(),
      };

  static Loan fromMap(Map<String, dynamic> m) => Loan(
        id: (m['id'] as String?) ?? '',
        name: (m['name'] as String?) ?? '',
        principal: (m['principal'] as num?)?.toDouble() ?? 0.0,
        currency: (m['currency'] as String?) ?? 'EGP',
        startDate: m['start_date'] != null
            ? DateTime.parse(m['start_date'] as String)
            : DateTime.now(),
        endDate: m['end_date'] != null
            ? DateTime.parse(m['end_date'] as String)
            : DateTime.now(),
        interestRate: (m['interest_rate'] as num?)?.toDouble(),
        accountId: m['account_id'] as String?,
        transferAccountId: m['transfer_account_id'] as String?,
        reminderEnabled: (m['reminder_enabled'] as int? ?? 0) == 1,
        reminderDay: m['reminder_day'] as int? ?? 1,
        reminderTime: (m['reminder_time'] as String?) ?? '09:00',
        isSettled: (m['is_settled'] as int? ?? 0) == 1,
        notes: (m['notes'] as String?) ?? '',
        createdAt: m['created_at'] != null
            ? DateTime.parse(m['created_at'] as String)
            : DateTime.now(),
      );

  Loan copyWith({
    String? name,
    double? principal,
    String? currency,
    DateTime? startDate,
    DateTime? endDate,
    double? interestRate,
    String? accountId,
    String? transferAccountId,
    bool? reminderEnabled,
    int? reminderDay,
    String? reminderTime,
    bool? isSettled,
    String? notes,
    bool clearInterestRate = false,
    bool clearAccount = false,
    bool clearTransferAccount = false,
  }) => Loan(
        id: id,
        name: name ?? this.name,
        principal: principal ?? this.principal,
        currency: currency ?? this.currency,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        interestRate: clearInterestRate ? null : (interestRate ?? this.interestRate),
        accountId: clearAccount ? null : (accountId ?? this.accountId),
        transferAccountId: clearTransferAccount ? null : (transferAccountId ?? this.transferAccountId),
        reminderEnabled: reminderEnabled ?? this.reminderEnabled,
        reminderDay: reminderDay ?? this.reminderDay,
        reminderTime: reminderTime ?? this.reminderTime,
        isSettled: isSettled ?? this.isSettled,
        notes: notes ?? this.notes,
        createdAt: createdAt,
      );
}

class LoanPayment {
  final String id;
  final String loanId;
  final DateTime date;
  final double amount;
  final String currency;
  final String? accountId;   // account debited for this payment, if any
  final String notes;

  const LoanPayment({
    required this.id,
    required this.loanId,
    required this.date,
    required this.amount,
    required this.currency,
    this.accountId,
    this.notes = '',
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'loan_id': loanId,
        'date': date.toIso8601String(),
        'amount': amount,
        'currency': currency,
        'account_id': accountId,
        'notes': notes,
      };

  static LoanPayment fromMap(Map<String, dynamic> m) => LoanPayment(
        id: (m['id'] as String?) ?? '',
        loanId: (m['loan_id'] as String?) ?? '',
        date: m['date'] != null
            ? DateTime.parse(m['date'] as String)
            : DateTime.now(),
        amount: (m['amount'] as num?)?.toDouble() ?? 0.0,
        currency: (m['currency'] as String?) ?? 'EGP',
        accountId: m['account_id'] as String?,
        notes: (m['notes'] as String?) ?? '',
      );
}
