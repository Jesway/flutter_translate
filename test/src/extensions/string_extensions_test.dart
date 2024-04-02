import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/src/extensions/string_extensions.dart';

void main() {
  group('StringLocaleExtensions', () {
    test('toLocale should convert string without underscore to locale', () {
      const localeString = 'en';
      final locale = localeString.toLocale();
      expect(locale, isA<Locale>());
      expect(locale.languageCode, equals('en'));
    });

    test('toLocale should convert string with underscore to locale with country code', () {
      const localeString = 'en_US';
      final locale = localeString.toLocale();
      expect(locale, isA<Locale>());
      expect(locale.languageCode, equals('en'));
      expect(locale.countryCode, equals('US'));
    });
  });
}
