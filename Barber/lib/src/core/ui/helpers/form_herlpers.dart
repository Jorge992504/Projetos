import 'package:flutter/material.dart';

void unFocus(BuildContext context) => FocusScope.of(context).unfocus();

extension UnFocus on BuildContext {
  void unfocus() => FocusScope.of(this).unfocus();
}
