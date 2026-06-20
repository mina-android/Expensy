// lib/services/exchange_rate_service.dart
//
// Fetches daily exchange rates from open.er-api.com (free, no API key).
// All rates are relative to USD as the pivot currency.
// Caches result in SharedPreferences; serves stale cache while refreshing.
//
// XAU (gold troy oz) is NOT included in the open.er-api.com free tier.
// It is fetched separately from the fawaz currency API and injected into
// the rates map so all existing convert() calls work transparently.
//
// Gold price source (free, no API key, daily updated, 200+ currencies):
//   Primary:  https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/xau.min.json
//   Fallback: https://latest.currency-api.pages.dev/v1/currencies/xau.min.json
//   Response: { "date": "2026-05-26", "xau": { "usd": 4540.33, "egp": 237110.38, ... } }
//   XAU rate for pivot math: 1 / xau["usd"]  (troy oz per 1 USD)

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ExchangeRateService {
  static const _ratesKey   = 'er_rates';
  static const _fetchedKey = 'er_fetched_at';
  static const _staleAfter = Duration(hours: 24);
  static const _apiUrl     = 'https://open.er-api.com/v6/latest/USD';

  /// Free currency API by fawazahmed0 — includes metals (XAU, XAG…).
  /// No API key. Daily updated. 200+ currencies.
  /// Primary served via jsDelivr CDN; fallback via Cloudflare Pages.
  static const _goldApiPrimary =
      'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/xau.min.json';
  static const _goldApiFallback =
      'https://latest.currency-api.pages.dev/v1/currencies/xau.min.json';

  // ── Public API ──────────────────────────────────────────────────────────

  /// Returns the cached rates map (may be stale or empty).
  /// AppProvider now controls when fresh fetches happen; this is kept
  /// for backward compatibility with any direct callers.
  Future<Map<String, double>> getRates() async {
    return await _loadCached() ?? {};
  }

  /// Explicitly fetches new rates (main + gold) and caches them.
  /// Returns the new map, or null on total failure (offline, timeout…).
  Future<Map<String, double>?> forceRefresh() => _fetchAndCache();

  /// Fetches the current gold spot price and returns it as an XAU rate
  /// (troy oz per 1 USD) suitable for injection into the rates map.
  ///
  /// Public so AppProvider can call it independently when the cached rates
  /// are missing XAU (e.g. old cache from before this feature was added).
  /// Returns null on any network / parse failure.
  Future<double?> fetchGoldRate() => _fetchGoldRate();

  /// Injects [xauRate] into the cached rates without resetting the
  /// freshness timestamp.  Safe to call after a background gold fetch.
  Future<void> patchCachedXau(double xauRate) async {
    final prefs = await SharedPreferences.getInstance();
    final raw   = prefs.getString(_ratesKey);
    if (raw == null) return;
    try {
      final map = (jsonDecode(raw) as Map<String, dynamic>)
          .map((k, v) => MapEntry(k, (v as num).toDouble()));
      map['XAU'] = xauRate;
      await prefs.setString(_ratesKey, jsonEncode(map));
    } catch (_) {}
  }

  /// Timestamp of the last successful fetch, or null if never fetched.
  Future<DateTime?> lastFetchedAt() async {
    final prefs   = await SharedPreferences.getInstance();
    final fetched = prefs.getString(_fetchedKey);
    if (fetched == null) return null;
    return DateTime.tryParse(fetched);
  }

  /// Convert [amount] from [from] to [to] using [rates].
  /// Both rates are relative to USD so we pivot through USD.
  /// Returns null when either rate is unavailable.
  double? convert(
    double amount,
    String from,
    String to,
    Map<String, double> rates,
  ) {
    if (from == to) return amount;
    final fromRate = rates[from];
    final toRate   = rates[to];
    if (fromRate == null || toRate == null || fromRate == 0) return null;
    return amount / fromRate * toRate;
  }

  // ── Internals ───────────────────────────────────────────────────────────

  /// Fetches main currency rates then injects XAU if not already present.
  Future<Map<String, double>?> _fetchAndCache() async {
    try {
      final resp = await http
          .get(Uri.parse(_apiUrl))
          .timeout(const Duration(seconds: 12));
      if (resp.statusCode != 200) return null;

      final json = jsonDecode(resp.body) as Map<String, dynamic>;
      if (json['result'] != 'success') return null;

      final rawRates = json['rates'] as Map<String, dynamic>;
      final rates    = rawRates.map(
        (k, v) => MapEntry(k, (v as num).toDouble()),
      );

      // XAU is not in the open.er-api.com free tier — fetch separately.
      final hasXau = rates.containsKey('XAU') &&
          (rates['XAU'] ?? 0) > 0;
      if (!hasXau) {
        final xauRate = await _fetchGoldRate();
        if (xauRate != null) rates['XAU'] = xauRate;
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_ratesKey,   jsonEncode(rates));
      await prefs.setString(_fetchedKey, DateTime.now().toIso8601String());
      return rates;
    } catch (_) {
      return null;
    }
  }

  /// Fetches the XAU rate from the fawaz currency API (primary + fallback).
  ///
  /// Response: {"date":"2026-05-26","xau":{"usd":4540.33,"egp":237110.38,...}}
  /// XAU rate = 1 / xau["usd"]  (troy oz per 1 USD, matching the pivot format)
  Future<double?> _fetchGoldRate() async {
    for (final url in [_goldApiPrimary, _goldApiFallback]) {
      try {
        final resp = await http
            .get(Uri.parse(url))
            .timeout(const Duration(seconds: 10));
        if (resp.statusCode != 200) continue;

        final data = jsonDecode(resp.body);
        if (data is! Map) continue;

        final xauMap = data['xau'];
        if (xauMap is! Map) continue;

        final usdPrice = xauMap['usd'];
        final priceUsd = usdPrice is num
            ? usdPrice.toDouble()
            : double.tryParse(usdPrice?.toString() ?? '');

        if (priceUsd != null && priceUsd > 0) {
          return 1.0 / priceUsd; // XAU rate: troy oz per 1 USD
        }
      } catch (_) {
        continue; // try fallback
      }
    }
    return null; // both endpoints failed
  }

  /// Returns cached rates from SharedPreferences without triggering a network
  /// fetch. Used by AppProvider to serve cached data immediately on startup.
  Future<Map<String, double>?> getCached() => _loadCached();

  /// Returns true when the cache exists and is younger than 24 hours.
  /// Public so AppProvider can decide whether to trigger a background refresh.
  Future<bool> isFresh() => _isFresh();

  Future<Map<String, double>?> _loadCached() async {
    final prefs = await SharedPreferences.getInstance();
    final raw   = prefs.getString(_ratesKey);
    if (raw == null) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return map.map((k, v) => MapEntry(k, (v as num).toDouble()));
    } catch (_) {
      return null;
    }
  }

  Future<bool> _isFresh() async {
    final prefs   = await SharedPreferences.getInstance();
    final fetched = prefs.getString(_fetchedKey);
    if (fetched == null) return false;
    final parsed  = DateTime.tryParse(fetched);
    if (parsed == null) return false;
    return DateTime.now().difference(parsed) < _staleAfter;
  }
}
