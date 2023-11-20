import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/models/locale_data.dart';
import 'package:flutter_translate/src/services/localization_service.dart';
import 'package:flutter_translate/src/utils/utils.dart';

class FallbackLocaleService
{
    final LocalizationService _localizationService;
    final FlutterTranslateOptions _options;
    
    FallbackLocaleService(this._localizationService, this._options);


    Future<LocaleData> getFallbackLocaleData() async
    {
        final data = await loadFallbackLocaleData();

        return LocaleData(_options.fallbackLocale, data);
    }

    Future<Map<String, dynamic>> loadFallbackLocaleData() async
    {
        final data = await _localizationService.loadLocaleData(_options.fallbackLocale);

        if (data == null)
        {
            throw Exception("Fatal error: fallback localizations were not found for locale ${localeToString(_options.fallbackLocale)}.");
        }

        return data;
    }
}