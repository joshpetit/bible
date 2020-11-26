import 'package:bible/model/PassageQuery.dart';

abstract class Provider {
  bool _requiresKey;
  String _version;

  String get version => _version;
  bool get requiresKey => _requiresKey;

  PassageQuery getPassage(String query);
}
