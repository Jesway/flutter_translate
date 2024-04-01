import 'package:flutter/widgets.dart';
import 'package:flutter_translate/src/contexts/localization_context.dart';
import 'package:flutter_translate/src/models/locale_data.dart';
import 'package:flutter_translate/src/services/fallback_locale_service.dart';
import 'package:flutter_translate/src/services/localization_service.dart';
import 'package:flutter_translate/src/services/supported_locale_service.dart';
import 'package:intl/intl.dart';

class ChangeLocaleService {
  final LocalizationContext _context;
  final LocalizationService _localizationService;
  final FallbackLocaleService _fallbackLocaleService;
  final SupportedLocaleService _supportedLocaleService;

  ChangeLocaleService(this._localizationService, this._fallbackLocaleService,
      this._supportedLocaleService, this._context);

  Future changeLocale(Locale newLocale) async {
    final supportedLocale =
        _supportedLocaleService.getSupportedLocale(newLocale);

    final data = await getNewLocaleData(supportedLocale) ??
        await _fallbackLocaleService.getFallbackLocaleData();

    Intl.defaultLocale = data.locale.toString();

    _context.update(data);
  }

  Future<LocaleData?> getNewLocaleData(Locale locale) async {
    var data = await _localizationService.loadLocaleData(locale);

    return data != null ? LocaleData(locale, data) : null;
  }
}
