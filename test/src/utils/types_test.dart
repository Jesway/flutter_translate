import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

typedef LocaleChangedCallback = Future<void> Function(Locale locale);

void main() {
  group('Types Tests', () {
    // Test cases for LocaleChangedCallback
    test('LocaleChangedCallback should be callable and return a Future', () {
      LocaleChangedCallback callback = (Locale locale) async {
        expect(locale, isNotNull);
        return;
      };

      expect(callback(Locale('en', 'US')), completes);
    });

    // TODO: can't test because LocaleChangedCallback is a typedef, not a class or method. SUGGESTION: test through usage.
  });
}
