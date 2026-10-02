// lib/screens/assets_screen.dart
import 'package:flutter/material.dart';
import '../utils/snackbar.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/fintech_components.dart';
import '../widgets/app_numeric_keypad.dart';
import '../utils/haptics.dart';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final total = app.totalAssetsValue;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.assets_assets, style: const TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: Column(children: [
        // ── Summary card ────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
              ),
            ),
            child: Row(children: [
              Expanded(child: _SumCol(
                label: l10n.assets_totalAssets,
                value: formatAmount(total, app.settings.currency),
                color: const Color(0xFF1565C0),
              )),
              Container(width: 1, height: 28, color: cs.outlineVariant.withValues(alpha: 0.2)),
              Expanded(child: _SumCol(
                label: l10n.assets_items,
                value: '${app.assets.length}',
                color: cs.onSurface,
              )),
            ]),
          ),
        ),

        // ── Asset list ──────────────────────────────────────────────────
        Expanded(
          child: app.assets.isEmpty
              ? EmptyState(
                  icon: Icons.inventory_2_outlined,
                  message: l10n.assets_noAssetsYet,
                  subMessage: l10n.assets_noAssetsYetSub,
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(14, 8, 14, 110),
                  itemCount: app.assets.length,
                  itemBuilder: (_, i) => _AssetCard(
                    asset: app.assets[i],
                    mainCurrency: app.settings.currency,
                    convertedValue: app.assets[i].currency != app.settings.currency
                        ? app.convertToMain(app.assets[i].value, app.assets[i].currency)
                        : null,
                  ),
                ),
        ),
      ]),
      floatingActionButton: FintechFab(
        tooltip: l10n.assets_addAsset,
        onPressed: () => _openSheet(context),
      ),
    );
  }

  static void _openSheet(BuildContext ctx, {AssetItem? existing}) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _AssetSheet(existing: existing),
    );
  }
}

// ── Summary column ───────────────────────────────────────────────────────────
class _SumCol extends StatelessWidget {
  final String label, value;
  final Color color;
  const _SumCol({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) => Column(children: [
    Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.55))),
    const SizedBox(height: 3),
    Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800,
        color: color), textAlign: TextAlign.center),
  ]);
}

// ── Asset card ────────────────────────────────────────────────────────────────
class _AssetCard extends StatelessWidget {
  final AssetItem asset;
  final String mainCurrency;
  final double? convertedValue;

  const _AssetCard({
    required this.asset,
    required this.mainCurrency,
    this.convertedValue,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const assetColor = Color(0xFF1565C0);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: cs.surfaceContainer.withValues(alpha: isDark ? 0.35 : 0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.black.withValues(alpha: 0.04),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(children: [
          // Icon container
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: assetColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.inventory_2_outlined,
                color: assetColor, size: 22),
          ),
          const SizedBox(width: 12),
          // Name + notes
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(asset.name, style: const TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 15)),
              if (asset.notes.isNotEmpty)
                Text(asset.notes, maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11,
                        color: cs.onSurface.withValues(alpha: 0.5))),
            ],
          )),
          // Value + converted
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              formatAmount(asset.value, asset.currency),
              style: const TextStyle(fontSize: 15,
                  fontWeight: FontWeight.w800, color: assetColor),
            ),
            if (convertedValue != null)
              Text(
                '≈ ${formatAmount(convertedValue!, mainCurrency)}',
                style: TextStyle(fontSize: 10,
                    color: cs.onSurface.withValues(alpha: 0.5)),
              ),
          ]),
          // Actions
          Column(children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 18),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              visualDensity: VisualDensity.compact,
              onPressed: () => AssetsScreen._openSheet(context, existing: asset),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline_rounded, size: 18,
                  color: cs.error),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              visualDensity: VisualDensity.compact,
              onPressed: () async {
                AppHaptics.tap(context, HapticStrength.medium);
                final undo = await context
                    .read<AppProvider>()
                    .deleteAssetWithUndo(asset.id);
                if (context.mounted) {
                  showAppSnackbar(
                      context, l10n.common_itemDeleted(asset.name),
                      onUndo: undo);
                }
              },
            ),
          ]),
        ]),
      ),
    );
  }
}

// ── Add / Edit sheet ──────────────────────────────────────────────────────────
class _AssetSheet extends StatefulWidget {
  final AssetItem? existing;
  const _AssetSheet({this.existing});

