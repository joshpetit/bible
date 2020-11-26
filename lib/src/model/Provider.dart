import 'package:bible/src/model/PassageQuery.dart';

abstract class Provider {
  bool _requiresKey;
  Set<String> _versions;

  bool containsVersion(String version) => _versions.contains(version);
  bool get requiresKey => _requiresKey;

  PassageQuery getPassage(String query);
}
