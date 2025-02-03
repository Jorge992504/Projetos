import 'package:ishopping/core/errors/service_exception.dart';
import 'package:ishopping/core/fp/either.dart';
import 'package:ishopping/core/fp/nil.dart';

abstract interface class UserLoginService {
  Future<Either<ServiceException, Nil>> execute(String email, String password);
}
