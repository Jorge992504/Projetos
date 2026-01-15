import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicespro/core/exceptions/repository_exception.dart';
import 'package:servicespro/src/repository/client/client_repository.dart';
import 'package:servicespro/src/states/client/client_state.dart';

class ClienteController extends Cubit<ClientState> {
  final ClientRepository _clientRepository;

  ClienteController(this._clientRepository) : super(ClientInitial());

  Future<void> buscarPrestadoresCategoria(int idCategoria) async {
    try {
      emit(ClientInitial());
      final response = await _clientRepository.buscarPrestadorCategoria(
        idCategoria,
      );
      emit(ClientLoaded(response));
    } on RepositoryException catch (e) {
      emit(ClientFailure(errorMessage: e.message));
    }
  }
}
