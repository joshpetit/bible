import 'package:bible/src/model/PassageQuery.dart';
import 'package:reference_parser/reference_parser.dart';
import 'Bible.dart';

abstract class Provider {
  final bool _requiresKey;
  final Set<String> _versions;
  final String name;

  Provider(this.name, this._requiresKey, this._versions) {
    Bible.addProvider(this, _versions.toList());
  }

  bool containsVersion(String version) => _versions.contains(version);

  bool get requiresKey => _requiresKey;

  List<String> get versions => _versions.toList();

  Future<PassageQuery> getPassage(BibleReference query,
      {Map<String, String> parameters});
}
