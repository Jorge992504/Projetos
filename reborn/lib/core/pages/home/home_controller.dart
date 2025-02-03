import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/core/pages/home/home_state.dart';

import 'package:reborn/core/repositorio/home_repository.dart';

class HomeController extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeController(this._homeRepository) : super(const HomeState.initial());

  Future<void> listarTreino() async {
    emit(
      state.copyWith(status: HomeStateStatus.loading),
    );
    final exe = await _homeRepository.listarTreino();
    emit(state.copyWith(status: HomeStateStatus.loaded, exe: exe));
  }
}
