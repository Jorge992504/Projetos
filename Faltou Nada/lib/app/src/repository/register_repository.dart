import 'dart:developer';
import 'package:faltou_nada/app/core/exceptions/create_exception.dart';
import 'package:faltou_nada/app/core/rest_client/rest_client.dart';
import 'package:faltou_nada/app/src/models/register_user_model.dart';

class RegisterRepository {
  final RestClient restClient;
  RegisterRepository({required this.restClient});

  Future<Map<String, dynamic>> register(RegisterUserModel model) async {
    try {
      final result = await restClient.unauth.post(
        "/register",
        data: model.toJson(),
      );
      return result.data;
    } catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
