import 'package:flutter_translate/src/constants/constants.dart';
import 'package:flutter_translate/src/contexts/localization_context.dart';
import 'package:intl/intl.dart';

class TranslationService
{
    LocalizationContext _context;

    TranslationService(this._context);

    void updateLocale(LocalizationContext context)
    {
        _context = context;
    }
    
    String translate(String key, {Map<String, dynamic>? args})
    {
        var translation = _getTranslation(key, _context.current.localizations);

        if (translation != null && args != null)
        {
            translation = _assignArguments(translation, args);
        }

        return translation ?? key;
    }

    String plural(String key, num value, {Map<String, dynamic>? args})
    {
        final forms = _getAllPluralForms(key, _context.current.localizations);

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

        // Added null check for map[key]
        if (map[key] != null) 
        {
            for (String k in map[key].keys) 
            {
                result[k] = map[key][k].toString();
            }
        }

        return result;
    }
}