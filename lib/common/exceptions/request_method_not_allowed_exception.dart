/// Exception thrown when a request is made with an HTTP method that
/// is not allowed.
class RequestMethodNotAllowedException implements Exception {
  /// Creates a new instance of [RequestMethodNotAllowedException]
  /// with the given [message].
  RequestMethodNotAllowedException(this.message);

  /// The error message associated with this exception.
  final String? message;

  @override
  String toString() => 'RequestMethodNotAllowedException: $message';
}
