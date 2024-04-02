import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/src/enums/localization_loader_type.dart';
import 'package:flutter_translate/src/services/loaders/http_loader/http_loader_options.dart';

void main() {
  group('HttpLoaderOptions', () {
    test('should create instance with provided URL', () {
      const url = 'https://example.com/translations';
      final options = HttpLoaderOptions(url: url);

      expect(options.url, url);
    });

    test('should have correct loader type', () {
      final options = HttpLoaderOptions(url: 'https://example.com/translations');

      expect(options.type, LocalizationLoaderType.http);
    });
  });
}
