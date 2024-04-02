import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/extensions/build_context_extensions.dart';
import 'package:flutter_translate/src/widgets/localized_app.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'build_context_extensions_test.mocks.dart';

@GenerateMocks([BuildContext])
void main() {
  group('BuildContextExtensions', () {
    late MockBuildContext mockContext;

    setUp(() {
      mockContext = MockBuildContext();
    });

    test('locale should return currentLocale from FlutterTranslate', () {
      // Implementation of test would go here
    });

    test('supportedLocales should return supportedLocales from FlutterTranslate', () {
      // Implementation of test would go here
    });

    // TODO flaky test
    // test('localizationDelegates should return delegates from LocalizedApp', () {
    //   when(mockContext.dependOnInheritedWidgetOfExactType<LocalizedAppInherited>()).thenReturn(LocalizedAppInherited(data: LocalizedAppState(), currentLocale: Locale('en'), child: Container()));
    //   expect(mockContext.localizationDelegates, isInstanceOf<List<LocalizationsDelegate>>());
    // });
  });
}
