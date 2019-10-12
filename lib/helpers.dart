import 'dart:ui';

Locale localeFromString(String code, {bool languageCodeOnly})
{
    if(code.contains('_'))
    {
        var parts = code.split('_');

        return languageCodeOnly ? Locale(parts[0]) : Locale(parts[0], parts[1]);
    }
    else
    {
        return Locale(code);
    }
}


