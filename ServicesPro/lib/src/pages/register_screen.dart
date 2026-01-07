import 'package:flutter/material.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  bool oscureText = true;
  bool habilitarBotao = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Text(
                  'Criar conta.',
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
                  'Preencha seus dados para começar.',
                  style: context.cusotomFontes.regular.copyWith(
                    color: TemaSistema().temaSistema(context)
                        ? ColorsConstants.primaryColor
                        : ColorsConstants.letrasColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 14),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: ColorsConstants.secundaryColor.withOpacity(
                      0.3,
                    ),
                    radius: 50,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_enhance_outlined,
                        color: ColorsConstants.secundaryColor,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Adicionar foto de perfil (opcional)',
                    style: context.cusotomFontes.regular.copyWith(
                      color: ColorsConstants.secundaryColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Nome completo',
                          labelStyle: context.cusotomFontes.regular.copyWith(
                            color: TemaSistema().temaSistema(context)
                                ? ColorsConstants.primaryColor
                                : ColorsConstants.letrasColor,
                            fontSize: 16,
                          ),
                          hintText: 'Digite seu nome completo',
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
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          labelStyle: context.cusotomFontes.regular.copyWith(
                            color: TemaSistema().temaSistema(context)
                                ? ColorsConstants.primaryColor
                                : ColorsConstants.letrasColor,
                            fontSize: 16,
                          ),
                          hintText: 'Digite seu e-mail',
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
                          hintText: 'Digite sua senha',
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
                              oscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
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
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Confirmar Senha',
                          labelStyle: context.cusotomFontes.regular.copyWith(
                            color: TemaSistema().temaSistema(context)
                                ? ColorsConstants.primaryColor
                                : ColorsConstants.letrasColor,
                            fontSize: 16,
                          ),
                          hintText: 'Digite sua senha novamente',
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
                              oscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
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
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Checkbox(
                            value: habilitarBotao,
                            onChanged: (value) {
                              setState(() {
                                habilitarBotao = value ?? false;
                              });
                            },
                            activeColor: ColorsConstants.azulColor,
                            checkColor: ColorsConstants.letrasColor,
                          ),
                          Expanded(
                            child: Text(
                              'Aceito os termos de uso e política de privacidade',
                              style: context.cusotomFontes.regular.copyWith(
                                color: TemaSistema().temaSistema(context)
                                    ? ColorsConstants.primaryColor
                                    : ColorsConstants.letrasColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushNamed(Rotas.termosPolitica);
                            },
                            child: Text(
                              'Termos de uso e\npolítica de privacidade',
                              style: context.cusotomFontes.regular.copyWith(
                                color: TemaSistema().temaSistema(context)
                                    ? ColorsConstants.secundaryColor
                                    : ColorsConstants.azulColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: habilitarBotao
                              ? () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    Rotas.registerClientEmployee,
                                    (route) => false,
                                  );
                                }
                              : null,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsConstants.secundaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Criar conta',
                            style: context.cusotomFontes.bold.copyWith(
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
            ),
          ),
        ),
      ),
    );
  }
}
