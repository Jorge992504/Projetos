// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:faltou_nada/app/core/exceptions/repository_exception.dart';

// class CreateException {
//   static RepositoryException dioException(Object dio) {
//     if (dio is DioException) {
//       if (dio.type == DioExceptionType.badResponse) {
//         log(dio.response!.data['message'].toString());
//         if (dio.response?.data['message'].toString() != null) {
//           return RepositoryException(message: dio.response?.data['message']);
//         } else {
//           return RepositoryException(message: "Erro não informado");
//         }
//       } else {
//         return RepositoryException(message: 'Erro ao conectar com o servidor');
//       }
//     } else {
//       return RepositoryException(message: 'Erro desconhecido');
//     }
//   }
// }
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faltou_nada/app/core/exceptions/repository_exception.dart';

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
