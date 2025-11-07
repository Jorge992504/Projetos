// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dente/src/models/servicos_model.dart';

class ServicosRepository {
  final RestClient restClient;
  ServicosRepository({required this.restClient});

  Future<void> registrarServicos(ServicosModel servicosModel) async {
    try {
      await restClient.auth.post(
        "/servicos/registrar",
        data: servicosModel.toJson(),
      );
    } catch (e, s) {
      log('Erro ao registrar serviço', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<List<ServicosModel>> buscarServicos() async {
    try {
      final response = await restClient.auth.get("/servicos/buscar");
      return response.data
          .map<ServicosModel>((e) => ServicosModel.fromMap(e))
          .toList();
    } catch (e, s) {
      log('Erro ao buscar serviços', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
