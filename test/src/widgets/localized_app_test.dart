import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('LocalizedApp Tests', () {
    //TODO can't test because of static method SUGGESTION: use dependency injection
    // testWidgets('should create LocalizedApp with delegate and child',
    //     (WidgetTester tester) async {
    //   final LocalizationDelegate delegate = await LocalizationDelegate.create(
    //     fallbackLocale: 'en',
    //     supportedLocales: ['en', 'es'],
    //   );

    //   await tester.pumpWidget(LocalizedApp(delegate, Container()));

    //   expect(find.byType(LocalizedApp), findsOneWidget);
    //   expect(find.byType(Container), findsOneWidget);
    // });

    //TODO can't test because of static method SUGGESTION: use dependency injection
    // testWidgets('should access LocalizedApp instance using of(context)', (WidgetTester tester) async {
    //   final delegate = LocalizationDelegate(
    //     fallbackLocale: Locale('en'),
    //     supportedLocales: [Locale('en'), Locale('es')],
    //     supportedLocalesMap: {Locale('en'): '', Locale('es'): ''},
    //   );
    //   await tester.pumpWidget(LocalizedApp(delegate, Container()));
    //
    //   final context = tester.element(find.byType(Container));
    //   final instance = LocalizedApp.of(context);
    //
    //   expect(instance, isNotNull);
    //   expect(instance, isA<LocalizedApp>());
    // });

    //TODO can't test because of private method SUGGESTION: make public
    // group('createState', () {
    //   testWidgets('should create LocalizedAppState', (WidgetTester tester) async {
    //     final delegate = LocalizationDelegate(
    //       fallbackLocale: Locale('en'),
    //       supportedLocales: [Locale('en'), Locale('es')],
    //       supportedLocalesMap: {Locale('en'): '', Locale('es'): ''},
    //     );
    //     await tester.pumpWidget(LocalizedApp(delegate, Container()));
    //
    //     expect(find.byType(LocalizedAppState), findsOneWidget);
    //   });
    // });
  });
}
