import 'dart:developer';

import 'package:aumigo/core/exceptions/repository_exception.dart';
import 'package:dio/dio.dart';

class CreateException {
  static RepositoryException dioException(Object dio, String msg) {
    if (dio is DioException) {
      if (dio.type == DioExceptionType.badResponse) {
        log(dio.response?.data['error']);
        if (dio.response?.data['error'] != null) {
          return RepositoryException(
              message: dio.response?.data['error'] ?? msg);
        } else {
          return RepositoryException(message: msg);
        }
      } else {
        return RepositoryException(message: 'Erro ao conectar com o servidor');
      }
    } else {
      return RepositoryException(message: 'Erro desconhecido');
    }
  }
}
