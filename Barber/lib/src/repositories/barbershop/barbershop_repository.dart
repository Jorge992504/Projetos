import 'package:barber/src/core/exceptions/repository_exeception.dart';
import 'package:barber/src/core/fp/either.dart';
import 'package:barber/src/core/fp/nil.dart';
import 'package:barber/src/models/barbershop_model.dart';
import 'package:barber/src/models/user_model.dart';

abstract interface class BarbershopRepository {
  Future<Either<RepositoryExeception, Nil>> save(
      ({
        String name,
        String email,
        List<String> openingDays,
        List<int> openingHours,
      }) data);
  Future<Either<RepositoryExeception, BarbershopModel>> getMyBarbershop(
      UserModel userModel);
}
