import 'case_style.dart';
import 'constants.dart';

class TranslateKeysOptions {
  final String path;
  final CaseStyle caseStyle;

  const TranslateKeysOptions({
    this.path = Constants.localizedAssetsPath,
    this.caseStyle = CaseStyle.camelCase,
  })  : assert(path != null),
        assert(caseStyle != null);
}
