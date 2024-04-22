/// An exception that is thrown when a request is forbidden by the server.
class RequestForbiddenException implements Exception {
  /// Creates a new instance of [RequestForbiddenException]
  /// with the given [message].
  RequestForbiddenException(this.message);

  /// The error message associated with this exception.
  final String? message;

  @override
  String toString() => 'RequestForbiddenException: $message';
}
