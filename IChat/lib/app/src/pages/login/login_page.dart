import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ichat/app/core/router/rotas.dart';
import 'package:ichat/app/core/ui/base/base_state.dart';
import 'package:ichat/app/src/pages/login/login_controller.dart';
import 'package:ichat/app/src/pages/login/login_state.dart';
import 'package:ichat/app/src/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocConsumer<LoginController, LoginState>(
        listener: (context, state) {
          state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            loaded: hideLoader,
            error: () {
              showError(state.errorMessage ?? 'Login ou senha inválidos');
              hideLoader();
            },
            success: () async {
              hideLoader(); // <- Primeiro esconde o loading
              showSuccess('Sucesso ao realizar login');
              await Provider.of<AuthProvider>(
                context,
                listen: false,
              ).atualizarUsuarioLogado();
              // ignore: use_build_context_synchronously
              Navigator.of(
                // ignore: use_build_context_synchronously
                context,
              ).pushNamedAndRemoveUntil(Rotas.home, (route) => false);
            },
          );
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  focusNode: emailFocusNode,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.login(
                        emailController.text,
                        passwordController.text,
                      );
                    },
                    child: const Text('Entrar'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
