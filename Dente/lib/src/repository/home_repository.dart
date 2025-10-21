import 'dart:developer';
import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dente/src/models/response/agendamentos_model_response.dart';

class HomeRepository {
  final RestClient restClient;
  HomeRepository({required this.restClient});

  Future<List<AgendamentosModelResponse>> buscaAgendamentos() async {
    try {
      final response = await restClient.auth.get("/agendamentos/busca/todos");
      return response.data
          .map<AgendamentosModelResponse>(
            (e) => AgendamentosModelResponse.fromMap(e),
          )
          .toList();
    } catch (e, s) {
      log('Erro ao buscar dados', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
