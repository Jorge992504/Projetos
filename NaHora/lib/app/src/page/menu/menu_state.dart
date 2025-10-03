import 'package:match/match.dart';
import 'package:nahora/app/src/models/request/sacola_model_request.dart';
import 'package:nahora/app/src/models/response/produto_especifico_model_response.dart';
import 'package:nahora/app/src/models/response/promocoes_model_response.dart';

part 'menu_state.g.dart';

@match
enum MenuStatus {
  initial,
  loading,
  loaded,
  refresh,
  failure,
  atualizaSacola,
  removerProduto,
}

class MenuState {
  final MenuStatus status;
  final String? errorMessage;
  final List<SacolaModelRequest>? sacola;
  final List<PromocoesModelResponse>? promocoesEspecificas;
  final List<ProdutoEspecificoModelResponse>? produtosEspecificos;

  MenuState.initial()
    : status = MenuStatus.initial,
      errorMessage = null,
      promocoesEspecificas = [],
      sacola = [],
      produtosEspecificos = [];

  MenuState({
    required this.status,
    this.errorMessage,
    this.promocoesEspecificas,
    this.sacola,
    this.produtosEspecificos,
  });

  MenuState copyWith({
    MenuStatus? status,
    String? errorMessage,
    List<PromocoesModelResponse>? promocoesEspecificas,
    List<SacolaModelRequest>? sacola,
    List<ProdutoEspecificoModelResponse>? produtosEspecificos,
  }) {
    return MenuState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      promocoesEspecificas: promocoesEspecificas ?? this.promocoesEspecificas,
      sacola: sacola ?? this.sacola,
      produtosEspecificos: produtosEspecificos ?? this.produtosEspecificos,
    );
  }

  List<Object?> get props {
    return [
      status,
      errorMessage,
      promocoesEspecificas,
      sacola,
      produtosEspecificos,
    ];
  }
}
