// ignore_for_file: public_member_api_docs, sort_constructors_first

enum TreinoFunctionStateStatus {
  initial,
  success,
  error,
}

class TreinoFunctionState {
  final TreinoFunctionStateStatus status;
  final List<String> days;
  final List<int> disease;

  TreinoFunctionState.initial()
      : this(
          status: TreinoFunctionStateStatus.initial,
          days: <String>[],
          disease: <int>[],
        );

  TreinoFunctionState({
    required this.status,
    required this.days,
    required this.disease,
  });

  TreinoFunctionState copyWith({
    TreinoFunctionStateStatus? status,
    List<String>? days,
    List<int>? disease,
  }) {
    return TreinoFunctionState(
      status: status ?? this.status,
      days: days ?? this.days,
      disease: disease ?? this.disease,
    );
  }
}
