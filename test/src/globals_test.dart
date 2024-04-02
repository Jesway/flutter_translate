import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/src/widgets/localized_app.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'globals_test.mocks.dart';

@GenerateMocks([FlutterTranslate, BuildContext, LocalizedAppState])
void main() {

  const String englishTranslation = '{"title": "Hello"}';
  const String spanishTranslation = '{"title": "Hola"}';

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
      final String key = utf8.decode(message!.buffer.asUint8List());
      if (key == 'AssetManifest.json') {
        return ByteData.view(utf8.encode(json.encode({
          'assets/i18n/en.json': ['en.json'],
          'assets/i18n/es.json': ['es.json'],
        })).buffer);
      } else if (key == 'assets/i18n/en.json') {
        return ByteData.view(utf8.encode(englishTranslation).buffer);
      } else if (key == 'assets/i18n/es.json') {
        return ByteData.view(utf8.encode(spanishTranslation).buffer);
      }
      return null;
    });

    await FlutterTranslate.initialize(FlutterTranslateOptions(
      supported: ["en", "es"],
      fallback: "en",
      loader: AssetsLoaderOptions(path: 'assets/i18n/'),
    ));
  });

  group('Global Functions', () {
    late BuildContext context;

    setUp(() {
      context = MockBuildContext();
    });

    group('translate', () {
      test('translates a key in the default language', () {
        expect(translate('title'), equals('Hello'));
      });

      test('translates a key in a different language', () async {
        await changeLocale(context, 'es');
        expect(translate('title'), equals('Hola'));
      });
    });

    // Additional tests for translatePlural, getValueAtKeyPath, and changeLocale
  });
}
