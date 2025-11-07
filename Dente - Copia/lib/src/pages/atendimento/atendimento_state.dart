import 'package:match/match.dart';

part 'atendimento_state.g.dart';

@match
enum AtendimentoStatus { initial, loading, loaded, success, failure }

class AtendimentoState {
  final AtendimentoStatus status;
  final String? errorMessage;

  AtendimentoState.initial()
    : status = AtendimentoStatus.initial,
      errorMessage = null;
  AtendimentoState({required this.status, this.errorMessage});

  AtendimentoState copyWith({AtendimentoStatus? status, String? errorMessage}) {
    return AtendimentoState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<Object?> get props {
    return [status, errorMessage];
  }
}
