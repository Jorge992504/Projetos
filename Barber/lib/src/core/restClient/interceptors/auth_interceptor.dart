import 'dart:io';

import 'package:barber/src/core/constants/local_storage_keys.dart';
import 'package:barber/src/core/ui/widgets/barbershp_nav_global_key.dart';
import 'package:barber/src/rotas/rotas.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
    print(headers);
    handle.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final DioException(requestOptions: RequestOptions(:extra), :response) = err;
    if (extra case {'DIO_AUTH_KEY': true}) {
      if (response != null && response.statusCode == HttpStatus.forbidden) {
        Navigator.of(BarbershpNavGlobalKey.instance.navKey.currentContext!)
            .pushNamedAndRemoveUntil(Rotas.login, (route) => false);
      }
    }
    handler.reject(err);
  }
}
