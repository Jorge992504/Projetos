import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:faltou_nada/app/core/exceptions/repository_exception.dart';
import 'package:faltou_nada/app/src/pages/redefinePassword/redefine_password_state.dart';
import 'package:faltou_nada/app/src/repository/redefine_password_repository.dart';

class RedefinePasswordController extends Cubit<RedefinePasswordState> {
  final RedefinePasswordRepository _redefinePasswordRepository;

  RedefinePasswordController(this._redefinePasswordRepository)
    : super(RedefinePasswordState.initial());

  Future<bool> redefinirSenha(String email, String password) async {
    try {
      emit(state.copyWith(status: RedefinePasswordStatus.loading));

      final result = await _redefinePasswordRepository.redefinirSenha(
        email,
        password,
      );

      emit(
        state.copyWith(
          status: RedefinePasswordStatus.success,
          errorMessage: result,
        ),
      );
      return true;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: RedefinePasswordStatus.failure,
          errorMessage: e.message,
        ),
      );
      return false;
    }
  }
}
