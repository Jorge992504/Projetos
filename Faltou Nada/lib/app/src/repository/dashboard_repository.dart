import 'dart:developer';
import 'package:faltou_nada/app/core/exceptions/create_exception.dart';
import 'package:faltou_nada/app/core/rest_client/rest_client.dart';
import 'package:faltou_nada/app/src/models/dashboard_model.dart';

class DashboardRepository {
  final RestClient restClient;
  DashboardRepository({required this.restClient});

  Future<void> enviarUrl(String url, String empresa) async {
    try {
      await restClient.auth.post(
        "/nfe",
        queryParameters: {'url': url, 'empresa': empresa},
      );
    } catch (e, s) {
      log('Erro ao registrar gastos', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<List<DashboardModel>> buscaGastos() async {
    try {
      final result = await restClient.auth.get("/dashboard/gastos");
      return result.data!
          .map<DashboardModel>((e) => DashboardModel.fromMap(e))
          .toList();
    } catch (e, s) {
      log('Erro ao buscar gastos', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<List<DashboardItensModel>> buscaItensGastos(int mes, int ano) async {
    try {
      final result = await restClient.auth.get(
        "/dashboard/gastos/itens",
        queryParameters: {'mes': mes, 'ano': ano},
      );
      return result.data!
          .map<DashboardItensModel>((e) => DashboardItensModel.fromMap(e))
          .toList();
    } catch (e, s) {
      log('Erro ao buscar os itens dos gastos', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
