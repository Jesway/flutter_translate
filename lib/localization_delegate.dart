import 'package:flutter/widgets.dart';
import 'package:flutter_device_locale/flutter_device_locale.dart';
import 'configuration_validator.dart';
import 'locale_service.dart';
import 'constants.dart';

import 'flutter_translate.dart';

class LocalizationDelegate extends LocalizationsDelegate<Localization> {
  Locale? _currentLocale;

  final Locale? fallbackLocale;

  final List<Locale>? supportedLocales;

  final Map<Locale, String>? supportedLocalesMap;

  final ITranslatePreferences? preferences;

  LocaleChangedCallback? onLocaleChanged;

  Locale? get currentLocale => _currentLocale;

  LocalizationDelegate._(this.fallbackLocale, this.supportedLocales, this.supportedLocalesMap, this.preferences);

  Future changeLocale(Locale newLocale) async {
    final bool isInitializing = currentLocale == null;

    final Locale? locale = LocaleService.findLocale(newLocale, supportedLocales) ?? fallbackLocale;

    if (_currentLocale == locale) return;

    final Map<String?, dynamic>? localizedContent = await LocaleService.getLocaleContent(locale, supportedLocalesMap!);

    Localization.load(localizedContent!);

    _currentLocale = locale;

    if (onLocaleChanged != null) {
      await onLocaleChanged!(locale);
    }

    if (!isInitializing && preferences != null) {
      await preferences!.savePreferredLocale(locale!);
    }
  }

  @override
  Future<Localization> load(Locale? newLocale) async {
    if (currentLocale != newLocale) {
      await changeLocale(newLocale!);
    }

    return Localization.instance!;
  }

  @override
  bool isSupported(Locale locale) => locale != null;

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => true;

  static Future<LocalizationDelegate> create(
      {@required String? fallbackLocale,
      @required List<String>? supportedLocales,
      String? basePath = Constants.localizedAssetsPath,
      ITranslatePreferences? preferences}) async {
    WidgetsFlutterBinding.ensureInitialized();

    final Locale? fallback = localeFromString(fallbackLocale);
    final Map<Locale, String>? localesMap = await LocaleService.getLocalesMap(supportedLocales, basePath);
    final List<Locale> locales = localesMap!.keys.toList();

    ConfigurationValidator.validate(fallback, locales);

    final LocalizationDelegate delegate = LocalizationDelegate._(fallback, locales, localesMap, preferences);

    if (!await delegate._loadPreferences()) {
      await delegate._loadDeviceLocale();
    }

    return delegate;
  }

  Future<bool> _loadPreferences() async {
    if (preferences == null) return false;

    Locale locale;

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
      final Locale locale = await DeviceLocale.getCurrentLocale();

      if (locale != null) {
        await changeLocale(locale);
      }
    } catch (e) {
      await changeLocale(fallbackLocale!);
    }
  }
}
