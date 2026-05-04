// lib/models/models.dart

// ─── ACCOUNT ──────────────────────────────────────────────────────────────
class Account {
  final String id;
  String name;
  String type; // bank | cash | savings | credit | wallet
  double balance;
  String currency;
  int colorValue;
  DateTime createdAt;

  Account({
    required this.id,
    required this.name,
    required this.type,
    required this.balance,
    this.currency = 'EGP',
    required this.colorValue,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'type': type,
        'balance': balance,
        'currency': currency,
        'color_value': colorValue,
        'created_at': createdAt.toIso8601String(),
      };

  factory Account.fromMap(Map<String, dynamic> m) => Account(
        id: m['id'] as String,
        name: m['name'] as String,
        type: m['type'] as String,
        balance: (m['balance'] as num).toDouble(),
        currency: m['currency'] as String? ?? 'EGP',
        colorValue: m['color_value'] as int,
        createdAt: DateTime.parse(m['created_at'] as String),
      );

  Account copyWith({
    String? name,
    String? type,
    double? balance,
    String? currency,
    int? colorValue,
  }) =>
      Account(
        id: id,
        name: name ?? this.name,
        type: type ?? this.type,
        balance: balance ?? this.balance,
        currency: currency ?? this.currency,
        colorValue: colorValue ?? this.colorValue,
        createdAt: createdAt,
      );
}

// ─── CATEGORY ─────────────────────────────────────────────────────────────
class Category {
  final String id;
  String name;
  String type; // income | expense
  int colorValue;
  bool isDefault;

  Category({
    required this.id,
    required this.name,
    required this.type,
    required this.colorValue,
    this.isDefault = false,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'type': type,
        'color_value': colorValue,
        'is_default': isDefault ? 1 : 0,
      };

  factory Category.fromMap(Map<String, dynamic> m) => Category(
        id: m['id'] as String,
        name: m['name'] as String,
        type: m['type'] as String,
        colorValue: m['color_value'] as int,
        isDefault: (m['is_default'] as int? ?? 0) == 1,
      );

  Category copyWith({String? name, int? colorValue}) => Category(
        id: id,
        name: name ?? this.name,
        type: type,
        colorValue: colorValue ?? this.colorValue,
        isDefault: isDefault,
      );
}

// ─── TRANSACTION ──────────────────────────────────────────────────────────
class Transaction {
  final String id;
  String accountId;
  String categoryId;
  double amount;
  String type; // income | expense
  String description;
  DateTime date;
  String note;

  Transaction({
    required this.id,
    required this.accountId,
    required this.categoryId,
    required this.amount,
    required this.type,
    required this.description,
    required this.date,
    this.note = '',
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'account_id': accountId,
        'category_id': categoryId,
        'amount': amount,
        'type': type,
        'description': description,
        'date': date.toIso8601String(),
        'note': note,
      };

  factory Transaction.fromMap(Map<String, dynamic> m) => Transaction(
        id: m['id'] as String,
        accountId: m['account_id'] as String,
        categoryId: m['category_id'] as String,
        amount: (m['amount'] as num).toDouble(),
        type: m['type'] as String,
        description: m['description'] as String,
        date: DateTime.parse(m['date'] as String),
        note: m['note'] as String? ?? '',
      );

  Transaction copyWith({
    String? accountId,
    String? categoryId,
    double? amount,
    String? type,
    String? description,
    DateTime? date,
    String? note,
  }) =>
      Transaction(
        id: id,
        accountId: accountId ?? this.accountId,
        categoryId: categoryId ?? this.categoryId,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        description: description ?? this.description,
        date: date ?? this.date,
        note: note ?? this.note,
      );
}

// ─── RECURRING PAYMENT ────────────────────────────────────────────────────
class RecurringPayment {
  final String id;
  String name;
  String accountId;
  String categoryId;
  double amount;
  int freqVal;
  String freqUnit; // days | weeks | months | years
  DateTime startDate;
  DateTime nextDate;
  DateTime? endDate;
  int paidPayments;
  bool reminderEnabled;
  String notes;

  RecurringPayment({
    required this.id,
    required this.name,
    required this.accountId,
    required this.categoryId,
    required this.amount,
    required this.freqVal,
    required this.freqUnit,
    required this.startDate,
    required this.nextDate,
    this.endDate,
    this.paidPayments = 0,
    this.reminderEnabled = true,
    this.notes = '',
  });

  // Total payments = exact count from first payment to last payment (inclusive).
  // Example: monthly, first=Jan, last=Dec → 12 payments.
  int? get totalPayments {
    if (endDate == null) return null;
    return _countPayments(startDate, endDate!, freqVal, freqUnit);
  }

  // Remaining = total - already paid
  int? get remainingPayments {
    if (endDate == null) return null;
    final total = totalPayments ?? 0;
    final remaining = total - paidPayments;
    return remaining < 0 ? 0 : remaining;
  }

  double get remainingAmount => (remainingPayments ?? 0) * amount;

  // Total cost = number of payments × amount per payment
  double get totalAmount => (totalPayments ?? 0) * amount;

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

  /// Count the number of payment occurrences from [first] to [last] inclusive.
  /// First payment is on [first], then every freqVal units, last on or before [last].
  static int _countPayments(
      DateTime first, DateTime last, int freqVal, String freqUnit) {
    if (last.isBefore(first)) return 0;
    switch (freqUnit) {
      case 'days':
        final diff = last.difference(first).inDays;
        return (diff / freqVal).floor() + 1;
      case 'weeks':
        final diff = last.difference(first).inDays;
        return (diff / (freqVal * 7)).floor() + 1;
      case 'months':
        final months = (last.year - first.year) * 12 + (last.month - first.month);
        return (months / freqVal).floor() + 1;
      case 'years':
        final years = last.year - first.year;
        return (years / freqVal).floor() + 1;
      default:
        final months = (last.year - first.year) * 12 + (last.month - first.month);
        return (months / freqVal).floor() + 1;
    }
  }

