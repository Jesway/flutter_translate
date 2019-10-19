import 'dart:ui';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslatePreferences implements ITranslatePreferences
{
    static const String _selectedLocaleKey = 'selected_locale';

    @override
    Future<Locale> getPreferredLocale() async
    {
        final preferences = await SharedPreferences.getInstance();

        if(!preferences.containsKey(_selectedLocaleKey)) return null;

        var locale = preferences.getString(_selectedLocaleKey);

        return localeFromString(locale);
    }

    @override
    Future savePreferredLocale(Locale locale) async
    {
        final preferences = await SharedPreferences.getInstance();

        await preferences.setString(_selectedLocaleKey, localeToString(locale));
    }
}
