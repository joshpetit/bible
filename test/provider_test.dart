import 'package:bible/bible.dart';
import 'package:bible/src/api/Provider.dart';
import 'package:test/test.dart';
import 'secrets.dart';

void main() {
  group('Test Bible', () {
    setUp(() {
      Bible.addKeys({'esvapi': 'esvKey', 'asvapi': 'asvKey'});
    });

    test('Keys can be queried ', () {
      expect(Bible.getKey('esvapi'), equals('esvKey'));
      expect(Bible.getKey('asvapi'), equals('asvKey'));
    });
  });

  group('Test Provider', () {
    test('Tests that the provider has the correct initialization', () {});
  });

  group('Test API Providers', () {
    setUp(() {
      var keys = getKeys();
      Bible.addKeys(keys);
    });

    test('ESV API', () {
      var passage = Bible.queryPassage('Genesis 1:1',
          provider: Bible.ESV, parameters: {'include-verse-numbers': 'true'});
      passage.then((x) => {
            expect(
                x.passage,
                equals(
                    '[1] In the beginning, God created the heavens and the earth.')),
          });
      passage = Bible.queryPassage('Genesis 1:1');
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
