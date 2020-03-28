import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'localization.dart';
import 'localization_provider.dart';
import 'localized_app.dart';

typedef LocaleChangedCallback = Future Function(Locale locale);

Locale localeFromString(String code, {bool languageCodeOnly = false})
{
	if (code.contains('_'))
	{
		var parts = code.split('_');

		return languageCodeOnly ? Locale(parts[0]) : Locale(parts[0], parts[1]);
	}
	else
	{
		return Locale(code);
	}
}

String localeToString(Locale locale)
{
	return locale.countryCode != null ? '${locale.languageCode}_${locale.countryCode}' : locale.languageCode;
}

String translate(String key, {Map<String, dynamic> args})
{
	return Localization.instance.translate(key, args: args);
}

String translatePlural(String key, num value, {Map<String, dynamic> args})
{
	return Localization.instance.plural(key, value, args: args);
}

void changeLocale(BuildContext context, String localeCode) async
{
	if (localeCode != null)
	{
		await LocalizedApp.of(context).delegate.changeLocale(localeFromString(localeCode));

		LocalizationProvider.of(context).state.onLocaleChanged();
	}
}
