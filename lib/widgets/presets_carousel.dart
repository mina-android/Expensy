// lib/widgets/presets_carousel.dart
// note: Horizontal quick-log carousel displaying user-configured transaction presets with 1-tap execution.
// Follows Material 3 and AMOLED surface conventions via popupSurfaceColor(cs) and semantic constants.
// All state mutations and queries route through AppProvider to preserve UI-DB decoupling.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../utils/haptics.dart';
import '../utils/snackbar.dart';
import 'preset_sheet.dart';

// ── class PresetsCarousel ──────────────────────────────────────────────────────────
// Encapsulates UI state and rendering logic for PresetsCarousel.
class PresetsCarousel extends StatelessWidget {
  final ValueChanged<TransactionPreset>? onPresetSelected;
  final List<String>? allowedTypes;
  final String? defaultNewType;

  const PresetsCarousel({
    super.key,
    this.onPresetSelected,
    this.allowedTypes,
    this.defaultNewType,
  });

  @override
  // Builds the widget subtree using theme-adaptive colors and localization.
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    final isAmoled = isAmoledSurface(cs);
    final presets = allowedTypes == null
        ? app.presets
        : app.presets.where((p) => allowedTypes!.contains(p.type)).toList();

    // Render Column layout container.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.bolt_rounded, size: 16, color: cs.primary),
                  const SizedBox(width: 6),
                  Text(
                    l10n.presets_quickLog,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: cs.onSurface,
                    ),
                  ),
                ],
              ),
              if (presets.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    AppHaptics.tap(context, HapticStrength.light);
                    PresetSheet.show(context, initialType: defaultNewType);
                  },
                  child: Text(
                    '+ ${l10n.home_add}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: cs.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (presets.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Material(
              color: isAmoled ? const Color(0xFF141414) : cs.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  AppHaptics.tap(context, HapticStrength.light);
                  PresetSheet.show(context, initialType: defaultNewType);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: cs.primary.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.flash_on_rounded, size: 18, color: cs.primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.presets_addQuickPresets,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: cs.onSurface,
                              ),
                            ),
                            Text(
                              l10n.presets_quickPresetsDesc,
                              style: TextStyle(
                                fontSize: 11,
                                color: cs.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.add, size: 18, color: cs.primary),
                    ],
                  ),
                ),
              ),
            ),
          )
        else
          SizedBox(
            height: 58,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: presets.length,
              itemBuilder: (context, i) {
                final preset = presets[i];
                final isTransfer = preset.isTransfer;
                final color = isTransfer ? cs.primary : Color(preset.colorValue);
                final acc = app.accountById(preset.accountId);
                final toAcc = preset.toAccountId != null
                    ? app.accountById(preset.toAccountId!)
                    : null;
                final currency = preset.currency.isNotEmpty
                    ? preset.currency
                    : (acc?.currency ?? app.settings.currency);
                final subtitle = isTransfer && acc != null && toAcc != null
                    ? '${formatAmount(preset.amount, currency)} • ${acc.name} → ${toAcc.name}'
                    : formatAmount(preset.amount, currency);
                final subtitleColor = isTransfer
                    ? cs.primary
                    : (preset.type == 'expense' ? kDangerColor : kSuccessColor);

                // Render Padding layout container.
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Material(
                    color: isAmoled ? const Color(0xFF161616) : cs.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () async {
                        AppHaptics.tap(context, HapticStrength.medium);
                        if (onPresetSelected != null) {
                          onPresetSelected!(preset);
                          return;
                        }
                        try {
                          final tx = await app.logPreset(preset);
                          if (context.mounted) {
                            showAppSnackbar(
                              context,
                              l10n.presets_loggedPreset(
                                preset.title,
                                formatAmount(preset.amount, currency),
                              ),
                              onUndo: () => app.deleteTransaction(tx.id),
                            );
                          }
                        } on RatesUnavailableException catch (e) {
                          if (context.mounted) {
                            showAppSnackbar(context, e.message);
                          }
                        }
                      },
                      onLongPress: () {
                        AppHaptics.tap(context, HapticStrength.heavy);
                        PresetSheet.show(context, existing: preset);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: color.withValues(alpha: 0.35),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isTransfer)
                              Icon(Icons.swap_horiz_rounded, size: 15, color: color)
                            else
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  preset.title,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  subtitle,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: subtitleColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
