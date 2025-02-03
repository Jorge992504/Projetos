import 'package:homechat/src/core/client/res_client.dart';
import 'package:homechat/src/core/fp/either.dart';

import 'package:homechat/src/core/models/user_model.dart';
import 'package:homechat/src/core/repositories/auth/auth_repository.dart';
import 'package:homechat/src/core/repositories/auth/auth_repository_impl.dart';
import 'package:homechat/src/core/repositories/general/repository_general.dart';
import 'package:homechat/src/core/repositories/general/repository_general_impl.dart';

import 'package:homechat/src/core/service/login/login_service.dart';
import 'package:homechat/src/core/service/login/login_service_impl.dart';
import 'package:homechat/src/core/service/register_service/register_service.dart';
import 'package:homechat/src/core/service/register_service/register_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'application_provider.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) =>
    AuthRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
LoginService loginService(LoginServiceRef ref) =>
    LoginServiceImpl(authRepository: ref.read(authRepositoryProvider));

//RESGISTER
@Riverpod(keepAlive: true)
RegisterService registerService(RegisterServiceRef ref) => RegisterServiceImpl(
    authRepository: ref.watch(authRepositoryProvider),
    loginService: ref.watch(loginServiceProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(authRepositoryProvider).me();
  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}

//
@Riverpod(keepAlive: true)
RepositoryGeneral repositoryGeneral(RepositoryGeneralRef ref) =>
    RepositoryGeneralImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<List<UserModel>> getMeUsers(GetMeUsersRef ref) async {
  final users = await ref.watch(getMeUsersProvider.future);
  final repositoryGeneral = ref.watch(repositoryGeneralProvider);
  final result = await repositoryGeneral.getUsers(users);
  return switch (result) {
    Success(value: final users) => users,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
Future<void> logout(LogoutRef ref) async {
  final sp = await SharedPreferences.getInstance();
  sp.clear();
  await sp.remove('token');
  ref.invalidate(getMeProvider);
  ref.invalidate(registerServiceProvider);
  ref.invalidate(repositoryGeneralProvider);
}
