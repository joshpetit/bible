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
    var verses = <String, String>{};
    var passage = StringBuffer();
    var refObj = query as Reference;
    var json = <String, dynamic>{};
    var extra = <String, dynamic>{};
    var ref = query.reference;
    if (refObj.startChapterNumber != refObj.endChapterNumber) {
      ref = '${refObj.startChapter.toString()}-${refObj.endChapterNumber}';
    }
    for (var i = refObj.startChapterNumber; i <= refObj.endChapterNumber; i++) {
      if (refObj.startChapterNumber != refObj.endChapterNumber) {
        params['passage'] = '${refObj.book} ${i}';
      }
      final uri = Uri.https('getbible.net', '/json', params);
      final res = await http.get(uri);
      // The response from the API isn't formated for Dart's json decoder
      json = jsonDecode(res.body.substring(1, res.body.length - 2));
      extra = json;
      var book = json['book'];
      if (book != null) {
        book = book[0];
      } else {
        book = json;
      }
      var chapter = book['chapter'];
      chapter.keys.forEach((x) {
        verses["${book['book_name']} ${book['chapter_nr']}:${chapter[x]['verse_nr']}"] =
            chapter[x]['verse'];
        passage.write(chapter[x]['verse'] + ' ');
      });
    }

    var jVersion = json['version'].toUpperCase();
    return PassageQuery.fromProvider(passage.toString().trim(), ref, jVersion,
        verses: verses, extra: extra);
  }
}
