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
          fontSize: 18,
        ),
        icon: Padding(
          padding: const EdgeInsets.all(30),
          child: Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.error_outline,
              color: ColorsConstants.iconeErrorColor,
              size: 32,
            ),
          ),
        ),
      ),
      snackBarPosition: SnackBarPosition.bottom,

      /// ⏱️ tempo que o erro fica visível
      displayDuration: const Duration(milliseconds: 300),

      /// 🎬 tempo da animação
      animationDuration: const Duration(milliseconds: 300),
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
          fontSize: 18,
        ),
        icon: Padding(
          padding: const EdgeInsets.all(30),
          child: Icon(
            Icons.info_outline,
            color: ColorsConstants.azulColor,
            size: 32,
          ),
        ),
      ),
      displayDuration: const Duration(milliseconds: 300),

      /// 🎬 tempo da animação
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  void showSuccess(String message) {
    showTopSnackBar(
      Overlay.of(context),

      CustomSnackBar.success(
        message: message,
        textStyle: context.cusotomFontes.medium.copyWith(
          color: ColorsConstants.primaryColor,
          fontSize: 18,
        ),
        icon: Padding(
          padding: const EdgeInsets.all(30),
          child: Icon(Icons.task_alt_outlined, size: 32),
        ),
      ),
      displayDuration: const Duration(milliseconds: 300),

      /// 🎬 tempo da animação
      animationDuration: const Duration(milliseconds: 300),
    );
  }
}
