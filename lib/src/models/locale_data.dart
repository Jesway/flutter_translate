import 'package:flutter/widgets.dart';
import 'package:flutter_translate/src/constants/constants.dart';

class LocaleData
{
    Locale locale = const Locale(Constants.undefinedLocale);

    Map<String, dynamic> localizations = {};

    Map<String, dynamic>? fallbackLocalizations = {};

    LocaleData(this.locale, this.localizations, {this.fallbackLocalizations});

    LocaleData.undefined();
}