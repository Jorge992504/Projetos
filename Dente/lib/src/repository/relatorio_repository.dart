// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dente/src/models/response/lista_procedimentos_realizados_model.dart';

class RelatorioRepository {
  final RestClient restClient;
  RelatorioRepository({required this.restClient});

  Future<List<ListaProcedimentosRealizadosModel>> buscaProcedimentosRealizados(
    String? filtro,
  ) async {
    try {
      final response = await restClient.auth.get(
        "/relatorios/clinicos/procedimentos",
        queryParameters: {"filtro": filtro},
      );
      return response.data
          .map<ListaProcedimentosRealizadosModel>(
            (e) => ListaProcedimentosRealizadosModel.fromMap(e),
          )
          .toList();
    } catch (e, s) {
      log(
        'Erro ao listar os procedimentos mais realizados',
        error: e,
        stackTrace: s,
      );
      throw CreateException.dioException(e);
    }
  }
}
