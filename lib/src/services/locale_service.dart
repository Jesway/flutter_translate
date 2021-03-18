import 'dart:convert';
import 'dart:ui';
import 'package:flutter_translate/flutter_translate.dart';

import 'locale_file_service.dart';

class LocaleService
{
    static Future<Map<Locale, String>> getLocalesMap(List<String> locales, String basePath) async
    {
        var files = await LocaleFileService.getLocaleFiles(locales, basePath);

        return files.map((x,y) => MapEntry(localeFromString(x), y));
    }

    static Locale findLocale(Locale locale, List<Locale> supportedLocales)
    {
        var existing = supportedLocales.firstWhere((x) => x == locale, orElse: () => null);

        if(existing == null)
        {
            existing = supportedLocales.firstWhere((x) => x.languageCode == locale.languageCode, orElse: () => null);
        }

        return existing;
    }

    static Future<Map<String, dynamic>> getLocaleContent(Locale locale, Map<Locale, String> supportedLocales) async
    {
        var file = supportedLocales[locale];

        var content = await LocaleFileService.getLocaleContent(file);

        return json.decode(content);
    }


}
