import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dente/core/router/rotas.dart';
import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/src/models/request/card_request.dart';
import 'package:dente/src/models/request/pix_request.dart';
import 'package:dente/src/models/response/card_response.dart';
import 'package:dente/src/models/response/card_status_response.dart';
import 'package:dente/src/models/response/pix_response.dart';
import 'package:dente/src/pages/plano/plano_controller.dart';
import 'package:dente/src/pages/plano/plano_state.dart';
import 'package:dente/src/pages/plano/widgets/card_payment_page.dart';
import 'package:dente/src/pages/plano/widgets/pix_paymento_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class PlanoPaymentPage extends StatefulWidget {
  final String? plano;
  final String? preco;
  const PlanoPaymentPage({super.key, this.plano, this.preco});

  @override
  State<PlanoPaymentPage> createState() => _PlanoPaymentPageState();
}

class _PlanoPaymentPageState
    extends BaseState<PlanoPaymentPage, PlanoController> {
  late String planoSelecionado;
  late String precoPlano;
  final metodoPagamentoController = TextEditingController();
  final periodoController = TextEditingController();

  String periodoSelecionado = "";
  String metodoPagamentoSelecionado = "";
  String valorPlano = "";
  String valorComDescontoPlano = "";
  String valorFinalPlano = "";

  bool isPix = false;
  bool isCard = false;

  PixResponse pixResponse = PixResponse();

  String iconeCartao = 'desconhecido';
  String publicKey = "";

  TextEditingController cartaoController = TextEditingController();
  TextEditingController validadeController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  FocusNode cartaoFocus = FocusNode();
  FocusNode validadeFocus = FocusNode();
  FocusNode cvvFocus = FocusNode();
  FocusNode nomeFocus = FocusNode();
  FocusNode cpfFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    planoSelecionado = widget.plano ?? "Desconhecido";
    precoPlano = widget.preco ?? "0";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calcularValorPlano(planoSelecionado, "Mensal");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Finalizar pagamento do plano')),
      body: BlocConsumer<PlanoController, PlanoState>(
        listener: (context, state) {
          state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            loaded: hideLoader,
            failure: () {
              showError(state.errorMessage ?? 'INTERNAL_ERROR');

              hideLoader();
            },
            success: () {
              hideLoader();
            },
          );
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsetsGeometry.all(30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 60,
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Plano selecionado',
                          labelStyle: TextStyle(
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

                          enabled: false,
                        ),
                        controller: TextEditingController(
                          text: planoSelecionado,
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
                    Container(
                      width: 300,
                      height: 60,
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Preço do plano',
                          labelStyle: TextStyle(
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

                          enabled: false,
                        ),
                        controller: TextEditingController(
                          text: "R\$ $precoPlano/mês",
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
                Container(
                  width: 600,
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
                              periodoController.text = opcao;
                            });
                            log('Período selecionado: $opcao');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio<String>(
                                value: (() {
                                  if (periodoController.text.isEmpty &&
                                      opcao == 'Mensal') {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          if (mounted) {
                                            setState(
                                              () => periodoController.text =
                                                  'Mensal',
                                            );
                                          }
                                        });
                                  }
                                  return opcao;
                                })(),
                                // ignore: deprecated_member_use
                                groupValue: periodoController.text.isEmpty
                                    ? null
                                    : periodoController.text,

                                // ignore: deprecated_member_use
                                onChanged: (valor) {
                                  setState(() {
                                    periodoController.text = valor ?? '';
                                  });
                                  log('Período selecionado: $valor');
                                  calcularValorPlano(
                                    planoSelecionado,
                                    valor ?? '',
                                  );
                                },

                                activeColor: ColorsConstants.appBarColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                opcao,
                                style: context.cusotomFontes.textRegular
                                    .copyWith(
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
                    width: 600,
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    child: DropdownButtonFormField2<String>(
                      // value: convenioController.text,
                      decoration: InputDecoration(
                        labelText: "Metodo de pagamento",
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
                      onChanged: (value) async {
                        setState(() {
                          metodoPagamentoController.text = value ?? '';
                          isPix = metodoPagamentoController.text == "PIX";
                          pixResponse = PixResponse();
                        });
                        if (isPix) {
                          setState(() {
                            isCard = false;
                          });
                          await gerarPix();
                        } else {
                          await buscaPublicKey();
                          setState(() {
                            isCard = true;
                          });
                        }
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
                          labelText: 'Desconto aplicado',
                          labelStyle: TextStyle(
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

                          enabled: false,
                        ),
                        controller: TextEditingController(
                          text: periodoSelecionado,
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
                    Container(
                      width: 200,
                      height: 60,
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Valor do plano',
                          labelStyle: TextStyle(
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
                          labelStyle: TextStyle(
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
                Padding(padding: const EdgeInsets.only(top: 20)),
                // Visibility(
                //   visible: isPix,
                //   child: SizedBox(
                //     width: 200,
                //     height: 60,
                //     child: ElevatedButton(
                //       onPressed: () async {
                //         await gerarPix();
                //         setState(() {
                //           isStatusPix = true;
                //         });
                //         verificarStatusPix();
                //       },
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             'Gerar PIX',
                //             style: context.cusotomFontes.textExtraBold.copyWith(
                //               color: ColorsConstants.primaryColor,
                //               fontSize: 20,
                //             ),
                //           ),
                //           const SizedBox(width: 15),
                //           Icon(
                //             Icons.qr_code,
                //             color: ColorsConstants.primaryColor,
                //             size: 20,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                Padding(padding: const EdgeInsets.only(top: 20)),
                Visibility(
                  visible: pixResponse.qrCodeBase64 != null,
                  child: PixPaymentoPage(
                    qrCodeBase64: pixResponse.qrCode ?? "",
                    copiaCola: pixResponse.qrCodeBase64 ?? "",
                  ),
                ),
                Visibility(
                  visible: isCard,
                  child: CardPaymentPage(
                    onChanged: (value) {
                      String bandeira = identificarBandeira(value);
                      setState(() {
                        iconeCartao =
                            bandeira; // usar para mostrar ícone Visa/Master
                      });
                    },
                    iconeCartao: iconeCartao,
                    cartaoController: cartaoController,
                    validadeController: validadeController,
                    cvvController: cvvController,
                    nomeController: nomeController,
                    cpfController: cpfController,
                    emailController: emailController,
                    cartaoFocus: cartaoFocus,
                    validadeFocus: validadeFocus,
                    cvvFocus: cvvFocus,
                    nomeFocus: nomeFocus,
                    cpfFocus: cpfFocus,
                    emailFocus: emailFocus,
                    onPagar: () async {
                      CardResponse response = await pagarCartao();
                      verificarStatusCard(response.id!);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<MetodoPagamento> tratamentoFechado = [
    MetodoPagamento(id: 1, nome: "PIX"),
    MetodoPagamento(id: 2, nome: "CARTÃO DE CRÉDITO"),
    MetodoPagamento(id: 3, nome: "CARTÃO DE DÉBITO"),
  ];

  Future<void> calcularValorPlano(String plano, String periodo) async {
    if (plano == "Basico") {
      if (periodo == "Mensal") {
        setState(() {
          periodoSelecionado = "0% off";
          valorPlano = "R\$ 85.00";
          valorComDescontoPlano = "R\$ 85.00";
        });
        return;
      } else if (periodo == "Semestral") {
        setState(() {
          periodoSelecionado = "10% off";
          valorPlano = "R\$ 510.00";
          valorComDescontoPlano = "R\$ 459.00";
        });
        return;
      } else {
        setState(() {
          periodoSelecionado = "20% off";
          valorPlano = "R\$ 1020.00";
          valorComDescontoPlano = "R\$ 816.00";
        });
        return;
      }
    }
    if (plano == "Pro") {
      if (periodo == "Mensal") {
        setState(() {
          periodoSelecionado = "0% off";
          valorPlano = "R\$ 99.90";
          valorComDescontoPlano = "R\$ 99.90";
        });
        return;
      } else if (periodo == "Semestral") {
        setState(() {
          periodoSelecionado = "10% off";
          valorPlano = "R\$ 599.40";
          valorComDescontoPlano = "R\$ 539.46";
        });
        return;
      } else {
        setState(() {
          periodoSelecionado = "20% off";
          valorPlano = "R\$ 1198.80";
          valorComDescontoPlano = "R\$ 959.04";
        });
        return;
      }
    }
    if (plano == "Premium") {
      if (periodo == "Mensal") {
        setState(() {
          periodoSelecionado = "0% off";
          valorPlano = "R\$ 129.90";
          valorComDescontoPlano = "R\$ 129.90";
        });
        return;
      } else if (periodo == "Semestral") {
        setState(() {
          periodoSelecionado = "10% off";
          valorPlano = "R\$ 779.40";
          valorComDescontoPlano = "R\$ 701.46";
        });
        return;
      } else {
        setState(() {
          periodoSelecionado = "20% off";
          valorPlano = "R\$ 1558.80";
          valorComDescontoPlano = "R\$ 1247.04";
        });
        return;
      }
    }
    return;
  }

  Future<void> gerarPix() async {
    final valorFormatado = formatarValor(valorComDescontoPlano);
    num valorFinal = num.tryParse(valorFormatado) ?? 0.0;
    PixRequest request = PixRequest(
      descricao: 'Pagamento do plano $planoSelecionado',
      // valor: valorFinal,
      valor: 10.0,
      email: "suportedente@gmail.com",
      name: "Jorge Bravo",
      cnpj: "80233616942",
    );
    final response = await controller.gerarPix(request);
    setState(() {
      pixResponse = response;
    });
  }

  String formatarValor(String valor) {
    return valor
        .replaceAll("R\$", "") // remove "R$"
        .replaceAll(" ", "") // remove espaços
        .replaceAll(",", "."); // troca vírgula por ponto
  }

  void verificarStatusPix() {
    Timer(const Duration(minutes: 5), () {
      final status = controller.verificarStatusPagamento(
        pixResponse.paymentId ?? 0,
      );
      // ignore: unrelated_type_equality_checks
      if (status == "approved") {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(Rotas.login, (_) => false);
        // ignore: unrelated_type_equality_checks
      } else if (status == "cancelled") {
        showError("O pagamento falhou.");
      } else {
        showError("Pagamento pendente.");
      }
    });
  }

  String identificarBandeira(String numeroCartao) {
    if (numeroCartao.isEmpty) return 'desconhecido';

    String bin = numeroCartao.replaceAll(' ', '').substring(0, 6);

    // Visa: começa com 4
    if (bin.startsWith('4')) return 'visa';

    // Mastercard: começa com 51-55 ou 2221-2720
    int binInt = int.tryParse(bin) ?? 0;
    if ((binInt >= 510000 && binInt <= 559999) ||
        (binInt >= 222100 && binInt <= 272099)) {
      return 'mastercard';
    }

    // American Express: começa com 34 ou 37
    if (bin.startsWith('34') || bin.startsWith('37')) return 'amex';

    // Outros casos
    return 'desconhecido';
  }

  //!!!!!!!!! pagamento com cartao !!!!!!!!!!!!!!!
  String limparNumeroCartao(String numero) {
    return numero.replaceAll(' ', '');
  }

  String converterMesValidade(String data) {
    // Remove barras
    final limpa = data.replaceAll('/', '');

    if (limpa.length != 4) return data; // segurança

    final mm = limpa.substring(0, 2);

    return mm;
  }

  String converterAnoValidade(String data) {
    // Remove barras
    final limpa = data.replaceAll('/', '');

    if (limpa.length != 4) return data; // segurança

    final aa = limpa.substring(2, 4);

    return '20$aa';
  }

  String limparCPF(String cpf) {
    return cpf.replaceAll('.', '').replaceAll('-', '');
  }

  Future<void> buscaPublicKey() async {
    String response = await controller.buscaPublicKey();
    if (response.isNotEmpty) {
      setState(() {
        publicKey = response;
      });
    }
  }

  Future<CardResponse> pagarCartao() async {
    final cardToken = await gerarToken();
    String name = nomeController.text;
    String cpf = limparCPF(cpfController.text);

    final valorFormatado = formatarValor(valorComDescontoPlano);
    num valorFinal = num.tryParse(valorFormatado) ?? 0.0;

    CardRequest request = CardRequest(
      amount: valorFinal,
      cardToken: cardToken,
      descricao: "Plano $planoSelecionado",
      parcelas: 1,
      paymentMethodId: iconeCartao == "mastercard" ? "master" : "visa",
      email: emailController.text,
      name: name,
      cpf: cpf,
    );
    CardResponse response = await controller.pagamentoCard(request);
    return response;
  }

  Future<String> gerarToken() async {
    final url = Uri.parse(
      'https://api.mercadopago.com/v1/card_tokens?public_key=$publicKey',
    );

    String mes = converterMesValidade(validadeController.text);
    String ano = converterAnoValidade(validadeController.text);
    String cardNumber = limparNumeroCartao(cartaoController.text);
    String securityCode = cvvController.text;
    String name = nomeController.text;
    String cpf = limparCPF(cpfController.text);
    int expirationMonth = int.tryParse(mes) ?? 0;
    int expirationYear = int.tryParse(ano) ?? 0;

    final body = {
      "card_number": cardNumber,
      "expiration_month": expirationMonth,
      "expiration_year": expirationYear,
      "security_code": securityCode,
      "cardholder": {
        "name": name,
        "identification": {"type": "CPF", "number": cpf},
      },
    };

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    debugPrint("STATUS: ${response.statusCode}");
    debugPrint("BODY: ${response.body}");
    final json = jsonDecode(response.body);

    // 🔥 Retorna só o id
    return json["id"] ?? "";
  }

  void verificarStatusCard(int paymentId) {
    Timer(const Duration(minutes: 5), () {
      final status = controller.statusCard(paymentId);
      // ignore: unrelated_type_equality_checks
      if (status == "approved") {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(Rotas.login, (_) => false);
        // ignore: unrelated_type_equality_checks
      } else if (status == "cancelled") {
        showError("O pagamento falhou.");
      } else {
        showError("Pagamento pendente.");
      }
    });
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









// approved
// cancelled