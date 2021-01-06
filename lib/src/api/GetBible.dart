import 'package:bible/src/model/PassageQuery.dart';
import 'package:reference_parser/reference_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'BibleProvider.dart';

/// A free API service that requires no API key.
class GetBible extends BibleProvider {
  GetBible()
      : super('getbible', false, {
          'akjv',
          'asv',
          'basicenglish',
          'douayrheims',
          'wb',
          'weymouth',
          'web',
          'ylt'
        });

  /// Queries [getbible.net](https://getbible.net/api).
  @override
  Future<PassageQuery> getPassage(BibleReference query,
      {Map<String, String> parameters, String key, String version}) async {
    final params = {
      'passage': query.reference,
      'version': version,
    };
    final uri = Uri.https('getbible.net', '/json', params);
    final res = await http.get(uri);
    // The response from the API isn't formated for Dart's json decoder
    var json = jsonDecode(res.body.substring(1, res.body.length - 2));
    var extra = json;
    var ref = query.reference;
    var jVersion = json['version'].toUpperCase();
    var book = json['book'];
    if (book != null) {
      book = book[0];
    } else {
      var encoder = new JsonEncoder.withIndent("  ");
      //print(encoder.convert(json['chapter']));
      book = json;
    }
    var chapter = book['chapter'];
    //print(chapter);
    if (chapter == null) {}
    var verses = <String, String>{};
    var passage = StringBuffer();
    chapter.keys.forEach((x) => {
          verses[x] = chapter[x]['verse'],
          passage.write(chapter[x]['verse'] + ' ')
        });
    return PassageQuery.fromProvider(passage.toString().trim(), ref, jVersion,
        verses: verses, extra: extra);
  }
}
