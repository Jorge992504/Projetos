import 'package:dio/dio.dart';
import 'package:dente/core/interceptor/interceptor.dart';
import 'package:dente/core/env/env.dart';

class RestClient {
  late final Dio _dio;
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

  Dio get instance => _dio;

  RestClient get auth {
    _dio.interceptors.add(_authInterceptor);
    return this;
  }

  RestClient get unauth {
    _dio.interceptors.remove(_authInterceptor);
    return this;
  }

  // Métodos auxiliares (para manter a mesma interface do RestClient "mobile")
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) =>
      _dio.get(path, queryParameters: queryParameters);

  Future<Response> post(String path, {dynamic data}) =>
      _dio.post(path, data: data);

  Future<Response> put(String path, {dynamic data}) =>
      _dio.put(path, data: data);

  Future<Response> delete(String path, {dynamic data}) =>
      _dio.delete(path, data: data);
}
