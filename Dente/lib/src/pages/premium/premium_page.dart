import 'dart:convert';
import 'dart:developer';

import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';
import 'package:pointycastle/asymmetric/api.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  String criptoDadosgrafados = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dadosCriptografados();
    });
  }

  @override
  Widget build(BuildContext context) {
    log(criptoDadosgrafados);
    return Scaffold(
      appBar: AppBar(title: const Text('Premium')),
      body: Container(child: Text(criptoDadosgrafados)),
    );
  }

  String criptografia(Map<String, dynamic> dados) {
    String publicKeyBase64 = publicKeyBase();
    final key = enc.Key.fromUtf8(publicKeyBase64);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.ecb));

    final jsonText = jsonEncode(dados);
    final encrypted = encrypter.encrypt(jsonText);

    return encrypted.base64;
  }

  String dadosCriptografados() {
    late final criptografados = criptografia({
      "cardNumber": "5031433215406351",
      "cardholderName": "APRO",
      "expirationMonth": 11,
      "expirationYear": 2023,
      "securityCode": "123",
      "cardholderCpf": "12345678909",
    });
    setState(() {
      criptoDadosgrafados = criptografados;
    });
    return criptografados;
  }

  String publicKeyBase() {
    final publicKeyString = "L7cK4zlQ2Aa1lx93i8Y9Fy3+mOH5kN9TnPbdJw0yPjI=";
    return publicKeyString;
  }
}
