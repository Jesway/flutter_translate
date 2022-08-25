import 'package:flutter/widgets.dart';
import 'package:flutter_translate_community/flutter_translate_community.dart';

class LocalizationProvider extends InheritedWidget {
  final LocalizedAppState state;

  final Widget child;

  LocalizationProvider({Key? key, required this.child, required this.state})
      : super(key: key, child: child);

  static LocalizationProvider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<LocalizationProvider>())!;

  @override
  bool updateShouldNotify(LocalizationProvider oldWidget) => true;
}
