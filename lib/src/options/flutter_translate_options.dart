import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/extensions/string_extensions.dart';
import 'package:flutter_translate/src/services/loaders/base/localization_loader_options.dart';

/// Configures localization settings for the flutter_translate package.
///
/// This class allows setting up initial settings for localization, including
/// supported locales, fallback locale, path to localization files, and event
/// handlers for locale changes.
class FlutterTranslateOptions {
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

  /// Specifies the loader type for localization data.
  ///
  /// This field determines how localization data is sourced - either from local assets or via HTTP.
  final LocalizationLoaderOptions loaderOptions;

  /// Constructor for [FlutterTranslateOptions].
  ///
  /// Initializes the class with default or provided values for localization settings.
  ///
  /// Parameters:
  ///   - [supported]: A list of language codes (e.g., 'en_US', 'de', etc.) representing the locales
  ///     supported by the application.
  ///   - [fallback]: The locale to use when the selected locale is not supported. If not provided,
  ///     the first supported locale is used as a fallback.
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
  FlutterTranslateOptions({
    this.autoSave = false,
    this.missingKeyStrategy = MissingKeyStrategy.key,
    this.onLocaleChanged,
    required List<String> supported,
    String? fallback,
    String? initial,
    LocalizationLoaderOptions? loader,
  })  : supportedLocales = getSupportedLocales(supported),
        fallbackLocale = getFallbackLocale(fallback, supported),
        initialLocale = getInitialLocale(initial),
        loaderOptions = loader ?? AssetsLoaderOptions();

  static List<Locale> getSupportedLocales(List<String> locales) {
    if (locales.isNotEmpty) {
      return locales.toSet().map((x) => x.toLocale()).toList();
    } else {
      throw Exception("At least one supported locale must be specified.");
    }
  }

  static Locale getFallbackLocale(
      String? fallback, List<String> supportedLocales) {
    if (fallback != null) {
      if (supportedLocales.any((x) => x == fallback)) {
        return fallback.toLocale();
      } else {
        throw Exception(
            "The fallback locale must be present in the list of supported locales.");
      }
    }

    return supportedLocales.first.toLocale();
  }

  static Locale? getInitialLocale(String? initial) {
    return initial?.toLocale();
  }
}
