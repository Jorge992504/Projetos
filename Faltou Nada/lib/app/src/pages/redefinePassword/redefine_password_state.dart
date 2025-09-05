import 'package:match/match.dart';

part 'redefine_password_state.g.dart';

@match
enum RedefinePasswordStatus {
  initial,
  loading,
  loaded,
  success,
  refresh,
  failure,
}

class RedefinePasswordState {
  final RedefinePasswordStatus status;
  final String? errorMessage;

  RedefinePasswordState.initial()
    : status = RedefinePasswordStatus.initial,
      errorMessage = null;
  RedefinePasswordState({required this.status, this.errorMessage});

  RedefinePasswordState copyWith({
    RedefinePasswordStatus? status,
    String? errorMessage,
  }) {
    return RedefinePasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<Object?> get props {
    return [status, errorMessage];
  }
}
