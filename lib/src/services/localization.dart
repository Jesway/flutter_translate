
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

    String translate(String key, {Map<String, dynamic>? args})
    {
        var translation = _getTranslation(key, _translations);

        if (translation != null && args != null)
        {
            translation = _assignArguments(translation, args);
        }

        return translation ?? key;
    }

    String plural(String key, num value, {Map<String, dynamic>? args})
    {
        final forms = _getAllPluralForms(key, _translations);
        return Intl.plural(
            value,
            zero: _putArgs(forms[Constants.pluralZero], value, args: args)
                ?? _putArgs(forms[Constants.plural0], value, args: args),
            one: _putArgs(forms[Constants.pluralOne], value, args: args)
                ?? _putArgs(forms[Constants.plural1], value, args: args),
            two: _putArgs(forms[Constants.pluralTwo], value, args: args)
                ?? _putArgs(forms[Constants.plural2], value, args: args),
            few: _putArgs(forms[Constants.pluralFew], value, args: args),
            many: _putArgs(forms[Constants.pluralMany], value, args: args),
            other: _putArgs(forms[Constants.pluralOther], value, args: args)
                ?? _putArgs(forms[Constants.pluralElse], value, args: args)
                ?? '$key.${Constants.pluralOther}',
        );
    }

    String? _putArgs(String? template, num value, {Map<String, dynamic>? args})
    {
        if (template == null) {
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

    Map<String, String> _getAllPluralForms(String key, Map<String, dynamic> map) {
        List<String> keys = key.split('.');

        if (keys.length > 1) {
            var firstKey = keys.first;

            if (map.containsKey(firstKey) && map[firstKey] is! String) {
                return _getAllPluralForms(
                    key.substring(key.indexOf('.') + 1), map[firstKey]);
            }
        }

        final result = <String, String>{};
        for (String k in map[key].keys) {
            result[k] = map[key][k].toString();
        }

        return result;
    }
}
