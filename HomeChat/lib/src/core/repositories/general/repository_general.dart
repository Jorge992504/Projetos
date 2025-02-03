import 'package:homechat/src/core/exceptions/repository_exception.dart';
import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/fp/nil.dart';
import 'package:homechat/src/core/models/user_model.dart';

abstract interface class RepositoryGeneral {
  Future<Either<RepositoryException, List<UserModel>>> getUsers(
      List<UserModel> name);

  Future<Either<RepositoryException, Nil>> invitation(
      ({String email, String text}) data);

  Future<Either<RepositoryException, Nil>> confirmCod(({int codigo}) data);

  Future<Either<RepositoryException, Nil>> addRequest(({int userId}) data);

  Future<Either<RepositoryException, List<UserModel>>> getRequest();

  Future<Either<RepositoryException, Nil>> aceptRequest(({int friendId}) data);

  Future<Either<RepositoryException, Nil>> deletRequest(({int request}) data);

  Future<Either<RepositoryException, List<UserModel>>> getFriend();

  Future<Either<RepositoryException, Nil>> deletFriend(({int friendId}) data);
}
