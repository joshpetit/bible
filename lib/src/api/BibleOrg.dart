import 'package:bible/src/model/PassageQuery.dart';
import 'package:reference_parser/reference_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'BibleProvider.dart';

/// A free API service that requires no API key.
class BibleOrg extends BibleProvider {
  BibleOrg() : super('bibleorg', false, {'net'});

  /// Queries [bible.org](https://labs.bible.org/api_web_service).
  @override
  Future<PassageQuery> getPassage(BibleReference query,
      {Map<String, String> parameters, String key, String version}) async {
    final params = {
      'type': 'json',
      'passage': query.reference,
    };
    final uri = Uri.https('labs.bible.org', '/api/', params);
    final res = await http.get(uri);
    var json = jsonDecode(res.body);
    print(json);
    var passage = StringBuffer();
    var verses = <String, String>{};
    var extra = {
      'extra': json,
    };
    json.forEach((x) => {
          passage.write(x['text']),
          verses[x['verse']] = x['text'],
        });
    print(verses);
    return PassageQuery.fromProvider(passage.toString(), query.reference, 'NET',
        extra: extra, verses: verses);
  }
}
