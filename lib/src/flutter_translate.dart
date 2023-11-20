import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/src/contexts/localization_context.dart';
import 'package:flutter_translate/src/extensions/string_extensions.dart';
import 'package:flutter_translate/src/models/locale_data.dart';
import 'package:flutter_translate/src/services/change_locale_service.dart';
import 'package:flutter_translate/src/services/fallback_locale_service.dart';
import 'package:flutter_translate/src/services/initial_locale_service.dart';
import 'package:flutter_translate/src/services/loaders/base/localization_loader.dart';
import 'package:flutter_translate/src/services/loaders/factories/localization_loader_factory.dart';
import 'package:flutter_translate/src/services/locale_persistence_service.dart';
import 'package:flutter_translate/src/services/localization_service.dart';
import 'package:flutter_translate/src/services/missing_localization_key_service.dart';
import 'package:flutter_translate/src/services/supported_locale_service.dart';
import 'package:flutter_translate/src/services/translation_service.dart';

class FlutterTranslate
{
    static final FlutterTranslate _instance = FlutterTranslate._();
    static FlutterTranslate get instance => _instance;
    FlutterTranslate._();
    
    bool _isInitialized = false;

    final LocalizationContext _context = LocalizationContext(LocaleData.undefined());

    late FlutterTranslateOptions _options;
    
    late TranslationService _translationService;
    late LocalizationService _localizationService;
    late FallbackLocaleService _fallbackLocaleService;
    late LocalizationLoader _loader;
    late InitialLocaleService _initialLocaleService;
    late MissingLocalizationKeyService _missingLocalizationKeyService;
    late ChangeLocaleService _changeLocaleService;
    late LocalePersistenceService _localePersistenceService;
    late SupportedLocaleService _supportedLocaleService;

    List<Locale> get supportedLocales => _options.supportedLocales;

    Locale get currentLocale => _context.current.locale;

    static Future<void> initialize(FlutterTranslateOptions options) async
    {
        if (_instance._isInitialized)
        {
            throw Exception("FlutterTranslate.initialize should only be called once.");
        }

        await _instance._initialize(options);
  
        _instance._isInitialized = true;
    }

    Future<void> _initialize(FlutterTranslateOptions options) async
    {                
        WidgetsFlutterBinding.ensureInitialized();

        _options = options;
        
        _loader = LocalizationLoaderFactory.createLoader(options);
        _localePersistenceService = LocalePersistenceService();
        _localizationService = LocalizationService(_loader, options);
        _fallbackLocaleService = FallbackLocaleService(_localizationService, options);
        _initialLocaleService = InitialLocaleService(_localizationService, _fallbackLocaleService, _localePersistenceService, options);
        _missingLocalizationKeyService = MissingLocalizationKeyService(_fallbackLocaleService, options);
        _translationService = TranslationService(_context);
        _supportedLocaleService = SupportedLocaleService(_options);
        _changeLocaleService = ChangeLocaleService(_localizationService, _fallbackLocaleService, _supportedLocaleService, _context);

        await _missingLocalizationKeyService.initialize();
        await _setupInitialLocale();
    }

    Future _setupInitialLocale() async
    {
        final initialLocale = await _initialLocaleService.getInitialLocale();

        await _changeLocaleService.changeLocale(initialLocale);
    }
    
    String translate(String key, {Map<String, dynamic>? args}) => _translationService.translate(key, args: args);

    String plural(String key, num value, {Map<String, dynamic>? args}) => _translationService.plural(key, value, args: args);

    Future changeLocale(String newLocale) => _changeLocaleService.changeLocale(newLocale.toLocale());
}