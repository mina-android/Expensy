// lib/providers/aggregations.dart
// note: Pure functional financial aggregation engine for income, expense, and category totals.

import '../models/models.dart';

typedef CurrencyConverter = double Function(double amount, String currency);
typedef TransactionCurrencyResolver = String Function(AppTransaction tx);

class PeriodTotals {
  final double income;
  final double expense;
  final double net;
  final int count;

  const PeriodTotals({
    required this.income,
    required this.expense,
    required this.net,
    required this.count,
  });

  static const zero = PeriodTotals(income: 0.0, expense: 0.0, net: 0.0, count: 0);
}

class FinancialAggregations {
  /// Excludes transfers, debt settlements, and investments from standard income/expense cashflow.
  static bool isExcludedFromTotals(AppTransaction t) {
    return t.isTransfer || t.isInvestment;
  }

  /// Calculates total income and expense within a date range [start, end),
  /// optionally filtered by [accountId] and converted to main currency via [convert].
  static PeriodTotals periodTotals(
    Iterable<AppTransaction> transactions, {
    DateTime? start,
    DateTime? end,
    String? accountId,
    CurrencyConverter? convert,
    TransactionCurrencyResolver? resolveCurrency,
  }) {
    double income = 0.0;
    double expense = 0.0;
    int count = 0;

    for (final t in transactions) {
      if (isExcludedFromTotals(t)) continue;
      if (accountId != null && t.accountId != accountId && t.paidViaAccountId != accountId) {
        continue;
      }
      if (start != null && t.date.isBefore(start)) continue;
      if (end != null && !t.date.isBefore(end)) continue;

      count++;
      final cur = resolveCurrency != null ? resolveCurrency(t) : t.currency;
      final val = convert != null ? convert(t.amount, cur) : t.amount;
      if (t.type == 'income') {
        income += val;
      } else if (t.type == 'expense') {
        expense += val;
      }
    }

    return PeriodTotals(
      income: income,
      expense: expense,
      net: income - expense,
      count: count,
    );
  }

  /// Calculates category breakdown for expenses (or income) within [start, end).
  /// When [resolveCategoryBucket] is provided, rolls up child categories into the
  /// resolved bucket (e.g. parent category ID). When [getSplits] is provided,
  /// attributes split transactions to their individual split categories.
  static Map<String, double> categoryTotals(
    Iterable<AppTransaction> transactions, {
    DateTime? start,
    DateTime? end,
    String? accountId,
    String type = 'expense',
    CurrencyConverter? convert,
    TransactionCurrencyResolver? resolveCurrency,
    String Function(String categoryId)? resolveCategoryBucket,
    Iterable<TransactionSplit> Function(String txId)? getSplits,
  }) {
    final Map<String, double> result = {};

    for (final t in transactions) {
      if (isExcludedFromTotals(t)) continue;
      if (t.type != type) continue;
      if (accountId != null && t.accountId != accountId && t.paidViaAccountId != accountId) {
        continue;
      }
      if (start != null && t.date.isBefore(start)) continue;
      if (end != null && !t.date.isBefore(end)) continue;

      final cur = resolveCurrency != null ? resolveCurrency(t) : t.currency;
      final txSplits = getSplits != null ? getSplits(t.id) : const <TransactionSplit>[];
      if (txSplits.isNotEmpty) {
        for (final s in txSplits) {
          if (s.categoryId.isEmpty) continue;
          final bucket = resolveCategoryBucket != null
              ? resolveCategoryBucket(s.categoryId)
              : s.categoryId;
          if (bucket.isEmpty) continue;
          final val = convert != null ? convert(s.amount, cur) : s.amount;
          result[bucket] = (result[bucket] ?? 0.0) + val;
        }
      } else {
        if (t.categoryId.isEmpty) continue;
        final bucket = resolveCategoryBucket != null
            ? resolveCategoryBucket(t.categoryId)
            : t.categoryId;
        if (bucket.isEmpty) continue;
        final val = convert != null ? convert(t.amount, cur) : t.amount;
        result[bucket] = (result[bucket] ?? 0.0) + val;
      }
    }

    return result;
  }
}
