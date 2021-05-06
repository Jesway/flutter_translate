import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'localization/keys.dart';

void main() async
{
  var delegate = await LocalizationDelegate.create(
          fallbackLocale: 'en_US',
          supportedLocales: ['en_US', 'es', 'fa', 'ar']);

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
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _counter = 0;

  void _decrementCounter() => setState(() => _counter--);

  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return Scaffold(
      appBar: AppBar(
        title: Text(translate(Keys.App_Bar_Title)),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(translate(Keys.Language_Selected_Message, args: {'language': translate(getCurrentLanguageLocalizationKey(localizationDelegate.currentLocale.languageCode))})),
            Padding(
                    padding: EdgeInsets.only(top: 25, bottom: 160),
                    child: CupertinoButton.filled(
                      child: Text(translate(Keys.Button_Change_Language)),
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 36.0),
                      onPressed: () => _onActionSheetPress(context),
                    )
            ),

            Padding(padding: const EdgeInsets.only(bottom: 10),
                    child: Text(translatePlural(Keys.Plural_Demo, _counter))
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

  void showDemoActionSheet({required BuildContext context, required Widget child}) {
    showCupertinoModalPopup<String>(
            context: context,
            builder: (BuildContext context) => child).then((String? value)
    {
      if(value != null)
      changeLocale(context, value);
    });
  }

  void _onActionSheetPress(BuildContext context) {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
        title: Text(translate(Keys.Language_Selection_Title)),
        message: Text(translate(Keys.Language_Selection_Message)),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(translate(Keys.Language_Name_En)),
            onPressed: () => Navigator.pop(context, 'en_US'),
          ),
          CupertinoActionSheetAction(
            child: Text(translate(Keys.Language_Name_Es)),
            onPressed: () => Navigator.pop(context, 'es'),
          ),
          CupertinoActionSheetAction(
            child: Text(translate(Keys.Language_Name_Fa)),
            onPressed: () => Navigator.pop(context, 'fa'),
          ),
          CupertinoActionSheetAction(
            child: Text(translate(Keys.Language_Name_Ar)),
            onPressed: () => Navigator.pop(context, 'ar'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(translate(Keys.Button_Cancel)),
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context, null),
        ),
      ),
    );
  }


  getCurrentLanguageLocalizationKey(String code)
  {
    switch(code)
    {
      case "en":
      case "en_US": return Keys.Language_Name_En;
      case "es": return Keys.Language_Name_Es;
      case "fa": return Keys.Language_Name_Fa;
      case "ar": return Keys.Language_Name_Ar;
      default: return null;
    }
  }
}
