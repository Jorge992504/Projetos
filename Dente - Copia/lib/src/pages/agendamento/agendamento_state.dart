import 'package:dente/src/models/response/busca_servicos_dentistas_agendamento_response.dart';
import 'package:match/match.dart';

part 'agendamento_state.g.dart';

@match
enum AgendamentoStatus { initial, loading, loaded, success, failure }

class AgendamentoState {
  final AgendamentoStatus status;
  final String? errorMessage;
  final BuscaServicosDentistasAgendamentoResponse? dentistasServicos;

  AgendamentoState.initial()
    : status = AgendamentoStatus.initial,
      errorMessage = null,
      dentistasServicos = null;
  AgendamentoState({
    required this.status,
    this.errorMessage,
    this.dentistasServicos,
  });

  AgendamentoState copyWith({
    AgendamentoStatus? status,
    String? errorMessage,
    BuscaServicosDentistasAgendamentoResponse? dentistasServicos,
  }) {
    return AgendamentoState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      dentistasServicos: dentistasServicos ?? this.dentistasServicos,
    );
  }

  List<Object?> get props {
    return [status, errorMessage, dentistasServicos];
  }
}
