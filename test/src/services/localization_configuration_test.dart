import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/constants/constants.dart';
import 'package:flutter_translate/src/services/locale_file_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/src/services/localization_configuration.dart';
import 'package:mockito/mockito.dart';

class MockLocaleFileService extends Mock implements LocaleFileService {}

void main() {
  group('LocalizationConfiguration', () {

    // TODO cant test static method DI so it can be replaced
    // group('create', () {
    //   test('should return a new LocalizationConfiguration instance', () async {
    //     final String fallbackLanguage = 'en';
    //     final List<String> supportedLanguages = ['en', 'es'];
    //     final String basePath = Constants.localizedAssetsPath;
    //     final Map<String, String> files = {
    //       'en': '$basePath/en.json',
    //       'es': '$basePath/es.json',
    //     };

    //     // Assuming LocaleFileService.getLocaleFiles is now an instance method
    //     final mockLocaleFileService = MockLocaleFileService();
    //     when(LocaleFileService.getLocaleFiles(supportedLanguages, basePath))
    //         .thenAnswer((_) async => files);

    //     final configuration = await LocalizationConfiguration.create(
    //         fallbackLanguage, supportedLanguages,
    //         basePath: basePath);

    //     expect(configuration, isA<LocalizationConfiguration>());
    //     expect(configuration.localizations, isNotNull);
    //     expect(configuration.localizations!.keys,
    //         containsAll([Locale('en'), Locale('es')]));
    //     expect(configuration.localizations![Locale('en')],
    //         equals('$basePath/en.json'));
    //   });
    // });

    // TODO cant test private method
    // group('_validateConfiguration', () {
    //   test('should throw an exception if fallback language is not in supported languages', () {
    //     final String fallbackLanguage = 'fr';
    //     final List<String> supportedLanguages = ['en', 'es'];

    //     expect(
    //         () => LocalizationConfiguration._validateConfiguration(
    //             fallbackLanguage, supportedLanguages),
    //         throwsA(isA<Exception>()));
    //   });
    // });

    // TODO cant test private method
    // group('_generateSupportedLocales', () {
    //   test('should generate a list of Locale from supported languages', () {
    //     final List<String> supportedLanguages = ['en', 'es'];
    //     final locales = LocalizationConfiguration._generateSupportedLocales(supportedLanguages);

    //     expect(locales, isA<List<Locale>>());
    //     expect(locales.length, equals(supportedLanguages.length));
    //     expect(locales, containsAll([Locale('en'), Locale('es')]));
    //   });
    // });

    // TODO cant test private method
    // group('_getLocalizedEntry', () {
    //   test('should return a MapEntry with a Locale and a file path', () {
    //     final String languageCode = 'en';
    //     final String file = 'path/to/en.json';

    //     final entry = LocalizationConfiguration._getLocalizedEntry(languageCode, file);

    //     expect(entry, isA<MapEntry<Locale, String>>());
    //     expect(entry.key, equals(Locale('en')));
    //     expect(entry.value, equals(file));
    //   });

    //   test('should handle language codes with country code', () {
    //     final String languageCode = 'en_US';
    //     final String file = 'path/to/en_US.json';

    //     final entry = LocalizationConfiguration._getLocalizedEntry(languageCode, file);

    //     expect(entry.key, equals(Locale('en', 'US')));
    //     expect(entry.value, equals(file));
    //   });
    // });
  });
}
