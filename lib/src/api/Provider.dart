import 'package:bible/src/model/PassageQuery.dart';

abstract class Provider {
  final bool _requiresKey;
  final Set<String> _versions;

  static final Map<String, Provider> _providers = {"esvapi": ESVAPI()};

  static final Map<String, Provider> _defaultProviders = {
    "esv": _providers['esvapi']
  };

  Provider(this._requiresKey, this._versions);
  bool containsVersion(String version) => _versions.contains(version);
  bool get requiresKey => _requiresKey;

  static getDefaultProvider(String version) => _defaultProviders[version];
  static getProvider(String provider) => _providers[provider.toLowerCase()];

  PassageQuery getPassage(String query);
}

class ESVAPI extends Provider {
  ESVAPI() : super(true, {'esv'});

  @override
  PassageQuery getPassage(String query) {
    return null;
  }
}
