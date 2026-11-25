// note: Backup & restore center supporting encrypted (.enc) archives, selective table restore, SAF scheduled auto-backup, and third-party CSV imports.
// All state mutations and queries route through AppProvider to preserve UI-DB decoupling.
// Follows Material 3 and AMOLED surface conventions via popupSurfaceColor(cs) and semantic constants.
// lib/screens/backup_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../utils/snackbar.dart';
import '../utils/haptics.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

// ── class BackupScreen ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for BackupScreen.
class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});
  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

// ── class _BackupScreenState ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for _BackupScreenState.
class _BackupScreenState extends State<BackupScreen> {
  bool _backingUp = false;
  bool _restoring = false;
  String? _msg;
  bool _msgOk = true;
  bool _canUndoRestore = false;
  Timer? _msgTimer;

  @override
  // Disposes controllers and listeners to prevent memory leaks.
  void dispose() {
    _msgTimer?.cancel();
    super.dispose();
  }

  // Helper method `_setMsg`: handles user action or computes derived UI state.
  void _setMsg(String m, {bool ok = true, bool showUndo = false}) {
    setState(() {
      _msg = m;
      _msgOk = ok;
      _canUndoRestore = showUndo;
    });
    _msgTimer?.cancel();
    _msgTimer = Timer(Duration(seconds: showUndo ? 8 : 3), () {
      if (mounted) {
        setState(() {
          _msg = null;
          _canUndoRestore = false;
        });
      }
    });
  }

