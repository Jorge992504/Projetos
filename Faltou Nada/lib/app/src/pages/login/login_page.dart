import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/custom_images.dart';
import 'package:faltou_nada/app/core/ui/style/size_extension.dart';
import 'package:faltou_nada/app/src/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImageConstants.loginMascote,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              width: context.percentWidth(0.9),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorsConstants.textos,
              ),
              child: Column(
                children: [
                  CustomTextFormField(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
