import 'package:match/match.dart';

part 'registrar_empresa_state.g.dart';

@match
enum RegistrarEmpresaStatus { initial, loading, loaded, success, failure }

class RegistrarEmpresaState {
  final RegistrarEmpresaStatus status;
  final String? errorMessage;

  RegistrarEmpresaState.initial()
    : status = RegistrarEmpresaStatus.initial,
      errorMessage = null;
  RegistrarEmpresaState({required this.status, this.errorMessage});

  RegistrarEmpresaState copyWith({
    RegistrarEmpresaStatus? status,
    String? errorMessage,
  }) {
    return RegistrarEmpresaState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<Object?> get props {
    return [status, errorMessage];
  }
}
