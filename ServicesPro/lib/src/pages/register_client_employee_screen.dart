import 'package:flutter/material.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';
import 'package:servicespro/src/widgets/client_employee/custom_client_dados.dart';
import 'package:servicespro/src/widgets/client_employee/custom_employee_dados.dart';

class RegisterClientEmployeeScreen extends StatefulWidget {
  const RegisterClientEmployeeScreen({super.key});

  @override
  State<RegisterClientEmployeeScreen> createState() =>
      _RegisterClientEmployeeScreenState();
}

class _RegisterClientEmployeeScreenState
    extends State<RegisterClientEmployeeScreen> {
  List<String> tiposRegistro = ['Cliente', 'Funcionário'];
  String? tipoSelecionado = 'Cliente';
  final formKey = GlobalKey<FormState>();

  final dataController = TextEditingController();
  final cpfController = TextEditingController();
  final telefoneController = TextEditingController();

  List<String> tiposPessoa = ['PF', 'PJ'];
  String? pessaoSelecionada;

  List<CategoriasClientEmployee> categorias = [
    CategoriasClientEmployee(id: 1, nome: "Serviços Domésticos"),
    CategoriasClientEmployee(id: 2, nome: "Reparos e Manutenção"),
    CategoriasClientEmployee(id: 3, nome: "Mudança, Transporte e Entregas"),
    CategoriasClientEmployee(id: 4, nome: "Beleza e Estética"),
    CategoriasClientEmployee(id: 5, nome: "Tecnologia"),
    CategoriasClientEmployee(id: 6, nome: "Área Pet"),
    CategoriasClientEmployee(id: 7, nome: "Fitness e Bem-estar"),
    CategoriasClientEmployee(
      id: 8,
      nome: "Consultoria e Profissionais Especializados",
    ),
    CategoriasClientEmployee(id: 9, nome: "Eventos"),
    CategoriasClientEmployee(id: 10, nome: "Automotivo"),
    CategoriasClientEmployee(id: 11, nome: "Reforma e Construção"),
    CategoriasClientEmployee(id: 12, nome: "Segurança"),
    CategoriasClientEmployee(id: 13, nome: "Serviços Administrativos"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  Radio(
                    value: tiposRegistro[0],
                    groupValue: tipoSelecionado,
                    onChanged: (value) {
                      setState(() {
                        tipoSelecionado = value;
                      });
                      //! limpar o campo de texto quando mudar para cliente
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
                    groupValue: tipoSelecionado,
                    onChanged: (value) {
                      setState(() {
                        tipoSelecionado = value;
                      });
                      //! limpar o campo de texto quando mudar para funcionário
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
                  child: tipoSelecionado == 'Cliente'
                      ? CustomClientDados(
                          dataController: dataController,
                          cpfController: cpfController,
                          telefoneController: telefoneController,
                        )
                      : CustomEmployeeDados(
                          dataController: dataController,
                          cpfController: cpfController,
                          telefoneController: telefoneController,
                          pessoaSelecionada: pessaoSelecionada ?? '',
                          tiposPessoa: tiposPessoa,
                          onChangedPF: (value) {
                            setState(() {
                              pessaoSelecionada = value;
                            });
                            //! limpar o campo de texto quando mudar para PF
                          },
                          onChangedPJ: (value) {
                            setState(() {
                              pessaoSelecionada = value;
                            });
                            //! limpar o campo de texto quando mudar para PJ
                          },
                          categorias: categorias,
                          onChangedSleecionaCategoria: (value) {
                            setState(() {
                              // nmDentistaController.text = value ?? '';
                              // dentistasDisponiveis
                              //     .where((dentista) => dentista.nome == value.toString())
                              //     .forEach((dentista) {
                              //       idDentista = dentista.id!;
                              //     });
                            });
                          },
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
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          Rotas.splash,
                          (route) => false,
                        );
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
      ),
    );
  }
}

class CategoriasClientEmployee {
  int? id;
  String? nome;
  CategoriasClientEmployee({this.id, this.nome});
}
