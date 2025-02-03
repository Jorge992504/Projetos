// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:activovo/src/models/model_exercise.dart';

enum HomeStateStatus {
  loades,
  error,
}

class HomeState {
  final HomeStateStatus status;
  final List<ModelExercise> exercise;

  HomeState({
    required this.status,
    required this.exercise,
  });

  HomeState copyWith({
    HomeStateStatus? status,
    List<ModelExercise>? exercise,
  }) {
    return HomeState(
      status: status ?? this.status,
      exercise: exercise ?? this.exercise,
    );
  }
}
