import 'package:match/match.dart';

part 'ses1184i_state.g.dart';

@match
enum Ses1184iStatus {
  initial,
  loading,
  loaded,
  failure,
  success,
}

class Ses1184iState {
  final Ses1184iStatus status;
  final String? errorMessage;
  Ses1184iState.initial()
      : status = Ses1184iStatus.initial,
        errorMessage = null;

  Ses1184iState({
    required this.status,
    this.errorMessage,
  });

  Ses1184iState copyWith({
    Ses1184iStatus? status,
    String? errorMessage,
  }) {
    return Ses1184iState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<Object?> get props {
    return [
      status,
      errorMessage,
    ];
  }
}
