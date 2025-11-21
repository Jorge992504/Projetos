import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/src/models/request/registrar_pagamento_request.dart';
import 'package:dente/src/pages/payment/payment_state.dart';
import 'package:dente/src/repository/payment_repository.dart';

class PaymentController extends Cubit<PaymentState> {
  final PaymentRepository _repository;

  PaymentController(this._repository) : super(PaymentState.initial());

  Future<void> buscaDentistasServicos() async {
    try {
      emit(
        state.copyWith(status: PaymentStatus.loading, conveniosPagamento: []),
      );

      final response = await _repository.buscaDentistasServicos();

      emit(
        state.copyWith(
          status: PaymentStatus.loaded,
          errorMessage: null,
          conveniosPagamento: response,
        ),
      );
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: PaymentStatus.failure,
          errorMessage: e.message,
          conveniosPagamento: [],
        ),
      );
    }
  }

  Future<void> terminarPagamento(RegistrarPagamentoRequest body) async {
    try {
      emit(state.copyWith(status: PaymentStatus.loading));

      await _repository.terminarPagamento(body);

      emit(state.copyWith(status: PaymentStatus.success, errorMessage: null));
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: PaymentStatus.failure, errorMessage: e.message),
      );
    }
  }
}
