import 'package:servicespro/src/models/client/usuario_prestador/usuario_prestador_model.dart';

sealed class ClientState {
  const ClientState();

  bool get isInitial => this is ClientInitial;
  bool get isLoading => this is ClientLoading;
  bool get isLoaded => this is ClientLoaded;
  bool get isSuccess => this is ClientSuccess;
  bool get isFailure => this is ClientFailure;
}

class ClientInitial extends ClientState {
  const ClientInitial();
}

class ClientLoading extends ClientState {
  const ClientLoading();
}

class ClientLoaded extends ClientState {
  final List<UsuarioPrestadorModel> usuarioPrestadorModel;
  ClientLoaded(this.usuarioPrestadorModel);
}

class ClientSuccess extends ClientState {
  const ClientSuccess();
}

class ClientFailure extends ClientState {
  final String? errorMessage;

  const ClientFailure({this.errorMessage});
}
