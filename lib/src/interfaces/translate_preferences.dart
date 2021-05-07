import 'dart:ui';

abstract class ITranslatePreferences
{
    Future savePreferredLocale(Locale locale);

  Future<Locale?> getPreferredLocale();
}
