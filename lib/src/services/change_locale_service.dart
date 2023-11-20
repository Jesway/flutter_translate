import 'package:flutter/widgets.dart';
import 'package:flutter_translate/src/contexts/localization_context.dart';
import 'package:flutter_translate/src/models/locale_data.dart';
import 'package:flutter_translate/src/services/fallback_locale_service.dart';
import 'package:flutter_translate/src/services/localization_service.dart';

class ChangeLocaleService
{
    final LocalizationContext _context;
    final LocalizationService _localizationService;
    final FallbackLocaleService _fallbackLocaleService;

    ChangeLocaleService(this._localizationService, this._fallbackLocaleService, this._context);

    Future changeLocale(Locale locale) async
    {
        final data = await getNewLocaleData(locale) ??
                     await _fallbackLocaleService.getFallbackLocaleData();

        _context.update(data);
    }

    Future<LocaleData?> getNewLocaleData(Locale locale) async
    {
        var data = await _localizationService.loadLocaleData(locale);

        return data != null ? LocaleData(locale, data) : null;
    }
}