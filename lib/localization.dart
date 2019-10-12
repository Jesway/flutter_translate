import 'package:flutter/cupertino.dart';

class Localization
{
    final Map<String, dynamic> translations;

    Localization(this.translations);

    static Localization of(BuildContext context) => Localizations.of<Localization>(context, Localization);

    String key(String key, {List<String> args})
    {
        var value = _getValue(key, translations);

        if (args != null)
        {
            args.forEach((String str)
            {
                value = value.replaceFirst(RegExp(r'{}'), str);
            });
        }

        return value;
    }

    String _getValue(String path, Map<String, dynamic> map)
    {
        List<String> keys = path.split('.');

        if (keys.length > 1)
        {
            for (int index = 0; index <= keys.length; index++)
            {
                if (map.containsKey(keys[index]) && map[keys[index]] is! String)
                {
                    return _getValue(keys.sublist(index + 1, keys.length).join('.'), map[keys[index]]);
                }

                return map[path] ?? path;
            }
        }

        return map[path] ?? path;
    }
}
