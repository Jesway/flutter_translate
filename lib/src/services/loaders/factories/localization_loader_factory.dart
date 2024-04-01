import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/enums/localization_loader_type.dart';
import 'package:flutter_translate/src/services/loaders/asset_loader/assets_localization_loader.dart';
import 'package:flutter_translate/src/services/loaders/base/localization_loader.dart';
import 'package:flutter_translate/src/services/loaders/http_loader/http_localization_loader.dart';

/// Factory class for creating instances of `LocalizationLoader`.
///
/// This class provides a method to instantiate the appropriate localization loader
/// based on the provided `LocalizationLoaderOptions`.
class LocalizationLoaderFactory {
  /// Creates a `LocalizationLoader` based on the specified loader options.
  ///
  /// Parameters:
  ///   - [loaderOptions]: The `LocalizationLoaderOptions` containing the configuration for the loader.
  ///
  /// Returns a `LocalizationLoader` instance according to the type defined in the options.
  ///
  /// Throws `UnimplementedError` if the loader type is not recognized or not implemented.
  static LocalizationLoader createLoader(FlutterTranslateOptions options) {
    switch (options.loaderOptions.type) {
      case LocalizationLoaderType.assets:
        return AssetsLocalizationLoader(options);
      case LocalizationLoaderType.http:
        return HttpLocalizationLoader(options);
      default:
        throw UnimplementedError(
            'LocalizationLoader for the specified type is not implemented.');
    }
  }
}
