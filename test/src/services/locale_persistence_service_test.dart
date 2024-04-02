import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/src/extensions/string_extensions.dart';
import 'package:flutter_translate/src/services/locale_persistence_service.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([SharedPreferences])
void main() {
  group('LocalePersistenceService', () {
    late LocalePersistenceService localePersistenceService;
    late SharedPreferences sharedPreferences;

    setUp(() async {
      // Initialize SharedPreferences with empty values
      SharedPreferences.setMockInitialValues({});
      // Directly obtain the instance, which now uses the mock initial values
      sharedPreferences = await SharedPreferences.getInstance();
      // Initialize your service with the mocked SharedPreferences instance
      localePersistenceService = LocalePersistenceService();
    });

    test('getPreferredLocale should return null when no locale is set', () async {
      final locale = await localePersistenceService.getPreferredLocale();
      expect(locale, isNull);
    });

    test('getPreferredLocale should return Locale when locale is set', () async {
      await sharedPreferences.setString('selected_locale', 'en_US');
      final locale = await localePersistenceService.getPreferredLocale();
      expect(locale, isNotNull);
      expect(locale!.languageCode, 'en');
      expect(locale.countryCode, 'US');
    });

    test('savePreferredLocale should save the locale to SharedPreferences', () async {
      final locale = Locale('en', 'US');
      await localePersistenceService.savePreferredLocale(locale);
      final savedLocaleString = sharedPreferences.getString('selected_locale');
      expect(savedLocaleString, locale.toString());
    });
  });
}
