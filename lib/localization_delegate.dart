import 'package:flutter/widgets.dart';
import 'package:flutter_device_locale/flutter_device_locale.dart';

import 'configuration_validator.dart';
import 'constants.dart';
import 'flutter_translate.dart';
import 'locale_service.dart';

class LocalizationDelegate extends LocalizationsDelegate<Localization> {
  Locale? _currentLocale;

  final Locale fallbackLocale;

  final List<Locale> supportedLocales;

  final Map<Locale, String> supportedLocalesMap;

  final ITranslatePreferences? preferences;

  LocaleChangedCallback? onLocaleChanged;

  Locale? get currentLocale => _currentLocale;

  LocalizationDelegate._(this.fallbackLocale, this.supportedLocales,
      this.supportedLocalesMap, this.preferences);

  Future changeLocale(Locale newLocale) async {
    var isInitializing = currentLocale == null;

    var locale =
        LocaleService.findLocale(newLocale, supportedLocales) ?? fallbackLocale;

    if (_currentLocale == locale) return;

    var localizedContent =
        await LocaleService.getLocaleContent(locale, supportedLocalesMap);

    Localization.load(localizedContent);

    _currentLocale = locale;

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
  bool isSupported(Locale locale) => true;

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => true;

  static Future<LocalizationDelegate> create(
      {required String fallbackLocale,
      required List<String> supportedLocales,
      String basePath = Constants.localizedAssetsPath,
      ITranslatePreferences? preferences}) async {
    WidgetsFlutterBinding.ensureInitialized();

    var fallback = localeFromString(fallbackLocale);
    var localesMap =
        await LocaleService.getLocalesMap(supportedLocales, basePath);
    var locales = localesMap.keys.toList();

    ConfigurationValidator.validate(fallback, locales);

    var delegate =
        LocalizationDelegate._(fallback, locales, localesMap, preferences);

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
      var locale = await DeviceLocale.getCurrentLocale();

      await changeLocale(locale);
    } catch (e) {
      await changeLocale(fallbackLocale);
    }
  }
}