  @override
  State<_AssetSheet> createState() => _AssetSheetState();
}

class _AssetSheetState extends State<_AssetSheet> {
  final _nameCtrl  = TextEditingController();
  final _valueCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String _currency = 'EGP';
  bool _submitted  = false;
  bool _showKeypad = false;

  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final app = context.read<AppProvider>();
    _currency = app.settings.currency;
    final e = widget.existing;
    if (e != null) {
      _nameCtrl.text  = e.name;
      _valueCtrl.text = e.value.toStringAsFixed(2);
      _notesCtrl.text = e.notes;
      _currency       = e.currency;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _valueCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (_nameCtrl.text.trim().isEmpty) return;
    final value = double.tryParse(_valueCtrl.text);
    if (value == null || value < 0) return;
    final app = context.read<AppProvider>();

    if (isEdit) {
      await app.updateAsset(widget.existing!.copyWith(
        name: _nameCtrl.text.trim(),
        value: value,
        currency: _currency,
        notes: _notesCtrl.text.trim(),
      ));
    } else {
      await app.addAsset(AssetItem(
        id: app.newId(),
        name: _nameCtrl.text.trim(),
        value: value,
        currency: _currency,
        notes: _notesCtrl.text.trim(),
      ));
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final sym = currencyInfo(_currency).symbol;
    final kbOpen = MediaQuery.of(context).viewInsets.bottom > 100;
    final showPad = _showKeypad && !kbOpen;

    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 20,
          right: 20,
          top: 20),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(isEdit ? l10n.assets_editAsset : l10n.assets_addAsset,
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 16),

            // Name
            TextField(
              controller: _nameCtrl,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: l10n.assets_productAssetName,
                prefixIcon: const Icon(Icons.inventory_2_outlined),
                errorText: _submitted && _nameCtrl.text.trim().isEmpty ? l10n.error_required : null,
              ),
              onTap: () {
                if (_showKeypad) setState(() => _showKeypad = false);
              },
              onChanged: (_) {
                if (_submitted) setState(() {});
              },
            ),
            const SizedBox(height: 12),

            // Value + currency on same row
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _valueCtrl,
                  readOnly: true,
                  showCursor: true,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    setState(() => _showKeypad = true);
                  },
                  decoration: InputDecoration(
                    labelText: l10n.assets_value,
                    prefixText: '$sym ',
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPad
                            ? Icons.keyboard_hide_outlined
                            : Icons.dialpad_outlined,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        AppHaptics.tap(context, HapticStrength.light);
                        FocusScope.of(context).unfocus();
                        setState(() => _showKeypad = !_showKeypad);
                      },
                    ),
                    errorText: _submitted && (double.tryParse(_valueCtrl.text) == null || double.parse(_valueCtrl.text) < 0) ? l10n.error_required : null,
                    helperText: _submitted && (double.tryParse(_valueCtrl.text) == null || double.parse(_valueCtrl.text) < 0) ? null : ' ',
                  ),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                  onChanged: (_) {
                    if (_submitted) setState(() {});
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    final picked = await showCurrencyPicker(
                        context, current: _currency);
                    if (picked != null) setState(() => _currency = picked);
                  },
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withValues(alpha: 0.4)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(children: [
                      Expanded(child: Text(_currency,
                          style: const TextStyle(fontWeight: FontWeight.w700,
                              fontSize: 15))),
                        const Icon(Icons.arrow_drop_down, size: 20),
                      ]),
                    ),
                  ),
                ),
            ]),
            const SizedBox(height: 12),

            // Notes
            TextField(
              controller: _notesCtrl,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              maxLines: 2,
              decoration: InputDecoration(
                labelText: l10n.assets_notesOptional,
                prefixIcon: const Icon(Icons.sticky_note_2_outlined),
              ),
              onTap: () {
                if (_showKeypad) setState(() => _showKeypad = false);
              },
            ),
            if (showPad) ...[
              const SizedBox(height: 12),
              AppNumericKeypad(
                controller: _valueCtrl,
                compact: true,
                onDone: () => setState(() => _showKeypad = false),
              ),
            ],
            const SizedBox(height: 24),

            FilledButton(
              onPressed: () { AppHaptics.tap(context, HapticStrength.light); _submit(); },
              style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28))),
              child: Text(isEdit ? l10n.assets_saveChanges : l10n.assets_addAsset),
            ),
            ],
          ),
        ),
      ),
    );
  }
}

