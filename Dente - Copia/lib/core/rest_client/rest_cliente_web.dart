import 'package:dio/dio.dart';
import 'package:dente/core/env/env.dart';
import 'package:dente/core/interceptor/interceptor.dart';

class RestClient {
  final Dio _dio;
  late AuthInterceptor _authInterceptor;

  RestClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: Env.env["backend_base_url"] ?? "",
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 60),
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      ) {
    _authInterceptor = AuthInterceptor();
    _dio.interceptors.addAll([
      LogInterceptor(requestBody: true, responseBody: true),
      _authInterceptor,
    ]);
  }

  Dio get client => _dio;

  RestClient get auth {
    if (!_dio.interceptors.contains(_authInterceptor)) {
      _dio.interceptors.add(_authInterceptor);
    }
    return this;
  }

  RestClient get unauth {
    _dio.interceptors.remove(_authInterceptor);
    return this;
  }
}
