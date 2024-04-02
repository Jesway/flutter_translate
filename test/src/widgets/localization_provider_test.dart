import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mockito/mockito.dart';

class MockLocalizedAppState extends Mock implements LocalizedAppState {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('LocalizationProvider Tests', () {
    testWidgets(
        'updateShouldNotify returns true when LocalizationProvider is updated',
        (WidgetTester tester) async {
      final MockLocalizedAppState state = MockLocalizedAppState();
      final LocalizationProvider provider = LocalizationProvider(
          key: UniqueKey(), child: Container(), state: state);

      await tester.pumpWidget(provider);

      final LocalizationProvider newProvider = LocalizationProvider(
          key: UniqueKey(), child: Container(), state: state);

      expect(provider.updateShouldNotify(newProvider), isTrue);
    });

    testWidgets('of method should return instance of LocalizationProvider',
        (WidgetTester tester) async {
      final MockLocalizedAppState state = MockLocalizedAppState();
      final Widget childWidget = Builder(
        builder: (BuildContext context) {
          LocalizationProvider.of(context);
          return Container();
        },
      );

      await tester
          .pumpWidget(LocalizationProvider(child: childWidget, state: state));

      expect(() => LocalizationProvider.of(MockBuildContext()), isNotNull);
    });
  });
}
