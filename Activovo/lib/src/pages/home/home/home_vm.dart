import 'package:activovo/src/funtional_prog/either.dart';
import 'package:activovo/src/pages/home/home/home_state.dart';
import 'package:activovo/src/providers/application_provider.dart';
import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_vm.g.dart';

@riverpod
class HomeVm extends _$HomeVm {
  @override
  Future<HomeState> build() async {
    final repositori = ref.read(exerciseRepositoryProvider);
    final exercise = await repositori.getExercise();
    switch (exercise) {
      case Success(value: final exercise):
        return HomeState(status: HomeStateStatus.loades, exercise: exercise);
      case Failure():
        return HomeState(status: HomeStateStatus.error, exercise: []);
    }
  }

  Future<void> logout() async => ref.read(logoutProvider.future).asyncLoader();
}
