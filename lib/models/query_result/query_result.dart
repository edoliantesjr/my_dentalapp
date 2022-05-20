class QueryResult {
  final bool success;
  final String? errorMessage;

  QueryResult._({required this.success, this.errorMessage});

  factory QueryResult.success() => QueryResult._(success: true);

  factory QueryResult.error(String message) =>
      QueryResult._(success: false, errorMessage: message);
}
