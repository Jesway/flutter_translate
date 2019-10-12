import 'dart:convert';
import 'package:flutter/services.dart';

class LocalizationFileService
{
    static const String assetManifestFilename = 'AssetManifest.json';

    static Future<Map<String, String>> getLocalizedFiles(List<String> languages, String basePath) async
    {
        var localizedFiles = await _getAllLocalizedFiles(basePath);

        final files = new Map<String, String>();

        for(final language in languages.toSet())
        {
            var file = _findLocalizationFile(language, localizedFiles, basePath);

            files[language] = file;
        }

        return files;
    }

    static Future<String> getLocalizedContent(String file) async
    {
        return await rootBundle.loadString(file);
    }

    static Future<List<String>> _getAllLocalizedFiles(String basePath) async
    {
        final manifest = await rootBundle.loadString(assetManifestFilename);

        Map<String, dynamic> map = jsonDecode(manifest);

        return map.keys.where((x) => x.startsWith('$basePath/')).toList();
    }

    static String _findLocalizationFile(String languageCode, List<String> localizedFiles, String basePath)
    {
        var file = _getFilepath(languageCode, basePath);

        if(!localizedFiles.contains(file))
        {
            if(languageCode.contains('_'))
            {
                file = _getFilepath(languageCode.split('_').first, basePath);
            }
        }

        if(file == null)
        {
            throw new Exception('The asset file for the language "$languageCode" was not found.');
        }

        return file;
    }

    static String _getFilepath(String languageCode, String basePath)
    {
        return '$basePath/$languageCode.json';
    }
}
