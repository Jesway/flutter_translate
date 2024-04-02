
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/options/flutter_translate_options.dart';
import 'package:flutter_translate/src/services/loaders/asset_loader/assets_loader_options.dart';

void main() {
  group('FlutterTranslateOptions', () {
    test('should create instance with provided values', () {
      final supportedLocales = ['en_US', 'de_DE'];
      final fallbackLocale = 'en_US';
      final initialLocale = 'de_DE';

      final options = FlutterTranslateOptions(
        supported: supportedLocales,
        fallback: fallbackLocale,
        initial: initialLocale,
        autoSave: true,
        missingKeyStrategy: MissingKeyStrategy.fallback,
        loader: AssetsLoaderOptions(),
      );

      expect(options.autoSave, isTrue);
      expect(options.missingKeyStrategy, MissingKeyStrategy.fallback);
      expect(options.supportedLocales, containsAll([Locale('en', 'US'), Locale('de', 'DE')]));
      expect(options.fallbackLocale, Locale('en', 'US'));
      expect(options.initialLocale, Locale('de', 'DE'));
    });

    test('should throw exception if fallback locale is not in supported locales', () {
      expect(
        () => FlutterTranslateOptions(
          supported: ['en_US'],
          fallback: 'de_DE',
        ),
        throwsException,
      );
    });

    test('should assign first supported locale as fallback if fallback is not provided', () {
      final options = FlutterTranslateOptions(supported: ['en_US', 'de_DE']);
      expect(options.fallbackLocale, Locale('en', 'US'));
    });

    test('should return null for initial locale if not provided', () {
      final options = FlutterTranslateOptions(supported: ['en_US', 'de_DE']);
      expect(options.initialLocale, isNull);
    });
  });
}
