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

  PassageQuery.fromProvider(this.query, this.passage, this.reference);

  @override
  String toString() {
    return '${reference}\n${passage}';
  }
}
