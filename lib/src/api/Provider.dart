import 'package:bible/src/model/PassageQuery.dart';
import 'package:reference_parser/reference_parser.dart';
import 'Bible.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class Provider {
  final bool _requiresKey;
  final Set<String> _versions;
  final String name;

  static final List<Provider> _providers = [
    ESVAPI(),
  ];

  static final Map<String, Provider> _namedProviders = {};

  static final Map<String, Provider> _defaultProviders = {"esv": _providers[0]};

  static final Map<String, List<Provider>> _availableProviders = {};

  Provider(this.name, this._requiresKey, this._versions) {
    _versions.forEach((version) => {
          Provider._availableProviders.putIfAbsent(version, () => <Provider>[]),
          Provider._availableProviders[version].add(this)
        });
    Provider._namedProviders.putIfAbsent(name, () => this);
  }

  bool containsVersion(String version) => _versions.contains(version);
  bool get requiresKey => _requiresKey;

  static Provider getDefaultProvider(String version) =>
      _defaultProviders[version];

  static Provider getProvider(String provider) =>
      _namedProviders[provider.toLowerCase];

  static List<Provider> getProviders() => _providers;

  PassageQuery getPassage(BibleReference query);
}

class ESVAPI extends Provider {
  ESVAPI() : super("esvapi", true, {'esv'});

  @override
  PassageQuery getPassage(BibleReference query) {
    PassageQuery res;
    queryESV(query).then((x) => res = x);
    print(res);
    return res;
  }

  Future<PassageQuery> queryESV(BibleReference query) async {
    final params = {
      'q': query.reference,
      'include-passage-references': 'false',
      'indent-poetry': 'false',
      'include-headings': 'false',
      'include-footnotes': 'false',
      'include-verse-numbers': 'false',
      'include-short-copyright': 'false',
      'include-passage-references': 'false'
    };
    final uri = Uri.https('api.esv.org', '/v3/passage/text/', params);
    final res = await http.get(uri, headers: {
      'Authorization': 'Token ${Bible.getKey('esvapi')}',
    });
    var json = jsonDecode(res.body);
    var passage = json['passages'].join(' ');
    return PassageQuery.fromProvider(query.reference, passage, query.reference);
  }
}
