import 'package:bible/bible.dart';
import 'package:bible/src/api/Provider.dart';
import 'package:test/test.dart';
import 'secrets.dart';

void main() {
  group('Test Provider', () {
    test('Tests that the provider has the correct initialization', () {
      var s = Provider.getDefaultProvider('esv');
      expect(s, equals(Bible.ESV));
    });
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
      passage = Bible.queryPassage('Genesis 1:1', provider: Bible.ESV);
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
