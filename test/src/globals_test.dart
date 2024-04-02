import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/src/widgets/localized_app.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'globals_test.mocks.dart';

@GenerateMocks(
    [FlutterTranslate, BuildContext, LocalizedAppState, LocalizedAppInherited])
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
    late MockLocalizedAppState mockLocalizedAppState;
    late MockLocalizedAppInherited mockLocalizedAppInherited;
    setUp(() {
      mockBuildContext = MockBuildContext();
      mockLocalizedAppState = MockLocalizedAppState();
      mockLocalizedAppInherited = MockLocalizedAppInherited();

      when(mockBuildContext.mounted).thenReturn(true);

      when(mockLocalizedAppInherited.data).thenReturn(mockLocalizedAppState);

      // Return the mocked LocalizedAppState when dependOnInheritedWidgetOfExactType is called
      when(mockBuildContext
              .dependOnInheritedWidgetOfExactType<LocalizedAppInherited>())
          .thenReturn(mockLocalizedAppInherited);

      // Ensure the refresh method is available and can be called
      when(mockLocalizedAppState.refresh()).thenReturn(null);
    });

    // TODO cant test because FlutterTranslate.instance is a getter need to refactor to perform DI to modify code
  });
}
