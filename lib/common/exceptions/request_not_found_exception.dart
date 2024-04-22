// requestNotFoundException
class RequestNotFoundException implements Exception {
  /// Creates a new instance of [RequestNotFoundException]
  /// with the given [message].
  RequestNotFoundException(this.message);
  final String? message;

  @override
  String toString() => 'RequestNotFoundException: $message';
}
