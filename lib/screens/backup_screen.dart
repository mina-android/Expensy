// lib/screens/backup_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../providers/app_provider.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});
  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  bool _backingUp = false;
  bool _restoring = false;
  String? _msg;
  bool _msgOk = true;
  Timer? _msgTimer;

  @override
  void dispose() {
    _msgTimer?.cancel();
    super.dispose();
  }

  void _setMsg(String m, {bool ok = true}) {
    setState(() {
      _msg = m;
      _msgOk = ok;
    });
    _msgTimer?.cancel();
    _msgTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _msg = null);
      }
    });
  }

  Future<void> _backup() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _backingUp = true;
      _msg = null;
    });
    try {
      final savedPath = await context.read<AppProvider>().createBackup();
      if (savedPath != null) {
        _setMsg(l10n.backup_backupSavedSuccessfully(savedPath));
      }
      // null = user cancelled file picker — show nothing
    } catch (e) {
      _setMsg(l10n.backup_backupFailed(e.toString()), ok: false);
    } finally {
      if (mounted) setState(() => _backingUp = false);
    }
  }

  Future<void> _restore() async {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.backup_restoreBackup),
        content: Text(l10n.backup_replaceDataWarning),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l10n.backup_cancel)),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(ctx).colorScheme.error),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.backup_replaceData),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() {
      _restoring = true;
      _msg = null;
    });
    try {
      final originalVersion = await context.read<AppProvider>().restoreBackup();
      if (mounted) {
        if (originalVersion == 0) {
          // User cancelled the file picker — say nothing
        } else {
          final vLabel = originalVersion < DBHelper.schemaVersion
              ? l10n.backup_upgradedFrom(
                  originalVersion.toString(), DBHelper.schemaVersion.toString())
              : '';
          _setMsg(l10n.backup_dataRestoredSuccessfully(vLabel));
        }
      }
    } on FormatException catch (e) {
      if (mounted) _setMsg(l10n.backup_restoreFailed(e.message), ok: false);
    } catch (e) {
      if (mounted) _setMsg(l10n.backup_restoreFailedCorrupted, ok: false);
    } finally {
      if (mounted) setState(() => _restoring = false);
    }
  }

  Future<void> _restoreExternal(String source) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _restoring = true;
      _msg = null;
    });
    try {
      final app = context.read<AppProvider>();
      final success = await app.restoreExternalBackup(source);
      if (mounted && success) {
        _setMsg(l10n.backup_dataRestoredSuccessfully(''));
      }
    } on FormatException catch (e) {
      if (mounted) _setMsg(l10n.backup_restoreFailed(e.message), ok: false);
    } catch (e) {
      if (mounted) _setMsg(l10n.backup_restoreFailedCorrupted, ok: false);
    } finally {
      if (mounted) setState(() => _restoring = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;

    // Live counts for the "what's included" breakdown. This list is kept in
    // sync with everything DBHelper.exportAll() actually writes to the
    // backup JSON — previously it only covered 8 of the (now) 10 backed-up
    // tables and never mentioned Budgets, Recurring History, or the
    // per-person lending structure, even though all of that data was always
    // correctly included in the file.
    final counts = [
      _CountRow(Icons.account_balance_wallet_outlined, l10n.backup_accounts,
          app.accounts.length),
      _CountRow(Icons.receipt_long_outlined, l10n.backup_transactions,
          app.transactions.length),
      _CountRow(Icons.repeat_rounded, l10n.backup_recurringPayments,
          app.recurring.length),
      _CountRow(Icons.history_rounded, l10n.backup_recurringHistory,
          app.recurringHistoryCount),
      _CountRow(Icons.pie_chart_outline_rounded, l10n.backup_budgets,
          app.budgets.length),
      _CountRow(
          Icons.savings_outlined, 'Savings Goals', app.savingsGoals.length),
      _CountRow(Icons.payments_outlined, 'Savings Contributions',
          app.savingsContributions.length),
      _CountRow(Icons.star_outline_rounded, l10n.backup_wishlist,
          app.wishlist.length),
      _CountRow(Icons.people_alt_outlined, l10n.backup_lentPeople,
          app.lendedPeople.length),
      _CountRow(
          Icons.handshake_outlined, l10n.backup_lentRecords, app.lended.length),
      _CountRow(
          Icons.inventory_2_outlined, l10n.backup_assets, app.assets.length),
      _CountRow(Icons.label_outline_rounded, l10n.backup_categories,
          app.categories.length),
      _CountRow(
          Icons.settings_outlined, l10n.backup_settings, -1), // -1 = 'included'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.backup_backupRestore,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ── What's included ────────────────────────────────────────────
          Row(children: [
            Expanded(
                child: Text(l10n.backup_whatsIncluded,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        letterSpacing: 1,
                        color: cs.onSurface.withValues(alpha: 0.6)))),
            Text(l10n.backup_everythingAlways,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: cs.primary)),
          ]),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: counts
                    .map((r) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(children: [
                            Icon(r.icon,
                                size: 18,
                                color: cs.primary.withValues(alpha: 0.8)),
                            const SizedBox(width: 12),
                            Expanded(
                                child: Text(r.label,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13))),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: cs.primaryContainer,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                r.count == -1
                                    ? l10n.backup_included
                                    : '${r.count}',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: cs.onPrimaryContainer),
                              ),
                            ),
                          ]),
                        ))
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              l10n.backup_backupDescription,
              style: TextStyle(
                  fontSize: 11.5, color: cs.onSurface.withValues(alpha: 0.55)),
            ),
          ),
          const SizedBox(height: 20),

          // ── Create backup ──────────────────────────────────────────────
          Text(l10n.backup_createBackup,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  letterSpacing: 1,
                  color: cs.onSurface.withValues(alpha: 0.6))),
          const SizedBox(height: 8),
          Card(
              child: Padding(
            padding: const EdgeInsets.all(18),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                        color: cs.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(Icons.backup_outlined, color: cs.primary)),
                const SizedBox(width: 14),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.backup_saveAsJson,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 15)),
                    Text(l10n.backup_exportsAllAppDataToA,
                        style: const TextStyle(fontSize: 12)),
                  ],
                )),
              ]),
              const SizedBox(height: 14),
              FilledButton.icon(
                onPressed: _backingUp ? null : _backup,
                icon: _backingUp
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.save_outlined),
                label: Text(
                    _backingUp ? l10n.backup_saving : l10n.backup_saveBackup),
                style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22))),
              ),
            ]),
          )),

          // ── Restore backup ─────────────────────────────────────────────
          Text(l10n.backup_restoreBackup_,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  letterSpacing: 1,
                  color: cs.onSurface.withValues(alpha: 0.6))),
          const SizedBox(height: 8),
          Card(
              child: Padding(
            padding: const EdgeInsets.all(18),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                        color: cs.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(Icons.restore_outlined, color: cs.error)),
                const SizedBox(width: 14),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.backup_loadFromJson,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 15)),
                    Text(l10n.backup_picksABackupFileAndR,
                        style: TextStyle(
                            fontSize: 12,
                            color: cs.onSurface.withValues(alpha: 0.6))),
                  ],
                )),
              ]),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: cs.errorContainer,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.warning_amber_rounded,
                          color: cs.error, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.backup_thisOverwritesAllCur,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: cs.onErrorContainer)),
                          const SizedBox(height: 2),
                          Text(
                            l10n.backup_restoreWarningText,
                            style: TextStyle(
                                fontSize: 11,
                                color: cs.onErrorContainer
                                    .withValues(alpha: 0.75)),
                          ),
                        ],
                      )),
                    ]),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _restoring ? null : _restore,
                icon: _restoring
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.upload_file_outlined),
                label: Text(_restoring
                    ? l10n.backup_restoring
                    : l10n.backup_restoreBackupBtn),
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                    foregroundColor: cs.error,
                    side: BorderSide(color: cs.error),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22))),
              ),
            ]),
          )),
          const SizedBox(height: 12),

          // ── Import from Other Apps ─────────────────────────────────────────────
          Text(l10n.backup_importFromOtherApps,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  letterSpacing: 1,
                  color: cs.onSurface.withValues(alpha: 0.6))),
          const SizedBox(height: 8),
          Card(
              child: Padding(
            padding: const EdgeInsets.all(18),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                        color: cs.secondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(Icons.download_outlined, color: cs.secondary)),
                const SizedBox(width: 14),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.backup_importFromOtherApps,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 15)),
                    Text(l10n.backup_importDescription,
                        style: TextStyle(
                            fontSize: 12,
                            color: cs.onSurface.withValues(alpha: 0.6))),
                  ],
                )),
              ]),
              const SizedBox(height: 14),
              OutlinedButton.icon(
                onPressed:
                    _restoring ? null : () => _restoreExternal('greenstash'),
                icon: const Icon(Icons.savings),
                label: Text(l10n.backup_importFromGreenStash),
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22))),
              ),
            ]),
          )),
        ]),
      ),
      bottomNavigationBar: _msg != null
          ? SafeArea(
              child: Container(
                margin: const EdgeInsets.all(20).copyWith(top: 0),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: _msgOk
                        ? const Color(0xFFE8F5E9)
                        : const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                          _msgOk
                              ? Icons.check_circle_outline
                              : Icons.error_outline,
                          color: _msgOk
                              ? const Color(0xFF2E7D32)
                              : const Color(0xFFC62828)),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Text(_msg!,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: _msgOk
                                      ? const Color(0xFF2E7D32)
                                      : const Color(0xFFC62828)))),
                    ]),
              ),
            )
          : null,
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

class _CountRow {
  final IconData icon;
  final String label;

  /// Negative sentinel values render as "included" instead of a raw number.
  final int count;
  const _CountRow(this.icon, this.label, this.count);
}
