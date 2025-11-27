// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dente/src/models/request/registrar_pagamento_request.dart';
import 'package:dente/src/models/response/agendamento_paciente_response.dart';
import 'package:dente/src/models/response/buscar_convenios_pagamento_response.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/src/pages/payment/payment_controller.dart';
import 'package:dente/src/pages/payment/payment_state.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends BaseState<PaymentPage, PaymentController> {
  List<BuscarConveniosPagamentoResponse> convenios = [];

  List<TipoPagamento> typePayment = [
    TipoPagamento(id: 1, typePayment: "Cartão de Credito"),
    TipoPagamento(id: 2, typePayment: "Cartão de Debito"),
    TipoPagamento(id: 3, typePayment: "PIX"),
    TipoPagamento(id: 4, typePayment: "Boleto"),
  ];

  List<StatusPayment> statusPayment = [
    StatusPayment(id: 1, nome: 'Pendente'),
    StatusPayment(id: 2, nome: 'Realizado'),
    StatusPayment(id: 3, nome: 'Cancelado'),
  ];

  List<TratamentoFechado> tratamentoFechado = [
    TratamentoFechado(id: 1, nome: "Sim"),
    TratamentoFechado(id: 2, nome: "Não"),
  ];

  final pacienteController = TextEditingController();
  final servicoController = TextEditingController();
  final obsController = TextEditingController();
  final percentualDentistaController = TextEditingController();
  final dentistaBoolController = TextEditingController();
  final empresaParceiraController = TextEditingController();
  final convenioController = TextEditingController();
  final valorAtualController = TextEditingController();
  final descontoController = TextEditingController();
  final valorCobrarController = TextEditingController();
  final valorRecebidoController = TextEditingController();
  final tipoPagamentpController = TextEditingController();
  final statusPagamentoController = TextEditingController();

  final valorAtualFocus = FocusNode();
  final descontoFocus = FocusNode();
  final valorCobrarFocus = FocusNode();
  final valorRecebidoFocus = FocusNode();
  final percentualDentistaFocuso = FocusNode();

  int idConvenio = 0;
  AgendamentoPacienteResponse agendamentoDetalhe =
      AgendamentoPacienteResponse();

  bool isCobrar = false;
  bool isTratamento = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final route = ModalRoute.of(context);
      final arguments =
          (route!.settings.arguments ?? <String, dynamic>{}) as Map;
      setState(() {
        agendamentoDetalhe = arguments['agendamentoDetalhe'];
        pacienteController.text = agendamentoDetalhe.pacienteNome ?? "";
        servicoController.text = agendamentoDetalhe.servico ?? "";
        obsController.text = agendamentoDetalhe.observacoes ?? "";
        valorAtualController.text = agendamentoDetalhe.vl.toString();
      });
      await controller.buscaDentistasServicos();
    });
  }

  @override
  void dispose() {
    pacienteController.dispose();
    servicoController.dispose();
    obsController.dispose();
    percentualDentistaController.dispose();
    dentistaBoolController.dispose();
    empresaParceiraController.dispose();
    convenioController.dispose();
    valorAtualController.dispose();
    descontoController.dispose();
    valorCobrarController.dispose();
    valorRecebidoController.dispose();
    tipoPagamentpController.dispose();
    statusPagamentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Finalizar pagamento')),
      body: BlocConsumer<PaymentController, PaymentState>(
        listener: (context, state) {
          state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            loaded: hideLoader,
            failure: () {
              hideLoader();
              showError(state.errorMessage ?? 'INTERNAL_ERROR');
            },
            success: () {
              hideLoader();
            },
          );
        },
        builder: (context, state) {
          convenios = state.conveniosPagamento ?? [];
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 60,
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: ColorsConstants.appBarColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),

                          counterText: "",
                          labelText: 'Paciente',
                        ),
                        cursorColor: ColorsConstants.appBarColor,
                        cursorWidth: 2,
                        cursorHeight: 15,
                        cursorRadius: Radius.circular(8),
                        enabled: false,
                        controller: pacienteController,
                        // controller: ,
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 60,
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: ColorsConstants.appBarColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),

                          counterText: "",
                          labelText: 'Serviço',
                        ),
                        cursorColor: ColorsConstants.appBarColor,
                        cursorWidth: 2,
                        cursorHeight: 15,
                        cursorRadius: Radius.circular(8),
                        controller: servicoController,
                        enabled: false,
                        // controller: ,
                      ),
                    ),
                    Container(
                      width: 400,
                      height: 60,
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: ColorsConstants.appBarColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),

                          counterText: "",
                          labelText: 'Observações',
                        ),
                        cursorColor: ColorsConstants.appBarColor,
                        cursorWidth: 2,
                        cursorHeight: 15,
                        cursorRadius: Radius.circular(8),
                        controller: obsController,
                        enabled: false,
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
                      padding: const EdgeInsets.all(8),
                      child: DropdownButtonFormField2<String>(
                        // value: convenioController.text,
                        decoration: InputDecoration(
                          labelText: "Tratamento fechado pelo dentista",
                          // hintText: "Paciente de convenio?",
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
                        items: tratamentoFechado.map((c) {
                          return DropdownMenuItem<String>(
                            value: c.nome,
                            child: Text(
                              c.nome ?? "",
                              style: context.cusotomFontes.textRegular.copyWith(
                                fontSize: 16,
                                color: ColorsConstants.appBarColor,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dentistaBoolController.text = value ?? '';
                            isTratamento = !isTratamento;
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: isTratamento,
                      child: Container(
                        width: 250,
                        height: 60,
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 5,
                                color: ColorsConstants.appBarColor,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),

                            counterText: "",
                            labelText: '% do dentista',
                          ),
                          cursorColor: ColorsConstants.appBarColor,
                          cursorWidth: 2,
                          cursorHeight: 15,
                          cursorRadius: Radius.circular(8),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          controller: percentualDentistaController,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 250,
                      height: 60,
                      padding: const EdgeInsets.all(8),
                      child: DropdownButtonFormField2<String>(
                        // value: convenioController.text,
                        decoration: InputDecoration(
                          labelText: "Empresa parceira",
                          // hintText: "Paciente de convenio?",
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
                        items: convenios.map((convenio) {
                          convenio.id;
                          return DropdownMenuItem<String>(
                            value: convenio.parceiro ?? "",
                            child: Text(
                              convenio.parceiro ?? "",
                              style: context.cusotomFontes.textRegular.copyWith(
                                fontSize: 16,
                                color: ColorsConstants.appBarColor,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            empresaParceiraController.text = value ?? '';

                            // AQUI está o segredo
                            final c = convenios.firstWhere(
                              (item) => item.parceiro == value,
                            );

                            idConvenio = c.id ?? 0;
                          });
                          log("ID selecionado: $idConvenio");
                        },
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 60,
                      padding: const EdgeInsets.all(8),
                      child: DropdownButtonFormField2<String>(
                        // value: convenioController.text.isEmpty,
                        decoration: InputDecoration(
                          labelText: "Tipo de pagamento",
                          // hintText: "Paciente de convenio?",
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
                        items: typePayment.map((payment) {
                          payment.id;
                          return DropdownMenuItem<String>(
                            value: payment.typePayment ?? "",
                            child: Text(
                              payment.typePayment ?? "",
                              style: context.cusotomFontes.textRegular.copyWith(
                                fontSize: 16,
                                color: ColorsConstants.appBarColor,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            tipoPagamentpController.text = value ?? '';
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 60,
                      padding: const EdgeInsets.all(8),
                      child: DropdownButtonFormField2<String>(
                        // value: convenioController.text.isEmpty,
                        decoration: InputDecoration(
                          labelText: "Status do pagamento",
                          // hintText: "Paciente de convenio?",
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
                        items: statusPayment.map((status) {
                          status.nome;
                          return DropdownMenuItem<String>(
                            value: status.nome ?? "",
                            child: Text(
                              status.nome ?? "",
                              style: context.cusotomFontes.textRegular.copyWith(
                                fontSize: 16,
                                color: ColorsConstants.appBarColor,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            statusPagamentoController.text = value ?? '';
                          });
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 250,
                      height: 60,
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: ColorsConstants.appBarColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'Preço atual',
                          enabled: false,
                        ),
                        controller: valorAtualController,
                        // controller: ,
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 60,
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: ColorsConstants.appBarColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),

                          counterText: "",
                          labelText: '% descontado',
                        ),
                        cursorColor: ColorsConstants.appBarColor,
                        cursorWidth: 2,
                        cursorHeight: 15,
                        cursorRadius: Radius.circular(8),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        controller: descontoController,
                        focusNode: descontoFocus,
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            aplicarDesconto();
                            valorRecebidoFocus.requestFocus();
                          } else {
                            num valorAtual =
                                num.tryParse(
                                  valorAtualController.text.replaceAll(
                                    ',',
                                    '.',
                                  ),
                                ) ??
                                0.0;

                            setState(() {
                              valorCobrarController.text = valorAtual
                                  .toStringAsFixed(2);
                              valorRecebidoController.text = valorAtual
                                  .toStringAsFixed(2);
                            });
                            valorRecebidoFocus.requestFocus();
                            setState(() {
                              isCobrar = true;
                            });
                          }
                        },
                        // controller: ,
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 60,
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: ColorsConstants.appBarColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),

                          counterText: "",
                          labelText: 'Valor ser cobrado',
                        ),
                        cursorColor: ColorsConstants.appBarColor,
                        cursorWidth: 2,
                        cursorHeight: 15,
                        cursorRadius: Radius.circular(8),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        controller: valorCobrarController,
                        enabled: isCobrar,
                        onSubmitted: (value) {
                          valorRecebidoFocus.requestFocus();
                        },
                        // controller: ,
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 60,
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: ColorsConstants.appBarColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),

                          counterText: "",
                          labelText: 'Valor recebido',
                        ),
                        cursorColor: ColorsConstants.appBarColor,
                        cursorWidth: 2,
                        cursorHeight: 15,
                        cursorRadius: Radius.circular(8),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        controller: valorRecebidoController,
                        focusNode: valorRecebidoFocus,
                        // controller: ,
                      ),
                    ),
                  ],
                ),

                Container(
                  width: 250,
                  height: 60,
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      terminarPagamento();
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      'Finalizar pagamento',
                      style: context.cusotomFontes.textBold.copyWith(
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

  void aplicarDesconto() {
    num valorAtual =
        num.tryParse(valorAtualController.text.replaceAll(',', '.')) ?? 0.0;
    num desconto =
        num.tryParse(descontoController.text.replaceAll(',', '.')) ?? 0.0;
    final valorComDesconto = valorAtual - (valorAtual * (desconto / 100));
    setState(() {
      valorCobrarController.text = valorComDesconto.toStringAsFixed(2);
      valorRecebidoController.text = valorComDesconto.toStringAsFixed(2);
    });
  }

  void terminarPagamento() async {
    RegistrarPagamentoRequest request = RegistrarPagamentoRequest(
      agendamentoId: agendamentoDetalhe.agendamentoId,
      convenioId: idConvenio,
      valorDesconto: num.tryParse(descontoController.text.replaceAll(',', '.')),
      percentoDentista: num.tryParse(
        percentualDentistaController.text.replaceAll(',', '.'),
      ),
      status: statusPagamentoController.text,
      tipoPagamento: tipoPagamentpController.text,
      valorCobrado: num.tryParse(
        valorCobrarController.text.replaceAll(',', '.'),
      ),
      valorLiquido: num.tryParse(
        valorRecebidoController.text.replaceAll(',', '.'),
      ),
      tratamentoFechado: convenioController.text == 'Sim' ? true : false,
      valorAtual: agendamentoDetalhe.vl,
    );
    await controller.terminarPagamento(request);
  }
}

class Convenio {
  String? nome;
  int? id;
  Convenio({this.nome, this.id});
}

class TipoPagamento {
  int? id;
  String? typePayment;
  TipoPagamento({this.id, this.typePayment});
}

class StatusPayment {
  int? id;
  String? nome;
  StatusPayment({this.id, this.nome});
}

class TratamentoFechado {
  int? id;
  String? nome;
  TratamentoFechado({this.id, this.nome});
}
