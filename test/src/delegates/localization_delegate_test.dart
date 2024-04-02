import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_translate/src/delegates/localization_delegate.dart';
import 'package:flutter_translate/src/services/locale_service.dart';

class MockLocaleService extends Mock implements LocaleService {}

class MockITranslatePreferences extends Mock implements ITranslatePreferences {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const String fallbackLocaleString = 'en_US';
  const List<String> supportedLocalesStrings = ['en_US', 'es_ES'];
  late LocalizationDelegate localizationDelegate;
  late MockITranslatePreferences mockPreferences;
  late Locale fallbackLocale;
  late List<Locale> supportedLocales;
  late Map<Locale, String> localesMap;

  setUp(() async {
    mockPreferences = MockITranslatePreferences();
    fallbackLocale = Locale('en', 'US');
    supportedLocales = List.generate(supportedLocalesStrings.length,
        (index) => Locale(supportedLocalesStrings[index]));

    localesMap = {
      Locale('en', 'US'): 'path/to/english.json',
      Locale('es', 'ES'): 'path/to/spanish.json',
    };

    localizationDelegate = await LocalizationDelegate.create(
      fallbackLocale: fallbackLocaleString,
      supportedLocales: supportedLocalesStrings,
      preferences: mockPreferences,
    );
  });

  // TODO cant test because LocaleService.getLocaleContent is static so it cant be mocked
  group('LocalizationDelegate', () {
    // group('load', () {
    //   test('should load the correct locale', () async {
    //     await localizationDelegate.load(Locale('es', 'ES'));
    //     expect(localizationDelegate.currentLocale, Locale('es', 'ES'));
    //   });

    //   test(
    //       'should not reload if the current locale is the same as the new locale',
    //       () async {
    //     await localizationDelegate.load(fallbackLocale);
    //     expect(localizationDelegate.currentLocale, fallbackLocale);
    //   });
    // });

    // group('isSupported', () {
    //   test('returns true for any locale', () {
    //     expect(localizationDelegate.isSupported(Locale('fr', 'FR')), isTrue);
    //   });
    // });

    // group('shouldReload', () {
    //   test('always returns true', () {
    //     expect(localizationDelegate.shouldReload(localizationDelegate), isTrue);
    //   });
    // });

    // group('changeLocale', () {
    //   test(
    //       'changes and persists the locale if it is different from the current',
    //       () async {
    //     await localizationDelegate.changeLocale(Locale('es', 'ES'));
    //     expect(localizationDelegate.currentLocale, Locale('es', 'ES'));
    //     verify(mockPreferences.savePreferredLocale(Locale('es', 'ES')))
    //         .called(1);
    //   });

    //   test('does not change the locale if it is the same as the current',
    //       () async {
    //     await localizationDelegate.changeLocale(fallbackLocale);
    //     expect(localizationDelegate.currentLocale, fallbackLocale);
    //     verifyNever(mockPreferences.savePreferredLocale(fallbackLocale));
    //   });

    //   test('defaults to fallback locale if the new locale is unsupported',
    //       () async {
    //     await localizationDelegate.changeLocale(Locale('fr', 'FR'));
    //     expect(localizationDelegate.currentLocale, fallbackLocale);
    //   });
    // });

    // group('create', () {
    //   test('successfully creates a LocalizationDelegate', () async {
    //     final delegate = await LocalizationDelegate.create(
    //       fallbackLocale: fallbackLocaleString,
    //       supportedLocales: supportedLocalesStrings,
    //       preferences: mockPreferences,
    //     );
    //     expect(delegate, isA<LocalizationDelegate>());
    //     expect(delegate.fallbackLocale, Locale('en', 'US'));
    //     expect(
    //         delegate.supportedLocales.length, supportedLocalesStrings.length);
    //   });
    // });

    // TODO cant test private method make public
    // group('_loadPreferences', () {
    //   test('sets the preferred locale if available', () async {
    //     when(mockPreferences.getPreferredLocale())
    //         .thenAnswer((_) async => Locale('es', 'ES'));
    //     bool result = await localizationDelegate._loadPreferences();
    //     expect(result, isTrue);
    //     expect(localizationDelegate.currentLocale, Locale('es', 'ES'));
    //   });

    //   test(
    //       'does not change the locale if the preferred locale is not available',
    //       () async {
    //     when(mockPreferences.getPreferredLocale())
    //         .thenAnswer((_) async => null);
    //     bool result = await localizationDelegate._loadPreferences();
    //     expect(result, isFalse);
    //     expect(localizationDelegate.currentLocale, fallbackLocale);
    //   });
    // });

    // group('_loadDeviceLocale', () {
    //   test('sets the locale based on device settings when preferred locale is not available', () async {
    //     // Mock the behavior of LocaleService.getCurrentLocale
    //     LocaleService.getCurrentLocale = () {
    //       return Locale('es', 'ES');
    //     };

    //     // Trigger the delegate creation which will invoke _loadDeviceLocale
    //     delegate = await LocalizationDelegate.create(
    //       fallbackLocale: fallbackLocaleString,
    //       supportedLocales: supportedLocalesStrings,
    //       preferences: mockPreferences,
    //     );

    //     // Verify that the locale is set to the device's locale
    //     expect(delegate.currentLocale, equals(Locale('es', 'ES')));
    //   });

    //   test('sets the fallback locale if the device locale is not supported', () async {
    //     // Change the behavior to return an unsupported locale
    //     LocaleService.getCurrentLocale = () {
    //       return Locale('fr', 'FR');
    //     };

    //     // Trigger the delegate creation which will invoke _loadDeviceLocale
    //     delegate = await LocalizationDelegate.create(
    //       fallbackLocale: fallbackLocaleString,
    //       supportedLocales: supportedLocalesStrings,
    //       preferences: mockPreferences,
    //     );

    //     // Verify that the locale is set to the fallback locale
    //     expect(delegate.currentLocale, equals(Locale('en', 'US')));
    //   });
    // });
  });
}
