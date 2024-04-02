import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/services/fallback_locale_service.dart';
import 'package:flutter_translate/src/services/missing_localization_key_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'missing_localization_key_service_test.mocks.dart';

@GenerateMocks([FallbackLocaleService, FlutterTranslateOptions])
void main() {
  group('MissingLocalizationKeyService', () {
    late MockFallbackLocaleService mockFallbackLocaleService;
    late MockFlutterTranslateOptions mockOptions;
    late MissingLocalizationKeyService missingLocalizationKeyService;

    setUp(() {
      mockFallbackLocaleService = MockFallbackLocaleService();
      mockOptions = MockFlutterTranslateOptions();
      missingLocalizationKeyService = MissingLocalizationKeyService(mockFallbackLocaleService, mockOptions);
    });

    test('initialize should load fallback data when strategy is fallback', () async {
      when(mockOptions.missingKeyStrategy).thenReturn(MissingKeyStrategy.fallback);
      when(mockFallbackLocaleService.loadFallbackLocaleData()).thenAnswer((_) async => {});

      await missingLocalizationKeyService.initialize();

      verify(mockFallbackLocaleService.loadFallbackLocaleData()).called(1);
    });

    test('initialize should not load fallback data when strategy is not fallback', () async {
      when(mockOptions.missingKeyStrategy).thenReturn(MissingKeyStrategy.key);

      await missingLocalizationKeyService.initialize();

      verifyNever(mockFallbackLocaleService.loadFallbackLocaleData());
    });
  });
}
