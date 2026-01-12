sealed class LoginState {
  const LoginState();

  bool get isInitial => this is LoginInitial;
  bool get isLoading => this is LoginLoading;
  bool get isSuccess => this is LoginSuccess;
  bool get isFailure => this is LoginFailure;
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final String token;
  const LoginSuccess(this.token);
}

class LoginFailure extends LoginState {
  final String? errorMessage;

  const LoginFailure({this.errorMessage});
}
