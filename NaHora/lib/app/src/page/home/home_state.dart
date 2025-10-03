import 'package:match/match.dart';
import 'package:nahora/app/src/models/request/sacola_model_request.dart';
import 'package:nahora/app/src/models/response/promocoes_model_response.dart';

part 'home_state.g.dart';

@match
enum HomeStatus {
  initial,
  loading,
  loaded,
  refresh,
  failure,
  atualizaSacola,
  removerProduto,
}

class HomeState {
  final HomeStatus status;
  final String? errorMessage;
  final List<SacolaModelRequest>? sacola;
  final List<PromocoesModelResponse>? promocoesGerais;

  HomeState.initial()
    : status = HomeStatus.initial,
      errorMessage = null,
      promocoesGerais = [],
      sacola = [];

  HomeState({
    required this.status,
    this.errorMessage,
    this.promocoesGerais,
    this.sacola,
  });

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    List<PromocoesModelResponse>? promocoesGerais,
    List<SacolaModelRequest>? sacola,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      promocoesGerais: promocoesGerais ?? this.promocoesGerais,
      sacola: sacola ?? this.sacola,
    );
  }

  List<Object?> get props {
    return [status, errorMessage, promocoesGerais, sacola];
  }
}
