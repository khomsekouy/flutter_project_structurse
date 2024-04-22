/// An exception that is thrown when a HTTP request returns an error
/// status code.
///
/// The [message] parameter is a description of the error, and the
/// [statusCode] parameter
/// is the HTTP status code returned by the server.
class HttpException implements Exception {
  HttpException(this.message, this.statusCode);
  final String? message;
  final int statusCode;

  @override
  String toString() => 'HttpException: $message ($statusCode)';
}
