// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:reborn/core/custom_dio/custom_dio.dart';
import 'package:reborn/core/dto/plano_dto.dart';
import 'package:reborn/core/erros/exception.dart';
import 'package:reborn/core/modelos/payment_types_model.dart';
import 'package:reborn/core/repositorio/plano_repository.dart';

class PlanoRepositoryImpl implements PlanoRepository {
  final CustomDio dio;
  PlanoRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<PaymentTypesModel>> getAllPaymentTypes() async {
    try {
      final result = await dio.unauth().get('/formas_pagamentos');
      return result.data
          .map<PaymentTypesModel>((p) => PaymentTypesModel.fromMap(p))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar formas de pagamentos', error: e, stackTrace: s);
      throw ExceptionErros(message: 'Erro ao buscar formas de pagamentos');
    }
  }

  @override
  Future<void> saveOrder(PlanoDto order) async {
    try {
      final result = {
        'tipo_pagamento': order.paymentMethodId,
      };
      await dio.auth().post('/orders', data: result);
      log('O pedido foi registrado');
    } on DioError catch (e, s) {
      log('Erro ao registrar pedido', error: e, stackTrace: s);
      throw ExceptionErros(message: 'Erro ao registrar pedido');
    }
  }
}
