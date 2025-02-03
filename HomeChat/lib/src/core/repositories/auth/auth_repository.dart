import 'package:homechat/src/core/exceptions/repository_exception.dart';
import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/fp/nil.dart';
import 'package:homechat/src/core/models/user_model.dart';

abstract interface class AuthRepository {
  Future<Either<RepositoryException, String>> login(
      String email, String password);

  Future<Either<RepositoryException, Nil>> register(
      ({String name, String password, String email}) userData);

  Future<Either<RepositoryException, UserModel>> me();
}
