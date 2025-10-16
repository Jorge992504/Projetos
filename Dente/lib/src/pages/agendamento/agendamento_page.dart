import 'package:dente/core/router/rotas.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({super.key});

  @override
  State<AgendamentoPage> createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  final cpfController = TextEditingController();
  final nmDentistaController = TextEditingController();
  final dataController = TextEditingController();
  final horaController = TextEditingController();
  final servicoController = TextEditingController();
  final obsController = TextEditingController();
  DateTime dataAtual = DateTime.now();

  @override
  void initState() {
    super.initState();
    dataController.text = DateFormat('dd/MM/yyyy', 'pt_BR').format(dataAtual);
    horaController.text = DateFormat('HH:mm').format(dataAtual);
  }

  @override
  void dispose() {
    cpfController.dispose();
    nmDentistaController.dispose();
    dataController.dispose();
    horaController.dispose();
    servicoController.dispose();
    obsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Agendamento')),
      body: LayoutBuilder(
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
                      width: 400,
                      height: 60,
                      padding: EdgeInsets.all(8),
                      //Todo: vai ser um campo de busqueda por cpf
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "CPF do paciente",
                          hintText: "Informe o CPF para agendamento",
                          suffixIcon: IconButton(
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
                        cursorColor: ColorsConstants.appBarColor,
                        cursorHeight: 15,
                        cursorErrorColor: ColorsConstants.errorColor,
                        autofocus: true,
                        inputFormatters: [cpfFormatter],
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Container(
                      width: 400,
                      height: 60,
                      padding: EdgeInsets.all(8),
                      //Todo: vai ser um campo de busqueda por nome
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Nome do dentista",
                          hintText: "Informe o nome do dentista",
                        ),
                        cursorColor: ColorsConstants.appBarColor,
                        cursorHeight: 15,
                        cursorErrorColor: ColorsConstants.errorColor,
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
                          labelText: "Serviço",
                          hintText: "Serviço que vai receber o paciente",
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              size: 25,
                              color: ColorsConstants.appBarColor,
                            ),
                          ),
                        ),
                        cursorColor: ColorsConstants.appBarColor,
                        cursorHeight: 15,
                        cursorErrorColor: ColorsConstants.errorColor,
                      ),
                    ),
                    Container(
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
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  alignment: Alignment.center,
                  width: 900,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).pushNamed(Rotas.agendamento);
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
}
