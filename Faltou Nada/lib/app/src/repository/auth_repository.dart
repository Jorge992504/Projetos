import 'package:dio/dio.dart';
import 'package:faltou_nada/app/core/exceptions/repository_exception.dart';
import 'package:faltou_nada/app/core/exceptions/unauthorized_exceptiom.dart';
import 'package:faltou_nada/app/core/rest_client/rest_client.dart';
import 'package:faltou_nada/app/src/models/auth_model.dart';

class AuthRepository {
  final RestClient restClient;
  AuthRepository({
    required this.restClient,
  });

  Future<AuthModel> login(String email, String password) async {
    try {
      final authModel =
          await restClient.unauth.post('/login', queryParameters: {
        'email': email,
        'password': password,
      });
      return AuthModel.fromMap(authModel.data);
    } on DioException catch (e) {
      e.response?.statusCode == 401
          ? {
              throw UnauthorizedExceptiom(
                e.response?.data['msg'],
              ),
            }
          : {throw RepositoryException(message: 'Erro ao realizar login')};
    }
  }
}
