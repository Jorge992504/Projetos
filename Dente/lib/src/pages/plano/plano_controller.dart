import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/src/models/request/card_request.dart';
import 'package:dente/src/models/request/pagamento_status_request.dart';
import 'package:dente/src/models/request/pix_request.dart';
import 'package:dente/src/models/response/card_response.dart';
import 'package:dente/src/models/response/card_status_response.dart';
import 'package:dente/src/models/response/pix_response.dart';
import 'package:dente/src/models/response/precos_model_response.dart';
import 'package:dente/src/pages/plano/plano_state.dart';
import 'package:dente/src/repository/plano_repository.dart';

class PlanoController extends Cubit<PlanoState> {
  final PlanoRepository _repository;

  PlanoController(this._repository) : super(PlanoState.initial());

  Future<List<PrecosModelResponse>> buscarPrecos() async {
    try {
      emit(state.copyWith(status: PlanoStatus.loading));

      final result = await _repository.buscarPlanos();

      emit(state.copyWith(status: PlanoStatus.loaded, errorMessage: null));
      return result;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: PlanoStatus.failure, errorMessage: e.message),
      );
      return [];
    }
  }

  Future<PixResponse> gerarPix(PixRequest body) async {
    try {
      emit(state.copyWith(status: PlanoStatus.loading));

      final result = await _repository.gerarPix(body);

      emit(state.copyWith(status: PlanoStatus.loaded, errorMessage: null));
      return result;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: PlanoStatus.failure, errorMessage: e.message),
      );
      rethrow;
    }
  }

  Future<String> verificarStatusPagamento(PagamentoStatusRequest body) async {
    try {
      emit(state.copyWith(status: PlanoStatus.loading));

      final result = await _repository.verificarStatusPagamento(body);

      emit(state.copyWith(status: PlanoStatus.loaded, errorMessage: null));
      return result;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: PlanoStatus.failure, errorMessage: e.message),
      );
      rethrow;
    }
  }

  Future<String> buscaPublicKey() async {
    try {
      emit(state.copyWith(status: PlanoStatus.loading));

      final result = await _repository.buscaPublicKey();

      emit(state.copyWith(status: PlanoStatus.loaded, errorMessage: null));
      return result;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: PlanoStatus.failure, errorMessage: e.message),
      );
      rethrow;
    }
  }

  Future<CardResponse> pagamentoCard(CardRequest body) async {
    try {
      emit(state.copyWith(status: PlanoStatus.loading));

      final result = await _repository.pagamentoCard(body);

      emit(state.copyWith(status: PlanoStatus.loaded, errorMessage: null));
      return result;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: PlanoStatus.failure, errorMessage: e.message),
      );
      rethrow;
    }
  }

  Future<CardStatusResponse> statusCard(int paymentId) async {
    try {
      emit(state.copyWith(status: PlanoStatus.loading));

      final result = await _repository.statusCard(paymentId);

      emit(state.copyWith(status: PlanoStatus.loaded, errorMessage: null));
      return result;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: PlanoStatus.failure, errorMessage: e.message),
      );
      rethrow;
    }
  }
}
