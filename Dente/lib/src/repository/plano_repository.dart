import 'package:dente/core/rest_client/rest_client.dart';

class PlanoRepository {
  final RestClient restClient;
  PlanoRepository({required this.restClient});

  // Future<void> terminarPagamento(RegistrarPagamentoRequest body) async {
  //   try {
  //     await restClient.auth.post(
  //       "/pagamento/grava/pagamento",
  //       data: body.toJson(),
  //     );
  //   } catch (e, s) {
  //     log('Erro ao registrar dados do pagamento', error: e, stackTrace: s);
  //     throw CreateException.dioException(e);
  //   }
  // }
}
