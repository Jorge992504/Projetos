import 'package:activovo/src/providers/application_provider.dart';
import 'package:activovo/src/services/user_register/user_register_service.dart';
import 'package:activovo/src/services/user_register/user_register_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_register_provider.g.dart';

@riverpod
UserRegisterService userRegisterService(UserRegisterServiceRef ref) =>
    UserRegisterServiceImpl(
        userRepository: ref.watch(userRepositoryProvider),
        userLoginService: ref.watch(userLoginServiceProvider));
