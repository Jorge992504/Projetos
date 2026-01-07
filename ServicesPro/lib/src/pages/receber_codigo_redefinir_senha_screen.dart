import 'package:flutter/material.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';

class ReceberCodigoRedefinirSenhaScreen extends StatefulWidget {
  const ReceberCodigoRedefinirSenhaScreen({super.key});

  @override
  State<ReceberCodigoRedefinirSenhaScreen> createState() =>
      _ReceberCodigoRedefinirSenhaScreenState();
}

class _ReceberCodigoRedefinirSenhaScreenState
    extends State<ReceberCodigoRedefinirSenhaScreen> {
  final formKey = GlobalKey<FormState>();
  bool isCOdigoEnviado = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: !isCOdigoEnviado
              ? Column(
                  children: [
                    const SizedBox(height: 60),
                    Text(
                      'Informe seu e-mail para receber o código de redefinição de senha.',
                      style: context.cusotomFontes.regular.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              labelStyle: context.cusotomFontes.regular
                                  .copyWith(
                                    color: TemaSistema().temaSistema(context)
                                        ? ColorsConstants.primaryColor
                                        : ColorsConstants.letrasColor,
                                    fontSize: 16,
                                  ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: TemaSistema().temaSistema(context)
                                      ? ColorsConstants.telaColor
                                      : ColorsConstants.letrasColor,
                                  width: 2,
                                ),
                              ),
                            ),

                            cursorHeight: 18,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  // Ação de login
                                  setState(() {
                                    isCOdigoEnviado = true;
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorsConstants.azulColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Enviar Código',
                                style: context.cusotomFontes.black.copyWith(
                                  color: ColorsConstants.primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    const SizedBox(height: 60),
                    Text(
                      'Código enviado! Verifique seu e-mail para redefinir sua senha.',
                      style: context.cusotomFontes.regular.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Form(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: TextFormField(
                                  // textAlignVertical:
                                  //     TextAlignVertical.center, // ✅ AQUI
                                  maxLength: 1,
                                  style: context.cusotomFontes.bold.copyWith(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: "",
                                    labelStyle: context.cusotomFontes.regular
                                        .copyWith(
                                          color:
                                              TemaSistema().temaSistema(context)
                                              ? ColorsConstants.primaryColor
                                              : ColorsConstants.letrasColor,
                                          fontSize: 16,
                                        ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color:
                                            TemaSistema().temaSistema(context)
                                            ? ColorsConstants.telaColor
                                            : ColorsConstants.letrasColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),

                                  cursorHeight: 18,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: TextFormField(
                                  // textAlignVertical:
                                  //     TextAlignVertical.center, // ✅ AQUI
                                  maxLength: 1,
                                  style: context.cusotomFontes.bold.copyWith(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: "",
                                    labelStyle: context.cusotomFontes.regular
                                        .copyWith(
                                          color:
                                              TemaSistema().temaSistema(context)
                                              ? ColorsConstants.primaryColor
                                              : ColorsConstants.letrasColor,
                                          fontSize: 16,
                                        ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color:
                                            TemaSistema().temaSistema(context)
                                            ? ColorsConstants.telaColor
                                            : ColorsConstants.letrasColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),

                                  cursorHeight: 18,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: TextFormField(
                                  // textAlignVertical:
                                  //     TextAlignVertical.center, // ✅ AQUI
                                  maxLength: 1,
                                  style: context.cusotomFontes.bold.copyWith(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: "",
                                    labelStyle: context.cusotomFontes.regular
                                        .copyWith(
                                          color:
                                              TemaSistema().temaSistema(context)
                                              ? ColorsConstants.primaryColor
                                              : ColorsConstants.letrasColor,
                                          fontSize: 16,
                                        ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color:
                                            TemaSistema().temaSistema(context)
                                            ? ColorsConstants.telaColor
                                            : ColorsConstants.letrasColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),

                                  cursorHeight: 18,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: TextFormField(
                                  // textAlignVertical:
                                  //     TextAlignVertical.center, // ✅ AQUI
                                  maxLength: 1,
                                  style: context.cusotomFontes.bold.copyWith(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: "",
                                    labelStyle: context.cusotomFontes.regular
                                        .copyWith(
                                          color:
                                              TemaSistema().temaSistema(context)
                                              ? ColorsConstants.primaryColor
                                              : ColorsConstants.letrasColor,
                                          fontSize: 16,
                                        ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color:
                                            TemaSistema().temaSistema(context)
                                            ? ColorsConstants.telaColor
                                            : ColorsConstants.letrasColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),

                                  cursorHeight: 18,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Ação após o código ser enviado
                          Navigator.of(context).pushNamed(Rotas.redefinirSenha);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsConstants.azulColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Confirmar',
                          style: context.cusotomFontes.black.copyWith(
                            color: ColorsConstants.primaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
