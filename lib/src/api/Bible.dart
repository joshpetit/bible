import 'package:bible/src/model/PassageQuery.dart';
import 'package:reference_parser/reference_parser.dart';
import 'BibleProvider.dart';
import 'package:bible/providers.dart';

class Bible {
  static final Map _keys = <String, String>{};
  static final List<BibleProvider> _providers = [
    ESVAPI(),
    GetBible(),
  ];
  static final Map<String, BibleProvider> _namedProviders = {};
  static final Map<String, BibleProvider> _defaultProviders = {
    'esv': _providers[0],
    'asv': _providers[1],
  };
  static final Map<String, List<BibleProvider>> _availableProviders = {};

  /// Adds a [BibleProvider] to the list of available providers.
  ///
  /// You can implement your own provider by extending the
  /// [BibleProvider] class and then implementing the constructor and
  /// [BibleProvider.getPassage] command. This would be useful in circumstances
  /// where you would like to be able to switch out versions but don't
  /// have a certain API in the [providers] library. If you do this please consider
  /// sending a pull request and adding your provider to the [providers] library!
  static void addProvider(BibleProvider provider, List<String> versions) {
    versions.forEach((version) => {
          _availableProviders.putIfAbsent(version, () => <BibleProvider>[]),
          _availableProviders[version].add(provider)
        });
    _namedProviders.putIfAbsent(provider.name, () => provider);
  }

  /// Returns the default [BibleProvider] for a version.
  ///
  /// The default provider is the provider used in cases
  /// where a provider is not explicitly passed in the
  /// [queryPassage] parameters.
  static BibleProvider getDefaultProvider(String version) =>
      _defaultProviders[version] ?? _availableProviders[version][0];

  /// Returns the [BibleProvider] based on name.
  ///
  /// See the [providers] library for the list of
  /// available [BibleProvider]s and their names.
  static BibleProvider getProvider(String provider) =>
      _namedProviders[provider.toLowerCase];

  /// Returns a list of all the [BibleProvider]s.
  ///
  /// [Bible] comes with a list of providers which
  /// can be used within the [queryPassage] method.
  static List<BibleProvider> get providers => _providers;

  /// Returns the key for a [BibleProvider].
  static String getKey(String provider) {
    return _keys[provider];
  }

  /// Adds API key to the Bible Map.
  ///
  /// The key of the map must be the name of the
  /// bible provider in lowercase single-word format
  /// i.e 'Esv API' -> 'esvapi'. See the read me or
  /// the [providers] library for the registered name
  /// of every API.
  static void addKeys(Map<String, String> keys) {
    _keys.addAll(keys);
  }

  /// Query a provider for a bible passage.
  ///
  /// [Bible] will use the recommended/default query
  /// provider if the provider is not specified in the optional
  /// parameter. If an adequet provider is not found to supply
  /// the version request or if the reference is invalid, a
  /// null value will be returned.
  static Future<PassageQuery> queryPassage(String queryReference,
      {version = 'asv',
      BibleProvider provider,
      Map<String, String> parameters,
      String providerName,
      String key}) {
    if (provider == null && providerName != null) {
      provider = getProvider(providerName);
    }
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
