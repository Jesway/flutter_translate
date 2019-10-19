import 'package:flutter/cupertino.dart';

abstract class ITranslatePreferences
{
    Future savePreferredLocale(Locale locale);

    Future<Locale> getPreferredLocale();
}
