// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dente/src/models/response/lista_procedimentos_realizados_model.dart';
import 'package:dente/src/models/response/relatorio_agendamento_cabeca_response.dart';

class DashboardRepository {
  final RestClient restClient;
  DashboardRepository({required this.restClient});

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

  Future<List<RelatorioAgendamentoCabecaResponse>> buscaRelatoriosAgendamentos(
    String? filtro,
  ) async {
    try {
      final response = await restClient.auth.get(
        "/relatorios/agendamentos",
        queryParameters: {"filtro": filtro},
      );
      return response.data
          .map<RelatorioAgendamentoCabecaResponse>(
            (e) => RelatorioAgendamentoCabecaResponse.fromMap(e),
          )
          .toList();
    } catch (e, s) {
      log('Erro ao listar os agendamentos', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
