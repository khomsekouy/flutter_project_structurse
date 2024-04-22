typedef ProgressCallback = void Function(int count, int total);

abstract class HttpClient {
  Future<Map<String, dynamic>> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      });

  Future<Map<String, dynamic>> post(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
        Object? body,
      });

  Future<Map<String, dynamic>> put(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? body,
      });

  Future<Map<String, dynamic>> patch(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
        Object? body,
      });

  Future<Map<String, dynamic>> delete(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      });

  Future<void> downloadFile(
      String path, {
        required String savePath,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
        required ProgressCallback onReceiveProgress,
      });
}
