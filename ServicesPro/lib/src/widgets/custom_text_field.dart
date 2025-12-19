import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';

class CustomTextField extends StatelessWidget {
  final bool isDark;
  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String)? onSubmitted;
  final Widget? prefixIcon;
  final String? labelText;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? enabled;
  final Widget? suffixIcon;
  final int? maxLines;
  final double? height;
  const CustomTextField({
    super.key,
    required this.isDark,
    required this.label,
    this.controller,
    this.focusNode,
    this.onSubmitted,
    this.prefixIcon,
    this.labelText,
    required this.textAlign,
    this.textInputAction,
    this.keyboardType,
    this.enabled,
    this.suffixIcon,
    this.maxLines = 1,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.percentWidth(0.9),
      height: height ?? 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isDark
            ? Theme.of(context).colorScheme.surface
            : ColorsConstants.telaColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        cursorHeight: 18,
        maxLines: maxLines ?? 1,
        controller: controller,
        focusNode: focusNode,
        onSubmitted: onSubmitted,
        textAlign: textAlign,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        enabled: enabled,
        cursorColor: isDark
            ? ColorsConstants.primaryColor
            : ColorsConstants.letrasColor,

        decoration: InputDecoration(
          border: InputBorder.none,
          hint: Text(label),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText,
        ),
      ),
    );
  }
}
