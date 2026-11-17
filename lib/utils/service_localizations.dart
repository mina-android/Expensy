// lib/utils/service_localizations.dart
import 'dart:ui';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';

/// Provides synchronized [AppLocalizations] and [Intl.defaultLocale] for
/// services, providers, and non-widget helpers without needing a [BuildContext].
class ServiceLocalizations {
  ServiceLocalizations._();

  static String _languageCode = 'system';

  static const Set<String> _supportedCodes = {
    'ar',
    'bn',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'it',
    'ja',
    'pt',
    'ru',
    'zh',
  };

  /// Updates the active language code and keeps [Intl.defaultLocale] aligned.
  static void setLanguageCode(String code) {
    _languageCode = code.trim().isEmpty ? 'system' : code.trim();
    Intl.defaultLocale = effectiveLanguageCode;
  }

  /// Resolves the effective two-letter ISO language code.
  static String get effectiveLanguageCode {
    if (_languageCode != 'system' && _supportedCodes.contains(_languageCode)) {
      return _languageCode;
    }
    final platformLang = PlatformDispatcher.instance.locale.languageCode;
    if (_supportedCodes.contains(platformLang)) {
      return platformLang;
    }
    return 'en';
  }

  /// Returns the [AppLocalizations] instance for the active language.
  static AppLocalizations get current =>
      lookupAppLocalizations(Locale(effectiveLanguageCode));
}