  // Helper method `_backup`: handles user action or computes derived UI state.
  Future<void> _backup() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _backingUp = true;
      _msg = null;
    });
    try {
      final savedPath = await context
          .read<AppProvider>()
          .createBackup(dialogTitle: l10n.backup_createBackup);
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

  // Helper method `_showSelectiveBackupSheet`: handles user action or computes derived UI state.
  void _showSelectiveBackupSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _SelectiveBackupSheet(),
    );
  }

  Future<void> _restore() async {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    final app = context.read<AppProvider>();

    setState(() {
      _restoring = true;
      _msg = null;
    });

    Map<String, dynamic>? data;
    try {
      data = await app.pickAndParseBackupFile(
        onPasswordRequired: () => showBackupPasswordDialog(context),
      );
    } on FormatException catch (e) {
      if (mounted) _setMsg(l10n.backup_restoreFailed(e.message), ok: false);
      return;
    } catch (e) {
      if (mounted) _setMsg(l10n.backup_restoreFailedCorrupted, ok: false);
      return;
    } finally {
      if (mounted) setState(() => _restoring = false);
    }

    if (data == null || !mounted) return;
    final backupData = data;
    if (backupData['selective'] == true) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => _SelectiveRestoreSheet(
          data: backupData,
          onRestored: () => _setMsg(
            l10n.backup_selectedRestoredSuccess,
            showUndo: app.lastPreRestoreSnapshotPath != null,
          ),
        ),
      );
      return;
    }
    _showRestoreModeSheet(context, backupData);
  }

  // Helper method `_showRestoreModeSheet`: handles user action or computes derived UI state.
  void _showRestoreModeSheet(BuildContext context, Map<String, dynamic> data) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => SheetShell(
        showHandle: true,
        title: l10n.backup_chooseRestoreMode,
        subtitle: l10n.backup_chooseRestoreModeDesc,
        children: [
          const SizedBox(height: 4),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: cs.primary.withValues(alpha: 0.4)),
            ),
            tileColor: cs.primaryContainer.withValues(alpha: 0.25),
            leading: Icon(Icons.checklist_rounded, color: cs.primary, size: 28),
            title: Text(l10n.backup_selectiveRestore,
                style: const TextStyle(fontWeight: FontWeight.w700)),
            subtitle: Text(l10n.backup_selectiveRestoreDesc),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () {
              Navigator.pop(ctx);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => _SelectiveRestoreSheet(
                  data: data,
                  onRestored: () => _setMsg(
                    l10n.backup_selectedRestoredSuccess,
                    showUndo: context.read<AppProvider>().lastPreRestoreSnapshotPath != null,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: cs.error.withValues(alpha: 0.3)),
            ),
            tileColor: cs.errorContainer.withValues(alpha: 0.2),
            leading: Icon(Icons.restore_outlined, color: cs.error, size: 28),
            title: Text(l10n.backup_fullRestore,
                style: const TextStyle(fontWeight: FontWeight.w700)),
            subtitle: Text(l10n.backup_fullRestoreDesc),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () async {
              Navigator.pop(ctx);
              final app = context.read<AppProvider>();
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (dlgCtx) => AlertDialog(
                  title: Text(l10n.backup_restoreBackup),
                  content: Text(l10n.backup_replaceDataWarning),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(dlgCtx, false),
                        child: Text(l10n.backup_cancel)),
                    FilledButton(
                      style: FilledButton.styleFrom(backgroundColor: cs.error),
                      onPressed: () => Navigator.pop(dlgCtx, true),
                      child: Text(l10n.backup_replaceData),
                    ),
                  ],
                ),
              );
              if (confirmed == true && mounted) {
                setState(() => _restoring = true);
                try {
                  final originalVersion = await app.restoreBackupData(data);
                  if (mounted) {
                    final vLabel = originalVersion < app.schemaVersion
                        ? l10n.backup_upgradedFrom(
                            originalVersion.toString(),
                            app.schemaVersion.toString())
                        : '';
                    _setMsg(
                      l10n.backup_dataRestoredSuccessfully(vLabel),
                      showUndo: app.lastPreRestoreSnapshotPath != null,
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    _setMsg(l10n.backup_restoreFailed(e.toString()), ok: false);
                  }
                } finally {
                  if (mounted) setState(() => _restoring = false);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  // Helper method `_restoreExternal`: handles user action or computes derived UI state.
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
        if (source == 'trackwallet') {
          _setMsg(l10n.backup_importedTransactions(app.lastExternalImportCount));
        } else {
          _setMsg(l10n.backup_dataRestoredSuccessfully(''));
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

  @override
  // Builds the widget subtree using theme-adaptive colors and localization.
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
      _CountRow(Icons.call_split_rounded, l10n.split_transactions_title,
          app.splits.length),
      _CountRow(Icons.repeat_rounded, l10n.backup_recurringPayments,
          app.recurring.length),
      _CountRow(Icons.bolt_rounded, l10n.presets_quickLog, app.presets.length),
      _CountRow(Icons.history_rounded, l10n.backup_recurringHistory,
          app.recurringHistoryCount),
      _CountRow(Icons.pie_chart_outline_rounded, l10n.backup_budgets,
          app.budgets.length),
      _CountRow(
          Icons.savings_outlined, l10n.backup_savingsGoals, app.savingsGoals.length),
      _CountRow(Icons.payments_outlined, l10n.backup_savingsContributions,
          app.savingsContributions.length),
      _CountRow(Icons.star_outline_rounded, l10n.backup_wishlist,
          app.wishlist.length),
      _CountRow(Icons.people_alt_outlined, l10n.backup_lentPeople,
          app.lendedPeople.length),
      _CountRow(
          Icons.handshake_outlined, l10n.backup_lentRecords, app.lended.length),
      _CountRow(
          Icons.inventory_2_outlined, l10n.backup_assets, app.assets.length),
      _CountRow(
          Icons.card_membership_rounded, l10n.certificates_title, app.certificates.length),
      _CountRow(
          Icons.account_balance_outlined, l10n.backup_loans, app.loans.length),
      _CountRow(Icons.payments_outlined, l10n.backup_loanPayments,
          app.loanPayments.length),
      _CountRow(Icons.label_outline_rounded, l10n.backup_categories,
          app.userCategories.length),
      _CountRow(Icons.account_balance_rounded, l10n.netWorth_title,
          app.netWorthSnapshots.length),
      _CountRow(
          Icons.settings_outlined, l10n.backup_settings, -1), // -1 = 'included'
    ];

    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Render Scaffold layout container.
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.backup_backupRestore,
            style: const TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ── Create backup ──────────────────────────────────────────────
          Text(l10n.backup_createBackup,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  letterSpacing: 1,
                  color: cs.onSurface.withValues(alpha: 0.6))),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
              ),
            ),
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
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: _backingUp ? null : _showSelectiveBackupSheet,
                  icon: const Icon(Icons.checklist_rounded),
                  label: Text(l10n.backup_selectiveBackupBtn),
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(44),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22))),
                ),
              ]),
            ),
          ),
          const SizedBox(height: 20),

          // ── Daily Auto Backup ──────────────────────────────────────────
          const _AutoBackupSection(),
          const SizedBox(height: 20),

          // ── Restore backup ─────────────────────────────────────────────
          Text(l10n.backup_restoreBackup_,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  letterSpacing: 1,
                  color: cs.onSurface.withValues(alpha: 0.6))),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
              ),
            ),
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
          ),
          ),
          const SizedBox(height: 20),

          // ── Import from Other Apps ─────────────────────────────────────────────
          Text(l10n.backup_importFromOtherApps,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  letterSpacing: 1,
                  color: cs.onSurface.withValues(alpha: 0.6))),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
              ),
            ),
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
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed:
                      _restoring ? null : () => _restoreExternal('trackwallet'),
                  icon: const Icon(Icons.account_balance_wallet_outlined),
                  label: Text(l10n.backup_importFromTrackWallet),
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(44),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22))),
                ),
              ]),
            ),
          ),
          const SizedBox(height: 24),

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
          Container(
            decoration: BoxDecoration(
              color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
              ),
            ),
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
                                color: cs.primary.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                r.count == -1
                                    ? l10n.backup_included
                                    : '${r.count}',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: cs.primary),
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
        ]),
      ),
      bottomNavigationBar: _msg != null
          ? SafeArea(
              child: Builder(builder: (context) {
                final isDark = Theme.of(context).brightness == Brightness.dark;
                final accent = _msgOk ? kSuccessColor : kDangerColor;
                final bg = isDark
                    ? accent.withValues(alpha: 0.15)
                    : (_msgOk
                        ? const Color(0xFFE8F5E9)
                        : const Color(0xFFFFEBEE));
                // Render Container layout container.
                return Container(
                  margin: const EdgeInsets.all(20).copyWith(top: 0),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      color: bg, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                            _msgOk
                                ? Icons.check_circle_outline
                                : Icons.error_outline,
                            color: accent),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Text(_msg!,
                                style: TextStyle(fontSize: 13, color: accent))),
                        if (_canUndoRestore &&
                            app.lastPreRestoreSnapshotPath != null) ...[
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: _restoring
                                ? null
                                : () async {
                                    setState(() => _restoring = true);
                                    try {
                                      final ok = await app.undoLastRestore();
                                      if (mounted && ok) {
                                        _setMsg(l10n.backup_dataRestoredSuccessfully(''));
                                      }
                                    } finally {
                                      if (mounted) {
                                        setState(() => _restoring = false);
                                      }
                                    }
                                  },
                            child: Text(
                              l10n.common_undo,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: accent,
                              ),
                            ),
                          ),
                        ],
                      ]),
                );
              }),
            )
          : null,
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

