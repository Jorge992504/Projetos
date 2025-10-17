import 'package:match/match.dart';

part 'dentista_state.g.dart';

@match
enum DentistaStatus { initial, loading, loaded, success, failure }

class DentistaState {
  final DentistaStatus status;
  final String? errorMessage;

  DentistaState.initial()
    : status = DentistaStatus.initial,
      errorMessage = null;
  DentistaState({required this.status, this.errorMessage});

  DentistaState copyWith({DentistaStatus? status, String? errorMessage}) {
    return DentistaState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<Object?> get props {
    return [status, errorMessage];
  }
}
