import 'package:dente/src/models/paciente_model.dart';
import 'package:match/match.dart';

part 'registrar_paciente_state.g.dart';

@match
enum RegistrarPacienteStatus { initial, loading, loaded, success, failure }

class RegistrarPacienteState {
  final RegistrarPacienteStatus status;
  final String? errorMessage;
  final List<PacienteModel>? pacientes;

  RegistrarPacienteState.initial()
    : status = RegistrarPacienteStatus.initial,
      errorMessage = null,
      pacientes = null;
  RegistrarPacienteState({
    required this.status,
    this.errorMessage,
    this.pacientes,
  });

  RegistrarPacienteState copyWith({
    RegistrarPacienteStatus? status,
    String? errorMessage,
    List<PacienteModel>? pacientes,
  }) {
    return RegistrarPacienteState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      pacientes: pacientes ?? this.pacientes,
    );
  }

  List<Object?> get props {
    return [status, errorMessage, pacientes];
  }
}
