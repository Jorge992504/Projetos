import 'package:match/match.dart';

part 'historico_consultas_state.g.dart';

@match
enum HistoricoConsultasStatus { initial, loading, loaded, success, failure }

class HistoricoConsultasState {
  final HistoricoConsultasStatus status;
  final String? errorMessage;

  HistoricoConsultasState.initial()
    : status = HistoricoConsultasStatus.initial,
      errorMessage = null;
  HistoricoConsultasState({required this.status, this.errorMessage});

  HistoricoConsultasState copyWith({
    HistoricoConsultasStatus? status,
    String? errorMessage,
  }) {
    return HistoricoConsultasState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<Object?> get props {
    return [status, errorMessage];
  }
}