// ── class _CountRow ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for _CountRow.
class _CountRow {
  final IconData icon;
  final String label;

  /// Negative sentinel values render as "included" instead of a raw number.
  final int count;
  const _CountRow(this.icon, this.label, this.count);
}

// ── class _AutoBackupSection ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for _AutoBackupSection.
class _AutoBackupSection extends StatefulWidget {
  const _AutoBackupSection();

  @override
  State<_AutoBackupSection> createState() => _AutoBackupSectionState();
}

// ── class _AutoBackupSectionState ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for _AutoBackupSectionState.
class _AutoBackupSectionState extends State<_AutoBackupSection> {
  bool _runningNow = false;

  // Helper method `_toggleEncryption`: handles user action or computes derived UI state.
  Future<void> _toggleEncryption(BuildContext context, AppProvider app) async {
    final l10n = AppLocalizations.of(context)!;
    final currentEnc = app.autoBackup.encrypted;
    if (currentEnc) {
      await app.setAutoBackupEncryption(on: false);
      if (mounted) showAppSnackbar(this.context, l10n.backup_encryptionDisabled);
      return;
    }

    final passCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();
    String? errorText;

    final set = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlgState) => AlertDialog(
          title: Text(l10n.backup_encryptAutoTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.backup_encryptAutoDesc,
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passCtrl,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: l10n.backup_password,
                  errorText: errorText,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: confirmCtrl,
                obscureText: true,
                decoration: InputDecoration(labelText: l10n.backup_confirmPassword),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l10n.backup_cancel),
            ),
            FilledButton(
              onPressed: () {
                if (passCtrl.text.isEmpty) {
                  setDlgState(() => errorText = l10n.backup_passwordEmpty);
                  return;
                }
                if (passCtrl.text != confirmCtrl.text) {
                  setDlgState(() => errorText = l10n.backup_passwordsMismatch);
                  return;
                }
                Navigator.pop(ctx, true);
              },
              child: Text(l10n.backup_setPassword),
            ),
          ],
        ),
      ),
    );

    if (set == true && mounted) {
      try {
        await app.setAutoBackupEncryption(on: true, password: passCtrl.text);
        if (mounted) showAppSnackbar(this.context, l10n.backup_encryptionEnabled);
      } catch (e) {
        if (mounted) {
          showAppSnackbar(
              this.context, l10n.backup_encryptionFailed(e.toString()));
        }
      }
    }
  }

  // Helper method `_runNow`: handles user action or computes derived UI state.
  Future<void> _runNow(BuildContext context, AppProvider app) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _runningNow = true);
    AppHaptics.tap(context, HapticStrength.medium);
    try {
      final res = await app.runAutoBackupNow();
      if (!mounted) return;
      if (res.success) {
        showAppSnackbar(this.context, l10n.backup_autoCreated(res.fileName ?? ''));
      } else {
        showAppSnackbar(this.context, l10n.backup_autoFailed(res.error ?? ''));
      }
    } catch (e) {
      if (mounted) showAppSnackbar(this.context, l10n.backup_failedError(e.toString()));
    } finally {
      if (mounted) setState(() => _runningNow = false);
    }
  }

  @override
  // Builds the widget subtree using theme-adaptive colors and localization.
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final auto = app.autoBackup;
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    // Render Column layout container.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.backup_automaticBackup,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                letterSpacing: 1,
                color: cs.onSurface.withValues(alpha: 0.6),
              ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.05),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: cs.tertiary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.schedule_rounded, color: cs.tertiary),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.backup_dailyAutoBackup,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            l10n.backup_nightlySchedule,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Switch.adaptive(
                      value: auto.enabled,
                      onChanged: (val) async {
                        AppHaptics.tap(context, HapticStrength.light);
                        await app.setAutoBackupEnabled(val);
                      },
                    ),
                  ],
                ),
                if (auto.enabled) ...[
                  const Divider(height: 24),
                  // Destination Folder
                  Row(
                    children: [
                      const Icon(Icons.folder_open_rounded, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          auto.folderName.isNotEmpty
                              ? auto.folderName
                              : l10n.backup_noFolderSelected,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TextButton(
                        onPressed: () => app.chooseAutoBackupFolder(),
                        child: Text(l10n.backup_changeFolder),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Retention
                  Row(
                    children: [
                      Text(
                        l10n.backup_keepCopies,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 12),
                      ...[3, 7, 14, 30].map((count) {
                        final isSel = auto.retention == count;
                        // Render Padding layout container.
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              AppHaptics.tap(context, HapticStrength.light);
                              app.setAutoBackupRetention(count);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: isSel ? cs.primary : cs.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '$count',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: isSel ? cs.onPrimary : cs.onSurface,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Encryption Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            auto.encrypted ? Icons.lock_rounded : Icons.lock_open_rounded,
                            size: 18,
                            color: auto.encrypted ? cs.primary : cs.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.backup_encryptAes,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Switch.adaptive(
                        value: auto.encrypted,
                        onChanged: (_) => _toggleEncryption(context, app),
                      ),
                    ],
                  ),
                  // Status & Error
                  if (auto.lastError.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: cs.errorContainer.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline_rounded, size: 16, color: cs.error),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              l10n.backup_failedError(auto.lastError),
                              style: TextStyle(fontSize: 11, color: cs.onErrorContainer),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else if (auto.lastSuccessMs > 0) ...[
                    const SizedBox(height: 8),
                    Text(
                      l10n.backup_lastSuccess(
                        DateFormat('yyyy-MM-dd HH:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(auto.lastSuccessMs),
                        ),
                        (auto.lastSize / 1024).toStringAsFixed(1),
                      ),
                      style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                    ),
                  ],
                  const SizedBox(height: 14),
                  FilledButton.tonalIcon(
                    onPressed: _runningNow ? null : () => _runNow(context, app),
                    icon: _runningNow
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.play_arrow_rounded, size: 18),
                    label: Text(
                        _runningNow ? l10n.backup_backingUp : l10n.backup_backUpNow),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.backup_androidIdleNote,
                    style: TextStyle(
                      fontSize: 11,
                      color: cs.onSurface.withValues(alpha: 0.5),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── class _SelectiveBackupSheet ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for _SelectiveBackupSheet.
class _SelectiveBackupSheet extends StatefulWidget {
  const _SelectiveBackupSheet();

  @override
  State<_SelectiveBackupSheet> createState() => _SelectiveBackupSheetState();
}

// ── class _SelectiveBackupSheetState ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for _SelectiveBackupSheetState.
class _SelectiveBackupSheetState extends State<_SelectiveBackupSheet> {
  final Set<String> _selected = {
    'accounts',
    'transactions',
    'categories',
    'recurring',
    'loans',
    'lent_money',
    'certificates',
    'budgets',
    'assets',
    'wishlist_goals',
    'net_worth',
    'settings',
  };
  bool _exporting = false;

  @override
  // Builds the widget subtree using theme-adaptive colors and localization.
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;

    final entities = [
      ('accounts', l10n.backup_accounts, Icons.account_balance_wallet_outlined, app.accounts.length),
      ('transactions', l10n.backup_entityTxSplitsPresets, Icons.receipt_long_outlined, app.transactions.length + app.presets.length),
      ('categories', l10n.backup_categories, Icons.label_outline_rounded, app.userCategories.length),
      ('recurring', l10n.backup_entityRecurringHistory, Icons.repeat_rounded, app.recurring.length),
      ('loans', l10n.backup_entityLoansPayments, Icons.account_balance_outlined, app.loans.length),
      ('lent_money', l10n.backup_entityLentContacts, Icons.handshake_outlined, app.lended.length),
      ('certificates', l10n.certificates_title, Icons.card_membership_rounded, app.certificates.length),
      ('budgets', l10n.backup_budgets, Icons.pie_chart_outline_rounded, app.budgets.length),
      ('assets', l10n.backup_entityAssetsValuables, Icons.inventory_2_outlined, app.assets.length),
      ('wishlist_goals', l10n.backup_entityWishlistGoals, Icons.star_outline_rounded, app.wishlist.length + app.savingsGoals.length),
      ('net_worth', l10n.netWorth_title, Icons.account_balance_rounded, app.netWorthSnapshots.length),
      ('settings', l10n.backup_settings, Icons.settings_outlined, 1),
    ];

    return SheetShell(
      showHandle: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                l10n.backup_selectiveBackup,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (_selected.length == entities.length) {
                    _selected.clear();
                  } else {
                    _selected.addAll(entities.map((e) => e.$1));
                  }
                });
              },
              child: Text(_selected.length == entities.length
                  ? l10n.backup_deselectAll
                  : l10n.backup_selectAll),
            ),
          ],
        ),
        Text(
          l10n.backup_selectiveBackupDesc,
          style: TextStyle(fontSize: 13, color: cs.onSurface.withValues(alpha: 0.6)),
        ),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.5),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: entities.length,
            separatorBuilder: (_, __) => const SizedBox(height: 6),
            itemBuilder: (context, i) {
              final item = entities[i];
              final isChecked = _selected.contains(item.$1);
              return InkWell(
                onTap: () {
                  setState(() {
                    if (isChecked) {
                      _selected.remove(item.$1);
                    } else {
                      _selected.add(item.$1);
                    }
                  });
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isChecked ? cs.primaryContainer.withValues(alpha: 0.3) : cs.surfaceContainerHigh.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isChecked ? cs.primary.withValues(alpha: 0.4) : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(item.$3, size: 22, color: isChecked ? cs.primary : cs.onSurface.withValues(alpha: 0.5)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item.$2,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: cs.onSurface.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item.$1 == 'settings' ? l10n.backup_included : '${item.$4}',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: cs.onSurface.withValues(alpha: 0.7)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Checkbox(
                        value: isChecked,
                        onChanged: (v) {
                          setState(() {
                            if (v == true) {
                              _selected.add(item.$1);
                            } else {
                              _selected.remove(item.$1);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: (_selected.isEmpty || _exporting)
              ? null
              : () async {
                  setState(() => _exporting = true);
                  try {
                    final path = await app.createSelectiveBackup(_selected,
                        dialogTitle: l10n.backup_selectiveBackup);
                    if (!context.mounted) return;
                    Navigator.pop(context);
                    if (path != null) {
                      showAppSnackbar(context, l10n.backup_selectiveSaved);
                    }
                  } catch (e) {
                    if (!context.mounted) return;
                    showAppSnackbar(context, l10n.backup_exportFailed(e.toString()));
                  } finally {
                    if (mounted) setState(() => _exporting = false);
                  }
                },
          icon: _exporting
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Icon(Icons.file_upload_outlined),
          label: Text(l10n.backup_exportSelected(_selected.length)),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ],
    );
  }
}

// ── class _SelectiveRestoreSheet ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for _SelectiveRestoreSheet.
class _SelectiveRestoreSheet extends StatefulWidget {
  final Map<String, dynamic> data;
  final VoidCallback onRestored;
  const _SelectiveRestoreSheet({required this.data, required this.onRestored});

  @override
  State<_SelectiveRestoreSheet> createState() => _SelectiveRestoreSheetState();
}

// ── class _SelectiveRestoreSheetState ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for _SelectiveRestoreSheetState.
class _SelectiveRestoreSheetState extends State<_SelectiveRestoreSheet> {
  final Set<String> _selected = {};
  bool _restoring = false;

  @override
  // Initializes controllers and local state from widget parameters.
  void initState() {
    super.initState();
    for (final key in AppProvider.entityGroupTables.keys) {
      if (_countForGroup(key) > 0) {
        _selected.add(key);
      }
    }
  }

  // Dependency prerequisites so selective restores do not create orphan references (B7).
  static const Map<String, List<String>> _groupDependencies = {
    'transactions': ['accounts', 'categories'],
    'budgets': ['categories'],
    'recurring': ['accounts', 'categories'],
  };

  // Helper method `_toggleGroupSelection`: handles user action or computes derived UI state.
  void _toggleGroupSelection(String groupKey, bool select) {
    setState(() {
      if (select) {
        _selected.add(groupKey);
        final deps = _groupDependencies[groupKey] ?? const [];
        for (final dep in deps) {
          if (_countForGroup(dep) > 0) {
            _selected.add(dep);
          }
        }
      } else {
        _selected.remove(groupKey);
        // Deselect groups that depend on this prerequisite
        for (final entry in _groupDependencies.entries) {
          if (entry.value.contains(groupKey)) {
            _selected.remove(entry.key);
          }
        }
      }
    });
  }

  // Helper method `_countForGroup`: handles user action or computes derived UI state.
  int _countForGroup(String group) {
    if (group == 'settings') {
      return widget.data['settings'] is Map ? 1 : 0;
    }
    int count = 0;
    final tables = AppProvider.entityGroupTables[group] ?? [];
    for (final t in tables) {
      final list = widget.data[t];
      if (list is List) count += list.length;
    }
    return count;
  }

  @override
  // Builds the widget subtree using theme-adaptive colors and localization.
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    final availableEntities = [
      ('accounts', l10n.backup_accounts, Icons.account_balance_wallet_outlined),
      ('transactions', l10n.backup_entityTxSplitsPresets, Icons.receipt_long_outlined),
      ('categories', l10n.backup_categories, Icons.label_outline_rounded),
      ('recurring', l10n.backup_entityRecurringHistory, Icons.repeat_rounded),
      ('loans', l10n.backup_entityLoansPayments, Icons.account_balance_outlined),
      ('lent_money', l10n.backup_entityLentContacts, Icons.handshake_outlined),
      ('certificates', l10n.certificates_title, Icons.card_membership_rounded),
      ('budgets', l10n.backup_budgets, Icons.pie_chart_outline_rounded),
      ('assets', l10n.backup_entityAssetsValuables, Icons.inventory_2_outlined),
      ('wishlist_goals', l10n.backup_entityWishlistGoals, Icons.star_outline_rounded),
      ('net_worth', l10n.netWorth_title, Icons.account_balance_rounded),
      ('settings', l10n.backup_settings, Icons.settings_outlined),
    ].where((e) => _countForGroup(e.$1) > 0).toList();

    return SheetShell(
      showHandle: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                l10n.backup_selectiveRestore,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (_selected.length == availableEntities.length) {
                    _selected.clear();
                  } else {
                    _selected.addAll(availableEntities.map((e) => e.$1));
                  }
                });
              },
              child: Text(_selected.length == availableEntities.length
                  ? l10n.backup_deselectAll
                  : l10n.backup_selectAll),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cs.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.primary.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(Icons.shield_outlined, size: 20, color: cs.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.backup_selectiveRestoreNote,
                  style: TextStyle(fontSize: 12, color: cs.onSurface),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.45),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: availableEntities.length,
            separatorBuilder: (_, __) => const SizedBox(height: 6),
            itemBuilder: (context, i) {
              final item = availableEntities[i];
              final count = _countForGroup(item.$1);
              final isChecked = _selected.contains(item.$1);
              return InkWell(
                onTap: () => _toggleGroupSelection(item.$1, !isChecked),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isChecked ? cs.primaryContainer.withValues(alpha: 0.3) : cs.surfaceContainerHigh.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isChecked ? cs.primary.withValues(alpha: 0.4) : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(item.$3, size: 22, color: isChecked ? cs.primary : cs.onSurface.withValues(alpha: 0.5)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item.$2,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: cs.onSurface.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item.$1 == 'settings'
                              ? l10n.backup_included
                              : l10n.backup_countInBackup(count),
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: cs.onSurface.withValues(alpha: 0.7)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Checkbox(
                        value: isChecked,
                        onChanged: (v) =>
                            _toggleGroupSelection(item.$1, v == true),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: (_selected.isEmpty || _restoring)
              ? null
              : () async {
                  setState(() => _restoring = true);
                  final app = context.read<AppProvider>();
                  try {
                    await app.restoreSelective(widget.data, _selected);
                    if (!context.mounted) return;
                    Navigator.pop(context);
                    widget.onRestored();
                  } catch (e) {
                    if (!context.mounted) return;
                    showAppSnackbar(
                        context, l10n.backup_restoreFailed(e.toString()));
                  } finally {
                    if (mounted) setState(() => _restoring = false);
                  }
                },
          icon: _restoring
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Icon(Icons.restore_page_outlined),
          label: Text(l10n.backup_restoreSelected(_selected.length)),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ],
    );
  }
}
