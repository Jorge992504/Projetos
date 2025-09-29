import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ichat/app/core/keys/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final RequestOptions(:headers, :extra) = options;
    const authHeaderKey = "Authorization";
    headers.remove(authHeaderKey);
    final sp = await SharedPreferences.getInstance();
    headers.addAll({authHeaderKey: 'Bearer ${sp.getString(Keys.token)}'});
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final DioException(requestOptions: RequestOptions(:extra), :response) = err;
    if (extra case {'DIO_AUTH_KEY': true}) {
      if (response != null && response.statusCode == HttpStatus.forbidden ||
          response?.statusCode == 403) {
        return handler.next(err);
      }
    }
    return handler.next(err);
  }
}
