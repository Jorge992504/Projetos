import 'package:barber/src/core/exceptions/service_exeception.dart';
import 'package:barber/src/core/fp/either.dart';
import 'package:barber/src/core/fp/nil.dart';

abstract interface class UserRegisterServiceAdm {
  Future<Either<ServiceExeception, Nil>> execute(
      ({
        String name,
        String emai,
        String password,
        String profile,
      }) userData);
}
