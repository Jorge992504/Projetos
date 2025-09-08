import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:nahora/app/core/env/env.dart';
import 'package:nahora/app/core/interceptor/interceptor.dart';

class RestClient extends DioForNative {
  late AuthInterceptor _authInterceptor;
  RestClient()
    : super(
        BaseOptions(
          baseUrl: Env.env["backend_base_url"] ?? "",
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 60),
          contentType: ContentType.json.value,
          responseType: ResponseType.json,
        ),
      ) {
    interceptors.addAll([
      LogInterceptor(requestBody: true, responseBody: true),
      _authInterceptor = AuthInterceptor(),
    ]);
  }

  RestClient get auth {
    interceptors.add(_authInterceptor);
    return this;
  }

  RestClient get unauth {
    interceptors.remove(_authInterceptor);
    return this;
  }
}
