// lib/services/backup_validator.dart
// note: Safety validator that inspects backup payloads, generates preview summaries, and detects orphans.

class RestorePreview {
  final bool isValid;
  final int schemaVersion;
  final bool isSelective;
  final Map<String, int> tableCounts;
  final List<String> warnings;
  final int orphanCount;
  final String? exportedAt;
  final String? errorMessage;

  const RestorePreview({
    required this.isValid,
    required this.schemaVersion,
    required this.isSelective,
    required this.tableCounts,
    required this.warnings,
    required this.orphanCount,
    this.exportedAt,
    this.errorMessage,
  });
}

class BackupValidator {
  static const int currentSchemaVersion = 28;

  static const Set<String> knownTables = {
    'accounts',
    'categories',
    'transactions',
    'recurring_payments',
    'wishlist',
    'lended_people',
    'lended_money',
    'assets',
    'budgets',
    'recurring_history',
    'savings_goals',
    'savings_contributions',
    'loans',
    'loan_payments',
    'transaction_presets',
    'transaction_splits',
    'certificates',
  };

  /// Inspects a raw decoded backup map and returns a RestorePreview report.
  static RestorePreview validate(Map<String, dynamic> data) {
    final version = (data['version'] as num?)?.toInt() ?? 1;
    if (version > currentSchemaVersion) {
      return RestorePreview(
        isValid: false,
        schemaVersion: version,
        isSelective: false,
        tableCounts: {},
        warnings: [],
        orphanCount: 0,
        errorMessage: 'Backup version $version is newer than current app version ($currentSchemaVersion).',
      );
    }

    final isSelective = data['selective'] == true;
    final exportedAt = data['exported_at'] as String?;
    final tableCounts = <String, int>{};
    final warnings = <String>[];
    int orphanCount = 0;

    for (final table in knownTables) {
      if (data.containsKey(table) && data[table] is List) {
        final list = data[table] as List;
        tableCounts[table] = list.length;
      }
    }

    // Check orphan recurring history
    if (data.containsKey('recurring_history') && data.containsKey('recurring_payments')) {
      final recIds = (data['recurring_payments'] as List?)
              ?.whereType<Map<String, dynamic>>()
              .map((r) => r['id'] as String?)
              .whereType<String>()
              .toSet() ??
          <String>{};
      final history = (data['recurring_history'] as List?)?.whereType<Map<String, dynamic>>() ?? [];
      for (final h in history) {
        final recId = h['recurring_id'] as String?;
        if (recId != null && !recIds.contains(recId)) {
          orphanCount++;
        }
      }
      if (orphanCount > 0) {
        warnings.add('Found $orphanCount recurring history records without a parent recurring payment.');
      }
    }

    // Check account references in transactions
    if (data.containsKey('transactions') && data.containsKey('accounts')) {
      final accIds = (data['accounts'] as List?)
              ?.whereType<Map<String, dynamic>>()
              .map((a) => a['id'] as String?)
              .whereType<String>()
              .toSet() ??
          <String>{};
      final txs = (data['transactions'] as List?)?.whereType<Map<String, dynamic>>() ?? [];
      int missingAccTxs = 0;
      for (final t in txs) {
        final accId = t['account_id'] as String?;
        if (accId != null && !accIds.contains(accId)) {
          missingAccTxs++;
        }
      }
      if (missingAccTxs > 0) {
        warnings.add('$missingAccTxs transactions reference accounts not in this backup.');
      }
    }

    return RestorePreview(
      isValid: true,
      schemaVersion: version,
      isSelective: isSelective,
      tableCounts: tableCounts,
      warnings: warnings,
      orphanCount: orphanCount,
      exportedAt: exportedAt,
    );
  }
}
