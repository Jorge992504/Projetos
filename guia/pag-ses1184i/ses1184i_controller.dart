import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:hsmobile/app/core/exceptions/repository_exception.dart';
import 'package:hsmobile/app/pages/ses1184i/models/ses1184i_item_model.dart';
import 'package:hsmobile/app/pages/ses1184i/ses1184i_state.dart';
import 'package:hsmobile/app/repositories/ses1184i/ses1184i_repository.dart';

class Ses1184iController extends Cubit<Ses1184iState> {
  final Ses1184iRepository ses1184irepository;
  Ses1184iController(this.ses1184irepository) : super(Ses1184iState.initial());

  Future<Map<String, dynamic>> consultarFilial(int filial) async {
    try {
      emit(state.copyWith(status: Ses1184iStatus.loading));

      final result = await ses1184irepository.consultarFilial(filial);

      emit(
        state.copyWith(
          status: Ses1184iStatus.loaded,
        ),
      );
      return result;
    } on RepositoryException catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      emit(state.copyWith(
          status: Ses1184iStatus.failure, errorMessage: e.message));
      return {};
    }
  }

  Future<Map<String, dynamic>> consultarProduto(
      String produto, int filial) async {
    try {
      emit(state.copyWith(status: Ses1184iStatus.loading));

      final result = await ses1184irepository.consultarProduto(produto, filial);

      emit(
        state.copyWith(
          status: Ses1184iStatus.loaded,
        ),
      );
      return result;
    } on RepositoryException catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      emit(state.copyWith(
          status: Ses1184iStatus.failure, errorMessage: e.message));
      return {};
    }
  }

  Future<Map<String, dynamic>> consultarMotivo(
      int motivo, int filial, int produto) async {
    try {
      emit(state.copyWith(status: Ses1184iStatus.loading));

      final result =
          await ses1184irepository.consultarMotivo(motivo, filial, produto);

      emit(
        state.copyWith(
          status: Ses1184iStatus.loaded,
        ),
      );
      return result;
    } on RepositoryException catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      emit(state.copyWith(
          status: Ses1184iStatus.failure, errorMessage: e.message));
      return {};
    }
  }

  Future<Map<String, dynamic>> consultarClifor(
      int clifor, int produto, int filial) async {
    try {
      emit(state.copyWith(status: Ses1184iStatus.loading));

      final result =
          await ses1184irepository.consultarClifor(clifor, produto, filial);

      emit(
        state.copyWith(
          status: Ses1184iStatus.loaded,
        ),
      );
      return result;
    } on RepositoryException catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      emit(state.copyWith(
          status: Ses1184iStatus.failure, errorMessage: e.message));
      return {};
    }
  }

  Future<bool> consultarQuantidade(
      int filial, int produto, num qtProduto, int motivo) async {
    try {
      emit(state.copyWith(status: Ses1184iStatus.loading));

      final result = await ses1184irepository.consultarQuantidade(
          filial, produto, qtProduto, motivo);

      emit(
        state.copyWith(
          status: Ses1184iStatus.loaded,
        ),
      );
      return result;
    } on RepositoryException catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      emit(state.copyWith(
          status: Ses1184iStatus.failure, errorMessage: e.message));
      return false;
    }
  }

  Future<bool> gravarRegistro(Ses1184iItemModel item) async {
    try {
      emit(state.copyWith(status: Ses1184iStatus.loading));

      final result = await ses1184irepository.gravaRegistro(item);

      emit(
        state.copyWith(
          status: Ses1184iStatus.loaded,
        ),
      );
      return result;
    } on RepositoryException catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      emit(state.copyWith(
          status: Ses1184iStatus.failure, errorMessage: e.message));
      return false;
    }
  }
}
