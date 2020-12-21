import 'package:bible/bible.dart' as bible;

void main() {
  bible.addKeys({'esvapi': 'APITOKEN'});
  var passage = bible.queryPassage('John 3:16');
  passage.then((x) => {
        print(x.passage),
      });
}
