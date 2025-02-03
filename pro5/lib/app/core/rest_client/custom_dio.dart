import 'dart:io';

import 'package:delivery/app/core/env/env.dart';
import 'package:delivery/app/core/rest_client/interceptors/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

class CustomDio extends DioForNative {
  late AuthInterceptor _authInterceptor;
  CustomDio()
      : super(BaseOptions(
          baseUrl: Env.i['backend_base_url'] ?? '',
          connectTimeout: 5000,
          receiveTimeout: 60000,
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

  CustomDio anuath() {
    interceptors.remove(_authInterceptor);
    return this;
  }
}
