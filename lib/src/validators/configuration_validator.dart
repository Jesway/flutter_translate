import 'dart:ui';

class ConfigurationValidator
{
    static void validate(Locale fallbackLocale, List<Locale> supportedLocales)
    {
        if(!supportedLocales.contains(fallbackLocale))
        {
            throw new Exception('The locale [$fallbackLocale] must be present in the list of supported locales [${supportedLocales.join(", ")}].');
        }
    }
}
