import 'package:match/match.dart';

part 'historico_paciente_state.g.dart';

@match
enum HistoricoPacienteStatus { initial, loading, loaded, success, failure }

class HistoricoPacienteState {
  final HistoricoPacienteStatus status;
  final String? errorMessage;

  HistoricoPacienteState.initial()
    : status = HistoricoPacienteStatus.initial,
      errorMessage = null;
  HistoricoPacienteState({required this.status, this.errorMessage});

  HistoricoPacienteState copyWith({
    HistoricoPacienteStatus? status,
    String? errorMessage,
  }) {
    return HistoricoPacienteState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<Object?> get props {
    return [status, errorMessage];
  }
}
