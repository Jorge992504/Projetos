import 'package:servicespro/src/models/categorias_model.dart';

sealed class RegisterState {
  const RegisterState();

  bool get isInitial => this is RegisterInitial;
  bool get isLoading => this is RegisterLoading;
  bool get isLoaded => this is RegisterLoaded;
  bool get isSuccess => this is RegisterSuccess;
  bool get isFailure => this is RegisterFailure;
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterLoaded extends RegisterState {
  final List<CategoriasModel> categoriasModel;
  RegisterLoaded(this.categoriasModel);
}

class RegisterSuccess extends RegisterState {
  final String token;
  const RegisterSuccess(this.token);
}

class RegisterFailure extends RegisterState {
  final String? errorMessage;

  const RegisterFailure({this.errorMessage});
}
