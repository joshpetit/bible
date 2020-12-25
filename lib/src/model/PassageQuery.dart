class PassageQuery {
  String passage;
  String reference;
  String version;
  final Map<String, String> verses;

  /// Either the original response by the API
  /// or extra information from the query, possibly null
  final Map<String, dynamic> extra;

  PassageQuery.fromProvider(this.passage, this.reference, this.version,
      {this.verses, this.extra});

  @override
  String toString() {
    return '${reference}\n${passage}';
  }
}
