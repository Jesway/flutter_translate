
import 'package:flutter_translate/src/constants/constants.dart';
import 'package:intl/intl.dart';

class Localization
{
    late Map<String, dynamic> _translations;

    Localization._();

    static Localization? _instance;
    static Localization get instance => _instance ?? (_instance = Localization._());

    static void load(Map<String, dynamic> translations)
    {
        instance._translations = translations;
    }

  String translate(String key, {Map<String, dynamic>? args}) {
    var translation = getValueAtKeyPath(key);

    if (translation != null && translation is String && args != null) {
      translation = _assignArguments(translation, args);
    }

    return translation is String ? translation : key;
  }

  String plural(String key, num value, {Map<String, dynamic>? args}) {
    var forms = getValueAtKeyPath(key);

    if (forms is! Map) {
      return key; // Return the key if the expected plural forms are not found.
    }

    return Intl.plural(
      value,
      zero: _putArgs(forms[Constants.pluralZero], value, args: args),
      one: _putArgs(forms[Constants.pluralOne], value, args: args),
      two: _putArgs(forms[Constants.pluralTwo], value, args: args),
      few: _putArgs(forms[Constants.pluralFew], value, args: args),
      many: _putArgs(forms[Constants.pluralMany], value, args: args),
      other: _putArgs(forms[Constants.pluralOther], value, args: args) ?? '$key.${Constants.pluralOther}',
    );
  }

    String? _putArgs(String? template, num value, {Map<String, dynamic>? args})
    {
        if (template == null)
        {
            return null;
        }

        template = template.replaceAll(Constants.pluralValueArg, value.toString());

        if (args == null)
        {
            return template;
        }

        for (String k in args.keys)
        {
            template = template!.replaceAll("{$k}", args[k].toString());
        }

        return template;
    }

    String _assignArguments(String value, Map<String, dynamic> args)
    {
        for(final key in args.keys)
        {
            value = value.replaceAll('{$key}', '${args[key]}');
        }

        return value;
    }

    String? _getTranslation(String key, Map<String, dynamic> map)
    {
        List<String> keys = key.split('.');

        if (keys.length > 1)
        {
            var firstKey = keys.first;

            if(map.containsKey(firstKey) && map[firstKey] is! String)
            {
                return _getTranslation(key.substring(key.indexOf('.') + 1), map[firstKey]);
            }
        }

        return map[key];
    }

    Map<String, String> _getAllPluralForms(String key, Map<String, dynamic> map)
    {
        List<String> keys = key.split('.');

        if (keys.length > 1)
        {
            var firstKey = keys.first;

            if (map.containsKey(firstKey) && map[firstKey] is! String)
            {
                return _getAllPluralForms(key.substring(key.indexOf('.') + 1), map[firstKey]);
            }
        }

        final result = <String, String>{};

        for (String k in map[key].keys)
        {
            result[k] = map[key][k].toString();
        }

        return result;
    }

  dynamic getValueAtKeyPath(String keyPath) {
    List<String> parts = keyPath.split('.');
    dynamic current = _translations;
    for (String part in parts) {
      if (current is Map) {
        current = current[part];
      } else if (current is List) {
        int index = int.tryParse(part) ?? -1;
        if (index >= 0 && index < current.length) {
          current = current[index];
        } else {
          return null;
        }
      } else {
        return null;
      }
    }
    return current;
  }
}
