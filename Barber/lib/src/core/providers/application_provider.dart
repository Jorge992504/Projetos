import 'dart:async';

import 'package:barber/src/core/fp/either.dart';
import 'package:barber/src/core/restClient/rest_client.dart';
import 'package:barber/src/core/ui/widgets/barbershp_nav_global_key.dart';
import 'package:barber/src/models/barbershop_model.dart';
import 'package:barber/src/models/user_model.dart';
import 'package:barber/src/repositories/barbershop/barbershop_repository.dart';
import 'package:barber/src/repositories/barbershop/barbershop_repository_impl.dart';

import 'package:barber/src/repositories/user/user_repository.dart';
import 'package:barber/src/repositories/user/user_repository_impl.dart';
import 'package:barber/src/rotas/rotas.dart';
import 'package:barber/src/servers/user_login/user_login.dart';
import 'package:barber/src/servers/user_login/user_login_impl.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'application_provider.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) =>
    UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLogin userLogin(UserLoginRef ref) =>
    UserLoginImpl(userRepository: ref.read(userRepositoryProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();
  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
BarbershopRepository barbershopRepository(BarbershopRepositoryRef ref) =>
    BarbershopRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<BarbershopModel> getMyBarbershop(GetMyBarbershopRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);
  final barbershopRepository = ref.watch(barbershopRepositoryProvider);
  final result = await barbershopRepository.getMyBarbershop(userModel);
  return switch (result) {
    Success(value: final barbershop) => barbershop,
    Failure(:final exception) => throw exception
  };
}

@riverpod
Future<void> logout(LogoutRef ref) async {
  final sp = await SharedPreferences.getInstance();
  sp.clear();
  ref.invalidate(getMeProvider);
  ref.invalidate(getMyBarbershopProvider);
  Navigator.of(BarbershpNavGlobalKey.instance.navKey.currentContext!)
      .pushNamedAndRemoveUntil(Rotas.login, (routes) => false);
}
