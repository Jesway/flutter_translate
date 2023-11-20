import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/services/loaders/base/localization_loader_options.dart';
import 'package:flutter_translate/src/utils/utils.dart';

/// Configures localization settings for the flutter_translate package.
///
/// This class allows setting up initial settings for localization, including 
/// supported locales, fallback locale, path to localization files, and event 
/// handlers for locale changes.
class FlutterTranslateOptions 
{
    // Default locale used when no specific locale is provided or available.
    static const _defaultLocale = 'en_US';

    /// Fallback locale used when the selected locale is not supported.
    /// This ensures the app has a default language to fall back to.
    final Locale fallbackLocale;
    
    /// List of locales supported by the application.
    /// These locales are available for use in the app's localization.
    final List<Locale> supportedLocales;

    /// Determines if the selected locale should be saved and reloaded on app restart.
    /// When true, the app remembers the user's language preference across sessions.
    final bool autoSave;

    /// Strategy to handle missing translation keys.
    /// Determines how the system reacts when a translation key is not found in the current locale.
    final MissingKeyStrategy missingKeyStrategy;

    /// Initial locale that overrides the system's default locale.
    /// If null, the system locale is used as the initial locale.
    final Locale? initialLocale;

    /// Event callback triggered when the locale changes.
    /// This can be used to perform actions when the app's language is changed.
    final LocaleChangedCallback? onLocaleChanged;

    /// Determines whether to use the country code in addition to the language code for retrieving localizations.
    ///
    /// If set to `false` (the default), only the language code is used to retrieve localizations. 
    /// This means that localization will be based purely on language (e.g., 'en', 'fr')
    ///
    /// If set to `true`, the country code is also considered, allowing for more specific localizations 
    /// that take into account both the language and the country/region (e.g., 'en_US', 'en_UK', 'fr_CA').
    final bool useCountryCode;

    /// Specifies the loader type for localization data.
    /// 
    /// This field determines how localization data is sourced - either from local assets or via HTTP.
    final LocalizationLoaderOptions loaderOptions;

    /// Constructor for [FlutterTranslateOptions].
    ///
    /// Initializes the class with default or provided values for localization settings.
    /// 
    /// Parameters:
    ///   - [supported]: A list of language codes (e.g., 'en_US', 'fr_FR') representing the locales 
    ///     supported by the application. If no list is provided, the default locale 'en_US' is used.
    ///   - [fallback]: The locale to use when the selected locale is not supported. If not provided,
    ///     the default locale 'en_US' is used as a fallback.
    ///   - [autoSave]: Determines if the selected locale should be saved and reloaded on app restart. 
    ///     Defaults to false.
    ///   - [missingKeyStrategy]: Strategy to handle missing translation keys. Defaults to using the key
    ///     itself as the fallback text.
    ///   - [initial]: The initial locale to be used by the app, overriding the system's default locale.
    ///     If null, the system's locale is used.
    ///   - [onLocaleChanged]: Event callback triggered when the locale changes. This can be used to
    ///     perform actions when the app's language is changed.
    ///   - [loader]: Specifies the loader type for localization data, determining how localization data
    ///     is sourced - either from local assets or via HTTP. If null, a default assets loader is used.
    ///   - [useCountryCode] Determines whether to use the country code in addition to the language code for retrieving localizations.
    ///     Defaults to false.
    FlutterTranslateOptions({
        this.autoSave = false,
        this.missingKeyStrategy = MissingKeyStrategy.key,
        this.onLocaleChanged,
        this.useCountryCode = false,
        List<String>? supported = const [_defaultLocale], 
        String? fallback = _defaultLocale,
        String? initial,
        LocalizationLoaderOptions? loader,
    }) : fallbackLocale = localeFromString(fallback ?? _defaultLocale, languageCodeOnly: !useCountryCode),
         supportedLocales = getSupportedLocales(supported, useCountryCode),
         initialLocale = initial != null ? localeFromString(initial, languageCodeOnly: !useCountryCode) : null,
         loaderOptions =  loader ?? AssetsLoaderOptions();

    static List<Locale> getSupportedLocales(List<String>? locales, bool useCountryCode)
    {
        if (locales != null && locales.isNotEmpty)
        {
            return locales.map((x) => localeFromString(x, languageCodeOnly: !useCountryCode)).toList();
        }

        return [localeFromString(_defaultLocale, languageCodeOnly: !useCountryCode)];
    }
}