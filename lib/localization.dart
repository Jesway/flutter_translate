import 'package:flutter/widgets.dart';

class Localization
{
    Locale locale;

    static Localization of(BuildContext context) => Localizations.of<Localization>(context, Localization);
}
