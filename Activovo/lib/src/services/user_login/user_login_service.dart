import 'package:activovo/src/error/service_exception.dart';
import 'package:activovo/src/funtional_prog/either.dart';
import 'package:activovo/src/funtional_prog/nil.dart';

abstract interface class UserLoginService {
  Future<Either<ServiceException, Nil>> execute(String email, String password);
}
