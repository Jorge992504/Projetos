import 'package:flutter/material.dart';
import 'package:ishopping/src/ui/colors/colors_constants.dart';
import 'package:ishopping/src/ui/extensions/size_screen.dart';
import 'package:ishopping/src/ui/fonts/fontes_constants.dart';
import 'package:ishopping/src/ui/helpers/form_focus.dart';
import 'package:validatorless/validatorless.dart';

class LoginTextFormFieldEmail extends StatelessWidget {
  final TextEditingController emailEC;

  const LoginTextFormFieldEmail({
    super.key,
    required this.emailEC,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: context.screenMetWidth(0.8),
      child: TextFormField(
        controller: emailEC,
        onTapOutside: (_) => context.unfocus,
        validator: Validatorless.multiple([
          Validatorless.required('E-mail obrigatorio'),
          Validatorless.email('E-mail inválido'),
        ]),
        decoration: InputDecoration(
          label: Text(
            'E-mail',
            style: context.fontes.textRegular.copyWith(
              fontSize: 18,
              color: ColorsConstants.label,
            ),
          ),
          hintText: 'E-mail',
          hintStyle: context.fontes.textMedium.copyWith(
            fontSize: 18,
            color: ColorsConstants.title,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: context.fontes.textRegular.copyWith(
            fontSize: 18,
            color: ColorsConstants.label,
          ),
          fillColor: ColorsConstants.fundoLabel,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorsConstants.fundoLabel,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: ColorsConstants.fundoLabel,
            ),
          ),
        ),
      ),
    );
  }
}

class LoginTextFormFieldPassword extends StatelessWidget {
  final TextEditingController passwordEC;
  const LoginTextFormFieldPassword({
    super.key,
    required this.passwordEC,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: context.screenMetWidth(0.8),
      child: TextFormField(
        controller: passwordEC,
        obscureText: true,
        onTapOutside: (_) => context.unfocus,
        validator: Validatorless.multiple([
          Validatorless.required('Senha obrigatoria'),
          Validatorless.min(4, 'A senha deve ter mais de 4 caractares'),
        ]),
        decoration: InputDecoration(
          label: Text(
            'Senha',
            style: context.fontes.textRegular.copyWith(
              fontSize: 18,
              color: ColorsConstants.label,
            ),
          ),
          hintText: 'Senha',
          hintStyle: context.fontes.textMedium.copyWith(
            fontSize: 18,
            color: ColorsConstants.title,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: context.fontes.textRegular.copyWith(
            fontSize: 18,
            color: ColorsConstants.label,
          ),
          fillColor: ColorsConstants.fundoLabel,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorsConstants.fundoLabel,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: ColorsConstants.fundoLabel,
            ),
          ),
        ),
      ),
    );
  }
}
