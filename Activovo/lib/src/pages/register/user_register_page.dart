import 'package:activovo/src/pages/register/user_register_vm.dart';
import 'package:activovo/src/rotas/rotas.dart';
import 'package:activovo/src/ui/colors/colors_constants.dart';

import 'package:activovo/src/ui/helpers/form_focus.dart';
import 'package:activovo/src/ui/helpers/messages.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class UserRegisterPage extends ConsumerStatefulWidget {
  const UserRegisterPage({super.key});

  @override
  ConsumerState<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends ConsumerState<UserRegisterPage> {
  void _showConfirmarDelete() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ColorsConstants.greyEntryF,
          title: Text(
            'Apresenta alguma doença?',
            style: context.fontes.textMedium.copyWith(
              fontSize: 14,
              color: ColorsConstants.greyTitulos,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Rotas.userComDoencas, (router) => false);
                  },
                  child: Text(
                    'Sim',
                    style: context.fontes.textBold
                        .copyWith(color: Colors.green, fontSize: 12),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Rotas.userSemDoencas, (router) => false);
                  },
                  child: Text(
                    'Não',
                    style: context.fontes.textBold
                        .copyWith(color: Colors.red, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRegisterVm = ref.watch(userRegisterVmProvider.notifier);
    ref.listen(userRegisterVmProvider, (_, state) {
      switch (state) {
        case UserRegisterStateStatus.initial:
          break;
        case UserRegisterStateStatus.success:
          _showConfirmarDelete();
        case UserRegisterStateStatus.error:
          Messages.showError("Erro ao registrar usuário", context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          ImageConstante.titulo,
          width: 130,
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(left: 20, top: 30),
              width: context.WidthScreen,
              child: Text(
                overflow: TextOverflow.ellipsis,
                'Cadastro',
                style: context.fontes.textExtraBold.copyWith(
                  fontSize: 24,
                  color: ColorsConstants.greyTitulos,
                ),
              ),
            ),
          ),
          // const SizedBox(
          //   height: 24,
          //   child: Placeholder(),
          // ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameEC,
                    onTapOutside: (_) => context.unfocus(),
                    validator: Validatorless.required('Nome obrigatorio'),
                    decoration: InputDecoration(
                      label: Text(
                        'Nome',
                        style: context.fontes.textRegular.copyWith(
                          color: ColorsConstants.greyTitulos,
                          fontSize: 14,
                        ),
                      ),
                      hintText: 'Nome',
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
                        borderSide:
                            const BorderSide(color: ColorsConstants.greyEntryF),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: emailEC,
                    onTapOutside: (_) => context.unfocus(),
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
                        borderSide:
                            const BorderSide(color: ColorsConstants.greyEntryF),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: passwordEC,
                    obscureText: true,
                    onTapOutside: (_) => context.unfocus(),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Senha obrigatoria'),
                        Validatorless.min(4, 'Senha inválida'),
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
                        borderSide:
                            const BorderSide(color: ColorsConstants.greyEntryF),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    obscureText: true,
                    onTapOutside: (_) => context.unfocus(),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Senha obrigatoria'),
                        Validatorless.compare(passwordEC, 'Senhas diferentes'),
                      ],
                    ),
                    decoration: InputDecoration(
                      label: Text(
                        'Corfirma senha',
                        style: context.fontes.textRegular.copyWith(
                          color: ColorsConstants.greyTitulos,
                          fontSize: 14,
                        ),
                      ),
                      hintText: 'Confirma senha',
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
                        borderSide:
                            const BorderSide(color: ColorsConstants.greyEntryF),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                  SizedBox(
                    width: context.WidthScreenM(0.9),
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        switch (formKey.currentState?.validate()) {
                          case (false || null):
                            Messages.showError('Campos inválidos', context);
                          case true:
                            userRegisterVm.register(
                                name: nameEC.text,
                                email: emailEC.text,
                                password: passwordEC.text);
                            _showConfirmarDelete();
                        }
                      },
                      child: Text(
                        'Salvar',
                        style: context.fontes.textBold.copyWith(
                          color: ColorsConstants.greyBotoes,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
