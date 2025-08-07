import 'package:faltou_nada/app/src/models/user_model.dart';
import 'package:match/match.dart';

part 'login_state.g.dart';

@match
enum LoginStatus {
  initial,
  loading,
  loaded,
  sucess,
  failure,
}

class LoginState {
  final LoginStatus status;
  final String? errorMessage;
  final UserModel? userModel;
  LoginState.initial()
      : status = LoginStatus.initial,
        errorMessage = null,
        userModel = UserModel();
  LoginState({
    required this.status,
    this.errorMessage,
    this.userModel,
  });

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
    UserModel? userModel,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      userModel: userModel ?? this.userModel,
    );
  }

  List<Object?> get props {
    return [
      status,
      errorMessage,
      userModel,
    ];
  }
}
