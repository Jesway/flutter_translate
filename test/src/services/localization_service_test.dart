import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/services/loaders/base/localization_loader.dart';
import 'package:flutter_translate/src/services/localization_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'localization_service_test.mocks.dart';

@GenerateMocks([LocalizationLoader, FlutterTranslateOptions])
void main() {
  group('LocalizationService Tests', () {
    late LocalizationService localizationService;
    late MockLocalizationLoader mockLoader;
    late MockFlutterTranslateOptions mockOptions;

    setUp(() {
      mockLoader = MockLocalizationLoader();
      mockOptions = MockFlutterTranslateOptions();
      localizationService = LocalizationService(mockLoader, mockOptions);
    });

    test('containsLocale should check if the locale is available', () {
      final locale = Locale('en', 'US');
      expect(localizationService.containsLocale(locale), isFalse);
    });

    test('loadLocaleData should invoke loader and add data to localizations', () async {
      final locale = Locale('en', 'US');
      final Map<String, dynamic> localeData = {'hello': 'Hello'};

      when(mockLoader.load(locale)).thenAnswer((_) async => localeData);

      await localizationService.loadLocaleData(locale);

      expect(localizationService.containsLocale(locale), isTrue);
    });

    // TODO: can't test because _loadLocaleData is a private method. SUGGESTION: make public
    /*
    group('_loadLocaleData Tests', () {
      test('_loadLocaleData should fetch data for a given locale', () async {
        final locale = Locale('en', 'US');
        final Map<String, dynamic> localeData = {'hello': 'Hello'};

        when(mockLoader.load(locale)).thenAnswer((_) async => localeData);

        final data = await localizationService._loadLocaleData(locale);

        expect(data, isNotNull);
        expect(data, equals(localeData));
      });
    });
    */

    // TODO: can't test because _addLocalization is a private method. SUGGESTION: make public
    /*
    group('_addLocalization Tests', () {
      test('_addLocalization should add localization data for a locale', () {
        final locale = Locale('en', 'US');
        final Map<String, dynamic> localeData = {'hello': 'Hello'};

        localizationService._addLocalization(locale, localeData);

        expect(localizationService.containsLocale(locale), isTrue);
      });
    });
    */

    // TODO: can't test because _getLocalizationData is a private method. SUGGESTION: make public
    /*
    group('_getLocalizationData Tests', () {
      test('_getLocalizationData should return localization data for a locale', () {
        final locale = Locale('en', 'US');
        final Map<String, dynamic> localeData = {'hello': 'Hello'};

        localizationService._addLocalization(locale, localeData);

        final data = localizationService._getLocalizationData(locale);

        expect(data, isNotNull);
        expect(data, equals(localeData));
      });
    });
    */
  });
}
