// lib/models/models.dart

class Account {
  final String id;
  String name;
  String type;        // bank|cash|savings|credit|wallet|gold
  double balance;
  String currency;
  int    colorValue;
  bool   excludeFromTotal;
  DateTime createdAt;
  // Gold-specific fields (null for non-gold accounts)
  final int?    goldKarat;  // 24, 22, 21, 18, 14, 10, 9
  final double? goldGrams;

  Account({
    required this.id,
    required this.name,
    required this.type,
    required this.balance,
    this.currency = 'EGP',
    required this.colorValue,
    this.excludeFromTotal = false,
    DateTime? createdAt,
    this.goldKarat,
    this.goldGrams,
  }) : createdAt = createdAt ?? DateTime.now();

  /// True when this account tracks a physical gold holding.
  bool get isGold => type == 'gold';

  Map<String, dynamic> toMap() => {
    'id': id, 'name': name, 'type': type, 'balance': balance,
    'currency': currency, 'color_value': colorValue,
    'exclude_from_total': excludeFromTotal ? 1 : 0,
    'created_at': createdAt.toIso8601String(),
    'gold_karat': goldKarat,
    'gold_grams': goldGrams,
  };

  static Account fromMap(Map<String, dynamic> m) => Account(
    id: m['id'] as String, name: m['name'] as String,
    type: m['type'] as String, balance: (m['balance'] as num).toDouble(),
    currency: (m['currency'] as String?) ?? 'EGP',
    colorValue: m['color_value'] as int,
    excludeFromTotal: (m['exclude_from_total'] as int? ?? 0) == 1,
    createdAt: DateTime.parse(m['created_at'] as String),
    goldKarat: m['gold_karat'] as int?,
    goldGrams: (m['gold_grams'] as num?)?.toDouble(),
  );

  Account copyWith({
    String? name, String? type, double? balance,
    String? currency, int? colorValue, bool? excludeFromTotal,
    int? goldKarat, double? goldGrams,
    bool clearGold = false,
  }) => Account(
    id: id, name: name ?? this.name, type: type ?? this.type,
    balance: balance ?? this.balance, currency: currency ?? this.currency,
    colorValue: colorValue ?? this.colorValue,
    excludeFromTotal: excludeFromTotal ?? this.excludeFromTotal,
    createdAt: createdAt,
    goldKarat: clearGold ? null : (goldKarat ?? this.goldKarat),
    goldGrams: clearGold ? null : (goldGrams ?? this.goldGrams),
  );
}

class AppCategory {
  final String id;
  String name;
  String type;        // income|expense
  int    colorValue;
  /// Code point of the icon (Icons.xxx.codePoint). 0 = use name-based default.
  int    iconCodePoint;

  AppCategory({required this.id, required this.name,
               required this.type, required this.colorValue,
               this.iconCodePoint = 0});

  Map<String, dynamic> toMap() => {
    'id': id, 'name': name, 'type': type,
    'color_value': colorValue, 'icon_code_point': iconCodePoint,
  };

  static AppCategory fromMap(Map<String, dynamic> m) => AppCategory(
    id: m['id'] as String, name: m['name'] as String,
    type: m['type'] as String, colorValue: m['color_value'] as int,
    iconCodePoint: m['icon_code_point'] as int? ?? 0,
  );

  AppCategory copyWith({String? name, int? colorValue, int? iconCodePoint}) =>
      AppCategory(id: id, name: name ?? this.name,
                  type: type, colorValue: colorValue ?? this.colorValue,
                  iconCodePoint: iconCodePoint ?? this.iconCodePoint);
}

class AppTransaction {
  final String id;
  String type;        // income|expense
  double amount;
  String description;
  String accountId;
  String categoryId;
  DateTime date;
  String note;
  /// Currency the amount was entered in. Empty string = same as account currency.
  String currency;

  AppTransaction({
    required this.id, required this.type, required this.amount,
    required this.description, required this.accountId,
    required this.categoryId, required this.date, this.note = '',
    this.currency = '',
  });

  Map<String, dynamic> toMap() => {
    'id': id, 'type': type, 'amount': amount,
    'description': description, 'account_id': accountId,
    'category_id': categoryId, 'date': date.toIso8601String(),
    'note': note, 'currency': currency,
  };

  static AppTransaction fromMap(Map<String, dynamic> m) => AppTransaction(
    id: m['id'] as String, type: m['type'] as String,
    amount: (m['amount'] as num).toDouble(),
    description: m['description'] as String,
    accountId: m['account_id'] as String,
    categoryId: m['category_id'] as String,
    date: DateTime.parse(m['date'] as String),
    note: (m['note'] as String?) ?? '',
    currency: (m['currency'] as String?) ?? '',
  );

