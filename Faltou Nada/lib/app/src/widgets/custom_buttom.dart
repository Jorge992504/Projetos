import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/fontes_letras.dart';
import 'package:faltou_nada/app/core/ui/style/size_extension.dart';
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final String label;
  final void Function()? onPressed;
  const CustomButtom({
    super.key,
    this.height,
    this.width,
    this.margin,
    this.padding,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 30,
      width: width ?? context.percentWidth(0.85),
      margin: margin ?? const EdgeInsets.only(top: 15),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(ColorsConstants.appBar)),
        child: Text(
          label,
          style: context.fontesLetras.textThin.copyWith(
            fontSize: 14,
            color: ColorsConstants.black,
          ),
        ),
      ),
    );
  }
}
