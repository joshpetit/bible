import 'package:bible/src/model/PassageQuery.dart';
import 'package:reference_parser/reference_parser.dart';
import 'package:bible/bible.dart';

abstract class BibleProvider {
  final bool _requiresKey;
  final Set<String> _versions;
  final String name;

  BibleProvider(this.name, this._requiresKey, this._versions);

  bool containsVersion(String version) => _versions.contains(version);

  bool get requiresKey => _requiresKey;

  List<String> get versions => _versions.toList();

  Future<PassageQuery> getPassage(BibleReference query,
      {Map<String, String> parameters, String key, String version});
}
