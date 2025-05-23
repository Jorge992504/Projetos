import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class GlobalContext {
  late final GlobalKey<NavigatorState> _navigator;
  static GlobalContext? _instance;
  GlobalContext._();

  static GlobalContext get i {
    _instance ??= GlobalContext._();
    return _instance!;
  }

  set navigatorKey(GlobalKey<NavigatorState> key) => _navigator = key;

  Future<void> loginExpire() async {
    final sp = await SharedPreferences.getInstance();
    sp.clear();
    showTopSnackBar(
      _navigator.currentState!.overlay!,
      const CustomSnackBar.error(
        message: 'Login expirado, clique na sacola novamente',
        backgroundColor: Colors.black,
      ),
    );
    _navigator.currentState!.popUntil(ModalRoute.withName('/home'));
  }
}
