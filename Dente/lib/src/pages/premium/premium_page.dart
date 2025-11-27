import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  String result = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assinar plano Premium')),
      body: Column(
        children: [
          Container(
            child: ElevatedButton(
              onPressed: () {
                // Lógica para assinar o plano Premium
              },
              child: const Text('Assinar Premium'),
            ),
          ),
          Text(result),
        ],
      ),
    );
  }

  Future<void> gerarToken() async {
    final url = Uri.parse(
      "https://api.mercadopago.com/v1/card_tokens?public_key=TEST-1842e064-25f7-44f4-84c9-58c47ae2dd25",
    );

    final body = {
      "card_number": "5031 4332 15406351",
      "expiration_year": "2030",
      "expiration_month": "11",
      "security_code": "123",
      "cardholder": {
        "name": "APRO",
        "identification": {"type": "CPF", "number": "19119119100"},
      },
    };

    final response = await http.post(
      url,
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );

    setState(() {
      result = response.body;
    });

    print("============= TOKEN GERADO =============");
    print(response.body);
  }
}
