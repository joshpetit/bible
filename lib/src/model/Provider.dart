import 'package:bible/src/model/PassageQuery.dart';

abstract class Provider {
  final bool _requiresKey;
  final Set<String> _versions;

  Provider(this._requiresKey, this._versions);
  bool containsVersion(String version) => _versions.contains(version);
  bool get requiresKey => _requiresKey;

  PassageQuery getPassage(String query);
}
