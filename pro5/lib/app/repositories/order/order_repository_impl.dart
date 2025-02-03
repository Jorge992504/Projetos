// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:delivery/app/core/rest_client/custom_dio.dart';
import 'package:delivery/app/dto/order_dto.dart';
import 'package:delivery/app/models/payment_types_model.dart';
import 'package:delivery/app/repositories/exception/repository_exception.dart';
import 'package:delivery/app/repositories/order/order_repository.dart';
import 'package:dio/dio.dart';

class OrderRepositoryImpl implements OrderRepository {
  final CustomDio dio;
  OrderRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<PaymentTypesModel>> getAllPaymentTypes() async {
    try {
      final result = await dio.auth().get('/formas_pagamentos');
      return result.data
          .map<PaymentTypesModel>((p) => PaymentTypesModel.fromMap(p))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar formas de pagamentos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar formas de pagamentos');
    }
  }

  @override
  Future<void> saveOrder(OrderDto order) async {
    try {
      final result = {
        'endereco': order.address,
        'cpf': order.document,
        'tipo_pagamento': order.paymentMethodId,
        'produtos': order.produtos
            .map((e) => {
                  'id_produto': e.product.id,
                  'quantidade': e.cont,
                  'total_preco': e.totalPreco,
                })
            .toList(),
      };
      await dio.auth().post('/orders', data: result);
      log('O pedido foi registrado');
    } on DioError catch (e, s) {
      log('Erro ao registrar pedido', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao registrar pedido');
    }
  }
}
