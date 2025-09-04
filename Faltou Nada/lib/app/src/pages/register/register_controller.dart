import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:faltou_nada/app/core/exceptions/repository_exception.dart';
import 'package:faltou_nada/app/src/models/register_user_model.dart';
import 'package:faltou_nada/app/src/pages/register/register_state.dart';
import 'package:faltou_nada/app/src/repository/register_repository.dart';

class RegisterController extends Cubit<RegisterState> {
  final RegisterRepository _registerRepository;

  RegisterController(this._registerRepository) : super(RegisterState.initial());

  Future<Map<String, dynamic>> register(RegisterUserModel model) async {
    try {
      emit(state.copyWith(status: RegisterStatus.loading));

      final result = await _registerRepository.register(model);

      emit(
        state.copyWith(
          status: RegisterStatus.success,
          errorMessage: result['msg'],
        ),
      );
      return result;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: RegisterStatus.failure, errorMessage: e.message),
      );
      return {};
    }
  }
}
