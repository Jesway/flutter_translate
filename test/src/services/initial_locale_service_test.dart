import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/services/fallback_locale_service.dart';
import 'package:flutter_translate/src/services/initial_locale_service.dart';
import 'package:flutter_translate/src/services/locale_persistence_service.dart';
import 'package:flutter_translate/src/services/localization_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'initial_locale_service_test.mocks.dart';

@GenerateMocks([
  LocalizationService,
  FallbackLocaleService,
  LocalePersistenceService,
  FlutterTranslateOptions,
])
void main() {
  group('InitialLocaleService', () {
    late MockLocalizationService mockLocalizationService;
    late MockFallbackLocaleService mockFallbackLocaleService;
    late MockLocalePersistenceService mockLocalePersistenceService;
    late MockFlutterTranslateOptions mockOptions;
    late InitialLocaleService initialLocaleService;

    setUp(() {
      mockLocalizationService = MockLocalizationService();
      mockFallbackLocaleService = MockFallbackLocaleService();
      mockLocalePersistenceService = MockLocalePersistenceService();
      mockOptions = MockFlutterTranslateOptions();
      initialLocaleService = InitialLocaleService(
        mockLocalizationService,
        mockFallbackLocaleService,
        mockLocalePersistenceService,
        mockOptions,
      );

      // Stub the initialLocale getter to return null
      when(mockOptions.initialLocale).thenReturn(null);
    });

    test('getInitialLocale should return the correct locale', () async {
      when(mockOptions.autoSave).thenReturn(true);
      when(mockLocalePersistenceService.getPreferredLocale())
          .thenAnswer((_) async => Locale('en', 'US'));
      when(mockLocalizationService.loadLocaleData(any))
          .thenAnswer((_) async => {});

      final locale = await initialLocaleService.getInitialLocale();

      expect(locale, isNotNull);
      expect(locale.languageCode, equals('en'));
      expect(locale.countryCode, equals('US'));
    });

    test('getInitialLocale should fall back when no data is available', () async {
      final fallbackLocale = Locale('fr', 'CA');
      when(mockOptions.autoSave).thenReturn(false);
      when(mockOptions.fallbackLocale).thenReturn(fallbackLocale);
      when(mockLocalizationService.loadLocaleData(any))
          .thenAnswer((_) async => null);
      when(mockFallbackLocaleService.loadFallbackLocaleData())
          .thenAnswer((_) async => {});

      final locale = await initialLocaleService.getInitialLocale();

      expect(locale, fallbackLocale);
    });

    // TODO: can't test _getInitialLocale because of private method. SUGGESTION: make public
    /*
    test('_getInitialLocale should return the correct initial locale', () async {
      when(mockOptions.autoSave).thenReturn(true);
      when(mockLocalePersistenceService.getPreferredLocale())
          .thenAnswer((_) async => Locale('en', 'US'));

      final locale = await initialLocaleService._getInitialLocale();

      expect(locale, isNotNull);
      expect(locale.languageCode, equals('en'));
      expect(locale.countryCode, equals('US'));
    });
    */
  });
}
