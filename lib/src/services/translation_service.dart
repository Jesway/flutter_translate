import 'package:flutter_translate/src/constants/constants.dart';
import 'package:flutter_translate/src/contexts/localization_context.dart';
import 'package:intl/intl.dart';

class TranslationService {
  LocalizationContext _context;

  TranslationService(this._context);

  void updateLocale(LocalizationContext context) {
    _context = context;
  }

  String translate(String key, {Map<String, dynamic>? args}) {
    var translation = _getTranslation(key, _context.current.localizations);

    if (translation != null && args != null) {
      translation = _assignArguments(translation, args);
    }

    return translation ?? key;
  }

  String plural(String key, num value, {Map<String, dynamic>? args}) {
    final forms = _getAllPluralForms(key, _context.current.localizations);

    return Intl.plural(
      value,
      zero: _putArgs(forms[Constants.pluralZero], value, args: args),
      one: _putArgs(forms[Constants.pluralOne], value, args: args),
      two: _putArgs(forms[Constants.pluralTwo], value, args: args),
      few: _putArgs(forms[Constants.pluralFew], value, args: args),
      many: _putArgs(forms[Constants.pluralMany], value, args: args),
      other: _putArgs(forms[Constants.pluralOther], value, args: args) ??
          '$key.${Constants.pluralOther}',
    );
  }

  String? _putArgs(String? template, num value, {Map<String, dynamic>? args}) {
    if (template == null) {
      return null;
    }

    template = template.replaceAll(Constants.pluralValueArg, value.toString());

    if (args == null) {
      return template;
    }

    for (String k in args.keys) {
      template = template!.replaceAll("{$k}", args[k].toString());
    }

    return template;
  }

  String _assignArguments(String value, Map<String, dynamic> args) {
    for (final key in args.keys) {
      value = value.replaceAll('{$key}', '${args[key]}');
    }

    return value;
  }

  String? _getTranslation(String key, dynamic localizations) {
    dynamic value = getValueAtKeyPath(key, localizations);
    if (value is String) {
      return value;
    }
    return null;
  }

  Map<String, String> _getAllPluralForms(String key, dynamic localizations) {
    dynamic value = getValueAtKeyPath(key, localizations);
    final result = <String, String>{};

    if (value is Map) {
      value.forEach((k, v) {
        if (v is String) {
          result[k] = v;
        }
      });
    }

    return result;
  }

  dynamic getValueAtKeyPath(String keyPath, [dynamic localizations]) {
    List<String> parts = keyPath.split('.');
    dynamic current = localizations ?? _context.current.localizations;
    for (String part in parts) {
      if (current is Map) {
        current = current[part];
      } else if (current is List) {
        int index = int.tryParse(part) ?? -1;
        if (index >= 0 && index < current.length) {
          current = current[index];
        } else {
          return null;
        }
      } else {
        return null;
      }
    }
    return current;
  }
}
