import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

mixin class Messages {
  static void showError(String message, BuildContext context) {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: message,
        ));
  }

  static void showInfo(String message, BuildContext context) {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.info(
          message: message,
          icon: const Icon(
            Icons.mark_email_read_rounded,
            size: 50,
          ),
        ));
  }

  static void showSuccess(String message, BuildContext context) {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: message,
        ));
  }
}
