import 'package:flutter/widgets.dart';
import 'localized_app_state.dart';

class LocalizationProvider extends InheritedWidget
{
    final LocalizedAppState state;

    final Widget child;

    LocalizationProvider({Key key, this.child, this.state}) : super(key: key, child: child);

    static LocalizationProvider of(BuildContext context) => (context.inheritFromWidgetOfExactType(LocalizationProvider) as LocalizationProvider);

    @override
    bool updateShouldNotify(LocalizationProvider oldWidget) => true;
}
