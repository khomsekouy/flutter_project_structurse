// requestCancelledException
class RequestCancelledException implements Exception {
  /// Creates a new instance of [RequestCancelledException]
  /// with the given [message].
  RequestCancelledException(this.message);
  final String? message;

  @override
  String toString() => 'RequestCancelledException: $message';
}
