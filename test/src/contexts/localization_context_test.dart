import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/src/models/locale_data.dart';
import 'package:flutter_translate/src/contexts/localization_context.dart';
import 'package:flutter/widgets.dart';

void main() {
  group('LocalizationContext', () {
    test('should update current LocaleData', () {
      final initialLocaleData = LocaleData(Locale('en'), {});
      final localizationContext = LocalizationContext(initialLocaleData);

      expect(localizationContext.current, initialLocaleData);

      final updatedLocaleData = LocaleData(Locale('es'), {});
      localizationContext.update(updatedLocaleData);

      expect(localizationContext.current, updatedLocaleData);
    });
  });
}
