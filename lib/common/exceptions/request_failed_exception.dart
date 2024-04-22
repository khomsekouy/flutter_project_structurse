// requestFailedException
class RequestFailedException implements Exception {
  /// Creates a new instance of [RequestFailedException] with the given
  /// [message].
  RequestFailedException(this.message);
  final String? message;

  @override
  String toString() => 'RequestFailedException: $message';
}

// bad request
class BadRequestException implements Exception {
  /// Creates a new instance of [BadRequestException] with the given [message].
  BadRequestException(this.message);
  final String? message;

  @override
  String toString() => 'BadRequestException: $message';
}

// processable entity exception
class UnprocessableEntityException implements Exception {
  /// Creates a new instance of [UnprocessableEntityException] with the given
  /// [message].
  UnprocessableEntityException(this.message);
  final List<String>? message;

  @override
  String toString() => 'UnprocessableEntityException: $message';
}
