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

    test('Getbible', () async {
      var passage = await bible.queryPassage('Genesis 1:1-4',
          version: 'asv', providerName: 'getbible');

      expect(passage.verses.length, equals(4));
      expect(passage.extra, isNot(null));
      expect(passage.version, equals('ASV'));
    });

    test('ESV API', () async {
      if (bible.getKey('esvapi') == null) {
        return;
      }
      var passage = await bible.queryPassage('Genesis 1:1',
          providerName: 'esvapi',
          parameters: {'include-verse-numbers': 'true'});
      expect(
          passage.passage,
          equals(
              '[1] In the beginning, God created the heavens and the earth.'));
      expect(passage.version, equals('ESV'));
      passage = await bible.queryPassage(
        'Genesis 1:1',
        providerName: 'esvapi',
      );
      expect(passage.passage,
          equals('In the beginning, God created the heavens and the earth.'));
      expect(passage.version, equals('ESV'));
    });
  });
}

Map<String, String> getKeys() {
  return secrets.keys;
}
