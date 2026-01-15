import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/base/base_state.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/widgets/formaters.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';
import 'package:servicespro/src/controllers/register_controller.dart';
import 'package:servicespro/src/models/categorias_model.dart';
import 'package:servicespro/src/models/usuario_model.dart';
import 'package:servicespro/src/providers/auth_provider.dart';
import 'package:servicespro/src/states/register_state.dart';
import 'package:servicespro/src/widgets/client_employee/custom_client_dados.dart';
import 'package:servicespro/src/widgets/client_employee/custom_employee_dados.dart';

class RegisterClientEmployeeScreen extends StatefulWidget {
  const RegisterClientEmployeeScreen({super.key});

  @override
  State<RegisterClientEmployeeScreen> createState() =>
      _RegisterClientEmployeeScreenState();
}

class _RegisterClientEmployeeScreenState
    extends BaseState<RegisterClientEmployeeScreen, RegisterController> {
  List<String> tiposRegistro = ['Cliente', 'Funcionário'];
  String? tipoUsuarioSelecionado = 'Cliente';
  final formKey = GlobalKey<FormState>();

  final dataController = TextEditingController();
  final cpfController = TextEditingController();
  final telefoneController = TextEditingController();
  final enderecoController = TextEditingController();

  final dataFocus = FocusNode();
  final cpfFocus = FocusNode();
  final telefoneFocus = FocusNode();
  final enderecoFocus = FocusNode();

  List<String> tiposPessoa = ['PF', 'PJ'];
  String? pessaoSelecionada;

  List<CategoriasModel> categorias = [];
  int categoriaSelecionada = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.buscarCategorias();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegisterController, RegisterState>(
        listener: (context, state) async {
          switch (state) {
            case RegisterLoading():
              showLoader();
              break;

            case RegisterLoaded():
              hideLoader();
              setState(() {
                categorias = state.categoriasModel;
              });
              break;

            case RegisterFailure(:final errorMessage):
              hideLoader();
              showError(
                errorMessage!.isNotEmpty
                    ? errorMessage
                    : 'Login ou senha inválidos',
              );
              break;

            case RegisterSuccess():
              hideLoader();
              await Provider.of<AuthProvider>(
                context,
                listen: false,
              ).salvarDadosUsuario();

              Navigator.of(
                // ignore: use_build_context_synchronously
                context,
              ).pushNamedAndRemoveUntil(Rotas.splash, (route) => false);

              break;

            case RegisterInitial():
              hideLoader();
              break;
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Radio(
                        value: tiposRegistro[0],
                        groupValue: tipoUsuarioSelecionado,
                        onChanged: (value) {
                          setState(() {
                            tipoUsuarioSelecionado = value;
                          });
                          limparCPFCNPJ();
                        },
                        activeColor: ColorsConstants.azulColor,
                      ),
                      Expanded(
                        child: Text(
                          'Cliente (Contratar serviços)',
                          style: context.cusotomFontes.regular.copyWith(
                            color: TemaSistema().temaSistema(context)
                                ? ColorsConstants.primaryColor
                                : ColorsConstants.letrasColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Radio(
                        value: tiposRegistro[1],
                        groupValue: tipoUsuarioSelecionado,
                        onChanged: (value) {
                          setState(() {
                            tipoUsuarioSelecionado = value;
                            categoriaSelecionada = 0;
                          });
                          limparCPFCNPJ();
                        },
                        activeColor: ColorsConstants.azulColor,
                      ),
                      Expanded(
                        child: Text(
                          'Funcionário (Prestar serviços)',
                          style: context.cusotomFontes.regular.copyWith(
                            color: TemaSistema().temaSistema(context)
                                ? ColorsConstants.primaryColor
                                : ColorsConstants.letrasColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: tipoUsuarioSelecionado == 'Cliente'
                          ? CustomClientDados(
                              dataController: dataController,
                              cpfController: cpfController,
                              telefoneController: telefoneController,
                              enderecoController: enderecoController,
                              cpfFocus: cpfFocus,
                              dataFocus: dataFocus,
                              enderecoFocus: enderecoFocus,
                              telefoneFocus: telefoneFocus,
                            )
                          : CustomEmployeeDados(
                              dataController: dataController,
                              cpfController: cpfController,
                              telefoneController: telefoneController,
                              pessoaSelecionada: pessaoSelecionada ?? '',
                              tiposPessoa: tiposPessoa,
                              enderecoController: enderecoController,
                              onChangedPF: (value) {
                                setState(() {
                                  pessaoSelecionada = value;
                                });
                                limparCPFCNPJ();
                              },
                              onChangedPJ: (value) {
                                setState(() {
                                  pessaoSelecionada = value;
                                });
                                limparCPFCNPJ();
                              },
                              categorias: categorias,
                              onChangedSleecionaCategoria: (value) {
                                setState(() {
                                  categorias
                                      .where(
                                        (categoria) =>
                                            categoria.nome == value.toString(),
                                      )
                                      .forEach((categoria) {
                                        categoriaSelecionada = categoria.id!;
                                      });
                                });
                              },
                              cpfFocus: cpfFocus,
                              dataFocus: dataFocus,
                              enderecoFocus: enderecoFocus,
                              telefoneFocus: telefoneFocus,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await registrarInfosUsuario();
                            }
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsConstants.secundaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Continuar',
                            style: context.cusotomFontes.bold.copyWith(
                              color: ColorsConstants.primaryColor,
                              fontSize: 16,
                            ),
                          ),
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

  Future<void> registrarInfosUsuario() async {
    if (tipoUsuarioSelecionado!.isEmpty) {
      showError("Selecione o tipo de usuário");
      return;
    }
    // if (tipoUsuarioSelecionado != "Cliente") {
    //   showInfo("Selecione o tipo de pessoa");
    //   return;
    // }

    if (cpfController.text.isEmpty && pessaoSelecionada == "PF") {
      showError("CPF obrigatorio");
      cpfFocus.requestFocus();
      return;
    }
    if (cpfController.text.isEmpty && pessaoSelecionada == "PJ") {
      showError("CNPJ obrigatorio");
      cpfFocus.requestFocus();
      return;
    }

    if (cpfController.text.isEmpty) {
      showError("CPF obrigatorio");
      cpfFocus.requestFocus();
      return;
    }

    if (dataController.text.isEmpty) {
      showError("Informe sua data de nacimento");
      dataFocus.requestFocus();
      return;
    }
    if (telefoneController.text.isEmpty) {
      showError("Informe seu número de telefone");
      telefoneFocus.requestFocus();
      return;
    }
    if (enderecoController.text.isEmpty) {
      showError("Informe seu endereço (Obrigatorio)");
      enderecoFocus.requestFocus();
      return;
    }

    String tipoUsuario = tipoUsuarioSelecionado == 'Cliente'
        ? "Cliente"
        : 'Prestador';
    String pessoaSelecionada = tipoUsuarioSelecionado == 'Cliente'
        ? "PF"
        : pessaoSelecionada!;
    String cpfcnpj = Formaters.formatarCPFCNPJ(cpfController.text);
    String dataNascimentoStr = Formaters.dataParaAPI(dataController.text);
    DateTime? dataNascimento = DateTime.tryParse(dataNascimentoStr);
    String telefone = Formaters.formatarTelefoneAPI(telefoneController.text);
    int idCategoriaSelecionada = tipoUsuarioSelecionado == 'Cliente'
        ? 0
        : categoriaSelecionada;
    String endereco = enderecoController.text;

    UsuarioModel usuarioModel = UsuarioModel(
      tipoUsuario: tipoUsuario,
      tipoPessoa: pessoaSelecionada,
      cpf_cnpj: cpfcnpj,
      dataNascimento: dataNascimento,
      telefone: telefone,
      endereco: endereco,
      categoriaPrestador: idCategoriaSelecionada,
    );
    // log(usuarioModel.toJson());
    await controller.registrarInfosUsuario(usuarioModel);
  }

  void limparCPFCNPJ() {
    cpfController.clear();
  }
}
