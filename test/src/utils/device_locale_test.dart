import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/src/utils/device_locale.dart';

void main() {
  group('DeviceLocale', () {
    test('getCurrentDeviceLocale returns the current device locale', () {
      final locale = getCurrentDeviceLocale();
      expect(locale, isA<Locale>());
      expect(locale, PlatformDispatcher.instance.locale);
    });

    //TODO can't test because of static method SUGGESTION use dependency injection
    // test('PlatformDispatcher.instance.locale is used to determine the device locale', () {
    //   // Implementation of test would go here
    // });
  });
}
