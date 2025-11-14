// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dente/src/models/request/lista_relatorios_model.dart';

class DashboardRepository {
  final RestClient restClient;
  DashboardRepository({required this.restClient});

  Future<List<ListaRelatoriosModel>> buscaRelatorios() async {
    try {
      final response = await restClient.auth.get(
        "/relatorios/busca-relatorios",
      );
      return response.data
          .map<ListaRelatoriosModel>((e) => ListaRelatoriosModel.fromMap(e))
          .toList();
    } catch (e, s) {
      log('Erro ao listar os tipos de relatorios', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
