// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dente/src/models/empresa_model.dart';

class RegistrarEmpresaRepository {
  final RestClient restClient;
  RegistrarEmpresaRepository({required this.restClient});

  Future<Map<String, dynamic>> register(EmpresaModel model) async {
    try {
      final result = await restClient.unauth.post(
        "/registrar/empresa",
        data: model.toJson(),
      );
      return result.data;
    } catch (e, s) {
      log('Erro ao registrar empressa', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
