import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'localization_file_service.dart';
import 'localization_configuration.dart';
import 'localization.dart';

class LocalizationDelegate extends LocalizationsDelegate<Localization>
{
    final LocalizationConfiguration configuration;

    LocalizationDelegate(this.configuration);

    @override
    Future<Localization> load(Locale newLocale) async
    {
        var locale = _findLocale(newLocale) ?? configuration.fallbackLocale;

        var localizedContent = await _getLocalizedContent(locale);

        return new Localization(localizedContent);
    }

    Future<Map<String, dynamic>> _getLocalizedContent(Locale locale) async
    {
        var file = configuration.localizations[locale];

        var content = await LocalizationFileService.getLocalizedContent(file);

        return json.decode(content);
    }


    Locale _findLocale(Locale locale)
    {
        var existing = configuration.localizations.keys.firstWhere((x) => x == locale, orElse: () => null);

        if(existing == null)
        {
            existing = configuration.localizations.keys.firstWhere((x) => x.languageCode == locale.languageCode, orElse: () => null);
        }

        return existing;
    }

    @override
    bool isSupported(Locale locale) => locale != null;

    @override
    bool shouldReload(LocalizationsDelegate<Localization> old) => true;
}
