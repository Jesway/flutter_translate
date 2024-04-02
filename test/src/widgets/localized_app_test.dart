import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/delegates/flutter_translate_delegate.dart';
import 'package:flutter_translate/src/widgets/localized_app.dart';

void main() {
  const String localeEn = 'en';
  const Map<String, dynamic> enLocalizations = {
    "apples": {"zero": "no apples", "one": "one apple", "other": "some apples"}
  };
    const Map<String, dynamic> esLocalizations = {
    "apples": {"zero": "nunca manzanas", "one": "una  manzana", "other": "otros mazanas"}
  };

  setUpAll(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
      final String key = utf8.decode(message!.buffer.asUint8List());
      if (key == 'AssetManifest.json') {
        return ByteData.view(utf8
            .encode(json.encode({"assets/i18n/$localeEn.json": []}))
            .buffer);
      } else if (key == 'assets/i18n/$localeEn.json') {
        return ByteData.view(utf8.encode(json.encode(enLocalizations)).buffer);
      } else if (key == 'assets/i18n/es.json') {
        return ByteData.view(utf8.encode(json.encode(esLocalizations)).buffer);
      }
      return null;
    });

    await FlutterTranslate.initialize(FlutterTranslateOptions(
      supported: ["en", "es"],
      fallback: "en",
      loader: AssetsLoaderOptions(path: 'assets/i18n/'),
    ));
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', null);
  });
  group('LocalizedApp', () {
    testWidgets('should provide LocalizedAppState via of(context)',
        (WidgetTester tester) async {
      await tester.pumpWidget(LocalizedApp(Container()));

      expect(LocalizedApp.of(tester.element(find.byType(Container))),
          isInstanceOf<LocalizedAppState>());
    });

    testWidgets('should rebuild widgets when refresh is called',
        (WidgetTester tester) async {
      bool didBuild = false;

      await tester.pumpWidget(LocalizedApp(
        Builder(
          builder: (BuildContext context) {
            didBuild = true;
            return Container();
          },
        ),
      ));

      LocalizedApp.of(tester.element(find.byType(Container))).refresh();
      await tester.pump();

      expect(didBuild, isTrue);
    });

    testWidgets('should update when the locale changes',
        (WidgetTester tester) async {
      final key = GlobalKey<LocalizedAppState>();

      await tester.pumpWidget(LocalizedApp(
        key: key,
        Container(),
      ));

      FlutterTranslate.instance.changeLocale('es');
      await tester.pump();


    });
  });


}
