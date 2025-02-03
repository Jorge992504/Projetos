import 'package:activovo/src/ui/colors/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ActivovoLoader extends StatelessWidget {
  const ActivovoLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: ColorsConstants.greenFundo,
        size: 60,
      ),
    );
  }
}
