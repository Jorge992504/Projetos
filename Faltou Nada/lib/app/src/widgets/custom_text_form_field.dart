import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/fontes_letras.dart';
import 'package:faltou_nada/app/core/ui/style/size_extension.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextInputType? keyboardType;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final bool? enabled;
  final TextCapitalization? textCapitalization;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool? autoFocus;
  final InputDecoration? decoration;
  final TextStyle? hintStyle;
  final TextStyle? floatingLabelStyle;
  final TextStyle? labelStyle;
  const CustomTextFormField({
    super.key,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.keyboardType,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.controller,
    this.textInputAction,
    this.obscureText,
    this.enabled,
    this.textCapitalization,
    this.style,
    this.textAlign,
    this.textAlignVertical,
    this.maxLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.border,
    this.focusedBorder,
    this.errorBorder,
    this.focusNode,
    this.nextFocusNode,
    this.autoFocus,
    this.decoration,
    this.hintStyle,
    this.floatingLabelStyle,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40,
      width: width ?? context.percentWidth(0.85),
      margin: margin ?? const EdgeInsets.only(top: 15),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction ?? TextInputAction.done,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        obscureText: obscureText ?? false,
        enabled: enabled ?? true,
        style: style ??
            context.fontesLetras.textLight
                .copyWith(fontSize: 14, color: ColorsConstants.black),
        textAlign: textAlign ?? TextAlign.start,
        textAlignVertical: textAlignVertical,
        maxLength: maxLength,
        initialValue: initialValue,
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        onEditingComplete: onEditingComplete,
        decoration: decoration ??
            InputDecoration(
              labelText: labelText,
              labelStyle: labelStyle ??
                  context.fontesLetras.textLight
                      .copyWith(fontSize: 14, color: ColorsConstants.black),
              hintText: hintText,
              counterText: "",
              hintStyle: hintStyle,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              floatingLabelStyle: floatingLabelStyle,
              contentPadding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: ColorsConstants.appBar,
                ),
              ),
            ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
