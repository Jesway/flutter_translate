import 'constants.dart';

class Localization {
  Map<dynamic, dynamic>? _translations;

  Localization._();

  static Localization? _instance;

  static Localization? get instance => _instance ?? (_instance = Localization._());

  static void load(Map<dynamic, dynamic> translations) {
    instance!._translations = translations;
  }

  String? translate(String? key, {Map<String?, dynamic>? args}) {
    String? translation = _getTranslation(key, _translations as Map<String?, dynamic>?);

    if (translation != null && args != null) {
      translation = _assignArguments(translation, args);
    }

    return translation ?? key;
  }

  String plural(String? key, num? value, {Map<String?, dynamic>? args}) {
    final String pluralKeyValue = _getPluralKeyValue(value!);
    String? translation = _getPluralTranslation(key!, pluralKeyValue, _translations as Map<String?, dynamic>?);

    if (translation != null) {
      translation = translation.replaceAll(Constants.pluralValueArg, value.toString());

      if (args != null) {
        translation = _assignArguments(translation, args);
      }
    }

    return translation ?? '$key.$pluralKeyValue';
  }

  String _getPluralKeyValue(num value) {
    switch (value) {
      case 0:
        return Constants.pluralZero;
      case 1:
        return Constants.pluralOne;
      case 2:
        return Constants.pluralTwo;
      default:
        return Constants.pluralElse;
    }
  }

  String _assignArguments(String? value, Map<String?, dynamic>? args) {
    for (final String? key in args!.keys) {
      value = value!.replaceAll('{$key}', '${args[key]}');
    }

    return value!;
  }

  String? _getTranslation(String? key, Map<String?, dynamic>? map) {
    final List<String> keys = key!.split('.');

    if (keys.length > 1) {
      final String firstKey = keys.first;

      if (map!.containsKey(firstKey) && map[firstKey] is! String) {
        return _getTranslation(key.substring(key.indexOf('.') + 1), map[firstKey] as Map<String?, dynamic>);
      }
    }

    return map![key] as String?;
  }

  String? _getPluralTranslation(String? key, String? valueKey, Map<String?, dynamic>? map) {
    final List<String> keys = key!.split('.');

    if (keys.length > 1) {
      final String firstKey = keys.first;

      if (map!.containsKey(firstKey) && map[firstKey] is! String) {
        return _getPluralTranslation(
            key.substring(key.indexOf('.') + 1), valueKey, map[firstKey] as Map<String?, dynamic>);
      }
    }

    return map![key][valueKey] as String? ?? map[key][Constants.pluralElse] as String?;
  }
}
