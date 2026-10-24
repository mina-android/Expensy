// lib/services/data_check_service.dart
// note: Diagnostic service to verify database integrity, orphan records, and consistency.

import '../database/app_database.dart';

class DataHealthIssue {
  final String code; // D1, D2, D3, D5, P0_1, COUNTER_DRIFT
  final String title;
  final String details;
  final int count;
  final List<String> affectedIds;

  const DataHealthIssue({
    required this.code,
    required this.title,
    required this.details,
    required this.count,
    this.affectedIds = const [],
  });
}

class DataHealthReport {
  final DateTime timestamp;
  final List<DataHealthIssue> issues;

  const DataHealthReport({
    required this.timestamp,
    required this.issues,
  });

  bool get hasIssues => issues.isNotEmpty;
  int get totalIssueCount => issues.fold(0, (sum, i) => sum + i.count);
}

class DataCheckService {
  final AppDatabase db;

  DataCheckService([AppDatabase? database]) : db = database ?? AppDatabase.instance;

  Future<DataHealthReport> runCheck() async {
    final issues = <DataHealthIssue>[];

    // 1. D2: Orphan recurring_history entries
    final orphanHistory = await db.customSelect('''
      SELECT rh.id, rh.recurring_id FROM recurring_history rh
      LEFT JOIN recurring_payments rp ON rh.recurring_id = rp.id
      WHERE rp.id IS NULL
    ''').get();
    if (orphanHistory.isNotEmpty) {
      issues.add(DataHealthIssue(
        code: 'D2',
        title: 'Orphan recurring history rows',
        details: 'History entries exist whose parent recurring payment has been deleted.',
        count: orphanHistory.length,
        affectedIds: orphanHistory.map((r) => r.data['id'].toString()).toList(),
      ));
    }

    // 2. D5: Transactions attributed directly to a debit card (or debit card balance != 0)
    final debitCardTxs = await db.customSelect('''
      SELECT t.id, t.description, t.account_id FROM transactions t
      JOIN accounts a ON t.account_id = a.id
      WHERE a.type = 'debit'
    ''').get();
    final strayCardBalances = await db.customSelect('''
      SELECT id, name, balance FROM accounts
      WHERE (type = 'debit') AND balance != 0.0
    ''').get();
    if (debitCardTxs.isNotEmpty || strayCardBalances.isNotEmpty) {
      final ids = [
        ...debitCardTxs.map((r) => r.data['id'].toString()),
        ...strayCardBalances.map((r) => r.data['id'].toString()),
      ];
      issues.add(DataHealthIssue(
        code: 'D5',
        title: 'Transactions attributed directly to debit card',
        details: 'Transactions are attributed to a debit card instead of parent bank account, or debit card has non-zero balance.',
        count: ids.length,
        affectedIds: ids,
      ));
    }

    // 3. D3: Credit cards with positive balances
    final positiveCreditCards = await db.customSelect('''
      SELECT id, name, balance FROM accounts
      WHERE type = 'credit' AND balance > 0.0
    ''').get();
    if (positiveCreditCards.isNotEmpty) {
      issues.add(DataHealthIssue(
        code: 'D3',
        title: 'Credit cards with positive balance',
        details: 'Credit cards entered as positive assets instead of negative liabilities.',
        count: positiveCreditCards.length,
        affectedIds: positiveCreditCards.map((r) => r.data['id'].toString()).toList(),
      ));
    }

    // 4. P0-1: Duplicate transactions
    final duplicates = await db.customSelect('''
      SELECT description, amount, category_id, account_id, substr(date, 1, 16) as minute_stamp, COUNT(*) as cnt
      FROM transactions
      GROUP BY description, amount, category_id, account_id, minute_stamp
      HAVING cnt > 1
    ''').get();
    if (duplicates.isNotEmpty) {
      final dupCount = duplicates.fold<int>(0, (sum, r) => sum + ((r.data['cnt'] as num).toInt() - 1));
      issues.add(DataHealthIssue(
        code: 'P0-1',
        title: 'Duplicate transaction rows',
        details: 'Transactions with identical description, amount, minute, category, and account.',
        count: dupCount,
      ));
    }

    // 5. D1: Legacy unpaired transfers (transfer_group_id is null)
    final unpairedTransfers = await db.customSelect('''
      SELECT id, description, amount, type, date FROM transactions
      WHERE (transfer_group_id IS NULL OR transfer_group_id = '')
        AND (description LIKE '%Transfer out%' OR description LIKE '%Transfer in%')
    ''').get();
    if (unpairedTransfers.isNotEmpty) {
      issues.add(DataHealthIssue(
        code: 'D1',
        title: 'Unpaired legacy transfers',
        details: 'Legacy transfer transactions missing paired transfer_group_id.',
        count: unpairedTransfers.length,
        affectedIds: unpairedTransfers.map((r) => r.data['id'].toString()).toList(),
      ));
    }

    // 6. Recurring payment counter drift (paid_payments != count of paid history)
    final counterDrift = await db.customSelect('''
      SELECT rp.id, rp.paid_payments, COUNT(rh.id) as history_count
      FROM recurring_payments rp
      LEFT JOIN recurring_history rh ON rp.id = rh.recurring_id AND rh.action = 'paid'
      GROUP BY rp.id
      HAVING rp.paid_payments != history_count
    ''').get();
    if (counterDrift.isNotEmpty) {
      issues.add(DataHealthIssue(
        code: 'COUNTER_DRIFT',
        title: 'Recurring counter drift',
        details: 'Recurring payment paid_payments counter does not match number of paid history logs.',
        count: counterDrift.length,
        affectedIds: counterDrift.map((r) => r.data['id'].toString()).toList(),
      ));
    }

    return DataHealthReport(
      timestamp: DateTime.now(),
      issues: issues,
    );
  }
}
