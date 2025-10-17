import 'package:match/match.dart';

part 'servicos_state.g.dart';

@match
enum ServicosStatus { initial, loading, loaded, success, failure }

class ServicosState {
  final ServicosStatus status;
  final String? errorMessage;

  ServicosState.initial()
    : status = ServicosStatus.initial,
      errorMessage = null;
  ServicosState({required this.status, this.errorMessage});

  ServicosState copyWith({ServicosStatus? status, String? errorMessage}) {
    return ServicosState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<Object?> get props {
    return [status, errorMessage];
  }
}
