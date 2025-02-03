import 'package:bloc/bloc.dart';

class ControlarProdutos extends Cubit<int> {
  late final bool _hasOrder;
  ControlarProdutos() : super(1);

  void initial(int cont, bool hasOrder) {
    _hasOrder = hasOrder;
    emit(cont);
  }

  void incrementar() => emit(state + 1);
  void decrementar() {
    if (state > (_hasOrder ? 0 : 1)) {
      //reduce o numero de ordens ate 0
      emit(state - 1);
    }
  }
}
