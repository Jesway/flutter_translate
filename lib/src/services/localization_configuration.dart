import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/constants/constants.dart';
import 'locale_file_service.dart';

class LocalizationConfiguration
{
    Map<Locale, String>? _localizations;

    Map<Locale, String>? get localizations => _localizations;

    final Locale fallbackLocale;

    final List<Locale> supportedLocales;

    LocalizationConfiguration._(this.fallbackLocale, this.supportedLocales);

    static Future<LocalizationConfiguration> create(String fallbackLanguage, List<String> supportedLanguages, {String basePath = Constants.localizedAssetsPath}) async
    {
        var configuration = new LocalizationConfiguration._(localeFromString(fallbackLanguage), _generateSupportedLocales(supportedLanguages));

        _validateConfiguration(fallbackLanguage, supportedLanguages);

        var files = await LocaleFileService.getLocaleFiles(supportedLanguages, basePath);

        configuration._localizations = files.map((x,y) => _getLocalizedEntry(x, y));

        return configuration;
    }

    static void _validateConfiguration(String fallbackLanguage, List<String> supportedLanguages)
    {
        if(!supportedLanguages.contains(fallbackLanguage))
        {
            throw new Exception('The fallbackLanguage [$fallbackLanguage] must be present in the supportedLanguages list [${supportedLanguages.join(", ")}].');
        }
    }

    static List<Locale> _generateSupportedLocales(List<String> supportedLanguages)
    {
        return supportedLanguages.map((x) => localeFromString(x, languageCodeOnly: true)).toSet().toList();
    }

    static MapEntry<Locale, String> _getLocalizedEntry(String languageCode, String file)
    {
        Locale locale;

        if(languageCode.contains('_'))
        {
            var parts = languageCode.split('_');

            locale = new Locale(parts[0], parts[1]);
        }
        else
        {
            locale = new Locale(languageCode);
        }

        return MapEntry(locale, file);
    }
}
