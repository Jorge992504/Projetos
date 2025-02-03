import 'package:flutter/material.dart';
import 'package:ishopping/core/fp/either.dart';
import 'package:ishopping/core/restClient/rest_client.dart';
import 'package:ishopping/core/router/rotas.dart';
import 'package:ishopping/src/models/products_model.dart';
import 'package:ishopping/src/models/user_model.dart';
import 'package:ishopping/src/repositories/auth/auth_user_repository.dart';
import 'package:ishopping/src/repositories/auth/auth_user_repository_impl.dart';
import 'package:ishopping/src/repositories/repository_geral/ishopping_repository.dart';
import 'package:ishopping/src/repositories/repository_geral/ishopping_repository_impl.dart';
import 'package:ishopping/src/service/user_login/user_login_service.dart';
import 'package:ishopping/src/service/user_login/user_login_service_impl.dart';
import 'package:ishopping/src/ui/widgets/ishopping_nav_global_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'application_provider.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
AuthUserRepository authUserRepository(AuthUserRepositoryRef ref) =>
    AuthUserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImpl(
        authUserRepository: ref.read(authUserRepositoryProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(authUserRepositoryProvider).me();
  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
IshoppingRepository ishoppingRepository(IshoppingRepositoryRef ref) =>
    IshoppingRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<List<ProductsModel>> getMeProducts(GetMeProductsRef ref) async {
  final products = await ref.watch(getMeProductsProvider.future);
  final ishoppingRepository = ref.watch(ishoppingRepositoryProvider);
  final result = await ishoppingRepository.getProducts(products);
  return switch (result) {
    Success(value: final products) => products,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod()
Future<void> logout(LogoutRef ref) async {
  final sp = await SharedPreferences.getInstance();
  sp.clear();

  ref.invalidate(getMeProvider);
  ref.invalidate(getMeProductsProvider);
  ref.invalidate(authUserRepositoryProvider);
  ref.invalidate(ishoppingRepositoryProvider);

  Navigator.of(IshoppingNavGlobalKey.instance.navKey.currentContext!)
      .pushNamedAndRemoveUntil(Rotas.login, (router) => false);
}
