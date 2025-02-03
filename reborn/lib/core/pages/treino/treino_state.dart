import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'treino_state.g.dart';

@match
enum TreinoStateStatus {
  initial,
  loading,
  loaded,
  error,
  success,
  register,
}

class TreinoState extends Equatable {
  final TreinoStateStatus status;

  const TreinoState({
    required this.status,
  });

  TreinoState copyWith({
    TreinoStateStatus? status,
  }) {
    return TreinoState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
  const TreinoState.initial() : status = TreinoStateStatus.initial;
}
