import "package:dio/dio.dart";
import "package:klyr/data/exception/authexception.dart";
import "package:klyr/data/localdb/authdb.dart";

class Authclient {
  static final Dio _authclient = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:3003/klyr/api',
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  static Dio get instance {
    _authclient.interceptors.clear();
    _authInterceptor();
    return _authclient;
  }

  static void _authInterceptor() {
    _authclient.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = "Bearer $token";
          }
          handler.next(options);
        },

        onError: (error, handler) async {
          if (error.response?.statusCode == 401 &&
              (error.response?.data['message'] == 'access-token-expired' ||
                  error.response?.data['message'] == 'invalid-token')) {
            final refreshed = await _refresh();
            if (refreshed) {
              final token = await TokenStorage.getAccessToken();
              error.requestOptions.headers['Authorization'] = 'Bearer $token';
              handler.resolve(await _authclient.fetch(error.requestOptions));
              return;
            } else {
              handler.reject(
                DioException(
                  requestOptions: error.requestOptions,
                  error: UnauthorizedException(),
                ),
              );
              return;
            }
          }
          handler.next(error);
        },
      ),
    );
  }

  static Future<bool> _refresh() async {
    try {
      final refreshToken = await TokenStorage.getRefreshToken();
      final response = await Dio().post(
        // plain Dio, no interceptor to avoid loop
        'http://10.0.2.2:3003/klyr/api/auth/refersh',
        data: {'refresh_token': refreshToken},
      );
      await TokenStorage.saveTokens(
        accessToken: response.data['tokens']['access_token'],
        refreshToken: response.data['tokens']['refresh_token'],
      );
      return true;
    } catch (_) {
      return false;
    }
  }
}
