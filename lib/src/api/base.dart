import 'package:http/http.dart' as http;
import 'dart:convert';

Future<http.Response> _fetchQuery(String query) async {
  final res = await http.get('http://getbible.net/json?scripture=${query}');
  if (res.statusCode == 200) {
    String body = res.body;
    var json = jsonDecode(body.substring(1, body.length - 2));
    var verses = json['book'][0]['chapter'];
    List<String> verseList = [];
    verses.forEach((x, y) => verseList.add(y['verse']));
    String passage = verseList.join(' ');
    print(passage);
  }
  return null;
}

Map<String, String> getVerse(String passage) {
  var q = _fetchQuery('john3:16-17');
}

void main() {
  getVerse("");
}
