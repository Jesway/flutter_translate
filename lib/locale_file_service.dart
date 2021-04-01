import 'dart:convert';
import 'package:flutter/services.dart';
import 'constants.dart';

class LocaleFileService {
  static Future<Map<String?, String?>?> getLocaleFiles(List<String?> locales, String? basePath) async {
    final List<String?>? localizedFiles = await _getAllLocaleFiles(basePath);

    final Map<String, String> files = <String, String>{};

    for (final String? language in locales.toSet()) {
      final String file = _findLocaleFile(language!, localizedFiles, basePath!)!;

      files[language] = file;
    }

    return files;
  }

  static Future<String?> getLocaleContent(String? file) async {
    return await rootBundle.loadString(file!);
  }

  static Future<List<String?>?> _getAllLocaleFiles(String? basePath) async {
    final String manifest = await rootBundle.loadString(Constants.assetManifestFilename);

    final Map<String, dynamic> map = jsonDecode(manifest) as Map<String, dynamic>;

    final String separator = basePath!.endsWith('/') ? '' : '/';

    return map.keys.where((String x) => x.startsWith('$basePath$separator')).toList();
  }

  static String? _findLocaleFile(String? languageCode, List<String?>? localizedFiles, String? basePath) {
    String? file = _getFilepath(languageCode, basePath);

    if (!localizedFiles!.contains(file)) {
      if (languageCode!.contains('_')) {
        file = _getFilepath(languageCode.split('_').first, basePath);
      }
    }

    if (file == null) {
      throw Exception('The asset file for the language "$languageCode" was not found.');
    }

    return file;
  }

  static String? _getFilepath(String? languageCode, String? basePath) {
    final String separator = basePath!.endsWith('/') ? '' : '/';

    return '$basePath$separator$languageCode.json';
  }
}
