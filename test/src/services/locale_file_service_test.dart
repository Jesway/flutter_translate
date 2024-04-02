import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_translate/src/constants/constants.dart';
import 'package:flutter_translate/src/services/locale_file_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAssetBundle extends Mock implements AssetBundle {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("local_file_service", () {
    group('getLocaleFiles', () {
      test('should return a map of locale files', () async {
        final String basePath = 'assets/i18n';
        final List<String> locales = ['en', 'es'];
        final manifestContent = {
          '$basePath/en.json': ['en.json'],
          '$basePath/es.json': ['es.json'],
        };
        final String encodedManifest = json.encode(manifestContent);

        // Intercept asset loading channel messages
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMessageHandler(
          'flutter/assets',
          (message) async {
            final String key = utf8.decode(message!.buffer.asUint8List());
            if (key == 'AssetManifest.json') {
              return ByteData.view(
                  Uint8List.fromList(encodedManifest.codeUnits).buffer);
            } else if (manifestContent.containsKey(key)) {
              // Return empty JSON data for locale files
              return ByteData.view(Uint8List.fromList('{}'.codeUnits).buffer);
            }
            return null;
          },
        );

        final files = await LocaleFileService.getLocaleFiles(locales, basePath);

        // Assert that the files map contains the expected keys and values
        expect(files, isA<Map<String, String>>());
        expect(files.keys, containsAll(locales));
        expect(files['en'], equals('$basePath/en.json'));
        expect(files['es'], equals('$basePath/es.json'));

        // Reset message handler after the test
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMessageHandler('flutter/assets', null);
      });
    });

    group('getLocaleContent', () {
      test('should return content of the file', () async {
        final String filePath = 'assets/i18n/en.json';
        final String fileContent = '{"hello": "Hello"}';
        final Map<String, dynamic> manifestContent = {
          filePath: ['en.json']
        };

        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMessageHandler(
          'flutter/assets',
          (message) async {
            // Correctly decode the message buffer to get the requested asset key
            final String key = utf8.decode(message!.buffer.asUint8List());

            if (key == 'AssetManifest.json') {
              // Mock the asset manifest response
              return ByteData.view(
                  Uint8List.fromList(utf8.encode(json.encode(manifestContent)))
                      .buffer);
            } else if (key == filePath) {
              // Mock the file content response when the requested asset matches filePath
              return ByteData.view(
                  Uint8List.fromList(utf8.encode(fileContent)).buffer);
            }
            return null;
          },
        );

        String? content = await LocaleFileService.getLocaleContent(filePath);

        // Assert the content is as expected
        expect(content, isNotNull);
        expect(content, isA<String>());
        expect(json.decode(content!), equals({"hello": "Hello"}));

        // Reset message handler after the test
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMessageHandler('flutter/assets', null);
      });
    });

    // TODO cant test private methods
    // group('_getAllLocaleFiles', () {
    //   test('should return all locale files', () async {
    //     final bundle = MockRootBundle();
    //     final String basePath = 'assets/i18n';
    //     final Map<String, dynamic> manifestMap = {
    //       'assets/i18n/en.json': ['en.json'],
    //       'assets/i18n/es.json': ['es.json'],
    //     };

    //     when(bundle.loadString(Constants.assetManifestFilename))
    //         .thenAnswer((_) async => json.encode(manifestMap));

    //     List<String> files = await LocaleFileService._getAllLocaleFiles(basePath);

    //     expect(files, isA<List<String>>());
    //     expect(files.length, 2);
    //     expect(files, contains('assets/i18n/en.json'));
    //     expect(files, contains('assets/i18n/es.json'));
    //   });
    // });

    // group('_findLocaleFile', () {
    //   test('should find and return the correct locale file', () async {
    //     final String basePath = 'assets/i18n';
    //     final List<String> files = ['assets/i18n/en.json', 'assets/i18n/es.json'];
    //     String result = LocaleFileService._findLocaleFile('en', files, basePath);

    //     expect(result, isA<String>());
    //     expect(result, 'assets/i18n/en.json');
    //   });

    //   test('should handle language codes with country code', () {
    //     final String basePath = 'assets/i18n';
    //     final List<String> files = ['assets/i18n/en.json', 'assets/i18n/en_US.json'];
    //     String result = LocaleFileService._findLocaleFile('en_US', files, basePath);

    //     expect(result, isA<String>());
    //     expect(result, 'assets/i18n/en_US.json');
    //   });

    //   test('should default to language code if specific country code file is not found', () {
    //     final String basePath = 'assets/i18n';
    //     final List<String> files = ['assets/i18n/en.json', 'assets/i18n/es.json'];
    //     String result = LocaleFileService._findLocaleFile('en_US', files, basePath);

    //     expect(result, isA<String>());
    //     expect(result, 'assets/i18n/en.json');
    //   });

    //   test('should throw an exception if the file is not found', () {
    //     final String basePath = 'assets/i18n';
    //     final List<String> files = ['assets/i18n/es.json'];

    //     expect(() => LocaleFileService._findLocaleFile('en', files, basePath), throwsException);
    //   });
    // });

    // group('_getFilepath', () {
    //   test('should return the correct file path', () {
    //     final String basePath = 'assets/i18n';
    //     final String languageCode = 'en';

    //     String? path = LocaleFileService._getFilepath(languageCode, basePath);

    //     expect(path, isNotNull);
    //     expect(path, 'assets/i18n/en.json');
    //   });

    //   test('should handle base paths with trailing slashes', () {
    //     final String basePath = 'assets/i18n/';
    //     final String languageCode = 'en';

    //     String? path = LocaleFileService._getFilepath(languageCode, basePath);

    //     expect(path, isNotNull);
    //     expect(path, 'assets/i18n/en.json');
    //   });
    // });
  });
}
