import 'package:flutter/material.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';

class RedefinirSenhaScreen extends StatefulWidget {
  const RedefinirSenhaScreen({super.key});

  @override
  State<RedefinirSenhaScreen> createState() => _RedefinirSenhaScreenState();
}

class _RedefinirSenhaScreenState extends State<RedefinirSenhaScreen> {
  final formKey = GlobalKey<FormState>();
  bool oscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Text(
                  'Redefinir Senha',
                  style: context.cusotomFontes.bold.copyWith(
                    fontSize: 24,
                    color: TemaSistema().temaSistema(context)
                        ? ColorsConstants.primaryColor
                        : ColorsConstants.letrasColor,
                  ),
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
                        oscureText ? Icons.visibility_off : Icons.visibility,
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
                        oscureText ? Icons.visibility_off : Icons.visibility,
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
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Ação após o código ser enviado
                      Navigator.of(context).pushNamed(Rotas.login);
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
      ),
    );
  }
}
