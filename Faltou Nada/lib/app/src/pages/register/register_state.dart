import 'package:match/match.dart';

part 'register_state.g.dart';

@match
enum RegisterStatus { initial, loading, loaded, success, refresh, failure }

class RegisterState {
  final RegisterStatus status;
  final String? errorMessage;

  RegisterState.initial()
    : status = RegisterStatus.initial,
      errorMessage = null;
  RegisterState({required this.status, this.errorMessage});

  RegisterState copyWith({RegisterStatus? status, String? errorMessage}) {
    return RegisterState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<Object?> get props {
    return [status, errorMessage];
  }
}
