import 'package:flutter/widgets.dart';

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