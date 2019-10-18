# flutter_translate

[![Build Status](https://travis-ci.org/bratan/flutter_translate.svg)](https://travis-ci.org/bratan/flutter_translate)
[![License: MIT](https://img.shields.io/badge/License-MIT-ff69b4.svg)](https://github.com/bratan/flutter_translate/blob/master/LICENSE)
[![Flutter.io](https://img.shields.io/badge/Flutter-Website-deepskyblue.svg)](https://flutter.io/)

---

The internationalization (i18n) library for Flutter.

It lets you define translations for your content in different languages and switch between them easily.

| Package                                                                            | Pub                                                                                                    | Description |
| ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ | ----------- |
| [flutter_translate](https://github.com/bratan/flutter_translate/tree/master/packages/flutter_translate)                  | [![pub package](https://img.shields.io/pub/v/flutter_translate.svg?color=success)](https://pub.dev/packages/flutter_translate) | The flutter_translate core package. |
| [flutter_translate_preferences](https://github.com/bratan/flutter_translate/tree/master/packages/flutter_translate_preferences) | [![pub package](https://img.shields.io/pub/v/flutter_translate_preferences.svg?color=success)](https://pub.dev/packages/flutter_translate_preferences)  | Extension for automatically saving & restoring the selected locale. |
| [flutter_translate_gen](https://github.com/bratan/flutter_translate_gen)           | [WIP]  | Statically-typed localization keys generator for flutter_translate.|

## Example
<img src="https://raw.githubusercontent.com/bratan/flutter_translate/master/resources/gifs/flutter_translate_screen.gif" width="300"/>

## Table of Contents
  - [Installation](#installation)
  - [Configuration](#configuration)
  - [Usage](#usage)

## Installation

Add this to your package's pubspec.yaml file:

```sh
dependencies:
  flutter_translate: ^1.3.2
```

Install packages from the command line (or from your editor):

```sh
flutter pub get
```

## Configuration

Import flutter_translate:

```dart
import 'package:flutter_translate/flutter_translate.dart';
```

Place the *json* localization files in a folder of your choice within the project.

By default ```flutter_translate``` will search for localization files in the `assets/i18n` directory in your project's root.

Declare your assets localization directory in ```pubspec.yaml```

```sh
flutter:
  assets:
    - assets/i18n
```

In the main function create the localization delegate and start the app, wrapping it with LocalizedApp

```dart
void main() async
{
  var delegate = await LocalizationDelegate.create(
        fallbackLanguage: 'en',
        supportedLanguages: ['en', 'es_ES', 'fa']);

  runApp(LocalizedApp(delegate, MyApp()));
}
```

If the assets directory for the localization files is different than the default one (```assets/i18n```), you need to specify it:

```dart
void main() async
{
  var delegate = await LocalizationDelegate.create(
        fallbackLanguage: 'en',
        supportedLanguages: ['en', 'es_ES', 'fa'],
        basePath: 'assets/i18n/');

  runApp(LocalizedApp(delegate, MyApp()));
}
```

Example MyApp:

```dart
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
          title: 'Flutter Translate Demo',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            localizationDelegate
          ],
          supportedLocales: localizationDelegate.configuration.supportedLocales,
          locale: localizationDelegate.currentLocale,
          theme: ThemeData(primarySwatch: Colors.blue),
          home: MyHomePage(),
          ),
    );
  }
}
```

## Usage

Translate a string:

```dart
translate('your.localization.key');
```

Translate with arguments;

```dart
translate('your.localization.key', args: {'argName1': argValue1, 'argName2': argValue2});
```

Translate with pluralization:

```dart
translatePlural('plural.demo', yourNumericValue);
```

JSON:

```json
"plural": {
    "demo": {
        "0": "Please start pushing the 'plus' button.",
        "1": "You have pushed the button one time.",
        "else": "You have pushed the button {{value}} times."
    }
}
```

Change the language:

```dart
@override
Widget build(BuildContext context) {
...
  ...
    changeLanguage(context, 'en');
  ...
...
}
```

### You can view the full example here:

[https://github.com/bratan/flutter_translate/blob/master/packages/flutter_translate/example/lib/main.dart](https://github.com/bratan/flutter_translate/blob/master/packages/flutter_translate/example/lib/main.dart)
