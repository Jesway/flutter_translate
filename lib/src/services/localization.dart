import 'package:flutter_translate_community/src/constants/constants.dart';
import 'package:intl/intl.dart';

class Localization {
  late Map<String, dynamic> _translations;
  Map<String, dynamic>? _fallbackTranslations;
  bool? _interpolateEmptyAsEmtpyString;

  Localization._();

  static Localization? _instance;
  static Localization get instance =>
      _instance ?? (_instance = Localization._());

  static void load(Map<String, dynamic> translations,
      {Map<String, dynamic>? fallback, bool? interpolateEmptyAsEmtpyString}) {
    instance._translations = translations;
    instance._fallbackTranslations = fallback;
    instance._interpolateEmptyAsEmtpyString = interpolateEmptyAsEmtpyString;
  }

  String translate(String key, {Map<String, dynamic>? args}) {
    var translation =
        _getTranslation(key, _translations, _fallbackTranslations);

    if (translation != null) {
      translation = _assignArguments(translation, args ?? {});
    }

    return translation ?? key;
  }

  String plural(String key, num value, {Map<String, dynamic>? args}) {
    final forms = _getAllPluralForms(key, _translations, _fallbackTranslations);

    return Intl.plural(
      value,
      zero: _putArgs(forms[Constants.pluralZero], value, args: args),
      one: _putArgs(forms[Constants.pluralOne], value, args: args),
      two: _putArgs(forms[Constants.pluralTwo], value, args: args),
      few: _putArgs(forms[Constants.pluralFew], value, args: args),
      many: _putArgs(forms[Constants.pluralMany], value, args: args),
      other: _putArgs(forms[Constants.pluralOther], value, args: args) ??
          '$key.${Constants.pluralOther}',
    );
  }

  List<String> list(String key, {Map<String, dynamic>? args}) {
    var translations =
        _getListTranslation(key, _translations, _fallbackTranslations);

    if (translations != null) {
      translations =
          translations.map((t) => _assignArguments(t, args ?? {})).toList();
    }

    return List<String>.from(translations ?? [key]);
  }

  String? _putArgs(String? template, num value, {Map<String, dynamic>? args}) {
    if (template == null) {
      return null;
    }

    template = template.replaceAll(Constants.pluralValueArg, value.toString());

    if (args == null) {
      return template;
    }

    for (String k in args.keys) {
      template = template!.replaceAll("{$k}", args[k].toString());
    }
    if (_interpolateEmptyAsEmtpyString ?? false) {
      template = template!.replaceAll('{}', '');
    }

    return template;
  }

  String _assignArguments(String value, Map<String, dynamic> args) {
    for (final key in args.keys) {
      value = value.replaceAll('{$key}', '${args[key]}');
    }
    if (_interpolateEmptyAsEmtpyString ?? false) {
      value = value.replaceAll('{}', '');
    }

    return value;
  }

  String? _getTranslation(
      String key, Map<String, dynamic> map, Map<String, dynamic>? fallbackMap) {
    List<String> keys = key.split('.');

    if (keys.length > 1) {
      var firstKey = keys.first;
      var remainingKey = key.substring(key.indexOf('.') + 1);

      var value = map[firstKey];
      if (value != null && value is! String) {
        return _getTranslation(remainingKey, value, fallbackMap?[firstKey]);
      } else if (fallbackMap != null) {
        var fallbackValue = fallbackMap[firstKey];
        if (fallbackValue != null && fallbackValue is! String) {
          return _getTranslation(remainingKey, fallbackValue, null);
        }
      }
    }

    return map[key] ?? fallbackMap?[key];
  }

  Map<String, String> _getAllPluralForms(
      String key, Map<String, dynamic> map, Map<String, dynamic>? fallbackMap) {
    List<String> keys = key.split('.');

    if (keys.length > 1) {
      var firstKey = keys.first;
      var remainingKey = key.substring(key.indexOf('.') + 1);

      var value = map[firstKey];
      if (value != null && value is! String) {
        return _getAllPluralForms(remainingKey, value, fallbackMap?[firstKey]);
      } else if (fallbackMap != null) {
        var fallbackValue = fallbackMap[firstKey];
        if (fallbackValue != null && fallbackValue is! String) {
          return _getAllPluralForms(remainingKey, fallbackValue, null);
        }
      }
    }

    final result = <String, String>{};

    for (String k in map[key].keys.toSet().addAll(fallbackMap?[key].keys)) {
      result[k] = (map[key][k] ?? fallbackMap?[key][k]).toString();
    }

    return result;
  }

  List<dynamic>? _getListTranslation(
      String key, Map<String, dynamic> map, Map<String, dynamic>? fallbackMap) {
    List<String> keys = key.split('.');

    if (keys.length > 1) {
      var firstKey = keys.first;
      var remainingKey = key.substring(key.indexOf('.') + 1);

      var value = map[firstKey];
      if (value != null && value is! List<dynamic>) {
        return _getListTranslation(remainingKey, value, fallbackMap?[firstKey]);
      } else if (fallbackMap != null) {
        var fallbackValue = fallbackMap[firstKey];
        if (fallbackValue != null && fallbackValue is! List<dynamic>) {
          return _getListTranslation(remainingKey, fallbackValue, null);
        }
      }
    }

    return map[key] ?? fallbackMap?[key];
  }
}
