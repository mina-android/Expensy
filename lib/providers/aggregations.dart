// lib/providers/aggregations.dart
// note: Pure functional financial aggregation engine for income, expense, and category totals.

import '../models/models.dart';

typedef CurrencyConverter = double Function(double amount, String currency);

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
      final val = convert != null ? convert(t.amount, t.currency) : t.amount;
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
  static Map<String, double> categoryTotals(
    Iterable<AppTransaction> transactions, {
    DateTime? start,
    DateTime? end,
    String? accountId,
    String type = 'expense',
    CurrencyConverter? convert,
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
      if (t.categoryId.isEmpty) continue;

      final val = convert != null ? convert(t.amount, t.currency) : t.amount;
      result[t.categoryId] = (result[t.categoryId] ?? 0.0) + val;
    }

    return result;
  }

  /// Computes day-by-day totals for a calendar month or date range.
  static Map<DateTime, PeriodTotals> dayTotals(
    Iterable<AppTransaction> transactions, {
    DateTime? start,
    DateTime? end,
    String? accountId,
    CurrencyConverter? convert,
  }) {
    final Map<DateTime, List<AppTransaction>> dayMap = {};

    for (final t in transactions) {
      if (isExcludedFromTotals(t)) continue;
      if (accountId != null && t.accountId != accountId && t.paidViaAccountId != accountId) {
        continue;
      }
      if (start != null && t.date.isBefore(start)) continue;
      if (end != null && !t.date.isBefore(end)) continue;

      final dayKey = DateTime(t.date.year, t.date.month, t.date.day);
      dayMap.putIfAbsent(dayKey, () => []).add(t);
    }

    final Map<DateTime, PeriodTotals> result = {};
    for (final entry in dayMap.entries) {
      result[entry.key] = periodTotals(entry.value, convert: convert);
    }
    return result;
  }
}
