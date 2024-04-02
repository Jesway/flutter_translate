import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/src/constants/constants.dart';
import 'package:flutter_translate/src/models/locale_data.dart';

void main() {
  group('LocaleData', () {
    test('should create instance with provided locale and localizations', () {
      final locale = Locale('en', 'US');
      final localizations = {'hello': 'Hello'};
      final fallbackLocalizations = {'hello': 'Hello, fallback'};

      final localeData = LocaleData(locale, localizations, fallbackLocalizations: fallbackLocalizations);

      expect(localeData.locale, equals(locale));
      expect(localeData.localizations, equals(localizations));
      expect(localeData.fallbackLocalizations, equals(fallbackLocalizations));
    });

    test('should create undefined instance', () {
      final localeData = LocaleData.undefined();

      expect(localeData.locale, equals(Locale(Constants.undefinedLocale)));
      expect(localeData.localizations, isNotNull);
      expect(localeData.localizations, isEmpty);
      expect(localeData.fallbackLocalizations, equals({}));
    });
  });
}
