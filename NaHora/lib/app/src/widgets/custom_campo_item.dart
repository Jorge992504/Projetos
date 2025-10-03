import 'package:flutter/material.dart';
import 'package:nahora/app/core/ui/style/custom_colors.dart';
import 'package:nahora/app/core/ui/style/fontes_letras.dart';

class CustomCampoItem extends StatelessWidget {
  final double? widthText;
  final double? heightText;
  final EdgeInsetsGeometry? paddingText;
  final EdgeInsetsGeometry? marginText;
  final String? labelText;
  final TextStyle? style;
  final AlignmentGeometry? alignmentText;

  const CustomCampoItem({
    super.key,
    this.widthText,
    this.heightText,
    this.paddingText,
    this.marginText,
    this.labelText,
    this.alignmentText,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return Container(
      width: widthText,
      height: heightText,
      padding: paddingText,
      margin: marginText,
      alignment: alignmentText,
      child: Text(
        labelText ?? "",
        style:
            style ??
            context.cusotomFontes.textBold.copyWith(
              fontSize: 16,
              color: brightness == Brightness.light
                  ? ColorsConstants.letrasColor
                  : ColorsConstants.primaryColor,
              height: 1,
            ),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
