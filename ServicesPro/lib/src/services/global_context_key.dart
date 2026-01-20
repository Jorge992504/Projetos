import 'package:flutter/material.dart';

class GlobalContextKey {
  late final GlobalKey<NavigatorState> _navigator;
  static GlobalContextKey? _instance;

  GlobalContextKey._();

  static GlobalContextKey get instance {
    _instance ??= GlobalContextKey._();
    return _instance!;
  }

  set navigatorKey(GlobalKey<NavigatorState> key) => _navigator = key;
  GlobalKey<NavigatorState> get navigatorKey => _navigator;
}
