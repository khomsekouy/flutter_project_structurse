import 'package:dio/dio.dart';

enum RefreshMethod { GET, POST }

enum TokenType { NONE, BEARER, BASIC }

class RefreshTokenInterceptor<T> extends QueuedInterceptor {
  RefreshTokenInterceptor({
    required this.url,
    this.requestHeaders,
    required this.accessToken,
    required this.onRequestSuccess,
    this.method = RefreshMethod.GET,
    required this.responseTokenKey,
    this.tokenType = TokenType.BEARER,
    this.expiration = const Duration(minutes: 30),
  });

  final String url;
  final String accessToken;
  final Duration expiration;
  final TokenType tokenType;
  final RefreshMethod method;
  final String responseTokenKey;
  final Map<String, dynamic>? requestHeaders;
  final void Function(T dynamic) onRequestSuccess;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // check if expiration is equal or less than 30 minutes
      if (options.uri.path == url && expiration.inMinutes <= 30) {
        // refresh token
        final response = await Dio().request<T>(
          url,
          options: Options(
            method: method == RefreshMethod.GET ? 'GET' : 'POST',
            headers: requestHeaders,
          ),
        );

        // check if refresh token is successful
        if (response.statusCode == 200) {
          // call onRequestSuccess callback
          onRequestSuccess(response.data as T);

          // update authorization header
          if (response.data != null) {
            final data = response.data! as Map<String, dynamic>;

            // get key by separator '.' (dot) from responseTokenKey
            final keys = responseTokenKey.split('.');
            var token = '';
            // access token is nested by key like 'data.token' => data['data']
            // ['token']
            // keys = ['data', 'token',...] => data['data']['token']
            for (final key in keys) {
              token = data[key] as String;
            }

            // check token type
            switch (tokenType) {
              case TokenType.BEARER:
                options.headers['Authorization'] = 'Bearer $token';
                break;
              case TokenType.BASIC:
                options.headers['Authorization'] = 'Basic $token';
                break;
              case TokenType.NONE:
                options.headers['Authorization'] = token;
                break;
            }
          }

          handler.next(options);
        } else {
          handler.reject(
            DioException(
              requestOptions: options,
              error: 'Refresh token failed',
            ),
          );
        }
      } else {
        // check token type
        switch (tokenType) {
          case TokenType.BEARER:
            options.headers['Authorization'] = 'Bearer $accessToken';
            break;
          case TokenType.BASIC:
            options.headers['Authorization'] = 'Basic $accessToken';
            break;
          case TokenType.NONE:
            options.headers['Authorization'] = accessToken;
            break;
        }

        handler.next(options);
      }
    } catch (e) {
      // continue request even if refresh token fails
      handler.next(options);
    }
  }
}
