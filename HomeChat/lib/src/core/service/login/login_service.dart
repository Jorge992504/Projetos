import 'package:homechat/src/core/exceptions/service_exception.dart';
import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/fp/nil.dart';

abstract interface class LoginService {
  Future<Either<ServiceException, Nil>> execute(String email, String passowrd);
}
