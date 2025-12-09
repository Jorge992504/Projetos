import 'dart:developer';

import 'package:dente/core/router/rotas.dart';
import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/core/ui/style/size_extension.dart';
import 'package:dente/src/models/paciente_model.dart';
import 'package:dente/src/models/request/novo_agendamento_model_request.dart';
import 'package:dente/src/models/response/busca_servicos_dentistas_agendamento_response.dart';
import 'package:dente/src/pages/agendamento/agendamento_controller.dart';
import 'package:dente/src/pages/agendamento/agendamento_state.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({super.key});

  @override
  State<AgendamentoPage> createState() => _AgendamentoPageState();
}

class _AgendamentoPageState
    extends BaseState<AgendamentoPage, AgendamentoController> {
  final cpfController = TextEditingController();
  final nmDentistaController = TextEditingController();
  final dataController = TextEditingController();
  final horaController = TextEditingController();
  final servicoController = TextEditingController();
  final obsController = TextEditingController();

  final cpfFocus = FocusNode();
  final nmDentistaFocus = FocusNode();
  final dataFocus = FocusNode();
  final horaFocus = FocusNode();
  final servicoFocus = FocusNode();
  final obsFocus = FocusNode();

  DateTime dataAtual = DateTime.now();

  int idDentista = 0;
  int idServico = 0;

  String data = '';
  String plano = '';

  List<BuscaServicosAgendamentoResponse> servicosDisponiveis = [];
  List<BuscaDentistasAgendamentoResponse> dentistasDisponiveis = [];

  PacienteModel pacienteModel = PacienteModel();
  final nomeController = TextEditingController();
  final emailController = TextEditingController();

  final nomeFocus = FocusNode();
  final emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    horaController.text = DateFormat('HH:mm').format(dataAtual);

    // Inicializa dataController aqui, não no build
    dataController.text = DateFormat('dd/MM/yyyy', 'pt_BR').format(dataAtual);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.buscaDentistasServicos();
      final route = ModalRoute.of(context);
      final arguments =
          (route!.settings.arguments ?? <String, dynamic>{}) as Map;
      setState(() {
        plano = arguments['plano'];
        data = arguments['data'];
        if (data.isNotEmpty) {
          dataController.text = data;
        }
      });
    });
  }

  @override
  void dispose() {
    cpfController.dispose();
    nmDentistaController.dispose();
    dataController.dispose();
    horaController.dispose();
    servicoController.dispose();
    obsController.dispose();
    nomeController.dispose();
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Agendamento')),
      body: BlocConsumer<AgendamentoController, AgendamentoState>(
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
              showSuccess("Agendamento relaizado!");
            },
          );
        },
        builder: (context, state) {
          dentistasDisponiveis = state.dentistasServicos?.dentistas ?? [];
          servicosDisponiveis = state.dentistasServicos?.servicos ?? [];
          return LayoutBuilder(
            builder: (context, tamanho) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: plano == "Basico" ? 800 : 400,
                          height: 60,
                          padding: EdgeInsets.all(8),
                          //Todo: vai ser um campo de busqueda por cpf
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "CPF ou nome do paciente",
                              hintText:
                                  "Informe o CPF ou o nome para agendamento",

                              suffixIcon: Visibility(
                                visible: plano != "Basico",
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      Rotas.registrarPaciente,
                                      arguments: {"cpf": cpfController.text},
                                    );
                                  },
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    size: 25,
                                    color: ColorsConstants.appBarColor,
                                  ),
                                ),
                              ),
                            ),
                            cursorColor: ColorsConstants.appBarColor,
                            cursorHeight: 15,
                            cursorErrorColor: ColorsConstants.errorColor,
                            autofocus: true,
                            // inputFormatters: [cpfFormatter],
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: cpfController,
                            focusNode: cpfFocus,
                            onSubmitted: (value) async {
                              log("entrou");

                              //!chama função q buscar os dados do paciente
                              final response = await controller
                                  .filtraDadosPaciente(value);
                              setState(() {
                                pacienteModel = response ?? PacienteModel();
                              });
                              if (pacienteModel.nome!.isEmpty) {
                                nomeController.text = cpfController.text;
                              } else {
                                nomeController.text = pacienteModel.nome ?? "";
                                cpfController.text = pacienteModel.cpf ?? "";
                              }
                              if (pacienteModel.email!.isEmpty) {
                                emailFocus.requestFocus();
                              } else {
                                emailController.text =
                                    pacienteModel.email ?? "";
                                dataFocus.requestFocus();
                              }
                            },
                            onChanged: (value) {
                              // Se contém letras -> não aplica máscara
                              if (RegExp(r'[A-Za-z]').hasMatch(value)) {
                                // remove máscara
                                setState(() {
                                  cpfController.value = cpfController.value
                                      .copyWith(
                                        text: value,
                                        selection: TextSelection.collapsed(
                                          offset: value.length,
                                        ),
                                      );
                                });
                              } else {
                                // Somente números → aplica máscara CPF
                                final masked = cpfFormatter.maskText(value);
                                setState(() {
                                  cpfController.value = cpfController.value
                                      .copyWith(
                                        text: masked,
                                        selection: TextSelection.collapsed(
                                          offset: masked.length,
                                        ),
                                      );
                                });
                              }
                            },
                          ),
                        ),
                        Visibility(
                          visible: plano != "Basico",
                          child: Container(
                            width: 400,
                            height: 60,
                            padding: const EdgeInsets.all(8),
                            child: DropdownButtonFormField2<String>(
                              focusNode: nmDentistaFocus,
                              value: nmDentistaController.text.isEmpty
                                  ? null
                                  : nmDentistaController.text,
                              decoration: InputDecoration(
                                labelText: "Nome do dentista",
                                hintText: "Informe o nome do dentista",
                                labelStyle: TextStyle(
                                  color: ColorsConstants.appBarColor,
                                ),
                                hintStyle: TextStyle(
                                  color: ColorsConstants.appBarColor,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorsConstants.appBarColor,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorsConstants.appBarColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 12,
                                ),
                              ),
                              isExpanded: true,
                              iconStyleData: IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                  color: ColorsConstants.appBarColor,
                                ),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                direction: DropdownDirection
                                    .textDirection, // 👈 força abrir para baixo
                                maxHeight: 300,
                                offset: const Offset(
                                  0,
                                  8,
                                ), // pequeno espaçamento abaixo do campo
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ColorsConstants.primaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorsConstants.appBarColor,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                              items: dentistasDisponiveis.map((dentista) {
                                dentista.id;
                                return DropdownMenuItem<String>(
                                  value: dentista.nome,
                                  child: Text(
                                    dentista.nome ?? '',
                                    style: context.cusotomFontes.textRegular
                                        .copyWith(
                                          fontSize: 16,
                                          color: ColorsConstants.appBarColor,
                                        ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  nmDentistaController.text = value ?? '';
                                  dentistasDisponiveis
                                      .where(
                                        (dentista) =>
                                            dentista.nome == value.toString(),
                                      )
                                      .forEach((dentista) {
                                        idDentista = dentista.id!;
                                      });
                                });
                                FocusScope.of(context).requestFocus(dataFocus);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 400,
                          height: 60,
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            decoration: InputDecoration(labelText: "Nome"),
                            cursorColor: ColorsConstants.appBarColor,
                            cursorHeight: 15,
                            controller: nomeController,
                            focusNode: nomeFocus,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        Container(
                          width: 400,
                          height: 60,
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "E-mail",
                              hintText: "Informe o email para confirmação",
                            ),
                            cursorColor: ColorsConstants.appBarColor,
                            cursorHeight: 15,
                            controller: emailController,
                            focusNode: emailFocus,
                            textInputAction: TextInputAction.next,
                            enabled: pacienteModel.email != null,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 400,
                          height: 60,
                          padding: EdgeInsets.all(8),

                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Data",
                              hintText: "Escolha a data do atendimento",
                              suffixIcon: IconButton(
                                onPressed: () => selecionarData(context),
                                icon: Icon(
                                  Icons.calendar_month,
                                  size: 25,
                                  color: ColorsConstants.appBarColor,
                                ),
                              ),
                            ),
                            cursorColor: ColorsConstants.appBarColor,
                            cursorHeight: 15,
                            cursorErrorColor: ColorsConstants.errorColor,
                            controller: dataController,
                            onChanged: formatarDataDigitada,
                            focusNode: dataFocus,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (value) {
                              horaFocus.requestFocus();
                            },
                          ),
                        ),
                        Container(
                          width: 400,
                          height: 60,
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Hora",
                              hintText: "Informe a hora do atendimento",
                              suffixIcon: IconButton(
                                onPressed: () => selecionarHora(context),
                                icon: Icon(
                                  Icons.timer_outlined,
                                  size: 25,
                                  color: ColorsConstants.appBarColor,
                                ),
                              ),
                            ),
                            cursorColor: ColorsConstants.appBarColor,
                            cursorHeight: 15,
                            cursorErrorColor: ColorsConstants.errorColor,
                            controller: horaController,
                            onChanged: formatarHoraDigitada,
                            focusNode: horaFocus,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (value) {
                              servicoFocus.requestFocus();
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: plano != "Basico",
                          child: Container(
                            width: 400,
                            height: 60,
                            padding: const EdgeInsets.all(8),
                            child: DropdownButtonFormField2<String>(
                              focusNode: servicoFocus,

                              value: servicoController.text.isEmpty
                                  ? null
                                  : servicoController.text,
                              decoration: InputDecoration(
                                labelText: "Serviço",
                                hintText: "Informe o serviço desejado",
                                labelStyle: TextStyle(
                                  color: ColorsConstants.appBarColor,
                                ),
                                hintStyle: TextStyle(
                                  color: ColorsConstants.appBarColor,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorsConstants.appBarColor,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorsConstants.appBarColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 12,
                                ),
                              ),
                              isExpanded: true,
                              iconStyleData: IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                  color: ColorsConstants.appBarColor,
                                ),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                direction: DropdownDirection
                                    .textDirection, // 👈 força abrir para baixo
                                maxHeight: 300,
                                offset: const Offset(
                                  0,
                                  8,
                                ), // pequeno espaçamento abaixo do campo
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ColorsConstants.primaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorsConstants.appBarColor,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                              items: servicosDisponiveis.map((servico) {
                                return DropdownMenuItem<String>(
                                  value: servico.nome,
                                  child: Text(
                                    servico.nome ?? '',
                                    style: context.cusotomFontes.textRegular
                                        .copyWith(
                                          fontSize: 16,
                                          color: ColorsConstants.appBarColor,
                                        ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  servicoController.text = value ?? '';
                                  servicosDisponiveis
                                      .where(
                                        (servico) =>
                                            servico.nome == value.toString(),
                                      )
                                      .forEach((servico) {
                                        idServico = servico.id!;
                                      });
                                });
                                FocusScope.of(context).requestFocus(obsFocus);
                              },
                            ),
                          ),
                        ),
                        Visibility(
                          visible: plano != "Basico",
                          child: Container(
                            width: 400,
                            height: 60,
                            padding: EdgeInsets.all(8),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Observações",
                                hintText: "Observações sobre o paciente",
                              ),
                              cursorColor: ColorsConstants.appBarColor,
                              cursorHeight: 15,
                              cursorErrorColor: ColorsConstants.errorColor,
                              controller: obsController,
                              focusNode: obsFocus,
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 20),
                      width: context.percentWidth(1),
                      child: ElevatedButton(
                        onPressed: () {
                          criarAgendamento();
                        },
                        child: Text(
                          'Marcar agendamento',
                          style: context.cusotomFontes.textItalic.copyWith(
                            color: ColorsConstants.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  //! formata a data conforme o usuario digita
  void formatarDataDigitada(String value) {
    String digitos = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitos.length > 8) digitos = digitos.substring(0, 8);
    String formatada = '';
    for (int i = 0; i < digitos.length; i++) {
      formatada += digitos[i];
      if (i == 1 || i == 3) formatada += '/';
    }
    dataController.value = TextEditingValue(
      text: formatada,
      selection: TextSelection.collapsed(offset: formatada.length),
    );
  }

  //* formata a hora conforme o usuario digita
  void formatarHoraDigitada(String value) {
    String digitos = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitos.length > 4) digitos = digitos.substring(0, 4);
    String formatada = '';
    for (int i = 0; i < digitos.length; i++) {
      formatada += digitos[i];
      if (i == 1) formatada += ':';
    }
    horaController.value = TextEditingValue(
      text: formatada,
      selection: TextSelection.collapsed(offset: formatada.length),
    );
  }

  //! mostra o calnedario ao clicar no botao data
  Future<void> selecionarData(BuildContext context) async {
    final DateTime? dataSelecionada = await showDatePicker(
      context: context,
      locale: const Locale('pt', 'BR'),
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary:
                  ColorsConstants.appBarColor, // cor principal do calendário
              onPrimary: ColorsConstants.primaryColor,
              onSurface: ColorsConstants.appBarColor,
              surface: ColorsConstants.primaryColor,
            ),
          ),

          child: child!,
        );
      },
    );

    if (dataSelecionada != null) {
      setState(() {
        dataController.text = DateFormat(
          'dd/MM/yyyy',
          'pt_BR',
        ).format(dataSelecionada);
      });
    }
  }

  //! mostra o seletor de hora ao clicar no botao hora
  Future<void> selecionarHora(BuildContext context) async {
    final TimeOfDay? horaSelecionada = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorsConstants.appBarColor,
              onPrimary: ColorsConstants.primaryColor,
              onSurface: ColorsConstants.appBarColor,
              surface: ColorsConstants.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (horaSelecionada != null) {
      final agora = DateTime.now();
      final dataCompleta = DateTime(
        agora.year,
        agora.month,
        agora.day,
        horaSelecionada.hour,
        horaSelecionada.minute,
      );
      setState(() {
        horaController.text = DateFormat('HH:mm').format(dataCompleta);
      });
    }
  }

  //! formata cpf enquanto o usaurio digita
  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  //! cria novo agendamento
  Future<void> criarAgendamento() async {
    NovoAgendamentoModelRequest body = NovoAgendamentoModelRequest(
      dataHora: '${dataController.text} - ${horaController.text}',
      cpfPaciente: cpfController.text,
      dentistaId: idDentista,
      servicoId: idServico,
      observacoes: obsController.text,
      email: emailController.text,
      nomePaciente: nomeController.text,
    );
    await controller.criaNovoAgendamento(body);
  }
}
