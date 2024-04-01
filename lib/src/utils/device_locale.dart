import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Returns the current device locale
Locale getCurrentDeviceLocale() {
  return PlatformDispatcher.instance.locale;
}
