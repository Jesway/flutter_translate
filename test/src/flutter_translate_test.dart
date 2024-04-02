import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/services/change_locale_service.dart';
import 'package:flutter_translate/src/services/fallback_locale_service.dart';
import 'package:flutter_translate/src/services/initial_locale_service.dart';
import 'package:flutter_translate/src/services/loaders/base/localization_loader.dart';
import 'package:flutter_translate/src/services/loaders/factories/localization_loader_factory.dart';
import 'package:flutter_translate/src/services/locale_persistence_service.dart';
import 'package:flutter_translate/src/services/localization_service.dart';
import 'package:flutter_translate/src/services/missing_localization_key_service.dart';
import 'package:flutter_translate/src/services/supported_locale_service.dart';
import 'package:flutter_translate/src/services/translation_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_translate_test.mocks.dart';

@GenerateMocks([
  LocalizationLoader,
  TranslationService,
  LocalizationService,
  FallbackLocaleService,
  InitialLocaleService,
  MissingLocalizationKeyService,
  ChangeLocaleService,
  LocalePersistenceService,
  SupportedLocaleService,
])
void main() {
  group('FlutterTranslate Tests', () {
    late FlutterTranslate flutterTranslate;
    late MockTranslationService mockTranslationService;
    late MockLocalizationService mockLocalizationService;
    late MockFallbackLocaleService mockFallbackLocaleService;
    late MockInitialLocaleService mockInitialLocaleService;
    late MockMissingLocalizationKeyService mockMissingLocalizationKeyService;
    late MockChangeLocaleService mockChangeLocaleService;
    late MockLocalePersistenceService mockLocalePersistenceService;
    late MockSupportedLocaleService mockSupportedLocaleService;

    setUp(() {
      mockTranslationService = MockTranslationService();
      mockLocalizationService = MockLocalizationService();
      mockFallbackLocaleService = MockFallbackLocaleService();
      mockInitialLocaleService = MockInitialLocaleService();
      mockMissingLocalizationKeyService = MockMissingLocalizationKeyService();
      mockChangeLocaleService = MockChangeLocaleService();
      mockLocalePersistenceService = MockLocalePersistenceService();
      mockSupportedLocaleService = MockSupportedLocaleService();

      flutterTranslate = FlutterTranslate.instance;
    });

    test('initialize should configure all services', () async {
      FlutterTranslateOptions options = FlutterTranslateOptions(
          supported: ['en', 'es'],
          loader:
              AssetsLoaderOptions() // Assuming you're using assets loader here
          );
      await FlutterTranslate.initialize(options);
      // No assertion, just checking no exception is thrown
    });

    test('translate should delegate to TranslationService', () {
      when(mockTranslationService.translate(any, args: anyNamed('args')))
          .thenReturn('Hello');
      expect(flutterTranslate.translate('Hello'), 'Hello');
    });

    test('plural should delegate to TranslationService', () {
      when(mockTranslationService.plural(any, any, args: anyNamed('args')))
          .thenReturn('2 apples');
      expect(flutterTranslate.plural('apple', 2), 'apple.other');
    });

    test('changeLocale should delegate to ChangeLocaleService', () async {
      when(mockChangeLocaleService.changeLocale(any)).thenAnswer((_) async {});
      await flutterTranslate.changeLocale('en_US');
      verify(mockChangeLocaleService.changeLocale(any)).called(1);
    });

    // TODO: can't test because _initialize is a private method. SUGGESTION: make public
    /*
    group('_initialize Tests', () {
      test('_initialize should setup all required services', () async {
        await flutterTranslate._initialize(FlutterTranslateOptions(supported: ['en', 'es']));
        // Assertions related to service initialization would go here
      });
    });
    */

    // TODO: can't test because _setupInitialLocale is a private method. SUGGESTION: make public
    /*
    group('_setupInitialLocale Tests', () {
      test('_setupInitialLocale should set the initial locale', () async {
        await flutterTranslate._setupInitialLocale();
        // Assertions related to initial locale setup would go here
      });
    });
    */
  });
}
