import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';

abstract class LocalizationLoader {
  FlutterTranslateOptions options;

  LocalizationLoader(this.options);

  Future<Map<String, dynamic>?> load(Locale locale);
}
