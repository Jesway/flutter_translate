import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/src/widgets/localized_app.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'globals_test.mocks.dart';

@GenerateMocks([FlutterTranslate, BuildContext, LocalizedAppState,LocalizedAppInherited])
void main() {
  const String englishTranslation = '{"title": "Hello"}';
  const String spanishTranslation = '{"title": "Hola"}';

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
      final String key = utf8.decode(message!.buffer.asUint8List());
      if (key == 'AssetManifest.json') {
        return ByteData.view(utf8
            .encode(json.encode({
              'assets/i18n/en.json': ['en.json'],
              'assets/i18n/es.json': ['es.json'],
            }))
            .buffer);
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
    late MockBuildContext mockBuildContext;
    late MockLocalizedAppInherited mockLocalizedAppInherited;

    setUp(() {
      mockBuildContext = MockBuildContext();
      mockLocalizedAppInherited = MockLocalizedAppInherited();

      when(mockBuildContext.mounted).thenReturn(true);

      // Return the mocked LocalizedAppInherited when dependOnInheritedWidgetOfExactType is called
      when(mockBuildContext.dependOnInheritedWidgetOfExactType<LocalizedAppInherited>())
        .thenReturn(mockLocalizedAppInherited);

      // Ensure the refresh method is available and can be called
      when(mockLocalizedAppInherited.refresh()).thenReturn(null);
    });

    group('translate', () {
      test('translates a key in the default language', () {
        expect(translate('title'), equals('Hello'));
      });

      test('translates a key in a different language', () async {
        await changeLocale(mockBuildContext, 'es');
        expect(translate('title'), equals('Hola'));
      });
    });

    // Additional tests for translatePlural, getValueAtKeyPath, and changeLocale
  });
}
