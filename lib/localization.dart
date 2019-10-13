import 'constants.dart';

class Localization
{
    Map<dynamic, dynamic> _translations;

    Localization._();

    static Localization _instance;
    static Localization get instance => _instance ?? (_instance = Localization._());

    static void load(Map<dynamic, dynamic> translations)
    {
        instance._translations = translations;
    }

    String translate(String key, {Map<String, dynamic> args})
    {
        var value = _getValue(key, _translations);

        if (args != null)
        {
            value = _assignArguments(value, args);
        }

        return value;
    }

    String plural(String key, num value, {Map<String, dynamic> args})
    {
        var localizationKey = _getPluralLocalizationKey(key, value);

        var translation = _getValue(localizationKey, _translations);
        translation = translation.replaceAll(Constants.pluralValueArg, value.toString());

        if (args != null)
        {
            translation = _assignArguments(translation, args);
        }
        
        return translation;
    }

    String _getPluralLocalizationKey(String key, num value)
    {
        switch(value)
        {
            case 0: return _getPluralValue(key, Constants.pluralZero, _translations);
            case 1: return _getPluralValue(key, Constants.pluralOne, _translations);
            default: return _getPluralValue(key, Constants.pluralElse, _translations);
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

    String _getValue(String key, Map<String, dynamic> map)
    {
        List<String> keys = key.split('.');

        if (keys.length > 1)
        {
            for (int index = 0; index <= keys.length; index++)
            {
                if (map.containsKey(keys[index]) && map[keys[index]] is! String)
                {
                    return _getValue(keys.sublist(index + 1, keys.length).join('.'), map[keys[index]]);
                }

                return map[key] ?? key;
            }
        }

        return map[key] ?? key;
    }

    String _getPluralValue(String key, String valueKey, Map<String, dynamic> map)
    {
        List<String> keys = key.split('.');

        if (keys.length > 1)
        {
            for (int index = 0; index <= keys.length; index++)
            {
                if (map.containsKey(keys[index]) && map[keys[index]] is! String)
                {
                    return _getPluralValue(keys.sublist(index + 1, keys.length).join('.'), valueKey, map[keys[index]]);
                }

                return map[key][valueKey] ?? key;
            }
        }

        return map[key][valueKey] ?? key;
    }
}
