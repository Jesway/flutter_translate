import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/services/loaders/http_loader/http_localization_loader.dart';
import 'package:flutter_translate/src/services/loaders/http_loader/http_loader_options.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_localization_loader_test.mocks.dart';

@GenerateMocks([FlutterTranslateOptions])
void main() {
  group('HttpLocalizationLoader', () {
    late HttpLocalizationLoader loader;
    late MockFlutterTranslateOptions mockOptions;

    setUp(() {
      mockOptions = MockFlutterTranslateOptions();
      when(mockOptions.loaderOptions).thenReturn(HttpLoaderOptions(url: 'https://example.com/translations'));
      loader = HttpLocalizationLoader(mockOptions);
    });

    test('constructor assigns httpLoaderOptions correctly', () {
      expect(loader.httpLoaderOptions.url, 'https://example.com/translations');
    });

    // Uncomment and implement this test when the load method is implemented
    // test('load should fetch data from the provided URL', () async {
    //   // Setup network requests and responses here
    //   // Execute the load method
    //   // Verify the behavior or the result
    // });

    //TODO can't test because of private method SUGGESTION  make public
    // test('privateMethodName behaves as expected', () {
    //   // Implementation of test would go here
    // });

    //TODO can't test because of static method SUGGESTION use dependency injection
    // test('staticMethodName behaves as expected', () {
    //   // Implementation of test would go here
    // });
  });
}
