import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/constants/constants.dart';
import 'package:flutter_translate/src/contexts/localization_context.dart';
import 'package:flutter_translate/src/models/locale_data.dart';
import 'package:flutter_translate/src/services/translation_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'translation_service_test.mocks.dart';

@GenerateMocks([LocalizationContext, LocaleData])
void main() {
  group('TranslationService Tests', () {
    late TranslationService translationService;
    late MockLocalizationContext mockContext;
    late MockLocaleData mockLocaleData;

    setUp(() {
      mockContext = MockLocalizationContext();
      mockLocaleData = MockLocaleData();
      translationService = TranslationService(mockContext);
      when(mockContext.current).thenReturn(mockLocaleData);
    });

    test('updateLocale should update the context', () {
      translationService.updateLocale(mockContext);
      // No assertion, just checking no exception is thrown
    });

    test('translate should return the key if translation is not found', () {
      when(mockLocaleData.localizations).thenReturn({});
      expect(translationService.translate('hello'), equals('hello'));
    });

    test('translate should return the translated string', () {
      when(mockLocaleData.localizations).thenReturn({'hello': 'Hello'});
      expect(translationService.translate('hello'), equals('Hello'));
    });

    test('plural should handle plural forms correctly', () {
      when(mockLocaleData.localizations).thenReturn({
        'days': {
          Constants.pluralZero: 'zero days',
          Constants.pluralOne: 'one day',
          Constants.pluralOther: 'many days',
        }
      });

      expect(translationService.plural('days', 0), equals('zero days'));
      expect(translationService.plural('days', 1), equals('one day'));
      expect(translationService.plural('days', 10), equals('many days'));
    });

    // TODO: can't test because _putArgs is a private method. SUGGESTION: make public
    /*
    group('_putArgs Tests', () {
      test('_putArgs should replace template values with arguments', () {
        final template = 'You have {{value}} messages';
        final result = translationService._putArgs(template, 5);
        expect(result, equals('You have 5 messages'));
      });
    });
    */

    // TODO: can't test because _assignArguments is a private method. SUGGESTION: make public
    /*
    group('_assignArguments Tests', () {
      test('_assignArguments should assign arguments to the translation', () {
        final translation = 'Hello, {name}';
        final args = {'name': 'John'};
        final result = translationService._assignArguments(translation, args);
        expect(result, equals('Hello, John'));
      });
    });
    */

    // TODO: can't test because _getTranslation is a private method. SUGGESTION: make public
    /*
    group('_getTranslation Tests', () {
      test('_getTranslation should return the translation for a key', () {
        when(mockLocaleData.localizations).thenReturn({'hello': 'Hello'});
        final result = translationService._getTranslation('hello', mockLocaleData.localizations);
        expect(result, equals('Hello'));
      });
    });
    */

    // TODO: can't test because _getAllPluralForms is a private method. SUGGESTION: make public
    /*
    group('_getAllPluralForms Tests', () {
      test('_getAllPluralForms should return all plural forms for a key', () {
        final localizations = {
          'days': {
            'one': 'one day',
            'other': 'many days',
          },
        };
        when(mockLocaleData.localizations).thenReturn(localizations);
        final result = translationService._getAllPluralForms('days', mockLocaleData.localizations);
        expect(result, equals(localizations['days']));
      });
    });
    */
  });
}
