import 'package:bible/bible.dart' as Bible;
import 'package:test/test.dart';
import 'secrets.dart';

void main() {
  group('Test Bible', () {
    setUp(() {
      Bible.addKeys({'esvapi': 'esvKey', 'asvapi': 'asvKey'});
    });

    test('Keys can be queried', () {
      expect(Bible.getKey('esvapi'), equals('esvKey'));
    });
  });

  group('Test API Providers', () {
    setUp(() {
      var keys = getKeys();
      Bible.addKeys(keys);
    });

    test('GetBible', () {
      var passage = Bible.queryPassage('Genesis 1:1-4',
          version: 'asv', providerName: 'getbible');
      passage.then((x) =>
          {expect(x.verses.length, equals(4)), expect(x.extra, isNot(null))});
    });
    test('ESV API', () {
      var passage = Bible.queryPassage('Genesis 1:1',
          providerName: 'esvapi',
          parameters: {'include-verse-numbers': 'true'});
      passage.then((x) => {
            expect(
                x.passage,
                equals(
                    '[1] In the beginning, God created the heavens and the earth.')),
          });
      passage = Bible.queryPassage(
        'Genesis 1:1',
        providerName: 'esvapi',
      );
      passage.then((x) => {
            expect(
                x.passage,
                equals(
                    'In the beginning, God created the heavens and the earth.')),
          });
    });
  });
}

Map<String, String> getKeys() {
  return Secrets.keys;
}
