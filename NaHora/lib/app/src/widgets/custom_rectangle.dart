import 'package:flutter/material.dart';
import 'package:nahora/app/core/ui/style/custom_colors.dart';

class CustomRectangle extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final Function()? onTap;
  const CustomRectangle({
    super.key,
    this.width,
    this.height,
    this.padding,
    this.child,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: ShapeDecoration(
          color: brightness == Brightness.light
              ? ColorsConstants.cardColor
              : ColorsConstants.focusColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: brightness == Brightness.light
                  ? ColorsConstants.focusColor
                  : ColorsConstants.cardColor,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: child,
      ),
    );
  }
}
