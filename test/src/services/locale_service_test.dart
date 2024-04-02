
import 'dart:convert';
import 'dart:ui';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/services/locale_file_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/src/services/locale_service.dart';
import 'package:mockito/mockito.dart';

class MockLocaleFileService extends Mock implements LocaleFileService {}
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LocaleService', () {
    // TODO cant test uses a staitc method
    // group('getLocalesMap', () {
    //   test('should return a map of Locales to file paths', () async {
    //     final String basePath = 'assets/i18n';
    //     final List<String> locales = ['en', 'es'];
    //     final Map<String, String> files = {
    //       'en': '$basePath/en.json',
    //       'es': '$basePath/es.json'
    //     };

    //     when(LocaleFileService.getLocaleFiles(locales, basePath))
    //         .thenAnswer((_) async => files);

    //     final localesMap = await LocaleService.getLocalesMap(locales, basePath);

    //     expect(localesMap, isA<Map<Locale, String>>());
    //     expect(localesMap.keys, containsAll([Locale('en'), Locale('es')]));
    //     expect(localesMap[Locale('en')], equals('$basePath/en.json'));
    //     expect(localesMap[Locale('es')], equals('$basePath/es.json'));
    //   });
    // });

    group('findLocale', () {
      test('should return the correct Locale object when the locale exists', () {
        final Locale locale = Locale('en');
        final List<Locale> supportedLocales = [Locale('en'), Locale('es')];

        final result = LocaleService.findLocale(locale, supportedLocales);

        expect(result, equals(locale));
      });

      test('should return null when the locale does not exist', () {
        final Locale locale = Locale('fr');
        final List<Locale> supportedLocales = [Locale('en'), Locale('es')];

        final result = LocaleService.findLocale(locale, supportedLocales);

        expect(result, isNull);
      });
    });

    // TODO cant test because LocaleFileService.getLocaleContent(filePath) is static refactor
    // group('getLocaleContent', () {
    //   test('should return the correct content for the locale', () async {
    //     final Locale locale = Locale('en');
    //     final String filePath = 'assets/i18n/en.json';
    //     final String fileContent = '{"hello": "Hello"}';
    //     final Map<Locale, String> supportedLocales = {locale: filePath};

    //     when(LocaleFileService.getLocaleContent(filePath))
    //         .thenAnswer((_) async => fileContent);

    //     final content = await LocaleService.getLocaleContent(locale, supportedLocales);

    //     expect(content, isA<Map<String, dynamic>>());
    //     expect(content, equals({"hello": "Hello"}));
    //   });

    //   test('should return an empty map if the file content is null', () async {
    //     final Locale locale = Locale('en');
    //     final String filePath = 'assets/i18n/en.json';
    //     final Map<Locale, String> supportedLocales = {locale: filePath};

    //     when(LocaleFileService.getLocaleContent(filePath)).thenAnswer((_) async => null);

    //     final content = await LocaleService.getLocaleContent(locale, supportedLocales);

    //     expect(content, isA<Map<String, dynamic>>());
    //     expect(content, isEmpty);
    //   });
    // });
  });
}

