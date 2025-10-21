import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/src/models/paciente_model.dart';
import 'package:dente/src/pages/registrar_paciente/registrar_paciente_controller.dart';
import 'package:dente/src/pages/registrar_paciente/registrar_paciente_state.dart';
import 'package:dente/src/pages/registrar_paciente/widgets/table_paciente.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:validatorless/validatorless.dart';

class RegistrarPacientePage extends StatefulWidget {
  const RegistrarPacientePage({super.key});

  @override
  State<RegistrarPacientePage> createState() => _RegistrarPacientePageState();
}

class _RegistrarPacientePageState
    extends BaseState<RegistrarPacientePage, RegistrarPacienteController> {
  final emailController = TextEditingController();
  final nmController = TextEditingController();
  final cpfController = TextEditingController();
  final rgController = TextEditingController();
  final enderecoController = TextEditingController();
  final telefoneController = TextEditingController();

  final emailFocus = FocusNode();
  final nmFocus = FocusNode();
  final cpfFocus = FocusNode();
  final rgFocus = FocusNode();
  final enderecoFocus = FocusNode();
  final telefoneFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  bool isPesquisa = true;
  bool isVoltar = true;

  List<PacienteModel> sugestoes = [];
  List<PacienteModel> pacienteModel = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.buscarPacientes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar paciente')),
      body: BlocConsumer<RegistrarPacienteController, RegistrarPacienteState>(
        listener: (context, state) {
          state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            loaded: hideLoader,
            failure: () {
              showError(state.errorMessage ?? 'INTERNAL_ERROR');
              hideLoader();
            },
            success: () async {
              showSuccess("Sucesso ao realizar cadastro.");
              // Navigator.of(context).pop();
              hideLoader();
            },
          );
        },
        builder: (context, state) {
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
                            buscarPacientePorNome(value);
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 450,
                        width: 900,
                        child: ListView.builder(
                          itemCount: state.pacientes != null
                              ?
                                // state.dentistas!.length
                                (sugestoes.isNotEmpty
                                    ? sugestoes.length
                                    : state.pacientes!.length)
                              : 0,
                          itemBuilder: (context, index) {
                            pacienteModel = state.pacientes ?? [];
                            PacienteModel paciente = sugestoes.isNotEmpty
                                ? sugestoes[index]
                                : state.pacientes![index];
                            // state.dentistas![index];
                            return TablePaciente(
                              nome:
                                  paciente.nome ?? sugestoes[index].nome ?? "",
                              email:
                                  paciente.email ??
                                  sugestoes[index].email ??
                                  "",
                              cpf: paciente.cpf ?? sugestoes[index].cpf ?? "",
                              telefone:
                                  paciente.telefone ??
                                  sugestoes[index].telefone ??
                                  "",
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
                              isPesquisa = !isPesquisa;
                            });
                          },
                          child: Text(
                            'Registrar novo paciente',
                            style: context.cusotomFontes.textItalic.copyWith(
                              color: ColorsConstants.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
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
                              labelText: "Nome do paciente",
                              hintText: "Informe o nome do paciente",
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
                                isVoltar = !isVoltar;
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
                              labelText: "E-mail do paciente",
                              hintText: "Informe o e-mail do paciente",
                            ),
                            validator: Validatorless.multiple([
                              Validatorless.required("E-mail obrigatorio"),
                              Validatorless.email("Informe um e-mail valido"),
                            ]),
                            controller: emailController,
                            focusNode: emailFocus,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (value) {
                              cpfFocus.requestFocus();
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
                              labelText: "CPF do paciente",
                              hintText: "Informe o CPF do paciente",
                            ),
                            validator: Validatorless.multiple([
                              Validatorless.required("CPF obrigatorio"),
                            ]),
                            controller: cpfController,
                            focusNode: cpfFocus,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [cpfFormatter],
                            keyboardType: TextInputType.number,
                            onFieldSubmitted: (value) {
                              rgFocus.requestFocus();
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
                              labelText: "RG do paciente (Não obrigatorio)",
                              hintText: "Informe o RG do paciente",
                            ),

                            controller: rgController,
                            focusNode: rgFocus,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (value) {
                              enderecoFocus.requestFocus();
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
                              labelText: "Endereço do paciente",
                              hintText: "Informe o endereço do paciente",
                            ),
                            validator: Validatorless.multiple([
                              Validatorless.required("Endereço obrigatorio"),
                            ]),

                            controller: enderecoController,
                            focusNode: enderecoFocus,
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
                              labelText: "Telefone do paciente",
                              hintText: "Informe o telefone do paciente",
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
                              if (isVoltar) {
                                setState(() {
                                  isPesquisa = !isPesquisa;
                                });
                              } else {
                                await registrarPaciente();
                                setState(() {
                                  isPesquisa = !isPesquisa;
                                });
                                refresh();
                              }
                            },
                            child: Text(
                              isVoltar ? "Voltar" : 'Salvar dados',
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

  //! formata cpf enquanto o usaurio digita
  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  //! formata numero telefone
  final celularFormatter = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  //! registrar paciente
  Future<void> registrarPaciente() async {
    final valid = formKey.currentState?.validate() ?? false;
    if (valid) {
      PacienteModel model = PacienteModel(
        email: emailController.text,
        nome: nmController.text,
        cpf: cpfController.text,
        endereco: enderecoController.text,
        telefone: telefoneController.text,
      );
      await controller.registrarPaciente(model);
    }
  }

  void refresh() async {
    await controller.buscarPacientes(); // recarrega a lista do backend
    setState(() {}); // força a tela a rebuildar com os novos dados
  }

  //! buscar paciente por nome
  void buscarPacientePorNome(String value) {
    String nome = value;
    setState(() {
      sugestoes = controller.state.pacientes!
          .where((p) => p.nome!.toLowerCase().contains(nome.toLowerCase()))
          .toList();
    });
  }
}
