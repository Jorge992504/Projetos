import 'package:bloc/bloc.dart';

class ProdutoDetailController extends Cubit<int> {
  late final bool _hasOrder;
  ProdutoDetailController() : super(1);

  void initial(int amount, bool hasOrder) {
    _hasOrder = hasOrder;
    emit(amount);
  }

  void incremento() => emit(state + 1);
  void decremento() {
    if (state > 1) {
      emit(state - 1);
    }
  }
}
