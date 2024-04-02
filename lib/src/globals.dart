import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';

/// Translate the selected key into the currently selected locale
String translate(String key, {Map<String, dynamic>? args}) {
  return FlutterTranslate.instance.translate(key, args: args);
}

/// Translate the selected key into the currently selected locale using pluralization
String translatePlural(String key, num value, {Map<String, dynamic>? args}) {
  return FlutterTranslate.instance.plural(key, value, args: args);
}

dynamic getValueAtKeyPath(String keyPath){
  return FlutterTranslate.instance.getValueAtKeyPath(keyPath);
}
/// Change the currently selected locale
Future changeLocale(BuildContext context, String locale) async {
  await FlutterTranslate.instance.changeLocale(locale);

  if (context.mounted) {
    LocalizedApp.of(context).refresh();
  }
}
