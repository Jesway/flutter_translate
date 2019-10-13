import 'localization.dart';

String translate(String key, {Map<String, dynamic> args})
{
	return Localization.instance.translate(key, args: args);
}
