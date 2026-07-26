// lib/screens/currency_converter_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});
  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState
    extends State<CurrencyConverterScreen> {
  late String _from;
  late String _to;
  final _ctrl = TextEditingController();
  double? _result;

  @override
  void initState() {
    super.initState();
    final app = context.read<AppProvider>();
    _from = app.settings.currency;
    // Default "to" = USD unless main currency is already USD
    _to = _from == 'USD' ? 'EUR' : 'USD';
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _convert(AppProvider app) {
    final amount = double.tryParse(_ctrl.text);
    if (amount == null) {
      setState(() => _result = null);
      return;
    }
    setState(() => _result = app.convertBetween(amount, _from, _to));
  }

  void _swap(AppProvider app) {
    setState(() {
      final tmp = _from;
      _from = _to;
      _to = tmp;
    });
    _convert(app);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;

    final fromInfo = currencyInfo(_from);
    final toInfo   = currencyInfo(_to);
    final rateAvail = app.ratesLoaded && app.exchangeRates.isNotEmpty;

    // 1 FROM → X TO
    final unitRate = rateAvail
        ? app.convertBetween(1.0, _from, _to)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.currency_converter_currencyConverter,
            style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 20, right: 20, top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Offline banner ───────────────────────────────────────
            if (!rateAvail) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: cs.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(children: [
                  Icon(Icons.wifi_off_rounded, size: 18,
                      color: cs.onErrorContainer),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      app.ratesFetching
                          ? l10n.currency_converter_loadingRates
                          : l10n.currency_converter_ratesUnavailable,
                      style: TextStyle(
                          fontSize: 12, color: cs.onErrorContainer),
                    ),
                  ),
                  if (app.ratesFetching)
                    SizedBox(
                      width: 14, height: 14,
                      child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: cs.onErrorContainer),
                    ),
                ]),
              ),
              const SizedBox(height: 20),
            ],

            // ── FROM field ───────────────────────────────────────────
            Text(l10n.currency_converter_amount, style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
                color: cs.onSurface.withValues(alpha: 0.5))),
            const SizedBox(height: 6),
            Row(children: [
              Expanded(
                child: TextField(
                  controller: _ctrl,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true),
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    prefixText: '${fromInfo.symbol} ',
                  ),
                  onChanged: (_) => _convert(app),
                ),
              ),
              const SizedBox(width: 10),
              // FROM currency pill
              GestureDetector(
                onTap: () async {
                  final picked = await showCurrencyPicker(
                      context, current: _from);
                  if (picked != null && mounted) {
                    setState(() => _from = picked);
                    _convert(context.read<AppProvider>());
                  }
                },
                child: _CurrencyPill(code: _from, cs: cs),
              ),
            ]),
            const SizedBox(height: 20),

            // ── Swap button ──────────────────────────────────────────
            Center(
              child: InkWell(
                onTap: () => _swap(app),
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: cs.primary.withValues(alpha: 0.3)),
                  ),
                  child: Icon(Icons.swap_vert_rounded,
                      size: 22, color: cs.primary),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ── TO result ────────────────────────────────────────────
            Text(l10n.currency_converter_convertedTo, style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
                color: cs.onSurface.withValues(alpha: 0.5))),
            const SizedBox(height: 6),
            Row(children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 18),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: cs.primary.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    _result != null
                        ? '${toInfo.symbol} ${_result!.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},')}'
                        : '—',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: _result != null
                          ? cs.primary
                          : cs.onSurface.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // TO currency pill
              GestureDetector(
                onTap: () async {
                  final picked = await showCurrencyPicker(
                      context, current: _to);
                  if (picked != null && mounted) {
                    setState(() => _to = picked);
                    _convert(context.read<AppProvider>());
                  }
                },
                child: _CurrencyPill(code: _to, cs: cs),
              ),
            ]),
            const SizedBox(height: 20),

            // ── Rate info ────────────────────────────────────────────
            if (unitRate != null)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(children: [
                  Icon(Icons.info_outline_rounded,
                      size: 15,
                      color: cs.onSurface.withValues(alpha: 0.45)),
                  const SizedBox(width: 8),
                  Text(
                    '1 $_from = ${unitRate.toStringAsFixed(4)} $_to',
                    style: TextStyle(
                        fontSize: 13,
                        color: cs.onSurface.withValues(alpha: 0.65)),
                  ),
                  if (app.ratesLastFetched != null) ...[
                    const Spacer(),
                    Text(
                      _rateAge(app.ratesLastFetched!, l10n),
                      style: TextStyle(
                          fontSize: 10,
                          color: cs.onSurface.withValues(alpha: 0.4)),
                    ),
                  ],
                ]),
              ),

            // Quick common conversions
            if (rateAvail && _ctrl.text.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text(l10n.currency_converter_commonConversions(_from),
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: cs.onSurface.withValues(alpha: 0.5))),
              const SizedBox(height: 10),
              _QuickConversions(
                amount: double.tryParse(_ctrl.text) ?? 0,
                from: _from,
                app: app,
                cs: cs,
                excludeTo: _to,
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _rateAge(DateTime fetched, AppLocalizations l10n) {
    final diff = DateTime.now().difference(fetched);
    if (diff.inMinutes < 2) return l10n.currency_converter_rateAgeJustNow;
    if (diff.inHours < 1) return l10n.currency_converter_rateAgeMins(diff.inMinutes);
    if (diff.inHours < 24) return l10n.currency_converter_rateAgeHours(diff.inHours);
    return l10n.currency_converter_rateAgeDays(diff.inDays);
  }
}

// ── Currency pill ─────────────────────────────────────────────────────────────
class _CurrencyPill extends StatelessWidget {
  final String code;
  final ColorScheme cs;
  const _CurrencyPill({required this.code, required this.cs});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: cs.primaryContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cs.primary.withValues(alpha: 0.3)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(code,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: cs.primary)),
          const SizedBox(width: 4),
          Icon(Icons.arrow_drop_down_rounded, size: 18, color: cs.primary),
        ]),
      );
}

// ── Quick conversions strip ───────────────────────────────────────────────────
class _QuickConversions extends StatelessWidget {
  final double amount;
  final String from;
  final String excludeTo;
  final AppProvider app;
  final ColorScheme cs;
  const _QuickConversions({
    required this.amount,
    required this.from,
    required this.excludeTo,
    required this.app,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const popular = ['USD', 'EUR', 'GBP', 'SAR', 'AED', 'EGP', 'JPY', 'GBP'];
    final targets = popular
        .where((c) => c != from && c != excludeTo)
        .take(4)
        .toList();

    if (targets.isEmpty || amount <= 0) return const SizedBox();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: targets.map((code) {
        final converted = app.convertBetween(amount, from, code);
        final info = currencyInfo(code);
        return Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(code,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface.withValues(alpha: 0.5))),
            Text(
              converted != null
                  ? '${info.symbol} ${converted.toStringAsFixed(2)}'
                  : '—',
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w700),
            ),
          ]),
        );
      }).toList(),
    );
  }
}
