import 'package:flutter/material.dart';

class ActivovoNavGlobalKey {
  static ActivovoNavGlobalKey? _instance;
  final navKey = GlobalKey<NavigatorState>();
  ActivovoNavGlobalKey._();
  static ActivovoNavGlobalKey get instance =>
      _instance ??= ActivovoNavGlobalKey._();
}
