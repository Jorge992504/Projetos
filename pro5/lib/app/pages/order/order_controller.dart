import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:delivery/app/dto/ordem_produto_dto.dart';
import 'package:delivery/app/dto/order_dto.dart';
import 'package:delivery/app/pages/order/order_state.dart';
import 'package:delivery/app/repositories/order/order_repository.dart';

class OrderController extends Cubit<OrderState> {
  final OrderRepository _orderRepository;
  OrderController(this._orderRepository) : super(const OrderState.initial());

  void load(List<OrdemProduto> produtos) async {
    try {
      emit(state.copyWith(status: OrderStatus.loading));
      final paymentTypes = await _orderRepository.getAllPaymentTypes();
      emit(
        state.copyWith(
          orderProdutos: produtos,
          status: OrderStatus.loaded,
          paymentTypes: paymentTypes,
        ),
      );
    } catch (e, s) {
      log('Error ao carregar pagina', error: e, stackTrace: s);
      emit(state.copyWith(
          status: OrderStatus.error, errorMEssage: 'Erro ao carregar pagina'));
    }
  }

  void incrementProduto(int index) {
    final orders = [...state.orderProdutos]; //duplicar lista
    final order = orders[index];
    orders[index] = order.copyWith(cont: order.cont + 1);
    emit(
        state.copyWith(orderProdutos: orders, status: OrderStatus.updateOrder));
  }

  void decrementarProduto(int index) {
    final orders = [...state.orderProdutos]; //duplicar lista
    final order = orders[index];
    final cont = order.cont;
    if (cont == 1) {
      if (state.status != OrderStatus.confirmRemoveProduto) {
        emit(OrderConfirmDeleteProdutoState(
          ordemProduto: order,
          index: index,
          status: OrderStatus.confirmRemoveProduto,
          orderProdutos: state.orderProdutos,
          paymentTypes: state.paymentTypes,
          errorMEssage: state.errorMEssage,
        ));
        return;
      } else {
        orders.removeAt(index);
      }
    } else {
      orders[index] = order.copyWith(cont: order.cont - 1);
    }
    if (orders.isEmpty) {
      emit(state.copyWith(status: OrderStatus.emptyBag));
      return;
    }
    emit(
        state.copyWith(orderProdutos: orders, status: OrderStatus.updateOrder));
  }

  void cancelDeleteProduto() {
    emit(state.copyWith(status: OrderStatus.loaded));
  }

  void emptyBag() {
    emit(state.copyWith(status: OrderStatus.emptyBag));
  }

  void saveOrder(
      {required String address,
      required String document,
      required int paymentMethodId}) async {
    emit(state.copyWith(status: OrderStatus.loading));
    await _orderRepository.saveOrder(
      OrderDto(
        produtos: state.orderProdutos,
        address: address,
        document: document,
        paymentMethodId: paymentMethodId,
      ),
    );
    emit(state.copyWith(status: OrderStatus.success));
  }
}
