import 'dart:developer';

import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class PlanoPaymentPage extends StatefulWidget {
  final String? plano;
  final String? preco;
  const PlanoPaymentPage({super.key, this.plano, this.preco});

  @override
  State<PlanoPaymentPage> createState() => _PlanoPaymentPageState();
}

class _PlanoPaymentPageState extends State<PlanoPaymentPage> {
  late String planoSelecionado;
  late String precoPlano;
  final metodoPagamentoController = TextEditingController();

  String periodoSelecionado = "";
  String metodoPagamentoSelecionado = "";
  String valorPlano = "";
  String valorComDescontoPlano = "";
  String valorFinalPlano = "";
  @override
  void initState() {
    super.initState();
    planoSelecionado = widget.plano ?? "Desconhecido";
    precoPlano = widget.preco ?? "0";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calcularValorPlano(planoSelecionado, precoPlano);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Finalizar pagamento do plano')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 60,
                padding: const EdgeInsets.all(8),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Plano selecionado',
                    labelStyle: TextStyle(color: ColorsConstants.appBarColor),
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

                    enabled: false,
                  ),
                  controller: TextEditingController(text: planoSelecionado),
                  style: context.cusotomFontes.textRegular.copyWith(
                    fontSize: 16,
                    color: Color.lerp(
                      ColorsConstants.appBarColor,
                      Colors.black,
                      0.45,
                    ),
                  ),
                ),
              ),
              Container(
                width: 200,
                height: 60,
                padding: const EdgeInsets.all(8),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Preço do plano',
                    labelStyle: TextStyle(color: ColorsConstants.appBarColor),
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

                    enabled: false,
                  ),
                  controller: TextEditingController(text: "\$ $precoPlano/mês"),
                  style: context.cusotomFontes.textRegular.copyWith(
                    fontSize: 16,
                    color: Color.lerp(
                      ColorsConstants.appBarColor,
                      Colors.black,
                      0.45,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: 400,
            height: 60,
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['Mensal', 'Semestral', 'Anual'].map((opcao) {
                return Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    radius: 20,
                    onTap: () {
                      setState(() {
                        metodoPagamentoController.text = opcao;
                      });
                      log('Período selecionado: $opcao');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: (() {
                            if (metodoPagamentoController.text.isEmpty &&
                                opcao == 'Mensal') {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (mounted) {
                                  setState(
                                    () => metodoPagamentoController.text =
                                        'Mensal',
                                  );
                                }
                              });
                            }
                            return opcao;
                          })(),
                          // ignore: deprecated_member_use
                          groupValue: metodoPagamentoController.text.isEmpty
                              ? null
                              : metodoPagamentoController.text,

                          // ignore: deprecated_member_use
                          onChanged: (valor) {
                            setState(() {
                              metodoPagamentoController.text = valor ?? '';
                            });
                            log('Período selecionado: $valor');
                            calcularValorPlano(planoSelecionado, valor ?? '');
                          },

                          activeColor: ColorsConstants.appBarColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          opcao,
                          style: context.cusotomFontes.textRegular.copyWith(
                            fontSize: 16,
                            color: ColorsConstants.appBarColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 400,
              height: 60,
              padding: const EdgeInsets.all(8),
              child: DropdownButtonFormField2<String>(
                // value: convenioController.text,
                decoration: InputDecoration(
                  labelText: "Metodo de pagamento",
                  labelStyle: TextStyle(color: ColorsConstants.appBarColor),
                  hintStyle: TextStyle(color: ColorsConstants.appBarColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorsConstants.appBarColor),
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
                    metodoPagamentoController.text = value ?? '';
                  });
                  log('log: Método de pagamento selecionado: $value');
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 60,
                padding: const EdgeInsets.all(8),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Plano selecionado',
                    labelStyle: TextStyle(color: ColorsConstants.appBarColor),
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

                    enabled: false,
                  ),
                  controller: TextEditingController(text: periodoSelecionado),
                  style: context.cusotomFontes.textRegular.copyWith(
                    fontSize: 16,
                    color: Color.lerp(
                      ColorsConstants.appBarColor,
                      Colors.black,
                      0.45,
                    ),
                  ),
                ),
              ),
              Container(
                width: 200,
                height: 60,
                padding: const EdgeInsets.all(8),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Valor do plano',
                    labelStyle: TextStyle(color: ColorsConstants.appBarColor),
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

                    enabled: false,
                  ),
                  controller: TextEditingController(text: valorPlano),
                  style: context.cusotomFontes.textRegular.copyWith(
                    fontSize: 16,
                    color: Color.lerp(
                      ColorsConstants.appBarColor,
                      Colors.black,
                      0.45,
                    ),
                  ),
                ),
              ),
              Container(
                width: 200,
                height: 60,
                padding: const EdgeInsets.all(8),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Valor com desconto',
                    labelStyle: TextStyle(color: ColorsConstants.appBarColor),
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

                    enabled: false,
                  ),
                  controller: TextEditingController(
                    text: valorComDescontoPlano,
                  ),
                  style: context.cusotomFontes.textRegular.copyWith(
                    fontSize: 16,
                    color: Color.lerp(
                      ColorsConstants.appBarColor,
                      Colors.black,
                      0.45,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<MetodoPagamento> tratamentoFechado = [
    MetodoPagamento(id: 1, nome: "PIX"),
    MetodoPagamento(id: 2, nome: "CARTÃO DE CRÉDITO"),
    MetodoPagamento(id: 3, nome: "CARTÃO DE DÉBITO"),
  ];

  Future<void> calcularValorPlano(String plano, String periodo) async {
    if (plano == "Basíco") {
      if (periodo == "Mensal") {
        setState(() {
          periodoSelecionado = "Basico";
          valorFinalPlano = "R\$ 85.00";
          valorComDescontoPlano = "R\$ 85.00";
        });
        return;
      } else if (periodo == "Semestral") {
        setState(() {
          periodoSelecionado = "Semestral 10 off";
          valorPlano = "R\$ 510.00";
          valorComDescontoPlano = "R\$ 459.00";
        });
        return;
      } else {
        setState(() {
          periodoSelecionado = "Anual 20% off";
          valorPlano = "R\$ 1020.00";
          valorComDescontoPlano = "R\$ 816.00";
        });
        return;
      }
    }
    if (plano == "Pro") {
      if (periodo == "Mensal") {
        setState(() {
          periodoSelecionado = "Mensal";
          valorPlano = "R\$ 99.90";
          valorComDescontoPlano = "R\$ 99.90";
        });
        return;
      } else if (periodo == "Semestral") {
        setState(() {
          periodoSelecionado = "Semestral 10% off";
          valorPlano = "R\$ 599.40";
          valorComDescontoPlano = "R\$ 539.46";
        });
        return;
      } else {
        setState(() {
          periodoSelecionado = "Anual 20% off";
          valorPlano = "R\$ 1198.80";
          valorComDescontoPlano = "R\$ 959.04";
        });
        return;
      }
    }
    if (plano == "Premium") {
      if (periodo == "Mensal") {
        setState(() {
          periodoSelecionado = "Mensal";
          valorPlano = "R\$ 129.90";
          valorComDescontoPlano = "R\$ 129.90";
        });
        return;
      } else if (periodo == "Semestral") {
        setState(() {
          periodoSelecionado = "Semestral 10% off";
          valorPlano = "R\$ 779.40";
          valorComDescontoPlano = "R\$ 701.46";
        });
        return;
      } else {
        setState(() {
          periodoSelecionado = "Anual 20% off";
          valorPlano = "R\$ 1558.80";
          valorComDescontoPlano = "R\$ 1247.04";
        });
        return;
      }
    }
    return;
  }
}

class MetodoPagamento {
  int? id;
  String? nome;
  MetodoPagamento({this.id, this.nome});
}

class ValorPlano {
  String? plano;
  String? preco;
  String? precoDesconto;
  ValorPlano({this.plano, this.preco, this.precoDesconto});
}
