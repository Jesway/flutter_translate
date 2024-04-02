import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/services/loaders/base/localization_loader.dart';
import 'package:mockito/mockito.dart';

class MockLocalizationLoader extends LocalizationLoader {
  MockLocalizationLoader(FlutterTranslateOptions options) : super(options);

  @override
  Future<Map<String, dynamic>?> load(Locale locale) {
    // Implement mock behavior or return a Future here if needed for tests
    return Future(() {
      return {};
    });
  }
}

class MockFlutterTranslateOptions extends Mock
    implements FlutterTranslateOptions {}

void main() {
  group('LocalizationLoader', () {
    late MockFlutterTranslateOptions options;
    late MockLocalizationLoader loader;

    setUp(() {
      options = MockFlutterTranslateOptions();
      loader = MockLocalizationLoader(options);
    });

    test('constructor assigns options', () {
      expect(loader.options, equals(options));
    });

    test('load method should be callable and return a Future', () async {
      var locale = Locale('en', 'US');
      expect(loader.load(locale), isA<Future<Map<String, dynamic>?>>());
    });

    // If there were private methods, they would be mentioned here as follows:
    // TODO: can't test private method `methodName`. SUGGESTION: make public or test through public API.

    // If there were static methods, they would be mentioned here as follows:
    // TODO: can't test static method `staticMethodName`. SUGGESTION: use dependency injection.
  });
}
