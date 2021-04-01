import 'package:flutter/widgets.dart';
import 'localized_app_state.dart';

class LocalizationProvider extends InheritedWidget {
  final LocalizedAppState? state;

  final Widget child;

  const LocalizationProvider({Key? key, required this.child, this.state}) : super(key: key, child: child);

  static LocalizationProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<LocalizationProvider>();

  @override
  bool updateShouldNotify(LocalizationProvider oldWidget) => true;
}
