// malformedUrlException
/// An exception that is thrown when a URL is malformed or invalid.
class MalformedUrlException implements Exception {
  /// Creates a new instance of [MalformedUrlException]
  /// with the given [message].
  MalformedUrlException(this.message);
  final String? message;

  @override
  String toString() => 'MalformedUrlException: $message';
}
