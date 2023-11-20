import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/delegates/flutter_translate_delegate.dart';

class LocalizedApp extends StatefulWidget 
{
    final Widget child;

    const LocalizedApp(this.child, {super.key});

    static LocalizedAppState of(BuildContext context) 
    {
        final inheritedWidget = context.dependOnInheritedWidgetOfExactType<LocalizedAppInherited>();

        assert(inheritedWidget != null, 'No LocalizedApp found in context');
        
        return inheritedWidget!.data;
    }

    @override
    LocalizedAppState createState() => LocalizedAppState();
}

class LocalizedAppState extends State<LocalizedApp> 
{
    final delegate = FlutterTranslateDelegate();

    List<LocalizationsDelegate> get delegates => [
        delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
    ];

    void refresh()
    {
        setState(() {});
    }

    @override
    Widget build(BuildContext context) 
    {
        return LocalizedAppInherited(
            data: this,
            currentLocale: FlutterTranslate.instance.currentLocale,
            child: widget.child,
        );
    }
}

class LocalizedAppInherited extends InheritedWidget 
{
    final LocalizedAppState data;
    final Locale currentLocale;

    const LocalizedAppInherited({
        super.key,
        required this.data,
        required this.currentLocale,
        required super.child,
    });

    @override
    bool updateShouldNotify(LocalizedAppInherited oldWidget) 
    {
        return oldWidget.currentLocale != currentLocale;
    }
}