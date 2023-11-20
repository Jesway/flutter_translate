import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:collection/collection.dart';

class SupportedLocaleService
{
    final FlutterTranslateOptions _options;

    SupportedLocaleService(this._options);

    /// Determines the most appropriate supported locale based on the provided [locale].
    ///
    /// This method searches for a supported locale in the following order:
    ///   1. An exact match for the provided [locale] in the supported locales list.
    ///   2. A locale with the same language code as the provided [locale].
    ///   3. The fallback locale, if no exact or language-code match is found.
    ///
    /// [locale]: The locale to match against the supported locales.
    ///
    /// Returns the most appropriate `Locale` object from the supported locales list,
    /// or the fallback locale if no suitable match is found.
    Locale getSupportedLocale(Locale locale)
    {
        var supportedLocale = _options.supportedLocales.firstWhereOrNull((x) => x == locale);
        
        if (supportedLocale != null)
        {
            return supportedLocale;
        }

        supportedLocale = _options.supportedLocales.firstWhereOrNull((x) => x.languageCode == locale.languageCode);

        return supportedLocale ?? _options.fallbackLocale;
    }
}