// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AccountsTable extends Accounts
    with TableInfo<$AccountsTable, AccountEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _balanceMeta =
      const VerificationMeta('balance');
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
      'balance', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('EGP'));
  static const VerificationMeta _colorValueMeta =
      const VerificationMeta('colorValue');
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
      'color_value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _excludeFromTotalMeta =
      const VerificationMeta('excludeFromTotal');
  @override
  late final GeneratedColumn<int> excludeFromTotal = GeneratedColumn<int>(
      'exclude_from_total', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _goldKaratMeta =
      const VerificationMeta('goldKarat');
  @override
  late final GeneratedColumn<int> goldKarat = GeneratedColumn<int>(
      'gold_karat', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _goldGramsMeta =
      const VerificationMeta('goldGrams');
  @override
  late final GeneratedColumn<double> goldGrams = GeneratedColumn<double>(
      'gold_grams', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _cardHolderNameMeta =
      const VerificationMeta('cardHolderName');
  @override
  late final GeneratedColumn<String> cardHolderName = GeneratedColumn<String>(
      'card_holder_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cardNumberLast4Meta =
      const VerificationMeta('cardNumberLast4');
  @override
  late final GeneratedColumn<String> cardNumberLast4 = GeneratedColumn<String>(
      'card_number_last4', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cardExpiryMeta =
      const VerificationMeta('cardExpiry');
  @override
  late final GeneratedColumn<String> cardExpiry = GeneratedColumn<String>(
      'card_expiry', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statementDayMeta =
      const VerificationMeta('statementDay');
  @override
  late final GeneratedColumn<int> statementDay = GeneratedColumn<int>(
      'statement_day', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _dueDayMeta = const VerificationMeta('dueDay');
  @override
  late final GeneratedColumn<int> dueDay = GeneratedColumn<int>(
      'due_day', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _creditLimitMeta =
      const VerificationMeta('creditLimit');
  @override
  late final GeneratedColumn<double> creditLimit = GeneratedColumn<double>(
      'credit_limit', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _minPaymentAmountMeta =
      const VerificationMeta('minPaymentAmount');
  @override
  late final GeneratedColumn<double> minPaymentAmount = GeneratedColumn<double>(
      'min_payment_amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _minPaymentPercentMeta =
      const VerificationMeta('minPaymentPercent');
  @override
  late final GeneratedColumn<double> minPaymentPercent =
      GeneratedColumn<double>('min_payment_percent', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _creditReminderEnabledMeta =
      const VerificationMeta('creditReminderEnabled');
  @override
  late final GeneratedColumn<int> creditReminderEnabled = GeneratedColumn<int>(
      'credit_reminder_enabled', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _creditReminderTimeMeta =
      const VerificationMeta('creditReminderTime');
  @override
  late final GeneratedColumn<String> creditReminderTime =
      GeneratedColumn<String>('credit_reminder_time', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('09:00'));
  static const VerificationMeta _creditEarlyReminderEnabledMeta =
      const VerificationMeta('creditEarlyReminderEnabled');
  @override
  late final GeneratedColumn<int> creditEarlyReminderEnabled =
      GeneratedColumn<int>('credit_early_reminder_enabled', aliasedName, true,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _linkedAccountIdMeta =
      const VerificationMeta('linkedAccountId');
  @override
  late final GeneratedColumn<String> linkedAccountId = GeneratedColumn<String>(
      'linked_account_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _excludeFromBankTotalMeta =
      const VerificationMeta('excludeFromBankTotal');
  @override
  late final GeneratedColumn<int> excludeFromBankTotal = GeneratedColumn<int>(
      'exclude_from_bank_total', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _dontLinkToCardMeta =
      const VerificationMeta('dontLinkToCard');
  @override
  late final GeneratedColumn<int> dontLinkToCard = GeneratedColumn<int>(
      'dont_link_to_card', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        type,
        balance,
        currency,
        colorValue,
        excludeFromTotal,
        createdAt,
        goldKarat,
        goldGrams,
        cardHolderName,
        cardNumberLast4,
        cardExpiry,
        statementDay,
        dueDay,
        creditLimit,
        minPaymentAmount,
        minPaymentPercent,
        creditReminderEnabled,
        creditReminderTime,
        creditEarlyReminderEnabled,
        linkedAccountId,
        orderIndex,
        excludeFromBankTotal,
        dontLinkToCard
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(Insertable<AccountEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(_balanceMeta,
          balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta));
    } else if (isInserting) {
      context.missing(_balanceMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    if (data.containsKey('color_value')) {
      context.handle(
          _colorValueMeta,
          colorValue.isAcceptableOrUnknown(
              data['color_value']!, _colorValueMeta));
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    if (data.containsKey('exclude_from_total')) {
      context.handle(
          _excludeFromTotalMeta,
          excludeFromTotal.isAcceptableOrUnknown(
              data['exclude_from_total']!, _excludeFromTotalMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('gold_karat')) {
      context.handle(_goldKaratMeta,
          goldKarat.isAcceptableOrUnknown(data['gold_karat']!, _goldKaratMeta));
    }
    if (data.containsKey('gold_grams')) {
      context.handle(_goldGramsMeta,
          goldGrams.isAcceptableOrUnknown(data['gold_grams']!, _goldGramsMeta));
    }
    if (data.containsKey('card_holder_name')) {
      context.handle(
          _cardHolderNameMeta,
          cardHolderName.isAcceptableOrUnknown(
              data['card_holder_name']!, _cardHolderNameMeta));
    }
    if (data.containsKey('card_number_last4')) {
      context.handle(
          _cardNumberLast4Meta,
          cardNumberLast4.isAcceptableOrUnknown(
              data['card_number_last4']!, _cardNumberLast4Meta));
    }
    if (data.containsKey('card_expiry')) {
      context.handle(
          _cardExpiryMeta,
          cardExpiry.isAcceptableOrUnknown(
              data['card_expiry']!, _cardExpiryMeta));
    }
    if (data.containsKey('statement_day')) {
      context.handle(
          _statementDayMeta,
          statementDay.isAcceptableOrUnknown(
              data['statement_day']!, _statementDayMeta));
    }
    if (data.containsKey('due_day')) {
      context.handle(_dueDayMeta,
          dueDay.isAcceptableOrUnknown(data['due_day']!, _dueDayMeta));
    }
    if (data.containsKey('credit_limit')) {
      context.handle(
          _creditLimitMeta,
          creditLimit.isAcceptableOrUnknown(
              data['credit_limit']!, _creditLimitMeta));
    }
    if (data.containsKey('min_payment_amount')) {
      context.handle(
          _minPaymentAmountMeta,
          minPaymentAmount.isAcceptableOrUnknown(
              data['min_payment_amount']!, _minPaymentAmountMeta));
    }
    if (data.containsKey('min_payment_percent')) {
      context.handle(
          _minPaymentPercentMeta,
          minPaymentPercent.isAcceptableOrUnknown(
              data['min_payment_percent']!, _minPaymentPercentMeta));
    }
    if (data.containsKey('credit_reminder_enabled')) {
      context.handle(
          _creditReminderEnabledMeta,
          creditReminderEnabled.isAcceptableOrUnknown(
              data['credit_reminder_enabled']!, _creditReminderEnabledMeta));
    }
    if (data.containsKey('credit_reminder_time')) {
      context.handle(
          _creditReminderTimeMeta,
          creditReminderTime.isAcceptableOrUnknown(
              data['credit_reminder_time']!, _creditReminderTimeMeta));
    }
    if (data.containsKey('credit_early_reminder_enabled')) {
      context.handle(
          _creditEarlyReminderEnabledMeta,
          creditEarlyReminderEnabled.isAcceptableOrUnknown(
              data['credit_early_reminder_enabled']!,
              _creditEarlyReminderEnabledMeta));
    }
    if (data.containsKey('linked_account_id')) {
      context.handle(
          _linkedAccountIdMeta,
          linkedAccountId.isAcceptableOrUnknown(
              data['linked_account_id']!, _linkedAccountIdMeta));
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    }
    if (data.containsKey('exclude_from_bank_total')) {
      context.handle(
          _excludeFromBankTotalMeta,
          excludeFromBankTotal.isAcceptableOrUnknown(
              data['exclude_from_bank_total']!, _excludeFromBankTotalMeta));
    }
    if (data.containsKey('dont_link_to_card')) {
      context.handle(
          _dontLinkToCardMeta,
          dontLinkToCard.isAcceptableOrUnknown(
              data['dont_link_to_card']!, _dontLinkToCardMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      balance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}balance'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      colorValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color_value'])!,
      excludeFromTotal: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}exclude_from_total'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      goldKarat: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gold_karat']),
      goldGrams: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}gold_grams']),
      cardHolderName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}card_holder_name']),
      cardNumberLast4: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}card_number_last4']),
      cardExpiry: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}card_expiry']),
      statementDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}statement_day']),
      dueDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}due_day']),
      creditLimit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}credit_limit']),
      minPaymentAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}min_payment_amount']),
      minPaymentPercent: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}min_payment_percent']),
      creditReminderEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}credit_reminder_enabled'])!,
      creditReminderTime: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}credit_reminder_time']),
      creditEarlyReminderEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}credit_early_reminder_enabled']),
      linkedAccountId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}linked_account_id']),
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index']),
      excludeFromBankTotal: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}exclude_from_bank_total'])!,
      dontLinkToCard: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dont_link_to_card'])!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class AccountEntry extends DataClass implements Insertable<AccountEntry> {
  final String id;
  final String name;
  final String type;
  final double balance;
  final String currency;
  final int colorValue;
  final int excludeFromTotal;
  final String createdAt;
  final int? goldKarat;
  final double? goldGrams;
  final String? cardHolderName;
  final String? cardNumberLast4;
  final String? cardExpiry;
  final int? statementDay;
  final int? dueDay;
  final double? creditLimit;
  final double? minPaymentAmount;
  final double? minPaymentPercent;
  final int creditReminderEnabled;
  final String? creditReminderTime;
  final int? creditEarlyReminderEnabled;
  final String? linkedAccountId;
  final int? orderIndex;
  final int excludeFromBankTotal;
  final int dontLinkToCard;
  const AccountEntry(
      {required this.id,
      required this.name,
      required this.type,
      required this.balance,
      required this.currency,
      required this.colorValue,
      required this.excludeFromTotal,
      required this.createdAt,
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
      required this.creditReminderEnabled,
      this.creditReminderTime,
      this.creditEarlyReminderEnabled,
      this.linkedAccountId,
      this.orderIndex,
      required this.excludeFromBankTotal,
      required this.dontLinkToCard});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['balance'] = Variable<double>(balance);
    map['currency'] = Variable<String>(currency);
    map['color_value'] = Variable<int>(colorValue);
    map['exclude_from_total'] = Variable<int>(excludeFromTotal);
    map['created_at'] = Variable<String>(createdAt);
    if (!nullToAbsent || goldKarat != null) {
      map['gold_karat'] = Variable<int>(goldKarat);
    }
    if (!nullToAbsent || goldGrams != null) {
      map['gold_grams'] = Variable<double>(goldGrams);
    }
    if (!nullToAbsent || cardHolderName != null) {
      map['card_holder_name'] = Variable<String>(cardHolderName);
    }
    if (!nullToAbsent || cardNumberLast4 != null) {
      map['card_number_last4'] = Variable<String>(cardNumberLast4);
    }
    if (!nullToAbsent || cardExpiry != null) {
      map['card_expiry'] = Variable<String>(cardExpiry);
    }
    if (!nullToAbsent || statementDay != null) {
      map['statement_day'] = Variable<int>(statementDay);
    }
    if (!nullToAbsent || dueDay != null) {
      map['due_day'] = Variable<int>(dueDay);
    }
    if (!nullToAbsent || creditLimit != null) {
      map['credit_limit'] = Variable<double>(creditLimit);
    }
    if (!nullToAbsent || minPaymentAmount != null) {
      map['min_payment_amount'] = Variable<double>(minPaymentAmount);
    }
    if (!nullToAbsent || minPaymentPercent != null) {
      map['min_payment_percent'] = Variable<double>(minPaymentPercent);
    }
    map['credit_reminder_enabled'] = Variable<int>(creditReminderEnabled);
    if (!nullToAbsent || creditReminderTime != null) {
      map['credit_reminder_time'] = Variable<String>(creditReminderTime);
    }
    if (!nullToAbsent || creditEarlyReminderEnabled != null) {
      map['credit_early_reminder_enabled'] =
          Variable<int>(creditEarlyReminderEnabled);
    }
    if (!nullToAbsent || linkedAccountId != null) {
      map['linked_account_id'] = Variable<String>(linkedAccountId);
    }
    if (!nullToAbsent || orderIndex != null) {
      map['order_index'] = Variable<int>(orderIndex);
    }
    map['exclude_from_bank_total'] = Variable<int>(excludeFromBankTotal);
    map['dont_link_to_card'] = Variable<int>(dontLinkToCard);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      balance: Value(balance),
      currency: Value(currency),
      colorValue: Value(colorValue),
      excludeFromTotal: Value(excludeFromTotal),
      createdAt: Value(createdAt),
      goldKarat: goldKarat == null && nullToAbsent
          ? const Value.absent()
          : Value(goldKarat),
      goldGrams: goldGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(goldGrams),
      cardHolderName: cardHolderName == null && nullToAbsent
          ? const Value.absent()
          : Value(cardHolderName),
      cardNumberLast4: cardNumberLast4 == null && nullToAbsent
          ? const Value.absent()
          : Value(cardNumberLast4),
      cardExpiry: cardExpiry == null && nullToAbsent
          ? const Value.absent()
          : Value(cardExpiry),
      statementDay: statementDay == null && nullToAbsent
          ? const Value.absent()
          : Value(statementDay),
      dueDay:
          dueDay == null && nullToAbsent ? const Value.absent() : Value(dueDay),
      creditLimit: creditLimit == null && nullToAbsent
          ? const Value.absent()
          : Value(creditLimit),
      minPaymentAmount: minPaymentAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(minPaymentAmount),
      minPaymentPercent: minPaymentPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(minPaymentPercent),
      creditReminderEnabled: Value(creditReminderEnabled),
      creditReminderTime: creditReminderTime == null && nullToAbsent
          ? const Value.absent()
          : Value(creditReminderTime),
      creditEarlyReminderEnabled:
          creditEarlyReminderEnabled == null && nullToAbsent
              ? const Value.absent()
              : Value(creditEarlyReminderEnabled),
      linkedAccountId: linkedAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedAccountId),
      orderIndex: orderIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(orderIndex),
      excludeFromBankTotal: Value(excludeFromBankTotal),
      dontLinkToCard: Value(dontLinkToCard),
    );
  }

  factory AccountEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      balance: serializer.fromJson<double>(json['balance']),
      currency: serializer.fromJson<String>(json['currency']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      excludeFromTotal: serializer.fromJson<int>(json['excludeFromTotal']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      goldKarat: serializer.fromJson<int?>(json['goldKarat']),
      goldGrams: serializer.fromJson<double?>(json['goldGrams']),
      cardHolderName: serializer.fromJson<String?>(json['cardHolderName']),
      cardNumberLast4: serializer.fromJson<String?>(json['cardNumberLast4']),
      cardExpiry: serializer.fromJson<String?>(json['cardExpiry']),
      statementDay: serializer.fromJson<int?>(json['statementDay']),
      dueDay: serializer.fromJson<int?>(json['dueDay']),
      creditLimit: serializer.fromJson<double?>(json['creditLimit']),
      minPaymentAmount: serializer.fromJson<double?>(json['minPaymentAmount']),
      minPaymentPercent:
          serializer.fromJson<double?>(json['minPaymentPercent']),
      creditReminderEnabled:
          serializer.fromJson<int>(json['creditReminderEnabled']),
      creditReminderTime:
          serializer.fromJson<String?>(json['creditReminderTime']),
      creditEarlyReminderEnabled:
          serializer.fromJson<int?>(json['creditEarlyReminderEnabled']),
      linkedAccountId: serializer.fromJson<String?>(json['linkedAccountId']),
      orderIndex: serializer.fromJson<int?>(json['orderIndex']),
      excludeFromBankTotal:
          serializer.fromJson<int>(json['excludeFromBankTotal']),
      dontLinkToCard: serializer.fromJson<int>(json['dontLinkToCard']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'balance': serializer.toJson<double>(balance),
      'currency': serializer.toJson<String>(currency),
      'colorValue': serializer.toJson<int>(colorValue),
      'excludeFromTotal': serializer.toJson<int>(excludeFromTotal),
      'createdAt': serializer.toJson<String>(createdAt),
      'goldKarat': serializer.toJson<int?>(goldKarat),
      'goldGrams': serializer.toJson<double?>(goldGrams),
      'cardHolderName': serializer.toJson<String?>(cardHolderName),
      'cardNumberLast4': serializer.toJson<String?>(cardNumberLast4),
      'cardExpiry': serializer.toJson<String?>(cardExpiry),
      'statementDay': serializer.toJson<int?>(statementDay),
      'dueDay': serializer.toJson<int?>(dueDay),
      'creditLimit': serializer.toJson<double?>(creditLimit),
      'minPaymentAmount': serializer.toJson<double?>(minPaymentAmount),
      'minPaymentPercent': serializer.toJson<double?>(minPaymentPercent),
      'creditReminderEnabled': serializer.toJson<int>(creditReminderEnabled),
      'creditReminderTime': serializer.toJson<String?>(creditReminderTime),
      'creditEarlyReminderEnabled':
          serializer.toJson<int?>(creditEarlyReminderEnabled),
      'linkedAccountId': serializer.toJson<String?>(linkedAccountId),
      'orderIndex': serializer.toJson<int?>(orderIndex),
      'excludeFromBankTotal': serializer.toJson<int>(excludeFromBankTotal),
      'dontLinkToCard': serializer.toJson<int>(dontLinkToCard),
    };
  }

  AccountEntry copyWith(
          {String? id,
          String? name,
          String? type,
          double? balance,
          String? currency,
          int? colorValue,
          int? excludeFromTotal,
          String? createdAt,
          Value<int?> goldKarat = const Value.absent(),
          Value<double?> goldGrams = const Value.absent(),
          Value<String?> cardHolderName = const Value.absent(),
          Value<String?> cardNumberLast4 = const Value.absent(),
          Value<String?> cardExpiry = const Value.absent(),
          Value<int?> statementDay = const Value.absent(),
          Value<int?> dueDay = const Value.absent(),
          Value<double?> creditLimit = const Value.absent(),
          Value<double?> minPaymentAmount = const Value.absent(),
          Value<double?> minPaymentPercent = const Value.absent(),
          int? creditReminderEnabled,
          Value<String?> creditReminderTime = const Value.absent(),
          Value<int?> creditEarlyReminderEnabled = const Value.absent(),
          Value<String?> linkedAccountId = const Value.absent(),
          Value<int?> orderIndex = const Value.absent(),
          int? excludeFromBankTotal,
          int? dontLinkToCard}) =>
      AccountEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        balance: balance ?? this.balance,
        currency: currency ?? this.currency,
        colorValue: colorValue ?? this.colorValue,
        excludeFromTotal: excludeFromTotal ?? this.excludeFromTotal,
        createdAt: createdAt ?? this.createdAt,
        goldKarat: goldKarat.present ? goldKarat.value : this.goldKarat,
        goldGrams: goldGrams.present ? goldGrams.value : this.goldGrams,
        cardHolderName:
            cardHolderName.present ? cardHolderName.value : this.cardHolderName,
        cardNumberLast4: cardNumberLast4.present
            ? cardNumberLast4.value
            : this.cardNumberLast4,
        cardExpiry: cardExpiry.present ? cardExpiry.value : this.cardExpiry,
        statementDay:
            statementDay.present ? statementDay.value : this.statementDay,
        dueDay: dueDay.present ? dueDay.value : this.dueDay,
        creditLimit: creditLimit.present ? creditLimit.value : this.creditLimit,
        minPaymentAmount: minPaymentAmount.present
            ? minPaymentAmount.value
            : this.minPaymentAmount,
        minPaymentPercent: minPaymentPercent.present
            ? minPaymentPercent.value
            : this.minPaymentPercent,
        creditReminderEnabled:
            creditReminderEnabled ?? this.creditReminderEnabled,
        creditReminderTime: creditReminderTime.present
            ? creditReminderTime.value
            : this.creditReminderTime,
        creditEarlyReminderEnabled: creditEarlyReminderEnabled.present
            ? creditEarlyReminderEnabled.value
            : this.creditEarlyReminderEnabled,
        linkedAccountId: linkedAccountId.present
            ? linkedAccountId.value
            : this.linkedAccountId,
        orderIndex: orderIndex.present ? orderIndex.value : this.orderIndex,
        excludeFromBankTotal: excludeFromBankTotal ?? this.excludeFromBankTotal,
        dontLinkToCard: dontLinkToCard ?? this.dontLinkToCard,
      );
  AccountEntry copyWithCompanion(AccountsCompanion data) {
    return AccountEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      balance: data.balance.present ? data.balance.value : this.balance,
      currency: data.currency.present ? data.currency.value : this.currency,
      colorValue:
          data.colorValue.present ? data.colorValue.value : this.colorValue,
      excludeFromTotal: data.excludeFromTotal.present
          ? data.excludeFromTotal.value
          : this.excludeFromTotal,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      goldKarat: data.goldKarat.present ? data.goldKarat.value : this.goldKarat,
      goldGrams: data.goldGrams.present ? data.goldGrams.value : this.goldGrams,
      cardHolderName: data.cardHolderName.present
          ? data.cardHolderName.value
          : this.cardHolderName,
      cardNumberLast4: data.cardNumberLast4.present
          ? data.cardNumberLast4.value
          : this.cardNumberLast4,
      cardExpiry:
          data.cardExpiry.present ? data.cardExpiry.value : this.cardExpiry,
      statementDay: data.statementDay.present
          ? data.statementDay.value
          : this.statementDay,
      dueDay: data.dueDay.present ? data.dueDay.value : this.dueDay,
      creditLimit:
          data.creditLimit.present ? data.creditLimit.value : this.creditLimit,
      minPaymentAmount: data.minPaymentAmount.present
          ? data.minPaymentAmount.value
          : this.minPaymentAmount,
      minPaymentPercent: data.minPaymentPercent.present
          ? data.minPaymentPercent.value
          : this.minPaymentPercent,
      creditReminderEnabled: data.creditReminderEnabled.present
          ? data.creditReminderEnabled.value
          : this.creditReminderEnabled,
      creditReminderTime: data.creditReminderTime.present
          ? data.creditReminderTime.value
          : this.creditReminderTime,
      creditEarlyReminderEnabled: data.creditEarlyReminderEnabled.present
          ? data.creditEarlyReminderEnabled.value
          : this.creditEarlyReminderEnabled,
      linkedAccountId: data.linkedAccountId.present
          ? data.linkedAccountId.value
          : this.linkedAccountId,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
      excludeFromBankTotal: data.excludeFromBankTotal.present
          ? data.excludeFromBankTotal.value
          : this.excludeFromBankTotal,
      dontLinkToCard: data.dontLinkToCard.present
          ? data.dontLinkToCard.value
          : this.dontLinkToCard,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('balance: $balance, ')
          ..write('currency: $currency, ')
          ..write('colorValue: $colorValue, ')
          ..write('excludeFromTotal: $excludeFromTotal, ')
          ..write('createdAt: $createdAt, ')
          ..write('goldKarat: $goldKarat, ')
          ..write('goldGrams: $goldGrams, ')
          ..write('cardHolderName: $cardHolderName, ')
          ..write('cardNumberLast4: $cardNumberLast4, ')
          ..write('cardExpiry: $cardExpiry, ')
          ..write('statementDay: $statementDay, ')
          ..write('dueDay: $dueDay, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('minPaymentAmount: $minPaymentAmount, ')
          ..write('minPaymentPercent: $minPaymentPercent, ')
          ..write('creditReminderEnabled: $creditReminderEnabled, ')
          ..write('creditReminderTime: $creditReminderTime, ')
          ..write('creditEarlyReminderEnabled: $creditEarlyReminderEnabled, ')
          ..write('linkedAccountId: $linkedAccountId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('excludeFromBankTotal: $excludeFromBankTotal, ')
          ..write('dontLinkToCard: $dontLinkToCard')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        name,
        type,
        balance,
        currency,
        colorValue,
        excludeFromTotal,
        createdAt,
        goldKarat,
        goldGrams,
        cardHolderName,
        cardNumberLast4,
        cardExpiry,
        statementDay,
        dueDay,
        creditLimit,
        minPaymentAmount,
        minPaymentPercent,
        creditReminderEnabled,
        creditReminderTime,
        creditEarlyReminderEnabled,
        linkedAccountId,
        orderIndex,
        excludeFromBankTotal,
        dontLinkToCard
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.balance == this.balance &&
          other.currency == this.currency &&
          other.colorValue == this.colorValue &&
          other.excludeFromTotal == this.excludeFromTotal &&
          other.createdAt == this.createdAt &&
          other.goldKarat == this.goldKarat &&
          other.goldGrams == this.goldGrams &&
          other.cardHolderName == this.cardHolderName &&
          other.cardNumberLast4 == this.cardNumberLast4 &&
          other.cardExpiry == this.cardExpiry &&
          other.statementDay == this.statementDay &&
          other.dueDay == this.dueDay &&
          other.creditLimit == this.creditLimit &&
          other.minPaymentAmount == this.minPaymentAmount &&
          other.minPaymentPercent == this.minPaymentPercent &&
          other.creditReminderEnabled == this.creditReminderEnabled &&
          other.creditReminderTime == this.creditReminderTime &&
          other.creditEarlyReminderEnabled == this.creditEarlyReminderEnabled &&
          other.linkedAccountId == this.linkedAccountId &&
          other.orderIndex == this.orderIndex &&
          other.excludeFromBankTotal == this.excludeFromBankTotal &&
          other.dontLinkToCard == this.dontLinkToCard);
}

class AccountsCompanion extends UpdateCompanion<AccountEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<double> balance;
  final Value<String> currency;
  final Value<int> colorValue;
  final Value<int> excludeFromTotal;
  final Value<String> createdAt;
  final Value<int?> goldKarat;
  final Value<double?> goldGrams;
  final Value<String?> cardHolderName;
  final Value<String?> cardNumberLast4;
  final Value<String?> cardExpiry;
  final Value<int?> statementDay;
  final Value<int?> dueDay;
  final Value<double?> creditLimit;
  final Value<double?> minPaymentAmount;
  final Value<double?> minPaymentPercent;
  final Value<int> creditReminderEnabled;
  final Value<String?> creditReminderTime;
  final Value<int?> creditEarlyReminderEnabled;
  final Value<String?> linkedAccountId;
  final Value<int?> orderIndex;
  final Value<int> excludeFromBankTotal;
  final Value<int> dontLinkToCard;
  final Value<int> rowid;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.balance = const Value.absent(),
    this.currency = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.excludeFromTotal = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.goldKarat = const Value.absent(),
    this.goldGrams = const Value.absent(),
    this.cardHolderName = const Value.absent(),
    this.cardNumberLast4 = const Value.absent(),
    this.cardExpiry = const Value.absent(),
    this.statementDay = const Value.absent(),
    this.dueDay = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.minPaymentAmount = const Value.absent(),
    this.minPaymentPercent = const Value.absent(),
    this.creditReminderEnabled = const Value.absent(),
    this.creditReminderTime = const Value.absent(),
    this.creditEarlyReminderEnabled = const Value.absent(),
    this.linkedAccountId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.excludeFromBankTotal = const Value.absent(),
    this.dontLinkToCard = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsCompanion.insert({
    required String id,
    required String name,
    required String type,
    required double balance,
    this.currency = const Value.absent(),
    required int colorValue,
    this.excludeFromTotal = const Value.absent(),
    required String createdAt,
    this.goldKarat = const Value.absent(),
    this.goldGrams = const Value.absent(),
    this.cardHolderName = const Value.absent(),
    this.cardNumberLast4 = const Value.absent(),
    this.cardExpiry = const Value.absent(),
    this.statementDay = const Value.absent(),
    this.dueDay = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.minPaymentAmount = const Value.absent(),
    this.minPaymentPercent = const Value.absent(),
    this.creditReminderEnabled = const Value.absent(),
    this.creditReminderTime = const Value.absent(),
    this.creditEarlyReminderEnabled = const Value.absent(),
    this.linkedAccountId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.excludeFromBankTotal = const Value.absent(),
    this.dontLinkToCard = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        type = Value(type),
        balance = Value(balance),
        colorValue = Value(colorValue),
        createdAt = Value(createdAt);
  static Insertable<AccountEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<double>? balance,
    Expression<String>? currency,
    Expression<int>? colorValue,
    Expression<int>? excludeFromTotal,
    Expression<String>? createdAt,
    Expression<int>? goldKarat,
    Expression<double>? goldGrams,
    Expression<String>? cardHolderName,
    Expression<String>? cardNumberLast4,
    Expression<String>? cardExpiry,
    Expression<int>? statementDay,
    Expression<int>? dueDay,
    Expression<double>? creditLimit,
    Expression<double>? minPaymentAmount,
    Expression<double>? minPaymentPercent,
    Expression<int>? creditReminderEnabled,
    Expression<String>? creditReminderTime,
    Expression<int>? creditEarlyReminderEnabled,
    Expression<String>? linkedAccountId,
    Expression<int>? orderIndex,
    Expression<int>? excludeFromBankTotal,
    Expression<int>? dontLinkToCard,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (balance != null) 'balance': balance,
      if (currency != null) 'currency': currency,
      if (colorValue != null) 'color_value': colorValue,
      if (excludeFromTotal != null) 'exclude_from_total': excludeFromTotal,
      if (createdAt != null) 'created_at': createdAt,
      if (goldKarat != null) 'gold_karat': goldKarat,
      if (goldGrams != null) 'gold_grams': goldGrams,
      if (cardHolderName != null) 'card_holder_name': cardHolderName,
      if (cardNumberLast4 != null) 'card_number_last4': cardNumberLast4,
      if (cardExpiry != null) 'card_expiry': cardExpiry,
      if (statementDay != null) 'statement_day': statementDay,
      if (dueDay != null) 'due_day': dueDay,
      if (creditLimit != null) 'credit_limit': creditLimit,
      if (minPaymentAmount != null) 'min_payment_amount': minPaymentAmount,
      if (minPaymentPercent != null) 'min_payment_percent': minPaymentPercent,
      if (creditReminderEnabled != null)
        'credit_reminder_enabled': creditReminderEnabled,
      if (creditReminderTime != null)
        'credit_reminder_time': creditReminderTime,
      if (creditEarlyReminderEnabled != null)
        'credit_early_reminder_enabled': creditEarlyReminderEnabled,
      if (linkedAccountId != null) 'linked_account_id': linkedAccountId,
      if (orderIndex != null) 'order_index': orderIndex,
      if (excludeFromBankTotal != null)
        'exclude_from_bank_total': excludeFromBankTotal,
      if (dontLinkToCard != null) 'dont_link_to_card': dontLinkToCard,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? type,
      Value<double>? balance,
      Value<String>? currency,
      Value<int>? colorValue,
      Value<int>? excludeFromTotal,
      Value<String>? createdAt,
      Value<int?>? goldKarat,
      Value<double?>? goldGrams,
      Value<String?>? cardHolderName,
      Value<String?>? cardNumberLast4,
      Value<String?>? cardExpiry,
      Value<int?>? statementDay,
      Value<int?>? dueDay,
      Value<double?>? creditLimit,
      Value<double?>? minPaymentAmount,
      Value<double?>? minPaymentPercent,
      Value<int>? creditReminderEnabled,
      Value<String?>? creditReminderTime,
      Value<int?>? creditEarlyReminderEnabled,
      Value<String?>? linkedAccountId,
      Value<int?>? orderIndex,
      Value<int>? excludeFromBankTotal,
      Value<int>? dontLinkToCard,
      Value<int>? rowid}) {
    return AccountsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      colorValue: colorValue ?? this.colorValue,
      excludeFromTotal: excludeFromTotal ?? this.excludeFromTotal,
      createdAt: createdAt ?? this.createdAt,
      goldKarat: goldKarat ?? this.goldKarat,
      goldGrams: goldGrams ?? this.goldGrams,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardNumberLast4: cardNumberLast4 ?? this.cardNumberLast4,
      cardExpiry: cardExpiry ?? this.cardExpiry,
      statementDay: statementDay ?? this.statementDay,
      dueDay: dueDay ?? this.dueDay,
      creditLimit: creditLimit ?? this.creditLimit,
      minPaymentAmount: minPaymentAmount ?? this.minPaymentAmount,
      minPaymentPercent: minPaymentPercent ?? this.minPaymentPercent,
      creditReminderEnabled:
          creditReminderEnabled ?? this.creditReminderEnabled,
      creditReminderTime: creditReminderTime ?? this.creditReminderTime,
      creditEarlyReminderEnabled:
          creditEarlyReminderEnabled ?? this.creditEarlyReminderEnabled,
      linkedAccountId: linkedAccountId ?? this.linkedAccountId,
      orderIndex: orderIndex ?? this.orderIndex,
      excludeFromBankTotal: excludeFromBankTotal ?? this.excludeFromBankTotal,
      dontLinkToCard: dontLinkToCard ?? this.dontLinkToCard,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (excludeFromTotal.present) {
      map['exclude_from_total'] = Variable<int>(excludeFromTotal.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (goldKarat.present) {
      map['gold_karat'] = Variable<int>(goldKarat.value);
    }
    if (goldGrams.present) {
      map['gold_grams'] = Variable<double>(goldGrams.value);
    }
    if (cardHolderName.present) {
      map['card_holder_name'] = Variable<String>(cardHolderName.value);
    }
    if (cardNumberLast4.present) {
      map['card_number_last4'] = Variable<String>(cardNumberLast4.value);
    }
    if (cardExpiry.present) {
      map['card_expiry'] = Variable<String>(cardExpiry.value);
    }
    if (statementDay.present) {
      map['statement_day'] = Variable<int>(statementDay.value);
    }
    if (dueDay.present) {
      map['due_day'] = Variable<int>(dueDay.value);
    }
    if (creditLimit.present) {
      map['credit_limit'] = Variable<double>(creditLimit.value);
    }
    if (minPaymentAmount.present) {
      map['min_payment_amount'] = Variable<double>(minPaymentAmount.value);
    }
    if (minPaymentPercent.present) {
      map['min_payment_percent'] = Variable<double>(minPaymentPercent.value);
    }
    if (creditReminderEnabled.present) {
      map['credit_reminder_enabled'] =
          Variable<int>(creditReminderEnabled.value);
    }
    if (creditReminderTime.present) {
      map['credit_reminder_time'] = Variable<String>(creditReminderTime.value);
    }
    if (creditEarlyReminderEnabled.present) {
      map['credit_early_reminder_enabled'] =
          Variable<int>(creditEarlyReminderEnabled.value);
    }
    if (linkedAccountId.present) {
      map['linked_account_id'] = Variable<String>(linkedAccountId.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (excludeFromBankTotal.present) {
      map['exclude_from_bank_total'] =
          Variable<int>(excludeFromBankTotal.value);
    }
    if (dontLinkToCard.present) {
      map['dont_link_to_card'] = Variable<int>(dontLinkToCard.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('balance: $balance, ')
          ..write('currency: $currency, ')
          ..write('colorValue: $colorValue, ')
          ..write('excludeFromTotal: $excludeFromTotal, ')
          ..write('createdAt: $createdAt, ')
          ..write('goldKarat: $goldKarat, ')
          ..write('goldGrams: $goldGrams, ')
          ..write('cardHolderName: $cardHolderName, ')
          ..write('cardNumberLast4: $cardNumberLast4, ')
          ..write('cardExpiry: $cardExpiry, ')
          ..write('statementDay: $statementDay, ')
          ..write('dueDay: $dueDay, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('minPaymentAmount: $minPaymentAmount, ')
          ..write('minPaymentPercent: $minPaymentPercent, ')
          ..write('creditReminderEnabled: $creditReminderEnabled, ')
          ..write('creditReminderTime: $creditReminderTime, ')
          ..write('creditEarlyReminderEnabled: $creditEarlyReminderEnabled, ')
          ..write('linkedAccountId: $linkedAccountId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('excludeFromBankTotal: $excludeFromBankTotal, ')
          ..write('dontLinkToCard: $dontLinkToCard, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, CategoryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorValueMeta =
      const VerificationMeta('colorValue');
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
      'color_value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _iconCodePointMeta =
      const VerificationMeta('iconCodePoint');
  @override
  late final GeneratedColumn<int> iconCodePoint = GeneratedColumn<int>(
      'icon_code_point', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, type, colorValue, iconCodePoint, orderIndex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
          _colorValueMeta,
          colorValue.isAcceptableOrUnknown(
              data['color_value']!, _colorValueMeta));
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    if (data.containsKey('icon_code_point')) {
      context.handle(
          _iconCodePointMeta,
          iconCodePoint.isAcceptableOrUnknown(
              data['icon_code_point']!, _iconCodePointMeta));
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      colorValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color_value'])!,
      iconCodePoint: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}icon_code_point'])!,
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class CategoryEntry extends DataClass implements Insertable<CategoryEntry> {
  final String id;
  final String name;
  final String type;
  final int colorValue;
  final int iconCodePoint;
  final int orderIndex;
  const CategoryEntry(
      {required this.id,
      required this.name,
      required this.type,
      required this.colorValue,
      required this.iconCodePoint,
      required this.orderIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['color_value'] = Variable<int>(colorValue);
    map['icon_code_point'] = Variable<int>(iconCodePoint);
    map['order_index'] = Variable<int>(orderIndex);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      colorValue: Value(colorValue),
      iconCodePoint: Value(iconCodePoint),
      orderIndex: Value(orderIndex),
    );
  }

  factory CategoryEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      iconCodePoint: serializer.fromJson<int>(json['iconCodePoint']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'colorValue': serializer.toJson<int>(colorValue),
      'iconCodePoint': serializer.toJson<int>(iconCodePoint),
      'orderIndex': serializer.toJson<int>(orderIndex),
    };
  }

  CategoryEntry copyWith(
          {String? id,
          String? name,
          String? type,
          int? colorValue,
          int? iconCodePoint,
          int? orderIndex}) =>
      CategoryEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        colorValue: colorValue ?? this.colorValue,
        iconCodePoint: iconCodePoint ?? this.iconCodePoint,
        orderIndex: orderIndex ?? this.orderIndex,
      );
  CategoryEntry copyWithCompanion(CategoriesCompanion data) {
    return CategoryEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      colorValue:
          data.colorValue.present ? data.colorValue.value : this.colorValue,
      iconCodePoint: data.iconCodePoint.present
          ? data.iconCodePoint.value
          : this.iconCodePoint,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('colorValue: $colorValue, ')
          ..write('iconCodePoint: $iconCodePoint, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, type, colorValue, iconCodePoint, orderIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.colorValue == this.colorValue &&
          other.iconCodePoint == this.iconCodePoint &&
          other.orderIndex == this.orderIndex);
}

class CategoriesCompanion extends UpdateCompanion<CategoryEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<int> colorValue;
  final Value<int> iconCodePoint;
  final Value<int> orderIndex;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.iconCodePoint = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    required String type,
    required int colorValue,
    this.iconCodePoint = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        type = Value(type),
        colorValue = Value(colorValue);
  static Insertable<CategoryEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? colorValue,
    Expression<int>? iconCodePoint,
    Expression<int>? orderIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (colorValue != null) 'color_value': colorValue,
      if (iconCodePoint != null) 'icon_code_point': iconCodePoint,
      if (orderIndex != null) 'order_index': orderIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? type,
      Value<int>? colorValue,
      Value<int>? iconCodePoint,
      Value<int>? orderIndex,
      Value<int>? rowid}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      colorValue: colorValue ?? this.colorValue,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      orderIndex: orderIndex ?? this.orderIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (iconCodePoint.present) {
      map['icon_code_point'] = Variable<int>(iconCodePoint.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('colorValue: $colorValue, ')
          ..write('iconCodePoint: $iconCodePoint, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, TransactionEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _accountIdMeta =
      const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
      'account_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        type,
        amount,
        description,
        accountId,
        categoryId,
        date,
        note,
        currency
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<TransactionEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      accountId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class TransactionEntry extends DataClass
    implements Insertable<TransactionEntry> {
  final String id;
  final String type;
  final double amount;
  final String description;
  final String accountId;
  final String categoryId;
  final String date;
  final String note;
  final String currency;
  const TransactionEntry(
      {required this.id,
      required this.type,
      required this.amount,
      required this.description,
      required this.accountId,
      required this.categoryId,
      required this.date,
      required this.note,
      required this.currency});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['amount'] = Variable<double>(amount);
    map['description'] = Variable<String>(description);
    map['account_id'] = Variable<String>(accountId);
    map['category_id'] = Variable<String>(categoryId);
    map['date'] = Variable<String>(date);
    map['note'] = Variable<String>(note);
    map['currency'] = Variable<String>(currency);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      type: Value(type),
      amount: Value(amount),
      description: Value(description),
      accountId: Value(accountId),
      categoryId: Value(categoryId),
      date: Value(date),
      note: Value(note),
      currency: Value(currency),
    );
  }

  factory TransactionEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionEntry(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      amount: serializer.fromJson<double>(json['amount']),
      description: serializer.fromJson<String>(json['description']),
      accountId: serializer.fromJson<String>(json['accountId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      date: serializer.fromJson<String>(json['date']),
      note: serializer.fromJson<String>(json['note']),
      currency: serializer.fromJson<String>(json['currency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'amount': serializer.toJson<double>(amount),
      'description': serializer.toJson<String>(description),
      'accountId': serializer.toJson<String>(accountId),
      'categoryId': serializer.toJson<String>(categoryId),
      'date': serializer.toJson<String>(date),
      'note': serializer.toJson<String>(note),
      'currency': serializer.toJson<String>(currency),
    };
  }

  TransactionEntry copyWith(
          {String? id,
          String? type,
          double? amount,
          String? description,
          String? accountId,
          String? categoryId,
          String? date,
          String? note,
          String? currency}) =>
      TransactionEntry(
        id: id ?? this.id,
        type: type ?? this.type,
        amount: amount ?? this.amount,
        description: description ?? this.description,
        accountId: accountId ?? this.accountId,
        categoryId: categoryId ?? this.categoryId,
        date: date ?? this.date,
        note: note ?? this.note,
        currency: currency ?? this.currency,
      );
  TransactionEntry copyWithCompanion(TransactionsCompanion data) {
    return TransactionEntry(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      amount: data.amount.present ? data.amount.value : this.amount,
      description:
          data.description.present ? data.description.value : this.description,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      date: data.date.present ? data.date.value : this.date,
      note: data.note.present ? data.note.value : this.note,
      currency: data.currency.present ? data.currency.value : this.currency,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionEntry(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('currency: $currency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, amount, description, accountId,
      categoryId, date, note, currency);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionEntry &&
          other.id == this.id &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.description == this.description &&
          other.accountId == this.accountId &&
          other.categoryId == this.categoryId &&
          other.date == this.date &&
          other.note == this.note &&
          other.currency == this.currency);
}

class TransactionsCompanion extends UpdateCompanion<TransactionEntry> {
  final Value<String> id;
  final Value<String> type;
  final Value<double> amount;
  final Value<String> description;
  final Value<String> accountId;
  final Value<String> categoryId;
  final Value<String> date;
  final Value<String> note;
  final Value<String> currency;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.description = const Value.absent(),
    this.accountId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.currency = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required String id,
    required String type,
    required double amount,
    required String description,
    required String accountId,
    required String categoryId,
    required String date,
    this.note = const Value.absent(),
    this.currency = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        amount = Value(amount),
        description = Value(description),
        accountId = Value(accountId),
        categoryId = Value(categoryId),
        date = Value(date);
  static Insertable<TransactionEntry> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<double>? amount,
    Expression<String>? description,
    Expression<String>? accountId,
    Expression<String>? categoryId,
    Expression<String>? date,
    Expression<String>? note,
    Expression<String>? currency,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (description != null) 'description': description,
      if (accountId != null) 'account_id': accountId,
      if (categoryId != null) 'category_id': categoryId,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (currency != null) 'currency': currency,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? type,
      Value<double>? amount,
      Value<String>? description,
      Value<String>? accountId,
      Value<String>? categoryId,
      Value<String>? date,
      Value<String>? note,
      Value<String>? currency,
      Value<int>? rowid}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      date: date ?? this.date,
      note: note ?? this.note,
      currency: currency ?? this.currency,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('currency: $currency, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecurringPaymentsTable extends RecurringPayments
    with TableInfo<$RecurringPaymentsTable, RecurringPaymentEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurringPaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _accountIdMeta =
      const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
      'account_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _paymentTypeMeta =
      const VerificationMeta('paymentType');
  @override
  late final GeneratedColumn<String> paymentType = GeneratedColumn<String>(
      'payment_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('expense'));
  static const VerificationMeta _freqValMeta =
      const VerificationMeta('freqVal');
  @override
  late final GeneratedColumn<int> freqVal = GeneratedColumn<int>(
      'freq_val', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _freqUnitMeta =
      const VerificationMeta('freqUnit');
  @override
  late final GeneratedColumn<String> freqUnit = GeneratedColumn<String>(
      'freq_unit', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('months'));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'start_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nextDateMeta =
      const VerificationMeta('nextDate');
  @override
  late final GeneratedColumn<String> nextDate = GeneratedColumn<String>(
      'next_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
      'end_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _paidPaymentsMeta =
      const VerificationMeta('paidPayments');
  @override
  late final GeneratedColumn<int> paidPayments = GeneratedColumn<int>(
      'paid_payments', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _reminderEnabledMeta =
      const VerificationMeta('reminderEnabled');
  @override
  late final GeneratedColumn<int> reminderEnabled = GeneratedColumn<int>(
      'reminder_enabled', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _reminderTimeMeta =
      const VerificationMeta('reminderTime');
  @override
  late final GeneratedColumn<String> reminderTime = GeneratedColumn<String>(
      'reminder_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('09:00'));
  static const VerificationMeta _earlyReminderEnabledMeta =
      const VerificationMeta('earlyReminderEnabled');
  @override
  late final GeneratedColumn<int> earlyReminderEnabled = GeneratedColumn<int>(
      'early_reminder_enabled', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _recurringTypeMeta =
      const VerificationMeta('recurringType');
  @override
  late final GeneratedColumn<String> recurringType = GeneratedColumn<String>(
      'recurring_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('subscription'));
  static const VerificationMeta _autoPayEnabledMeta =
      const VerificationMeta('autoPayEnabled');
  @override
  late final GeneratedColumn<int> autoPayEnabled = GeneratedColumn<int>(
      'auto_pay_enabled', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _autoPayTimeMeta =
      const VerificationMeta('autoPayTime');
  @override
  late final GeneratedColumn<String> autoPayTime = GeneratedColumn<String>(
      'auto_pay_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('09:00'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        accountId,
        categoryId,
        amount,
        paymentType,
        freqVal,
        freqUnit,
        startDate,
        nextDate,
        endDate,
        paidPayments,
        reminderEnabled,
        reminderTime,
        earlyReminderEnabled,
        notes,
        recurringType,
        autoPayEnabled,
        autoPayTime
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurring_payments';
  @override
  VerificationContext validateIntegrity(
      Insertable<RecurringPaymentEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payment_type')) {
      context.handle(
          _paymentTypeMeta,
          paymentType.isAcceptableOrUnknown(
              data['payment_type']!, _paymentTypeMeta));
    }
    if (data.containsKey('freq_val')) {
      context.handle(_freqValMeta,
          freqVal.isAcceptableOrUnknown(data['freq_val']!, _freqValMeta));
    }
    if (data.containsKey('freq_unit')) {
      context.handle(_freqUnitMeta,
          freqUnit.isAcceptableOrUnknown(data['freq_unit']!, _freqUnitMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('next_date')) {
      context.handle(_nextDateMeta,
          nextDate.isAcceptableOrUnknown(data['next_date']!, _nextDateMeta));
    } else if (isInserting) {
      context.missing(_nextDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('paid_payments')) {
      context.handle(
          _paidPaymentsMeta,
          paidPayments.isAcceptableOrUnknown(
              data['paid_payments']!, _paidPaymentsMeta));
    }
    if (data.containsKey('reminder_enabled')) {
      context.handle(
          _reminderEnabledMeta,
          reminderEnabled.isAcceptableOrUnknown(
              data['reminder_enabled']!, _reminderEnabledMeta));
    }
    if (data.containsKey('reminder_time')) {
      context.handle(
          _reminderTimeMeta,
          reminderTime.isAcceptableOrUnknown(
              data['reminder_time']!, _reminderTimeMeta));
    }
    if (data.containsKey('early_reminder_enabled')) {
      context.handle(
          _earlyReminderEnabledMeta,
          earlyReminderEnabled.isAcceptableOrUnknown(
              data['early_reminder_enabled']!, _earlyReminderEnabledMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('recurring_type')) {
      context.handle(
          _recurringTypeMeta,
          recurringType.isAcceptableOrUnknown(
              data['recurring_type']!, _recurringTypeMeta));
    }
    if (data.containsKey('auto_pay_enabled')) {
      context.handle(
          _autoPayEnabledMeta,
          autoPayEnabled.isAcceptableOrUnknown(
              data['auto_pay_enabled']!, _autoPayEnabledMeta));
    }
    if (data.containsKey('auto_pay_time')) {
      context.handle(
          _autoPayTimeMeta,
          autoPayTime.isAcceptableOrUnknown(
              data['auto_pay_time']!, _autoPayTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurringPaymentEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurringPaymentEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      accountId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      paymentType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_type'])!,
      freqVal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}freq_val'])!,
      freqUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}freq_unit'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_date'])!,
      nextDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}next_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_date']),
      paidPayments: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}paid_payments'])!,
      reminderEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reminder_enabled'])!,
      reminderTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reminder_time'])!,
      earlyReminderEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}early_reminder_enabled'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      recurringType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recurring_type'])!,
      autoPayEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}auto_pay_enabled'])!,
      autoPayTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}auto_pay_time'])!,
    );
  }

  @override
  $RecurringPaymentsTable createAlias(String alias) {
    return $RecurringPaymentsTable(attachedDatabase, alias);
  }
}

class RecurringPaymentEntry extends DataClass
    implements Insertable<RecurringPaymentEntry> {
  final String id;
  final String name;
  final String accountId;
  final String categoryId;
  final double amount;
  final String paymentType;
  final int freqVal;
  final String freqUnit;
  final String startDate;
  final String nextDate;
  final String? endDate;
  final int paidPayments;
  final int reminderEnabled;
  final String reminderTime;
  final int earlyReminderEnabled;
  final String notes;
  final String recurringType;
  final int autoPayEnabled;
  final String autoPayTime;
  const RecurringPaymentEntry(
      {required this.id,
      required this.name,
      required this.accountId,
      required this.categoryId,
      required this.amount,
      required this.paymentType,
      required this.freqVal,
      required this.freqUnit,
      required this.startDate,
      required this.nextDate,
      this.endDate,
      required this.paidPayments,
      required this.reminderEnabled,
      required this.reminderTime,
      required this.earlyReminderEnabled,
      required this.notes,
      required this.recurringType,
      required this.autoPayEnabled,
      required this.autoPayTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['account_id'] = Variable<String>(accountId);
    map['category_id'] = Variable<String>(categoryId);
    map['amount'] = Variable<double>(amount);
    map['payment_type'] = Variable<String>(paymentType);
    map['freq_val'] = Variable<int>(freqVal);
    map['freq_unit'] = Variable<String>(freqUnit);
    map['start_date'] = Variable<String>(startDate);
    map['next_date'] = Variable<String>(nextDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<String>(endDate);
    }
    map['paid_payments'] = Variable<int>(paidPayments);
    map['reminder_enabled'] = Variable<int>(reminderEnabled);
    map['reminder_time'] = Variable<String>(reminderTime);
    map['early_reminder_enabled'] = Variable<int>(earlyReminderEnabled);
    map['notes'] = Variable<String>(notes);
    map['recurring_type'] = Variable<String>(recurringType);
    map['auto_pay_enabled'] = Variable<int>(autoPayEnabled);
    map['auto_pay_time'] = Variable<String>(autoPayTime);
    return map;
  }

  RecurringPaymentsCompanion toCompanion(bool nullToAbsent) {
    return RecurringPaymentsCompanion(
      id: Value(id),
      name: Value(name),
      accountId: Value(accountId),
      categoryId: Value(categoryId),
      amount: Value(amount),
      paymentType: Value(paymentType),
      freqVal: Value(freqVal),
      freqUnit: Value(freqUnit),
      startDate: Value(startDate),
      nextDate: Value(nextDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      paidPayments: Value(paidPayments),
      reminderEnabled: Value(reminderEnabled),
      reminderTime: Value(reminderTime),
      earlyReminderEnabled: Value(earlyReminderEnabled),
      notes: Value(notes),
      recurringType: Value(recurringType),
      autoPayEnabled: Value(autoPayEnabled),
      autoPayTime: Value(autoPayTime),
    );
  }

  factory RecurringPaymentEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurringPaymentEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      accountId: serializer.fromJson<String>(json['accountId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      amount: serializer.fromJson<double>(json['amount']),
      paymentType: serializer.fromJson<String>(json['paymentType']),
      freqVal: serializer.fromJson<int>(json['freqVal']),
      freqUnit: serializer.fromJson<String>(json['freqUnit']),
      startDate: serializer.fromJson<String>(json['startDate']),
      nextDate: serializer.fromJson<String>(json['nextDate']),
      endDate: serializer.fromJson<String?>(json['endDate']),
      paidPayments: serializer.fromJson<int>(json['paidPayments']),
      reminderEnabled: serializer.fromJson<int>(json['reminderEnabled']),
      reminderTime: serializer.fromJson<String>(json['reminderTime']),
      earlyReminderEnabled:
          serializer.fromJson<int>(json['earlyReminderEnabled']),
      notes: serializer.fromJson<String>(json['notes']),
      recurringType: serializer.fromJson<String>(json['recurringType']),
      autoPayEnabled: serializer.fromJson<int>(json['autoPayEnabled']),
      autoPayTime: serializer.fromJson<String>(json['autoPayTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'accountId': serializer.toJson<String>(accountId),
      'categoryId': serializer.toJson<String>(categoryId),
      'amount': serializer.toJson<double>(amount),
      'paymentType': serializer.toJson<String>(paymentType),
      'freqVal': serializer.toJson<int>(freqVal),
      'freqUnit': serializer.toJson<String>(freqUnit),
      'startDate': serializer.toJson<String>(startDate),
      'nextDate': serializer.toJson<String>(nextDate),
      'endDate': serializer.toJson<String?>(endDate),
      'paidPayments': serializer.toJson<int>(paidPayments),
      'reminderEnabled': serializer.toJson<int>(reminderEnabled),
      'reminderTime': serializer.toJson<String>(reminderTime),
      'earlyReminderEnabled': serializer.toJson<int>(earlyReminderEnabled),
      'notes': serializer.toJson<String>(notes),
      'recurringType': serializer.toJson<String>(recurringType),
      'autoPayEnabled': serializer.toJson<int>(autoPayEnabled),
      'autoPayTime': serializer.toJson<String>(autoPayTime),
    };
  }

  RecurringPaymentEntry copyWith(
          {String? id,
          String? name,
          String? accountId,
          String? categoryId,
          double? amount,
          String? paymentType,
          int? freqVal,
          String? freqUnit,
          String? startDate,
          String? nextDate,
          Value<String?> endDate = const Value.absent(),
          int? paidPayments,
          int? reminderEnabled,
          String? reminderTime,
          int? earlyReminderEnabled,
          String? notes,
          String? recurringType,
          int? autoPayEnabled,
          String? autoPayTime}) =>
      RecurringPaymentEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        accountId: accountId ?? this.accountId,
        categoryId: categoryId ?? this.categoryId,
        amount: amount ?? this.amount,
        paymentType: paymentType ?? this.paymentType,
        freqVal: freqVal ?? this.freqVal,
        freqUnit: freqUnit ?? this.freqUnit,
        startDate: startDate ?? this.startDate,
        nextDate: nextDate ?? this.nextDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        paidPayments: paidPayments ?? this.paidPayments,
        reminderEnabled: reminderEnabled ?? this.reminderEnabled,
        reminderTime: reminderTime ?? this.reminderTime,
        earlyReminderEnabled: earlyReminderEnabled ?? this.earlyReminderEnabled,
        notes: notes ?? this.notes,
        recurringType: recurringType ?? this.recurringType,
        autoPayEnabled: autoPayEnabled ?? this.autoPayEnabled,
        autoPayTime: autoPayTime ?? this.autoPayTime,
      );
  RecurringPaymentEntry copyWithCompanion(RecurringPaymentsCompanion data) {
    return RecurringPaymentEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentType:
          data.paymentType.present ? data.paymentType.value : this.paymentType,
      freqVal: data.freqVal.present ? data.freqVal.value : this.freqVal,
      freqUnit: data.freqUnit.present ? data.freqUnit.value : this.freqUnit,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      nextDate: data.nextDate.present ? data.nextDate.value : this.nextDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      paidPayments: data.paidPayments.present
          ? data.paidPayments.value
          : this.paidPayments,
      reminderEnabled: data.reminderEnabled.present
          ? data.reminderEnabled.value
          : this.reminderEnabled,
      reminderTime: data.reminderTime.present
          ? data.reminderTime.value
          : this.reminderTime,
      earlyReminderEnabled: data.earlyReminderEnabled.present
          ? data.earlyReminderEnabled.value
          : this.earlyReminderEnabled,
      notes: data.notes.present ? data.notes.value : this.notes,
      recurringType: data.recurringType.present
          ? data.recurringType.value
          : this.recurringType,
      autoPayEnabled: data.autoPayEnabled.present
          ? data.autoPayEnabled.value
          : this.autoPayEnabled,
      autoPayTime:
          data.autoPayTime.present ? data.autoPayTime.value : this.autoPayTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurringPaymentEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('paymentType: $paymentType, ')
          ..write('freqVal: $freqVal, ')
          ..write('freqUnit: $freqUnit, ')
          ..write('startDate: $startDate, ')
          ..write('nextDate: $nextDate, ')
          ..write('endDate: $endDate, ')
          ..write('paidPayments: $paidPayments, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('earlyReminderEnabled: $earlyReminderEnabled, ')
          ..write('notes: $notes, ')
          ..write('recurringType: $recurringType, ')
          ..write('autoPayEnabled: $autoPayEnabled, ')
          ..write('autoPayTime: $autoPayTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      accountId,
      categoryId,
      amount,
      paymentType,
      freqVal,
      freqUnit,
      startDate,
      nextDate,
      endDate,
      paidPayments,
      reminderEnabled,
      reminderTime,
      earlyReminderEnabled,
      notes,
      recurringType,
      autoPayEnabled,
      autoPayTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurringPaymentEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.accountId == this.accountId &&
          other.categoryId == this.categoryId &&
          other.amount == this.amount &&
          other.paymentType == this.paymentType &&
          other.freqVal == this.freqVal &&
          other.freqUnit == this.freqUnit &&
          other.startDate == this.startDate &&
          other.nextDate == this.nextDate &&
          other.endDate == this.endDate &&
          other.paidPayments == this.paidPayments &&
          other.reminderEnabled == this.reminderEnabled &&
          other.reminderTime == this.reminderTime &&
          other.earlyReminderEnabled == this.earlyReminderEnabled &&
          other.notes == this.notes &&
          other.recurringType == this.recurringType &&
          other.autoPayEnabled == this.autoPayEnabled &&
          other.autoPayTime == this.autoPayTime);
}

class RecurringPaymentsCompanion
    extends UpdateCompanion<RecurringPaymentEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> accountId;
  final Value<String> categoryId;
  final Value<double> amount;
  final Value<String> paymentType;
  final Value<int> freqVal;
  final Value<String> freqUnit;
  final Value<String> startDate;
  final Value<String> nextDate;
  final Value<String?> endDate;
  final Value<int> paidPayments;
  final Value<int> reminderEnabled;
  final Value<String> reminderTime;
  final Value<int> earlyReminderEnabled;
  final Value<String> notes;
  final Value<String> recurringType;
  final Value<int> autoPayEnabled;
  final Value<String> autoPayTime;
  final Value<int> rowid;
  const RecurringPaymentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.accountId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentType = const Value.absent(),
    this.freqVal = const Value.absent(),
    this.freqUnit = const Value.absent(),
    this.startDate = const Value.absent(),
    this.nextDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.paidPayments = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.earlyReminderEnabled = const Value.absent(),
    this.notes = const Value.absent(),
    this.recurringType = const Value.absent(),
    this.autoPayEnabled = const Value.absent(),
    this.autoPayTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecurringPaymentsCompanion.insert({
    required String id,
    required String name,
    required String accountId,
    required String categoryId,
    required double amount,
    this.paymentType = const Value.absent(),
    this.freqVal = const Value.absent(),
    this.freqUnit = const Value.absent(),
    required String startDate,
    required String nextDate,
    this.endDate = const Value.absent(),
    this.paidPayments = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.earlyReminderEnabled = const Value.absent(),
    this.notes = const Value.absent(),
    this.recurringType = const Value.absent(),
    this.autoPayEnabled = const Value.absent(),
    this.autoPayTime = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        accountId = Value(accountId),
        categoryId = Value(categoryId),
        amount = Value(amount),
        startDate = Value(startDate),
        nextDate = Value(nextDate);
  static Insertable<RecurringPaymentEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? accountId,
    Expression<String>? categoryId,
    Expression<double>? amount,
    Expression<String>? paymentType,
    Expression<int>? freqVal,
    Expression<String>? freqUnit,
    Expression<String>? startDate,
    Expression<String>? nextDate,
    Expression<String>? endDate,
    Expression<int>? paidPayments,
    Expression<int>? reminderEnabled,
    Expression<String>? reminderTime,
    Expression<int>? earlyReminderEnabled,
    Expression<String>? notes,
    Expression<String>? recurringType,
    Expression<int>? autoPayEnabled,
    Expression<String>? autoPayTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (accountId != null) 'account_id': accountId,
      if (categoryId != null) 'category_id': categoryId,
      if (amount != null) 'amount': amount,
      if (paymentType != null) 'payment_type': paymentType,
      if (freqVal != null) 'freq_val': freqVal,
      if (freqUnit != null) 'freq_unit': freqUnit,
      if (startDate != null) 'start_date': startDate,
      if (nextDate != null) 'next_date': nextDate,
      if (endDate != null) 'end_date': endDate,
      if (paidPayments != null) 'paid_payments': paidPayments,
      if (reminderEnabled != null) 'reminder_enabled': reminderEnabled,
      if (reminderTime != null) 'reminder_time': reminderTime,
      if (earlyReminderEnabled != null)
        'early_reminder_enabled': earlyReminderEnabled,
      if (notes != null) 'notes': notes,
      if (recurringType != null) 'recurring_type': recurringType,
      if (autoPayEnabled != null) 'auto_pay_enabled': autoPayEnabled,
      if (autoPayTime != null) 'auto_pay_time': autoPayTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecurringPaymentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? accountId,
      Value<String>? categoryId,
      Value<double>? amount,
      Value<String>? paymentType,
      Value<int>? freqVal,
      Value<String>? freqUnit,
      Value<String>? startDate,
      Value<String>? nextDate,
      Value<String?>? endDate,
      Value<int>? paidPayments,
      Value<int>? reminderEnabled,
      Value<String>? reminderTime,
      Value<int>? earlyReminderEnabled,
      Value<String>? notes,
      Value<String>? recurringType,
      Value<int>? autoPayEnabled,
      Value<String>? autoPayTime,
      Value<int>? rowid}) {
    return RecurringPaymentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      paymentType: paymentType ?? this.paymentType,
      freqVal: freqVal ?? this.freqVal,
      freqUnit: freqUnit ?? this.freqUnit,
      startDate: startDate ?? this.startDate,
      nextDate: nextDate ?? this.nextDate,
      endDate: endDate ?? this.endDate,
      paidPayments: paidPayments ?? this.paidPayments,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderTime: reminderTime ?? this.reminderTime,
      earlyReminderEnabled: earlyReminderEnabled ?? this.earlyReminderEnabled,
      notes: notes ?? this.notes,
      recurringType: recurringType ?? this.recurringType,
      autoPayEnabled: autoPayEnabled ?? this.autoPayEnabled,
      autoPayTime: autoPayTime ?? this.autoPayTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paymentType.present) {
      map['payment_type'] = Variable<String>(paymentType.value);
    }
    if (freqVal.present) {
      map['freq_val'] = Variable<int>(freqVal.value);
    }
    if (freqUnit.present) {
      map['freq_unit'] = Variable<String>(freqUnit.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (nextDate.present) {
      map['next_date'] = Variable<String>(nextDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (paidPayments.present) {
      map['paid_payments'] = Variable<int>(paidPayments.value);
    }
    if (reminderEnabled.present) {
      map['reminder_enabled'] = Variable<int>(reminderEnabled.value);
    }
    if (reminderTime.present) {
      map['reminder_time'] = Variable<String>(reminderTime.value);
    }
    if (earlyReminderEnabled.present) {
      map['early_reminder_enabled'] = Variable<int>(earlyReminderEnabled.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (recurringType.present) {
      map['recurring_type'] = Variable<String>(recurringType.value);
    }
    if (autoPayEnabled.present) {
      map['auto_pay_enabled'] = Variable<int>(autoPayEnabled.value);
    }
    if (autoPayTime.present) {
      map['auto_pay_time'] = Variable<String>(autoPayTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurringPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('paymentType: $paymentType, ')
          ..write('freqVal: $freqVal, ')
          ..write('freqUnit: $freqUnit, ')
          ..write('startDate: $startDate, ')
          ..write('nextDate: $nextDate, ')
          ..write('endDate: $endDate, ')
          ..write('paidPayments: $paidPayments, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('earlyReminderEnabled: $earlyReminderEnabled, ')
          ..write('notes: $notes, ')
          ..write('recurringType: $recurringType, ')
          ..write('autoPayEnabled: $autoPayEnabled, ')
          ..write('autoPayTime: $autoPayTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WishlistTable extends Wishlist
    with TableInfo<$WishlistTable, WishlistEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WishlistTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetPriceMeta =
      const VerificationMeta('targetPrice');
  @override
  late final GeneratedColumn<double> targetPrice = GeneratedColumn<double>(
      'target_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
      'priority', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isPurchasedMeta =
      const VerificationMeta('isPurchased');
  @override
  late final GeneratedColumn<int> isPurchased = GeneratedColumn<int>(
      'is_purchased', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
      'goal_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, targetPrice, priority, isPurchased, notes, createdAt, goalId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wishlist';
  @override
  VerificationContext validateIntegrity(Insertable<WishlistEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('target_price')) {
      context.handle(
          _targetPriceMeta,
          targetPrice.isAcceptableOrUnknown(
              data['target_price']!, _targetPriceMeta));
    } else if (isInserting) {
      context.missing(_targetPriceMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('is_purchased')) {
      context.handle(
          _isPurchasedMeta,
          isPurchased.isAcceptableOrUnknown(
              data['is_purchased']!, _isPurchasedMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(_goalIdMeta,
          goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WishlistEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WishlistEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      targetPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_price'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}priority'])!,
      isPurchased: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_purchased'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}goal_id']),
    );
  }

  @override
  $WishlistTable createAlias(String alias) {
    return $WishlistTable(attachedDatabase, alias);
  }
}

class WishlistEntry extends DataClass implements Insertable<WishlistEntry> {
  final String id;
  final String name;
  final double targetPrice;
  final String priority;
  final int isPurchased;
  final String notes;
  final String createdAt;
  final String? goalId;
  const WishlistEntry(
      {required this.id,
      required this.name,
      required this.targetPrice,
      required this.priority,
      required this.isPurchased,
      required this.notes,
      required this.createdAt,
      this.goalId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['target_price'] = Variable<double>(targetPrice);
    map['priority'] = Variable<String>(priority);
    map['is_purchased'] = Variable<int>(isPurchased);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<String>(createdAt);
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<String>(goalId);
    }
    return map;
  }

  WishlistCompanion toCompanion(bool nullToAbsent) {
    return WishlistCompanion(
      id: Value(id),
      name: Value(name),
      targetPrice: Value(targetPrice),
      priority: Value(priority),
      isPurchased: Value(isPurchased),
      notes: Value(notes),
      createdAt: Value(createdAt),
      goalId:
          goalId == null && nullToAbsent ? const Value.absent() : Value(goalId),
    );
  }

  factory WishlistEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WishlistEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      targetPrice: serializer.fromJson<double>(json['targetPrice']),
      priority: serializer.fromJson<String>(json['priority']),
      isPurchased: serializer.fromJson<int>(json['isPurchased']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      goalId: serializer.fromJson<String?>(json['goalId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'targetPrice': serializer.toJson<double>(targetPrice),
      'priority': serializer.toJson<String>(priority),
      'isPurchased': serializer.toJson<int>(isPurchased),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<String>(createdAt),
      'goalId': serializer.toJson<String?>(goalId),
    };
  }

  WishlistEntry copyWith(
          {String? id,
          String? name,
          double? targetPrice,
          String? priority,
          int? isPurchased,
          String? notes,
          String? createdAt,
          Value<String?> goalId = const Value.absent()}) =>
      WishlistEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        targetPrice: targetPrice ?? this.targetPrice,
        priority: priority ?? this.priority,
        isPurchased: isPurchased ?? this.isPurchased,
        notes: notes ?? this.notes,
        createdAt: createdAt ?? this.createdAt,
        goalId: goalId.present ? goalId.value : this.goalId,
      );
  WishlistEntry copyWithCompanion(WishlistCompanion data) {
    return WishlistEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      targetPrice:
          data.targetPrice.present ? data.targetPrice.value : this.targetPrice,
      priority: data.priority.present ? data.priority.value : this.priority,
      isPurchased:
          data.isPurchased.present ? data.isPurchased.value : this.isPurchased,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WishlistEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('targetPrice: $targetPrice, ')
          ..write('priority: $priority, ')
          ..write('isPurchased: $isPurchased, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('goalId: $goalId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, targetPrice, priority, isPurchased, notes, createdAt, goalId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WishlistEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.targetPrice == this.targetPrice &&
          other.priority == this.priority &&
          other.isPurchased == this.isPurchased &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.goalId == this.goalId);
}

class WishlistCompanion extends UpdateCompanion<WishlistEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> targetPrice;
  final Value<String> priority;
  final Value<int> isPurchased;
  final Value<String> notes;
  final Value<String> createdAt;
  final Value<String?> goalId;
  final Value<int> rowid;
  const WishlistCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.targetPrice = const Value.absent(),
    this.priority = const Value.absent(),
    this.isPurchased = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.goalId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WishlistCompanion.insert({
    required String id,
    required String name,
    required double targetPrice,
    required String priority,
    this.isPurchased = const Value.absent(),
    this.notes = const Value.absent(),
    required String createdAt,
    this.goalId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        targetPrice = Value(targetPrice),
        priority = Value(priority),
        createdAt = Value(createdAt);
  static Insertable<WishlistEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? targetPrice,
    Expression<String>? priority,
    Expression<int>? isPurchased,
    Expression<String>? notes,
    Expression<String>? createdAt,
    Expression<String>? goalId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (targetPrice != null) 'target_price': targetPrice,
      if (priority != null) 'priority': priority,
      if (isPurchased != null) 'is_purchased': isPurchased,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (goalId != null) 'goal_id': goalId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WishlistCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<double>? targetPrice,
      Value<String>? priority,
      Value<int>? isPurchased,
      Value<String>? notes,
      Value<String>? createdAt,
      Value<String?>? goalId,
      Value<int>? rowid}) {
    return WishlistCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      targetPrice: targetPrice ?? this.targetPrice,
      priority: priority ?? this.priority,
      isPurchased: isPurchased ?? this.isPurchased,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      goalId: goalId ?? this.goalId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (targetPrice.present) {
      map['target_price'] = Variable<double>(targetPrice.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (isPurchased.present) {
      map['is_purchased'] = Variable<int>(isPurchased.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WishlistCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('targetPrice: $targetPrice, ')
          ..write('priority: $priority, ')
          ..write('isPurchased: $isPurchased, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('goalId: $goalId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AssetItemsTable extends AssetItems
    with TableInfo<$AssetItemsTable, AssetItemEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssetItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _colorValueMeta =
      const VerificationMeta('colorValue');
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
      'color_value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, value, colorValue, notes, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'asset_items';
  @override
  VerificationContext validateIntegrity(Insertable<AssetItemEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
          _colorValueMeta,
          colorValue.isAcceptableOrUnknown(
              data['color_value']!, _colorValueMeta));
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AssetItemEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssetItemEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value'])!,
      colorValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color_value'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AssetItemsTable createAlias(String alias) {
    return $AssetItemsTable(attachedDatabase, alias);
  }
}

class AssetItemEntry extends DataClass implements Insertable<AssetItemEntry> {
  final String id;
  final String name;
  final double value;
  final int colorValue;
  final String? notes;
  final String createdAt;
  const AssetItemEntry(
      {required this.id,
      required this.name,
      required this.value,
      required this.colorValue,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['value'] = Variable<double>(value);
    map['color_value'] = Variable<int>(colorValue);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  AssetItemsCompanion toCompanion(bool nullToAbsent) {
    return AssetItemsCompanion(
      id: Value(id),
      name: Value(name),
      value: Value(value),
      colorValue: Value(colorValue),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory AssetItemEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssetItemEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      value: serializer.fromJson<double>(json['value']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<double>(value),
      'colorValue': serializer.toJson<int>(colorValue),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  AssetItemEntry copyWith(
          {String? id,
          String? name,
          double? value,
          int? colorValue,
          Value<String?> notes = const Value.absent(),
          String? createdAt}) =>
      AssetItemEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        value: value ?? this.value,
        colorValue: colorValue ?? this.colorValue,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  AssetItemEntry copyWithCompanion(AssetItemsCompanion data) {
    return AssetItemEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      value: data.value.present ? data.value.value : this.value,
      colorValue:
          data.colorValue.present ? data.colorValue.value : this.colorValue,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AssetItemEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('colorValue: $colorValue, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, value, colorValue, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssetItemEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.value == this.value &&
          other.colorValue == this.colorValue &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class AssetItemsCompanion extends UpdateCompanion<AssetItemEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> value;
  final Value<int> colorValue;
  final Value<String?> notes;
  final Value<String> createdAt;
  final Value<int> rowid;
  const AssetItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.value = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AssetItemsCompanion.insert({
    required String id,
    required String name,
    required double value,
    required int colorValue,
    this.notes = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        value = Value(value),
        colorValue = Value(colorValue),
        createdAt = Value(createdAt);
  static Insertable<AssetItemEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? value,
    Expression<int>? colorValue,
    Expression<String>? notes,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (value != null) 'value': value,
      if (colorValue != null) 'color_value': colorValue,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AssetItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<double>? value,
      Value<int>? colorValue,
      Value<String?>? notes,
      Value<String>? createdAt,
      Value<int>? rowid}) {
    return AssetItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      colorValue: colorValue ?? this.colorValue,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssetItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('colorValue: $colorValue, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NetWorthSnapshotsTable extends NetWorthSnapshots
    with TableInfo<$NetWorthSnapshotsTable, NetWorthSnapshotEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NetWorthSnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalAccountsMeta =
      const VerificationMeta('totalAccounts');
  @override
  late final GeneratedColumn<double> totalAccounts = GeneratedColumn<double>(
      'total_accounts', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalAssetsMeta =
      const VerificationMeta('totalAssets');
  @override
  late final GeneratedColumn<double> totalAssets = GeneratedColumn<double>(
      'total_assets', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _netWorthMeta =
      const VerificationMeta('netWorth');
  @override
  late final GeneratedColumn<double> netWorth = GeneratedColumn<double>(
      'net_worth', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, totalAccounts, totalAssets, netWorth, currency];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'net_worth_snapshots';
  @override
  VerificationContext validateIntegrity(
      Insertable<NetWorthSnapshotEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('total_accounts')) {
      context.handle(
          _totalAccountsMeta,
          totalAccounts.isAcceptableOrUnknown(
              data['total_accounts']!, _totalAccountsMeta));
    } else if (isInserting) {
      context.missing(_totalAccountsMeta);
    }
    if (data.containsKey('total_assets')) {
      context.handle(
          _totalAssetsMeta,
          totalAssets.isAcceptableOrUnknown(
              data['total_assets']!, _totalAssetsMeta));
    } else if (isInserting) {
      context.missing(_totalAssetsMeta);
    }
    if (data.containsKey('net_worth')) {
      context.handle(_netWorthMeta,
          netWorth.isAcceptableOrUnknown(data['net_worth']!, _netWorthMeta));
    } else if (isInserting) {
      context.missing(_netWorthMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NetWorthSnapshotEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NetWorthSnapshotEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      totalAccounts: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_accounts'])!,
      totalAssets: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_assets'])!,
      netWorth: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}net_worth'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
    );
  }

  @override
  $NetWorthSnapshotsTable createAlias(String alias) {
    return $NetWorthSnapshotsTable(attachedDatabase, alias);
  }
}

class NetWorthSnapshotEntry extends DataClass
    implements Insertable<NetWorthSnapshotEntry> {
  final String id;
  final String date;
  final double totalAccounts;
  final double totalAssets;
  final double netWorth;
  final String currency;
  const NetWorthSnapshotEntry(
      {required this.id,
      required this.date,
      required this.totalAccounts,
      required this.totalAssets,
      required this.netWorth,
      required this.currency});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['total_accounts'] = Variable<double>(totalAccounts);
    map['total_assets'] = Variable<double>(totalAssets);
    map['net_worth'] = Variable<double>(netWorth);
    map['currency'] = Variable<String>(currency);
    return map;
  }

  NetWorthSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return NetWorthSnapshotsCompanion(
      id: Value(id),
      date: Value(date),
      totalAccounts: Value(totalAccounts),
      totalAssets: Value(totalAssets),
      netWorth: Value(netWorth),
      currency: Value(currency),
    );
  }

  factory NetWorthSnapshotEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NetWorthSnapshotEntry(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      totalAccounts: serializer.fromJson<double>(json['totalAccounts']),
      totalAssets: serializer.fromJson<double>(json['totalAssets']),
      netWorth: serializer.fromJson<double>(json['netWorth']),
      currency: serializer.fromJson<String>(json['currency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'totalAccounts': serializer.toJson<double>(totalAccounts),
      'totalAssets': serializer.toJson<double>(totalAssets),
      'netWorth': serializer.toJson<double>(netWorth),
      'currency': serializer.toJson<String>(currency),
    };
  }

  NetWorthSnapshotEntry copyWith(
          {String? id,
          String? date,
          double? totalAccounts,
          double? totalAssets,
          double? netWorth,
          String? currency}) =>
      NetWorthSnapshotEntry(
        id: id ?? this.id,
        date: date ?? this.date,
        totalAccounts: totalAccounts ?? this.totalAccounts,
        totalAssets: totalAssets ?? this.totalAssets,
        netWorth: netWorth ?? this.netWorth,
        currency: currency ?? this.currency,
      );
  NetWorthSnapshotEntry copyWithCompanion(NetWorthSnapshotsCompanion data) {
    return NetWorthSnapshotEntry(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      totalAccounts: data.totalAccounts.present
          ? data.totalAccounts.value
          : this.totalAccounts,
      totalAssets:
          data.totalAssets.present ? data.totalAssets.value : this.totalAssets,
      netWorth: data.netWorth.present ? data.netWorth.value : this.netWorth,
      currency: data.currency.present ? data.currency.value : this.currency,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NetWorthSnapshotEntry(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('totalAccounts: $totalAccounts, ')
          ..write('totalAssets: $totalAssets, ')
          ..write('netWorth: $netWorth, ')
          ..write('currency: $currency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, totalAccounts, totalAssets, netWorth, currency);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NetWorthSnapshotEntry &&
          other.id == this.id &&
          other.date == this.date &&
          other.totalAccounts == this.totalAccounts &&
          other.totalAssets == this.totalAssets &&
          other.netWorth == this.netWorth &&
          other.currency == this.currency);
}

class NetWorthSnapshotsCompanion
    extends UpdateCompanion<NetWorthSnapshotEntry> {
  final Value<String> id;
  final Value<String> date;
  final Value<double> totalAccounts;
  final Value<double> totalAssets;
  final Value<double> netWorth;
  final Value<String> currency;
  final Value<int> rowid;
  const NetWorthSnapshotsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.totalAccounts = const Value.absent(),
    this.totalAssets = const Value.absent(),
    this.netWorth = const Value.absent(),
    this.currency = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NetWorthSnapshotsCompanion.insert({
    required String id,
    required String date,
    required double totalAccounts,
    required double totalAssets,
    required double netWorth,
    required String currency,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date),
        totalAccounts = Value(totalAccounts),
        totalAssets = Value(totalAssets),
        netWorth = Value(netWorth),
        currency = Value(currency);
  static Insertable<NetWorthSnapshotEntry> custom({
    Expression<String>? id,
    Expression<String>? date,
    Expression<double>? totalAccounts,
    Expression<double>? totalAssets,
    Expression<double>? netWorth,
    Expression<String>? currency,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (totalAccounts != null) 'total_accounts': totalAccounts,
      if (totalAssets != null) 'total_assets': totalAssets,
      if (netWorth != null) 'net_worth': netWorth,
      if (currency != null) 'currency': currency,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NetWorthSnapshotsCompanion copyWith(
      {Value<String>? id,
      Value<String>? date,
      Value<double>? totalAccounts,
      Value<double>? totalAssets,
      Value<double>? netWorth,
      Value<String>? currency,
      Value<int>? rowid}) {
    return NetWorthSnapshotsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      totalAccounts: totalAccounts ?? this.totalAccounts,
      totalAssets: totalAssets ?? this.totalAssets,
      netWorth: netWorth ?? this.netWorth,
      currency: currency ?? this.currency,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (totalAccounts.present) {
      map['total_accounts'] = Variable<double>(totalAccounts.value);
    }
    if (totalAssets.present) {
      map['total_assets'] = Variable<double>(totalAssets.value);
    }
    if (netWorth.present) {
      map['net_worth'] = Variable<double>(netWorth.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NetWorthSnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('totalAccounts: $totalAccounts, ')
          ..write('totalAssets: $totalAssets, ')
          ..write('netWorth: $netWorth, ')
          ..write('currency: $currency, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LendedPeopleTable extends LendedPeople
    with TableInfo<$LendedPeopleTable, LendedPersonEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LendedPeopleTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorValueMeta =
      const VerificationMeta('colorValue');
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
      'color_value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, colorValue, notes, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lended_people';
  @override
  VerificationContext validateIntegrity(Insertable<LendedPersonEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
          _colorValueMeta,
          colorValue.isAcceptableOrUnknown(
              data['color_value']!, _colorValueMeta));
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LendedPersonEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LendedPersonEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      colorValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color_value'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $LendedPeopleTable createAlias(String alias) {
    return $LendedPeopleTable(attachedDatabase, alias);
  }
}

class LendedPersonEntry extends DataClass
    implements Insertable<LendedPersonEntry> {
  final String id;
  final String name;
  final int colorValue;
  final String notes;
  final String createdAt;
  const LendedPersonEntry(
      {required this.id,
      required this.name,
      required this.colorValue,
      required this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['color_value'] = Variable<int>(colorValue);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  LendedPeopleCompanion toCompanion(bool nullToAbsent) {
    return LendedPeopleCompanion(
      id: Value(id),
      name: Value(name),
      colorValue: Value(colorValue),
      notes: Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory LendedPersonEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LendedPersonEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'colorValue': serializer.toJson<int>(colorValue),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  LendedPersonEntry copyWith(
          {String? id,
          String? name,
          int? colorValue,
          String? notes,
          String? createdAt}) =>
      LendedPersonEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        colorValue: colorValue ?? this.colorValue,
        notes: notes ?? this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  LendedPersonEntry copyWithCompanion(LendedPeopleCompanion data) {
    return LendedPersonEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      colorValue:
          data.colorValue.present ? data.colorValue.value : this.colorValue,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LendedPersonEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorValue: $colorValue, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, colorValue, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LendedPersonEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.colorValue == this.colorValue &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class LendedPeopleCompanion extends UpdateCompanion<LendedPersonEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> colorValue;
  final Value<String> notes;
  final Value<String> createdAt;
  final Value<int> rowid;
  const LendedPeopleCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LendedPeopleCompanion.insert({
    required String id,
    required String name,
    required int colorValue,
    this.notes = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        colorValue = Value(colorValue),
        createdAt = Value(createdAt);
  static Insertable<LendedPersonEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? colorValue,
    Expression<String>? notes,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (colorValue != null) 'color_value': colorValue,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LendedPeopleCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<int>? colorValue,
      Value<String>? notes,
      Value<String>? createdAt,
      Value<int>? rowid}) {
    return LendedPeopleCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LendedPeopleCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorValue: $colorValue, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LendedMoneyTableTable extends LendedMoneyTable
    with TableInfo<$LendedMoneyTableTable, LendedMoneyEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LendedMoneyTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _personIdMeta =
      const VerificationMeta('personId');
  @override
  late final GeneratedColumn<String> personId = GeneratedColumn<String>(
      'person_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _accountIdMeta =
      const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
      'account_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isSettledMeta =
      const VerificationMeta('isSettled');
  @override
  late final GeneratedColumn<int> isSettled = GeneratedColumn<int>(
      'is_settled', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<String> dueDate = GeneratedColumn<String>(
      'due_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _reminderEnabledMeta =
      const VerificationMeta('reminderEnabled');
  @override
  late final GeneratedColumn<int> reminderEnabled = GeneratedColumn<int>(
      'reminder_enabled', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _reminderTimeMeta =
      const VerificationMeta('reminderTime');
  @override
  late final GeneratedColumn<String> reminderTime = GeneratedColumn<String>(
      'reminder_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('09:00'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        personId,
        amount,
        type,
        accountId,
        isSettled,
        date,
        dueDate,
        notes,
        reminderEnabled,
        reminderTime
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lended_money';
  @override
  VerificationContext validateIntegrity(Insertable<LendedMoneyEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('person_id')) {
      context.handle(_personIdMeta,
          personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta));
    } else if (isInserting) {
      context.missing(_personIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    }
    if (data.containsKey('is_settled')) {
      context.handle(_isSettledMeta,
          isSettled.isAcceptableOrUnknown(data['is_settled']!, _isSettledMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('reminder_enabled')) {
      context.handle(
          _reminderEnabledMeta,
          reminderEnabled.isAcceptableOrUnknown(
              data['reminder_enabled']!, _reminderEnabledMeta));
    }
    if (data.containsKey('reminder_time')) {
      context.handle(
          _reminderTimeMeta,
          reminderTime.isAcceptableOrUnknown(
              data['reminder_time']!, _reminderTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LendedMoneyEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LendedMoneyEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      personId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}person_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      accountId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_id']),
      isSettled: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_settled'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}due_date']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      reminderEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reminder_enabled'])!,
      reminderTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reminder_time'])!,
    );
  }

  @override
  $LendedMoneyTableTable createAlias(String alias) {
    return $LendedMoneyTableTable(attachedDatabase, alias);
  }
}

class LendedMoneyEntry extends DataClass
    implements Insertable<LendedMoneyEntry> {
  final String id;
  final String personId;
  final double amount;
  final String type;
  final String? accountId;
  final int isSettled;
  final String date;
  final String? dueDate;
  final String notes;
  final int reminderEnabled;
  final String reminderTime;
  const LendedMoneyEntry(
      {required this.id,
      required this.personId,
      required this.amount,
      required this.type,
      this.accountId,
      required this.isSettled,
      required this.date,
      this.dueDate,
      required this.notes,
      required this.reminderEnabled,
      required this.reminderTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['person_id'] = Variable<String>(personId);
    map['amount'] = Variable<double>(amount);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    map['is_settled'] = Variable<int>(isSettled);
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<String>(dueDate);
    }
    map['notes'] = Variable<String>(notes);
    map['reminder_enabled'] = Variable<int>(reminderEnabled);
    map['reminder_time'] = Variable<String>(reminderTime);
    return map;
  }

  LendedMoneyTableCompanion toCompanion(bool nullToAbsent) {
    return LendedMoneyTableCompanion(
      id: Value(id),
      personId: Value(personId),
      amount: Value(amount),
      type: Value(type),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      isSettled: Value(isSettled),
      date: Value(date),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      notes: Value(notes),
      reminderEnabled: Value(reminderEnabled),
      reminderTime: Value(reminderTime),
    );
  }

  factory LendedMoneyEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LendedMoneyEntry(
      id: serializer.fromJson<String>(json['id']),
      personId: serializer.fromJson<String>(json['personId']),
      amount: serializer.fromJson<double>(json['amount']),
      type: serializer.fromJson<String>(json['type']),
      accountId: serializer.fromJson<String?>(json['accountId']),
      isSettled: serializer.fromJson<int>(json['isSettled']),
      date: serializer.fromJson<String>(json['date']),
      dueDate: serializer.fromJson<String?>(json['dueDate']),
      notes: serializer.fromJson<String>(json['notes']),
      reminderEnabled: serializer.fromJson<int>(json['reminderEnabled']),
      reminderTime: serializer.fromJson<String>(json['reminderTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'personId': serializer.toJson<String>(personId),
      'amount': serializer.toJson<double>(amount),
      'type': serializer.toJson<String>(type),
      'accountId': serializer.toJson<String?>(accountId),
      'isSettled': serializer.toJson<int>(isSettled),
      'date': serializer.toJson<String>(date),
      'dueDate': serializer.toJson<String?>(dueDate),
      'notes': serializer.toJson<String>(notes),
      'reminderEnabled': serializer.toJson<int>(reminderEnabled),
      'reminderTime': serializer.toJson<String>(reminderTime),
    };
  }

  LendedMoneyEntry copyWith(
          {String? id,
          String? personId,
          double? amount,
          String? type,
          Value<String?> accountId = const Value.absent(),
          int? isSettled,
          String? date,
          Value<String?> dueDate = const Value.absent(),
          String? notes,
          int? reminderEnabled,
          String? reminderTime}) =>
      LendedMoneyEntry(
        id: id ?? this.id,
        personId: personId ?? this.personId,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        accountId: accountId.present ? accountId.value : this.accountId,
        isSettled: isSettled ?? this.isSettled,
        date: date ?? this.date,
        dueDate: dueDate.present ? dueDate.value : this.dueDate,
        notes: notes ?? this.notes,
        reminderEnabled: reminderEnabled ?? this.reminderEnabled,
        reminderTime: reminderTime ?? this.reminderTime,
      );
  LendedMoneyEntry copyWithCompanion(LendedMoneyTableCompanion data) {
    return LendedMoneyEntry(
      id: data.id.present ? data.id.value : this.id,
      personId: data.personId.present ? data.personId.value : this.personId,
      amount: data.amount.present ? data.amount.value : this.amount,
      type: data.type.present ? data.type.value : this.type,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      isSettled: data.isSettled.present ? data.isSettled.value : this.isSettled,
      date: data.date.present ? data.date.value : this.date,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      reminderEnabled: data.reminderEnabled.present
          ? data.reminderEnabled.value
          : this.reminderEnabled,
      reminderTime: data.reminderTime.present
          ? data.reminderTime.value
          : this.reminderTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LendedMoneyEntry(')
          ..write('id: $id, ')
          ..write('personId: $personId, ')
          ..write('amount: $amount, ')
          ..write('type: $type, ')
          ..write('accountId: $accountId, ')
          ..write('isSettled: $isSettled, ')
          ..write('date: $date, ')
          ..write('dueDate: $dueDate, ')
          ..write('notes: $notes, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('reminderTime: $reminderTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, personId, amount, type, accountId,
      isSettled, date, dueDate, notes, reminderEnabled, reminderTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LendedMoneyEntry &&
          other.id == this.id &&
          other.personId == this.personId &&
          other.amount == this.amount &&
          other.type == this.type &&
          other.accountId == this.accountId &&
          other.isSettled == this.isSettled &&
          other.date == this.date &&
          other.dueDate == this.dueDate &&
          other.notes == this.notes &&
          other.reminderEnabled == this.reminderEnabled &&
          other.reminderTime == this.reminderTime);
}

class LendedMoneyTableCompanion extends UpdateCompanion<LendedMoneyEntry> {
  final Value<String> id;
  final Value<String> personId;
  final Value<double> amount;
  final Value<String> type;
  final Value<String?> accountId;
  final Value<int> isSettled;
  final Value<String> date;
  final Value<String?> dueDate;
  final Value<String> notes;
  final Value<int> reminderEnabled;
  final Value<String> reminderTime;
  final Value<int> rowid;
  const LendedMoneyTableCompanion({
    this.id = const Value.absent(),
    this.personId = const Value.absent(),
    this.amount = const Value.absent(),
    this.type = const Value.absent(),
    this.accountId = const Value.absent(),
    this.isSettled = const Value.absent(),
    this.date = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LendedMoneyTableCompanion.insert({
    required String id,
    required String personId,
    required double amount,
    required String type,
    this.accountId = const Value.absent(),
    this.isSettled = const Value.absent(),
    required String date,
    this.dueDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        personId = Value(personId),
        amount = Value(amount),
        type = Value(type),
        date = Value(date);
  static Insertable<LendedMoneyEntry> custom({
    Expression<String>? id,
    Expression<String>? personId,
    Expression<double>? amount,
    Expression<String>? type,
    Expression<String>? accountId,
    Expression<int>? isSettled,
    Expression<String>? date,
    Expression<String>? dueDate,
    Expression<String>? notes,
    Expression<int>? reminderEnabled,
    Expression<String>? reminderTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (personId != null) 'person_id': personId,
      if (amount != null) 'amount': amount,
      if (type != null) 'type': type,
      if (accountId != null) 'account_id': accountId,
      if (isSettled != null) 'is_settled': isSettled,
      if (date != null) 'date': date,
      if (dueDate != null) 'due_date': dueDate,
      if (notes != null) 'notes': notes,
      if (reminderEnabled != null) 'reminder_enabled': reminderEnabled,
      if (reminderTime != null) 'reminder_time': reminderTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LendedMoneyTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? personId,
      Value<double>? amount,
      Value<String>? type,
      Value<String?>? accountId,
      Value<int>? isSettled,
      Value<String>? date,
      Value<String?>? dueDate,
      Value<String>? notes,
      Value<int>? reminderEnabled,
      Value<String>? reminderTime,
      Value<int>? rowid}) {
    return LendedMoneyTableCompanion(
      id: id ?? this.id,
      personId: personId ?? this.personId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      accountId: accountId ?? this.accountId,
      isSettled: isSettled ?? this.isSettled,
      date: date ?? this.date,
      dueDate: dueDate ?? this.dueDate,
      notes: notes ?? this.notes,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderTime: reminderTime ?? this.reminderTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<String>(personId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (isSettled.present) {
      map['is_settled'] = Variable<int>(isSettled.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<String>(dueDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (reminderEnabled.present) {
      map['reminder_enabled'] = Variable<int>(reminderEnabled.value);
    }
    if (reminderTime.present) {
      map['reminder_time'] = Variable<String>(reminderTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LendedMoneyTableCompanion(')
          ..write('id: $id, ')
          ..write('personId: $personId, ')
          ..write('amount: $amount, ')
          ..write('type: $type, ')
          ..write('accountId: $accountId, ')
          ..write('isSettled: $isSettled, ')
          ..write('date: $date, ')
          ..write('dueDate: $dueDate, ')
          ..write('notes: $notes, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AssetsTable extends Assets with TableInfo<$AssetsTable, AssetEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('EGP'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, value, currency, notes, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assets';
  @override
  VerificationContext validateIntegrity(Insertable<AssetEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AssetEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssetEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AssetsTable createAlias(String alias) {
    return $AssetsTable(attachedDatabase, alias);
  }
}

class AssetEntry extends DataClass implements Insertable<AssetEntry> {
  final String id;
  final String name;
  final double value;
  final String currency;
  final String notes;
  final String createdAt;
  const AssetEntry(
      {required this.id,
      required this.name,
      required this.value,
      required this.currency,
      required this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['value'] = Variable<double>(value);
    map['currency'] = Variable<String>(currency);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  AssetsCompanion toCompanion(bool nullToAbsent) {
    return AssetsCompanion(
      id: Value(id),
      name: Value(name),
      value: Value(value),
      currency: Value(currency),
      notes: Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory AssetEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssetEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      value: serializer.fromJson<double>(json['value']),
      currency: serializer.fromJson<String>(json['currency']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<double>(value),
      'currency': serializer.toJson<String>(currency),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  AssetEntry copyWith(
          {String? id,
          String? name,
          double? value,
          String? currency,
          String? notes,
          String? createdAt}) =>
      AssetEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        value: value ?? this.value,
        currency: currency ?? this.currency,
        notes: notes ?? this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  AssetEntry copyWithCompanion(AssetsCompanion data) {
    return AssetEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      value: data.value.present ? data.value.value : this.value,
      currency: data.currency.present ? data.currency.value : this.currency,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AssetEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('currency: $currency, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, value, currency, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssetEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.value == this.value &&
          other.currency == this.currency &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class AssetsCompanion extends UpdateCompanion<AssetEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> value;
  final Value<String> currency;
  final Value<String> notes;
  final Value<String> createdAt;
  final Value<int> rowid;
  const AssetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.value = const Value.absent(),
    this.currency = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AssetsCompanion.insert({
    required String id,
    required String name,
    required double value,
    this.currency = const Value.absent(),
    this.notes = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        value = Value(value),
        createdAt = Value(createdAt);
  static Insertable<AssetEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? value,
    Expression<String>? currency,
    Expression<String>? notes,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (value != null) 'value': value,
      if (currency != null) 'currency': currency,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AssetsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<double>? value,
      Value<String>? currency,
      Value<String>? notes,
      Value<String>? createdAt,
      Value<int>? rowid}) {
    return AssetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      currency: currency ?? this.currency,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('currency: $currency, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetsTable extends Budgets with TableInfo<$BudgetsTable, BudgetEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _periodMeta = const VerificationMeta('period');
  @override
  late final GeneratedColumn<String> period = GeneratedColumn<String>(
      'period', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('monthly'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _allowRolloverMeta =
      const VerificationMeta('allowRollover');
  @override
  late final GeneratedColumn<int> allowRollover = GeneratedColumn<int>(
      'allow_rollover', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, categoryId, amount, period, createdAt, allowRollover];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budgets';
  @override
  VerificationContext validateIntegrity(Insertable<BudgetEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('period')) {
      context.handle(_periodMeta,
          period.isAcceptableOrUnknown(data['period']!, _periodMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('allow_rollover')) {
      context.handle(
          _allowRolloverMeta,
          allowRollover.isAcceptableOrUnknown(
              data['allow_rollover']!, _allowRolloverMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      period: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}period'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      allowRollover: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}allow_rollover'])!,
    );
  }

  @override
  $BudgetsTable createAlias(String alias) {
    return $BudgetsTable(attachedDatabase, alias);
  }
}

class BudgetEntry extends DataClass implements Insertable<BudgetEntry> {
  final String id;
  final String categoryId;
  final double amount;
  final String period;
  final String createdAt;
  final int allowRollover;
  const BudgetEntry(
      {required this.id,
      required this.categoryId,
      required this.amount,
      required this.period,
      required this.createdAt,
      required this.allowRollover});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category_id'] = Variable<String>(categoryId);
    map['amount'] = Variable<double>(amount);
    map['period'] = Variable<String>(period);
    map['created_at'] = Variable<String>(createdAt);
    map['allow_rollover'] = Variable<int>(allowRollover);
    return map;
  }

  BudgetsCompanion toCompanion(bool nullToAbsent) {
    return BudgetsCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      amount: Value(amount),
      period: Value(period),
      createdAt: Value(createdAt),
      allowRollover: Value(allowRollover),
    );
  }

  factory BudgetEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetEntry(
      id: serializer.fromJson<String>(json['id']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      amount: serializer.fromJson<double>(json['amount']),
      period: serializer.fromJson<String>(json['period']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      allowRollover: serializer.fromJson<int>(json['allowRollover']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'categoryId': serializer.toJson<String>(categoryId),
      'amount': serializer.toJson<double>(amount),
      'period': serializer.toJson<String>(period),
      'createdAt': serializer.toJson<String>(createdAt),
      'allowRollover': serializer.toJson<int>(allowRollover),
    };
  }

  BudgetEntry copyWith(
          {String? id,
          String? categoryId,
          double? amount,
          String? period,
          String? createdAt,
          int? allowRollover}) =>
      BudgetEntry(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        amount: amount ?? this.amount,
        period: period ?? this.period,
        createdAt: createdAt ?? this.createdAt,
        allowRollover: allowRollover ?? this.allowRollover,
      );
  BudgetEntry copyWithCompanion(BudgetsCompanion data) {
    return BudgetEntry(
      id: data.id.present ? data.id.value : this.id,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      amount: data.amount.present ? data.amount.value : this.amount,
      period: data.period.present ? data.period.value : this.period,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      allowRollover: data.allowRollover.present
          ? data.allowRollover.value
          : this.allowRollover,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetEntry(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('period: $period, ')
          ..write('createdAt: $createdAt, ')
          ..write('allowRollover: $allowRollover')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, categoryId, amount, period, createdAt, allowRollover);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetEntry &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.amount == this.amount &&
          other.period == this.period &&
          other.createdAt == this.createdAt &&
          other.allowRollover == this.allowRollover);
}

class BudgetsCompanion extends UpdateCompanion<BudgetEntry> {
  final Value<String> id;
  final Value<String> categoryId;
  final Value<double> amount;
  final Value<String> period;
  final Value<String> createdAt;
  final Value<int> allowRollover;
  final Value<int> rowid;
  const BudgetsCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.amount = const Value.absent(),
    this.period = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.allowRollover = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetsCompanion.insert({
    required String id,
    required String categoryId,
    required double amount,
    this.period = const Value.absent(),
    required String createdAt,
    this.allowRollover = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        categoryId = Value(categoryId),
        amount = Value(amount),
        createdAt = Value(createdAt);
  static Insertable<BudgetEntry> custom({
    Expression<String>? id,
    Expression<String>? categoryId,
    Expression<double>? amount,
    Expression<String>? period,
    Expression<String>? createdAt,
    Expression<int>? allowRollover,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (amount != null) 'amount': amount,
      if (period != null) 'period': period,
      if (createdAt != null) 'created_at': createdAt,
      if (allowRollover != null) 'allow_rollover': allowRollover,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetsCompanion copyWith(
      {Value<String>? id,
      Value<String>? categoryId,
      Value<double>? amount,
      Value<String>? period,
      Value<String>? createdAt,
      Value<int>? allowRollover,
      Value<int>? rowid}) {
    return BudgetsCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      period: period ?? this.period,
      createdAt: createdAt ?? this.createdAt,
      allowRollover: allowRollover ?? this.allowRollover,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (period.present) {
      map['period'] = Variable<String>(period.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (allowRollover.present) {
      map['allow_rollover'] = Variable<int>(allowRollover.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetsCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('period: $period, ')
          ..write('createdAt: $createdAt, ')
          ..write('allowRollover: $allowRollover, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecurringHistoryTable extends RecurringHistory
    with TableInfo<$RecurringHistoryTable, RecurringHistoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurringHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recurringIdMeta =
      const VerificationMeta('recurringId');
  @override
  late final GeneratedColumn<String> recurringId = GeneratedColumn<String>(
      'recurring_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
      'action', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, recurringId, action, date, amount, currency];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurring_history';
  @override
  VerificationContext validateIntegrity(
      Insertable<RecurringHistoryRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('recurring_id')) {
      context.handle(
          _recurringIdMeta,
          recurringId.isAcceptableOrUnknown(
              data['recurring_id']!, _recurringIdMeta));
    } else if (isInserting) {
      context.missing(_recurringIdMeta);
    }
    if (data.containsKey('action')) {
      context.handle(_actionMeta,
          action.isAcceptableOrUnknown(data['action']!, _actionMeta));
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurringHistoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurringHistoryRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      recurringId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recurring_id'])!,
      action: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
    );
  }

  @override
  $RecurringHistoryTable createAlias(String alias) {
    return $RecurringHistoryTable(attachedDatabase, alias);
  }
}

class RecurringHistoryRow extends DataClass
    implements Insertable<RecurringHistoryRow> {
  final String id;
  final String recurringId;
  final String action;
  final String date;
  final double amount;
  final String currency;
  const RecurringHistoryRow(
      {required this.id,
      required this.recurringId,
      required this.action,
      required this.date,
      required this.amount,
      required this.currency});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['recurring_id'] = Variable<String>(recurringId);
    map['action'] = Variable<String>(action);
    map['date'] = Variable<String>(date);
    map['amount'] = Variable<double>(amount);
    map['currency'] = Variable<String>(currency);
    return map;
  }

  RecurringHistoryCompanion toCompanion(bool nullToAbsent) {
    return RecurringHistoryCompanion(
      id: Value(id),
      recurringId: Value(recurringId),
      action: Value(action),
      date: Value(date),
      amount: Value(amount),
      currency: Value(currency),
    );
  }

  factory RecurringHistoryRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurringHistoryRow(
      id: serializer.fromJson<String>(json['id']),
      recurringId: serializer.fromJson<String>(json['recurringId']),
      action: serializer.fromJson<String>(json['action']),
      date: serializer.fromJson<String>(json['date']),
      amount: serializer.fromJson<double>(json['amount']),
      currency: serializer.fromJson<String>(json['currency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'recurringId': serializer.toJson<String>(recurringId),
      'action': serializer.toJson<String>(action),
      'date': serializer.toJson<String>(date),
      'amount': serializer.toJson<double>(amount),
      'currency': serializer.toJson<String>(currency),
    };
  }

  RecurringHistoryRow copyWith(
          {String? id,
          String? recurringId,
          String? action,
          String? date,
          double? amount,
          String? currency}) =>
      RecurringHistoryRow(
        id: id ?? this.id,
        recurringId: recurringId ?? this.recurringId,
        action: action ?? this.action,
        date: date ?? this.date,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
      );
  RecurringHistoryRow copyWithCompanion(RecurringHistoryCompanion data) {
    return RecurringHistoryRow(
      id: data.id.present ? data.id.value : this.id,
      recurringId:
          data.recurringId.present ? data.recurringId.value : this.recurringId,
      action: data.action.present ? data.action.value : this.action,
      date: data.date.present ? data.date.value : this.date,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurringHistoryRow(')
          ..write('id: $id, ')
          ..write('recurringId: $recurringId, ')
          ..write('action: $action, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, recurringId, action, date, amount, currency);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurringHistoryRow &&
          other.id == this.id &&
          other.recurringId == this.recurringId &&
          other.action == this.action &&
          other.date == this.date &&
          other.amount == this.amount &&
          other.currency == this.currency);
}

class RecurringHistoryCompanion extends UpdateCompanion<RecurringHistoryRow> {
  final Value<String> id;
  final Value<String> recurringId;
  final Value<String> action;
  final Value<String> date;
  final Value<double> amount;
  final Value<String> currency;
  final Value<int> rowid;
  const RecurringHistoryCompanion({
    this.id = const Value.absent(),
    this.recurringId = const Value.absent(),
    this.action = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecurringHistoryCompanion.insert({
    required String id,
    required String recurringId,
    required String action,
    required String date,
    required double amount,
    required String currency,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        recurringId = Value(recurringId),
        action = Value(action),
        date = Value(date),
        amount = Value(amount),
        currency = Value(currency);
  static Insertable<RecurringHistoryRow> custom({
    Expression<String>? id,
    Expression<String>? recurringId,
    Expression<String>? action,
    Expression<String>? date,
    Expression<double>? amount,
    Expression<String>? currency,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recurringId != null) 'recurring_id': recurringId,
      if (action != null) 'action': action,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecurringHistoryCompanion copyWith(
      {Value<String>? id,
      Value<String>? recurringId,
      Value<String>? action,
      Value<String>? date,
      Value<double>? amount,
      Value<String>? currency,
      Value<int>? rowid}) {
    return RecurringHistoryCompanion(
      id: id ?? this.id,
      recurringId: recurringId ?? this.recurringId,
      action: action ?? this.action,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (recurringId.present) {
      map['recurring_id'] = Variable<String>(recurringId.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurringHistoryCompanion(')
          ..write('id: $id, ')
          ..write('recurringId: $recurringId, ')
          ..write('action: $action, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavingsGoalsTable extends SavingsGoals
    with TableInfo<$SavingsGoalsTable, SavingsGoalEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavingsGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetAmountMeta =
      const VerificationMeta('targetAmount');
  @override
  late final GeneratedColumn<double> targetAmount = GeneratedColumn<double>(
      'target_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _currentAmountMeta =
      const VerificationMeta('currentAmount');
  @override
  late final GeneratedColumn<double> currentAmount = GeneratedColumn<double>(
      'current_amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetDateMeta =
      const VerificationMeta('targetDate');
  @override
  late final GeneratedColumn<String> targetDate = GeneratedColumn<String>(
      'target_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorValueMeta =
      const VerificationMeta('colorValue');
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
      'color_value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<int> isCompleted = GeneratedColumn<int>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<String> completedAt = GeneratedColumn<String>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _wishlistItemIdMeta =
      const VerificationMeta('wishlistItemId');
  @override
  late final GeneratedColumn<String> wishlistItemId = GeneratedColumn<String>(
      'wishlist_item_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        targetAmount,
        currentAmount,
        currency,
        targetDate,
        colorValue,
        isCompleted,
        createdAt,
        completedAt,
        wishlistItemId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'savings_goals';
  @override
  VerificationContext validateIntegrity(Insertable<SavingsGoalEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('target_amount')) {
      context.handle(
          _targetAmountMeta,
          targetAmount.isAcceptableOrUnknown(
              data['target_amount']!, _targetAmountMeta));
    } else if (isInserting) {
      context.missing(_targetAmountMeta);
    }
    if (data.containsKey('current_amount')) {
      context.handle(
          _currentAmountMeta,
          currentAmount.isAcceptableOrUnknown(
              data['current_amount']!, _currentAmountMeta));
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('target_date')) {
      context.handle(
          _targetDateMeta,
          targetDate.isAcceptableOrUnknown(
              data['target_date']!, _targetDateMeta));
    }
    if (data.containsKey('color_value')) {
      context.handle(
          _colorValueMeta,
          colorValue.isAcceptableOrUnknown(
              data['color_value']!, _colorValueMeta));
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('wishlist_item_id')) {
      context.handle(
          _wishlistItemIdMeta,
          wishlistItemId.isAcceptableOrUnknown(
              data['wishlist_item_id']!, _wishlistItemIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavingsGoalEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavingsGoalEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      targetAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_amount'])!,
      currentAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}current_amount'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      targetDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_date']),
      colorValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color_value'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_completed'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}completed_at']),
      wishlistItemId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}wishlist_item_id']),
    );
  }

  @override
  $SavingsGoalsTable createAlias(String alias) {
    return $SavingsGoalsTable(attachedDatabase, alias);
  }
}

class SavingsGoalEntry extends DataClass
    implements Insertable<SavingsGoalEntry> {
  final String id;
  final String name;
  final double targetAmount;
  final double currentAmount;
  final String currency;
  final String? targetDate;
  final int colorValue;
  final int isCompleted;
  final String createdAt;
  final String? completedAt;
  final String? wishlistItemId;
  const SavingsGoalEntry(
      {required this.id,
      required this.name,
      required this.targetAmount,
      required this.currentAmount,
      required this.currency,
      this.targetDate,
      required this.colorValue,
      required this.isCompleted,
      required this.createdAt,
      this.completedAt,
      this.wishlistItemId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['target_amount'] = Variable<double>(targetAmount);
    map['current_amount'] = Variable<double>(currentAmount);
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || targetDate != null) {
      map['target_date'] = Variable<String>(targetDate);
    }
    map['color_value'] = Variable<int>(colorValue);
    map['is_completed'] = Variable<int>(isCompleted);
    map['created_at'] = Variable<String>(createdAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<String>(completedAt);
    }
    if (!nullToAbsent || wishlistItemId != null) {
      map['wishlist_item_id'] = Variable<String>(wishlistItemId);
    }
    return map;
  }

  SavingsGoalsCompanion toCompanion(bool nullToAbsent) {
    return SavingsGoalsCompanion(
      id: Value(id),
      name: Value(name),
      targetAmount: Value(targetAmount),
      currentAmount: Value(currentAmount),
      currency: Value(currency),
      targetDate: targetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDate),
      colorValue: Value(colorValue),
      isCompleted: Value(isCompleted),
      createdAt: Value(createdAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      wishlistItemId: wishlistItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(wishlistItemId),
    );
  }

  factory SavingsGoalEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavingsGoalEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      targetAmount: serializer.fromJson<double>(json['targetAmount']),
      currentAmount: serializer.fromJson<double>(json['currentAmount']),
      currency: serializer.fromJson<String>(json['currency']),
      targetDate: serializer.fromJson<String?>(json['targetDate']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      isCompleted: serializer.fromJson<int>(json['isCompleted']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      completedAt: serializer.fromJson<String?>(json['completedAt']),
      wishlistItemId: serializer.fromJson<String?>(json['wishlistItemId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'targetAmount': serializer.toJson<double>(targetAmount),
      'currentAmount': serializer.toJson<double>(currentAmount),
      'currency': serializer.toJson<String>(currency),
      'targetDate': serializer.toJson<String?>(targetDate),
      'colorValue': serializer.toJson<int>(colorValue),
      'isCompleted': serializer.toJson<int>(isCompleted),
      'createdAt': serializer.toJson<String>(createdAt),
      'completedAt': serializer.toJson<String?>(completedAt),
      'wishlistItemId': serializer.toJson<String?>(wishlistItemId),
    };
  }

  SavingsGoalEntry copyWith(
          {String? id,
          String? name,
          double? targetAmount,
          double? currentAmount,
          String? currency,
          Value<String?> targetDate = const Value.absent(),
          int? colorValue,
          int? isCompleted,
          String? createdAt,
          Value<String?> completedAt = const Value.absent(),
          Value<String?> wishlistItemId = const Value.absent()}) =>
      SavingsGoalEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        targetAmount: targetAmount ?? this.targetAmount,
        currentAmount: currentAmount ?? this.currentAmount,
        currency: currency ?? this.currency,
        targetDate: targetDate.present ? targetDate.value : this.targetDate,
        colorValue: colorValue ?? this.colorValue,
        isCompleted: isCompleted ?? this.isCompleted,
        createdAt: createdAt ?? this.createdAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        wishlistItemId:
            wishlistItemId.present ? wishlistItemId.value : this.wishlistItemId,
      );
  SavingsGoalEntry copyWithCompanion(SavingsGoalsCompanion data) {
    return SavingsGoalEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      targetAmount: data.targetAmount.present
          ? data.targetAmount.value
          : this.targetAmount,
      currentAmount: data.currentAmount.present
          ? data.currentAmount.value
          : this.currentAmount,
      currency: data.currency.present ? data.currency.value : this.currency,
      targetDate:
          data.targetDate.present ? data.targetDate.value : this.targetDate,
      colorValue:
          data.colorValue.present ? data.colorValue.value : this.colorValue,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      wishlistItemId: data.wishlistItemId.present
          ? data.wishlistItemId.value
          : this.wishlistItemId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavingsGoalEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('currentAmount: $currentAmount, ')
          ..write('currency: $currency, ')
          ..write('targetDate: $targetDate, ')
          ..write('colorValue: $colorValue, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('wishlistItemId: $wishlistItemId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      targetAmount,
      currentAmount,
      currency,
      targetDate,
      colorValue,
      isCompleted,
      createdAt,
      completedAt,
      wishlistItemId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavingsGoalEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.targetAmount == this.targetAmount &&
          other.currentAmount == this.currentAmount &&
          other.currency == this.currency &&
          other.targetDate == this.targetDate &&
          other.colorValue == this.colorValue &&
          other.isCompleted == this.isCompleted &&
          other.createdAt == this.createdAt &&
          other.completedAt == this.completedAt &&
          other.wishlistItemId == this.wishlistItemId);
}

class SavingsGoalsCompanion extends UpdateCompanion<SavingsGoalEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> targetAmount;
  final Value<double> currentAmount;
  final Value<String> currency;
  final Value<String?> targetDate;
  final Value<int> colorValue;
  final Value<int> isCompleted;
  final Value<String> createdAt;
  final Value<String?> completedAt;
  final Value<String?> wishlistItemId;
  final Value<int> rowid;
  const SavingsGoalsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.targetAmount = const Value.absent(),
    this.currentAmount = const Value.absent(),
    this.currency = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.wishlistItemId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavingsGoalsCompanion.insert({
    required String id,
    required String name,
    required double targetAmount,
    this.currentAmount = const Value.absent(),
    required String currency,
    this.targetDate = const Value.absent(),
    required int colorValue,
    this.isCompleted = const Value.absent(),
    required String createdAt,
    this.completedAt = const Value.absent(),
    this.wishlistItemId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        targetAmount = Value(targetAmount),
        currency = Value(currency),
        colorValue = Value(colorValue),
        createdAt = Value(createdAt);
  static Insertable<SavingsGoalEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? targetAmount,
    Expression<double>? currentAmount,
    Expression<String>? currency,
    Expression<String>? targetDate,
    Expression<int>? colorValue,
    Expression<int>? isCompleted,
    Expression<String>? createdAt,
    Expression<String>? completedAt,
    Expression<String>? wishlistItemId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (targetAmount != null) 'target_amount': targetAmount,
      if (currentAmount != null) 'current_amount': currentAmount,
      if (currency != null) 'currency': currency,
      if (targetDate != null) 'target_date': targetDate,
      if (colorValue != null) 'color_value': colorValue,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (createdAt != null) 'created_at': createdAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (wishlistItemId != null) 'wishlist_item_id': wishlistItemId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavingsGoalsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<double>? targetAmount,
      Value<double>? currentAmount,
      Value<String>? currency,
      Value<String?>? targetDate,
      Value<int>? colorValue,
      Value<int>? isCompleted,
      Value<String>? createdAt,
      Value<String?>? completedAt,
      Value<String?>? wishlistItemId,
      Value<int>? rowid}) {
    return SavingsGoalsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      currency: currency ?? this.currency,
      targetDate: targetDate ?? this.targetDate,
      colorValue: colorValue ?? this.colorValue,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      wishlistItemId: wishlistItemId ?? this.wishlistItemId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (targetAmount.present) {
      map['target_amount'] = Variable<double>(targetAmount.value);
    }
    if (currentAmount.present) {
      map['current_amount'] = Variable<double>(currentAmount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<String>(targetDate.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<int>(isCompleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<String>(completedAt.value);
    }
    if (wishlistItemId.present) {
      map['wishlist_item_id'] = Variable<String>(wishlistItemId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavingsGoalsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('currentAmount: $currentAmount, ')
          ..write('currency: $currency, ')
          ..write('targetDate: $targetDate, ')
          ..write('colorValue: $colorValue, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('wishlistItemId: $wishlistItemId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavingsContributionsTable extends SavingsContributions
    with TableInfo<$SavingsContributionsTable, SavingsContributionEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavingsContributionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
      'goal_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _accountIdMeta =
      const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
      'account_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns =>
      [id, goalId, amount, accountId, type, date, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'savings_contributions';
  @override
  VerificationContext validateIntegrity(
      Insertable<SavingsContributionEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(_goalIdMeta,
          goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta));
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavingsContributionEntry map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavingsContributionEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}goal_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      accountId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note'])!,
    );
  }

  @override
  $SavingsContributionsTable createAlias(String alias) {
    return $SavingsContributionsTable(attachedDatabase, alias);
  }
}

class SavingsContributionEntry extends DataClass
    implements Insertable<SavingsContributionEntry> {
  final String id;
  final String goalId;
  final double amount;
  final String accountId;
  final String type;
  final String date;
  final String note;
  const SavingsContributionEntry(
      {required this.id,
      required this.goalId,
      required this.amount,
      required this.accountId,
      required this.type,
      required this.date,
      required this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['goal_id'] = Variable<String>(goalId);
    map['amount'] = Variable<double>(amount);
    map['account_id'] = Variable<String>(accountId);
    map['type'] = Variable<String>(type);
    map['date'] = Variable<String>(date);
    map['note'] = Variable<String>(note);
    return map;
  }

  SavingsContributionsCompanion toCompanion(bool nullToAbsent) {
    return SavingsContributionsCompanion(
      id: Value(id),
      goalId: Value(goalId),
      amount: Value(amount),
      accountId: Value(accountId),
      type: Value(type),
      date: Value(date),
      note: Value(note),
    );
  }

  factory SavingsContributionEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavingsContributionEntry(
      id: serializer.fromJson<String>(json['id']),
      goalId: serializer.fromJson<String>(json['goalId']),
      amount: serializer.fromJson<double>(json['amount']),
      accountId: serializer.fromJson<String>(json['accountId']),
      type: serializer.fromJson<String>(json['type']),
      date: serializer.fromJson<String>(json['date']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'goalId': serializer.toJson<String>(goalId),
      'amount': serializer.toJson<double>(amount),
      'accountId': serializer.toJson<String>(accountId),
      'type': serializer.toJson<String>(type),
      'date': serializer.toJson<String>(date),
      'note': serializer.toJson<String>(note),
    };
  }

  SavingsContributionEntry copyWith(
          {String? id,
          String? goalId,
          double? amount,
          String? accountId,
          String? type,
          String? date,
          String? note}) =>
      SavingsContributionEntry(
        id: id ?? this.id,
        goalId: goalId ?? this.goalId,
        amount: amount ?? this.amount,
        accountId: accountId ?? this.accountId,
        type: type ?? this.type,
        date: date ?? this.date,
        note: note ?? this.note,
      );
  SavingsContributionEntry copyWithCompanion(
      SavingsContributionsCompanion data) {
    return SavingsContributionEntry(
      id: data.id.present ? data.id.value : this.id,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      amount: data.amount.present ? data.amount.value : this.amount,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      type: data.type.present ? data.type.value : this.type,
      date: data.date.present ? data.date.value : this.date,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavingsContributionEntry(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('amount: $amount, ')
          ..write('accountId: $accountId, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, goalId, amount, accountId, type, date, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavingsContributionEntry &&
          other.id == this.id &&
          other.goalId == this.goalId &&
          other.amount == this.amount &&
          other.accountId == this.accountId &&
          other.type == this.type &&
          other.date == this.date &&
          other.note == this.note);
}

class SavingsContributionsCompanion
    extends UpdateCompanion<SavingsContributionEntry> {
  final Value<String> id;
  final Value<String> goalId;
  final Value<double> amount;
  final Value<String> accountId;
  final Value<String> type;
  final Value<String> date;
  final Value<String> note;
  final Value<int> rowid;
  const SavingsContributionsCompanion({
    this.id = const Value.absent(),
    this.goalId = const Value.absent(),
    this.amount = const Value.absent(),
    this.accountId = const Value.absent(),
    this.type = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavingsContributionsCompanion.insert({
    required String id,
    required String goalId,
    required double amount,
    required String accountId,
    required String type,
    required String date,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        goalId = Value(goalId),
        amount = Value(amount),
        accountId = Value(accountId),
        type = Value(type),
        date = Value(date);
  static Insertable<SavingsContributionEntry> custom({
    Expression<String>? id,
    Expression<String>? goalId,
    Expression<double>? amount,
    Expression<String>? accountId,
    Expression<String>? type,
    Expression<String>? date,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (goalId != null) 'goal_id': goalId,
      if (amount != null) 'amount': amount,
      if (accountId != null) 'account_id': accountId,
      if (type != null) 'type': type,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavingsContributionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? goalId,
      Value<double>? amount,
      Value<String>? accountId,
      Value<String>? type,
      Value<String>? date,
      Value<String>? note,
      Value<int>? rowid}) {
    return SavingsContributionsCompanion(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      amount: amount ?? this.amount,
      accountId: accountId ?? this.accountId,
      type: type ?? this.type,
      date: date ?? this.date,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavingsContributionsCompanion(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('amount: $amount, ')
          ..write('accountId: $accountId, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LoansTable extends Loans with TableInfo<$LoansTable, LoanEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _principalMeta =
      const VerificationMeta('principal');
  @override
  late final GeneratedColumn<double> principal = GeneratedColumn<double>(
      'principal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('EGP'));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'start_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
      'end_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _interestRateMeta =
      const VerificationMeta('interestRate');
  @override
  late final GeneratedColumn<double> interestRate = GeneratedColumn<double>(
      'interest_rate', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _accountIdMeta =
      const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
      'account_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _transferAccountIdMeta =
      const VerificationMeta('transferAccountId');
  @override
  late final GeneratedColumn<String> transferAccountId =
      GeneratedColumn<String>('transfer_account_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reminderEnabledMeta =
      const VerificationMeta('reminderEnabled');
  @override
  late final GeneratedColumn<int> reminderEnabled = GeneratedColumn<int>(
      'reminder_enabled', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _reminderDayMeta =
      const VerificationMeta('reminderDay');
  @override
  late final GeneratedColumn<int> reminderDay = GeneratedColumn<int>(
      'reminder_day', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _reminderTimeMeta =
      const VerificationMeta('reminderTime');
  @override
  late final GeneratedColumn<String> reminderTime = GeneratedColumn<String>(
      'reminder_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('09:00'));
  static const VerificationMeta _isSettledMeta =
      const VerificationMeta('isSettled');
  @override
  late final GeneratedColumn<int> isSettled = GeneratedColumn<int>(
      'is_settled', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        principal,
        currency,
        startDate,
        endDate,
        interestRate,
        accountId,
        transferAccountId,
        reminderEnabled,
        reminderDay,
        reminderTime,
        isSettled,
        notes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'loans';
  @override
  VerificationContext validateIntegrity(Insertable<LoanEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('principal')) {
      context.handle(_principalMeta,
          principal.isAcceptableOrUnknown(data['principal']!, _principalMeta));
    } else if (isInserting) {
      context.missing(_principalMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('interest_rate')) {
      context.handle(
          _interestRateMeta,
          interestRate.isAcceptableOrUnknown(
              data['interest_rate']!, _interestRateMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    }
    if (data.containsKey('transfer_account_id')) {
      context.handle(
          _transferAccountIdMeta,
          transferAccountId.isAcceptableOrUnknown(
              data['transfer_account_id']!, _transferAccountIdMeta));
    }
    if (data.containsKey('reminder_enabled')) {
      context.handle(
          _reminderEnabledMeta,
          reminderEnabled.isAcceptableOrUnknown(
              data['reminder_enabled']!, _reminderEnabledMeta));
    }
    if (data.containsKey('reminder_day')) {
      context.handle(
          _reminderDayMeta,
          reminderDay.isAcceptableOrUnknown(
              data['reminder_day']!, _reminderDayMeta));
    }
    if (data.containsKey('reminder_time')) {
      context.handle(
          _reminderTimeMeta,
          reminderTime.isAcceptableOrUnknown(
              data['reminder_time']!, _reminderTimeMeta));
    }
    if (data.containsKey('is_settled')) {
      context.handle(_isSettledMeta,
          isSettled.isAcceptableOrUnknown(data['is_settled']!, _isSettledMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LoanEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LoanEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      principal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}principal'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_date'])!,
      interestRate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}interest_rate']),
      accountId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_id']),
      transferAccountId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transfer_account_id']),
      reminderEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reminder_enabled'])!,
      reminderDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reminder_day'])!,
      reminderTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reminder_time'])!,
      isSettled: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_settled'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $LoansTable createAlias(String alias) {
    return $LoansTable(attachedDatabase, alias);
  }
}

class LoanEntry extends DataClass implements Insertable<LoanEntry> {
  final String id;
  final String name;
  final double principal;
  final String currency;
  final String startDate;
  final String endDate;
  final double? interestRate;
  final String? accountId;
  final String? transferAccountId;
  final int reminderEnabled;
  final int reminderDay;
  final String reminderTime;
  final int isSettled;
  final String notes;
  final String createdAt;
  const LoanEntry(
      {required this.id,
      required this.name,
      required this.principal,
      required this.currency,
      required this.startDate,
      required this.endDate,
      this.interestRate,
      this.accountId,
      this.transferAccountId,
      required this.reminderEnabled,
      required this.reminderDay,
      required this.reminderTime,
      required this.isSettled,
      required this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['principal'] = Variable<double>(principal);
    map['currency'] = Variable<String>(currency);
    map['start_date'] = Variable<String>(startDate);
    map['end_date'] = Variable<String>(endDate);
    if (!nullToAbsent || interestRate != null) {
      map['interest_rate'] = Variable<double>(interestRate);
    }
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    if (!nullToAbsent || transferAccountId != null) {
      map['transfer_account_id'] = Variable<String>(transferAccountId);
    }
    map['reminder_enabled'] = Variable<int>(reminderEnabled);
    map['reminder_day'] = Variable<int>(reminderDay);
    map['reminder_time'] = Variable<String>(reminderTime);
    map['is_settled'] = Variable<int>(isSettled);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  LoansCompanion toCompanion(bool nullToAbsent) {
    return LoansCompanion(
      id: Value(id),
      name: Value(name),
      principal: Value(principal),
      currency: Value(currency),
      startDate: Value(startDate),
      endDate: Value(endDate),
      interestRate: interestRate == null && nullToAbsent
          ? const Value.absent()
          : Value(interestRate),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      transferAccountId: transferAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(transferAccountId),
      reminderEnabled: Value(reminderEnabled),
      reminderDay: Value(reminderDay),
      reminderTime: Value(reminderTime),
      isSettled: Value(isSettled),
      notes: Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory LoanEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LoanEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      principal: serializer.fromJson<double>(json['principal']),
      currency: serializer.fromJson<String>(json['currency']),
      startDate: serializer.fromJson<String>(json['startDate']),
      endDate: serializer.fromJson<String>(json['endDate']),
      interestRate: serializer.fromJson<double?>(json['interestRate']),
      accountId: serializer.fromJson<String?>(json['accountId']),
      transferAccountId:
          serializer.fromJson<String?>(json['transferAccountId']),
      reminderEnabled: serializer.fromJson<int>(json['reminderEnabled']),
      reminderDay: serializer.fromJson<int>(json['reminderDay']),
      reminderTime: serializer.fromJson<String>(json['reminderTime']),
      isSettled: serializer.fromJson<int>(json['isSettled']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'principal': serializer.toJson<double>(principal),
      'currency': serializer.toJson<String>(currency),
      'startDate': serializer.toJson<String>(startDate),
      'endDate': serializer.toJson<String>(endDate),
      'interestRate': serializer.toJson<double?>(interestRate),
      'accountId': serializer.toJson<String?>(accountId),
      'transferAccountId': serializer.toJson<String?>(transferAccountId),
      'reminderEnabled': serializer.toJson<int>(reminderEnabled),
      'reminderDay': serializer.toJson<int>(reminderDay),
      'reminderTime': serializer.toJson<String>(reminderTime),
      'isSettled': serializer.toJson<int>(isSettled),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  LoanEntry copyWith(
          {String? id,
          String? name,
          double? principal,
          String? currency,
          String? startDate,
          String? endDate,
          Value<double?> interestRate = const Value.absent(),
          Value<String?> accountId = const Value.absent(),
          Value<String?> transferAccountId = const Value.absent(),
          int? reminderEnabled,
          int? reminderDay,
          String? reminderTime,
          int? isSettled,
          String? notes,
          String? createdAt}) =>
      LoanEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        principal: principal ?? this.principal,
        currency: currency ?? this.currency,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        interestRate:
            interestRate.present ? interestRate.value : this.interestRate,
        accountId: accountId.present ? accountId.value : this.accountId,
        transferAccountId: transferAccountId.present
            ? transferAccountId.value
            : this.transferAccountId,
        reminderEnabled: reminderEnabled ?? this.reminderEnabled,
        reminderDay: reminderDay ?? this.reminderDay,
        reminderTime: reminderTime ?? this.reminderTime,
        isSettled: isSettled ?? this.isSettled,
        notes: notes ?? this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  LoanEntry copyWithCompanion(LoansCompanion data) {
    return LoanEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      principal: data.principal.present ? data.principal.value : this.principal,
      currency: data.currency.present ? data.currency.value : this.currency,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      interestRate: data.interestRate.present
          ? data.interestRate.value
          : this.interestRate,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      transferAccountId: data.transferAccountId.present
          ? data.transferAccountId.value
          : this.transferAccountId,
      reminderEnabled: data.reminderEnabled.present
          ? data.reminderEnabled.value
          : this.reminderEnabled,
      reminderDay:
          data.reminderDay.present ? data.reminderDay.value : this.reminderDay,
      reminderTime: data.reminderTime.present
          ? data.reminderTime.value
          : this.reminderTime,
      isSettled: data.isSettled.present ? data.isSettled.value : this.isSettled,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LoanEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('principal: $principal, ')
          ..write('currency: $currency, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('interestRate: $interestRate, ')
          ..write('accountId: $accountId, ')
          ..write('transferAccountId: $transferAccountId, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('reminderDay: $reminderDay, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('isSettled: $isSettled, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      principal,
      currency,
      startDate,
      endDate,
      interestRate,
      accountId,
      transferAccountId,
      reminderEnabled,
      reminderDay,
      reminderTime,
      isSettled,
      notes,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoanEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.principal == this.principal &&
          other.currency == this.currency &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.interestRate == this.interestRate &&
          other.accountId == this.accountId &&
          other.transferAccountId == this.transferAccountId &&
          other.reminderEnabled == this.reminderEnabled &&
          other.reminderDay == this.reminderDay &&
          other.reminderTime == this.reminderTime &&
          other.isSettled == this.isSettled &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class LoansCompanion extends UpdateCompanion<LoanEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> principal;
  final Value<String> currency;
  final Value<String> startDate;
  final Value<String> endDate;
  final Value<double?> interestRate;
  final Value<String?> accountId;
  final Value<String?> transferAccountId;
  final Value<int> reminderEnabled;
  final Value<int> reminderDay;
  final Value<String> reminderTime;
  final Value<int> isSettled;
  final Value<String> notes;
  final Value<String> createdAt;
  final Value<int> rowid;
  const LoansCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.principal = const Value.absent(),
    this.currency = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.interestRate = const Value.absent(),
    this.accountId = const Value.absent(),
    this.transferAccountId = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.reminderDay = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.isSettled = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LoansCompanion.insert({
    required String id,
    required String name,
    required double principal,
    this.currency = const Value.absent(),
    required String startDate,
    required String endDate,
    this.interestRate = const Value.absent(),
    this.accountId = const Value.absent(),
    this.transferAccountId = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.reminderDay = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.isSettled = const Value.absent(),
    this.notes = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        principal = Value(principal),
        startDate = Value(startDate),
        endDate = Value(endDate),
        createdAt = Value(createdAt);
  static Insertable<LoanEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? principal,
    Expression<String>? currency,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<double>? interestRate,
    Expression<String>? accountId,
    Expression<String>? transferAccountId,
    Expression<int>? reminderEnabled,
    Expression<int>? reminderDay,
    Expression<String>? reminderTime,
    Expression<int>? isSettled,
    Expression<String>? notes,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (principal != null) 'principal': principal,
      if (currency != null) 'currency': currency,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (interestRate != null) 'interest_rate': interestRate,
      if (accountId != null) 'account_id': accountId,
      if (transferAccountId != null) 'transfer_account_id': transferAccountId,
      if (reminderEnabled != null) 'reminder_enabled': reminderEnabled,
      if (reminderDay != null) 'reminder_day': reminderDay,
      if (reminderTime != null) 'reminder_time': reminderTime,
      if (isSettled != null) 'is_settled': isSettled,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LoansCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<double>? principal,
      Value<String>? currency,
      Value<String>? startDate,
      Value<String>? endDate,
      Value<double?>? interestRate,
      Value<String?>? accountId,
      Value<String?>? transferAccountId,
      Value<int>? reminderEnabled,
      Value<int>? reminderDay,
      Value<String>? reminderTime,
      Value<int>? isSettled,
      Value<String>? notes,
      Value<String>? createdAt,
      Value<int>? rowid}) {
    return LoansCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      principal: principal ?? this.principal,
      currency: currency ?? this.currency,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      interestRate: interestRate ?? this.interestRate,
      accountId: accountId ?? this.accountId,
      transferAccountId: transferAccountId ?? this.transferAccountId,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderDay: reminderDay ?? this.reminderDay,
      reminderTime: reminderTime ?? this.reminderTime,
      isSettled: isSettled ?? this.isSettled,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (principal.present) {
      map['principal'] = Variable<double>(principal.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (interestRate.present) {
      map['interest_rate'] = Variable<double>(interestRate.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (transferAccountId.present) {
      map['transfer_account_id'] = Variable<String>(transferAccountId.value);
    }
    if (reminderEnabled.present) {
      map['reminder_enabled'] = Variable<int>(reminderEnabled.value);
    }
    if (reminderDay.present) {
      map['reminder_day'] = Variable<int>(reminderDay.value);
    }
    if (reminderTime.present) {
      map['reminder_time'] = Variable<String>(reminderTime.value);
    }
    if (isSettled.present) {
      map['is_settled'] = Variable<int>(isSettled.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoansCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('principal: $principal, ')
          ..write('currency: $currency, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('interestRate: $interestRate, ')
          ..write('accountId: $accountId, ')
          ..write('transferAccountId: $transferAccountId, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('reminderDay: $reminderDay, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('isSettled: $isSettled, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LoanPaymentsTable extends LoanPayments
    with TableInfo<$LoanPaymentsTable, LoanPaymentEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoanPaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _loanIdMeta = const VerificationMeta('loanId');
  @override
  late final GeneratedColumn<String> loanId = GeneratedColumn<String>(
      'loan_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _accountIdMeta =
      const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
      'account_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns =>
      [id, loanId, date, amount, currency, accountId, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'loan_payments';
  @override
  VerificationContext validateIntegrity(Insertable<LoanPaymentEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('loan_id')) {
      context.handle(_loanIdMeta,
          loanId.isAcceptableOrUnknown(data['loan_id']!, _loanIdMeta));
    } else if (isInserting) {
      context.missing(_loanIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LoanPaymentEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LoanPaymentEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      loanId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}loan_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      accountId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_id']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
    );
  }

  @override
  $LoanPaymentsTable createAlias(String alias) {
    return $LoanPaymentsTable(attachedDatabase, alias);
  }
}

class LoanPaymentEntry extends DataClass
    implements Insertable<LoanPaymentEntry> {
  final String id;
  final String loanId;
  final String date;
  final double amount;
  final String currency;
  final String? accountId;
  final String notes;
  const LoanPaymentEntry(
      {required this.id,
      required this.loanId,
      required this.date,
      required this.amount,
      required this.currency,
      this.accountId,
      required this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['loan_id'] = Variable<String>(loanId);
    map['date'] = Variable<String>(date);
    map['amount'] = Variable<double>(amount);
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    map['notes'] = Variable<String>(notes);
    return map;
  }

  LoanPaymentsCompanion toCompanion(bool nullToAbsent) {
    return LoanPaymentsCompanion(
      id: Value(id),
      loanId: Value(loanId),
      date: Value(date),
      amount: Value(amount),
      currency: Value(currency),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      notes: Value(notes),
    );
  }

  factory LoanPaymentEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LoanPaymentEntry(
      id: serializer.fromJson<String>(json['id']),
      loanId: serializer.fromJson<String>(json['loanId']),
      date: serializer.fromJson<String>(json['date']),
      amount: serializer.fromJson<double>(json['amount']),
      currency: serializer.fromJson<String>(json['currency']),
      accountId: serializer.fromJson<String?>(json['accountId']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'loanId': serializer.toJson<String>(loanId),
      'date': serializer.toJson<String>(date),
      'amount': serializer.toJson<double>(amount),
      'currency': serializer.toJson<String>(currency),
      'accountId': serializer.toJson<String?>(accountId),
      'notes': serializer.toJson<String>(notes),
    };
  }

  LoanPaymentEntry copyWith(
          {String? id,
          String? loanId,
          String? date,
          double? amount,
          String? currency,
          Value<String?> accountId = const Value.absent(),
          String? notes}) =>
      LoanPaymentEntry(
        id: id ?? this.id,
        loanId: loanId ?? this.loanId,
        date: date ?? this.date,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        accountId: accountId.present ? accountId.value : this.accountId,
        notes: notes ?? this.notes,
      );
  LoanPaymentEntry copyWithCompanion(LoanPaymentsCompanion data) {
    return LoanPaymentEntry(
      id: data.id.present ? data.id.value : this.id,
      loanId: data.loanId.present ? data.loanId.value : this.loanId,
      date: data.date.present ? data.date.value : this.date,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LoanPaymentEntry(')
          ..write('id: $id, ')
          ..write('loanId: $loanId, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('accountId: $accountId, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, loanId, date, amount, currency, accountId, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoanPaymentEntry &&
          other.id == this.id &&
          other.loanId == this.loanId &&
          other.date == this.date &&
          other.amount == this.amount &&
          other.currency == this.currency &&
          other.accountId == this.accountId &&
          other.notes == this.notes);
}

class LoanPaymentsCompanion extends UpdateCompanion<LoanPaymentEntry> {
  final Value<String> id;
  final Value<String> loanId;
  final Value<String> date;
  final Value<double> amount;
  final Value<String> currency;
  final Value<String?> accountId;
  final Value<String> notes;
  final Value<int> rowid;
  const LoanPaymentsCompanion({
    this.id = const Value.absent(),
    this.loanId = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
    this.accountId = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LoanPaymentsCompanion.insert({
    required String id,
    required String loanId,
    required String date,
    required double amount,
    required String currency,
    this.accountId = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        loanId = Value(loanId),
        date = Value(date),
        amount = Value(amount),
        currency = Value(currency);
  static Insertable<LoanPaymentEntry> custom({
    Expression<String>? id,
    Expression<String>? loanId,
    Expression<String>? date,
    Expression<double>? amount,
    Expression<String>? currency,
    Expression<String>? accountId,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (loanId != null) 'loan_id': loanId,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (accountId != null) 'account_id': accountId,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LoanPaymentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? loanId,
      Value<String>? date,
      Value<double>? amount,
      Value<String>? currency,
      Value<String?>? accountId,
      Value<String>? notes,
      Value<int>? rowid}) {
    return LoanPaymentsCompanion(
      id: id ?? this.id,
      loanId: loanId ?? this.loanId,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      accountId: accountId ?? this.accountId,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (loanId.present) {
      map['loan_id'] = Variable<String>(loanId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoanPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('loanId: $loanId, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('accountId: $accountId, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionPresetsTable extends TransactionPresets
    with TableInfo<$TransactionPresetsTable, TransactionPresetEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionPresetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _accountIdMeta =
      const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
      'account_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _colorValueMeta =
      const VerificationMeta('colorValue');
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
      'color_value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _iconCodePointMeta =
      const VerificationMeta('iconCodePoint');
  @override
  late final GeneratedColumn<int> iconCodePoint = GeneratedColumn<int>(
      'icon_code_point', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        type,
        amount,
        accountId,
        categoryId,
        currency,
        note,
        colorValue,
        iconCodePoint,
        orderIndex,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_presets';
  @override
  VerificationContext validateIntegrity(
      Insertable<TransactionPresetEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('color_value')) {
      context.handle(
          _colorValueMeta,
          colorValue.isAcceptableOrUnknown(
              data['color_value']!, _colorValueMeta));
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    if (data.containsKey('icon_code_point')) {
      context.handle(
          _iconCodePointMeta,
          iconCodePoint.isAcceptableOrUnknown(
              data['icon_code_point']!, _iconCodePointMeta));
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionPresetEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionPresetEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      accountId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note'])!,
      colorValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color_value'])!,
      iconCodePoint: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}icon_code_point'])!,
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $TransactionPresetsTable createAlias(String alias) {
    return $TransactionPresetsTable(attachedDatabase, alias);
  }
}

class TransactionPresetEntry extends DataClass
    implements Insertable<TransactionPresetEntry> {
  final String id;
  final String title;
  final String type;
  final double amount;
  final String accountId;
  final String categoryId;
  final String currency;
  final String note;
  final int colorValue;
  final int iconCodePoint;
  final int orderIndex;
  final String createdAt;
  const TransactionPresetEntry(
      {required this.id,
      required this.title,
      required this.type,
      required this.amount,
      required this.accountId,
      required this.categoryId,
      required this.currency,
      required this.note,
      required this.colorValue,
      required this.iconCodePoint,
      required this.orderIndex,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    map['amount'] = Variable<double>(amount);
    map['account_id'] = Variable<String>(accountId);
    map['category_id'] = Variable<String>(categoryId);
    map['currency'] = Variable<String>(currency);
    map['note'] = Variable<String>(note);
    map['color_value'] = Variable<int>(colorValue);
    map['icon_code_point'] = Variable<int>(iconCodePoint);
    map['order_index'] = Variable<int>(orderIndex);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  TransactionPresetsCompanion toCompanion(bool nullToAbsent) {
    return TransactionPresetsCompanion(
      id: Value(id),
      title: Value(title),
      type: Value(type),
      amount: Value(amount),
      accountId: Value(accountId),
      categoryId: Value(categoryId),
      currency: Value(currency),
      note: Value(note),
      colorValue: Value(colorValue),
      iconCodePoint: Value(iconCodePoint),
      orderIndex: Value(orderIndex),
      createdAt: Value(createdAt),
    );
  }

  factory TransactionPresetEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionPresetEntry(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      amount: serializer.fromJson<double>(json['amount']),
      accountId: serializer.fromJson<String>(json['accountId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      currency: serializer.fromJson<String>(json['currency']),
      note: serializer.fromJson<String>(json['note']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      iconCodePoint: serializer.fromJson<int>(json['iconCodePoint']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'amount': serializer.toJson<double>(amount),
      'accountId': serializer.toJson<String>(accountId),
      'categoryId': serializer.toJson<String>(categoryId),
      'currency': serializer.toJson<String>(currency),
      'note': serializer.toJson<String>(note),
      'colorValue': serializer.toJson<int>(colorValue),
      'iconCodePoint': serializer.toJson<int>(iconCodePoint),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  TransactionPresetEntry copyWith(
          {String? id,
          String? title,
          String? type,
          double? amount,
          String? accountId,
          String? categoryId,
          String? currency,
          String? note,
          int? colorValue,
          int? iconCodePoint,
          int? orderIndex,
          String? createdAt}) =>
      TransactionPresetEntry(
        id: id ?? this.id,
        title: title ?? this.title,
        type: type ?? this.type,
        amount: amount ?? this.amount,
        accountId: accountId ?? this.accountId,
        categoryId: categoryId ?? this.categoryId,
        currency: currency ?? this.currency,
        note: note ?? this.note,
        colorValue: colorValue ?? this.colorValue,
        iconCodePoint: iconCodePoint ?? this.iconCodePoint,
        orderIndex: orderIndex ?? this.orderIndex,
        createdAt: createdAt ?? this.createdAt,
      );
  TransactionPresetEntry copyWithCompanion(TransactionPresetsCompanion data) {
    return TransactionPresetEntry(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
      amount: data.amount.present ? data.amount.value : this.amount,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      currency: data.currency.present ? data.currency.value : this.currency,
      note: data.note.present ? data.note.value : this.note,
      colorValue:
          data.colorValue.present ? data.colorValue.value : this.colorValue,
      iconCodePoint: data.iconCodePoint.present
          ? data.iconCodePoint.value
          : this.iconCodePoint,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionPresetEntry(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('currency: $currency, ')
          ..write('note: $note, ')
          ..write('colorValue: $colorValue, ')
          ..write('iconCodePoint: $iconCodePoint, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      type,
      amount,
      accountId,
      categoryId,
      currency,
      note,
      colorValue,
      iconCodePoint,
      orderIndex,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionPresetEntry &&
          other.id == this.id &&
          other.title == this.title &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.accountId == this.accountId &&
          other.categoryId == this.categoryId &&
          other.currency == this.currency &&
          other.note == this.note &&
          other.colorValue == this.colorValue &&
          other.iconCodePoint == this.iconCodePoint &&
          other.orderIndex == this.orderIndex &&
          other.createdAt == this.createdAt);
}

class TransactionPresetsCompanion
    extends UpdateCompanion<TransactionPresetEntry> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> type;
  final Value<double> amount;
  final Value<String> accountId;
  final Value<String> categoryId;
  final Value<String> currency;
  final Value<String> note;
  final Value<int> colorValue;
  final Value<int> iconCodePoint;
  final Value<int> orderIndex;
  final Value<String> createdAt;
  final Value<int> rowid;
  const TransactionPresetsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.accountId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.currency = const Value.absent(),
    this.note = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.iconCodePoint = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionPresetsCompanion.insert({
    required String id,
    required String title,
    required String type,
    required double amount,
    required String accountId,
    required String categoryId,
    this.currency = const Value.absent(),
    this.note = const Value.absent(),
    required int colorValue,
    this.iconCodePoint = const Value.absent(),
    this.orderIndex = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        type = Value(type),
        amount = Value(amount),
        accountId = Value(accountId),
        categoryId = Value(categoryId),
        colorValue = Value(colorValue),
        createdAt = Value(createdAt);
  static Insertable<TransactionPresetEntry> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? type,
    Expression<double>? amount,
    Expression<String>? accountId,
    Expression<String>? categoryId,
    Expression<String>? currency,
    Expression<String>? note,
    Expression<int>? colorValue,
    Expression<int>? iconCodePoint,
    Expression<int>? orderIndex,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (accountId != null) 'account_id': accountId,
      if (categoryId != null) 'category_id': categoryId,
      if (currency != null) 'currency': currency,
      if (note != null) 'note': note,
      if (colorValue != null) 'color_value': colorValue,
      if (iconCodePoint != null) 'icon_code_point': iconCodePoint,
      if (orderIndex != null) 'order_index': orderIndex,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionPresetsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? type,
      Value<double>? amount,
      Value<String>? accountId,
      Value<String>? categoryId,
      Value<String>? currency,
      Value<String>? note,
      Value<int>? colorValue,
      Value<int>? iconCodePoint,
      Value<int>? orderIndex,
      Value<String>? createdAt,
      Value<int>? rowid}) {
    return TransactionPresetsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      currency: currency ?? this.currency,
      note: note ?? this.note,
      colorValue: colorValue ?? this.colorValue,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      orderIndex: orderIndex ?? this.orderIndex,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (iconCodePoint.present) {
      map['icon_code_point'] = Variable<int>(iconCodePoint.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionPresetsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('currency: $currency, ')
          ..write('note: $note, ')
          ..write('colorValue: $colorValue, ')
          ..write('iconCodePoint: $iconCodePoint, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionSplitsTable extends TransactionSplits
    with TableInfo<$TransactionSplitsTable, TransactionSplitEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionSplitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _transactionIdMeta =
      const VerificationMeta('transactionId');
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
      'transaction_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns =>
      [id, transactionId, categoryId, amount, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_splits';
  @override
  VerificationContext validateIntegrity(
      Insertable<TransactionSplitEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
          _transactionIdMeta,
          transactionId.isAcceptableOrUnknown(
              data['transaction_id']!, _transactionIdMeta));
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionSplitEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionSplitEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      transactionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}transaction_id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note'])!,
    );
  }

  @override
  $TransactionSplitsTable createAlias(String alias) {
    return $TransactionSplitsTable(attachedDatabase, alias);
  }
}

class TransactionSplitEntry extends DataClass
    implements Insertable<TransactionSplitEntry> {
  final String id;
  final String transactionId;
  final String categoryId;
  final double amount;
  final String note;
  const TransactionSplitEntry(
      {required this.id,
      required this.transactionId,
      required this.categoryId,
      required this.amount,
      required this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['transaction_id'] = Variable<String>(transactionId);
    map['category_id'] = Variable<String>(categoryId);
    map['amount'] = Variable<double>(amount);
    map['note'] = Variable<String>(note);
    return map;
  }

  TransactionSplitsCompanion toCompanion(bool nullToAbsent) {
    return TransactionSplitsCompanion(
      id: Value(id),
      transactionId: Value(transactionId),
      categoryId: Value(categoryId),
      amount: Value(amount),
      note: Value(note),
    );
  }

  factory TransactionSplitEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionSplitEntry(
      id: serializer.fromJson<String>(json['id']),
      transactionId: serializer.fromJson<String>(json['transactionId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      amount: serializer.fromJson<double>(json['amount']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'transactionId': serializer.toJson<String>(transactionId),
      'categoryId': serializer.toJson<String>(categoryId),
      'amount': serializer.toJson<double>(amount),
      'note': serializer.toJson<String>(note),
    };
  }

  TransactionSplitEntry copyWith(
          {String? id,
          String? transactionId,
          String? categoryId,
          double? amount,
          String? note}) =>
      TransactionSplitEntry(
        id: id ?? this.id,
        transactionId: transactionId ?? this.transactionId,
        categoryId: categoryId ?? this.categoryId,
        amount: amount ?? this.amount,
        note: note ?? this.note,
      );
  TransactionSplitEntry copyWithCompanion(TransactionSplitsCompanion data) {
    return TransactionSplitEntry(
      id: data.id.present ? data.id.value : this.id,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      amount: data.amount.present ? data.amount.value : this.amount,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionSplitEntry(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, transactionId, categoryId, amount, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionSplitEntry &&
          other.id == this.id &&
          other.transactionId == this.transactionId &&
          other.categoryId == this.categoryId &&
          other.amount == this.amount &&
          other.note == this.note);
}

class TransactionSplitsCompanion
    extends UpdateCompanion<TransactionSplitEntry> {
  final Value<String> id;
  final Value<String> transactionId;
  final Value<String> categoryId;
  final Value<double> amount;
  final Value<String> note;
  final Value<int> rowid;
  const TransactionSplitsCompanion({
    this.id = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.amount = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionSplitsCompanion.insert({
    required String id,
    required String transactionId,
    required String categoryId,
    required double amount,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        transactionId = Value(transactionId),
        categoryId = Value(categoryId),
        amount = Value(amount);
  static Insertable<TransactionSplitEntry> custom({
    Expression<String>? id,
    Expression<String>? transactionId,
    Expression<String>? categoryId,
    Expression<double>? amount,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (transactionId != null) 'transaction_id': transactionId,
      if (categoryId != null) 'category_id': categoryId,
      if (amount != null) 'amount': amount,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionSplitsCompanion copyWith(
      {Value<String>? id,
      Value<String>? transactionId,
      Value<String>? categoryId,
      Value<double>? amount,
      Value<String>? note,
      Value<int>? rowid}) {
    return TransactionSplitsCompanion(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionSplitsCompanion(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $RecurringPaymentsTable recurringPayments =
      $RecurringPaymentsTable(this);
  late final $WishlistTable wishlist = $WishlistTable(this);
  late final $AssetItemsTable assetItems = $AssetItemsTable(this);
  late final $NetWorthSnapshotsTable netWorthSnapshots =
      $NetWorthSnapshotsTable(this);
  late final $LendedPeopleTable lendedPeople = $LendedPeopleTable(this);
  late final $LendedMoneyTableTable lendedMoneyTable =
      $LendedMoneyTableTable(this);
  late final $AssetsTable assets = $AssetsTable(this);
  late final $BudgetsTable budgets = $BudgetsTable(this);
  late final $RecurringHistoryTable recurringHistory =
      $RecurringHistoryTable(this);
  late final $SavingsGoalsTable savingsGoals = $SavingsGoalsTable(this);
  late final $SavingsContributionsTable savingsContributions =
      $SavingsContributionsTable(this);
  late final $LoansTable loans = $LoansTable(this);
  late final $LoanPaymentsTable loanPayments = $LoanPaymentsTable(this);
  late final $TransactionPresetsTable transactionPresets =
      $TransactionPresetsTable(this);
  late final $TransactionSplitsTable transactionSplits =
      $TransactionSplitsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        accounts,
        categories,
        transactions,
        recurringPayments,
        wishlist,
        assetItems,
        netWorthSnapshots,
        lendedPeople,
        lendedMoneyTable,
        assets,
        budgets,
        recurringHistory,
        savingsGoals,
        savingsContributions,
        loans,
        loanPayments,
        transactionPresets,
        transactionSplits
      ];
}

typedef $$AccountsTableCreateCompanionBuilder = AccountsCompanion Function({
  required String id,
  required String name,
  required String type,
  required double balance,
  Value<String> currency,
  required int colorValue,
  Value<int> excludeFromTotal,
  required String createdAt,
  Value<int?> goldKarat,
  Value<double?> goldGrams,
  Value<String?> cardHolderName,
  Value<String?> cardNumberLast4,
  Value<String?> cardExpiry,
  Value<int?> statementDay,
  Value<int?> dueDay,
  Value<double?> creditLimit,
  Value<double?> minPaymentAmount,
  Value<double?> minPaymentPercent,
  Value<int> creditReminderEnabled,
  Value<String?> creditReminderTime,
  Value<int?> creditEarlyReminderEnabled,
  Value<String?> linkedAccountId,
  Value<int?> orderIndex,
  Value<int> excludeFromBankTotal,
  Value<int> dontLinkToCard,
  Value<int> rowid,
});
typedef $$AccountsTableUpdateCompanionBuilder = AccountsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> type,
  Value<double> balance,
  Value<String> currency,
  Value<int> colorValue,
  Value<int> excludeFromTotal,
  Value<String> createdAt,
  Value<int?> goldKarat,
  Value<double?> goldGrams,
  Value<String?> cardHolderName,
  Value<String?> cardNumberLast4,
  Value<String?> cardExpiry,
  Value<int?> statementDay,
  Value<int?> dueDay,
  Value<double?> creditLimit,
  Value<double?> minPaymentAmount,
  Value<double?> minPaymentPercent,
  Value<int> creditReminderEnabled,
  Value<String?> creditReminderTime,
  Value<int?> creditEarlyReminderEnabled,
  Value<String?> linkedAccountId,
  Value<int?> orderIndex,
  Value<int> excludeFromBankTotal,
  Value<int> dontLinkToCard,
  Value<int> rowid,
});

class $$AccountsTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get balance => $composableBuilder(
      column: $table.balance, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get excludeFromTotal => $composableBuilder(
      column: $table.excludeFromTotal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get goldKarat => $composableBuilder(
      column: $table.goldKarat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get goldGrams => $composableBuilder(
      column: $table.goldGrams, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cardHolderName => $composableBuilder(
      column: $table.cardHolderName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cardNumberLast4 => $composableBuilder(
      column: $table.cardNumberLast4,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cardExpiry => $composableBuilder(
      column: $table.cardExpiry, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get statementDay => $composableBuilder(
      column: $table.statementDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dueDay => $composableBuilder(
      column: $table.dueDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get creditLimit => $composableBuilder(
      column: $table.creditLimit, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get minPaymentAmount => $composableBuilder(
      column: $table.minPaymentAmount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get minPaymentPercent => $composableBuilder(
      column: $table.minPaymentPercent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get creditReminderEnabled => $composableBuilder(
      column: $table.creditReminderEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get creditReminderTime => $composableBuilder(
      column: $table.creditReminderTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get creditEarlyReminderEnabled => $composableBuilder(
      column: $table.creditEarlyReminderEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get linkedAccountId => $composableBuilder(
      column: $table.linkedAccountId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get excludeFromBankTotal => $composableBuilder(
      column: $table.excludeFromBankTotal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dontLinkToCard => $composableBuilder(
      column: $table.dontLinkToCard,
      builder: (column) => ColumnFilters(column));
}

class $$AccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get balance => $composableBuilder(
      column: $table.balance, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get excludeFromTotal => $composableBuilder(
      column: $table.excludeFromTotal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get goldKarat => $composableBuilder(
      column: $table.goldKarat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get goldGrams => $composableBuilder(
      column: $table.goldGrams, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cardHolderName => $composableBuilder(
      column: $table.cardHolderName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cardNumberLast4 => $composableBuilder(
      column: $table.cardNumberLast4,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cardExpiry => $composableBuilder(
      column: $table.cardExpiry, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get statementDay => $composableBuilder(
      column: $table.statementDay,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dueDay => $composableBuilder(
      column: $table.dueDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get creditLimit => $composableBuilder(
      column: $table.creditLimit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get minPaymentAmount => $composableBuilder(
      column: $table.minPaymentAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get minPaymentPercent => $composableBuilder(
      column: $table.minPaymentPercent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get creditReminderEnabled => $composableBuilder(
      column: $table.creditReminderEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get creditReminderTime => $composableBuilder(
      column: $table.creditReminderTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get creditEarlyReminderEnabled => $composableBuilder(
      column: $table.creditEarlyReminderEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get linkedAccountId => $composableBuilder(
      column: $table.linkedAccountId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get excludeFromBankTotal => $composableBuilder(
      column: $table.excludeFromBankTotal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dontLinkToCard => $composableBuilder(
      column: $table.dontLinkToCard,
      builder: (column) => ColumnOrderings(column));
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => column);

  GeneratedColumn<int> get excludeFromTotal => $composableBuilder(
      column: $table.excludeFromTotal, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get goldKarat =>
      $composableBuilder(column: $table.goldKarat, builder: (column) => column);

  GeneratedColumn<double> get goldGrams =>
      $composableBuilder(column: $table.goldGrams, builder: (column) => column);

  GeneratedColumn<String> get cardHolderName => $composableBuilder(
      column: $table.cardHolderName, builder: (column) => column);

  GeneratedColumn<String> get cardNumberLast4 => $composableBuilder(
      column: $table.cardNumberLast4, builder: (column) => column);

  GeneratedColumn<String> get cardExpiry => $composableBuilder(
      column: $table.cardExpiry, builder: (column) => column);

  GeneratedColumn<int> get statementDay => $composableBuilder(
      column: $table.statementDay, builder: (column) => column);

  GeneratedColumn<int> get dueDay =>
      $composableBuilder(column: $table.dueDay, builder: (column) => column);

  GeneratedColumn<double> get creditLimit => $composableBuilder(
      column: $table.creditLimit, builder: (column) => column);

  GeneratedColumn<double> get minPaymentAmount => $composableBuilder(
      column: $table.minPaymentAmount, builder: (column) => column);

  GeneratedColumn<double> get minPaymentPercent => $composableBuilder(
      column: $table.minPaymentPercent, builder: (column) => column);

  GeneratedColumn<int> get creditReminderEnabled => $composableBuilder(
      column: $table.creditReminderEnabled, builder: (column) => column);

  GeneratedColumn<String> get creditReminderTime => $composableBuilder(
      column: $table.creditReminderTime, builder: (column) => column);

  GeneratedColumn<int> get creditEarlyReminderEnabled => $composableBuilder(
      column: $table.creditEarlyReminderEnabled, builder: (column) => column);

  GeneratedColumn<String> get linkedAccountId => $composableBuilder(
      column: $table.linkedAccountId, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => column);

  GeneratedColumn<int> get excludeFromBankTotal => $composableBuilder(
      column: $table.excludeFromBankTotal, builder: (column) => column);

  GeneratedColumn<int> get dontLinkToCard => $composableBuilder(
      column: $table.dontLinkToCard, builder: (column) => column);
}

class $$AccountsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AccountsTable,
    AccountEntry,
    $$AccountsTableFilterComposer,
    $$AccountsTableOrderingComposer,
    $$AccountsTableAnnotationComposer,
    $$AccountsTableCreateCompanionBuilder,
    $$AccountsTableUpdateCompanionBuilder,
    (AccountEntry, BaseReferences<_$AppDatabase, $AccountsTable, AccountEntry>),
    AccountEntry,
    PrefetchHooks Function()> {
  $$AccountsTableTableManager(_$AppDatabase db, $AccountsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<double> balance = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<int> colorValue = const Value.absent(),
            Value<int> excludeFromTotal = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<int?> goldKarat = const Value.absent(),
            Value<double?> goldGrams = const Value.absent(),
            Value<String?> cardHolderName = const Value.absent(),
            Value<String?> cardNumberLast4 = const Value.absent(),
            Value<String?> cardExpiry = const Value.absent(),
            Value<int?> statementDay = const Value.absent(),
            Value<int?> dueDay = const Value.absent(),
            Value<double?> creditLimit = const Value.absent(),
            Value<double?> minPaymentAmount = const Value.absent(),
            Value<double?> minPaymentPercent = const Value.absent(),
            Value<int> creditReminderEnabled = const Value.absent(),
            Value<String?> creditReminderTime = const Value.absent(),
            Value<int?> creditEarlyReminderEnabled = const Value.absent(),
            Value<String?> linkedAccountId = const Value.absent(),
            Value<int?> orderIndex = const Value.absent(),
            Value<int> excludeFromBankTotal = const Value.absent(),
            Value<int> dontLinkToCard = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AccountsCompanion(
            id: id,
            name: name,
            type: type,
            balance: balance,
            currency: currency,
            colorValue: colorValue,
            excludeFromTotal: excludeFromTotal,
            createdAt: createdAt,
            goldKarat: goldKarat,
            goldGrams: goldGrams,
            cardHolderName: cardHolderName,
            cardNumberLast4: cardNumberLast4,
            cardExpiry: cardExpiry,
            statementDay: statementDay,
            dueDay: dueDay,
            creditLimit: creditLimit,
            minPaymentAmount: minPaymentAmount,
            minPaymentPercent: minPaymentPercent,
            creditReminderEnabled: creditReminderEnabled,
            creditReminderTime: creditReminderTime,
            creditEarlyReminderEnabled: creditEarlyReminderEnabled,
            linkedAccountId: linkedAccountId,
            orderIndex: orderIndex,
            excludeFromBankTotal: excludeFromBankTotal,
            dontLinkToCard: dontLinkToCard,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String type,
            required double balance,
            Value<String> currency = const Value.absent(),
            required int colorValue,
            Value<int> excludeFromTotal = const Value.absent(),
            required String createdAt,
            Value<int?> goldKarat = const Value.absent(),
            Value<double?> goldGrams = const Value.absent(),
            Value<String?> cardHolderName = const Value.absent(),
            Value<String?> cardNumberLast4 = const Value.absent(),
            Value<String?> cardExpiry = const Value.absent(),
            Value<int?> statementDay = const Value.absent(),
            Value<int?> dueDay = const Value.absent(),
            Value<double?> creditLimit = const Value.absent(),
            Value<double?> minPaymentAmount = const Value.absent(),
            Value<double?> minPaymentPercent = const Value.absent(),
            Value<int> creditReminderEnabled = const Value.absent(),
            Value<String?> creditReminderTime = const Value.absent(),
            Value<int?> creditEarlyReminderEnabled = const Value.absent(),
            Value<String?> linkedAccountId = const Value.absent(),
            Value<int?> orderIndex = const Value.absent(),
            Value<int> excludeFromBankTotal = const Value.absent(),
            Value<int> dontLinkToCard = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AccountsCompanion.insert(
            id: id,
            name: name,
            type: type,
            balance: balance,
            currency: currency,
            colorValue: colorValue,
            excludeFromTotal: excludeFromTotal,
            createdAt: createdAt,
            goldKarat: goldKarat,
            goldGrams: goldGrams,
            cardHolderName: cardHolderName,
            cardNumberLast4: cardNumberLast4,
            cardExpiry: cardExpiry,
            statementDay: statementDay,
            dueDay: dueDay,
            creditLimit: creditLimit,
            minPaymentAmount: minPaymentAmount,
            minPaymentPercent: minPaymentPercent,
            creditReminderEnabled: creditReminderEnabled,
            creditReminderTime: creditReminderTime,
            creditEarlyReminderEnabled: creditEarlyReminderEnabled,
            linkedAccountId: linkedAccountId,
            orderIndex: orderIndex,
            excludeFromBankTotal: excludeFromBankTotal,
            dontLinkToCard: dontLinkToCard,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$AccountsTable, AccountEntry>(table),
                    BaseReferences<_$AppDatabase, $AccountsTable, AccountEntry>(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AccountsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AccountsTable,
    AccountEntry,
    $$AccountsTableFilterComposer,
    $$AccountsTableOrderingComposer,
    $$AccountsTableAnnotationComposer,
    $$AccountsTableCreateCompanionBuilder,
    $$AccountsTableUpdateCompanionBuilder,
    (AccountEntry, BaseReferences<_$AppDatabase, $AccountsTable, AccountEntry>),
    AccountEntry,
    PrefetchHooks Function()>;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required String id,
  required String name,
  required String type,
  required int colorValue,
  Value<int> iconCodePoint,
  Value<int> orderIndex,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> type,
  Value<int> colorValue,
  Value<int> iconCodePoint,
  Value<int> orderIndex,
  Value<int> rowid,
});

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get iconCodePoint => $composableBuilder(
      column: $table.iconCodePoint, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnFilters(column));
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get iconCodePoint => $composableBuilder(
      column: $table.iconCodePoint,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnOrderings(column));
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => column);

  GeneratedColumn<int> get iconCodePoint => $composableBuilder(
      column: $table.iconCodePoint, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => column);
}

class $$CategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTable,
    CategoryEntry,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (
      CategoryEntry,
      BaseReferences<_$AppDatabase, $CategoriesTable, CategoryEntry>
    ),
    CategoryEntry,
    PrefetchHooks Function()> {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int> colorValue = const Value.absent(),
            Value<int> iconCodePoint = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesCompanion(
            id: id,
            name: name,
            type: type,
            colorValue: colorValue,
            iconCodePoint: iconCodePoint,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String type,
            required int colorValue,
            Value<int> iconCodePoint = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesCompanion.insert(
            id: id,
            name: name,
            type: type,
            colorValue: colorValue,
            iconCodePoint: iconCodePoint,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$CategoriesTable, CategoryEntry>(table),
                    BaseReferences<_$AppDatabase, $CategoriesTable,
                        CategoryEntry>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriesTable,
    CategoryEntry,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (
      CategoryEntry,
      BaseReferences<_$AppDatabase, $CategoriesTable, CategoryEntry>
    ),
    CategoryEntry,
    PrefetchHooks Function()>;
typedef $$TransactionsTableCreateCompanionBuilder = TransactionsCompanion
    Function({
  required String id,
  required String type,
  required double amount,
  required String description,
  required String accountId,
  required String categoryId,
  required String date,
  Value<String> note,
  Value<String> currency,
  Value<int> rowid,
});
typedef $$TransactionsTableUpdateCompanionBuilder = TransactionsCompanion
    Function({
  Value<String> id,
  Value<String> type,
  Value<double> amount,
  Value<String> description,
  Value<String> accountId,
  Value<String> categoryId,
  Value<String> date,
  Value<String> note,
  Value<String> currency,
  Value<int> rowid,
});

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accountId => $composableBuilder(
      column: $table.accountId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accountId => $composableBuilder(
      column: $table.accountId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);
}

class $$TransactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionsTable,
    TransactionEntry,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (
      TransactionEntry,
      BaseReferences<_$AppDatabase, $TransactionsTable, TransactionEntry>
    ),
    TransactionEntry,
    PrefetchHooks Function()> {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> accountId = const Value.absent(),
            Value<String> categoryId = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> note = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TransactionsCompanion(
            id: id,
            type: type,
            amount: amount,
            description: description,
            accountId: accountId,
            categoryId: categoryId,
            date: date,
            note: note,
            currency: currency,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String type,
            required double amount,
            required String description,
            required String accountId,
            required String categoryId,
            required String date,
            Value<String> note = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TransactionsCompanion.insert(
            id: id,
            type: type,
            amount: amount,
            description: description,
            accountId: accountId,
            categoryId: categoryId,
            date: date,
            note: note,
            currency: currency,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$TransactionsTable, TransactionEntry>(table),
                    BaseReferences<_$AppDatabase, $TransactionsTable,
                        TransactionEntry>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TransactionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransactionsTable,
    TransactionEntry,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (
      TransactionEntry,
      BaseReferences<_$AppDatabase, $TransactionsTable, TransactionEntry>
    ),
    TransactionEntry,
    PrefetchHooks Function()>;
typedef $$RecurringPaymentsTableCreateCompanionBuilder
    = RecurringPaymentsCompanion Function({
  required String id,
  required String name,
  required String accountId,
  required String categoryId,
  required double amount,
  Value<String> paymentType,
  Value<int> freqVal,
  Value<String> freqUnit,
  required String startDate,
  required String nextDate,
  Value<String?> endDate,
  Value<int> paidPayments,
  Value<int> reminderEnabled,
  Value<String> reminderTime,
  Value<int> earlyReminderEnabled,
  Value<String> notes,
  Value<String> recurringType,
  Value<int> autoPayEnabled,
  Value<String> autoPayTime,
  Value<int> rowid,
});
typedef $$RecurringPaymentsTableUpdateCompanionBuilder
    = RecurringPaymentsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> accountId,
  Value<String> categoryId,
  Value<double> amount,
  Value<String> paymentType,
  Value<int> freqVal,
  Value<String> freqUnit,
  Value<String> startDate,
  Value<String> nextDate,
  Value<String?> endDate,
  Value<int> paidPayments,
  Value<int> reminderEnabled,
  Value<String> reminderTime,
  Value<int> earlyReminderEnabled,
  Value<String> notes,
  Value<String> recurringType,
  Value<int> autoPayEnabled,
  Value<String> autoPayTime,
  Value<int> rowid,
});

class $$RecurringPaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $RecurringPaymentsTable> {
  $$RecurringPaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accountId => $composableBuilder(
      column: $table.accountId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentType => $composableBuilder(
      column: $table.paymentType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get freqVal => $composableBuilder(
      column: $table.freqVal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get freqUnit => $composableBuilder(
      column: $table.freqUnit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nextDate => $composableBuilder(
      column: $table.nextDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get paidPayments => $composableBuilder(
      column: $table.paidPayments, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderTime => $composableBuilder(
      column: $table.reminderTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get earlyReminderEnabled => $composableBuilder(
      column: $table.earlyReminderEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recurringType => $composableBuilder(
      column: $table.recurringType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get autoPayEnabled => $composableBuilder(
      column: $table.autoPayEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get autoPayTime => $composableBuilder(
      column: $table.autoPayTime, builder: (column) => ColumnFilters(column));
}

class $$RecurringPaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecurringPaymentsTable> {
  $$RecurringPaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accountId => $composableBuilder(
      column: $table.accountId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentType => $composableBuilder(
      column: $table.paymentType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get freqVal => $composableBuilder(
      column: $table.freqVal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get freqUnit => $composableBuilder(
      column: $table.freqUnit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nextDate => $composableBuilder(
      column: $table.nextDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get paidPayments => $composableBuilder(
      column: $table.paidPayments,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderTime => $composableBuilder(
      column: $table.reminderTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get earlyReminderEnabled => $composableBuilder(
      column: $table.earlyReminderEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recurringType => $composableBuilder(
      column: $table.recurringType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get autoPayEnabled => $composableBuilder(
      column: $table.autoPayEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get autoPayTime => $composableBuilder(
      column: $table.autoPayTime, builder: (column) => ColumnOrderings(column));
}

class $$RecurringPaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecurringPaymentsTable> {
  $$RecurringPaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get paymentType => $composableBuilder(
      column: $table.paymentType, builder: (column) => column);

  GeneratedColumn<int> get freqVal =>
      $composableBuilder(column: $table.freqVal, builder: (column) => column);

  GeneratedColumn<String> get freqUnit =>
      $composableBuilder(column: $table.freqUnit, builder: (column) => column);

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get nextDate =>
      $composableBuilder(column: $table.nextDate, builder: (column) => column);

  GeneratedColumn<String> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get paidPayments => $composableBuilder(
      column: $table.paidPayments, builder: (column) => column);

  GeneratedColumn<int> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled, builder: (column) => column);

  GeneratedColumn<String> get reminderTime => $composableBuilder(
      column: $table.reminderTime, builder: (column) => column);

  GeneratedColumn<int> get earlyReminderEnabled => $composableBuilder(
      column: $table.earlyReminderEnabled, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get recurringType => $composableBuilder(
      column: $table.recurringType, builder: (column) => column);

  GeneratedColumn<int> get autoPayEnabled => $composableBuilder(
      column: $table.autoPayEnabled, builder: (column) => column);

  GeneratedColumn<String> get autoPayTime => $composableBuilder(
      column: $table.autoPayTime, builder: (column) => column);
}

class $$RecurringPaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecurringPaymentsTable,
    RecurringPaymentEntry,
    $$RecurringPaymentsTableFilterComposer,
    $$RecurringPaymentsTableOrderingComposer,
    $$RecurringPaymentsTableAnnotationComposer,
    $$RecurringPaymentsTableCreateCompanionBuilder,
    $$RecurringPaymentsTableUpdateCompanionBuilder,
    (
      RecurringPaymentEntry,
      BaseReferences<_$AppDatabase, $RecurringPaymentsTable,
          RecurringPaymentEntry>
    ),
    RecurringPaymentEntry,
    PrefetchHooks Function()> {
  $$RecurringPaymentsTableTableManager(
      _$AppDatabase db, $RecurringPaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecurringPaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecurringPaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecurringPaymentsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> accountId = const Value.absent(),
            Value<String> categoryId = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> paymentType = const Value.absent(),
            Value<int> freqVal = const Value.absent(),
            Value<String> freqUnit = const Value.absent(),
            Value<String> startDate = const Value.absent(),
            Value<String> nextDate = const Value.absent(),
            Value<String?> endDate = const Value.absent(),
            Value<int> paidPayments = const Value.absent(),
            Value<int> reminderEnabled = const Value.absent(),
            Value<String> reminderTime = const Value.absent(),
            Value<int> earlyReminderEnabled = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<String> recurringType = const Value.absent(),
            Value<int> autoPayEnabled = const Value.absent(),
            Value<String> autoPayTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RecurringPaymentsCompanion(
            id: id,
            name: name,
            accountId: accountId,
            categoryId: categoryId,
            amount: amount,
            paymentType: paymentType,
            freqVal: freqVal,
            freqUnit: freqUnit,
            startDate: startDate,
            nextDate: nextDate,
            endDate: endDate,
            paidPayments: paidPayments,
            reminderEnabled: reminderEnabled,
            reminderTime: reminderTime,
            earlyReminderEnabled: earlyReminderEnabled,
            notes: notes,
            recurringType: recurringType,
            autoPayEnabled: autoPayEnabled,
            autoPayTime: autoPayTime,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String accountId,
            required String categoryId,
            required double amount,
            Value<String> paymentType = const Value.absent(),
            Value<int> freqVal = const Value.absent(),
            Value<String> freqUnit = const Value.absent(),
            required String startDate,
            required String nextDate,
            Value<String?> endDate = const Value.absent(),
            Value<int> paidPayments = const Value.absent(),
            Value<int> reminderEnabled = const Value.absent(),
            Value<String> reminderTime = const Value.absent(),
            Value<int> earlyReminderEnabled = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<String> recurringType = const Value.absent(),
            Value<int> autoPayEnabled = const Value.absent(),
            Value<String> autoPayTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RecurringPaymentsCompanion.insert(
            id: id,
            name: name,
            accountId: accountId,
            categoryId: categoryId,
            amount: amount,
            paymentType: paymentType,
            freqVal: freqVal,
            freqUnit: freqUnit,
            startDate: startDate,
            nextDate: nextDate,
            endDate: endDate,
            paidPayments: paidPayments,
            reminderEnabled: reminderEnabled,
            reminderTime: reminderTime,
            earlyReminderEnabled: earlyReminderEnabled,
            notes: notes,
            recurringType: recurringType,
            autoPayEnabled: autoPayEnabled,
            autoPayTime: autoPayTime,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$RecurringPaymentsTable, RecurringPaymentEntry>(
                        table),
                    BaseReferences<_$AppDatabase, $RecurringPaymentsTable,
                        RecurringPaymentEntry>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RecurringPaymentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RecurringPaymentsTable,
    RecurringPaymentEntry,
    $$RecurringPaymentsTableFilterComposer,
    $$RecurringPaymentsTableOrderingComposer,
    $$RecurringPaymentsTableAnnotationComposer,
    $$RecurringPaymentsTableCreateCompanionBuilder,
    $$RecurringPaymentsTableUpdateCompanionBuilder,
    (
      RecurringPaymentEntry,
      BaseReferences<_$AppDatabase, $RecurringPaymentsTable,
          RecurringPaymentEntry>
    ),
    RecurringPaymentEntry,
    PrefetchHooks Function()>;
typedef $$WishlistTableCreateCompanionBuilder = WishlistCompanion Function({
  required String id,
  required String name,
  required double targetPrice,
  required String priority,
  Value<int> isPurchased,
  Value<String> notes,
  required String createdAt,
  Value<String?> goalId,
  Value<int> rowid,
});
typedef $$WishlistTableUpdateCompanionBuilder = WishlistCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<double> targetPrice,
  Value<String> priority,
  Value<int> isPurchased,
  Value<String> notes,
  Value<String> createdAt,
  Value<String?> goalId,
  Value<int> rowid,
});

class $$WishlistTableFilterComposer
    extends Composer<_$AppDatabase, $WishlistTable> {
  $$WishlistTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get targetPrice => $composableBuilder(
      column: $table.targetPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isPurchased => $composableBuilder(
      column: $table.isPurchased, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get goalId => $composableBuilder(
      column: $table.goalId, builder: (column) => ColumnFilters(column));
}

class $$WishlistTableOrderingComposer
    extends Composer<_$AppDatabase, $WishlistTable> {
  $$WishlistTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get targetPrice => $composableBuilder(
      column: $table.targetPrice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isPurchased => $composableBuilder(
      column: $table.isPurchased, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get goalId => $composableBuilder(
      column: $table.goalId, builder: (column) => ColumnOrderings(column));
}

class $$WishlistTableAnnotationComposer
    extends Composer<_$AppDatabase, $WishlistTable> {
  $$WishlistTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get targetPrice => $composableBuilder(
      column: $table.targetPrice, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<int> get isPurchased => $composableBuilder(
      column: $table.isPurchased, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get goalId =>
      $composableBuilder(column: $table.goalId, builder: (column) => column);
}

class $$WishlistTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WishlistTable,
    WishlistEntry,
    $$WishlistTableFilterComposer,
    $$WishlistTableOrderingComposer,
    $$WishlistTableAnnotationComposer,
    $$WishlistTableCreateCompanionBuilder,
    $$WishlistTableUpdateCompanionBuilder,
    (
      WishlistEntry,
      BaseReferences<_$AppDatabase, $WishlistTable, WishlistEntry>
    ),
    WishlistEntry,
    PrefetchHooks Function()> {
  $$WishlistTableTableManager(_$AppDatabase db, $WishlistTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WishlistTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WishlistTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WishlistTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double> targetPrice = const Value.absent(),
            Value<String> priority = const Value.absent(),
            Value<int> isPurchased = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String?> goalId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WishlistCompanion(
            id: id,
            name: name,
            targetPrice: targetPrice,
            priority: priority,
            isPurchased: isPurchased,
            notes: notes,
            createdAt: createdAt,
            goalId: goalId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required double targetPrice,
            required String priority,
            Value<int> isPurchased = const Value.absent(),
            Value<String> notes = const Value.absent(),
            required String createdAt,
            Value<String?> goalId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WishlistCompanion.insert(
            id: id,
            name: name,
            targetPrice: targetPrice,
            priority: priority,
            isPurchased: isPurchased,
            notes: notes,
            createdAt: createdAt,
            goalId: goalId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$WishlistTable, WishlistEntry>(table),
                    BaseReferences<_$AppDatabase, $WishlistTable,
                        WishlistEntry>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WishlistTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WishlistTable,
    WishlistEntry,
    $$WishlistTableFilterComposer,
    $$WishlistTableOrderingComposer,
    $$WishlistTableAnnotationComposer,
    $$WishlistTableCreateCompanionBuilder,
    $$WishlistTableUpdateCompanionBuilder,
    (
      WishlistEntry,
      BaseReferences<_$AppDatabase, $WishlistTable, WishlistEntry>
    ),
    WishlistEntry,
    PrefetchHooks Function()>;
typedef $$AssetItemsTableCreateCompanionBuilder = AssetItemsCompanion Function({
  required String id,
  required String name,
  required double value,
  required int colorValue,
  Value<String?> notes,
  required String createdAt,
  Value<int> rowid,
});
typedef $$AssetItemsTableUpdateCompanionBuilder = AssetItemsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<double> value,
  Value<int> colorValue,
  Value<String?> notes,
  Value<String> createdAt,
  Value<int> rowid,
});

class $$AssetItemsTableFilterComposer
    extends Composer<_$AppDatabase, $AssetItemsTable> {
  $$AssetItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$AssetItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $AssetItemsTable> {
  $$AssetItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$AssetItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssetItemsTable> {
  $$AssetItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AssetItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AssetItemsTable,
    AssetItemEntry,
    $$AssetItemsTableFilterComposer,
    $$AssetItemsTableOrderingComposer,
    $$AssetItemsTableAnnotationComposer,
    $$AssetItemsTableCreateCompanionBuilder,
    $$AssetItemsTableUpdateCompanionBuilder,
    (
      AssetItemEntry,
      BaseReferences<_$AppDatabase, $AssetItemsTable, AssetItemEntry>
    ),
    AssetItemEntry,
    PrefetchHooks Function()> {
  $$AssetItemsTableTableManager(_$AppDatabase db, $AssetItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssetItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssetItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssetItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double> value = const Value.absent(),
            Value<int> colorValue = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AssetItemsCompanion(
            id: id,
            name: name,
            value: value,
            colorValue: colorValue,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required double value,
            required int colorValue,
            Value<String?> notes = const Value.absent(),
            required String createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AssetItemsCompanion.insert(
            id: id,
            name: name,
            value: value,
            colorValue: colorValue,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$AssetItemsTable, AssetItemEntry>(table),
                    BaseReferences<_$AppDatabase, $AssetItemsTable,
                        AssetItemEntry>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AssetItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AssetItemsTable,
    AssetItemEntry,
    $$AssetItemsTableFilterComposer,
    $$AssetItemsTableOrderingComposer,
    $$AssetItemsTableAnnotationComposer,
    $$AssetItemsTableCreateCompanionBuilder,
    $$AssetItemsTableUpdateCompanionBuilder,
    (
      AssetItemEntry,
      BaseReferences<_$AppDatabase, $AssetItemsTable, AssetItemEntry>
    ),
    AssetItemEntry,
    PrefetchHooks Function()>;
typedef $$NetWorthSnapshotsTableCreateCompanionBuilder
    = NetWorthSnapshotsCompanion Function({
  required String id,
  required String date,
  required double totalAccounts,
  required double totalAssets,
  required double netWorth,
  required String currency,
  Value<int> rowid,
});
typedef $$NetWorthSnapshotsTableUpdateCompanionBuilder
    = NetWorthSnapshotsCompanion Function({
  Value<String> id,
  Value<String> date,
  Value<double> totalAccounts,
  Value<double> totalAssets,
  Value<double> netWorth,
  Value<String> currency,
  Value<int> rowid,
});

class $$NetWorthSnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $NetWorthSnapshotsTable> {
  $$NetWorthSnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalAccounts => $composableBuilder(
      column: $table.totalAccounts, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalAssets => $composableBuilder(
      column: $table.totalAssets, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get netWorth => $composableBuilder(
      column: $table.netWorth, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));
}

class $$NetWorthSnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $NetWorthSnapshotsTable> {
  $$NetWorthSnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalAccounts => $composableBuilder(
      column: $table.totalAccounts,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalAssets => $composableBuilder(
      column: $table.totalAssets, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get netWorth => $composableBuilder(
      column: $table.netWorth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));
}

class $$NetWorthSnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NetWorthSnapshotsTable> {
  $$NetWorthSnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get totalAccounts => $composableBuilder(
      column: $table.totalAccounts, builder: (column) => column);

  GeneratedColumn<double> get totalAssets => $composableBuilder(
      column: $table.totalAssets, builder: (column) => column);

  GeneratedColumn<double> get netWorth =>
      $composableBuilder(column: $table.netWorth, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);
}

class $$NetWorthSnapshotsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NetWorthSnapshotsTable,
    NetWorthSnapshotEntry,
    $$NetWorthSnapshotsTableFilterComposer,
    $$NetWorthSnapshotsTableOrderingComposer,
    $$NetWorthSnapshotsTableAnnotationComposer,
    $$NetWorthSnapshotsTableCreateCompanionBuilder,
    $$NetWorthSnapshotsTableUpdateCompanionBuilder,
    (
      NetWorthSnapshotEntry,
      BaseReferences<_$AppDatabase, $NetWorthSnapshotsTable,
          NetWorthSnapshotEntry>
    ),
    NetWorthSnapshotEntry,
    PrefetchHooks Function()> {
  $$NetWorthSnapshotsTableTableManager(
      _$AppDatabase db, $NetWorthSnapshotsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NetWorthSnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NetWorthSnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NetWorthSnapshotsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<double> totalAccounts = const Value.absent(),
            Value<double> totalAssets = const Value.absent(),
            Value<double> netWorth = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NetWorthSnapshotsCompanion(
            id: id,
            date: date,
            totalAccounts: totalAccounts,
            totalAssets: totalAssets,
            netWorth: netWorth,
            currency: currency,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String date,
            required double totalAccounts,
            required double totalAssets,
            required double netWorth,
            required String currency,
            Value<int> rowid = const Value.absent(),
          }) =>
              NetWorthSnapshotsCompanion.insert(
            id: id,
            date: date,
            totalAccounts: totalAccounts,
            totalAssets: totalAssets,
            netWorth: netWorth,
            currency: currency,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$NetWorthSnapshotsTable, NetWorthSnapshotEntry>(
                        table),
                    BaseReferences<_$AppDatabase, $NetWorthSnapshotsTable,
                        NetWorthSnapshotEntry>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NetWorthSnapshotsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NetWorthSnapshotsTable,
    NetWorthSnapshotEntry,
    $$NetWorthSnapshotsTableFilterComposer,
    $$NetWorthSnapshotsTableOrderingComposer,
    $$NetWorthSnapshotsTableAnnotationComposer,
    $$NetWorthSnapshotsTableCreateCompanionBuilder,
    $$NetWorthSnapshotsTableUpdateCompanionBuilder,
    (
      NetWorthSnapshotEntry,
      BaseReferences<_$AppDatabase, $NetWorthSnapshotsTable,
          NetWorthSnapshotEntry>
    ),
    NetWorthSnapshotEntry,
    PrefetchHooks Function()>;
typedef $$LendedPeopleTableCreateCompanionBuilder = LendedPeopleCompanion
    Function({
  required String id,
  required String name,
  required int colorValue,
  Value<String> notes,
  required String createdAt,
  Value<int> rowid,
});
typedef $$LendedPeopleTableUpdateCompanionBuilder = LendedPeopleCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<int> colorValue,
  Value<String> notes,
  Value<String> createdAt,
  Value<int> rowid,
});

class $$LendedPeopleTableFilterComposer
    extends Composer<_$AppDatabase, $LendedPeopleTable> {
  $$LendedPeopleTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$LendedPeopleTableOrderingComposer
    extends Composer<_$AppDatabase, $LendedPeopleTable> {
  $$LendedPeopleTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$LendedPeopleTableAnnotationComposer
    extends Composer<_$AppDatabase, $LendedPeopleTable> {
  $$LendedPeopleTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LendedPeopleTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LendedPeopleTable,
    LendedPersonEntry,
    $$LendedPeopleTableFilterComposer,
    $$LendedPeopleTableOrderingComposer,
    $$LendedPeopleTableAnnotationComposer,
    $$LendedPeopleTableCreateCompanionBuilder,
    $$LendedPeopleTableUpdateCompanionBuilder,
    (
      LendedPersonEntry,
      BaseReferences<_$AppDatabase, $LendedPeopleTable, LendedPersonEntry>
    ),
    LendedPersonEntry,
    PrefetchHooks Function()> {
  $$LendedPeopleTableTableManager(_$AppDatabase db, $LendedPeopleTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LendedPeopleTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LendedPeopleTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LendedPeopleTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> colorValue = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LendedPeopleCompanion(
            id: id,
            name: name,
            colorValue: colorValue,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required int colorValue,
            Value<String> notes = const Value.absent(),
            required String createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              LendedPeopleCompanion.insert(
            id: id,
            name: name,
            colorValue: colorValue,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$LendedPeopleTable, LendedPersonEntry>(table),
                    BaseReferences<_$AppDatabase, $LendedPeopleTable,
                        LendedPersonEntry>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LendedPeopleTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LendedPeopleTable,
    LendedPersonEntry,
    $$LendedPeopleTableFilterComposer,
    $$LendedPeopleTableOrderingComposer,
    $$LendedPeopleTableAnnotationComposer,
    $$LendedPeopleTableCreateCompanionBuilder,
    $$LendedPeopleTableUpdateCompanionBuilder,
    (
      LendedPersonEntry,
      BaseReferences<_$AppDatabase, $LendedPeopleTable, LendedPersonEntry>
    ),
    LendedPersonEntry,
    PrefetchHooks Function()>;
typedef $$LendedMoneyTableTableCreateCompanionBuilder
    = LendedMoneyTableCompanion Function({
  required String id,
  required String personId,
  required double amount,
  required String type,
  Value<String?> accountId,
  Value<int> isSettled,
  required String date,
  Value<String?> dueDate,
  Value<String> notes,
  Value<int> reminderEnabled,
  Value<String> reminderTime,
  Value<int> rowid,
});
typedef $$LendedMoneyTableTableUpdateCompanionBuilder
    = LendedMoneyTableCompanion Function({
  Value<String> id,
  Value<String> personId,
  Value<double> amount,
  Value<String> type,
  Value<String?> accountId,
  Value<int> isSettled,
  Value<String> date,
  Value<String?> dueDate,
  Value<String> notes,
  Value<int> reminderEnabled,
  Value<String> reminderTime,
  Value<int> rowid,
});

class $$LendedMoneyTableTableFilterComposer
    extends Composer<_$AppDatabase, $LendedMoneyTableTable> {
  $$LendedMoneyTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get personId => $composableBuilder(
      column: $table.personId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accountId => $composableBuilder(
      column: $table.accountId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isSettled => $composableBuilder(
      column: $table.isSettled, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderTime => $composableBuilder(
      column: $table.reminderTime, builder: (column) => ColumnFilters(column));
}

class $$LendedMoneyTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LendedMoneyTableTable> {
  $$LendedMoneyTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get personId => $composableBuilder(
      column: $table.personId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accountId => $composableBuilder(
      column: $table.accountId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isSettled => $composableBuilder(
      column: $table.isSettled, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderTime => $composableBuilder(
      column: $table.reminderTime,
      builder: (column) => ColumnOrderings(column));
}

class $$LendedMoneyTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LendedMoneyTableTable> {
  $$LendedMoneyTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get personId =>
      $composableBuilder(column: $table.personId, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<int> get isSettled =>
      $composableBuilder(column: $table.isSettled, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled, builder: (column) => column);

  GeneratedColumn<String> get reminderTime => $composableBuilder(
      column: $table.reminderTime, builder: (column) => column);
}

class $$LendedMoneyTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LendedMoneyTableTable,
    LendedMoneyEntry,
    $$LendedMoneyTableTableFilterComposer,
    $$LendedMoneyTableTableOrderingComposer,
    $$LendedMoneyTableTableAnnotationComposer,
    $$LendedMoneyTableTableCreateCompanionBuilder,
    $$LendedMoneyTableTableUpdateCompanionBuilder,
    (
      LendedMoneyEntry,
      BaseReferences<_$AppDatabase, $LendedMoneyTableTable, LendedMoneyEntry>
    ),
    LendedMoneyEntry,
    PrefetchHooks Function()> {
  $$LendedMoneyTableTableTableManager(
      _$AppDatabase db, $LendedMoneyTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LendedMoneyTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LendedMoneyTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LendedMoneyTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> personId = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String?> accountId = const Value.absent(),
            Value<int> isSettled = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String?> dueDate = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<int> reminderEnabled = const Value.absent(),
            Value<String> reminderTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LendedMoneyTableCompanion(
            id: id,
            personId: personId,
            amount: amount,
            type: type,
            accountId: accountId,
            isSettled: isSettled,
            date: date,
            dueDate: dueDate,
            notes: notes,
            reminderEnabled: reminderEnabled,
            reminderTime: reminderTime,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String personId,
            required double amount,
            required String type,
            Value<String?> accountId = const Value.absent(),
            Value<int> isSettled = const Value.absent(),
            required String date,
            Value<String?> dueDate = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<int> reminderEnabled = const Value.absent(),
            Value<String> reminderTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LendedMoneyTableCompanion.insert(
            id: id,
            personId: personId,
            amount: amount,
            type: type,
            accountId: accountId,
            isSettled: isSettled,
            date: date,
            dueDate: dueDate,
            notes: notes,
            reminderEnabled: reminderEnabled,
            reminderTime: reminderTime,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$LendedMoneyTableTable, LendedMoneyEntry>(
                        table),
                    BaseReferences<_$AppDatabase, $LendedMoneyTableTable,
                        LendedMoneyEntry>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LendedMoneyTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LendedMoneyTableTable,
    LendedMoneyEntry,
    $$LendedMoneyTableTableFilterComposer,
    $$LendedMoneyTableTableOrderingComposer,
    $$LendedMoneyTableTableAnnotationComposer,
    $$LendedMoneyTableTableCreateCompanionBuilder,
    $$LendedMoneyTableTableUpdateCompanionBuilder,
    (
      LendedMoneyEntry,
      BaseReferences<_$AppDatabase, $LendedMoneyTableTable, LendedMoneyEntry>
    ),
    LendedMoneyEntry,
    PrefetchHooks Function()>;
typedef $$AssetsTableCreateCompanionBuilder = AssetsCompanion Function({
  required String id,
  required String name,
  required double value,
  Value<String> currency,
  Value<String> notes,
  required String createdAt,
  Value<int> rowid,
});
typedef $$AssetsTableUpdateCompanionBuilder = AssetsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<double> value,
  Value<String> currency,
  Value<String> notes,
  Value<String> createdAt,
  Value<int> rowid,
});

class $$AssetsTableFilterComposer
    extends Composer<_$AppDatabase, $AssetsTable> {
  $$AssetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$AssetsTableOrderingComposer
    extends Composer<_$AppDatabase, $AssetsTable> {
  $$AssetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$AssetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssetsTable> {
  $$AssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AssetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AssetsTable,
    AssetEntry,
    $$AssetsTableFilterComposer,
    $$AssetsTableOrderingComposer,
    $$AssetsTableAnnotationComposer,
    $$AssetsTableCreateCompanionBuilder,
    $$AssetsTableUpdateCompanionBuilder,
    (AssetEntry, BaseReferences<_$AppDatabase, $AssetsTable, AssetEntry>),
    AssetEntry,
    PrefetchHooks Function()> {
  $$AssetsTableTableManager(_$AppDatabase db, $AssetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double> value = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AssetsCompanion(
            id: id,
            name: name,
            value: value,
            currency: currency,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required double value,
            Value<String> currency = const Value.absent(),
            Value<String> notes = const Value.absent(),
            required String createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AssetsCompanion.insert(
            id: id,
            name: name,
            value: value,
            currency: currency,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$AssetsTable, AssetEntry>(table),
                    BaseReferences<_$AppDatabase, $AssetsTable, AssetEntry>(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AssetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AssetsTable,
    AssetEntry,
    $$AssetsTableFilterComposer,
    $$AssetsTableOrderingComposer,
    $$AssetsTableAnnotationComposer,
    $$AssetsTableCreateCompanionBuilder,
    $$AssetsTableUpdateCompanionBuilder,
    (AssetEntry, BaseReferences<_$AppDatabase, $AssetsTable, AssetEntry>),
    AssetEntry,
    PrefetchHooks Function()>;
typedef $$BudgetsTableCreateCompanionBuilder = BudgetsCompanion Function({
  required String id,
  required String categoryId,
  required double amount,
  Value<String> period,
  required String createdAt,
  Value<int> allowRollover,
  Value<int> rowid,
});
typedef $$BudgetsTableUpdateCompanionBuilder = BudgetsCompanion Function({
  Value<String> id,
  Value<String> categoryId,
  Value<double> amount,
  Value<String> period,
  Value<String> createdAt,
  Value<int> allowRollover,
  Value<int> rowid,
});

class $$BudgetsTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetsTable> {
  $$BudgetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get period => $composableBuilder(
      column: $table.period, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get allowRollover => $composableBuilder(
      column: $table.allowRollover, builder: (column) => ColumnFilters(column));
}

class $$BudgetsTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetsTable> {
  $$BudgetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get period => $composableBuilder(
      column: $table.period, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get allowRollover => $composableBuilder(
      column: $table.allowRollover,
      builder: (column) => ColumnOrderings(column));
}

class $$BudgetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetsTable> {
  $$BudgetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get period =>
      $composableBuilder(column: $table.period, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get allowRollover => $composableBuilder(
      column: $table.allowRollover, builder: (column) => column);
}

class $$BudgetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BudgetsTable,
    BudgetEntry,
    $$BudgetsTableFilterComposer,
    $$BudgetsTableOrderingComposer,
    $$BudgetsTableAnnotationComposer,
    $$BudgetsTableCreateCompanionBuilder,
    $$BudgetsTableUpdateCompanionBuilder,
    (BudgetEntry, BaseReferences<_$AppDatabase, $BudgetsTable, BudgetEntry>),
    BudgetEntry,
    PrefetchHooks Function()> {
  $$BudgetsTableTableManager(_$AppDatabase db, $BudgetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> categoryId = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> period = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<int> allowRollover = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BudgetsCompanion(
            id: id,
            categoryId: categoryId,
            amount: amount,
            period: period,
            createdAt: createdAt,
            allowRollover: allowRollover,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String categoryId,
            required double amount,
            Value<String> period = const Value.absent(),
            required String createdAt,
            Value<int> allowRollover = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BudgetsCompanion.insert(
            id: id,
            categoryId: categoryId,
            amount: amount,
            period: period,
            createdAt: createdAt,
            allowRollover: allowRollover,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$BudgetsTable, BudgetEntry>(table),
                    BaseReferences<_$AppDatabase, $BudgetsTable, BudgetEntry>(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BudgetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BudgetsTable,
    BudgetEntry,
    $$BudgetsTableFilterComposer,
    $$BudgetsTableOrderingComposer,
    $$BudgetsTableAnnotationComposer,
    $$BudgetsTableCreateCompanionBuilder,
    $$BudgetsTableUpdateCompanionBuilder,
    (BudgetEntry, BaseReferences<_$AppDatabase, $BudgetsTable, BudgetEntry>),
    BudgetEntry,
    PrefetchHooks Function()>;
typedef $$RecurringHistoryTableCreateCompanionBuilder
    = RecurringHistoryCompanion Function({
  required String id,
  required String recurringId,
  required String action,
  required String date,
  required double amount,
  required String currency,
  Value<int> rowid,
});
typedef $$RecurringHistoryTableUpdateCompanionBuilder
    = RecurringHistoryCompanion Function({
  Value<String> id,
  Value<String> recurringId,
  Value<String> action,
  Value<String> date,
  Value<double> amount,
  Value<String> currency,
  Value<int> rowid,
});

class $$RecurringHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $RecurringHistoryTable> {
  $$RecurringHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recurringId => $composableBuilder(
      column: $table.recurringId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get action => $composableBuilder(
      column: $table.action, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));
}

class $$RecurringHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $RecurringHistoryTable> {
  $$RecurringHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recurringId => $composableBuilder(
      column: $table.recurringId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get action => $composableBuilder(
      column: $table.action, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));
}

class $$RecurringHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecurringHistoryTable> {
  $$RecurringHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get recurringId => $composableBuilder(
      column: $table.recurringId, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);
}

class $$RecurringHistoryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecurringHistoryTable,
    RecurringHistoryRow,
    $$RecurringHistoryTableFilterComposer,
    $$RecurringHistoryTableOrderingComposer,
    $$RecurringHistoryTableAnnotationComposer,
    $$RecurringHistoryTableCreateCompanionBuilder,
    $$RecurringHistoryTableUpdateCompanionBuilder,
    (
      RecurringHistoryRow,
      BaseReferences<_$AppDatabase, $RecurringHistoryTable, RecurringHistoryRow>
    ),
    RecurringHistoryRow,
    PrefetchHooks Function()> {
  $$RecurringHistoryTableTableManager(
      _$AppDatabase db, $RecurringHistoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecurringHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecurringHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecurringHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> recurringId = const Value.absent(),
            Value<String> action = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RecurringHistoryCompanion(
            id: id,
            recurringId: recurringId,
            action: action,
            date: date,
            amount: amount,
            currency: currency,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String recurringId,
            required String action,
            required String date,
            required double amount,
            required String currency,
            Value<int> rowid = const Value.absent(),
          }) =>
              RecurringHistoryCompanion.insert(
            id: id,
            recurringId: recurringId,
            action: action,
            date: date,
            amount: amount,
            currency: currency,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$RecurringHistoryTable, RecurringHistoryRow>(
                        table),
                    BaseReferences<_$AppDatabase, $RecurringHistoryTable,
                        RecurringHistoryRow>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RecurringHistoryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RecurringHistoryTable,
    RecurringHistoryRow,
    $$RecurringHistoryTableFilterComposer,
    $$RecurringHistoryTableOrderingComposer,
    $$RecurringHistoryTableAnnotationComposer,
    $$RecurringHistoryTableCreateCompanionBuilder,
    $$RecurringHistoryTableUpdateCompanionBuilder,
    (
      RecurringHistoryRow,
      BaseReferences<_$AppDatabase, $RecurringHistoryTable, RecurringHistoryRow>
    ),
    RecurringHistoryRow,
    PrefetchHooks Function()>;
typedef $$SavingsGoalsTableCreateCompanionBuilder = SavingsGoalsCompanion
    Function({
  required String id,
  required String name,
  required double targetAmount,
  Value<double> currentAmount,
  required String currency,
  Value<String?> targetDate,
  required int colorValue,
  Value<int> isCompleted,
  required String createdAt,
  Value<String?> completedAt,
  Value<String?> wishlistItemId,
  Value<int> rowid,
});
typedef $$SavingsGoalsTableUpdateCompanionBuilder = SavingsGoalsCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<double> targetAmount,
  Value<double> currentAmount,
  Value<String> currency,
  Value<String?> targetDate,
  Value<int> colorValue,
  Value<int> isCompleted,
  Value<String> createdAt,
  Value<String?> completedAt,
  Value<String?> wishlistItemId,
  Value<int> rowid,
});

class $$SavingsGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $SavingsGoalsTable> {
  $$SavingsGoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get targetAmount => $composableBuilder(
      column: $table.targetAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get currentAmount => $composableBuilder(
      column: $table.currentAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get wishlistItemId => $composableBuilder(
      column: $table.wishlistItemId,
      builder: (column) => ColumnFilters(column));
}

class $$SavingsGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $SavingsGoalsTable> {
  $$SavingsGoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get targetAmount => $composableBuilder(
      column: $table.targetAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get currentAmount => $composableBuilder(
      column: $table.currentAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get wishlistItemId => $composableBuilder(
      column: $table.wishlistItemId,
      builder: (column) => ColumnOrderings(column));
}

class $$SavingsGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavingsGoalsTable> {
  $$SavingsGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get targetAmount => $composableBuilder(
      column: $table.targetAmount, builder: (column) => column);

  GeneratedColumn<double> get currentAmount => $composableBuilder(
      column: $table.currentAmount, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => column);

  GeneratedColumn<int> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<String> get wishlistItemId => $composableBuilder(
      column: $table.wishlistItemId, builder: (column) => column);
}

class $$SavingsGoalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SavingsGoalsTable,
    SavingsGoalEntry,
    $$SavingsGoalsTableFilterComposer,
    $$SavingsGoalsTableOrderingComposer,
    $$SavingsGoalsTableAnnotationComposer,
    $$SavingsGoalsTableCreateCompanionBuilder,
    $$SavingsGoalsTableUpdateCompanionBuilder,
    (
      SavingsGoalEntry,
      BaseReferences<_$AppDatabase, $SavingsGoalsTable, SavingsGoalEntry>
    ),
    SavingsGoalEntry,
    PrefetchHooks Function()> {
  $$SavingsGoalsTableTableManager(_$AppDatabase db, $SavingsGoalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavingsGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavingsGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavingsGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double> targetAmount = const Value.absent(),
            Value<double> currentAmount = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<String?> targetDate = const Value.absent(),
            Value<int> colorValue = const Value.absent(),
            Value<int> isCompleted = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String?> completedAt = const Value.absent(),
            Value<String?> wishlistItemId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SavingsGoalsCompanion(
            id: id,
            name: name,
            targetAmount: targetAmount,
            currentAmount: currentAmount,
            currency: currency,
            targetDate: targetDate,
            colorValue: colorValue,
            isCompleted: isCompleted,
            createdAt: createdAt,
            completedAt: completedAt,
            wishlistItemId: wishlistItemId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required double targetAmount,
            Value<double> currentAmount = const Value.absent(),
            required String currency,
            Value<String?> targetDate = const Value.absent(),
            required int colorValue,
            Value<int> isCompleted = const Value.absent(),
            required String createdAt,
            Value<String?> completedAt = const Value.absent(),
            Value<String?> wishlistItemId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SavingsGoalsCompanion.insert(
            id: id,
            name: name,
            targetAmount: targetAmount,
            currentAmount: currentAmount,
            currency: currency,
            targetDate: targetDate,
            colorValue: colorValue,
            isCompleted: isCompleted,
            createdAt: createdAt,
            completedAt: completedAt,
            wishlistItemId: wishlistItemId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$SavingsGoalsTable, SavingsGoalEntry>(table),
                    BaseReferences<_$AppDatabase, $SavingsGoalsTable,
                        SavingsGoalEntry>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SavingsGoalsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SavingsGoalsTable,
    SavingsGoalEntry,
    $$SavingsGoalsTableFilterComposer,
    $$SavingsGoalsTableOrderingComposer,
    $$SavingsGoalsTableAnnotationComposer,
    $$SavingsGoalsTableCreateCompanionBuilder,
    $$SavingsGoalsTableUpdateCompanionBuilder,
    (
      SavingsGoalEntry,
      BaseReferences<_$AppDatabase, $SavingsGoalsTable, SavingsGoalEntry>
    ),
    SavingsGoalEntry,
    PrefetchHooks Function()>;
typedef $$SavingsContributionsTableCreateCompanionBuilder
    = SavingsContributionsCompanion Function({
  required String id,
  required String goalId,
  required double amount,
  required String accountId,
  required String type,
  required String date,
  Value<String> note,
  Value<int> rowid,
});
typedef $$SavingsContributionsTableUpdateCompanionBuilder
    = SavingsContributionsCompanion Function({
  Value<String> id,
  Value<String> goalId,
  Value<double> amount,
  Value<String> accountId,
  Value<String> type,
  Value<String> date,
  Value<String> note,
  Value<int> rowid,
});

class $$SavingsContributionsTableFilterComposer
    extends Composer<_$AppDatabase, $SavingsContributionsTable> {
  $$SavingsContributionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get goalId => $composableBuilder(
      column: $table.goalId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accountId => $composableBuilder(
      column: $table.accountId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));
}

class $$SavingsContributionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SavingsContributionsTable> {
  $$SavingsContributionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get goalId => $composableBuilder(
      column: $table.goalId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accountId => $composableBuilder(
      column: $table.accountId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));
}

class $$SavingsContributionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavingsContributionsTable> {
  $$SavingsContributionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get goalId =>
      $composableBuilder(column: $table.goalId, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$SavingsContributionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SavingsContributionsTable,
    SavingsContributionEntry,
    $$SavingsContributionsTableFilterComposer,
    $$SavingsContributionsTableOrderingComposer,
    $$SavingsContributionsTableAnnotationComposer,
    $$SavingsContributionsTableCreateCompanionBuilder,
    $$SavingsContributionsTableUpdateCompanionBuilder,
    (
      SavingsContributionEntry,
      BaseReferences<_$AppDatabase, $SavingsContributionsTable,
          SavingsContributionEntry>
    ),
    SavingsContributionEntry,
    PrefetchHooks Function()> {
  $$SavingsContributionsTableTableManager(
      _$AppDatabase db, $SavingsContributionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavingsContributionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavingsContributionsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavingsContributionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> goalId = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> accountId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SavingsContributionsCompanion(
            id: id,
            goalId: goalId,
            amount: amount,
            accountId: accountId,
            type: type,
            date: date,
            note: note,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String goalId,
            required double amount,
            required String accountId,
            required String type,
            required String date,
            Value<String> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SavingsContributionsCompanion.insert(
            id: id,
            goalId: goalId,
            amount: amount,
            accountId: accountId,
            type: type,
            date: date,
            note: note,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$SavingsContributionsTable,
                        SavingsContributionEntry>(table),
                    BaseReferences<_$AppDatabase, $SavingsContributionsTable,
                        SavingsContributionEntry>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SavingsContributionsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SavingsContributionsTable,
        SavingsContributionEntry,
        $$SavingsContributionsTableFilterComposer,
        $$SavingsContributionsTableOrderingComposer,
        $$SavingsContributionsTableAnnotationComposer,
        $$SavingsContributionsTableCreateCompanionBuilder,
        $$SavingsContributionsTableUpdateCompanionBuilder,
        (
          SavingsContributionEntry,
          BaseReferences<_$AppDatabase, $SavingsContributionsTable,
              SavingsContributionEntry>
        ),
        SavingsContributionEntry,
        PrefetchHooks Function()>;
typedef $$LoansTableCreateCompanionBuilder = LoansCompanion Function({
  required String id,
  required String name,
  required double principal,
  Value<String> currency,
  required String startDate,
  required String endDate,
  Value<double?> interestRate,
  Value<String?> accountId,
  Value<String?> transferAccountId,
  Value<int> reminderEnabled,
  Value<int> reminderDay,
  Value<String> reminderTime,
  Value<int> isSettled,
  Value<String> notes,
  required String createdAt,
  Value<int> rowid,
});
typedef $$LoansTableUpdateCompanionBuilder = LoansCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<double> principal,
  Value<String> currency,
  Value<String> startDate,
  Value<String> endDate,
  Value<double?> interestRate,
  Value<String?> accountId,
  Value<String?> transferAccountId,
  Value<int> reminderEnabled,
  Value<int> reminderDay,
  Value<String> reminderTime,
  Value<int> isSettled,
  Value<String> notes,
  Value<String> createdAt,
  Value<int> rowid,
});

class $$LoansTableFilterComposer extends Composer<_$AppDatabase, $LoansTable> {
  $$LoansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get principal => $composableBuilder(
      column: $table.principal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get interestRate => $composableBuilder(
      column: $table.interestRate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accountId => $composableBuilder(
      column: $table.accountId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transferAccountId => $composableBuilder(
      column: $table.transferAccountId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reminderDay => $composableBuilder(
      column: $table.reminderDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderTime => $composableBuilder(
      column: $table.reminderTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isSettled => $composableBuilder(
      column: $table.isSettled, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$LoansTableOrderingComposer
    extends Composer<_$AppDatabase, $LoansTable> {
  $$LoansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get principal => $composableBuilder(
      column: $table.principal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get interestRate => $composableBuilder(
      column: $table.interestRate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accountId => $composableBuilder(
      column: $table.accountId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transferAccountId => $composableBuilder(
      column: $table.transferAccountId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reminderDay => $composableBuilder(
      column: $table.reminderDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderTime => $composableBuilder(
      column: $table.reminderTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isSettled => $composableBuilder(
      column: $table.isSettled, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$LoansTableAnnotationComposer
    extends Composer<_$AppDatabase, $LoansTable> {
  $$LoansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get principal =>
      $composableBuilder(column: $table.principal, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<double> get interestRate => $composableBuilder(
      column: $table.interestRate, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get transferAccountId => $composableBuilder(
      column: $table.transferAccountId, builder: (column) => column);

  GeneratedColumn<int> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled, builder: (column) => column);

  GeneratedColumn<int> get reminderDay => $composableBuilder(
      column: $table.reminderDay, builder: (column) => column);

  GeneratedColumn<String> get reminderTime => $composableBuilder(
      column: $table.reminderTime, builder: (column) => column);

  GeneratedColumn<int> get isSettled =>
      $composableBuilder(column: $table.isSettled, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LoansTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LoansTable,
    LoanEntry,
    $$LoansTableFilterComposer,
    $$LoansTableOrderingComposer,
    $$LoansTableAnnotationComposer,
    $$LoansTableCreateCompanionBuilder,
    $$LoansTableUpdateCompanionBuilder,
    (LoanEntry, BaseReferences<_$AppDatabase, $LoansTable, LoanEntry>),
    LoanEntry,
    PrefetchHooks Function()> {
  $$LoansTableTableManager(_$AppDatabase db, $LoansTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LoansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LoansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LoansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double> principal = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<String> startDate = const Value.absent(),
            Value<String> endDate = const Value.absent(),
            Value<double?> interestRate = const Value.absent(),
            Value<String?> accountId = const Value.absent(),
            Value<String?> transferAccountId = const Value.absent(),
            Value<int> reminderEnabled = const Value.absent(),
            Value<int> reminderDay = const Value.absent(),
            Value<String> reminderTime = const Value.absent(),
            Value<int> isSettled = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LoansCompanion(
            id: id,
            name: name,
            principal: principal,
            currency: currency,
            startDate: startDate,
            endDate: endDate,
            interestRate: interestRate,
            accountId: accountId,
            transferAccountId: transferAccountId,
            reminderEnabled: reminderEnabled,
            reminderDay: reminderDay,
            reminderTime: reminderTime,
            isSettled: isSettled,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required double principal,
            Value<String> currency = const Value.absent(),
            required String startDate,
            required String endDate,
            Value<double?> interestRate = const Value.absent(),
            Value<String?> accountId = const Value.absent(),
            Value<String?> transferAccountId = const Value.absent(),
            Value<int> reminderEnabled = const Value.absent(),
            Value<int> reminderDay = const Value.absent(),
            Value<String> reminderTime = const Value.absent(),
            Value<int> isSettled = const Value.absent(),
            Value<String> notes = const Value.absent(),
            required String createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              LoansCompanion.insert(
            id: id,
            name: name,
            principal: principal,
            currency: currency,
            startDate: startDate,
            endDate: endDate,
            interestRate: interestRate,
            accountId: accountId,
            transferAccountId: transferAccountId,
            reminderEnabled: reminderEnabled,
            reminderDay: reminderDay,
            reminderTime: reminderTime,
            isSettled: isSettled,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$LoansTable, LoanEntry>(table),
                    BaseReferences<_$AppDatabase, $LoansTable, LoanEntry>(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LoansTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LoansTable,
    LoanEntry,
    $$LoansTableFilterComposer,
    $$LoansTableOrderingComposer,
    $$LoansTableAnnotationComposer,
    $$LoansTableCreateCompanionBuilder,
    $$LoansTableUpdateCompanionBuilder,
    (LoanEntry, BaseReferences<_$AppDatabase, $LoansTable, LoanEntry>),
    LoanEntry,
    PrefetchHooks Function()>;
typedef $$LoanPaymentsTableCreateCompanionBuilder = LoanPaymentsCompanion
    Function({
  required String id,
  required String loanId,
  required String date,
  required double amount,
  required String currency,
  Value<String?> accountId,
  Value<String> notes,
  Value<int> rowid,
});
typedef $$LoanPaymentsTableUpdateCompanionBuilder = LoanPaymentsCompanion
    Function({
  Value<String> id,
  Value<String> loanId,
  Value<String> date,
  Value<double> amount,
  Value<String> currency,
  Value<String?> accountId,
  Value<String> notes,
  Value<int> rowid,
});

class $$LoanPaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $LoanPaymentsTable> {
  $$LoanPaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get loanId => $composableBuilder(
      column: $table.loanId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accountId => $composableBuilder(
      column: $table.accountId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));
}

class $$LoanPaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $LoanPaymentsTable> {
  $$LoanPaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get loanId => $composableBuilder(
      column: $table.loanId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accountId => $composableBuilder(
      column: $table.accountId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$LoanPaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LoanPaymentsTable> {
  $$LoanPaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get loanId =>
      $composableBuilder(column: $table.loanId, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$LoanPaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LoanPaymentsTable,
    LoanPaymentEntry,
    $$LoanPaymentsTableFilterComposer,
    $$LoanPaymentsTableOrderingComposer,
    $$LoanPaymentsTableAnnotationComposer,
    $$LoanPaymentsTableCreateCompanionBuilder,
    $$LoanPaymentsTableUpdateCompanionBuilder,
    (
      LoanPaymentEntry,
      BaseReferences<_$AppDatabase, $LoanPaymentsTable, LoanPaymentEntry>
    ),
    LoanPaymentEntry,
    PrefetchHooks Function()> {
  $$LoanPaymentsTableTableManager(_$AppDatabase db, $LoanPaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LoanPaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LoanPaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LoanPaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> loanId = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<String?> accountId = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LoanPaymentsCompanion(
            id: id,
            loanId: loanId,
            date: date,
            amount: amount,
            currency: currency,
            accountId: accountId,
            notes: notes,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String loanId,
            required String date,
            required double amount,
            required String currency,
            Value<String?> accountId = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LoanPaymentsCompanion.insert(
            id: id,
            loanId: loanId,
            date: date,
            amount: amount,
            currency: currency,
            accountId: accountId,
            notes: notes,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$LoanPaymentsTable, LoanPaymentEntry>(table),
                    BaseReferences<_$AppDatabase, $LoanPaymentsTable,
                        LoanPaymentEntry>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LoanPaymentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LoanPaymentsTable,
    LoanPaymentEntry,
    $$LoanPaymentsTableFilterComposer,
    $$LoanPaymentsTableOrderingComposer,
    $$LoanPaymentsTableAnnotationComposer,
    $$LoanPaymentsTableCreateCompanionBuilder,
    $$LoanPaymentsTableUpdateCompanionBuilder,
    (
      LoanPaymentEntry,
      BaseReferences<_$AppDatabase, $LoanPaymentsTable, LoanPaymentEntry>
    ),
    LoanPaymentEntry,
    PrefetchHooks Function()>;
typedef $$TransactionPresetsTableCreateCompanionBuilder
    = TransactionPresetsCompanion Function({
  required String id,
  required String title,
  required String type,
  required double amount,
  required String accountId,
  required String categoryId,
  Value<String> currency,
  Value<String> note,
  required int colorValue,
  Value<int> iconCodePoint,
  Value<int> orderIndex,
  required String createdAt,
  Value<int> rowid,
});
typedef $$TransactionPresetsTableUpdateCompanionBuilder
    = TransactionPresetsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> type,
  Value<double> amount,
  Value<String> accountId,
  Value<String> categoryId,
  Value<String> currency,
  Value<String> note,
  Value<int> colorValue,
  Value<int> iconCodePoint,
  Value<int> orderIndex,
  Value<String> createdAt,
  Value<int> rowid,
});

class $$TransactionPresetsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionPresetsTable> {
  $$TransactionPresetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accountId => $composableBuilder(
      column: $table.accountId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get iconCodePoint => $composableBuilder(
      column: $table.iconCodePoint, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$TransactionPresetsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionPresetsTable> {
  $$TransactionPresetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accountId => $composableBuilder(
      column: $table.accountId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get iconCodePoint => $composableBuilder(
      column: $table.iconCodePoint,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$TransactionPresetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionPresetsTable> {
  $$TransactionPresetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => column);

  GeneratedColumn<int> get iconCodePoint => $composableBuilder(
      column: $table.iconCodePoint, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TransactionPresetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionPresetsTable,
    TransactionPresetEntry,
    $$TransactionPresetsTableFilterComposer,
    $$TransactionPresetsTableOrderingComposer,
    $$TransactionPresetsTableAnnotationComposer,
    $$TransactionPresetsTableCreateCompanionBuilder,
    $$TransactionPresetsTableUpdateCompanionBuilder,
    (
      TransactionPresetEntry,
      BaseReferences<_$AppDatabase, $TransactionPresetsTable,
          TransactionPresetEntry>
    ),
    TransactionPresetEntry,
    PrefetchHooks Function()> {
  $$TransactionPresetsTableTableManager(
      _$AppDatabase db, $TransactionPresetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionPresetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionPresetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionPresetsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> accountId = const Value.absent(),
            Value<String> categoryId = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<String> note = const Value.absent(),
            Value<int> colorValue = const Value.absent(),
            Value<int> iconCodePoint = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TransactionPresetsCompanion(
            id: id,
            title: title,
            type: type,
            amount: amount,
            accountId: accountId,
            categoryId: categoryId,
            currency: currency,
            note: note,
            colorValue: colorValue,
            iconCodePoint: iconCodePoint,
            orderIndex: orderIndex,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String type,
            required double amount,
            required String accountId,
            required String categoryId,
            Value<String> currency = const Value.absent(),
            Value<String> note = const Value.absent(),
            required int colorValue,
            Value<int> iconCodePoint = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            required String createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              TransactionPresetsCompanion.insert(
            id: id,
            title: title,
            type: type,
            amount: amount,
            accountId: accountId,
            categoryId: categoryId,
            currency: currency,
            note: note,
            colorValue: colorValue,
            iconCodePoint: iconCodePoint,
            orderIndex: orderIndex,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$TransactionPresetsTable,
                        TransactionPresetEntry>(table),
                    BaseReferences<_$AppDatabase, $TransactionPresetsTable,
                        TransactionPresetEntry>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TransactionPresetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransactionPresetsTable,
    TransactionPresetEntry,
    $$TransactionPresetsTableFilterComposer,
    $$TransactionPresetsTableOrderingComposer,
    $$TransactionPresetsTableAnnotationComposer,
    $$TransactionPresetsTableCreateCompanionBuilder,
    $$TransactionPresetsTableUpdateCompanionBuilder,
    (
      TransactionPresetEntry,
      BaseReferences<_$AppDatabase, $TransactionPresetsTable,
          TransactionPresetEntry>
    ),
    TransactionPresetEntry,
    PrefetchHooks Function()>;
typedef $$TransactionSplitsTableCreateCompanionBuilder
    = TransactionSplitsCompanion Function({
  required String id,
  required String transactionId,
  required String categoryId,
  required double amount,
  Value<String> note,
  Value<int> rowid,
});
typedef $$TransactionSplitsTableUpdateCompanionBuilder
    = TransactionSplitsCompanion Function({
  Value<String> id,
  Value<String> transactionId,
  Value<String> categoryId,
  Value<double> amount,
  Value<String> note,
  Value<int> rowid,
});

class $$TransactionSplitsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionSplitsTable> {
  $$TransactionSplitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transactionId => $composableBuilder(
      column: $table.transactionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));
}

class $$TransactionSplitsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionSplitsTable> {
  $$TransactionSplitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transactionId => $composableBuilder(
      column: $table.transactionId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));
}

class $$TransactionSplitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionSplitsTable> {
  $$TransactionSplitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get transactionId => $composableBuilder(
      column: $table.transactionId, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$TransactionSplitsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionSplitsTable,
    TransactionSplitEntry,
    $$TransactionSplitsTableFilterComposer,
    $$TransactionSplitsTableOrderingComposer,
    $$TransactionSplitsTableAnnotationComposer,
    $$TransactionSplitsTableCreateCompanionBuilder,
    $$TransactionSplitsTableUpdateCompanionBuilder,
    (
      TransactionSplitEntry,
      BaseReferences<_$AppDatabase, $TransactionSplitsTable,
          TransactionSplitEntry>
    ),
    TransactionSplitEntry,
    PrefetchHooks Function()> {
  $$TransactionSplitsTableTableManager(
      _$AppDatabase db, $TransactionSplitsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionSplitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionSplitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionSplitsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> transactionId = const Value.absent(),
            Value<String> categoryId = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TransactionSplitsCompanion(
            id: id,
            transactionId: transactionId,
            categoryId: categoryId,
            amount: amount,
            note: note,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String transactionId,
            required String categoryId,
            required double amount,
            Value<String> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TransactionSplitsCompanion.insert(
            id: id,
            transactionId: transactionId,
            categoryId: categoryId,
            amount: amount,
            note: note,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$TransactionSplitsTable, TransactionSplitEntry>(
                        table),
                    BaseReferences<_$AppDatabase, $TransactionSplitsTable,
                        TransactionSplitEntry>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TransactionSplitsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransactionSplitsTable,
    TransactionSplitEntry,
    $$TransactionSplitsTableFilterComposer,
    $$TransactionSplitsTableOrderingComposer,
    $$TransactionSplitsTableAnnotationComposer,
    $$TransactionSplitsTableCreateCompanionBuilder,
    $$TransactionSplitsTableUpdateCompanionBuilder,
    (
      TransactionSplitEntry,
      BaseReferences<_$AppDatabase, $TransactionSplitsTable,
          TransactionSplitEntry>
    ),
    TransactionSplitEntry,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$RecurringPaymentsTableTableManager get recurringPayments =>
      $$RecurringPaymentsTableTableManager(_db, _db.recurringPayments);
  $$WishlistTableTableManager get wishlist =>
      $$WishlistTableTableManager(_db, _db.wishlist);
  $$AssetItemsTableTableManager get assetItems =>
      $$AssetItemsTableTableManager(_db, _db.assetItems);
  $$NetWorthSnapshotsTableTableManager get netWorthSnapshots =>
      $$NetWorthSnapshotsTableTableManager(_db, _db.netWorthSnapshots);
  $$LendedPeopleTableTableManager get lendedPeople =>
      $$LendedPeopleTableTableManager(_db, _db.lendedPeople);
  $$LendedMoneyTableTableTableManager get lendedMoneyTable =>
      $$LendedMoneyTableTableTableManager(_db, _db.lendedMoneyTable);
  $$AssetsTableTableManager get assets =>
      $$AssetsTableTableManager(_db, _db.assets);
  $$BudgetsTableTableManager get budgets =>
      $$BudgetsTableTableManager(_db, _db.budgets);
  $$RecurringHistoryTableTableManager get recurringHistory =>
      $$RecurringHistoryTableTableManager(_db, _db.recurringHistory);
  $$SavingsGoalsTableTableManager get savingsGoals =>
      $$SavingsGoalsTableTableManager(_db, _db.savingsGoals);
  $$SavingsContributionsTableTableManager get savingsContributions =>
      $$SavingsContributionsTableTableManager(_db, _db.savingsContributions);
  $$LoansTableTableManager get loans =>
      $$LoansTableTableManager(_db, _db.loans);
  $$LoanPaymentsTableTableManager get loanPayments =>
      $$LoanPaymentsTableTableManager(_db, _db.loanPayments);
  $$TransactionPresetsTableTableManager get transactionPresets =>
      $$TransactionPresetsTableTableManager(_db, _db.transactionPresets);
  $$TransactionSplitsTableTableManager get transactionSplits =>
      $$TransactionSplitsTableTableManager(_db, _db.transactionSplits);
}
