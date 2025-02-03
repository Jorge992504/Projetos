import 'package:Ativovo/style/colors_app.dart';
import 'package:Ativovo/style/text_styles.dart';
import 'package:flutter/material.dart';

class AppStaly {
  static AppStaly? _instace;

  AppStaly._();

  static AppStaly get i {
    _instace ??= AppStaly._();
    return _instace!;
  }

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        backgroundColor: ColorsApp.i.primary,
        textStyle: TextStyles.i.textButtonLabel,
      );
}

extension AppStylesExtension on BuildContext {
  AppStaly get appStyles => AppStaly.i;
}
