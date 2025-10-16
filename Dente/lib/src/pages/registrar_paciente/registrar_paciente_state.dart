import 'package:match/match.dart';

part 'registrar_paciente_state.g.dart';

@match
enum RegistrarPacienteStatus { initial, loading, loaded, success, failure }

class RegistrarPacienteState {
  final RegistrarPacienteStatus status;
  final String? errorMessage;

  RegistrarPacienteState.initial()
    : status = RegistrarPacienteStatus.initial,
      errorMessage = null;
  RegistrarPacienteState({required this.status, this.errorMessage});

  RegistrarPacienteState copyWith({
    RegistrarPacienteStatus? status,
    String? errorMessage,
  }) {
    return RegistrarPacienteState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<Object?> get props {
    return [status, errorMessage];
  }
}
