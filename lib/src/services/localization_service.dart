import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/services/loaders/base/localization_loader.dart';

class LocalizationService 
{
    final Map<Locale, Map<String, dynamic>> _localizations = {};

    bool containsLocale(Locale locale)
    {
        return _localizations.containsKey(locale);
    }
    final LocalizationLoader loader;
    final FlutterTranslateOptions options;

    LocalizationService(this.loader, this.options);
    
    Future<Map<String, dynamic>?> loadLocaleData(Locale locale) async 
    {
        var data = await _loadLocaleData(locale);

        if (data == null && locale.countryCode != null)
        {
            data = await _loadLocaleData(Locale(locale.languageCode));
        }

        return data;
    }

    Future<Map<String, dynamic>?> _loadLocaleData(Locale locale) async
    {
        var data = _getLocalizationData(locale);

        if (data == null) 
        {
            data = await loader.load(locale);

            if (data != null)
            {
                _addLocalization(locale, data);
            }
        }

        return data;
    }

    void _addLocalization(Locale locale, Map<String, dynamic> localizationData) 
    {
        _localizations[locale] = localizationData;
    }

    Map<String, dynamic>? _getLocalizationData(Locale locale) 
    {
        return _localizations[locale];
    }
}