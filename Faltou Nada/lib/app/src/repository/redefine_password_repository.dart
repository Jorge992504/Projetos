import 'dart:developer';
import 'package:faltou_nada/app/core/exceptions/create_exception.dart';
import 'package:faltou_nada/app/core/rest_client/rest_client.dart';

class RedefinePasswordRepository {
  final RestClient restClient;
  RedefinePasswordRepository({required this.restClient});

  Future<String> redefinirSenha(String email, String password) async {
    try {
      final result = await restClient.unauth.get(
        "/redefine",
        queryParameters: {'email': email, 'password': password},
      );
      return result.data;
    } catch (e, s) {
      log('Erro ao redefinir senha', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
