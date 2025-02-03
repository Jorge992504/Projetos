import 'package:activovo/src/error/auth_exception.dart';
import 'package:activovo/src/error/repository_exception.dart';
import 'package:activovo/src/funtional_prog/either.dart';
import 'package:activovo/src/funtional_prog/nil.dart';
import 'package:activovo/src/models/model_user.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);

  Future<Either<RepositoryException, ModelUser>> me();

  Future<Either<RepositoryException, Nil>> registerUser(
      ({String name, String email, String password}) userData);
}
