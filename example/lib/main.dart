import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';

void main() async {
  var delegate = await LocalizationDelegate.create(
          fallbackLanguage: 'en', // required - fallback language in case the device language is not supported
          supportedLanguages: ['en', 'es_ES', 'fa'], // required - the list of supported languages, translation files are required to be present
          basePath: 'assets/i18n'); // optional - default is 'assets/i18n'

  runApp(LocalizedApp(delegate, MyApp()));
}

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _counter = 0;

  void _decrementCounter() => setState(() => _counter--);

  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('app_bar.title')),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton.filled(
              child: Text(translate('button.change_language')),
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 36.0),
              onPressed: () => _onActionSheetPress(context),
              ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                    child: Text(translatePlural('plural.demo', _counter))
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove_circle),
                  iconSize: 48,
                  onPressed: _counter > 0 ? () => setState(() => _decrementCounter()) : null,
                  ),
                IconButton(
                  icon: Icon(Icons.add_circle),
                  color: Colors.blue,
                  iconSize: 48,
                  onPressed: () => setState(() => _incrementCounter()),
                  ),
              ],
            )

          ],
        ),
      ),
    );
  }

  void showDemoActionSheet({BuildContext context, Widget child}) {

    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => child).then((String value)
      {
        changeLanguage(context, value);
      });
  }

  void _onActionSheetPress(BuildContext context) {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
        title: Text(translate('language.selection.title')),
        message: Text(translate('language.selection.message')),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(translate('language.name.english')),
            onPressed: () => Navigator.pop(context, 'en'),
            ),
          CupertinoActionSheetAction(
            child: Text(translate('language.name.spanish')),
            onPressed: () => Navigator.pop(context, 'es_ES'),
            ),
          CupertinoActionSheetAction(
            child: Text(translate('language.name.persian')),
            onPressed: () => Navigator.pop(context, 'fa'),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(translate('button.cancel')),
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context, null),
          ),
        ),
      );
  }
}
