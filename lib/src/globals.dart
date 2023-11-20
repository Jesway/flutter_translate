import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/utils/utils.dart';

/// Translate the selected key into the currently selected locale
String translate(String key, {Map<String, dynamic>? args})
{
	return FlutterTranslate.instance.translate(key, args: args);
}

/// Translate the selected key into the currently selected locale using pluralization
String translatePlural(String key, num value, {Map<String, dynamic>? args})
{
	return FlutterTranslate.instance.plural(key, value, args: args);
}

/// Change the currently selected locale
Future changeLocale(BuildContext context, String localeCode) async
{
	final newLocale = localeFromString(localeCode);
	
	await FlutterTranslate.instance.changeLocale(newLocale);

	if (context.mounted)
	{
  		LocalizedApp.of(context).refresh();
	}
}