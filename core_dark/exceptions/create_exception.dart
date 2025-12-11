import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:nahora/app/core/exceptions/repository_exception.dart';

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
        return RepositoryException(message: 'Erro ao conectar com o servidor');
      }
    } else {
      return RepositoryException(message: 'Erro desconhecido');
    }
  }
}
