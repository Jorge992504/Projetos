import 'package:homechat/src/core/keys/local_storage_keys.dart';
import 'package:homechat/src/core/providers/application_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_vm.g.dart';

enum SplashStateStatus {
  initial,
  login,
  error,
}

@riverpod
class SplashVm extends _$SplashVm {
  @override
  Future<SplashStateStatus> build() async {
    final sp = await SharedPreferences.getInstance();
    if (sp.containsKey(LocalStorageKeys.token)) {
      ref.invalidate(getMeProvider);
      return SplashStateStatus.login;
    } else {
      throw SplashStateStatus.error;
    }
  }
}
