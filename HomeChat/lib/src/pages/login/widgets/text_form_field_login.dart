import 'package:flutter/material.dart';
import 'package:homechat/src/ui/helpers/form_focus.dart';
import 'package:homechat/src/ui/sizes/size_screen.dart';
import 'package:validatorless/validatorless.dart';

class TextFormFieldEmail extends StatelessWidget {
  final TextEditingController emailEC;
  const TextFormFieldEmail({super.key, required this.emailEC});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
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
            style: TextStyle(color: Colors.blue[300]),
          ),
        ),
      ),
    );
  }
}

class TextFormFieldPassword extends StatelessWidget {
  final TextEditingController passwordEC;
  const TextFormFieldPassword({super.key, required this.passwordEC});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: context.screenMetWidth(0.8),
      child: TextFormField(
        controller: passwordEC,
        onTapOutside: (_) => context.unfocus,
        validator: Validatorless.multiple([
          Validatorless.required('Senha obrigatoria'),
          Validatorless.min(4, 'Senha inválido'),
        ]),
        obscureText: true,
        decoration: InputDecoration(
          label: Text(
            'Senha',
            style: TextStyle(color: Colors.blue[300]),
          ),
          hintStyle: const TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}
