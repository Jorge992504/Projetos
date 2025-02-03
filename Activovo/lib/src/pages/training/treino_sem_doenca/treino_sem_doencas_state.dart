// ignore_for_file: public_member_api_docs, sort_constructors_first
enum TreinoSemDoencasStateStatus {
  initial,
  success,
  error,
}

class TreinoSemDoencasState {
  final TreinoSemDoencasStateStatus status;
  final List<String> days;

  TreinoSemDoencasState.initial()
      : this(
          status: TreinoSemDoencasStateStatus.initial,
          days: <String>[],
        );

  TreinoSemDoencasState({
    required this.status,
    required this.days,
  });

  TreinoSemDoencasState copyWith({
    TreinoSemDoencasStateStatus? status,
    List<String>? days,
  }) {
    return TreinoSemDoencasState(
      status: status ?? this.status,
      days: days ?? this.days,
    );
  }
}
