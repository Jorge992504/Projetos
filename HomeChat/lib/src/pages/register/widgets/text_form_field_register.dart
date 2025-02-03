import 'package:flutter/material.dart';
import 'package:homechat/src/ui/helpers/form_focus.dart';
import 'package:homechat/src/ui/sizes/size_screen.dart';
import 'package:validatorless/validatorless.dart';

class TextFormFieldRegisterEmail extends StatelessWidget {
  final TextEditingController emailEC;
  const TextFormFieldRegisterEmail({super.key, required this.emailEC});

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

class TextFormFieldRegisterPassword extends StatelessWidget {
  final TextEditingController passwordEC;
  const TextFormFieldRegisterPassword({super.key, required this.passwordEC});

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
          Validatorless.min(4, 'Senha inválida'),
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

class TextFormFieldRegisterConfirmaPassword extends StatelessWidget {
  final TextEditingController passwordEC;
  final TextEditingController confirmapasswordEC;
  const TextFormFieldRegisterConfirmaPassword(
      {super.key, required this.passwordEC, required this.confirmapasswordEC});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: context.screenMetWidth(0.8),
      child: TextFormField(
        controller: confirmapasswordEC,
        onTapOutside: (_) => context.unfocus,
        validator: Validatorless.multiple([
          Validatorless.required('Confirmação de senha obrigatoria'),
          Validatorless.compare(passwordEC, 'As senhas não são iguais'),
        ]),
        obscureText: true,
        decoration: InputDecoration(
          label: Text(
            'Confirma senha',
            style: TextStyle(color: Colors.blue[300]),
          ),
          hintStyle: const TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}

class TextFormFieldRegisterName extends StatelessWidget {
  final TextEditingController nameEC;
  const TextFormFieldRegisterName({super.key, required this.nameEC});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: context.screenMetWidth(0.8),
      child: TextFormField(
        controller: nameEC,
        onTapOutside: (_) => context.unfocus,
        validator: Validatorless.multiple([
          Validatorless.required('Nome obrigatorio'),
        ]),
        decoration: InputDecoration(
          label: Text(
            'Nome e sobrenome',
            style: TextStyle(color: Colors.blue[300]),
          ),
        ),
      ),
    );
  }
}
