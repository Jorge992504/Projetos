import 'package:activovo/src/ui/colors/colors_constants.dart';
import 'package:activovo/src/ui/helpers/form_focus.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class TextCarPayment extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String requiValid;
  const TextCarPayment(
      {super.key,
      required this.controller,
      required this.label,
      required this.requiValid});

  @override
  State<TextCarPayment> createState() => _TextCarPaymentState();
}

class _TextCarPaymentState extends State<TextCarPayment> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onTapOutside: (_) => context.unfocus,
      validator: Validatorless.multiple(
        [
          Validatorless.required(widget.requiValid),
        ],
      ),
      decoration: InputDecoration(
        label: Text(
          widget.label,
          style: context.fontes.textRegular.copyWith(
            color: ColorsConstants.greyTitulos,
            fontSize: 14,
          ),
        ),
        hintText: widget.label,
        hintStyle: context.fontes.textLight.copyWith(
          fontSize: 12,
          color: ColorsConstants.greyTitulos,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: context.fontes.textLight.copyWith(
          fontSize: 14,
          color: ColorsConstants.greyTitulos,
        ),
        fillColor: ColorsConstants.greyEntryF,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            color: ColorsConstants.greyEntryF,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: ColorsConstants.greyEntryF),
        ),
      ),
    );
  }
}
