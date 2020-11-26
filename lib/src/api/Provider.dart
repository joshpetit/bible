import 'package:bible/src/model/PassageQuery.dart';

abstract class Provider {
  final bool _requiresKey;
  final Set<String> _versions;
  final String name;

  static final List<Provider> _providers = [
    ESVAPI(),
  ];

  static final Map<String, Provider> _namedProviders = {};

  static final Map<String, Provider> _defaultProviders = {
    "esv": _namedProviders['esvapi']
  };

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

  static getDefaultProvider(String version) => _defaultProviders[version];
  static getProvider(String provider) => _namedProviders[provider.toLowerCase];
  PassageQuery getPassage(String query);
}

class ESVAPI extends Provider {
  ESVAPI() : super("esvapi", true, {'esv'});

  @override
  PassageQuery getPassage(String query) {
    return null;
  }
}
