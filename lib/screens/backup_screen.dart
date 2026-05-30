// lib/screens/backup_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});
  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  bool    _backingUp = false;
  bool    _restoring = false;
  String? _msg;
  bool    _msgOk = true;

  void _setMsg(String m, {bool ok = true}) =>
      setState(() { _msg = m; _msgOk = ok; });

  Future<void> _backup() async {
    setState(() { _backingUp = true; _msg = null; });
    try {
      final savedPath = await context.read<AppProvider>().createBackup();
      if (savedPath != null) {
        _setMsg('Backup saved successfully:\n$savedPath');
      }
      // null = user cancelled file picker — show nothing
    } catch (e) {
      _setMsg('Backup failed: $e', ok: false);
    } finally {
      if (mounted) setState(() => _backingUp = false);
    }
  }

  Future<void> _restore() async {
    if (!mounted) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Restore Backup?'),
        content: const Text(
            'This will replace ALL your current data with the backup.\n'
            'This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(ctx).colorScheme.error),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Replace Data'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() { _restoring = true; _msg = null; });
    try {
      final originalVersion = await context.read<AppProvider>().restoreBackup();
      if (mounted) {
        if (originalVersion == 0) {
          // User cancelled the file picker — say nothing
        } else {
          final vLabel = originalVersion < _kBackupVersion
              ? ' (upgraded from v$originalVersion → v$_kBackupVersion)'
              : '';
          _setMsg('Data restored successfully!$vLabel');
        }
      }
    } on FormatException catch (e) {
      if (mounted) _setMsg('Restore failed: ${e.message}', ok: false);
    } catch (e) {
      if (mounted) _setMsg(
          'Restore failed: the file may be corrupted or not an Expensy backup.',
          ok: false);
    } finally {
      if (mounted) setState(() => _restoring = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;

    // Live counts for the "what's included" breakdown
    final counts = [
      _CountRow(Icons.account_balance_wallet_outlined,  'Accounts',        app.accounts.length),
      _CountRow(Icons.receipt_long_outlined,            'Transactions',    app.transactions.length),
      _CountRow(Icons.repeat_rounded,                   'Recurring',       app.recurring.length),
      _CountRow(Icons.star_outline_rounded,             'Wishlist',        app.wishlist.length),
      _CountRow(Icons.handshake_outlined,               'Lent & Borrowed', app.lended.length),
      _CountRow(Icons.inventory_2_outlined,             'Assets',          app.assets.length),
      _CountRow(Icons.label_outline_rounded,            'Categories',      app.categories.length),
      _CountRow(Icons.settings_outlined,                'Settings',        -1), // -1 = 'included'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup & Restore',
            style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          // ── What's included ────────────────────────────────────────────
          Text('What\'s included',
              style: Theme.of(context).textTheme.labelMedium
                  ?.copyWith(letterSpacing: 1,
                      color: cs.onSurface.withValues(alpha: 0.6))),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: counts.map((r) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(children: [
                    Icon(r.icon, size: 18,
                        color: cs.primary.withValues(alpha: 0.8)),
                    const SizedBox(width: 12),
                    Expanded(child: Text(r.label,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 13))),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: cs.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        r.count < 0 ? 'included' : '${r.count}',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w700,
                            color: cs.onPrimaryContainer),
                      ),
                    ),
                  ]),
                )).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // ── Create backup ──────────────────────────────────────────────
          Text('Create Backup',
              style: Theme.of(context).textTheme.labelMedium
                  ?.copyWith(letterSpacing: 1,
                      color: cs.onSurface.withValues(alpha: 0.6))),
          const SizedBox(height: 8),
          Card(child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(width: 44, height: 44,
                    decoration: BoxDecoration(
                        color: cs.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(Icons.backup_outlined, color: cs.primary)),
                const SizedBox(width: 14),
                const Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Save as JSON', style: TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 15)),
                    Text('Exports all data to a portable file',
                        style: TextStyle(fontSize: 12)),
                  ],
                )),
              ]),
              const SizedBox(height: 14),
              FilledButton.icon(
                onPressed: _backingUp ? null : _backup,
                icon: _backingUp
                    ? const SizedBox(width: 16, height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2,
                            color: Colors.white))
                    : const Icon(Icons.save_outlined),
                label: Text(_backingUp ? 'Saving...' : 'Save Backup'),
                style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22))),
              ),
            ]),
          )),
          const SizedBox(height: 12),

          // ── Restore backup ─────────────────────────────────────────────
          Text('Restore Backup',
              style: Theme.of(context).textTheme.labelMedium
                  ?.copyWith(letterSpacing: 1,
                      color: cs.onSurface.withValues(alpha: 0.6))),
          const SizedBox(height: 8),
          Card(child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(width: 44, height: 44,
                    decoration: BoxDecoration(
                        color: cs.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(Icons.restore_outlined, color: cs.error)),
                const SizedBox(width: 14),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Load from JSON', style: TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 15)),
                    Text('Picks a backup file and restores it',
                        style: TextStyle(fontSize: 12,
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
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Icon(Icons.warning_amber_rounded,
                      color: cs.error, size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('This overwrites ALL current data.',
                          style: TextStyle(fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: cs.onErrorContainer)),
                      const SizedBox(height: 2),
                      Text(
                        'Compatible with backups from any app version. '
                        'Missing fields are filled with safe defaults.',
                        style: TextStyle(fontSize: 11,
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
                    ? const SizedBox(width: 16, height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.upload_file_outlined),
                label: Text(_restoring ? 'Restoring...' : 'Restore Backup'),
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                    foregroundColor: cs.error,
                    side: BorderSide(color: cs.error),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22))),
              ),
            ]),
          )),

          // ── Status message ─────────────────────────────────────────────
          if (_msg != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _msgOk
                    ? const Color(0xFFE8F5E9)
                    : const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(12)),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Icon(_msgOk
                    ? Icons.check_circle_outline
                    : Icons.error_outline,
                    color: _msgOk
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFFC62828)),
                const SizedBox(width: 10),
                Expanded(child: Text(_msg!, style: TextStyle(
                    fontSize: 13,
                    color: _msgOk
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFFC62828)))),
              ]),
            ),
          ],

          const SizedBox(height: 24),
          // ── Format note ───────────────────────────────────────────────
          Center(child: Text(
            'Backup format v$_kBackupVersion  ·  JSON  ·  '
            'Generated on ${DateFormat('d MMM yyyy').format(DateTime.now())}',
            style: TextStyle(fontSize: 11,
                color: cs.onSurface.withValues(alpha: 0.35)),
            textAlign: TextAlign.center,
          )),
        ]),
      ),
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

/// Must match DBHelper._version so the label is always accurate.
const int _kBackupVersion = 6;

class _CountRow {
  final IconData icon;
  final String   label;
  /// Negative means "show 'included' instead of a number."
  final int      count;
  const _CountRow(this.icon, this.label, this.count);
}
