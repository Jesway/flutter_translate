import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/services/fallback_locale_service.dart';

class MissingLocalizationKeyService {
  FallbackLocaleService fallbackLocaleService;
  FlutterTranslateOptions options;

  MissingLocalizationKeyService(this.fallbackLocaleService, this.options);

  Future initialize() async {
    if (options.missingKeyStrategy == MissingKeyStrategy.fallback) {
      await fallbackLocaleService.loadFallbackLocaleData();
    }
  }
}
