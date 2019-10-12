import 'package:flutter/widgets.dart';
import 'localized_app.dart';
import 'localization_provider.dart';

class LocalizedAppState extends State<LocalizedApp>
{
    Locale _currentLocale;

    Locale get currentLocale => _currentLocale;

    void changeLanguage(Locale newLocale)
    {
        setState(() => _currentLocale = newLocale);
    }

    @override
    Widget build(BuildContext context) => LocalizationProvider(state: this, child: widget.child);
}
