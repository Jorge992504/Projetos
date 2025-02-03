import 'package:barber/src/core/providers/application_provider.dart';
import 'package:barber/src/servers/user_register/user_register_service_adm.dart';
import 'package:barber/src/servers/user_register/user_register_service_adm_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_register_provider_adm.g.dart';

@riverpod
UserRegisterServiceAdm userRegisterServiceAdm(UserRegisterServiceAdmRef ref) =>
    UserRegisterServiceAdmImpl(
        userRepository: ref.watch(userRepositoryProvider),
        userLogin: ref.watch(userLoginProvider));
