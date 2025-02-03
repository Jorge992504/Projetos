// ignore_for_file: public_member_api_docs, sort_constructors_first
enum SelectedProductStateStatus {
  initial,
  success,
  error,
  loading,
}

class SelectedProductState {
  final SelectedProductStateStatus status;
  final int idProduct;

  SelectedProductState.initial()
      : this(status: SelectedProductStateStatus.initial, idProduct: 0);

  SelectedProductState({
    required this.status,
    required this.idProduct,
  });

  SelectedProductState copyWith({
    SelectedProductStateStatus? status,
    int? idProduct,
  }) {
    return SelectedProductState(
      status: status ?? this.status,
      idProduct: idProduct ?? this.idProduct,
    );
  }
}
