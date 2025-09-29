import 'package:match/match.dart';
part 'login_state.g.dart';

@match
enum LoginStatus { initial, loading, loaded, success, error }

class LoginState {
  final LoginStatus status;
  final String? errorMessage;
  LoginState.initial() : status = LoginStatus.initial, errorMessage = null;
  LoginState({required this.status, this.errorMessage});
  LoginState copyWith({LoginStatus? status, String? errorMessage}) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<Object?> get props => [status, errorMessage];
}
