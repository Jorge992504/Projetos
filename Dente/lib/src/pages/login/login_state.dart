import 'package:dente/src/models/empresa_model.dart';
import 'package:match/match.dart';

part 'login_state.g.dart';

@match
enum LoginStatus { initial, loading, loaded, sucess, failure }

class LoginState {
  final LoginStatus status;
  final String? errorMessage;
  final EmpresaModel? empresaModel;
  LoginState.initial()
    : status = LoginStatus.initial,
      errorMessage = null,
      empresaModel = EmpresaModel();
  LoginState({required this.status, this.errorMessage, this.empresaModel});

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
    EmpresaModel? empresaModel,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      empresaModel: empresaModel ?? this.empresaModel,
    );
  }

  List<Object?> get props {
    return [status, errorMessage, empresaModel];
  }
}
