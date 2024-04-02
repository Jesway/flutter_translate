import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_translate/flutter_translate.dart';

void main() {
  const String localeEn = 'en';
  const Map<String, dynamic> enLocalizations = {
    "apples": {
      "zero": "no apples",
      "one": "one apple",
      "other": "some apples"
    }
  };

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMessageHandler('flutter/assets', (message) async {
        final String key = utf8.decode(message!.buffer.asUint8List());
        if (key == 'AssetManifest.json') {
          return ByteData.view(utf8.encode(json.encode({"assets/i18n/$localeEn.json": []})).buffer);
        } else if (key == 'assets/i18n/$localeEn.json') {
          return ByteData.view(utf8.encode(json.encode(enLocalizations)).buffer);
        }
        return null;
      });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMessageHandler('flutter/assets', null);
  });

  group('FlutterTranslate Tests', () {
    test('initialize and use translate and plural', () async {
      await FlutterTranslate.initialize(FlutterTranslateOptions(supported: ['en'], fallback: 'en', loader: AssetsLoaderOptions()));

      String singleApple = translate("apples", args: {"count": 1});
      expect(singleApple, 'one apple');

      String multipleApples = translate("apples", args: {"count": 10});
      expect(multipleApples, 'some apples');
    });
  });
}
