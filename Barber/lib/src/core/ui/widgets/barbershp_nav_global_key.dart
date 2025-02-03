import 'package:flutter/material.dart';

class BarbershpNavGlobalKey {
  static BarbershpNavGlobalKey? _instance;
  final navKey = GlobalKey<NavigatorState>();
  BarbershpNavGlobalKey._();
  static BarbershpNavGlobalKey get instance =>
      _instance ??= BarbershpNavGlobalKey._();
}
