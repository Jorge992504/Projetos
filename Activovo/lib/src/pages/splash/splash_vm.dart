import 'package:activovo/src/custom/keys.dart';
import 'package:activovo/src/providers/application_provider.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_vm.g.dart';

enum SplashState {
  initial,
  login,
  loggeVip,
  logge,
  error,
}

@riverpod
class SplashVm extends _$SplashVm {
  @override
  Future<SplashState> build() async {
    final sp = await SharedPreferences.getInstance();
    if (sp.containsKey(Keys.token)) {
      ref.invalidate(getMeProvider);
      ref.invalidate(getMeUserTypeProvider);
      try {
        final userModel = await ref.watch(getMeProvider.future);
        return switch (userModel.profile) {
          'VIP' => SplashState.loggeVip,
          'user' => SplashState.logge,
          _ => SplashState.login,
        };
      } catch (e) {
        return SplashState.login;
      }
    } else {
      return SplashState.login;
    }
  }
}
