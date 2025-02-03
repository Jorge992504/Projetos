import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ishopping/core/keys/LocalStorageKeys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handle) async {
    final RequestOptions(:headers, :extra) = options;
    const authHeaderKey = "Authorization";
    headers.remove(authHeaderKey);
    if (extra case {'DIO_AUTH_KEY': true}) {
      final sp = await SharedPreferences.getInstance();
      headers.addAll(
          {authHeaderKey: 'Bearer ${sp.getString(LocalStorageKeys.token)}'});
    }
    handle.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final DioException(requestOptions: RequestOptions(:extra), :response) = err;
    if (extra case {'DIO_AUTH_KEY': true}) {
      if (response != null && response.statusCode == HttpStatus.forbidden) {
        // Navigator.of(BarbershpNavGlobalKey.instance.navKey.currentContext!)
        //     .pushNamedAndRemoveUntil(Rotas.login, (route) => false);
      }
    }
    handler.reject(err);
  }
}
