import 'package:flutter/material.dart';
import 'package:ishopping/src/ui/colors/colors_constants.dart';
import 'package:ishopping/src/ui/extensions/size_screen.dart';
import 'package:ishopping/src/ui/fonts/fontes_constants.dart';
import 'package:ishopping/src/ui/helpers/form_focus.dart';
import 'package:validatorless/validatorless.dart';

class RegisterTextFormFieldName extends StatelessWidget {
  final TextEditingController nameEC;
  const RegisterTextFormFieldName({
    super.key,
    required this.nameEC,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: context.screenMetWidth(0.8),
      child: TextFormField(
        controller: nameEC,
        onTapOutside: (_) => context.unfocus,
        validator: Validatorless.required('Nome obrigatorio'),
        decoration: InputDecoration(
          label: Text(
            'Nome',
            style: context.fontes.textRegular.copyWith(
              fontSize: 18,
              color: ColorsConstants.label,
            ),
          ),
          hintText: 'Nome',
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

class RegisterTextFormFieldEmail extends StatelessWidget {
  final TextEditingController emailEC;
  const RegisterTextFormFieldEmail({
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

class RegisterTextFormFieldPassword extends StatelessWidget {
  final TextEditingController passwordEC;
  const RegisterTextFormFieldPassword({
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
        onTapOutside: (_) => context.unfocus,
        validator: Validatorless.multiple([
          Validatorless.required('Senha obrigatoria'),
          Validatorless.min(4, 'Senha inválida'),
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

class RegisterTextFormFieldPasswordConfirm extends StatelessWidget {
  final TextEditingController passwordConfirmEC;
  final TextEditingController passwordEC;
  const RegisterTextFormFieldPasswordConfirm({
    super.key,
    required this.passwordConfirmEC,
    required this.passwordEC,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: context.screenMetWidth(0.8),
      child: TextFormField(
        controller: passwordConfirmEC,
        onTapOutside: (_) => context.unfocus,
        validator: Validatorless.multiple([
          Validatorless.required('Senha obrigatoria'),
          Validatorless.compare(passwordEC, 'Senhas diferentes'),
        ]),
        decoration: InputDecoration(
          label: Text(
            'Confirma Senha',
            style: context.fontes.textRegular.copyWith(
              fontSize: 18,
              color: ColorsConstants.label,
            ),
          ),
          hintText: 'Confirma Senha',
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
