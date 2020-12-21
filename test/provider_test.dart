import 'package:bible/bible.dart' as bible;
import 'package:test/test.dart';
import 'secrets.dart' as secrets;

void main() {
  group('Test bible', () {
    setUp(() {
      bible.addKeys({'esvapi': 'esvKey', 'asvapi': 'asvKey'});
    });

    test('Keys can be queried', () {
      expect(bible.getKey('esvapi'), equals('esvKey'));
    });
  });

  group('Test API Providers', () {
    setUp(() {
      var keys = getKeys();
      bible.addKeys(keys);
    });

    test('Getbible', () {
      var passage = bible.queryPassage('Genesis 1:1-4',
          version: 'asv', providerName: 'getbible');
      passage.then((x) =>
          {expect(x.verses.length, equals(4)), expect(x.extra, isNot(null))});
    });

    test('ESV API', () {
      if (bible.getKey('esvapi') == null) {
        return;
      }
      var passage = bible.queryPassage('Genesis 1:1',
          providerName: 'esvapi',
          parameters: {'include-verse-numbers': 'true'});
      passage.then((x) => {
            expect(
                x.passage,
                equals(
                    '[1] In the beginning, God created the heavens and the earth.')),
          });
      passage = bible.queryPassage(
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
  return secrets.keys;
}
