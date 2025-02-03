// ignore_for_file: public_member_api_docs, sort_constructors_first
enum DetailPaymentStateStatus {
  initial,
  success,
  error,
}

class DetailPaymentState {
  final DetailPaymentStateStatus status;
  final List<String> improvement;

  DetailPaymentState.initial()
      : this(
          status: DetailPaymentStateStatus.initial,
          improvement: <String>[],
        );

  DetailPaymentState({
    required this.status,
    required this.improvement,
  });

  DetailPaymentState copyWith({
    DetailPaymentStateStatus? status,
    List<String>? improvement,
  }) {
    return DetailPaymentState(
      status: status ?? this.status,
      improvement: improvement ?? this.improvement,
    );
  }
}
