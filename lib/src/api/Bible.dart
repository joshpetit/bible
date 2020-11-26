import 'package:bible/model/PassageQuery.dart';

class Bible {
  static PassageQuery queryPassage(String queryReference) {
    var ref = parseReference(queryReference);
    if (!ref.isValid) {
      return null;
    }
    var reference = ref.reference;
  }
}
