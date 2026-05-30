// lib/theme/app_theme.dart
import 'package:flutter/material.dart';

// ── Seed colours ─────────────────────────────────────────────────────────────
const Map<String, Color> kSeedColours = {
  'violet':      Color(0xFF6750A4),
  'blue':        Color(0xFF0061A4),
  'green':       Color(0xFF386A1F),
  'rose':        Color(0xFF9C4257),
  'amber':       Color(0xFF785900),
  'teal':        Color(0xFF006874),
  'orange':      Color(0xFFBF360C),
  'indigo':      Color(0xFF283593),
  'cyan':        Color(0xFF00838F),
  'pink':        Color(0xFFAD1457),
  'lime':        Color(0xFF558B2F),
  'deep_purple': Color(0xFF4527A0),
  'crimson':     Color(0xFFB71C1C),
  'midnight':    Color(0xFF1A237E),
  // Greens
  'forest':      Color(0xFF1B5E20),
  'mint':        Color(0xFF00695C),
  'olive':       Color(0xFF827717),
  'sage':        Color(0xFF33691E),
  // Blues
  'sky':         Color(0xFF0277BD),
  'navy':        Color(0xFF0D47A1),
  'cobalt':      Color(0xFF1565C0),
  'ocean':       Color(0xFF006064),
  // Others
  'coral':       Color(0xFFD84315),
  'gold':        Color(0xFFF9A825),
  'slate':       Color(0xFF37474F),
  'magenta':     Color(0xFF880E4F),
  'turquoise':   Color(0xFF004D40),
  'brown':       Color(0xFF4E342E),
  'lavender':    Color(0xFF6A1B9A),
};

const Map<String, String> kSeedLabels = {
  'violet': 'Violet', 'blue': 'Blue', 'green': 'Green', 'rose': 'Rose',
  'amber': 'Amber', 'teal': 'Teal', 'orange': 'Orange', 'indigo': 'Indigo',
  'cyan': 'Cyan', 'pink': 'Pink', 'lime': 'Lime', 'deep_purple': 'Deep Purple',
  'crimson': 'Crimson', 'midnight': 'Midnight',
  'forest': 'Forest', 'mint': 'Mint', 'olive': 'Olive', 'sage': 'Sage',
  'sky': 'Sky Blue', 'navy': 'Navy', 'cobalt': 'Cobalt', 'ocean': 'Ocean',
  'coral': 'Coral', 'gold': 'Gold', 'slate': 'Slate',
  'magenta': 'Magenta', 'turquoise': 'Turquoise',
  'brown': 'Brown', 'lavender': 'Lavender',
};

Color seedColour(String key) => kSeedColours[key] ?? const Color(0xFF6750A4);

/// themeMode: 'system' | 'light' | 'dark' | 'amoled'
ThemeMode resolveThemeMode(String mode) {
  switch (mode) {
    case 'light':  return ThemeMode.light;
    case 'dark':   return ThemeMode.dark;
    case 'amoled': return ThemeMode.dark;
    default:       return ThemeMode.system;
  }
}

ThemeData buildTheme({required String seed, required bool dark, bool amoled = false}) {
  final seedColor = kSeedColours[seed] ?? const Color(0xFF6750A4);
  if (dark && amoled) {
    // AMOLED: pure black surface + chosen accent colour for primary/secondary
    final cs = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ).copyWith(
      surface:                 Colors.black,
      surfaceContainerLow:     const Color(0xFF0A0A0A),
      surfaceContainer:        const Color(0xFF111111),
      surfaceContainerHigh:    const Color(0xFF1A1A1A),
      surfaceContainerHighest: const Color(0xFF222222),
    );
    return _base(cs);
  }
  return _base(ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: dark ? Brightness.dark : Brightness.light,
  ));
}

ThemeData _base(ColorScheme cs) => ThemeData(
  colorScheme: cs,
  useMaterial3: true,
  appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
  cardTheme: CardThemeData(
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    border:        OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cs.primary, width: 2)),
  ),
);

// ── Currency ─────────────────────────────────────────────────────────────────
class CurrencyInfo {
  final String code, symbol, name;
  const CurrencyInfo(this.code, this.symbol, this.name);
}

