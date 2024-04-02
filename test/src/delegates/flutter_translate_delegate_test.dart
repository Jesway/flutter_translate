
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/delegates/flutter_translate_delegate.dart';

void main() {
  group('FlutterTranslateDelegate', () {
    test('load should return instance of FlutterTranslate', () async {
      final delegate = FlutterTranslateDelegate();
      final result = await delegate.load(Locale('en'));
      expect(result, isInstanceOf<FlutterTranslate>());
    });

    test('isSupported should return true for non-null locale', () {
      final delegate = FlutterTranslateDelegate();
      expect(delegate.isSupported(Locale('en')), isTrue);
      expect(delegate.isSupported(null), isFalse);
    });

    test('shouldReload should return true', () {
      final delegate = FlutterTranslateDelegate();
      expect(delegate.shouldReload(delegate), isTrue);
    });
  });
}
