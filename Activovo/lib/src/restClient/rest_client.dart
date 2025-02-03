import 'dart:io';

import 'package:activovo/src/restClient/interceptors/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

final class RestClient extends DioForNative {
  RestClient()
      : super(
          BaseOptions(
            // baseUrl: 'http://192.168.3.20:3000',
            baseUrl: 'http://192.168.26.94:3000',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 60),
            contentType: ContentType.json.value,
          ),
        ) {
    interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
      ),
      AuthInterceptor(),
    ]);
  }
  RestClient get auth {
    options.extra['DIO_AUTH_KEY'] = true;
    return this;
  }

  RestClient get unauth {
    options.extra['DIO_AUTH_KEY'] = false;
    return this;
  }
}
