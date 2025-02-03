import 'package:ishopping/core/providers/application_provider.dart';
import 'package:ishopping/src/service/user_register/user_register_service.dart';
import 'package:ishopping/src/service/user_register/user_register_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_provider.g.dart';

@riverpod
UserRegisterService userRegisterService(UserRegisterServiceRef ref) =>
    UserRegisterServiceImpl(
        authUserRepository: ref.watch(authUserRepositoryProvider),
        userLoginService: ref.watch(userLoginServiceProvider));
