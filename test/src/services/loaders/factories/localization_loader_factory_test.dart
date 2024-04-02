import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/enums/localization_loader_type.dart';
import 'package:flutter_translate/src/services/loaders/asset_loader/assets_localization_loader.dart';
import 'package:flutter_translate/src/services/loaders/base/localization_loader_options.dart';
import 'package:flutter_translate/src/services/loaders/factories/localization_loader_factory.dart';
import 'package:flutter_translate/src/services/loaders/http_loader/http_localization_loader.dart';
import 'package:flutter_translate/src/services/loaders/base/localization_loader.dart';


void main() {
  group('LocalizationLoaderFactory', () {
    test('createLoader returns AssetsLocalizationLoader for assets loader type', () {
      final options = FlutterTranslateOptions(
        loader: AssetsLoaderOptions(),
        supported: ['en'],
      );

      final loader = LocalizationLoaderFactory.createLoader(options);

      expect(loader, isA<AssetsLocalizationLoader>());
    });

    test('createLoader returns HttpLocalizationLoader for http loader type', () {
      final options = FlutterTranslateOptions(
        loader: HttpLoaderOptions(url: 'http://example.com'),
        supported: ['en'],
      );

      final loader = LocalizationLoaderFactory.createLoader(options);

      expect(loader, isA<HttpLocalizationLoader>());
    });


  });
}


