import 'package:example/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

void main() async {
  await FlutterTranslate.initialize(FlutterTranslateOptions(
    initial: 'en',
    fallback: 'en',
    supported: ['en', 'es', 'ru', 'ar'],
    autoSave: true,
    missingKeyStrategy: MissingKeyStrategy.key,
    loader: AssetsLoaderOptions(),
  ));

  runApp(const LocalizedApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Translate',
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}