  DateTime calcNextDate() {
    switch (freqUnit) {
      case 'days':   return nextDate.add(Duration(days: freqVal));
      case 'weeks':  return nextDate.add(Duration(days: freqVal * 7));
      case 'months': return DateTime(nextDate.year, nextDate.month + freqVal, nextDate.day);
      case 'years':  return DateTime(nextDate.year + freqVal, nextDate.month, nextDate.day);
      default:       return DateTime(nextDate.year, nextDate.month + freqVal, nextDate.day);
    }
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'account_id': accountId,
        'category_id': categoryId,
        'amount': amount,
        'freq_val': freqVal,
        'freq_unit': freqUnit,
        'start_date': startDate.toIso8601String(),
        'next_date': nextDate.toIso8601String(),
        'end_date': endDate?.toIso8601String(),
        'paid_payments': paidPayments,
        'reminder_enabled': reminderEnabled ? 1 : 0,
        'notes': notes,
      };

  factory RecurringPayment.fromMap(Map<String, dynamic> m) => RecurringPayment(
        id: m['id'] as String,
        name: m['name'] as String,
        accountId: m['account_id'] as String,
        categoryId: m['category_id'] as String,
        amount: (m['amount'] as num).toDouble(),
        freqVal: m['freq_val'] as int? ?? 1,
        freqUnit: m['freq_unit'] as String? ?? 'months',
        startDate: DateTime.parse(m['start_date'] as String),
        nextDate: DateTime.parse(m['next_date'] as String),
        endDate: m['end_date'] != null ? DateTime.parse(m['end_date'] as String) : null,
        paidPayments: m['paid_payments'] as int? ?? 0,
        reminderEnabled: (m['reminder_enabled'] as int? ?? 1) == 1,
        notes: m['notes'] as String? ?? '',
      );
}

// ─── WISHLIST ITEM ────────────────────────────────────────────────────────
class WishlistItem {
  final String id;
  String name;
  double price;
  String priority; // low | medium | high
  String notes;
  bool isPurchased;
  DateTime createdAt;

  WishlistItem({
    required this.id,
    required this.name,
    required this.price,
    required this.priority,
    this.notes = '',
    this.isPurchased = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'priority': priority,
        'notes': notes,
        'is_purchased': isPurchased ? 1 : 0,
        'created_at': createdAt.toIso8601String(),
      };

  factory WishlistItem.fromMap(Map<String, dynamic> m) => WishlistItem(
        id: m['id'] as String,
        name: m['name'] as String,
        price: (m['price'] as num).toDouble(),
        priority: m['priority'] as String,
        notes: m['notes'] as String? ?? '',
        isPurchased: (m['is_purchased'] as int? ?? 0) == 1,
        createdAt: DateTime.parse(m['created_at'] as String),
      );

  WishlistItem copyWith({
    String? name,
    double? price,
    String? priority,
    String? notes,
    bool? isPurchased,
  }) =>
      WishlistItem(
        id: id,
        name: name ?? this.name,
        price: price ?? this.price,
        priority: priority ?? this.priority,
        notes: notes ?? this.notes,
        isPurchased: isPurchased ?? this.isPurchased,
        createdAt: createdAt,
      );
}

// ─── LENT MONEY ───────────────────────────────────────────────────────────
class LendedMoney {
  final String id;
  String personName;
  double amount;
  String type;       // lent (I lent to them) | borrowed (I borrowed from them)
  String? accountId; // which account was affected
  DateTime date;
  DateTime? dueDate;
  String notes;
  bool isSettled;

  LendedMoney({
    required this.id,
    required this.personName,
    required this.amount,
    required this.type,
    this.accountId,
    required this.date,
    this.dueDate,
    this.notes = '',
    this.isSettled = false,
  });

  bool get isOverdue =>
      dueDate != null && !isSettled && dueDate!.isBefore(DateTime.now());

  Map<String, dynamic> toMap() => {
        'id': id,
        'person_name': personName,
        'amount': amount,
        'type': type,
        'account_id': accountId,
        'date': date.toIso8601String(),
        'due_date': dueDate?.toIso8601String(),
        'notes': notes,
        'is_settled': isSettled ? 1 : 0,
      };

  factory LendedMoney.fromMap(Map<String, dynamic> m) => LendedMoney(
        id: m['id'] as String,
        personName: m['person_name'] as String,
        amount: (m['amount'] as num).toDouble(),
        type: m['type'] as String,
        accountId: m['account_id'] as String?,
        date: DateTime.parse(m['date'] as String),
        dueDate: m['due_date'] != null ? DateTime.parse(m['due_date'] as String) : null,
        notes: m['notes'] as String? ?? '',
        isSettled: (m['is_settled'] as int? ?? 0) == 1,
      );

  LendedMoney copyWith({
    String? personName,
    double? amount,
    String? type,
    Object? accountId = _sentinel,
    DateTime? dueDate,
    String? notes,
    bool? isSettled,
  }) =>
      LendedMoney(
        id: id,
        personName: personName ?? this.personName,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        accountId: accountId == _sentinel ? this.accountId : accountId as String?,
        date: date,
        dueDate: dueDate ?? this.dueDate,
        notes: notes ?? this.notes,
        isSettled: isSettled ?? this.isSettled,
      );
}

const _sentinel = Object();
