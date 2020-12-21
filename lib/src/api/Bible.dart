import 'package:bible/src/model/PassageQuery.dart';
import 'package:reference_parser/reference_parser.dart';
import 'BibleProvider.dart';
import 'package:bible/providers.dart';

/// The API keys saved by the user.
final Map _keys = <String, String>{};

/// The usable bible sources.
final List<BibleProvider> _providers = [
  ESVAPI(),
  GetBible(),
];

/// The prefered way to fetch certain versions
final Map<String, String> _defaultProviders = {
  'esv': 'esvapi',
  'asv': 'getbible',
};

/// Adds a [BibleProvider] to the list of available providers.
///
/// You can implement your own provider by extending the
/// [BibleProvider] class and then implementing the constructor and
/// [BibleProvider.getPassage] command. This would be useful in circumstances
/// where you would like to be able to switch out versions but don't
/// have a certain API in the [providers] library. If you do this please consider
/// sending a pull request and adding your provider to the [providers] library!
void addProvider(BibleProvider provider, List<String> versions) {
  _providers.add(provider);
}

/// Returns the default [BibleProvider] for a version.
///
/// The default provider is the provider used in cases
/// where a provider is not explicitly passed in the
/// [queryPassage] parameters.
BibleProvider getDefaultProvider(String version) {
  var name = _defaultProviders[version];
  if (name == null) {
    return _providers.firstWhere((x) => x.containsVersion(version));
  }
  return _providers.firstWhere((x) => x.name == name);
}

/// Returns the [BibleProvider] based on name.
///
/// See the [providers] library for the list of
/// available [BibleProvider]s and their names.
BibleProvider getProvider(String provider) {
  return _providers.firstWhere((x) => x.name == provider.toLowerCase());
}

/// Get all the [BibleProvider]s available
List<BibleProvider> getProviders() => _providers;

/// Returns a list of all the [BibleProvider]s.
///
/// [Bible] comes with a list of providers which
/// can be used within the [queryPassage] method.
List<BibleProvider> get providers => _providers;

/// Returns the key for a [BibleProvider].
String getKey(String provider) {
  return _keys[provider];
}

/// Adds API key to the Bible Map.
///
/// The key of the map must be the name of the
/// bible provider in lowercase single-word format
/// i.e 'Esv API' -> 'esvapi'. See the read me or
/// the [providers] library for the registered name
/// of every API.
void addKeys(Map<String, String> keys) {
  _keys.addAll(keys);
}

/// Query a provider for a bible passage.
///
/// [Bible] will use the recommended/default query
/// provider if the provider is not specified in the optional
/// parameter. If an adequet provider is not found to supply
/// the version request or if the reference is invalid, a
/// null value will be returned.
Future<PassageQuery> queryPassage(String queryReference,
    {String version,
    BibleProvider provider,
    Map<String, String> parameters,
    useParser = true,
    String providerName,
    String key}) {
  if (provider == null && providerName != null) {
    provider = getProvider(providerName);
  }
  if (version != null) {
    provider ??= getDefaultProvider(version);
  }
  if (provider == null) {
    return null;
  }
  BibleReference ref;
  if (useParser) {
    var ref = parseReference(queryReference);
  }
  // Tries to parse the reference, if unable just use the original query.
  if (ref == null || !ref.isValid) {
    ref = Reference(queryReference);
  }

  key ??= getKey(provider.name);
  if (provider.requiresKey && key == null) {
    return null;
  }

  parameters ??= {};
  return provider.getPassage(ref,
      parameters: parameters, key: key, version: version);
}
