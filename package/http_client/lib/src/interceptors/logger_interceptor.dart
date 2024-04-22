import 'dart:developer';

import 'package:dio/dio.dart';

/// An interceptor that logs HTTP requests and responses using
/// the `dart:developer` library.
/// This interceptor logs the HTTP method, path,
/// and status code of each request and response.
/// It can be used with the `Dio` HTTP client by adding it
/// to the client's interceptors list.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    log('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    log('RESPONSE[${response.statusCode}] => PATH:'
        ' ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    log('ERROR[${err.response?.statusCode}] => '
        'PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }
}
