import 'package:bible/src/model/PassageQuery.dart';
import 'package:reference_parser/reference_parser.dart';
import 'BibleProvider.dart';
import 'package:bible/providers.dart';

class Bible {
  static final Map _keys = <String, String>{};
  static final List<BibleProvider> _providers = [
    ESVAPI(),
  ];
  static final Map<String, BibleProvider> _namedProviders = {};
  static final Map<String, BibleProvider> _defaultProviders = {
    'esv': _providers[0]
  };
  static final Map<String, List<BibleProvider>> _availableProviders = {};

  static void addProvider(BibleProvider provider, List<String> versions) {
    versions.forEach((version) => {
          _availableProviders.putIfAbsent(version, () => <BibleProvider>[]),
          _availableProviders[version].add(provider)
        });
    _namedProviders.putIfAbsent(provider.name, () => provider);
  }

  static BibleProvider getDefaultProvider(String version) =>
      _defaultProviders[version] ?? _availableProviders[version][0];

  static BibleProvider getProvider(String provider) =>
      _namedProviders[provider.toLowerCase];

  static List<BibleProvider> get providers => _providers;

  static String getKey(String provider) {
    return _keys[provider];
  }

  static void addKeys(Map<String, String> keys) {
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
      {version = 'esv',
      BibleProvider provider,
      Map<String, String> parameters,
      String key}) {
    provider ??= getDefaultProvider(version);
    if (provider == null || !provider.containsVersion(version)) {
      return null;
    }
    var ref = parseReference(queryReference);
    if (!ref.isValid) {
      return null;
    }

    key ??= Bible.getKey(provider.name);
    if (provider.requiresKey && key == null) {
      return null;
    }

    parameters ??= {};
    return provider.getPassage(ref,
        parameters: parameters, key: key, version: version);
  }
}
