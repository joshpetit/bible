import 'package:bible/src/model/PassageQuery.dart';
import 'package:reference_parser/reference_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'BibleProvider.dart';

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

  @override
  Future<PassageQuery> getPassage(BibleReference query,
      {Map<String, String> parameters, String key, String version}) async {
    final params = {
      'passage': query.reference,
      'version': version,
    };
    final uri = Uri.https('getbible.net', '/json', params);
    final res = await http.get(uri);
    var json = jsonDecode(res.body.substring(1, res.body.length - 2));
    var extra = json;
    var ref = query.reference;
    var book = json['book'][0];
    var chapter = book['chapter'];
    var verses = <String, String>{};
    var passage = StringBuffer();
    chapter.keys.forEach((x) => {
          verses[x] = chapter[x]['verse'],
          passage.write(chapter[x]['verse'] + ' ')
        });
    return PassageQuery.fromProvider(passage.toString(), ref,
        verses: verses, extra: extra);
  }
}
