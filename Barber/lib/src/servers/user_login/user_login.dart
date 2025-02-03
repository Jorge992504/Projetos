import 'package:barber/src/core/exceptions/service_exeception.dart';
import 'package:barber/src/core/fp/either.dart';
import 'package:barber/src/core/fp/nil.dart';

abstract interface class UserLogin {
  Future<Either<ServiceExeception, Nil>> execute(String emial, String password);
}
