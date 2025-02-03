import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:homechat/src/core/interceptors/auth_interceptor.dart';

final class RestClient extends DioForNative {
  RestClient()
      : super(
          BaseOptions(
            baseUrl: 'http://172.16.251.22:3000',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 60),
            contentType: ContentType.json.value,
          ),
        ) {
    interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
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
