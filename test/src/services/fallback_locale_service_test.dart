import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/models/locale_data.dart';
import 'package:flutter_translate/src/services/fallback_locale_service.dart';
import 'package:flutter_translate/src/services/localization_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Make sure to use the generated mocks correctly if needed.
import 'fallback_locale_service_test.mocks.dart';

@GenerateMocks([LocalizationService, FlutterTranslateOptions])
void main() {
  group('FallbackLocaleService', () {
    late FallbackLocaleService fallbackLocaleService;
    late MockLocalizationService mockLocalizationService;
    late MockFlutterTranslateOptions mockOptions;

    setUp(() {
      mockLocalizationService = MockLocalizationService();
      mockOptions = MockFlutterTranslateOptions();
      when(mockOptions.fallbackLocale).thenReturn(const Locale('en', 'US'));
      fallbackLocaleService = FallbackLocaleService(mockLocalizationService, mockOptions);
    });

    test('getFallbackLocaleData should return LocaleData with expected data', () async {
      final Map<String, dynamic> mockData = {'hello': 'Hello'};
      when(mockLocalizationService.loadLocaleData(any)).thenAnswer((_) async => mockData);

      final localeData = await fallbackLocaleService.getFallbackLocaleData();
      expect(localeData, isA<LocaleData>());
      expect(localeData.locale, const Locale('en', 'US'));
      expect(localeData.localizations, mockData);
    });

    // TODO: Uncomment and adjust once the method is public or accessible for testing.
    // test('loadFallbackLocaleData should return expected data', () async {
    //   final Map<String, dynamic> mockData = {'hello': 'Hello'};
    //   when(mockLocalizationService.loadLocaleData(any)).thenAnswer((_) async => mockData);
    //   final data = await fallbackLocaleService.loadFallbackLocaleData();
    //   expect(data, mockData);
    // });

    test('loadFallbackLocaleData should throw an exception if data is null', () {
      when(mockLocalizationService.loadLocaleData(any)).thenAnswer((_) async => null);
      expect(fallbackLocaleService.loadFallbackLocaleData(), throwsA(isA<Exception>()));
    });
  });
}
