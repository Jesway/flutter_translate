import 'dart:io';
import 'dart:ui';

import 'package:flutter/widgets.dart';

    Locale getCurrentLocale() 
    {
       return _localeFromString(Platform.localeName);
    }

    List<Locale> getPreferredLocales() 
    {
        final deviceLocales = WidgetsBinding.instance.window.locales;

        return deviceLocales;
    }

    Locale _localeFromString(String code) 
    {
        var separator = code.contains('_') ? '_' : code.contains('-') ? '-' : null;

        if (separator != null) 
        {
            var parts = code.split(RegExp(separator));

            return Locale(parts[0], parts[1]);
        } 
        else 
        {
            return Locale(code);
        }
    }