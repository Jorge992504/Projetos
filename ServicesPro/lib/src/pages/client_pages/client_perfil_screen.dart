import 'package:flutter/material.dart';

class ClientPerfilScreen extends StatefulWidget {
  const ClientPerfilScreen({super.key});

  @override
  State<ClientPerfilScreen> createState() => _ClientPerfilScreenState();
}

class _ClientPerfilScreenState extends State<ClientPerfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Dados')),
      body: Container(),
    );
  }
}