const List<CurrencyInfo> kCurrencies = [
  CurrencyInfo('USD', r'$',   'US Dollar'),
  CurrencyInfo('EUR', '€',   'Euro'),
  CurrencyInfo('GBP', '£',   'British Pound'),
  CurrencyInfo('CAD', r'C$', 'Canadian Dollar'),
  CurrencyInfo('EGP', 'EGP', 'Egyptian Pound'),
  CurrencyInfo('SAR', 'SR',  'Saudi Riyal'),
  CurrencyInfo('AED', 'د.إ', 'UAE Dirham'),
  CurrencyInfo('KWD', 'KD',  'Kuwaiti Dinar'),
  CurrencyInfo('QAR', 'QR',  'Qatari Riyal'),
  CurrencyInfo('BHD', 'BD',  'Bahraini Dinar'),
  CurrencyInfo('OMR', 'OMR', 'Omani Rial'),
  CurrencyInfo('JOD', 'JD',  'Jordanian Dinar'),
  CurrencyInfo('MAD', 'MAD', 'Moroccan Dirham'),
  CurrencyInfo('TND', 'DT',  'Tunisian Dinar'),
  CurrencyInfo('LYD', 'LD',  'Libyan Dinar'),
  CurrencyInfo('DZD', 'DA',  'Algerian Dinar'),
  CurrencyInfo('SDG', 'SDG', 'Sudanese Pound'),
  CurrencyInfo('NGN', '₦',   'Nigerian Naira'),
  CurrencyInfo('GHS', 'GH₵', 'Ghanaian Cedi'),
  CurrencyInfo('KES', 'KSh', 'Kenyan Shilling'),
  CurrencyInfo('ZAR', 'R',   'South African Rand'),
  CurrencyInfo('ETB', 'Br',  'Ethiopian Birr'),
  CurrencyInfo('TZS', 'TSh', 'Tanzanian Shilling'),
  CurrencyInfo('UGX', 'USh', 'Ugandan Shilling'),
  CurrencyInfo('RWF', 'RF',  'Rwandan Franc'),
  CurrencyInfo('XOF', 'CFA', 'West African CFA'),
  CurrencyInfo('XAF', 'FCFA','Central African CFA'),
  CurrencyInfo('MZN', 'MT',  'Mozambican Metical'),
  CurrencyInfo('ZMW', 'ZK',  'Zambian Kwacha'),
  CurrencyInfo('JPY', '¥',   'Japanese Yen'),
  CurrencyInfo('CNY', '¥',   'Chinese Yuan'),
  CurrencyInfo('INR', '₹',   'Indian Rupee'),
  CurrencyInfo('KRW', '₩',   'South Korean Won'),
  CurrencyInfo('IDR', 'Rp',  'Indonesian Rupiah'),
  CurrencyInfo('MYR', 'RM',  'Malaysian Ringgit'),
  CurrencyInfo('SGD', r'S$', 'Singapore Dollar'),
  CurrencyInfo('THB', '฿',   'Thai Baht'),
  CurrencyInfo('VND', '₫',   'Vietnamese Dong'),
  CurrencyInfo('PHP', '₱',   'Philippine Peso'),
  CurrencyInfo('PKR', 'Rs',  'Pakistani Rupee'),
  CurrencyInfo('BDT', '৳',   'Bangladeshi Taka'),
  CurrencyInfo('LKR', 'Rs',  'Sri Lankan Rupee'),
  CurrencyInfo('NPR', 'Rs',  'Nepali Rupee'),
  CurrencyInfo('MMK', 'K',   'Myanmar Kyat'),
  CurrencyInfo('TWD', r'NT$','Taiwan Dollar'),
  CurrencyInfo('HKD', r'HK$','Hong Kong Dollar'),
  CurrencyInfo('ILS', '₪',   'Israeli Shekel'),
  CurrencyInfo('TRY', '₺',   'Turkish Lira'),
  CurrencyInfo('CHF', 'Fr',  'Swiss Franc'),
  CurrencyInfo('SEK', 'kr',  'Swedish Krona'),
  CurrencyInfo('NOK', 'kr',  'Norwegian Krone'),
  CurrencyInfo('DKK', 'kr',  'Danish Krone'),
  CurrencyInfo('PLN', 'zł',  'Polish Zloty'),
  CurrencyInfo('CZK', 'Kč',  'Czech Koruna'),
  CurrencyInfo('HUF', 'Ft',  'Hungarian Forint'),
  CurrencyInfo('RON', 'lei', 'Romanian Leu'),
  CurrencyInfo('BGN', 'лв',  'Bulgarian Lev'),
  CurrencyInfo('RUB', '₽',   'Russian Ruble'),
  CurrencyInfo('UAH', '₴',   'Ukrainian Hryvnia'),
  CurrencyInfo('GEL', '₾',   'Georgian Lari'),
];

CurrencyInfo currencyInfo(String code) =>
    kCurrencies.firstWhere((c) => c.code == code,
        orElse: () => kCurrencies.first);

String formatAmount(double amount, String code) {
  final info = currencyInfo(code);
  final sign = amount < 0 ? '-' : '';
  final formatted = amount.abs().toStringAsFixed(2)
      .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},');
  return '$sign${info.symbol} $formatted';
}
