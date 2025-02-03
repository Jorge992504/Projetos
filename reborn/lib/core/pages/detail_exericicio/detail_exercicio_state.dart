import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'detail_exercicio_state.g.dart';

@match
enum DetailExercicioStateStatus {
  initial,
  loading,
  loaded,
  error,
  success,
  register,
}

class DetailExercicioState extends Equatable {
  final DetailExercicioStateStatus status;

  const DetailExercicioState({
    required this.status,
  });

  DetailExercicioState copyWith({
    DetailExercicioStateStatus? status,
  }) {
    return DetailExercicioState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
  const DetailExercicioState.initial()
      : status = DetailExercicioStateStatus.initial;
}
