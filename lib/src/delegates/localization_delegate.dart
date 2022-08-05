import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/constants/constants.dart';
import 'package:flutter_translate/src/services/locale_service.dart';
import 'package:flutter_translate/src/validators/configuration_validator.dart';

class LocalizationDelegate extends LocalizationsDelegate<Localization> {
  Locale? _currentLocale;

  final Locale fallbackLocale;

  final List<Locale> supportedLocales;

  final Map<Locale, String> supportedLocalesMap;

  final ITranslatePreferences? preferences;

  final bool fallbackForMissingStrings;

  LocaleChangedCallback? onLocaleChanged;

  Locale get currentLocale => _currentLocale!;

  LocalizationDelegate._(
    this.fallbackLocale,
    this.supportedLocales,
    this.supportedLocalesMap,
    this.preferences,
    this.fallbackForMissingStrings,
  );

  Future changeLocale(Locale newLocale) async {
    var isInitializing = _currentLocale == null;

    var locale =
        LocaleService.findLocale(newLocale, supportedLocales) ?? fallbackLocale;

    if (_currentLocale == locale) return;

    var localizedContent =
        await LocaleService.getLocaleContent(locale, supportedLocalesMap);

    var fallbackContent =
        (fallbackForMissingStrings && locale != fallbackLocale)
            ? await LocaleService.getLocaleContent(
                fallbackLocale, supportedLocalesMap)
            : null;

    Localization.load(localizedContent, fallback: fallbackContent);

    _currentLocale = locale;

    Intl.defaultLocale = _currentLocale?.languageCode;

    if (onLocaleChanged != null) {
      await onLocaleChanged!(locale);
    }

    if (!isInitializing && preferences != null) {
      await preferences!.savePreferredLocale(locale);
    }
  }

  @override
  Future<Localization> load(Locale newLocale) async {
    if (currentLocale != newLocale) {
      await changeLocale(newLocale);
    }

    return Localization.instance;
  }

  @override
  bool isSupported(Locale? locale) => locale != null;

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => true;

  static Future<LocalizationDelegate> create(
      {required String fallbackLocale,
      required List<String> supportedLocales,
      bool? useFallbackForMissingStrings,
      String basePath = Constants.localizedAssetsPath,
      ITranslatePreferences? preferences}) async {
    WidgetsFlutterBinding.ensureInitialized();

    var fallback = localeFromString(fallbackLocale);
    var localesMap =
        await LocaleService.getLocalesMap(supportedLocales, basePath);
    var locales = localesMap.keys.toList();

    ConfigurationValidator.validate(fallback, locales);

    var delegate = LocalizationDelegate._(fallback, locales, localesMap,
        preferences, useFallbackForMissingStrings ?? false);

    if (!await delegate._loadPreferences()) {
      await delegate._loadDeviceLocale();
    }

    return delegate;
  }

  Future<bool> _loadPreferences() async {
    if (preferences == null) return false;

    Locale? locale;

    try {
      locale = await preferences!.getPreferredLocale();
    } catch (e) {
      return false;
    }

    if (locale != null) {
      await changeLocale(locale);
      return true;
    }

    return false;
  }

  Future _loadDeviceLocale() async {
    try {
      var locale = getCurrentLocale();

      if (locale != null) {
        await changeLocale(locale);
      }
    } catch (e) {
      await changeLocale(fallbackLocale);
    }
  }
}
