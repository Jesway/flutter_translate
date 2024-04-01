import 'package:flutter/widgets.dart';

/// Extends `String` class to provide a method for converting a string to a `Locale` object.
extension StringLocaleExtensions on String {
  Locale toLocale() {
    if (contains('_')) {
      var parts = split('_');

      return Locale(parts[0], parts[1]);
    } else {
      return Locale(this);
    }
  }
}
