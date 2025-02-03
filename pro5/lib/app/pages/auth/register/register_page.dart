import 'package:delivery/app/core/ui/base_state/base_state.dart';
import 'package:delivery/app/core/ui/style/text_styles.dart';
import 'package:delivery/app/core/ui/widgets/delivery_appbar.dart';
import 'package:delivery/app/core/ui/widgets/delivery_button.dart';
import 'package:delivery/app/pages/auth/register/register_controller.dart';
import 'package:delivery/app/pages/auth/register/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController(); // fu-text-edit
  final _formKey = GlobalKey<FormState>(); //fu-forem-key
  @override
  void dispose() {
    _nome.dispose();
    _email.dispose();
    _senha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          register: () => showLoader(),
          error: () {
            hideLoader();
            showError('Erro ao registrar usuário');
          },
          success: () {
            hideLoader();
            showSuccess('Cadastro realizado com sucesso');
            Navigator.pop(context);
          },
        );
      },
      child: Scaffold(
        appBar: DeliveryAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastro',
                    style: context.textStyles.textTitle,
                  ),
                  Text(
                    'Preencha os campos para criar o cadastro',
                    style: context.textStyles.textMedium.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _nome,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    validator: Validatorless.required('Nome obrigatorio'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('E-mail obrigatorio'),
                        Validatorless.email('E-mail inválido'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _senha,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Senha'),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Senha obrigatoria'),
                        Validatorless.min(
                            8, 'Senha deve conter pelo menos 8 caracteres'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration:
                        const InputDecoration(labelText: 'Confirma senha'),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Confirma senha obrigatoria'),
                        Validatorless.compare(
                            _senha, 'Senha diferente de confirma senha'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: DeliveryButton(
                      onPressed: () {
                        final valid =
                            _formKey.currentState?.validate() ?? false;
                        if (valid) {
                          controller.registerUsuarios(
                            _email.text,
                            _nome.text,
                            _senha.text,
                          );
                        }
                      },
                      label: 'Cadastrar',
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
