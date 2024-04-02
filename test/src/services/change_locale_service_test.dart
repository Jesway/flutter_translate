import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/src/contexts/localization_context.dart';
import 'package:flutter_translate/src/models/locale_data.dart';
import 'package:flutter_translate/src/services/change_locale_service.dart';
import 'package:flutter_translate/src/services/fallback_locale_service.dart';
import 'package:flutter_translate/src/services/localization_service.dart';
import 'package:flutter_translate/src/services/supported_locale_service.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_locale_service_test.mocks.dart';

@GenerateMocks([
  LocalizationService,
  FallbackLocaleService,
  SupportedLocaleService,
  LocalizationContext,
])
void main() {
  group('ChangeLocaleService', () {
    late MockLocalizationService mockLocalizationService;
    late MockFallbackLocaleService mockFallbackLocaleService;
    late MockSupportedLocaleService mockSupportedLocaleService;
    late MockLocalizationContext mockLocalizationContext;
    late ChangeLocaleService changeLocaleService;

    setUp(() {
      mockLocalizationService = MockLocalizationService();
      mockFallbackLocaleService = MockFallbackLocaleService();
      mockSupportedLocaleService = MockSupportedLocaleService();
      mockLocalizationContext = MockLocalizationContext();
      changeLocaleService = ChangeLocaleService(
        mockLocalizationService,
        mockFallbackLocaleService,
        mockSupportedLocaleService,
        mockLocalizationContext,
      );

      // Stub the update method to do nothing
      when(mockLocalizationContext.update(any)).thenReturn(null);
    });

    test('changeLocale should update the context with new locale data', () async {
      final locale = Locale('en', 'US');
      final localeData = LocaleData(locale, {});
      when(mockSupportedLocaleService.getSupportedLocale(any))
          .thenReturn(locale);
      when(mockLocalizationService.loadLocaleData(any))
          .thenAnswer((_) async => {});
      when(mockFallbackLocaleService.getFallbackLocaleData())
          .thenAnswer((_) async => localeData);

      await changeLocaleService.changeLocale(locale);

      verify(mockLocalizationContext.update(any)).called(1);
      expect(Intl.defaultLocale, locale.toString());
    });

    // TODO: can't test getNewLocaleData because of private method. SUGGESTION: make public
    /*
    test('getNewLocaleData should return locale data for supported locale', () async {
      final locale = Locale('en', 'US');
      final localeData = LocaleData(locale, {});
      when(mockLocalizationService.loadLocaleData(locale))
          .thenAnswer((_) async => localeData.localizations);

      final result = await changeLocaleService.getNewLocaleData(locale);

      expect(result, isNotNull);
      expect(result!.locale, equals(locale));
      expect(result.localizations, equals(localeData.localizations));
    });
    */
  });
}
