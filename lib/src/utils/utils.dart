import 'package:flutter/widgets.dart';
import 'package:flutter_translate_community/flutter_translate_community.dart';

typedef LocaleChangedCallback = Future Function(Locale locale);

Locale localeFromString(String code, {bool languageCodeOnly = false}) {
  if (code.contains('_')) {
    var parts = code.split('_');

    return languageCodeOnly ? Locale(parts[0]) : Locale(parts[0], parts[1]);
  } else {
    return Locale(code);
  }
}

String localeToString(Locale locale) {
  return locale.countryCode != null
      ? '${locale.languageCode}_${locale.countryCode}'
      : locale.languageCode;
}

/// Translate the selected key into the currently selected locale
String translate(String key, {Map<String, dynamic>? args}) {
  return Localization.instance.translate(key, args: args);
}

/// Translate the selected key into the currently selected locale using pluralization
String translatePlural(String key, num value, {Map<String, dynamic>? args}) {
  return Localization.instance.plural(key, value, args: args);
}

/// Translate the selected key into the currently selected locale returning a list of strings
List<String> translateList(String key, {Map<String, dynamic>? args}) {
  return Localization.instance.list(key, args: args);
}

/// Change the currently selected locale
Future changeLocale(BuildContext context, String? localeCode) async {
  if (localeCode != null) {
    await LocalizedApp.of(context)
        .delegate
        .changeLocale(localeFromString(localeCode));

    LocalizationProvider.of(context).state.onLocaleChanged();
  }
}
