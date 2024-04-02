import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/services/supported_locale_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'supported_locale_service_test.mocks.dart';

@GenerateMocks([FlutterTranslateOptions])
void main() {
  group('SupportedLocaleService', () {
    late MockFlutterTranslateOptions mockOptions;
    late SupportedLocaleService supportedLocaleService;

    setUp(() {
      mockOptions = MockFlutterTranslateOptions();
      supportedLocaleService = SupportedLocaleService(mockOptions);
    });

    test('getSupportedLocale returns exact match if available', () {
      final locale = Locale('en', 'US');
      final supportedLocales = [Locale('en', 'US'), Locale('es', 'ES')];
      final fallbackLocale = Locale('es', 'ES');

      when(mockOptions.supportedLocales).thenReturn(supportedLocales);
      when(mockOptions.fallbackLocale).thenReturn(fallbackLocale);

      final result = supportedLocaleService.getSupportedLocale(locale);
      expect(result, equals(locale));
    });

    test('getSupportedLocale returns locale with matching language code if exact match not found', () {
      final locale = Locale('en', 'GB');
      final supportedLocales = [Locale('en', 'US'), Locale('es', 'ES')];
      final fallbackLocale = Locale('es', 'ES');

      when(mockOptions.supportedLocales).thenReturn(supportedLocales);
      when(mockOptions.fallbackLocale).thenReturn(fallbackLocale);

      final result = supportedLocaleService.getSupportedLocale(locale);
      expect(result.languageCode, equals('en'));
      expect(result.countryCode, equals('US'));
    });

    test('getSupportedLocale returns fallback locale if no match is found', () {
      final locale = Locale('fr', 'FR');
      final supportedLocales = [Locale('en', 'US'), Locale('es', 'ES')];
      final fallbackLocale = Locale('es', 'ES');

      when(mockOptions.supportedLocales).thenReturn(supportedLocales);
      when(mockOptions.fallbackLocale).thenReturn(fallbackLocale);

      final result = supportedLocaleService.getSupportedLocale(locale);
      expect(result, equals(fallbackLocale));
    });
  });
}
