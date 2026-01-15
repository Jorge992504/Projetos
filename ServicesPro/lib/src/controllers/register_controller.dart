import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicespro/core/exceptions/repository_exception.dart';
import 'package:servicespro/src/models/usuario_model.dart';
import 'package:servicespro/src/repository/register_repository.dart';
import 'package:servicespro/src/states/register_state.dart';

class RegisterController extends Cubit<RegisterState> {
  final RegisterRepository _registerRepository;

  RegisterController(this._registerRepository) : super(RegisterInitial());

  Future<void> registrarUsuario(UsuarioModel usuarioModel) async {
    try {
      emit(RegisterInitial());
      final response = await _registerRepository.registrarUsuario(usuarioModel);
      emit(RegisterSuccess(response.token));
    } on RepositoryException catch (e) {
      emit(RegisterFailure(errorMessage: e.message));
    }
  }

  Future<void> buscarCategorias() async {
    try {
      emit(RegisterInitial());
      final response = await _registerRepository.buscarCategorias();
      emit(RegisterLoaded(response));
    } on RepositoryException catch (e) {
      emit(RegisterFailure(errorMessage: e.message));
    }
  }

  Future<void> registrarInfosUsuario(UsuarioModel usuarioModel) async {
    try {
      emit(RegisterInitial());
      await _registerRepository.registrarInfosUsuario(usuarioModel);
      emit(RegisterSuccess(""));
    } on RepositoryException catch (e) {
      emit(RegisterFailure(errorMessage: e.message));
    }
  }
}
