import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/services/fallback_locale_service.dart';
import 'package:flutter_translate/src/services/locale_persistence_service.dart';
import 'package:flutter_translate/src/services/localization_service.dart';

class InitialLocaleService {
  FlutterTranslateOptions options;
  LocalizationService localizationService;
  FallbackLocaleService fallbackLocaleService;
  LocalePersistenceService localePersistenceService;

  InitialLocaleService(this.localizationService, this.fallbackLocaleService,
      this.localePersistenceService, this.options);

  Future<Locale> getInitialLocale() async {
    Locale currentLocale = await _getInitialLocale();

    final data = await localizationService.loadLocaleData(currentLocale);

    if (data == null) {
      await fallbackLocaleService.loadFallbackLocaleData();

      currentLocale = options.fallbackLocale;
    }

    return currentLocale;
  }

  Future<Locale> _getInitialLocale() async {
    Locale? locale;

    if (options.autoSave) {
      locale = await localePersistenceService.getPreferredLocale();
    }

    locale ??= options.initialLocale ??
        getCurrentDeviceLocale(); // options.fallbackLocale

    return locale;
  }
}
