import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/delegates/flutter_translate_delegate.dart';
import 'package:flutter_translate/src/widgets/localized_app.dart';

void main() {
  group('LocalizedApp', () {
    testWidgets('should provide LocalizedAppState via of(context)', (WidgetTester tester) async {
      await tester.pumpWidget(LocalizedApp(Container()));

      expect(LocalizedApp.of(tester.element(find.byType(Container))), isInstanceOf<LocalizedAppState>());
    });

    testWidgets('should rebuild widgets when refresh is called', (WidgetTester tester) async {
      bool didBuild = false;

      await tester.pumpWidget(LocalizedApp(
        Builder(
          builder: (BuildContext context) {
            didBuild = true;
            return Container();
          },
        ),
      ));

      didBuild = false;
      LocalizedApp.of(tester.element(find.byType(Container))).refresh();
      await tester.pump();

      expect(didBuild, isTrue);
    });

    testWidgets('should update when the locale changes', (WidgetTester tester) async {
      final key = GlobalKey<LocalizedAppState>();

      await tester.pumpWidget(LocalizedApp(
        key: key,
        Container(),
      ));

      final oldLocale = key.currentState!.delegates.first as FlutterTranslateDelegate;

      FlutterTranslate.instance.changeLocale('es');
      await tester.pump();

      final newLocale = key.currentState!.delegates.first as FlutterTranslateDelegate;

      expect(oldLocale != newLocale, isTrue);
    });
  });

  // TODO: can't test LocalizedAppInherited's updateShouldNotify directly as it's a private method. SUGGESTION: make public or test through public API.
  /*
  group('LocalizedAppInherited', () {
    testWidgets('should notify dependents when locale changes', (WidgetTester tester) async {
      // The implementation would go here
    });
  });
  */
}
