import 'dart:convert';
import 'dart:ui';
import 'locale_file_service.dart';
import 'global.dart';

class LocaleService {
  static Future<Map<Locale, String>?> getLocalesMap(List<String>? locales, String? basePath) async {
    final Map<String?, String?>? files = await LocaleFileService.getLocaleFiles(locales!, basePath);

    return files!.map((String? x, String? y) => MapEntry(localeFromString(x)!, y!));
  }

  static Locale? findLocale(Locale? locale, List<Locale>? supportedLocales) {
    Locale existing = supportedLocales!.firstWhere((Locale? x) => x == locale!, orElse: () => null!);

    if (existing == null) {
      existing =
          supportedLocales.firstWhere((Locale? x) => x!.languageCode == locale!.languageCode, orElse: () => null!);
    }

    return existing;
  }

  static Future<Map<String?, dynamic>?> getLocaleContent(Locale? locale, Map<Locale?, String?> supportedLocales) async {
    final String? file = supportedLocales[locale];

    final String? content = await LocaleFileService.getLocaleContent(file);

    return json.decode(content!) as Map<String?, dynamic>?;
  }
}
