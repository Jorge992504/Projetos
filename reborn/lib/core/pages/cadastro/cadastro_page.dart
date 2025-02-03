import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:reborn/core/bot%C3%B5es/button_salvar_cadastro.dart';
import 'package:reborn/core/componentes/cadastro_componentes/card_cadastro.dart';
import 'package:reborn/core/componentes/cadastro_componentes/dataformfield_data.dart';
import 'package:reborn/core/componentes/cadastro_componentes/textformfield_altura.dart';
import 'package:reborn/core/componentes/cadastro_componentes/textformfield_conf_senha.dart';
import 'package:reborn/core/componentes/cadastro_componentes/textformfield_email.dart';
import 'package:reborn/core/componentes/cadastro_componentes/textformfield_nome.dart';
import 'package:reborn/core/componentes/cadastro_componentes/textformfield_peso.dart';
import 'package:reborn/core/componentes/cadastro_componentes/textformfield_senha.dart';
import 'package:reborn/core/componentes/cadastro_componentes/textformfield_sobrenome.dart';
import 'package:reborn/core/componentes/cadastro_componentes/textformfield_usuario.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';

import 'package:reborn/core/pages/cadastro/cadastro_controller.dart';
import 'package:reborn/core/pages/cadastro/cadastro_state.dart';

import 'package:reborn/core/rotas/rotas.dart';
import 'package:reborn/core/ui/base_state.dart';
import 'package:reborn/core/widgets/reborn_app_bar.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPage();
}

final textNome = TextEditingController();
final textSobreNome = TextEditingController();
final dataController = DateFormFieldController();
final textEmail = TextEditingController();
final textPeso = TextEditingController();
final textAltura = TextEditingController();
final textUsuario = TextEditingController();
final textSenha = TextEditingController();
final textConfirmaSenha = TextEditingController();

final _formKey = GlobalKey<FormState>();

class _CadastroPage extends BaseState<CadastroPage, CadastrarController> {
  void _showConfirmarDelete() {
    showDialog(
      context: context,
      barrierDismissible: false, //para q o usuario tenha q escolher uma opcao
      builder: (context) {
        return AlertDialog(
          title: const Text('Apresenta alguma doença?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed(Rotas.semdoencas);
              },
              child: Text(
                'Não',
                style: context.textEstilo.textBold.copyWith(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed(Rotas.doenca);
              },
              child: Text(
                'Sim',
                style:
                    context.textEstilo.textBold.copyWith(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CadastrarController, CadastrarState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          register: () => showLoader(),
          error: () {
            hideLoader();
            showError('Erro ao cadastrar usuário');
          },
          success: () {
            hideLoader();
            showSuccess('Cadastro realizado com sucesso');
            textNome.clear();
            textSobreNome.clear();
            dataController.clear();
            textEmail.clear();
            textPeso.clear();
            textAltura.clear();
            textUsuario.clear();
            textSenha.clear();
            textConfirmaSenha.clear();
            _showConfirmarDelete();
          },
        );
      },
      child: Scaffold(
        appBar: RebornAppBar(),
        body: Stack(
          children: [
            Form(
              key: _formKey,
              child: ListView(
                children: [
                  CardCadastro(
                    widget: Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      alignment: Alignment.topCenter,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: TextFormFielNome(
                              textNome: textNome,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            margin: const EdgeInsets.only(top: 45),
                            child: TextFormFielSobreNome(
                              textSobreNome: textSobreNome,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            margin: const EdgeInsets.only(top: 90),
                            child: TextFormFielEmail(
                              textEmail: textEmail,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            margin: const EdgeInsets.only(top: 138),
                            child: DateFormField(
                              dateController: dataController,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            margin: const EdgeInsets.only(top: 188),
                            child: TextFormFielPeso(
                              textPeso: textPeso,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            margin: const EdgeInsets.only(top: 234),
                            child: TextFormFielAltura(
                              textAltura: textAltura,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            margin: const EdgeInsets.only(top: 280),
                            child: TextFormFielUsuario(
                              textUsuario: textUsuario,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            margin: const EdgeInsets.only(top: 330),
                            child: TextFormFieldSenha(
                              textSenha: textSenha,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            margin: const EdgeInsets.only(top: 380),
                            child: TextFormFieldConfirmaSenha(
                              textConfirmaSenha: textConfirmaSenha,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ButtonSalvarCadastro(
                    label: 'Salvar cadastro',
                    onPressed: () {
                      final valid = _formKey.currentState?.validate() ?? false;
                      if (valid) {
                        controller.cadastrar(
                          textUsuario.text,
                          textSenha.text,
                          textNome.text,
                          textSobreNome.text,
                          double.parse(textPeso.text),
                          double.parse(textAltura.text),
                          textEmail.text,
                          dataController.data,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
