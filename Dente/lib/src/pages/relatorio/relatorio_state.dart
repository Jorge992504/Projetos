import 'package:match/match.dart';

part 'relatorio_state.g.dart';

@match
enum RelatorioStatus { initial, loading, loaded, success, failure }

class RelatorioState {
  final RelatorioStatus status;
  final String? errorMessage;

  RelatorioState.initial()
    : status = RelatorioStatus.initial,
      errorMessage = null;
  RelatorioState({required this.status, this.errorMessage});

  RelatorioState copyWith({RelatorioStatus? status, String? errorMessage}) {
    return RelatorioState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<Object?> get props {
    return [status, errorMessage];
  }
}
