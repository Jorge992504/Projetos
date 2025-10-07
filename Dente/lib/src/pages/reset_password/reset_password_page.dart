import 'dart:developer';

import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/src/pages/reset_password/reset_password_controller.dart';
import 'package:dente/src/pages/reset_password/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState
    extends BaseState<ResetPasswordPage, ResetPasswordController> {
  final senhaFocus = FocusNode();
  final confirmaSenhaFocus = FocusNode();
  final senhaController = TextEditingController();
  final confirmaSenhaController = TextEditingController();

  final codigo1Controller = TextEditingController();
  final codigo2Controller = TextEditingController();
  final codigo3Controller = TextEditingController();
  final codigo4Controller = TextEditingController();

  final codigo1Focus = FocusNode();
  final codigo2Focus = FocusNode();
  final codigo3Focus = FocusNode();
  final codigo4Focus = FocusNode();

  String email = "";
  late bool isUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final route = ModalRoute.of(context);
      final arguments =
          (route!.settings.arguments ?? <String, dynamic>{}) as Map;
      setState(() {
        email = arguments['email'];
      });
      controller.enviaEmailRedefineSenha(email);
    });
    isUser = true;
  }

  @override
  void dispose() {
    // senhaFocus.dispose();
    // confirmaSenhaFocus.dispose();
    senhaController.dispose();
    confirmaSenhaController.dispose();
    codigo1Controller.dispose();
    codigo2Controller.dispose();
    codigo3Controller.dispose();
    codigo4Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsConstants.primaryColor,
        iconTheme: IconThemeData(color: ColorsConstants.appBarColor),
      ),
      body: BlocConsumer<ResetPasswordController, ResetPasswordState>(
        listener: (context, state) {
          state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            loaded: hideLoader,
            failure: () {
              showError(state.errorMessage ?? 'INTERNAL_ERROR');
              hideLoader();
            },
            success: () async {
              hideLoader();
            },
          );
        },
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, tamanho) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: tamanho.maxWidth * 1,
                    child: Text(
                      "Redefinir senha",
                      style: context.cusotomFontes.textExtraBold.copyWith(
                        color: ColorsConstants.letrasColor,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 14),

                  !isUser
                      ? SizedBox(
                          width: tamanho.maxWidth * 0.3,
                          child: TextFormField(
                            cursorColor: ColorsConstants.appBarColor,
                            decoration: InputDecoration(
                              labelText: "Senha",
                              hintText: "Digite a senha",
                            ),
                            validator: Validatorless.multiple([
                              Validatorless.min(
                                4,
                                'Senha deve ter minimo 4 cacteres',
                              ),
                              Validatorless.required("Senha obrigatoria"),
                            ]),
                            controller: senhaController,
                            focusNode: senhaFocus,
                            textInputAction: TextInputAction.next,
                          ),
                        )
                      : SizedBox(),
                  const SizedBox(height: 14),
                  !isUser
                      ? SizedBox(
                          width: tamanho.maxWidth * 0.3,
                          child: TextFormField(
                            cursorColor: ColorsConstants.appBarColor,
                            decoration: InputDecoration(
                              labelText: "Confirme sua Senha",
                              hintText: "Digite a senha",
                            ),
                            validator: Validatorless.multiple([
                              Validatorless.compare(
                                senhaController,
                                "Senhas diferentes",
                              ),
                              Validatorless.required("Senha obrigatoria"),
                            ]),
                            controller: confirmaSenhaController,
                            focusNode: confirmaSenhaFocus,
                            textInputAction: TextInputAction.done,
                          ),
                        )
                      : SizedBox(),
                  isUser
                      ? SizedBox(
                          width: tamanho.maxWidth * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: tamanho.maxWidth * 0.07,

                                child: TextField(
                                  controller: codigo1Controller,
                                  focusNode: codigo1Focus,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: ColorsConstants.appBarColor,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(width: 3),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: tamanho.maxWidth * 0.07,

                                child: TextField(
                                  controller: codigo2Controller,
                                  focusNode: codigo2Focus,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: ColorsConstants.appBarColor,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(width: 3),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: tamanho.maxWidth * 0.07,

                                child: TextField(
                                  controller: codigo3Controller,
                                  focusNode: codigo3Focus,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: ColorsConstants.appBarColor,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(width: 3),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: tamanho.maxWidth * 0.07,
                                child: TextField(
                                  controller: codigo4Controller,
                                  focusNode: codigo4Focus,
                                  textInputAction: TextInputAction.done,
                                  cursorColor: ColorsConstants.appBarColor,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(width: 3),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  const SizedBox(height: 24),
                  Container(
                    width: tamanho.maxWidth * 0.4,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        // setState(() {
                        //   isUser = !isUser;
                        // });
                        verificaCodigo();
                      },
                      child: Text(
                        isUser ? 'Verificar' : 'Redefinir senha',
                        style: context.cusotomFontes.textBold.copyWith(
                          color: ColorsConstants.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future<void> verificaCodigo() async {
    String codigoString =
        codigo1Controller.text +
        codigo2Controller.text +
        codigo3Controller.text +
        codigo4Controller.text;
    int codigo = int.tryParse(codigoString) ?? 0;
    log('$codigo');
  }
}
