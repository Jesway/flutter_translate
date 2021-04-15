import 'package:flutter/widgets.dart';
import 'locale_file_service.dart';
import 'constants.dart';
import 'global.dart';

class LocalizationConfiguration {
  Map<Locale?, String?>? _localizations;

  Map<Locale?, String?>? get localizations => _localizations;

  final Locale? fallbackLocale;

  final List<Locale?>? supportedLocales;

  LocalizationConfiguration._(this.fallbackLocale, this.supportedLocales);

  static Future<LocalizationConfiguration?> create(String? fallbackLanguage, List<String>? supportedLanguages,
      {String? basePath = Constants.localizedAssetsPath}) async {
    final LocalizationConfiguration configuration =
        LocalizationConfiguration._(localeFromString(fallbackLanguage), _generateSupportedLocales(supportedLanguages!));

    _validateConfiguration(fallbackLanguage, supportedLanguages);

    final Map<String?, String?>? files = await LocaleFileService.getLocaleFiles(supportedLanguages, basePath);

    configuration._localizations = files!.map((String? x, String? y) => _getLocalizedEntry(x, y)!);

    return configuration;
  }

  static void _validateConfiguration(String? fallbackLanguage, List<String?>? supportedLanguages) {
    if (!supportedLanguages!.contains(fallbackLanguage)) {
      throw Exception(
          'The fallbackLanguage [$fallbackLanguage] must be present in the supportedLanguages list [${supportedLanguages.join(", ")}].');
    }
  }

  static List<Locale?>? _generateSupportedLocales(List<String?>? supportedLanguages) {
    return supportedLanguages!.map((String? x) => localeFromString(x, languageCodeOnly: true)).toSet().toList();
  }

  static MapEntry<Locale?, String?>? _getLocalizedEntry(String? languageCode, String? file) {
    Locale? locale;

    if (languageCode!.contains('_')) {
      final List<String> parts = languageCode.split('_');

      locale = Locale(parts[0], parts[1]);
    } else {
      locale = Locale(languageCode);
    }

    return MapEntry<Locale?, String?>(locale, file);
  }
}
