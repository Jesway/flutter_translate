
import 'package:flutter_translate/src/constants/constants.dart';

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
        var pluralKeyValue = _getPluralKeyValue(value);
        var translation = _getPluralTranslation(key, pluralKeyValue, _translations);

        if(translation != null)
        {
            translation = translation.replaceAll(Constants.pluralValueArg, value.toString());

            if (args != null)
            {
                translation = _assignArguments(translation, args);
            }
        }

        return translation ?? '$key.$pluralKeyValue';
    }

    String _getPluralKeyValue(num value)
    {
        switch(value)
        {
            case 0: return Constants.pluralZero;
            case 1: return Constants.pluralOne;
            case 2: return Constants.pluralTwo;
            default: return Constants.pluralElse;
        }
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

    String? _getPluralTranslation(String key, String valueKey, Map<String, dynamic> map)
    {
        List<String> keys = key.split('.');

        if (keys.length > 1)
        {
            var firstKey = keys.first;

            if(map.containsKey(firstKey) && map[firstKey] is! String)
            {
                return _getPluralTranslation(key.substring(key.indexOf('.') + 1), valueKey, map[firstKey]);
            }
        }

        return map[key][valueKey] ?? map[key][Constants.pluralElse];
    }
}
