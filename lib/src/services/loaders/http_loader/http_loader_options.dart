import 'package:flutter_translate/src/enums/localization_loader_type.dart';
import 'package:flutter_translate/src/services/loaders/base/localization_loader_options.dart';

class HttpLoaderOptions extends LocalizationLoaderOptions {
  @override
  LocalizationLoaderType get type => LocalizationLoaderType.http;

  final String url;

  HttpLoaderOptions({required this.url});
}
