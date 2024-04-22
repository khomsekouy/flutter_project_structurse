// requestTimeoutException
class RequestTimeoutException implements Exception {
  /// Creates a new instance of [RequestTimeoutException]
  /// with the given [message].
  RequestTimeoutException(this.message);
  final String? message;

  @override
  String toString() => 'RequestTimeoutException: $message';
}
