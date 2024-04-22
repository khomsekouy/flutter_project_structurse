import 'dart:convert';

import 'package:dio/dio.dart';

import '../../common/exceptions/request_cancelled_exception.dart';
import '../../common/exceptions/request_failed_exception.dart';
import '../../common/exceptions/request_forbidden_exception.dart';
import '../../common/exceptions/request_method_not_allowed_exception.dart';
import '../../common/exceptions/request_not_found_exception.dart';
import '../../common/exceptions/request_timeout_exception.dart';
import '../../common/exceptions/request_unauthorized_exception.dart';
import '../../common/interceptors/authentication_queued_interceptor.dart';
import '../../common/interceptors/logger_interceptor.dart';
import '../storage/token_storage/token_storage_provider.dart';
import 'http_client.dart';

typedef ProgressCallback = void Function(int sent, int total);

class DioHttpClient implements HttpClient {
  DioHttpClient({
    required Dio dio,
    required String baseUrl,
    required TokenStorageProvider tokenStorageProvider,
    List<Interceptor>? interceptors
}) : _dio = dio,
  _baseUrl = baseUrl,
  _tokenStorageProvider = tokenStorageProvider,
  _interceptors = interceptors {
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 120);
    _dio.options.receiveTimeout = const Duration(seconds: 120);
    _dio.interceptors.add(LoggingInterceptor());
    if(_interceptors != null) {
      _dio.interceptors.addAll(_interceptors!);
    }
    _dio.interceptors.add(AuthenticationQueuedInterceptor(
      tokenStorage: _tokenStorageProvider,
      baseUrl: _baseUrl
    ));
  }

  final Dio _dio;
  final String _baseUrl;
  final TokenStorageProvider _tokenStorageProvider;
  final List<Interceptor>? _interceptors;
  // get method
  @override
  Future<Map<String, dynamic>> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return response.data!;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  // post method
  @override
  Future<Map<String, dynamic>> post(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
        dynamic body,
      }) async {
    try {
      final response = await _dio.post<dynamic>(
        path,
        queryParameters: queryParameters,
        data: body,
        options: Options(headers: headers),
      );

      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      } else {
        return jsonDecode(response.data as String) as Map<String, dynamic>;
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  // put method

  @override
  Future<Map<String, dynamic>> put(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
        dynamic body,
      }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      return response.data!;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  // path method
  @override
  Future<Map<String, dynamic>> patch(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
        dynamic body,
      }) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      return response.data!;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  // deleted method
  @override
  Future<Map<String, dynamic>> delete(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return response.data!;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // download file
  @override
  Future<void> downloadFile(
      String urlPath, {
        required String savePath,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
        required ProgressCallback onReceiveProgress,
      }) async {
    try {
      await _dio.download(
        urlPath,
        savePath,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // _header error
  Exception _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return RequestTimeoutException('Request Timeout');
    } else if (e.type == DioExceptionType.cancel) {
      return RequestCancelledException('Request Cancelled');
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return RequestTimeoutException('Receive Timeout');
    } else if (e.type == DioExceptionType.unknown) {
      final data = e.response?.data;
      switch (e.response!.statusCode) {
        case 400:
          return RequestFailedException(
            data['message'] as String? ?? 'Request Failed',
          );
        case 401:
          return RequestUnauthorizedException(
            data['message'] as String? ?? 'Request Unauthorized',
          );
        case 403:
          return RequestForbiddenException(
            data['message'] as String? ?? 'Request Forbidden',
          );
        case 404:
          return RequestNotFoundException(
            data['message'] as String? ?? 'Request Not Found',
          );
        case 405:
          return RequestMethodNotAllowedException(
            data['message'] as String? ?? 'Request Method Not Allowed',
          );
        default:
          return RequestFailedException(
            data['message'] as String? ?? 'Request Failed',
          );
      }
    } else {
      final data = e.response?.data;
      switch (e.response!.statusCode) {
        case 400:
          return BadRequestException(
            data['data']['message'] as String? ?? 'Request Failed',
          );
        case 401:
          return RequestUnauthorizedException(
            data['message'] as String? ?? 'Request Unauthorized',
          );
        case 403:
          return RequestForbiddenException(
            data['message'] as String? ?? 'Request Forbidden',
          );
        case 404:
          return RequestNotFoundException(
            data['message'] as String? ?? 'Request Not Found',
          );
        case 405:
          return RequestMethodNotAllowedException(
            data['message'] as String? ?? 'Request Method Not Allowed',
          );
        case 422:
        // return UnprocessableEntityException();
          final errors = data['data'] as Map<String, dynamic>;
          // loop through errors key
          final errorMessages = errors.keys.map((key) {
            final error = errors[key] as List<dynamic>;
            return error.join(', ');
          }).toList();
          return UnprocessableEntityException(errorMessages);
        default:
          return RequestFailedException(
            data['message'] as String? ?? 'Request Failed',
          );
      }
    }
  }
}
