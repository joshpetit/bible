import 'package:bible/bible.dart';

void main() {
  Bible.addKeys({'esvapi': 'APITOKEN'});
  var passage = Bible.queryPassage('John 3:16');
}
