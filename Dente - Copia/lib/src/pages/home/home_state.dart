import 'package:dente/src/models/response/agendamentos_model_response.dart';
import 'package:match/match.dart';

part 'home_state.g.dart';

@match
enum HomeStatus { initial, loading, loaded, success, failure }

class HomeState {
  final HomeStatus status;
  final String? errorMessage;
  final List<AgendamentosModelResponse>? agendamentos;

  HomeState.initial()
    : status = HomeStatus.initial,
      errorMessage = null,
      agendamentos = null;
  HomeState({required this.status, this.errorMessage, this.agendamentos});

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    List<AgendamentosModelResponse>? agendamentos,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      agendamentos: agendamentos ?? this.agendamentos,
    );
  }

  List<Object?> get props {
    return [status, errorMessage, agendamentos];
  }
}
