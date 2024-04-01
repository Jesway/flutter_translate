import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.title});

  final String? title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _counter = 0;

  void _decrementCounter() => setState(() => _counter--);
  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    // var localizationDelegate = LocalizedApp.of(context).delegate;

    return Scaffold(
      appBar: AppBar(
        title: Text(translate('app_bar.title')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(translate('language.selected_message', args: {
              'language': translate(
                  'language.name.${FlutterTranslate.instance.currentLocale.languageCode}')
            })),
            Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 160),
                child: CupertinoButton.filled(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 36.0),
                  onPressed: () => _onActionSheetPress(context),
                  child: Text(translate('button.change_language')),
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(translatePlural('plural.demo', _counter))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.remove_circle),
                  iconSize: 48,
                  onPressed: _counter > 0
                      ? () => setState(() => _decrementCounter())
                      : null,
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle),
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

  void showDemoActionSheet(
      {required BuildContext context, required Widget child}) {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) => child).then((String? value) {
      if (value != null) {
        changeLocale(context, value);
      }
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
            child: Text(translate('language.name.en')),
            onPressed: () => Navigator.pop(context, 'en_US'),
          ),
          CupertinoActionSheetAction(
            child: Text(translate('language.name.es')),
            onPressed: () => Navigator.pop(context, 'es'),
          ),
          CupertinoActionSheetAction(
            child: Text(translate('language.name.ar')),
            onPressed: () => Navigator.pop(context, 'ar'),
          ),
          CupertinoActionSheetAction(
            child: Text(translate('language.name.ru')),
            onPressed: () => Navigator.pop(context, 'ru'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context, null),
          child: Text(translate('button.cancel')),
        ),
      ),
    );
  }
}
