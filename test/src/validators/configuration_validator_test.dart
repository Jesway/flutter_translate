
import 'package:flutter_test/flutter_test.dart';
import 'dart:ui';

void main() {
  group('ConfigurationValidator Tests', () {
    //TODO can't test because of static method SUGGESTION use dependency injection
    group('validate', () {
      // Test cases for validate method
      /*
      test('should not throw an exception when fallbackLocale is in the list of supportedLocales', () {
        final Locale fallbackLocale = Locale('en', 'US');
        final List<Locale> supportedLocales = [Locale('en', 'US'), Locale('fr', 'FR')];

        expect(() => ConfigurationValidator.validate(fallbackLocale, supportedLocales), returnsNormally);
      });

      test('should throw an exception when fallbackLocale is not in the list of supportedLocales', () {
        final Locale fallbackLocale = Locale('it', 'IT');
        final List<Locale> supportedLocales = [Locale('en', 'US'), Locale('fr', 'FR')];

        expect(() => ConfigurationValidator.validate(fallbackLocale, supportedLocales), throwsException);
      });
      */
    });
  });
}
