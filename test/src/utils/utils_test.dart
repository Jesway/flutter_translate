
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';

void main() {
  group('Localization Functions Tests', () {
    group('localeFromString', () {
      test('should return a locale with only language code when languageCodeOnly is true', () {
        final locale = localeFromString('en_US', languageCodeOnly: true);
        expect(locale, Locale('en'));
      });

      test('should return a locale with language code and country code when languageCodeOnly is false', () {
        final locale = localeFromString('en_US');
        expect(locale, Locale('en', 'US'));
      });

      test('should return a locale with only language code when code does not contain country code', () {
        final locale = localeFromString('en');
        expect(locale, Locale('en'));
      });
    });

    group('localeToString', () {
      test('should return a string with language code and country code', () {
        final string = localeToString(Locale('en', 'US'));
        expect(string, 'en_US');
      });

      test('should return a string with only language code when country code is null', () {
        final string = localeToString(Locale('en'));
        expect(string, 'en');
      });
    });

    //TODO can't test because of static method SUGGESTION use dependency injection
    group('translate', () {
      // Test cases for translate function
      /*
      test('should translate key to localized string', () {
        // Implementation of test case
      });
      */
    });

    //TODO can't test because of static method SUGGESTION use dependency injection
    group('translatePlural', () {
      // Test cases for translatePlural function
      /*
      test('should translate plural key to localized string', () {
        // Implementation of test case
      });
      */
    });

    //TODO can't test because of static method SUGGESTION use dependency injection
    group('changeLocale', () {
      // Test cases for changeLocale function
      /*
      test('should change the locale', () async {
        // Implementation of test case
      });
      */
    });

    //TODO can't test because of static method SUGGESTION use dependency injection
    group('getValueAtKeyPath', () {
      // Test cases for getValueAtKeyPath function
      /*
      test('should get value at key path', () {
        // Implementation of test case
      });
      */
    });
  });
}
