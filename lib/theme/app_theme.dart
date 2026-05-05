// lib/theme/app_theme.dart
import 'package:flutter/material.dart';

// ─── Seed colours ─────────────────────────────────────────────────────────
const Map<String, Color> kSeedColours = {
  // Original 15
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
  'pitch_black': Color(0xFF1C1C1C),
  // New 10
  'sky':         Color(0xFF0277BD),
  'forest':      Color(0xFF1B5E20),
  'coral':       Color(0xFFD84315),
  'gold':        Color(0xFFF9A825),
  'slate':       Color(0xFF37474F),
  'magenta':     Color(0xFF880E4F),
  'turquoise':   Color(0xFF004D40),
  'brown':       Color(0xFF4E342E),
  'olive':       Color(0xFF827717),
  'lavender':    Color(0xFF6A1B9A),
};

const Map<String, String> kSeedLabels = {
  'violet':      'Violet',
  'blue':        'Blue',
  'green':       'Green',
  'rose':        'Rose',
  'amber':       'Amber',
  'teal':        'Teal',
  'orange':      'Orange',
  'indigo':      'Indigo',
  'cyan':        'Cyan',
  'pink':        'Pink',
  'lime':        'Lime',
  'deep_purple': 'Deep Purple',
  'crimson':     'Crimson',
  'midnight':    'Midnight',
  'pitch_black': 'Pitch Black',
  'sky':         'Sky Blue',
  'forest':      'Forest',
  'coral':       'Coral',
  'gold':        'Gold',
  'slate':       'Slate',
  'magenta':     'Magenta',
  'turquoise':   'Turquoise',
  'brown':       'Brown',
  'olive':       'Olive',
  'lavender':    'Lavender',
};

Color seedColour(String key) =>
    kSeedColours[key] ?? const Color(0xFF6750A4);

ThemeData buildTheme({required String seed, required bool dark}) {
  if (seed == 'pitch_black') {
    final cs = ColorScheme.fromSeed(
      seedColor: const Color(0xFF9E9E9E),
      brightness: Brightness.dark,
    ).copyWith(
      surface:                 Colors.black,
      surfaceContainerLow:     const Color(0xFF0A0A0A),
      surfaceContainer:        const Color(0xFF111111),
      surfaceContainerHigh:    const Color(0xFF1A1A1A),
      surfaceContainerHighest: const Color(0xFF222222),
    );
    return _baseTheme(cs);
  }
  return _baseTheme(ColorScheme.fromSeed(
    seedColor: seedColour(seed),
    brightness: dark ? Brightness.dark : Brightness.light,
  ));
}

ThemeData _baseTheme(ColorScheme cs) => ThemeData(
  colorScheme: cs,
  useMaterial3: true,
  fontFamily: 'Roboto',
  appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
  cardTheme: CardThemeData(
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    border:        OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: cs.primary, width: 2),
    ),
  ),
  // ── Rounded dropdowns globally ──────────────────────────────────────────
  dropdownMenuTheme: DropdownMenuThemeData(
    menuStyle: MenuStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS:     CupertinoPageTransitionsBuilder(),
    },
  ),
  segmentedButtonTheme: const SegmentedButtonThemeData(),
);

// ─── Currency registry ─────────────────────────────────────────────────────
class CurrencyInfo {
  final String code, symbol, name;
  const CurrencyInfo(this.code, this.symbol, this.name);
}

const List<CurrencyInfo> kCurrencies = [
  CurrencyInfo('EGP', 'EGP', 'Egyptian Pound'),   // ← changed E£ → EGP
  CurrencyInfo('USD', '\$',   'US Dollar'),
  CurrencyInfo('EUR', '€',   'Euro'),
  CurrencyInfo('GBP', '£',   'British Pound'),
  CurrencyInfo('SAR', 'SR',  'Saudi Riyal'),
  CurrencyInfo('AED', 'د.إ', 'UAE Dirham'),
  CurrencyInfo('JPY', '¥',   'Japanese Yen'),
  CurrencyInfo('CAD', 'C\$', 'Canadian Dollar'),
];

CurrencyInfo currencyInfo(String code) =>
    kCurrencies.firstWhere((c) => c.code == code,
        orElse: () => kCurrencies.first);

String formatAmount(double amount, String currencyCode) {
  final info = currencyInfo(currencyCode);
  final formatted = amount.abs().toStringAsFixed(2)
      .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},');
  return '${info.symbol} $formatted';
}
