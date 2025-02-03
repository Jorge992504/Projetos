import 'package:ishopping/core/errors/auth_exception.dart';
import 'package:ishopping/core/errors/repository_exception.dart';
import 'package:ishopping/core/fp/either.dart';
import 'package:ishopping/core/fp/nil.dart';
import 'package:ishopping/src/models/user_model.dart';

abstract interface class AuthUserRepository {
  //LOGIN USER
  Future<Either<AuthException, String>> loginUser(
      String email, String password);

  //REGISTER USER
  Future<Either<RepositoryException, Nil>> registerUser(
      ({String name, String email, String password}) userData);

  //BUSCAR USUÁRIO LOGADO
  Future<Either<RepositoryException, UserModel>> me();
}
