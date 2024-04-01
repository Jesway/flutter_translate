import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/constants/constants.dart';
import 'package:flutter_translate/src/services/loaders/base/localization_loader.dart';
import 'package:path/path.dart' as path;

class AssetsLocalizationLoader extends LocalizationLoader {
  bool _initialized = false;

  late final AssetsLoaderOptions assetsLoaderOptions;

  Map<String, String> files = {};

  AssetsLocalizationLoader(FlutterTranslateOptions options) : super(options) {
    assetsLoaderOptions = options.loaderOptions as AssetsLoaderOptions;
  }

  @override
  Future<Map<String, dynamic>?> load(Locale locale) async {
    await _initializeIfRequired();

    final file = _getLocaleFile(locale);

    if (file == null) return null;

    final content = await _getFileContent(file);

    return jsonDecode(content);
  }

  String? _getLocaleFile(Locale locale) {
    final localeString = locale.toString();

    return files[localeString];
  }

  Future<void> _initializeIfRequired() async {
    if (_initialized) return;

    files = await _getAllLocaleFiles();

    _initialized = true;
  }

  Future<Map<String, String>> _getAllLocaleFiles() async {
    final manifest =
        await rootBundle.loadString(Constants.assetManifestFilename);

    Map<String, dynamic> map = jsonDecode(manifest);

    Map<String, String> result = {};

    final keys = map.keys.toList();

    keys.sort((a, b) => a.toString().compareTo(b.toString()));

    for (var key in keys) {
      if (!_isLocalizationFile(key)) continue;

      var locale = path.basenameWithoutExtension(key);

      if (!result.containsKey(locale)) {
        result[locale] = key;
      }
    }

    return result;
  }

  bool _isLocalizationFile(String path) {
    var basePath = assetsLoaderOptions.path;
    var separator = basePath.endsWith('/') ? '' : '/';

    return path.startsWith('$basePath$separator') &&
        (path.endsWith('.json') || path.endsWith('.arb'));
  }

  Future<String> _getFileContent(String file) async {
    final ByteData data = await rootBundle.load(file);

    return utf8.decode(data.buffer.asUint8List());
  }
}
