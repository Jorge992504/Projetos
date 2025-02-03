import 'package:flutter/material.dart';

class IshoppingNavGlobalKey {
  static IshoppingNavGlobalKey? _instance;
  final navKey = GlobalKey<NavigatorState>();
  IshoppingNavGlobalKey._();
  static IshoppingNavGlobalKey get instance =>
      _instance ??= IshoppingNavGlobalKey._();
}
