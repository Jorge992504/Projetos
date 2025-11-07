// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dente/src/models/empresa_model.dart';

class EditarEmpresaRepository {
  final RestClient restClient;
  EditarEmpresaRepository({required this.restClient});

  Future<void> gravaEditarEmpresa(EmpresaModel empresaModel) async {
    try {
      await restClient.auth.post(
        "/empresa/editar",
        data: empresaModel.toJson(),
      );
    } catch (e, s) {
      log('Erro ao gravar dados da clinica', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
