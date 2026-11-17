// lib/screens/certificates_screen.dart
// note: Overview screen listing active and matured investment certificates with total principal and upcoming interest summary.
// Follows Material 3 and AMOLED surface conventions via popupSurfaceColor(cs) and semantic constants.
// All state mutations and queries route through AppProvider to preserve UI-DB decoupling.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../widgets/fintech_components.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/certificate_sheet.dart';
import 'certificate_detail_screen.dart';

// ── class CertificatesScreen ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for CertificatesScreen.
class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({super.key});

  // Helper method `openSheet`: handles user action or computes derived UI state.
  static void openSheet(BuildContext context, {Certificate? existing}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CertificateSheet(existing: existing),
    );
  }

  @override
  // Builds the widget subtree using theme-adaptive colors and localization.
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final cur = app.settings.currency;

    final activeCerts = app.certificates.where((c) => !c.isSettled).toList();
    final settledCerts = app.certificates.where((c) => c.isSettled).toList();

    // Render Scaffold layout container.
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.certificates_title,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      floatingActionButton: FintechFab(
        tooltip: l10n.certificates_addCertificate,
        color: kCertificateColor,
        onPressed: () => openSheet(context),
      ),
      body: Column(
        children: [
          // Header summary card
          if (app.certificates.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: kCertificateColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: kCertificateColor
                                .withValues(alpha: 0.25)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.certificates_activePrincipal,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: cs.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formatAmount(app.totalCertificatesValue, cur),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: kCertificateColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: cs.primaryContainer.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: cs.primary.withValues(alpha: 0.25)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.certificates_activeCount,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: cs.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${activeCerts.length}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: cs.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          Expanded(
            child: app.certificates.isEmpty
                ? EmptyState(
                    icon: Icons.card_membership_rounded,
                    message: l10n.certificates_noCertificates,
                    subMessage: l10n.certificates_noCertificatesSub,
                  )
                : ListView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                    children: [
                      if (activeCerts.isNotEmpty) ...[
                        Text(
                          l10n.certificates_active.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            color: cs.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...activeCerts.map((c) => _CertificateCard(cert: c)),
                        const SizedBox(height: 16),
                      ],
                      if (settledCerts.isNotEmpty) ...[
                        Text(
                          l10n.certificates_matured.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            color: cs.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...settledCerts.map((c) => _CertificateCard(cert: c)),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

// ── class _CertificateCard ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for _CertificateCard.
class _CertificateCard extends StatelessWidget {
  final Certificate cert;
  const _CertificateCard({required this.cert});

  @override
  // Builds the widget subtree using theme-adaptive colors and localization.
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final app = context.watch<AppProvider>();
    final progress = cert.progress.clamp(0.0, 1.0);
    final bank = app.accounts.where((a) => a.id == cert.accountId).firstOrNull;

    // Render Card layout container.
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            ExpensyRoute(
                builder: (_) => CertificateDetailScreen(certificate: cert)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: cert.isSettled
                                ? cs.surfaceContainerHighest
                                : kCertificateColor
                                    .withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            cert.isSettled
                                ? Icons.check_circle_outline
                                : Icons.receipt_long_rounded,
                            size: 18,
                            color: cert.isSettled
                                ? cs.onSurfaceVariant
                                : kCertificateColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cert.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (bank != null)
                                Text(
                                  l10n.certificates_linkedBank(bank.name),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: cs.onSurface.withValues(alpha: 0.55),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        formatAmount(cert.amount, cert.currency),
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color:
                              kCertificateColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${cert.interestRate.toStringAsFixed(1)}% p.a.',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: kCertificateColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: cs.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    cert.isSettled
                        ? cs.onSurfaceVariant
                        : kCertificateColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.certificates_yieldSummary(
                      formatAmount(cert.periodicPayout, cert.currency),
                      switch (cert.collectionType) {
                        'daily' => l10n.freq_daily,
                        'yearly' => l10n.freq_yearly,
                        _ => l10n.recurring_monthly,
                      },
                    ),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  Text(
                    l10n.certificates_maturesOn(
                      DateFormat('dd MMM yyyy').format(cert.endDate),
                    ),
                    style: TextStyle(
                      fontSize: 11,
                      color: cs.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
