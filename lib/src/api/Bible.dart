import 'package:bible/src/model/PassageQuery.dart';
import 'package:reference_parser/reference_parser.dart';
import 'Provider.dart';

class Bible {
  static final ESV = Provider.getDefaultProvider('esv');
  static final Map _keys = <String, String>{};

  static addKeys(Map<String, String> keys) {
    _keys.addAll(keys);
  }

  static String getKey(String provider) {
    return _keys[provider];
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
      provider = Provider.getDefaultProvider(version);
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
