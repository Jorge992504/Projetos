import 'package:activovo/src/pages/login/login_state.dart';
import 'package:activovo/src/pages/login/login_vm.dart';
import 'package:activovo/src/rotas/rotas.dart';
import 'package:activovo/src/ui/colors/colors_constants.dart';
import 'package:activovo/src/ui/helpers/form_focus.dart';
import 'package:activovo/src/ui/helpers/messages.dart';
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
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
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
        case LoginState(
            status: LoginStateStatus.error,
          ):
          Messages.showError('Erro ao realizar login', context);
        case LoginState(status: LoginStateStatus.login):
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Rotas.home, (router) => false);
        case LoginState(status: LoginStateStatus.vipLogin):
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Rotas.homeVip, (router) => false);
      }
    });
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            image: const DecorationImage(
                              image: AssetImage(
                                ImageConstante.activoco,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(right: 100),
                            width: context.WidthScreen,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              'Login',
                              style: context.fontes.textExtraBold.copyWith(
                                fontSize: 24,
                                color: ColorsConstants.greyTitulos,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        TextFormField(
                          controller: emailEC,
                          onTapOutside: (_) => context.unfocus,
                          validator: Validatorless.multiple(
                            [
                              Validatorless.required('E-mail obrigatorio'),
                              Validatorless.email('E-mail inválido'),
                            ],
                          ),
                          decoration: InputDecoration(
                            label: Text(
                              'E-mail',
                              style: context.fontes.textRegular.copyWith(
                                color: ColorsConstants.greyTitulos,
                                fontSize: 14,
                              ),
                            ),
                            hintText: 'E-mail',
                            hintStyle: context.fontes.textLight.copyWith(
                              fontSize: 12,
                              color: ColorsConstants.greyTitulos,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: context.fontes.textLight.copyWith(
                              fontSize: 14,
                              color: ColorsConstants.greyTitulos,
                            ),
                            fillColor: ColorsConstants.greyEntryF,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: const BorderSide(
                                color: ColorsConstants.greyEntryF,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: const BorderSide(
                                  color: ColorsConstants.greyEntryF),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          controller: passwordEC,
                          obscureText: true,
                          onTapOutside: (_) => context.unfocus,
                          validator: Validatorless.multiple(
                            [
                              Validatorless.required('Senha obrigatoria'),
                            ],
                          ),
                          decoration: InputDecoration(
                            label: Text(
                              'Senha',
                              style: context.fontes.textRegular.copyWith(
                                color: ColorsConstants.greyTitulos,
                                fontSize: 14,
                              ),
                            ),
                            hintText: 'Senha',
                            hintStyle: context.fontes.textLight.copyWith(
                              fontSize: 12,
                              color: ColorsConstants.greyTitulos,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: context.fontes.textLight.copyWith(
                              fontSize: 14,
                              color: ColorsConstants.greyTitulos,
                            ),
                            fillColor: ColorsConstants.greyEntryF,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: const BorderSide(
                                color: ColorsConstants.greyEntryF,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: const BorderSide(
                                  color: ColorsConstants.greyEntryF),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              'Esqueceu a senha?',
                              style: context.fontes.textLight.copyWith(
                                color: ColorsConstants.greyTitulos,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        SizedBox(
                          width: context.WidthScreenM(0.8),
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              switch (formKey.currentState?.validate()) {
                                case (false || null):
                                  Messages.showError(
                                      'Campos inválidos', context);
                                case true:
                                  login(emailEC.text, passwordEC.text);
                              }
                            },
                            child: Text(
                              'Acessar',
                              style: context.fontes.textBold.copyWith(
                                color: ColorsConstants.greyBotoes,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(Rotas.register);
                            },
                            child: Text(
                              'Criar conta',
                              style: context.fontes.textSemiBold.copyWith(
                                fontSize: 13,
                                color: ColorsConstants.greyTitulos,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
