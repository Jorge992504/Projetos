import 'package:flutter/material.dart';

class HomechatNavGlobalKey {
  static HomechatNavGlobalKey? _instance;
  final navKey = GlobalKey<NavigatorState>();
  HomechatNavGlobalKey._();
  static HomechatNavGlobalKey get instance =>
      _instance ??= HomechatNavGlobalKey._();
}
