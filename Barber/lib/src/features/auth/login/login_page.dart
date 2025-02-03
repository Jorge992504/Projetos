import 'package:barber/src/core/ui/constant/color_constants.dart';
import 'package:barber/src/core/ui/helpers/form_herlpers.dart';
import 'package:barber/src/core/ui/helpers/messages.dart';
import 'package:barber/src/features/auth/login/login_state.dart';
import 'package:barber/src/features/auth/login/login_vm.dart';
import 'package:barber/src/rotas/rotas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emialEC = TextEditingController();
  final passwordEC = TextEditingController();
  @override
  void dispose() {
    emialEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);
    ref.listen(loginVmProvider, (_, state) {
      switch (state) {
        case LoginState(status: LoginStateStatus.initial):
          break;
        case LoginState(status: LoginStateStatus.error, :final errorMessage?):
          Messages.showError(errorMessage, context);
        case LoginState(status: LoginStateStatus.error):
          Messages.showError("Erro ao relizar login", context);
        case LoginState(status: LoginStateStatus.admLogin):
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Rotas.adm, (router) => false);
          break;
        case LoginState(status: LoginStateStatus.employeeLogin):
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Rotas.employee, (router) => false);
          break;
      }
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formKey,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ImageConstante.backgroundImage,
              ),
              opacity: 0.2,
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageConstante.imageLogo,
                          ),
                          TextFormField(
                            controller: emialEC,
                            onTapOutside: (_) => context.unfocus,
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required('E-mail obrigatorio'),
                                Validatorless.email('E-mail invalido'),
                              ],
                            ),
                            decoration: const InputDecoration(
                              label: Text('E-mail'),
                              hintText: 'E-mail',
                              hintStyle: TextStyle(color: Colors.black),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            onTapOutside: (_) => context.unfocus,
                            controller: passwordEC,
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required('Senha obrigatoria'),
                                Validatorless.min(
                                    4, 'Senha deve ter ao menos 4 caracteres'),
                              ],
                            ),
                            obscureText: true,
                            decoration: const InputDecoration(
                              label: Text('Senha'),
                              hintText: 'Senha',
                              hintStyle: TextStyle(color: Colors.black),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Esqueceu a senha?',
                              style: TextStyle(
                                color: ColorConstants.brow,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(56),
                            ),
                            onPressed: () {
                              switch (formKey.currentState?.validate()) {
                                case (false || null):
                                  Messages.showError(
                                      'Campos invalidos', context);
                                case true:
                                  login(emialEC.text, passwordEC.text);
                              }
                            },
                            child: const Text('Acessar'),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(Rotas.userRegister);
                          },
                          child: const Text(
                            'Criar conta',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
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
