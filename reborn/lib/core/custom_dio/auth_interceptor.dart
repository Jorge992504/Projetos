import 'package:dio/dio.dart';
import 'package:reborn/core/custom_dio/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  late String token;
  late SharedPreferences sp;
  AuthInterceptor() {
    token = "";
    (() async {
      sp = await SharedPreferences.getInstance();
      token = sp.getString(Keys.token) ?? "";
    })();
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (token.isEmpty) {
      token = sp.getString(Keys.token) ?? "";
      if (token.isEmpty) {
        return handler.reject(DioException(requestOptions: options));
      }
    }
    options.headers['Authorization'] = 'Bearer $token';
    return handler.next(options);
  }
}
