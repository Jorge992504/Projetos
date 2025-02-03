import 'package:activovo/src/error/repository_exception.dart';
import 'package:activovo/src/funtional_prog/either.dart';
import 'package:activovo/src/funtional_prog/nil.dart';
import 'package:activovo/src/models/model_disease.dart';
import 'package:activovo/src/models/model_user.dart';
import 'package:activovo/src/models/model_exercise.dart';

abstract interface class UserTypeRepository {
//
  Future<Either<RepositoryException, Nil>> saveDays(
      ({
        List<String> days,
      }) data);

  Future<Either<RepositoryException, Nil>> saveDaysDisease(
      ({
        List<String> days,
        List<int> disease,
      }) data);

  Future<Either<RepositoryException, Nil>> savePlanImprovements(
      ({
        List<String> improvement,
      }) data);

  Future<Either<RepositoryException, Nil>> modifyUser(
      ({
        String profile,
      }) data);

//
  Future<Either<RepositoryException, ModelUser>> getMyUserType();

  Future<Either<RepositoryException, List<ModelDisease>>> getDisease();

  Future<Either<RepositoryException, List<ModelExercise>>> getExercise();

  Future<Either<RepositoryException, List<ModelExercise>>> getExerciseVip();
}
