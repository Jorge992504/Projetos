import 'package:flutter/material.dart';
import 'package:homechat/src/ui/sizes/size_screen.dart';
import 'package:validatorless/validatorless.dart';

class TextFormFielInvatationEmail extends StatelessWidget {
  final TextEditingController emailEC;

  const TextFormFielInvatationEmail({super.key, required this.emailEC});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      height: 60,
      child: TextFormField(
        textAlign: TextAlign.left,
        controller: emailEC,
        validator: Validatorless.multiple([
          Validatorless.required('O e-mail é obrigatorio'),
          Validatorless.email('Esse e-mail não é valido'),
        ]),
        decoration: const InputDecoration(
          hintText: 'Digite o e-mail para enviar o convite',
          // suffixIcon: IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.send_rounded,
          //     color: Colors.blue,
          //   ),
          // ),
        ),
      ),
    );
  }
}

class TextFormFielText extends StatelessWidget {
  final TextEditingController textEC;
  final VoidCallback onPressed;
  const TextFormFielText(
      {super.key, required this.textEC, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: context.screenWidth,
      // height: context.screenMetHeight(0.1),
      child: TextFormField(
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        controller: textEC,
        expands: true,
        maxLines: null,
        // validator: Validatorless.multiple([
        //   Validatorless.required('O e-mail é obrigatorio'),
        //   Validatorless.email('Esse e-mail não é valido'),
        // ]),
        decoration: InputDecoration(
          hintText: 'Quer enviar uma mensagem personalizada?',
          suffixIcon: Padding(
            padding: const EdgeInsets.only(top: 450, right: 10),
            child: IconButton(
              alignment: Alignment.bottomRight,
              onPressed: onPressed,
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.blue,
                size: 34,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
