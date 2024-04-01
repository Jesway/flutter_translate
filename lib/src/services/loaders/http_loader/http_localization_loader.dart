import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/services/loaders/base/localization_loader.dart';

class HttpLocalizationLoader extends LocalizationLoader {
  late final HttpLoaderOptions httpLoaderOptions;

  HttpLocalizationLoader(FlutterTranslateOptions options) : super(options) {
    httpLoaderOptions = options.loaderOptions as HttpLoaderOptions;
  }

  @override
  Future<Map<String, dynamic>?> load(Locale locale) {
    throw UnimplementedError();
  }
}
