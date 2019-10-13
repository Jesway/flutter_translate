import 'package:flutter/widgets.dart';
import 'localized_app.dart';
import 'localization_provider.dart';

class LocalizedAppState extends State<LocalizedApp>
{
    void onLanguageChanged() => setState(() {});

    @override
    Widget build(BuildContext context) => LocalizationProvider(state: this, child: widget.child);

}
