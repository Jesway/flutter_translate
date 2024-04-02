import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/services/loaders/asset_loader/assets_localization_loader.dart';
import 'dart:convert';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Initialize the binding

  group('AssetsLocalizationLoader Tests', () {
    late AssetsLocalizationLoader loader;
    const String encodedManifest = '{"assets/i18n/en.json": [], "assets/i18n/es.json": []}';
    const Map<String, dynamic> manifestContent = {
      'assets/i18n/en.json': ['en.json'],
      'assets/i18n/es.json': ['es.json'],
    };

    const String filePath = 'assets/i18n/en.json';
    const String fileContent = '{"hello": "Hello"}';

    setUp(() {
      loader = AssetsLocalizationLoader(FlutterTranslateOptions(
        loader: AssetsLoaderOptions(path: 'assets/i18n/'),
        supported: ['en', 'es'],
      ));

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('flutter/assets', (message) async {
        final String key = utf8.decode(message!.buffer.asUint8List());

        if (key == 'AssetManifest.json') {
          return ByteData.view(utf8.encode(json.encode(manifestContent)).buffer);
        } else if (key == filePath) {
          return ByteData.view(utf8.encode(fileContent).buffer);
        }
        return null;
      });
    });

    test('should load localization files', () async {
      final enData = await loader.load(const Locale('en'));
      expect(enData, isNotNull);
      expect(enData!['hello'], 'Hello');
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler('flutter/assets', null);
    });
  });
}
