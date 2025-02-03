// ignore_for_file: public_member_api_docs, sort_constructors_first
enum LoginStateStatus {
  initial,
  error,
  login,
}

class LoginState {
  final LoginStateStatus status;
  final String? errorMessage;
  LoginState({
    required this.status,
    this.errorMessage,
  });

  LoginState.initial() : this(status: LoginStateStatus.initial);

  LoginState copyWith({
    LoginStateStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
