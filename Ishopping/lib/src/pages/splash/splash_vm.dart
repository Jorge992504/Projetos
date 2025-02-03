import 'package:ishopping/core/keys/LocalStorageKeys.dart';
import 'package:ishopping/core/providers/application_provider.dart';
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
      ref.invalidate(getMeProductsProvider);
      return SplashStateStatus.login;
    } else {
      throw SplashStateStatus.error;
    }
  }
}
