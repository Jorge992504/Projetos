import 'package:barber/src/core/exceptions/auth_exception.dart';
import 'package:barber/src/core/exceptions/repository_exeception.dart';
import 'package:barber/src/core/fp/either.dart';
import 'package:barber/src/core/fp/nil.dart';
import 'package:barber/src/models/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);

  Future<Either<RepositoryExeception, UserModel>> me();

  Future<Either<RepositoryExeception, Nil>> registerAdmin(
      ({String name, String emai, String password, String profile}) userData);

  Future<Either<RepositoryExeception, List<UserModel>>> getEmployee(
      int barbershopId);
}
