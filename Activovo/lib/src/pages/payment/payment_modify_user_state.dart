// ignore_for_file: public_member_api_docs, sort_constructors_first
enum PaymentModifyUserStateStatus {
  success,
  error,
  initial,
}

class PaymentModifyUserState {
  final PaymentModifyUserStateStatus status;
  final String profile;

  PaymentModifyUserState.initial()
      : this(
          status: PaymentModifyUserStateStatus.initial,
          profile: '',
        );
  PaymentModifyUserState({
    required this.status,
    required this.profile,
  });

  PaymentModifyUserState copyWith({
    PaymentModifyUserStateStatus? status,
    String? profile,
  }) {
    return PaymentModifyUserState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
    );
  }
}
