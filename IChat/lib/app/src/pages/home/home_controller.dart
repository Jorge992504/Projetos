import 'package:bloc/bloc.dart';
import 'package:ichat/app/core/exceptions/repository_exception.dart';
import 'package:ichat/app/src/pages/home/home_state.dart';
import 'package:ichat/app/src/repository/home_repository.dart';

class HomeController extends Cubit<HomeState> {
  final HomeRepository _repository;

  HomeController(this._repository) : super(HomeState.initial());

  Future<void> buscaMessagesOfUSer() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final response = await _repository.buscaMessagesOfUSer();
      emit(state.copyWith(status: HomeStatus.loaded, conversas: response));
    } on RepositoryException catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: e.message,
          conversas: [],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: 'Erro ao buscar mensagens',
          conversas: [],
        ),
      );
    }
  }
}
