import 'package:barber/src/core/constants/local_storage_keys.dart';
import 'package:barber/src/core/providers/application_provider.dart';
import 'package:barber/src/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_vm.g.dart';

enum SplashState {
  initial,
  login,
  loggeAdm,
  loggeEmployee,
  error;
}

@riverpod
class SplashVm extends _$SplashVm {
  @override
  Future<SplashState> build() async {
    final sp = await SharedPreferences.getInstance();
    if (sp.containsKey(LocalStorageKeys.token)) {
      ref.invalidate(getMeProvider);
      ref.invalidate(getMyBarbershopProvider);
      try {
        final userModel = await ref.watch(getMeProvider.future);
        return switch (userModel) {
          UserModelADM() => SplashState.loggeAdm,
          UserModelEmployee() => SplashState.loggeEmployee,
        };
      } catch (e) {
        return SplashState.login;
      }
    } else {
      return SplashState.login;
    }
  }
}
