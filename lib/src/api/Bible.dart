import 'package:bible/src/model/PassageQuery.dart';
import 'package:reference_parser/reference_parser.dart';
import 'Provider.dart';
import 'ESVAPI.dart';

class Bible {
  static final Map _keys = <String, String>{};
  static final List<Provider> _providers = [
    ESVAPI(),
  ];
  static final Map<String, Provider> _namedProviders = {};
  static final Map<String, Provider> _defaultProviders = {"esv": _providers[0]};
  static final Map<String, List<Provider>> _availableProviders = {};

  static void addProvider(Provider provider, List<String> versions) {
    versions.forEach((version) => {
          _availableProviders.putIfAbsent(version, () => <Provider>[]),
          _availableProviders[version].add(provider)
        });
    _namedProviders.putIfAbsent(provider.name, () => provider);
  }

  static Provider getDefaultProvider(String version) =>
      _defaultProviders[version] ?? _availableProviders[version][0];

  static Provider getProvider(String provider) =>
      _namedProviders[provider.toLowerCase];

  static List<Provider> get providers => _providers;

  static String getKey(String provider) {
    return _keys[provider];
  }

  static addKeys(Map<String, String> keys) {
    _keys.addAll(keys);
  }

  /// Query a provider for a bible passage
  ///
  /// [Bible] will use the recommended/default query
  /// provider if the provider is not specified in the optional
  /// parameter. If an adequet provider is not found to supply
  /// the version request or if the reference is invalid, a
  /// null value will be returned.
  static Future<PassageQuery> queryPassage(String queryReference,
      {version: 'esv', Provider provider, Map<String, String> parameters}) {
    if (provider == null) {
      provider = getDefaultProvider(version);
    }
    if (provider == null || !provider.containsVersion(version)) {
      return null;
    }
    var ref = parseReference(queryReference);
    if (!ref.isValid) {
      return null;
    }
    parameters ??= {};
    return provider.getPassage(ref, parameters: parameters);
  }
}
