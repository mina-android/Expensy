import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../l10n/app_localizations.dart';
import '../utils/snackbar.dart';
import '../widgets/certificate_sheet.dart';
import '../widgets/fintech_components.dart';

class CertificateDetailScreen extends StatefulWidget {
  final Certificate certificate;
  const CertificateDetailScreen({super.key, required this.certificate});

  @override
  State<CertificateDetailScreen> createState() =>
      _CertificateDetailScreenState();
}

class _CertificateDetailScreenState extends State<CertificateDetailScreen> {
  late Certificate _cert;

  @override
  void initState() {
    super.initState();
    _cert = widget.certificate;
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Refresh live instance
    _cert = app.certificates.firstWhere(
      (c) => c.id == _cert.id,
      orElse: () => _cert,
    );

    final bank =
        app.accounts.where((a) => a.id == _cert.accountId).firstOrNull;
    final cur = _cert.currency;
    final df = DateFormat('MMM dd, yyyy');
    final progress = _cert.progress.clamp(0.0, 1.0);
    const tealAccent = Color(0xFF00897B);

    return Scaffold(
      appBar: AppBar(
        title: Text(_cert.name,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => CertificateSheet(existing: _cert),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final ok = await FintechDialog.show(
                context,
                icon: Icon(Icons.delete_outline_rounded, color: cs.error, size: 28),
                title: l10n.certificates_deleteCertificate,
                content: l10n.certificates_confirmDeleteCertificate,
                confirmText: l10n.shared_widgets_delete_,
                cancelText: l10n.shared_widgets_cancel,
                isDestructive: true,
              );

              if (ok == true && context.mounted) {
                Navigator.pop(context); // close details screen
                await app.deleteCertificate(_cert.id);
                if (context.mounted) {
                  showAppSnackbar(context, l10n.certificates_deleted);
                }
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // ── Header Summary Card (Matches LoanDetailScreen) ──────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Container(
              decoration: BoxDecoration(
                color:
                    cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.05),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.certificates_amount.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.1,
                            color: cs.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2.5),
                          decoration: BoxDecoration(
                            color: _cert.isSettled
                                ? cs.outlineVariant.withValues(alpha: 0.25)
                                : tealAccent.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            (_cert.isSettled ? 'SETTLED' : 'ACTIVE')
                                .toUpperCase(),
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                              color: _cert.isSettled
                                  ? cs.onSurface.withValues(alpha: 0.6)
                                  : tealAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatAmount(_cert.amount, cur),
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                        color: _cert.isSettled ? cs.onSurface : tealAccent,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${l10n.certificates_collectedSoFar}: ${formatAmount(_cert.totalCollectedAmount, cur)}',
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '${(progress * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    LinearProgressCard(
                      value: progress,
                      color: _cert.isSettled
                          ? cs.outlineVariant
                          : tealAccent,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Metadata Stats Grid (Matches LoanDetailScreen) ──────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                color:
                    cs.surfaceContainer.withValues(alpha: isDark ? 0.35 : 0.55),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.05),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _CertStat(
                            'Annual Rate',
                            '${_cert.interestRate.toStringAsFixed(1)}%',
                          ),
                        ),
                        Expanded(
                          child: _CertStat(
                            'Periodic Yield',
                            formatAmount(_cert.periodicPayout, cur),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 16, thickness: 0.5),
                    Row(
                      children: [
                        Expanded(
                          child: _CertStat(
                            l10n.certificates_collectionType,
                            '${_cert.collectionType[0].toUpperCase()}${_cert.collectionType.substring(1)} (Day ${_cert.collectionDay})',
                          ),
                        ),
                        Expanded(
                          child: _CertStat(
                            l10n.certificates_expectedTotal,
                            formatAmount(_cert.totalExpectedReturn, cur),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 16, thickness: 0.5),
                    Row(
                      children: [
                        Expanded(
                          child: _CertStat(
                            l10n.certificates_startDate,
                            df.format(_cert.startDate),
                          ),
                        ),
                        Expanded(
                          child: _CertStat(
                            l10n.certificates_endDate,
                            df.format(_cert.endDate),
                          ),
                        ),
                      ],
                    ),
                    if (bank != null) ...[
                      const Divider(height: 16, thickness: 0.5),
                      Row(
                        children: [
                          Expanded(
                            child: _CertStat(
                              l10n.certificates_linkedBankAccount,
                              bank.name,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (_cert.notes.trim().isNotEmpty) ...[
                      const Divider(height: 16, thickness: 0.5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.lended_person_notesOptional,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        cs.onSurface.withValues(alpha: 0.5),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _cert.notes,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // ── Actions Section ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: _cert.isSettled
                ? Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerHighest.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: cs.outlineVariant.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline_rounded,
                            color: cs.primary, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Certificate Matured & Settled',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: cs.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  )
                : FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: tealAccent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    icon: const Icon(Icons.assignment_turned_in_rounded,
                        size: 20),
                    label: Text(
                      l10n.certificates_redeem,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                    onPressed: () async {
                      final confirm = await FintechDialog.show(
                        context,
                        icon: Icon(Icons.card_membership_rounded, color: tealAccent, size: 28),
                        title: l10n.certificates_redeem,
                        content: l10n.certificates_redeemConfirm(
                          _cert.name,
                          formatAmount(_cert.amount, cur),
                        ),
                        confirmText: l10n.certificates_redeem,
                        cancelText: l10n.shared_widgets_cancel,
                      );

                      if (confirm == true && context.mounted) {
                        await app.redeemCertificate(_cert.id,
                            returnPrincipal: true);
                        if (context.mounted) {
                          showAppSnackbar(
                              context, l10n.certificates_redeemedSuccess);
                        }
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _CertStat extends StatelessWidget {
  final String label;
  final String value;
  const _CertStat(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: cs.onSurface.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
