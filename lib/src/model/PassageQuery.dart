class PassageQuery {
  final String query;
  String passage;
  String reference;
  bool isValid;
  final Map<String, String> verses;

  /// Either the original response by the API
  /// or extra information from the query, possibly null
  final Map<String, dynamic> extra;

  PassageQuery.fromProvider(this.query, this.passage, this.reference,
      {this.verses, this.extra});

  @override
  String toString() {
    return '${reference}\n${passage}';
  }
}
