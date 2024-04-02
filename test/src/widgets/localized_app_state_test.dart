import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';


void main() {
  // TODO cannot test uses static method SUGGESTION remove static method
  // group('LocalizedAppState Tests', () {
  //   testWidgets('should build with LocalizationProvider',
  //       (WidgetTester tester) async {
  //     final LocalizationDelegate delegate = await LocalizationDelegate.create(
  //       fallbackLocale: 'en',
  //       supportedLocales: ['en', 'es'],
  //     );
  //     await tester.pumpWidget(LocalizedApp(delegate, Container()));

  //     expect(find.byType(LocalizationProvider), findsOneWidget);
  //   });

  //   testWidgets('onLocaleChanged should update state',
  //       (WidgetTester tester) async {
  //     final LocalizationDelegate delegate = await LocalizationDelegate.create(
  //       fallbackLocale: 'en',
  //       supportedLocales: ['en', 'es'],
  //     );
  //     await tester.pumpWidget(LocalizedApp(delegate, Container()));

  //     // Get the state of the LocalizedApp
  //     final state = tester.state<LocalizedAppState>(find.byType(LocalizedApp));

  //     // Initial state check before any action is taken
  //     expect(state.mounted, isTrue);

  //     // Call onLocaleChanged and then check if state has been updated
  //     state.onLocaleChanged();
  //     await tester.pump();

  //     // Additional checks can be added here if the state change results in any UI change
  //   });
  // });
}
