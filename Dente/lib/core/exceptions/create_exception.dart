import 'dart:developer';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dio/dio.dart';

class CreateException {
  static RepositoryException dioException(Object dio) {
    if (dio is DioException) {
      if (dio.type == DioExceptionType.badResponse) {
        final data = dio.response?.data;

        String message;

        if (data is Map<String, dynamic>) {
          // API retornou JSON
          message = data['message'] ?? "Erro não informado";
        } else if (data is String) {
          // API retornou apenas texto
          message = data;
        } else {
          message = "Erro não informado";
        }

        log(message);
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
