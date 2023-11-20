import 'package:flutter/widgets.dart';
import 'package:flutter_translate/src/extensions/string_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for persisting and retrieving user's preferred locale settings.
class LocalePersistenceService
{
    // Key for storing the selected locale in SharedPreferences.
    static const String _selectedLocaleKey = 'selected_locale';

    /// Retrieves the preferred Locale from SharedPreferences.
    /// Returns null if no preferred Locale is set or in case of an error.
    Future<Locale?> getPreferredLocale() async
    {
        try
        {
            // Obtain an instance of SharedPreferences.
            final preferences = await SharedPreferences.getInstance();

            // Check if a preferred locale is set.
            if(!preferences.containsKey(_selectedLocaleKey)) 
            {
                // Return null if no preferred locale is found.
                return null;
            }
            
            // Retrieve the stored locale string.
            var locale = preferences.getString(_selectedLocaleKey);

            // Convert the string to a Locale object.
            return locale!.toLocale();
        }
        catch (e)
        {
            /// Log the exception in the future.
            return null;
        }
    }

    /// Saves the user's preferred Locale to SharedPreferences.
    Future savePreferredLocale(Locale locale) async
    {
        try
        {
            // Obtain an instance of SharedPreferences.
            final preferences = await SharedPreferences.getInstance();

            // Store the locale string in SharedPreferences.
            await preferences.setString(_selectedLocaleKey, locale.toString());
        }
        catch (e) 
        {
            // Log the exception in the future.
        }
    }
}