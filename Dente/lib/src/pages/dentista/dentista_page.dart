import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/src/models/dentista_model.dart';
import 'package:dente/src/pages/dentista/dentista_controller.dart';
import 'package:dente/src/pages/dentista/dentista_state.dart';
import 'package:dente/src/pages/dentista/widgets/table_dentista.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:validatorless/validatorless.dart';

class DentistaPage extends StatefulWidget {
  const DentistaPage({super.key});

  @override
  State<DentistaPage> createState() => _DentistaPageState();
}

class _DentistaPageState extends BaseState<DentistaPage, DentistaController> {
  final emailController = TextEditingController();
  final nmController = TextEditingController();
  final croController = TextEditingController();
  final telefoneController = TextEditingController();

  final emailFocus = FocusNode();
  final nmFocus = FocusNode();
  final croFocus = FocusNode();
  final telefoneFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  bool isPesquisa = true;
  bool isAtivo = true;
  bool isVoltar = true;

  List<DentistaModel> dentistaModel = [];
  List<DentistaModel> sugestoes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.buscarDentista();
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    nmController.dispose();
    croController.dispose();
    telefoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isPesquisa == true ? 'Dentistas' : 'Cadastrar dentista'),
        leading: IconButton(
          onPressed: () {
            if (isPesquisa) {
              Navigator.pop(context);
            } else {
              setState(() {
                isPesquisa = true;
              });
            }
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: BlocConsumer<DentistaController, DentistaState>(
        listener: (context, state) {
          state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            loaded: hideLoader,
            failure: () {
              hideLoader();
              showError(state.errorMessage ?? 'INTERNAL_ERROR');
            },
            success: () async {
              hideLoader();
              showSuccess("Sucesso ao realizar cadastro.");
            },
          );
        },
        builder: (context, state) {
          //Todos: tabela que mostra todos os dentistas-----------------------------------------
          return isPesquisa == true
              ? Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        width: 500,
                        height: 60,
                        margin: EdgeInsets.only(top: 25),
                        child: TextField(
                          autofocus: true,
                          cursorColor: ColorsConstants.appBarColor,
                          cursorHeight: 15,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.search_outlined,
                              size: 25,
                              color: ColorsConstants.appBarColor,
                            ),
                          ),
                          onChanged: (value) {
                            buscarDentistaPorNome(value);
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 450,
                        width: 900,
                        child: ListView.builder(
                          itemCount: state.dentistas != null
                              ?
                                // state.dentistas!.length
                                (sugestoes.isNotEmpty
                                    ? sugestoes.length
                                    : state.dentistas!.length)
                              : 0,
                          itemBuilder: (context, index) {
                            dentistaModel = state.dentistas ?? [];
                            DentistaModel dentista = sugestoes.isNotEmpty
                                ? sugestoes[index]
                                : state.dentistas![index];
                            // state.dentistas![index];
                            return TableDentista(
                              nome:
                                  dentista.nome ?? sugestoes[index].nome ?? "",
                              email:
                                  dentista.email ??
                                  sugestoes[index].email ??
                                  "",
                              cro: dentista.cro ?? sugestoes[index].cro ?? "",
                              telefone:
                                  dentista.telefone ??
                                  sugestoes[index].telefone ??
                                  "",

                              onTap: () {
                                setState(() {
                                  isAtivo = !(dentista.ativo ?? true);
                                  dentista.ativo = isAtivo;
                                });
                                controller.inativarAtivarDentistas(
                                  dentista.email!,
                                );
                              },
                              isAtivo: dentista.ativo ?? false,
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        alignment: Alignment.center,
                        width: 900,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isPesquisa = false;
                            });
                            emailController.clear();
                            nmController.clear();
                            croController.clear();
                            telefoneController.clear();
                          },
                          child: Text(
                            'Registrar novo dentista',
                            style: context.cusotomFontes.textItalic.copyWith(
                              color: ColorsConstants.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              //Todos: formulario para registrar um novo dentista----------------------------------------------------------------------
              : Align(
                  alignment: Alignment.center,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 400,
                          height: 60,
                          child: TextFormField(
                            cursorColor: ColorsConstants.appBarColor,
                            decoration: InputDecoration(
                              labelText: "Nome do dentista",
                              hintText: "Informe o nome do dentista",
                            ),
                            validator: Validatorless.multiple([
                              Validatorless.required("Nome obrigatorio"),
                            ]),
                            controller: nmController,
                            focusNode: nmFocus,
                            textInputAction: TextInputAction.next,
                            autofocus: true,
                            onFieldSubmitted: (value) {
                              emailFocus.requestFocus();
                              setState(() {
                                isVoltar = isPesquisa;
                              });
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 400,
                          height: 60,
                          child: TextFormField(
                            cursorColor: ColorsConstants.appBarColor,
                            decoration: InputDecoration(
                              labelText: "E-mail do dentista",
                              hintText: "Informe o e-mail do dentista",
                            ),
                            validator: Validatorless.multiple([
                              Validatorless.required("E-mail obrigatorio"),
                              Validatorless.email("Informe um e-mail valido"),
                            ]),
                            controller: emailController,
                            focusNode: emailFocus,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (value) {
                              croFocus.requestFocus();
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 400,
                          height: 60,
                          child: TextFormField(
                            cursorColor: ColorsConstants.appBarColor,
                            decoration: InputDecoration(
                              labelText: "CRO do dentista",
                              hintText: "Informe o CRO do dentista",
                              counterText: "",
                            ),
                            maxLength: 9,
                            validator: Validatorless.multiple([
                              Validatorless.required("CRO obrigatorio"),
                            ]),
                            controller: croController,
                            focusNode: croFocus,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (value) {
                              telefoneFocus.requestFocus();
                            },
                          ),
                        ),

                        Container(
                          alignment: Alignment.center,
                          width: 400,
                          height: 60,
                          child: TextFormField(
                            cursorColor: ColorsConstants.appBarColor,
                            decoration: InputDecoration(
                              labelText: "Telefone do dentista",
                              hintText: "Informe o telefone do dentista",
                            ),
                            validator: Validatorless.multiple([
                              Validatorless.required("Telefone obrigatorio"),
                            ]),
                            controller: telefoneController,
                            focusNode: telefoneFocus,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            inputFormatters: [celularFormatter],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15),
                          alignment: Alignment.center,
                          width: 900,
                          child: ElevatedButton(
                            onPressed: () async {
                              // if (isVoltar) {
                              //   setState(() {
                              //     isPesquisa = !isPesquisa;
                              //   });
                              // } else {

                              // }
                              // dentistaModel = await controller.buscarDentista();
                              await registrarDentitsa();
                              // setState(() {
                              //   isPesquisa = !isPesquisa;
                              // });
                              refresh();
                            },
                            child: Text(
                              'Salvar dados',
                              style: context.cusotomFontes.textItalic.copyWith(
                                color: ColorsConstants.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

  //! formata numero telefone
  final celularFormatter = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  //! registrar dentista
  Future<void> registrarDentitsa() async {
    final valid = formKey.currentState?.validate() ?? false;
    if (valid) {
      DentistaModel model = DentistaModel(
        email: emailController.text,
        nome: nmController.text,
        cro: croController.text,
        telefone: telefoneController.text,
      );
      await controller.registrarDentista(model);
    }
  }

  //! buscar dentistas por nome
  void buscarDentistaPorNome(String value) {
    String nome = value;
    setState(() {
      sugestoes = controller.state.dentistas!
          .where((p) => p.nome!.toLowerCase().contains(nome.toLowerCase()))
          .toList();
    });
  }

  void refresh() async {
    await controller.buscarDentista(); // recarrega a lista do backend
    setState(() {
      isPesquisa = true;
      isVoltar = isPesquisa;
    }); // força a tela a rebuildar com os novos dados
  }
}
