import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

//gera as messages da tela
mixin CustomMessages<T extends StatefulWidget> on State<T> {
  void showError(String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: message,
        backgroundColor: ColorsConstants.errorColor,
        textStyle: context.cusotomFontes.medium.copyWith(
          color: ColorsConstants.primaryColor,
          fontSize: 20,
        ),
        icon: Icon(Icons.error_outline, color: ColorsConstants.iconeErrorColor),
      ),
      animationDuration: Duration(seconds: 2),
      snackBarPosition: SnackBarPosition.bottom,
    );
  }

  void showInfo(String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        message: message,
        backgroundColor: ColorsConstants.secundaryColor,
        textStyle: context.cusotomFontes.medium.copyWith(
          color: ColorsConstants.primaryColor,
          fontSize: 20,
        ),
        icon: Icon(Icons.info_outline, color: ColorsConstants.azulColor),
      ),
    );
  }

  void showSuccess(String message) {
    showTopSnackBar(
      Overlay.of(context),

      CustomSnackBar.success(
        message: message,
        textStyle: context.cusotomFontes.medium.copyWith(
          color: ColorsConstants.primaryColor,
          fontSize: 20,
        ),
        icon: Icon(Icons.task_alt_outlined),
      ),
    );
  }
}
