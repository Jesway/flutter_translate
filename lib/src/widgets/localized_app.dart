import 'package:flutter/widgets.dart';
import 'package:flutter_translate_community/flutter_translate_community.dart';

class LocalizedApp extends StatefulWidget {
  final Widget child;

  final LocalizationDelegate delegate;

  LocalizedApp(this.delegate, this.child);

  LocalizedAppState createState() => LocalizedAppState();

  static LocalizedApp of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<LocalizedApp>()!;
}
