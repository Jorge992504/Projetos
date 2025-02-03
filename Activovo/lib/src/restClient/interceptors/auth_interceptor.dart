import 'dart:io';

import 'package:activovo/src/custom/keys.dart';
import 'package:activovo/src/rotas/rotas.dart';
import 'package:activovo/src/ui/widgets/activovo_nav_global_key.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;

    const authHeaderKey = 'Authorization';
    headers.remove(authHeaderKey);
    if (extra case {'DIO_AUTH_KEY': true}) {
      final sp = await SharedPreferences.getInstance();
      headers.addAll({authHeaderKey: 'Bearer ${sp.getString(Keys.token)}'});
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final DioException(requestOptions: RequestOptions(:extra), :response) = err;

    if (extra case {'DIO_AUTH_KEY': true}) {
      if (response != null && response.statusCode == HttpStatus.forbidden) {
        Navigator.of(ActivovoNavGlobalKey.instance.navKey.currentContext!)
            .pushNamedAndRemoveUntil(Rotas.login, (router) => false);
      }
    }
    handler.reject(err);
  }
}
