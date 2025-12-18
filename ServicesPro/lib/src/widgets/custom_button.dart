import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;
  final WidgetStateProperty<Color?>? backgroundColor;
  final TextStyle? style;
  const CustomButton({
    super.key,
    this.onPressed,
    required this.label,
    this.width,
    this.height,
    this.padding,
    this.decoration,
    this.backgroundColor,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: decoration,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(backgroundColor: backgroundColor),
        child: Text(label, style: style),
      ),
    );
  }
}
