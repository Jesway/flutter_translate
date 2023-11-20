import 'package:flutter_translate/src/constants/constants.dart';
import 'package:flutter_translate/src/enums/localization_loader_type.dart';
import 'package:flutter_translate/src/services/loaders/base/localization_loader_options.dart';

class AssetsLoaderOptions extends LocalizationLoaderOptions
{
    @override
    LocalizationLoaderType get type => LocalizationLoaderType.assets;

    final String path;

    AssetsLoaderOptions({this.path = Constants.localizationAssetsPath});
}