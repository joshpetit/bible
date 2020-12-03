import 'package:bible/src/model/PassageQuery.dart';
import 'package:reference_parser/reference_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Bible.dart';
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
      "passage": query.reference,
      "version": version,
    };
    final uri = Uri.https('getbible.net', '/json', params);
    final res = await http.get(uri);
    print(res);
    var json = jsonDecode(res.body.substring(1, res.body.length - 2));
    JsonEncoder encoder = JsonEncoder.withIndent('  ');
    String pp = encoder.convert(json);
    print(pp);
    return null;
  }
}
