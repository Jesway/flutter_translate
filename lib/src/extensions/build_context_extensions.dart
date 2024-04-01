import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';

extension BuildContextExtensions on BuildContext {
  Locale get locale => FlutterTranslate.instance.currentLocale;

  List<Locale> get supportedLocales =>
      FlutterTranslate.instance.supportedLocales;

  List<LocalizationsDelegate> get localizationDelegates =>
      LocalizedApp.of(this).delegates;
}
