import 'dart:convert';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/custom_images.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/src/pages/plano/plano_controller.dart';
import 'package:dente/src/pages/plano/plano_payment_page.dart';
import 'package:dente/src/pages/plano/widgets/plano_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PlanoPage extends StatefulWidget {
  const PlanoPage({super.key});

  @override
  State<PlanoPage> createState() => _PlanoPageState();
}

class _PlanoPageState extends State<PlanoPage> {
  String respostaTexto =
      ""; // <-- aqui guardamos o retorno para mostrar no Text
  String iconeCartao = 'desconhecido';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Premium')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Escolha seu plano\npara continuar usando o sistema.',
                  style: context.cusotomFontes.textBold.copyWith(
                    color: ColorsConstants.appBarColor,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              width: 1000,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PlanoCard(
                    withAlpha: 150,
                    planoTitle: "Plano Básico",
                    planoPrice: "R\$ 85,00/mês",
                    planoDescription1: "-Acesso aos agendamentos.",
                    planoDescription2:
                        "-Confirmação de consultas \npor e-mail.",
                    planoDescription3: "-Atualizações regulares.",
                    onPressed: () {
                      navegarPaymentPlano(plano: "Basico", preco: "85,00");
                    },
                  ),

                  PlanoCard(
                    withAlpha: 200,
                    planoTitle: "Plano Pro",
                    planoPrice: "R\$ 99,90/mês",
                    planoDescription1: "-Tudo do Plano Básico.",
                    planoDescription2: "-Acesso a cadastro de serviços.",
                    planoDescription3: "-Acesso a cadastro de clientes.",
                    planoDescription4: "-Acceso a informações \ndo cliente.",
                    onPressed: () {
                      navegarPaymentPlano(plano: "Pro", preco: "99,90");
                    },
                  ),
                  PlanoCard(
                    withAlpha: 255,
                    planoTitle: "Plano Premium",
                    planoPrice: "R\$ 129,90/mês",
                    planoDescription1: "-Tudo do Plano Pro e Basico.",
                    planoDescription2: "-Acesso a todos os relatórios.",
                    planoDescription3: "-Suporte prioritário.",
                    planoDescription4: "-Acesso a\nfuncionalidades futuras.",
                    onPressed: () {
                      navegarPaymentPlano(plano: "Premium", preco: "129,90");
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(LogosCartoes.visa, width: 40),
                const SizedBox(width: 20),
                Image.asset(LogosCartoes.mastercard, width: 40),
                const SizedBox(width: 20),
                Image.asset(LogosCartoes.pix, width: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<String> gerarToken() async {
    final url = Uri.parse(
      'https://api.mercadopago.com/v1/card_tokens?public_key=TEST-1842e064-25f7-44f4-84c9-58c47ae2dd25',
    );

    final body = {
      "card_number": "4235647728025682",
      "expiration_month": 11,
      "expiration_year": 2030,
      "security_code": "123",
      "cardholder": {
        "name": "APRO",
        "identification": {"type": "CPF", "number": "12345678909"},
      },
    };

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    debugPrint("STATUS: ${response.statusCode}");
    debugPrint("BODY: ${response.body}");

    return response.body;
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

  // TextField(
  //           onChanged: (value) {
  //             String bandeira = identificarBandeira(value);
  //             setState(() {
  //               iconeCartao = bandeira; // usar para mostrar ícone Visa/Master
  //             });
  //           },
  //           decoration: InputDecoration(
  //             hintText: 'Número do cartão',
  //             prefixIcon: iconeCartao == 'visa'
  //                 ? Image.asset(LogosCartoes.visa, width: 40)
  //                 : iconeCartao == 'mastercard'
  //                 ? Image.asset(LogosCartoes.mastercard, width: 40)
  //                 : Icon(Icons.credit_card),
  //           ),
  //         ),

  void navegarPaymentPlano({String? plano, String? preco}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Provider.value(
          value: Provider.of<PlanoController>(context, listen: false),
          child: PlanoPaymentPage(plano: plano, preco: preco),
        ),
      ),
    );
  }
}
