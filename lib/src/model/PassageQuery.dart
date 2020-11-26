import 'package:reference_parser/reference_parser.dart';

class PassageQuery {
  final String query;
  String passage;
  String reference;
  bool isValid;

  PassageQuery(this.query) {
    var ref = parseReference(query);
    if (ref.isValid) {
      this.reference = ref.reference;
      isValid = true;
    } else {
      isValid = false;
    }
  }

  @override
  String toString() {
    return '${query}${reference}';
  }
}

void main() {
  var q = PassageQuery("jn 2:2");
  print(q);
}
