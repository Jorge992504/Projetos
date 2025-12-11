import 'dart:developer';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dio/dio.dart';

class CreateException {
  static RepositoryException dioException(Object dio) {
    if (dio is DioException) {
      log('----dio---> $dio');
      if (dio.type == DioExceptionType.badResponse ||
          dio.type == DioExceptionType.unknown) {
        final data = dio.response?.data;
        log('----data---> $data');

        String message;

        if (data is Map<String, dynamic>) {
          // API retornou JSON
          message = data['message'] ?? "Erro não informado";
        } else if (data is String) {
          // API retornou apenas texto
          if (data == "") {
            message = "Entrar em contato com suporte";
          } else {
            message = data;
          }
        } else {
          message = "Entrar em contato com suporte";
        }

        log('-------> $message');
        return RepositoryException(message: message);
      } else {
        final data = dio.response?.data;

        return RepositoryException(message: data['message']);
      }
    } else {
      return RepositoryException(message: 'Erro desconhecido');
    }
  }
}
