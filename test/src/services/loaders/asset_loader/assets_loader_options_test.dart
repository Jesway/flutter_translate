
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/src/constants/constants.dart';
import 'package:flutter_translate/src/enums/localization_loader_type.dart';
import 'package:flutter_translate/src/services/loaders/asset_loader/assets_loader_options.dart';

void main() {
  group('AssetsLoaderOptions', () {
    test('should create instance with default path', () {
      final loaderOptions = AssetsLoaderOptions();
      expect(loaderOptions.path, Constants.localizationAssetsPath);
    });

    test('should create instance with custom path', () {
      const customPath = 'custom/path';
      final loaderOptions = AssetsLoaderOptions(path: customPath);
      expect(loaderOptions.path, customPath);
    });

    test('should have correct loader type', () {
      final loaderOptions = AssetsLoaderOptions();
      expect(loaderOptions.type, LocalizationLoaderType.assets);
    });
  });
}
