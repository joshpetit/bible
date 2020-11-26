import 'package:bible/src/model/PassageQuery.dart';
import 'package:reference_parser/reference_parser.dart';
import 'Provider.dart';

class Bible {
  static final ESV = Provider.getDefaultProvider('esv');
  static final Map _keys = <String, String>{};

  static addKeys(Map<String, String> keys) {
    _keys.addAll(keys);
  }

  static PassageQuery queryPassage(String queryReference) {
    var ref = parseReference(queryReference);
    if (!ref.isValid) {
      return null;
    }
    var reference = ref.reference;
  }
}
