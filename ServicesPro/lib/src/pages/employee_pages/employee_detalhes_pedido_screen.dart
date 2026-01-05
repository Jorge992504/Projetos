import 'package:flutter/material.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/src/widgets/employee/pedidos/employee_detalhes_pedido.dart';

class EmployeeDetalhesPedidoScreen extends StatefulWidget {
  const EmployeeDetalhesPedidoScreen({super.key});

  @override
  State<EmployeeDetalhesPedidoScreen> createState() =>
      _EmployeeDetalhesPedidoScreenState();
}

class _EmployeeDetalhesPedidoScreenState
    extends State<EmployeeDetalhesPedidoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: ColorsConstants.primaryColor),
        ),
        backgroundColor: ColorsConstants.azulColor,
        title: Text(
          'Detalhes do pedido.',
          style: context.cusotomFontes.bold.copyWith(
            color: ColorsConstants.primaryColor,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: EmployeeDetalhesPedido(
            nomeCliente: 'Cliente: Maria Silva',
            label1: '4.8',
            label2: '(150 avaliações)',
            icon: Icons.star,
            color: Colors.yellow,
            telefone: '(11) 98765-4321',
            localizacao: 'Rua das Flores, 123 - São Paulo, SP',
            categoriaServico: 'Eletrica',
            nomeServico: 'Instalação de Luminárias',
            descricaoServico:
                'Instalação de luminárias de LED em toda a residência, garantindo eficiência energética e iluminação adequada.',
            dataPublicacao: 'Publicado em: 15/09/2024',
            onPressedAceitar: () {
              Navigator.of(context).pushNamed(Rotas.chat);
            },
          ),
        ),
      ),
    );
  }
}
