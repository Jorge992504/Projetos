import 'package:activovo/src/funtional_prog/either.dart';
import 'package:activovo/src/pages/home/home/home_state.dart';
import 'package:activovo/src/providers/application_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_vip_vm.g.dart';

@riverpod
class HomeVipVm extends _$HomeVipVm {
  @override
  Future<HomeState> build() async {
    final repositori = ref.read(exerciseRepositoryProvider);
    final exercise = await repositori.getExerciseVip();
    switch (exercise) {
      case Success(value: final exercise):
        return HomeState(status: HomeStateStatus.loades, exercise: exercise);
      case Failure():
        return HomeState(status: HomeStateStatus.error, exercise: []);
    }
  }
}
