import 'package:dio/dio.dart';

import '../../provider/storage/token_storage/token_storage_provider.dart';




class AuthenticationQueuedInterceptor extends QueuedInterceptor {
  AuthenticationQueuedInterceptor({
    required TokenStorageProvider tokenStorage,
    required String baseUrl,
    bool isRequireAuth = true,
  })  : _tokenStorage = tokenStorage,
        _baseUrl = baseUrl,
        _isRequireAuth = isRequireAuth;

  final String _baseUrl;
  final TokenStorageProvider _tokenStorage;
  final bool _isRequireAuth;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isRequireAuth) {
      final token = await _tokenStorage.readToken();
      final accessToken = token[0];
      final refreshToken = token[1];
      if (accessToken != '') {
        final tokenDuration = await _tokenStorage.getAccessTokenDuration();

        // if less than 60 seconds left, refresh token
        if (tokenDuration.inSeconds < 60) {
          try {
            final response = await Dio(
              BaseOptions(
                headers: {
                  'Content-Type': 'application/json',
                },
              ),
            ).post<Map<String, dynamic>>(
              '$_baseUrl/driver/auth/refresh-token',
              data: {
                'refresh_token': refreshToken,
                'token': accessToken,
              },
              options: Options(
                headers: {
                  'Authorization': 'Bearer $accessToken',
                },
              ),
            );

            if (response.statusCode == 200) {
              // save new token
              if (response.data!['success'] as bool) {
                final accessToken = response.data!['data']['access_token'];
                final refreshToken = response.data!['data']['refresh_token'];

                if (accessToken is! String && refreshToken is! String) {
                  throw DioError(requestOptions: options);
                }

                await _tokenStorage.writeToken(
                  accessToken: accessToken as String,
                  refreshToken: refreshToken as String,
                );

                options.headers['authorization'] = 'Bearer $accessToken';
                return handler.next(options);
              } else {
                await _tokenStorage.clearAccessToken();
                throw DioError(requestOptions: options);
              }
            } else {
              await _tokenStorage.clearAccessToken();
              throw DioError(requestOptions: options);
            }
          } on DioException {
            return handler.next(options);
          }
        } else {
          options.headers['authorization'] = 'Bearer $accessToken';
          return handler.next(options);
        }
      } else {
        return handler.next(options);
      }
    } else {
      handler.next(options);
    }
  }
}
