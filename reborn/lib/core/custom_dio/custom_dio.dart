import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:reborn/core/custom_dio/auth_interceptor.dart';
import 'package:reborn/core/custom_dio/env.dart';

class CustomDio extends DioForNative {
  late AuthInterceptor _authInterceptor;
  CustomDio()
      : super(BaseOptions(
          baseUrl: Env.i['backend_base_url'] ?? '',
          connectTimeout: const Duration(milliseconds: 5000),
          receiveTimeout: const Duration(milliseconds: 60000),
          contentType: ContentType.json.value,
        )) {
    interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
    ));
    _authInterceptor = AuthInterceptor();
  }
  CustomDio auth() {
    interceptors.add(_authInterceptor);
    return this;
  }

  CustomDio unauth() {
    interceptors.remove(_authInterceptor);
    return this;
  }

  CustomDio exe() {
    return this;
  }
}
