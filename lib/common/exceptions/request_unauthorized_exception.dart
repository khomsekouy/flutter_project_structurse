// requestUnauthorizedException
class RequestUnauthorizedException implements Exception {
  /// Creates a new instance of [RequestUnauthorizedException]
  /// with the given [message].
  RequestUnauthorizedException(this.message);
  final String? message;

  @override
  String toString() => 'RequestUnauthorizedException: $message';
}
