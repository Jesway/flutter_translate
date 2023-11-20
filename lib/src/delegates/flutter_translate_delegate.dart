import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';

class FlutterTranslateDelegate extends LocalizationsDelegate<FlutterTranslate>
{
    @override
    Future<FlutterTranslate> load(Locale locale) async
    {
        return FlutterTranslate.instance;
    }

    @override
    bool isSupported(Locale? locale) => locale != null;

    @override
    bool shouldReload(LocalizationsDelegate<FlutterTranslate> old) => true;
}