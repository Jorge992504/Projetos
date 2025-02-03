import 'package:activovo/src/funtional_prog/either.dart';
import 'package:activovo/src/models/model_disease.dart';
import 'package:activovo/src/models/model_user.dart';
import 'package:activovo/src/models/model_exercise.dart';
import 'package:activovo/src/repositories/repository_geral/user_type_repository.dart';
import 'package:activovo/src/repositories/repository_geral/user_type_repository_impl.dart';
import 'package:activovo/src/repositories/user/user_repository.dart';
import 'package:activovo/src/repositories/user/user_repository_impl.dart';
import 'package:activovo/src/restClient/rest_client.dart';
import 'package:activovo/src/rotas/rotas.dart';
import 'package:activovo/src/services/user_login/user_login_service.dart';
import 'package:activovo/src/services/user_login/user_login_service_impl.dart';
import 'package:activovo/src/ui/widgets/activovo_nav_global_key.dart';
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
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));

@Riverpod(keepAlive: true)
Future<ModelUser> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();
  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
UserTypeRepository userTypeRepository(UserTypeRepositoryRef ref) =>
    UserTypeRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<ModelUser> getMeUserType(GetMeUserTypeRef ref) async {
  // final userModel = await ref.watch(getMeProvider.future);

  final userTypeRepository = ref.watch(userTypeRepositoryProvider);
  final result = await userTypeRepository.getMyUserType();
  return switch (result) {
    Success(value: final userType) => userType,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
UserTypeRepository diseaseRepository(UserTypeRepositoryRef ref) =>
    UserTypeRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<List<ModelDisease>> getMeDisease(GetMeDiseaseRef ref) async {
  // final diseaseModel = await ref.watch(getMeDiseaseProvider.future);

  final diseaseRepository = ref.watch(userTypeRepositoryProvider);
  final result = await diseaseRepository.getDisease();
  return switch (result) {
    Success(value: final diseaseM) => diseaseM,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod()
Future<void> logout(LogoutRef ref) async {
  final sp = await SharedPreferences.getInstance();
  sp.clear();

  ref.invalidate(getMeProvider);
  ref.invalidate(getMeUserTypeProvider);
  ref.invalidate(getMeDiseaseProvider);
  Navigator.of(ActivovoNavGlobalKey.instance.navKey.currentContext!)
      .pushNamedAndRemoveUntil(Rotas.login, (router) => false);
}

@Riverpod(keepAlive: true)
UserTypeRepository exerciseRepository(UserTypeRepositoryRef ref) =>
    UserTypeRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<List<ModelExercise>> getMeExercise(GetMeExerciseRef ref) async {
  // final diseaseModel = await ref.watch(getMeDiseaseProvider.future);

  final exerciseRepository = ref.watch(userTypeRepositoryProvider);
  final result = await exerciseRepository.getExercise();
  return switch (result) {
    Success(value: final exercise) => exercise,
    Failure(:final exception) => throw exception,
  };
}
