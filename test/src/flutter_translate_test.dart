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


    // test('initialize should only be called once', () async {
    //   // Implementation would be here if we could isolate static dependencies
    // });


    //TODO can't test because of private method. SUGGESTION: make public or use dependency injection
    // test('_initialize should setup services', () async {
    //   // Implementation would be here if the method was public or if dependencies could be injected
    // });


    //TODO can't test because of private method. SUGGESTION: make public or use dependency injection
    // test('_setupInitialLocale should set initial locale based on service', () async {
    //   // Implementation would be here if the method was public or if dependencies could be injected
    // });

    //TODO can't test because of dependency on _translationService. SUGGESTION: use dependency injection
    // test('translate should return correct translation', () {
    //   // Implementation would be here if _translationService could be mocked
    // });

    //TODO can't test because of dependency on _translationService. SUGGESTION: use dependency injection
    // test('plural should return correct pluralization', () {
    //   // Implementation would be here if _translationService could be mocked
    // });

    //TODO can't test because of dependency on _translationService. SUGGESTION: use dependency injection
    // test('getValueAtKeyPath should return correct value', () {
    //   // Implementation would be here if _translationService could be mocked
    // });

    //TODO can't test because of dependency on _changeLocaleService. SUGGESTION: use dependency injection
    // test('changeLocale should update locale correctly', () async {
    //   // Implementation would be here if _changeLocaleService could be mocked
    // });
  });
}
