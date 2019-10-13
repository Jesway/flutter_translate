import 'package:flutter/cupertino.dart';
import 'localization.dart';
import 'localization_provider.dart';
import 'localized_app.dart';

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

String translate(String key, {Map<String, dynamic> args})
{
	return Localization.instance.translate(key, args: args);
}

String translatePlural(String key, num value, {Map<String, dynamic> args})
{
	return Localization.instance.plural(key, value, args: args);
}

void changeLanguage(BuildContext context, String localeCode)
{
	if (localeCode != null)
	{
		LocalizedApp.of(context).delegate.changeLanguage(localeFromString(localeCode));

		LocalizationProvider.of(context).state.onLanguageChanged();
	}
}
