import 'package:bible/src/model/PassageQuery.dart';
import 'package:reference_parser/reference_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Bible.dart';
import 'Provider.dart';

class ESVAPI extends Provider {
  ESVAPI() : super("esvapi", true, {'esv'});

  @override
  Future<PassageQuery> getPassage(BibleReference query,
      {Map<String, String> parameters}) async {
    final params = {
      'q': query.reference,
      'include-passage-references':
          '${parameters['include-passage-references'] ?? 'false'}',
      'indent-poetry': '${parameters['indent-poetry'] ?? 'false'}',
      'include-headings': '${parameters['include-headings'] ?? 'false'}',
      'include-footnotes': '${parameters['include-footnotes'] ?? 'false'}',
      'include-verse-numbers':
          '${parameters['include-verse-numbers'] ?? 'false'}',
      'include-short-copyright':
          '${parameters['include-short-copyright'] ?? 'false'}',
      'include-passage-references':
          '${parameters['include-passage-references'] ?? 'false'}'
    };
    final uri = Uri.https('api.esv.org', '/v3/passage/text/', params);
    final res = await http.get(uri, headers: {
      'Authorization': 'Token ${Bible.getKey('esvapi')}',
    });
    var json = jsonDecode(res.body);
    var passage = json['passages'].join(' ').trim();
    return PassageQuery.fromProvider(
        json['canonical'], passage, query.reference,
        extra: json);
  }
}
