import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  group('Localization', () {
    setUp(() {
      Localization.load({
        'hello': 'Hello',
        'greeting': '{value} user',
        'plural': {
          'zero': 'zero user',
          'one': 'one user',
          'two': 'two users',
          'few': 'few users',
          'many': 'many users',
          'other': 'other users',
        },
        'nested': {
          'welcome': 'Welcome',
        },
      });
    });

    //TODO can't test because of static method SUGGESTION: use dependency injection
    // group('load', () {
    //   test('should load translations', () {
    //     expect(Localization.instance._translations.containsKey('hello'), isTrue);
    //   });
    // });

    group('translate', () {
      test('should return correct translation for a key', () {
        expect(Localization.instance.translate('hello'), equals('Hello'));
      });

      test('should return key if translation not found', () {
        expect(Localization.instance.translate('nonexistent'),
            equals('nonexistent'));
      });

      test('should replace args in translation', () {
        expect(
            Localization.instance.translate('greeting', args: {'value': '1'}),
            equals('1 user'));
      });
    });

    group('plural', () {
      test('should return correct plural form', () {
        expect(Localization.instance.plural('plural', 0), equals('zero user'));
        expect(Localization.instance.plural('plural', 1), equals('one user'));
        expect(Localization.instance.plural('plural', 2), equals('two users'));
        expect(Localization.instance.plural('plural', 3), equals('other users'));
        // TODO the plural key indicators indicate  you should use string not number
        // expect(
        //     Localization.instance.plural('plural', 10), equals('many users'));
        // expect(
        //     Localization.instance.plural('plural', 100), equals('other users'));
      });

      test('should return key if plural forms not found', () {
        expect(Localization.instance.plural('nonexistent', 1),
            equals('nonexistent'));
      });
    });

    //TODO can't test because of private method SUGGESTION: make public
    // group('_putArgs', () {
    //   test('should replace arguments in template', () {
    //     var result = Localization.instance._putArgs('Hello $name', 1, args: {'name': 'World'});
    //     expect(result, equals('Hello World'));
    //   });
    // });

    //TODO can't test because of private method SUGGESTION: make public
    // group('_assignArguments', () {
    //   test('should assign arguments to the translation string', () {
    //     var result = Localization.instance._assignArguments('Hello $name', {'name': 'World'});
    //     expect(result, equals('Hello World'));
    //   });
    // });

    //TODO can't test because of private method SUGGESTION: make public
    // group('_getTranslation', () {
    //   test('should get translation for a key', () {
    //     var result = Localization.instance._getTranslation('hello', Localization.instance._translations);
    //     expect(result, equals('Hello'));
    //   });
    // });

    //TODO can't test because of private method SUGGESTION: make public
    // group('_getAllPluralForms', () {
    //   test('should get all plural forms for a key', () {
    //     var result = Localization.instance._getAllPluralForms('greeting', Localization.instance._translations);
    //     expect(result, contains('one'));
    //     expect(result, contains('other'));
    //   });
    // });

    //TODO can't test because of static method SUGGESTION: use dependency injection
    // group('getValueAtKeyPath', () {
    //   test('should return correct value for a nested key', () {
    //     expect(Localization.instance.getValueAtKeyPath('nested.welcome'), equals('Welcome'));
    //   });

    //   test('should return null for a non-existent key', () {
    //     expect(Localization.instance.getValueAtKeyPath('nested.nonexistent'), isNull);
    //   });
    // });
  });
}
