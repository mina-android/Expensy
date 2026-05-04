// lib/screens/backup_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});
  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  bool _backingUp  = false;
  bool _restoring  = false;
  String? _message;
  bool _messageOk  = true;

  void _setMsg(String msg, {bool ok = true}) =>
      setState(() { _message = msg; _messageOk = ok; });

  Future<void> _backup() async {
    setState(() { _backingUp = true; _message = null; });
    try {
      await context.read<AppProvider>().createBackup();
      _setMsg('Backup created — check your share sheet.');
    } catch (e) {
      _setMsg('Backup failed: $e', ok: false);
    } finally {
      setState(() => _backingUp = false);
    }
  }

  Future<void> _restore() async {
    // Confirm first
    if (!mounted) return;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Restore Backup?'),
        content: const Text(
            'This will replace ALL your current data with the backup file.\n\n'
            'This action cannot be undone. Continue?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
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
    if (ok != true) return;
    if (!mounted) return;

    setState(() { _restoring = true; _message = null; });
    try {
      final success = await context.read<AppProvider>().restoreBackup();
      if (success) {
        _setMsg('Data restored successfully!');
      } else {
        _setMsg('No file selected or restore cancelled.', ok: false);
      }
    } catch (e) {
      _setMsg('Restore failed: invalid backup file.', ok: false);
    } finally {
      setState(() => _restoring = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup & Restore',
            style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: const Color(0xFF37474F),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status banner
            if (_message != null)
              Container(
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: _messageOk
                      ? const Color(0xFFE8F5E9)
                      : const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: _messageOk
                          ? const Color(0xFFA5D6A7)
                          : const Color(0xFFEF9A9A)),
                ),
                child: Row(children: [
                  Icon(
                    _messageOk
                        ? Icons.check_circle_outline
                        : Icons.error_outline,
                    color: _messageOk
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFFC62828),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _message!,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: _messageOk
                              ? const Color(0xFF2E7D32)
                              : const Color(0xFFC62828)),
                    ),
                  ),
                ]),
              ),

            // Data overview card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Current Data',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 12),
                    _DataRow(icon: Icons.account_balance_wallet_outlined,
                        label: 'Accounts', count: app.accounts.length),
                    _DataRow(icon: Icons.receipt_long_outlined,
                        label: 'Transactions', count: app.transactions.length),
                    _DataRow(icon: Icons.repeat_rounded,
                        label: 'Recurring Payments', count: app.recurring.length),
                    _DataRow(icon: Icons.star_outline_rounded,
                        label: 'Wishlist Items', count: app.wishlist.length),
                    _DataRow(icon: Icons.handshake_outlined,
                        label: 'Lending Records', count: app.lended.length),
                    _DataRow(icon: Icons.label_outline_rounded,
                        label: 'Categories', count: app.categories.length,
                        last: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Backup card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF37474F).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.backup_outlined,
                            color: Color(0xFF37474F)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Backup Data',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w800)),
                            Text(
                              'Save a complete snapshot of all your data',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: cs.onSurface.withValues(alpha: 0.6)),
                            ),
                          ],
                        ),
                      ),
                    ]),
                    const SizedBox(height: 14),
                    Text(
                      'The backup file (JSON) includes all accounts, transactions, '
                      'recurring payments, wishlist, lending records, categories, '
                      'and settings.',
                      style: TextStyle(
                          fontSize: 13,
                          color: cs.onSurface.withValues(alpha: 0.65),
                          height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: _backingUp ? null : _backup,
                      icon: _backingUp
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                          : const Icon(Icons.file_download_outlined),
                      label: Text(
                          _backingUp ? 'Creating backup…' : 'Create Backup'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        backgroundColor: const Color(0xFF37474F),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Restore card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                    color: cs.error.withValues(alpha: 0.3), width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: cs.errorContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.restore_outlined,
                            color: cs.onErrorContainer),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Restore Data',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w800)),
                            Text(
                              'Load data from a backup file',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: cs.onSurface.withValues(alpha: 0.6)),
                            ),
                          ],
                        ),
                      ),
                    ]),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: cs.errorContainer.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(children: [
                        Icon(Icons.warning_amber_outlined,
                            size: 18, color: cs.error),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Warning: This will permanently replace all current data.',
                            style: TextStyle(
                                fontSize: 12,
                                color: cs.error,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: _restoring ? null : _restore,
                      icon: _restoring
                          ? SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: cs.error))
                          : const Icon(Icons.file_upload_outlined),
                      label: Text(
                          _restoring ? 'Restoring…' : 'Restore from File'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        foregroundColor: cs.error,
                        side: BorderSide(color: cs.error),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final bool last;
  const _DataRow(
      {required this.icon,
      required this.label,
      required this.count,
      this.last = false});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: last
          ? null
          : BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: cs.outlineVariant.withValues(alpha: 0.5)))),
      child: Row(children: [
        Icon(icon, size: 18, color: cs.primary),
        const SizedBox(width: 10),
        Expanded(
            child: Text(label,
                style: const TextStyle(fontSize: 13))),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text('$count',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: cs.primary)),
        ),
      ]),
    );
  }
}
