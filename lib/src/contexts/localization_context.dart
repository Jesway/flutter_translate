import 'package:flutter_translate/src/models/locale_data.dart';

class LocalizationContext
{
    LocaleData _current;
    LocaleData get current => _current;

    LocalizationContext(LocaleData data): _current = data;

    update(LocaleData data)
    {
        _current = data;
    }
}
