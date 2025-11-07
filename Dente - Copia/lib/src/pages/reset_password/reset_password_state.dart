import 'package:match/match.dart';

part 'reset_password_state.g.dart';

@match
enum ResetPasswordStatus { initial, loading, loaded, success, failure }

class ResetPasswordState {
  final ResetPasswordStatus status;
  final String? errorMessage;

  ResetPasswordState.initial()
    : status = ResetPasswordStatus.initial,
      errorMessage = null;
  ResetPasswordState({required this.status, this.errorMessage});

  ResetPasswordState copyWith({
    ResetPasswordStatus? status,
    String? errorMessage,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<Object?> get props {
    return [status, errorMessage];
  }
}
