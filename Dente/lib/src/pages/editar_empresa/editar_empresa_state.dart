import 'package:match/match.dart';
part 'editar_empresa_state.g.dart';

@match
enum EditarEmpresaStatus { initial, loading, loaded, success, failure }

class EditarEmpresaState {
  final EditarEmpresaStatus status;
  final String? errorMessage;

  EditarEmpresaState.initial()
    : status = EditarEmpresaStatus.initial,
      errorMessage = null;
  EditarEmpresaState({required this.status, this.errorMessage});

  EditarEmpresaState copyWith({
    EditarEmpresaStatus? status,
    String? errorMessage,
  }) {
    return EditarEmpresaState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<Object?> get props {
    return [status, errorMessage];
  }
}
