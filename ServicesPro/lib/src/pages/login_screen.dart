import 'package:flutter/material.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool oscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Text(
                'Bem-vindo de volta!',
                style: context.cusotomFontes.black.copyWith(
                  color: TemaSistema().temaSistema(context)
                      ? ColorsConstants.primaryColor
                      : ColorsConstants.letrasColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Entre para continuar conectando-se com profissionais.',
                style: context.cusotomFontes.regular.copyWith(
                  color: TemaSistema().temaSistema(context)
                      ? ColorsConstants.primaryColor
                      : ColorsConstants.letrasColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 14),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        labelStyle: context.cusotomFontes.regular.copyWith(
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
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        labelStyle: context.cusotomFontes.regular.copyWith(
                          color: TemaSistema().temaSistema(context)
                              ? ColorsConstants.primaryColor
                              : ColorsConstants.letrasColor,
                          fontSize: 16,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),

                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              oscureText = !oscureText;
                            });
                          },
                          icon: Icon(
                            Icons.visibility,
                            color: TemaSistema().temaSistema(context)
                                ? ColorsConstants.primaryColor
                                : ColorsConstants.letrasColor,
                          ),
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
                      obscureText: oscureText,

                      cursorHeight: 18,
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Rotas.receberCodigo);
                  },
                  child: Text(
                    'Esqueci minha senha',
                    style: context.cusotomFontes.medium.copyWith(
                      color: TemaSistema().temaSistema(context)
                          ? ColorsConstants.primaryColor
                          : ColorsConstants.letrasColor,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              Expanded(child: const SizedBox(height: 24)),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Ação de login
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsConstants.azulColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Entrar',
                    style: context.cusotomFontes.black.copyWith(
                      color: ColorsConstants.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: TemaSistema().temaSistema(context)
                          ? ColorsConstants.primaryColor
                          : ColorsConstants.letrasColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'ou',
                      style: context.cusotomFontes.regular.copyWith(
                        color: TemaSistema().temaSistema(context)
                            ? ColorsConstants.primaryColor
                            : ColorsConstants.letrasColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: TemaSistema().temaSistema(context)
                          ? ColorsConstants.primaryColor
                          : ColorsConstants.letrasColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Rotas.register);
                    },
                    child: Text(
                      'Não tem uma conta? Registre-se',
                      style: context.cusotomFontes.medium.copyWith(
                        color: TemaSistema().temaSistema(context)
                            ? ColorsConstants.primaryColor
                            : ColorsConstants.letrasColor,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