  AppTransaction copyWith({
    String? type, double? amount, String? description,
    String? accountId, String? categoryId, DateTime? date,
    String? note, String? currency,
  }) => AppTransaction(
    id: id, type: type ?? this.type, amount: amount ?? this.amount,
    description: description ?? this.description,
    accountId: accountId ?? this.accountId,
    categoryId: categoryId ?? this.categoryId,
    date: date ?? this.date, note: note ?? this.note,
    currency: currency ?? this.currency,
  );
}

class RecurringPayment {
  final String id;
  String name;
  String accountId;
  String categoryId;
  double amount;
  String paymentType;   // expense|income
  int    freqVal;
  String freqUnit;      // days|weeks|months|years
  DateTime startDate;   // first payment
  DateTime nextDate;
  DateTime? endDate;    // last payment (null = ongoing)
  int    paidPayments;
  bool   reminderEnabled;
  /// Time of day for the reminder in 'HH:mm' format, e.g. '09:00'.
  String reminderTime;
  /// When true, an additional notification fires 2 days before [nextDate]
  /// at the same [reminderTime]. Only meaningful when [reminderEnabled] is true.
  bool   earlyReminderEnabled;
  String notes;

  RecurringPayment({
    required this.id, required this.name,
    required this.accountId, required this.categoryId,
    required this.amount, this.paymentType = 'expense',
    required this.freqVal, required this.freqUnit,
    required this.startDate, required this.nextDate,
    this.endDate, this.paidPayments = 0,
    this.reminderEnabled = false,
    this.reminderTime = '09:00',
    this.earlyReminderEnabled = false,
    this.notes = '',
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
  double get totalAmount     => (totalPayments     ?? 0) * amount;

  String get frequencyLabel {
    if (freqVal == 1) {
      switch (freqUnit) {
        case 'days':   return 'Daily';
        case 'weeks':  return 'Weekly';
        case 'months': return 'Monthly';
        case 'years':  return 'Yearly';
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
        final day = nextDate.day.clamp(1,
            DateTime(y, mon + 1, 0).day);
        return DateTime(y, mon, day);
      case 'years':
        return DateTime(nextDate.year + freqVal, nextDate.month, nextDate.day);
      default:
        return nextDate.add(Duration(days: freqVal * 30));
    }
  }

  Map<String, dynamic> toMap() => {
    'id': id, 'name': name, 'account_id': accountId,
    'category_id': categoryId, 'amount': amount,
    'payment_type': paymentType, 'freq_val': freqVal, 'freq_unit': freqUnit,
    'start_date': startDate.toIso8601String(),
    'next_date': nextDate.toIso8601String(),
    'end_date': endDate?.toIso8601String(),
    'paid_payments': paidPayments,
    'reminder_enabled': reminderEnabled ? 1 : 0,
    'reminder_time': reminderTime,
    'early_reminder_enabled': earlyReminderEnabled ? 1 : 0,
    'notes': notes,
  };

  static RecurringPayment fromMap(Map<String, dynamic> m) => RecurringPayment(
    id: m['id'] as String, name: m['name'] as String,
    accountId: m['account_id'] as String,
    categoryId: m['category_id'] as String,
    amount: (m['amount'] as num).toDouble(),
    paymentType: (m['payment_type'] as String?) ?? 'expense',
    freqVal: m['freq_val'] as int,
    freqUnit: m['freq_unit'] as String,
    startDate: DateTime.parse(m['start_date'] as String),
    nextDate: DateTime.parse(m['next_date'] as String),
    endDate: m['end_date'] != null
        ? DateTime.parse(m['end_date'] as String) : null,
    paidPayments: m['paid_payments'] as int? ?? 0,
    reminderEnabled: (m['reminder_enabled'] as int? ?? 0) == 1,
    reminderTime: (m['reminder_time'] as String?) ?? '09:00',
    earlyReminderEnabled: (m['early_reminder_enabled'] as int? ?? 0) == 1,
    notes: (m['notes'] as String?) ?? '',
  );
}

class WishlistItem {
  final String id;
  String name;
  double targetPrice;
  String priority;    // low|medium|high
  bool   isPurchased;
  String notes;
  DateTime createdAt;

  WishlistItem({
    required this.id, required this.name, required this.targetPrice,
    required this.priority, this.isPurchased = false,
    this.notes = '', DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
    'id': id, 'name': name, 'target_price': targetPrice,
    'priority': priority, 'is_purchased': isPurchased ? 1 : 0,
    'notes': notes, 'created_at': createdAt.toIso8601String(),
  };

  static WishlistItem fromMap(Map<String, dynamic> m) => WishlistItem(
    id: m['id'] as String, name: m['name'] as String,
    targetPrice: (m['target_price'] as num).toDouble(),
    priority: m['priority'] as String,
    isPurchased: (m['is_purchased'] as int? ?? 0) == 1,
    notes: (m['notes'] as String?) ?? '',
    createdAt: DateTime.parse(m['created_at'] as String),
  );

  WishlistItem copyWith({
    String? name, double? targetPrice, String? priority,
    bool? isPurchased, String? notes,
  }) => WishlistItem(
    id: id, name: name ?? this.name,
    targetPrice: targetPrice ?? this.targetPrice,
    priority: priority ?? this.priority,
    isPurchased: isPurchased ?? this.isPurchased,
    notes: notes ?? this.notes, createdAt: createdAt,
  );
}

/// A person with whom the user lends/borrows money. Acts like a lightweight
/// "account" that owns a history of [LendedMoney] entries. Not a real
/// [Account] — excluded from net-worth totals, transfer pickers, etc.
class LendedPerson {
  final String id;
  String name;
  int    colorValue;
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
    'id': id, 'name': name, 'color_value': colorValue,
    'notes': notes, 'created_at': createdAt.toIso8601String(),
  };

  static LendedPerson fromMap(Map<String, dynamic> m) => LendedPerson(
    id: m['id'] as String,
    name: m['name'] as String,
    colorValue: (m['color_value'] as int?) ?? 0xFF6750A4,
    notes: (m['notes'] as String?) ?? '',
    createdAt: DateTime.parse(m['created_at'] as String),
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
  String type;         // lent|borrowed
  String? accountId;
  bool   isSettled;
  DateTime date;
  DateTime? dueDate;
  String notes;
  bool   reminderEnabled;
  /// Time of day for the reminder, 'HH:mm' format.
  String reminderTime;

  LendedMoney({
    required this.id, required this.personId, required this.amount,
    required this.type, this.accountId, this.isSettled = false,
    required this.date, this.dueDate, this.notes = '',
    this.reminderEnabled = false,
    this.reminderTime = '09:00',
  });

  Map<String, dynamic> toMap() => {
    'id': id, 'person_id': personId, 'amount': amount, 'type': type,
    'account_id': accountId, 'is_settled': isSettled ? 1 : 0,
    'date': date.toIso8601String(),
    'due_date': dueDate?.toIso8601String(),
    'notes': notes,
    'reminder_enabled': reminderEnabled ? 1 : 0,
    'reminder_time': reminderTime,
  };

  static LendedMoney fromMap(Map<String, dynamic> m) => LendedMoney(
    id: m['id'] as String, personId: m['person_id'] as String,
    amount: (m['amount'] as num).toDouble(), type: m['type'] as String,
    accountId: m['account_id'] as String?,
    isSettled: (m['is_settled'] as int? ?? 0) == 1,
    date: DateTime.parse(m['date'] as String),
    dueDate: m['due_date'] != null
        ? DateTime.parse(m['due_date'] as String) : null,
    notes: (m['notes'] as String?) ?? '',
    reminderEnabled: (m['reminder_enabled'] as int? ?? 0) == 1,
    reminderTime: (m['reminder_time'] as String?) ?? '09:00',
  );

  LendedMoney copyWith({
    String? personId, double? amount, String? type,
    String? accountId, bool? isSettled, DateTime? dueDate, String? notes,
    bool clearAccount = false,
    bool clearDueDate = false,
    bool? reminderEnabled, String? reminderTime,
  }) => LendedMoney(
    id: id, personId: personId ?? this.personId,
    amount: amount ?? this.amount, type: type ?? this.type,
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
    'id': id, 'name': name, 'value': value, 'currency': currency,
    'notes': notes, 'created_at': createdAt.toIso8601String(),
  };

  static AssetItem fromMap(Map<String, dynamic> m) => AssetItem(
    id: m['id'] as String,
    name: m['name'] as String,
    value: (m['value'] as num).toDouble(),
    currency: (m['currency'] as String?) ?? 'EGP',
    notes: (m['notes'] as String?) ?? '',
    createdAt: DateTime.parse(m['created_at'] as String),
  );

  AssetItem copyWith({
    String? name, double? value, String? currency, String? notes,
  }) => AssetItem(
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
  final String period;    // 'monthly' | 'weekly'
  final DateTime createdAt;

  const Budget({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.period,
    required this.createdAt,
  });

  Budget copyWith({String? categoryId, double? amount, String? period}) => Budget(
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
    id: m['id'] as String,
    categoryId: m['category_id'] as String,
    amount: (m['amount'] as num).toDouble(),
    period: (m['period'] as String?) ?? 'monthly',
    createdAt: DateTime.parse(m['created_at'] as String),
  );
}

// ── Recurring History Entry ────────────────────────────────────────────────────
class RecurringHistoryEntry {
  final String id;
  final String recurringId;
  final String action;    // 'paid' | 'skipped'
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
        id: m['id'] as String,
        recurringId: m['recurring_id'] as String,
        action: m['action'] as String,
        date: DateTime.parse(m['date'] as String),
        amount: (m['amount'] as num).toDouble(),
        currency: m['currency'] as String,
      );
}
